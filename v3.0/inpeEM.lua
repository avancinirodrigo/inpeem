dofile(PROJECTDIR.."inpe_EM_3_0\\inpeEM_combine.lua")
dofile(PROJECTDIR.."inpe_EM_3_0\\inpeEM_componentVR.lua")
dofile(PROJECTDIR.."inpe_EM_3_0\\inpeEM_componentSV.lua")
dofile(PROJECTDIR.."inpe_EM_3_0\\inpeEM_componentDEGRAD.lua")

-- Handles with the model execution.
-- @arg model A INPE-EM Model.
-- @usage --DONTRUN
-- inpeEM_execute(model)
function inpeEM_execute(model)  
	if (model.mode == "combine") then  
		inpeEM_executeCombine(model, model.model_ns, model.model_s) 
	else   
		inpeEM_init(model)
	
		for year = model.yearInit, model.yearFinal, 1 do
			inpeEM_load(year, model)

			if (model.DEGRAD_flag) then
				componentDEGRAD_execute(year, model)
			end				

			if (model.SV_flag) then
				componentSV_execute(year, model)
			end
			
			if (model.VR_flag) then
				componentVR_execute(year, model)
			end
			
			inpeEM_computeNetEmission(year, model)
		end  
	end

	model.run = true
	
	if (model.verbose == true) then
		inpeEM_printReport(model) 
	end

	if (model.mode == "spatial") then
		if (model.DEGRAD_flag) then
			inpeEM_saveCells(model, model.componentDEGRAD)
		end	
		
		if (model.VR_flag) then
			inpeEM_saveCells(model, model.componentVR)
		end
		
		if (model.SV_flag) then
			inpeEM_saveCells(model, model.componentSV)
		end	
	end
end
 
-- Handles with the model initialization.
-- @arg model A INPE-EM Model.
-- @usage --DONTRUN
-- inpeEM_init(model)
function inpeEM_init(model)
	error_flag = false

	if (model.verbose == nil) then
		model.verbose = false 
	end

	if (model.verbose ~= true and model.verbose ~= false) then
		error("Combine model verbose must be true or false!", 2)
	end

	if (model.componentD == nil) then
		print("\nModel definition error: componentD (disturbance) missing")
		error_flag = true
	else 
		componentD_verify(model)
	end

	if (model.componentB == nil) then
		print("\nModel definition error: componentB (biomass) missing")
		error_flag = true
	else 
		componentB_verify(model)
	end
	
	model.DEGRAD_flag = true
	if (model.componentDEGRAD == nil) then
		model.DEGRAD_flag = false
		componentDEGRAD_createNullComponent(model)
	else 
		componentDEGRAD_verify(model) 
	end	

	model.VR_flag = true
	if (model.componentVR == nil) then
		model.VR_flag = false
		componentVR_createNullComponent(model)
	else 
		componentVR_verify(model) 
	end

	model.SV_flag = true
	if (model.componentSV == nil) then
		model.SV_flag = false
		componentSV_createNullComponent(model)
	else 
		componentSV_verify(model) 
	end
	
	if ((model.SV_flag == false and model.VR_flag == false) and model.DEGRAD_flag == false) then
		print("\nModel definition error: componentVR AND/OR componentSV AND/OR componentDEGRAD must be defined")
		error_flag = true
	end

	if (model.yearInit == nil) then
		print("\nModel definition error: initial year missing")
		error_flag = true
	end	 

	if (model.yearFinal == nil) then
		print("\nModel definition error: initial year missing")
		error_flag = true
	end	 

	if (model.yearInit > model.yearFinal) then
		print("\nModel definition error: initial year missing")
		error_flag = true
	end

	if (model.mode == nil) then
		print("\nModel definition error: mode (spatial or non-spatial) missing")
		error_flag = true
	end	 

	if (error_flag) then
		error("\nPlease, complete your model definition before executing!", 2)
	end

	error_flag = false

	if (model.mode == "spatial") then
		model.cs = CellularSpace {   
									project = model.project,
									layer = model.layer,
									cellarea = model.cellarea
								 } 

		model.cs_temp = CellularSpace { 
										project = model.project,
										layer = model.layer,
										cellarea = model.cellarea
									  }
	end

	if (model.mode == "non_spatial") then
		if (model.dataTable == nil) then
			print("\nModel definition error: dataTable missing")
			error_flag = true
		else
			model.cs = CellularSpace { 
										xdim = 1,
										ydim = 1
								     }
			model.cs.cellarea = model.area
			model.cs_temp = nil
			model.save = false
		end
	end

	if (error_flag) then
		error("\nPlease, correct your database or file definition before executing!") 
	end

	inpeEM_initResults(model)
	inpeEM_initComponents(model)
end

-- Handles with the components initialization.
-- @arg model A INPE-EM Model.
-- @usage --DONTRUN
-- inpeEM_initComponents(model)
function inpeEM_initComponents(model)
	forEachCell(model.cs, function(cell)
							cell.D_Area = 0
							cell.D_AreaAcc = 0
							cell.B_AGB = model.componentB.averAGB
							cell.B_BGBPercAGB = model.componentB.averBGBPercAGB
							cell.B_LitterPercAGB = model.componentB.averLitterPercAGB
							cell.B_DeadWoodPercAGB = model.componentB.averDeadWoodPercAGB
							cell.B_PercCarbon = model.componentB.averFactorB_C
							cell.B_FactorB_CO2 = model.componentB.averFactorB_CO2
							cell.B_FactorB_CO2_fire = model.componentB.averFactorB_CO2_fire
							cell.B_FactorB_CH4_fire = model.componentB.averFactorB_CH4_fire
							cell.B_FactorB_N2O_fire = model.componentB.averFactorB_N2O_fire
							cell.B_FactorB_NOx_fire = model.componentB.averFactorB_NOx_fire
							cell.B_FactorB_CO_fire  = model.componentB.averFactorB_CO_fire
						  end
			   )

	model.componentD.attrArea = model.componentD.name.."_area"
	model.componentD.attrInitialArea = model.componentD.name.."_inita"
	
	model.componentB.attrAGB = model.componentB.name.."_agb"
	
	model.componentB.attrBGBPercAGB = model.componentB.name.."_perc1"
	model.componentB.attrDeadWoodPercAGB = model.componentB.name.."_perc2"
	model.componentB.attrLitterPercAGB = model.componentB.name.."_perc3"
	
	model.componentB.attrFactorB_CH4_fire = model.componentB.name.."_fact1"
	model.componentB.attrFactorB_CO2 = model.componentB.name.."_fact2"
	model.componentB.attrFactorB_CO2_fire = model.componentB.name.."_fact3"
	model.componentB.attrFactorB_CO_fire = model.componentB.name.."_fact4"
	model.componentB.attrFactorB_N2O_fire = model.componentB.name.."_fact5"
	model.componentB.attrFactorB_NOx_fire = model.componentB.name.."_fact6"
	
	model.componentB.attrPercCarbon = model.componentB.name.."_perccarbon"

	if (model.DEGRAD_flag) then
		componentDEGRAD_init(model)
	end
	
	if (model.VR_flag) then
		componentVR_init(model)
	end
	
	if (model.SV_flag) then
		componentSV_init(model)
	end
end
 
-- Handles with the model results initialize, creating the output attributes and the set default value.
-- @arg model A INPE-EM Model.
-- @usage --DONTRUN
-- inpeEM_initResults(model)
function inpeEM_initResults(model)
	model.D_result = {}
	model.D_result_acc = 0
	model.DEGRAD_result = {}
	model.SV_result = {}
	model.VR_result = {}
	model.net_result = {}

	for y = model.yearInit, model.yearFinal, 1 do
		model.D_result[y] = { 
								D_Area = 0,
								D_AreaAcc = 0
							}
							
		model.DEGRAD_result[y] = { 
									DEGRAD_Area = 0,
									DEGRAD_CO2_emission = 0,
									DEGRAD_CO2_absorption = 0,
									DEGRAD_CO2_emission_aboveDegradLimiar = 0,
									DEGRAD_CO2_absorption_aboveDegradLimiar = 0,
									DEGRAD_CO2_BALANCE = 0, 
									DEGRAD_CO2_BALANCE2 = 0,
									DEGRAD_AveLoss = 0
								}

		model.SV_result[y] = {  
								SV_area_total = 0,
								SV_area_cleared = 0,
								SV_CO2_emission = 0,
								SV_CO2_absorption = 0
							 }

		model.VR_result[y] = {  
								VR_CO2_1stOrder = 0,
								VR_CO2_2ndOrder = 0,
								VR_CO2_2ndOrder_fire = 0,
								VR_CO2_2ndOrder_decay = 0,
								VR_CH4_CO2Eq_2ndOrder_fire = 0,
								VR_N2O_CO2Eq_2ndOrder_fire = 0,
								VR_CO_CO2Eq_2ndOrder_fire = 0,
								VR_NOx_CO2Eq_2ndOrder_fire = 0
							 }

		model.net_result[y] = {	
								net_CO2_1stOrder = 0,
								net_CO2_2ndOrder = 0
							  }
	end	
end

-- Handles with selection of the load method based on the model type (spatial or non-spatial).
-- @arg year A year to compute the balance.
-- @arg model A INPE-EM Model.
-- @usage --DONTRUN
-- inpeEM_load(year, model)
function inpeEM_load(year, model)
	if (model.mode == "spatial") then
		inpeEM_loadFromDB(year, model)
	else
		inpeEM_loadFromTable(year, model)
	end
end        
 
-- Handles with the load of the attributes from a table (used with non-spatial model).
-- @arg year A year to compute the balance.
-- @arg model A INPE-EM Model.
-- @usage --DONTRUN
-- inpeEM_loadFromTable(year, model)
function inpeEM_loadFromTable(year, model)
	local step = year - model.yearInit + 1
	local cell = model.cs.cells[1]

	if (year == model.yearInit) then
		cell.D_AreaAcc = model.componentD.initialArea
		model.D_result_acc = cell.D_AreaAcc 
	end

	if (model.dataTable.Area == nil) then
		error("Input table error: Area data missing", 1) 
	end

	if (#model.dataTable.Area < step) then
		error("Time required exceeds the input table size: Area", 1) 
	end

	cell.D_Area = model.dataTable.Area[step]
	cell.D_AreaAcc = cell.D_AreaAcc + cell.D_Area

	model.D_result[year].D_Area = model.D_result[year].D_Area + cell.D_Area
	model.D_result_acc = model.D_result_acc + cell.D_Area
	model.D_result[year].D_AreaAcc = model.D_result_acc

	if (model.DEGRAD_flag) then
		componentDEGRAD_loadFromTable(model, cell, step) 
	end	
	
	if (model.VR_flag) then
		componentVR_loadFromTable(model, cell, step) 
	end
	
	if (model.SV_flag) then
		componentSV_loadFromTable(model, cell, step) 
	end
end 
 
-- Handles with the load of the attributes from the database or shape.
-- @arg year A year to compute the balance.
-- @arg model A INPE-EM Model.
-- @usage --DONTRUN
-- inpeEM_loadFromDB(year, model) 
function inpeEM_loadFromDB(year, model) 
	-- initial year only
	local flagPrintAGB = true
	local flagPrintBGBPercAGB = true
	local flagPrintLitterPercAGB = true
	local flagPrintDeadWoodPercAGB = true

	if (year == model.yearInit) then
		forEachCellPair(model.cs, model.cs_temp, function(cell, cell_temp)
													if (cell_temp[model.componentD.attrInitialArea] ~= nil) then
														cell.D_AreaAcc = cell_temp[model.componentD.attrInitialArea]
														model.D_result_acc = model.D_result_acc + cell.D_AreaAcc 
													else
														error("Historical disturbance information missing: "..model.componentD.attrInitialArea, 1)	
													end

													if (cell_temp[model.componentB.attrAGB] ~= nil) then
														cell.B_AGB = cell_temp[model.componentB.attrAGB]
														cell.B_ActualAGB = cell.B_AGB
														if (flagPrintAGB) then
															print(year, "Loading "..model.componentB.attrAGB)
															flagPrintAGB = false 
														end
													end 

													if (cell_temp[model.componentB.attrBGBPercAGB] ~= nil) then
														cell.B_BGBPercAGB = cell_temp[model.componentB.attrBGBPercAGB]
														if (flagPrintBGBPercAGB) then
															print(year, "Loading "..model.componentB.attrBGBPercAGB)
															flagPrintBGBPercAGB = false 
														end
													end 

													if (cell_temp[model.componentB.attrLitterPercAGB] ~= nil) then
														cell.B_LitterPercAGB = cell_temp[model.componentB.attrLitterPercAGB]
														if (flagPrintLitterPercAGB) then
															print(year, "Loading "..model.componentB.attrLitterPercAGB)
															flagPrintLitterPercAGB = false 
														end
													end 

													if (cell_temp[model.componentB.attrDeadWoodPercAGB] ~= nil) then
														cell.B_DeadWoodPercAGB = cell_temp[model.componentB.attrDeadWoodPercAGB]
														if (flagPrintDeadWoodPercAGB) then
															print(year, "Loading "..model.componentB.attrDeadWoodPercAGB)
															flagPrintDeadWoodPercAGB = false 
														end
													end 

													if (cell_temp[model.componentB.attrPercCarbon] ~= nil) then --XXXXXXXXXXXXXXXXXXXXXXXX
														cell.B_PercCarbon = cell_temp[model.componentB.attrPercCarbon]
													end 

													if (cell_temp[model.componentB.attrFactorB_CO2] ~= nil) then
														cell.B_FactorB_CO2 = cell_temp[model.componentB.attrFactorB_CO2]
													end 

													if (cell_temp[model.componentB.attrFactorB_CO2_fire] ~= nil) then
														cell.B_FactorB_CO2_fire = cell_temp[model.componentB.attrFactorB_CO2_fire]
													end 

													if (cell_temp[model.componentB.attrFactorB_CH4_fire] ~= nil) then
														cell.B_FactorB_CH4_fire = cell_temp[model.componentB.attrFactorB_CH4_fire]
													end 

													if (cell_temp[model.componentB.attrFactorB_N2O_fire] ~= nil) then
														cell.B_FactorB_N2O_fire = cell_temp[model.componentB.attrFactorB_N2O_fire]
													end 

													if (cell_temp[model.componentB.attrFactorB_CO_fire] ~= nil) then
														cell.B_FactorB_CO_fire = cell_temp[model.componentB.attrFactorB_CO_fire]
													end 

													if (cell_temp[model.componentB.attrFactorB_NOx_fire] ~= nil) then
														cell.B_FactorB_NOx_fire = cell_temp[model.componentB.attrFactorB_NOx_fire]
													end 
												end
						)
	end	

	--spatio-temporal attributes
	flagPrintAreaPercVegSec = true
	flagPrintHalfLife = true

	forEachCellPair(model.cs, model.cs_temp, function(cell,cell_temp)
												if (cell_temp[model.componentD.attrArea..year] ~= nil) then
													cell.D_Area = cell_temp[model.componentD.attrArea..year]
													cell.D_AreaAcc = cell.D_AreaAcc + cell.D_Area
													model.D_result[year].D_Area = model.D_result[year].D_Area + cell.D_Area
													model.D_result_acc = model.D_result_acc + cell.D_Area
													model.D_result[year].D_AreaAcc =  model.D_result_acc
												else
													error("Disturbance information missing: "..model.componentD.attrArea, 1)
												end

												if (model.DEGRAD_flag) then
													componentDEGRAD_loadFromDB(model, cell_temp, cell, year)
												end
												
												if (model.VR_flag) then
													componentVR_loadFromDB(model, cell_temp, cell, year) 
												end
												
												if (model.SV_flag) then
													componentSV_loadFromDB(model, cell_temp, cell, year) 
												end
											 end
					)
end -- function
  
-- Handles with the carbon balance (absortion less emission).
-- @arg year A year to compute the balance.
-- @arg model A INPE-EM Model.
-- @usage --DONTRUN
-- inpeEM_inpeEM_computeNetEmission(year, model)
function inpeEM_computeNetEmission(year, model)
	if (model.verbose) then
		print(year, "Executing NET - mode:"..model.mode) 
	end

	for y = model.yearInit, model.yearFinal, 1 do
		model.net_result[y].net_CO2_2ndOrder = model.VR_result[y].VR_CO2_2ndOrder + (model.SV_result[y].SV_CO2_emission - model.SV_result[y].SV_CO2_absorption) + (model.DEGRAD_result[y].DEGRAD_CO2_emission - model.DEGRAD_result[y].DEGRAD_CO2_absorption)
		model.net_result[y].net_CO2_1stOrder = model.VR_result[y].VR_CO2_1stOrder + (model.SV_result[y].SV_CO2_emission - model.SV_result[y].SV_CO2_absorption) + (model.DEGRAD_result[y].DEGRAD_CO2_emission - model.DEGRAD_result[y].DEGRAD_CO2_absorption)
	end
end

-- Handles to save the attributes into database or shape file, according to input.
-- @arg model A INPE-EM Model.
-- @arg component A INPE-EM component.
-- @usage --DONTRUN
-- inpeEM_saveCells(model, model.componentVR)
function inpeEM_saveCells(model, component) 
	local name = ""
	if (component.saveCount > 0)  then
		name = model.inputThemeName.."_"..component.name.."_"..model.yearInit.."_"
		if (component.saveCount < 300) then 
			model.cs:save(name, component.saveAttrs) 
		else 
			print("Sorry, number of attributes > 300, impossible to save, run with a shorter time period")
			io.flush()
		end
	end
end

-- Handles with the screen print of the simulation results.
-- @arg model A INPE-EM Model.
-- @usage --DONTRUN
-- component.componentD_verify(model)
function inpeEM_printReport(model)
	print("\n_____________________________________________________________________________________________________________________________________")
	print("\nINPE-EM TOTAL RESULTS")
	print("\n_____________________________________________________________________________________________________________________________________")
	print("MODEL NAME = "..model.name)
	print("MODEL MODE = "..model.mode)
	if (model.VR_flag == true and model.SV_flag == false) then 
		print("SUBMODELS \tB = "..model.componentB.name.."\tD = "..model.componentD.name.."\tVR = "..model.componentVR.name)	
	end      

	if (model.SV_flag == true and model.VR_flag == false) then 
		print("SUBMODELS \tB = "..model.componentB.name.."\tD = "..model.componentD.name.."\tSV = "..model.componentSV.name)	
	end

	if (model.SV_flag == true and model.VR_flag == true and model.DEGRAD_flag == false) then  
		print("SUBMODELS \tB = "..model.componentB.name.."\tD = "..model.componentD.name.."\tVR = "..model.componentVR.name.."\tSV = "..model.componentSV.name)
	end	
	
	if (model.SV_flag and model.VR_flag and model.DEGRAD_flag) then  
		print("SUBMODELS \tB = "..model.componentB.name.."\tD = "..model.componentD.name.."\tVR = "..model.componentVR.name.."\tSV = "..model.componentSV.name.."\tDegrad = "..model.componentDEGRAD.name)
	end
	print("_____________________________________________________________________________________________________________________________________")
	
	if (model.VR_flag == true and model.SV_flag == false) then 
		print("\nD_Area \tD_AreaAcc \t- \t \tVR_CO2_1stOrder \tVR_CO2_2ndOrder \tVR_CO2_2ndOrder_fire \tVR_CO2_2ndOrder_decay \tVR_NOx_CO2Eq_2ndOrder_fire \tVR_N2O_CO2Eq_2ndOrder_fire")
	end      

	if (model.SV_flag == true and model.VR_flag == false) then 
		print("\nD_Area \tD_AreaAcc \t- \t \tSV_area_total \tSV_area_cleared \tSV_CO2_emission \tSV_CO2_absorption")
	end

	if (model.SV_flag == true and model.VR_flag == true and model.DEGRAD_flag == false) then  
		print("\nD_Area \tD_AreaAcc \t- \t \tVR_CO2_1stOrder \tVR_CO2_2ndOrder \tVR_CO2_2ndOrder_fire \tVR_CO2_2ndOrder_decay \tVR_CH4_CO2Eq_2ndOrder_fire \tVR_N2O_CO2Eq_2ndOrder_fire".. 
			  "\tSV_area_total \tSV_area_cleared \tSV_CO2_emission \tSV_CO2_absorption \tnet_CO2_2ndOrder")
	end
	
	if (model.SV_flag and model.VR_flag and model.DEGRAD_flag) then  
		print ("\nD_AreaAcc \tD_Area \tDEGRAD_Area \t-\t \t \tVR_CO2_1stOrder \tVR_CO2_2ndOrder \tSV_CO2_emission \tSV_CO2_absorption \t-\t \t \tDEGRAD_CO2_emission \tDEGRAD_CO2_absorption"..
			   "\tDEGRAD_CO2_emission_aboveLimiar \tDEGRAD_CO2_absorption_aboveLimiar \tPercentage Loss \t-\t \t \tNET_1st_Order \tNET_2nd_Order")
	end

	io.flush()
	
	for y = model.yearInit, model.yearFinal, 1 do
		a = math.floor(model.D_result[y].D_Area)        
		b = math.floor(model.D_result[y].D_AreaAcc)   
		b1 = math.floor (model.DEGRAD_result[y].DEGRAD_Area)
  		
		c = math.floor(model.VR_result[y].VR_CO2_1stOrder / 1000000)
		d = math.floor(model.VR_result[y].VR_CO2_2ndOrder / 1000000)
		e = math.floor(model.VR_result[y].VR_CO2_2ndOrder_fire / 1000000)
		f = math.floor(model.VR_result[y].VR_CO2_2ndOrder_decay / 1000000)
		g = math.floor(model.VR_result[y].VR_CH4_CO2Eq_2ndOrder_fire / 1000000)
		h = math.floor(model.VR_result[y].VR_N2O_CO2Eq_2ndOrder_fire / 1000000)
		
		k1 = math.floor(model.SV_result[y].SV_area_total)  
		k = math.floor(model.SV_result[y].SV_area_cleared) 
		l = math.floor(model.SV_result[y].SV_CO2_emission / 1000000)
		m = math.floor((-1) * model.SV_result[y].SV_CO2_absorption / 1000000)
		
		o = math.floor(model.net_result[y].net_CO2_2ndOrder / 1000000)
		r = math.floor(model.net_result[y].net_CO2_1stOrder / 1000000)

		p = math.floor(model.DEGRAD_result[y].DEGRAD_CO2_emission / 1000000) 
		q = math.floor(model.DEGRAD_result[y].DEGRAD_CO2_absorption / 1000000) * (-1)
		s = math.floor(model.DEGRAD_result[y].DEGRAD_CO2_emission_aboveDegradLimiar / 1000000)
		t = math.floor(model.DEGRAD_result[y].DEGRAD_CO2_absorption_aboveDegradLimiar / 1000000) * (-1)
		u = math.floor(model.DEGRAD_result[y].DEGRAD_CO2_BALANCE / 1000000)
		u2 = math.floor(model.DEGRAD_result[y].DEGRAD_AveLoss * 1000)		

		if (model.VR_flag == true and model.SV_flag == false) then
			print(y, a, b, "-", y, c, d, e, f, g, h)  
		end
		
		if (model.VR_flag == false and model.SV_flag == true) then
			print(y, a, b, "-", y, k1, k,l, m)  
		end
		
		if (model.SV_flag == true and model.VR_flag == true and model.DEGRAD_flag == false) then
			print(y, a, b, "-", y, c, d, e, f, g, h, k1, k, l, m, o)  
		end  
		
		if (model.SV_flag and model.VR_flag and model.DEGRAD_flag) then
			print(y, b, a, b1, "-", y, c, d, l, m, "-", y, p, q, s, t, u2, "-", r, o)  
		end		
		
		io.flush()
	end
	
	print("\n(OBS: area in hecatares, CO2 in MtonCO2(= 10 12 g), other gases in CO2Eq)")
end

-- Handles with the verify method of a Disturbance component.
-- @arg model A INPE-EM Model.
-- @usage --DONTRUN
-- component.componentD_verify(model)
function componentD_verify(model)
	if (model.componentD.name == nil) then
		error("Missing D parameter: name", 1)
	end

	if (model.componentB.description == nil) then 
		error("Missing D parameter: description", 1) 
	end

	if (model.componentD.initialArea == nil) then 
		error("Missing D parameter: initialArea", 1) 
	end

	return true
end	  	 

-- Handles with the verify method of a Biomass component.
-- @arg model A INPE-EM Model.
-- @usage --DONTRUN
-- component.componentB_verify(model)
function componentB_verify(model)
	if (model.componentB.name == nil) then
		error("Missing B parameter: name", 1) 
	end

	if (model.componentB.description == nil) then
		error("Missing B parameter: description", 1) 
	end

	if (model.componentB.averBGBPercAGB == nil) then
		error("Missing B parameter: averBGBPercAGB", 1) 
	end

	if (model.componentB.averLitterPercAGB == nil) then
		error("Missing B parameter: averLitterPercAGB", 1) 
	end

	if (model.componentB.averDeadWoodPercAGB == nil) then
		error("Missing B parameter: averDeadWoodPercAGB", 1) 
	end

	if (model.componentB.averFactorB_C == nil) then
		error("Missing B parameter: averFactorB_C", 1) 
	end

	if (model.componentB.averFactorB_CO2 == nil) then
		error("Missing B parameter: averFactorB_CO2", 1) 
	end

	if (model.componentB.averFactorB_CO2_fire == nil) then
		error("Missing B parameter: averFactorB_CO2_fire", 1) 
	end

	if (model.componentB.averFactorB_CH4_fire == nil) then
		error("Missing B parameter: averFactorB_CH4_fire", 1) 
	end

	if (model.componentB.averFactorB_N2O_fire == nil) then
		error("Missing B parameter: averFactorB_N2O_fire", 1) 
	end

	if (model.componentB.averFactorB_NOx_fire == nil) then
		error("Missing B parameter: averFactorB_NOx_fire", 1) 
	end

	if (model.componentB.averFactorB_CO_fire == nil) then
		error("Missing B parameter: averFactorB_CO_fire", 1) 
	end

	return true
end
