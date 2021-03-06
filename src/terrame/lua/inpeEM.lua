-- Global Warming Potential(GWP)(without carbon feedback - source: IPCC AR5 2013 - cap 8, p 713)
local gwpCH4 = 28.0
local gwpN2O = 265.0
local gwpNOx = 0.0
local gwpCO = 0.0
local E = 2.718

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
		if (model.DEGRAD_flag and model.componentDEGRAD.save) then
			inpeEM_saveCells(model, model.componentDEGRAD)
		end

		if (model.VR_flag and model.componentVR.save) then
			inpeEM_saveCells(model, model.componentVR)
		end

		if (model.SV_flag and model.componentSV.save) then
			inpeEM_saveCells(model, model.componentSV)
		end
	end
end

-- Handles with the model initialization.
-- @arg model A INPE-EM Model.
-- @usage --DONTRUN
-- inpeEM_init(model)
function inpeEM_init(model)
	print("\nInitializing Model")
	errorFlag = false

	model.gwpCH4 = gwpCH4
	model.gwpN2O = gwpN2O
	model.gwpNOx = gwpNOx
	model.gwpCO = gwpCO
	model.E = E

	if (model.verbose == nil) then
		model.verbose = false
	end

	if (model.verbose ~= true and model.verbose ~= false) then
		print("Error - Combine model verbose must be true or false!")
		os.exit()
	end

	if (model.componentD == nil) then
		print("\nModel definition error: componentD (disturbance) missing")
		errorFlag = true
	else
		componentD_verify(model)
	end

	if (model.componentB == nil) then
		print("\nModel definition error: componentB (biomass) missing")
		errorFlag = true
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
		errorFlag = true
	end

	if (model.yearInit == nil) then
		print("\nModel definition error: initial year missing")
		errorFlag = true
	end

	if (model.yearFinal == nil) then
		print("\nModel definition error: final year missing")
		errorFlag = true
	end

	if (model.yearInit > model.yearFinal) then
		print("\nModel definition error: initial year starts after the final year")
		errorFlag = true
	end

	if (model.mode == nil) then
		print("\nModel definition error: mode (spatial or non-spatial) missing")
		errorFlag = true
	end

	if (errorFlag) then
		print("\nError - Please, complete your model definition before executing!")
		os.exit()
	end

	errorFlag = false

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
			errorFlag = true
		else
			model.cs = CellularSpace{xdim = 1}
			model.cs.cellarea = model.area
			model.cs_temp = nil
			model.save = false
		end
	end

	if (errorFlag) then
		print("\nError - Please, correct your database or file definition before executing!")
		os.exit()
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
							cell.D_Forest = 0
							cell.B_AGB = model.componentB.averAGB
							cell.B_BGBPercAGB = model.componentB.averBGBPercAGB
							cell.B_LitterPercAGB = model.componentB.averLitterPercAGB
							cell.B_DeadWoodPercAGB= model.componentB.averDeadWoodPercAGB
							cell.B_PercCarbon = model.componentB.averFactorB_C
							cell.B_FactorB_CO2 = model.componentB.averFactorB_CO2
							cell.B_FactorB_CO2Fire = model.componentB.averFactorB_CO2_fire
							cell.B_FactorB_CH4Fire = model.componentB.averFactorB_CH4_fire
							cell.B_FactorB_N2OFire = model.componentB.averFactorB_N2O_fire
							cell.B_FactorB_NOxFire = model.componentB.averFactorB_NOx_fire
							cell.B_FactorB_COFire  = model.componentB.averFactorB_CO_fire
						  end
			   )

	model.componentD.attrArea = model.componentD.name.."_area"
	model.componentD.attrInitialArea = model.componentD.name.."_inita"
	model.componentD.attrForest = model.componentD.name.."_forest"

	model.componentB.attrAGB = model.componentB.name.."_agb"

	model.componentB.attrBGBPercAGB = model.componentB.name.."_perc1"
	model.componentB.attrDeadWoodPercAGB = model.componentB.name.."_perc2"
	model.componentB.attrLitterPercAGB = model.componentB.name.."_perc3"

	model.componentB.attrFactorB_CH4Fire = model.componentB.name.."_fact1"
	model.componentB.attrFactorB_CO2 = model.componentB.name.."_fact2"
	model.componentB.attrFactorB_CO2Fire = model.componentB.name.."_fact3"
	model.componentB.attrFactorB_COFire = model.componentB.name.."_fact4"
	model.componentB.attrFactorB_N2OFire = model.componentB.name.."_fact5"
	model.componentB.attrFactorB_NOxFire = model.componentB.name.."_fact6"

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
	model.D_Result = {}
	model.D_ResultAcc = 0
	model.DEGRAD_Result = {}
	model.SV_Result = {}
	model.VR_Result = {}
	model.NET_Result = {}

	for y = model.yearInit, model.yearFinal, 1 do
		model.D_Result[y] = {
								D_Area = 0,
								D_AreaAcc = 0
							}

		model.DEGRAD_Result[y] = {
									DEGRAD_Area = 0,
									DEGRAD_CO2Emission = 0,
									DEGRAD_CO2Absorption = 0,
									DEGRAD_CO2EmissionAboveDegradLimiar = 0,
									DEGRAD_CO2AbsorptionAboveDegradLimiar = 0,
									DEGRAD_CH4Eq2ndOrderFire = 0,
									DEGRAD_N2OEq2ndOrderFire = 0,
									DEGRAD_COEq2ndOrderFire = 0,
									DEGRAD_NOxEq2ndOrderFire = 0,
									DEGRAD_CO2Balance = 0,
									DEGRAD_CO2Balance2 = 0,
									DEGRAD_AveLoss = 0
								}

		model.SV_Result[y] = {
								SV_AreaTotal = 0,
								SV_AreaCleared = 0,
								SV_CO2Emission = 0,
								SV_CO2Absorption = 0
							 }

		model.VR_Result[y] = {
								VR_CO2_1stOrder = 0,
								VR_CO2_2ndOrder = 0,
								VR_CO2_2ndOrderFire = 0,
								VR_CO2_2ndOrderDecay = 0,
								VR_CH42Eq_2ndOrderFire = 0,
								VR_N2OEq_2ndOrderFire = 0,
								VR_CO2Eq_2ndOrderFire = 0,
								VR_NOxEq_2ndOrderFire = 0
							 }

		model.NET_Result[y] = {
								NET_CO2_1stOrder = 0,
								NET_CO2_2ndOrder = 0
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
		model.D_ResultAcc = cell.D_AreaAcc

		if (model.mode == "non_spatial") then
			cell.D_Forest = model.componentD.initialForest
		end
	end

	if (model.dataTable.Area == nil) then
		print("Error - Input table error: Area data missing")
		os.exit()
	end

	if (#model.dataTable.Area < step) then
		print("Error - Time required exceeds the input table size: Area")
		os.exit()
	end

	cell.D_Area = model.dataTable.Area[step]
	cell.D_AreaAcc = cell.D_AreaAcc + cell.D_Area

	model.D_Result[year].D_Area = model.D_Result[year].D_Area + cell.D_Area
	model.D_ResultAcc = model.D_ResultAcc + cell.D_Area
	model.D_Result[year].D_AreaAcc = model.D_ResultAcc

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
	local flagPrintForest = true

	if (year == model.yearInit) then
		forEachCellPair(model.cs, model.cs_temp, function(cell, cell_temp)
													if (cell_temp[model.componentD.attrInitialArea] ~= nil) then
														cell.D_AreaAcc = cell_temp[model.componentD.attrInitialArea]
														model.D_ResultAcc = model.D_ResultAcc + cell.D_AreaAcc
													else
														print("Error - Historical disturbance information missing: "..model.componentD.attrInitialArea)
														os.exit()
													end

													if (cell_temp[model.componentD.attrForest] ~= nil) then
														cell.D_Forest = cell_temp[model.componentD.attrForest]
														if (flagPrintForest) then
															print(year, "Loading "..model.componentD.attrForest)
															flagPrintForest = false
														end
													else
														print("Error - Initial forest information missing: "..model.componentD.attrForest)
														os.exit()
													end

													if (cell_temp[model.componentB.attrAGB] ~= nil) then
														cell.B_AGB = cell_temp[model.componentB.attrAGB]
														cell.B_CurrentAGB = cell.B_AGB
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

													if (cell_temp[model.componentB.attrFactorB_CO2] ~= nil) then
														cell.B_FactorB_CO2 = cell_temp[model.componentB.attrFactorB_CO2]
													end

													if (cell_temp[model.componentB.attrFactorB_CO2Fire] ~= nil) then
														cell.B_FactorB_CO2Fire = cell_temp[model.componentB.attrFactorB_CO2Fire]
													end

													if (cell_temp[model.componentB.attrFactorB_CH4Fire] ~= nil) then
														cell.B_FactorB_CH4Fire = cell_temp[model.componentB.attrFactorB_CH4Fire]
													end

													if (cell_temp[model.componentB.attrFactorB_N2OFire] ~= nil) then
														cell.B_FactorB_N2OFire = cell_temp[model.componentB.attrFactorB_N2OFire]
													end

													if (cell_temp[model.componentB.attrFactorB_COFire] ~= nil) then
														cell.B_FactorB_COFire = cell_temp[model.componentB.attrFactorB_COFire]
													end

													if (cell_temp[model.componentB.attrFactorB_NOxFire] ~= nil) then
														cell.B_FactorB_NOxFire = cell_temp[model.componentB.attrFactorB_NOxFire]
													end
												end
						)
	end

	--spatio-temporal attributes
	flagPrintAreaPercVegSec = true
	flagPrintHalfLife = true

	forEachCellPair(model.cs, model.cs_temp, function(cell,cell_temp)
												if (cell_temp[model.componentD.attrArea..string.sub(year, string.len(year) - 1)] ~= nil) then
													cell.D_Area = cell_temp[model.componentD.attrArea..string.sub(year, string.len(year) - 1)]
													cell.D_AreaAcc = cell.D_AreaAcc + cell.D_Area
													model.D_Result[year].D_Area = model.D_Result[year].D_Area + cell.D_Area
													model.D_ResultAcc = model.D_ResultAcc + cell.D_Area
													model.D_Result[year].D_AreaAcc =  model.D_ResultAcc
												else
													print("Error - Disturbance information missing: "..model.componentD.attrArea)
													os.exit()
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
		model.NET_Result[y].NET_CO2_2ndOrder = model.VR_Result[y].VR_CO2_2ndOrder + (model.SV_Result[y].SV_CO2Emission - model.SV_Result[y].SV_CO2Absorption) + (model.DEGRAD_Result[y].DEGRAD_CO2Emission - model.DEGRAD_Result[y].DEGRAD_CO2Absorption)
		model.NET_Result[y].NET_CO2_1stOrder = model.VR_Result[y].VR_CO2_1stOrder + (model.SV_Result[y].SV_CO2Emission - model.SV_Result[y].SV_CO2Absorption) + (model.DEGRAD_Result[y].DEGRAD_CO2Emission - model.DEGRAD_Result[y].DEGRAD_CO2Absorption)
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
		name = model.name.."_"..component.name
		if (component.saveCount < 300) then
			print("Saving: "..name)
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
-- component.inpeEM_printReport(model)
function inpeEM_printReport(model)
	file = io.open(MODELDIR..model.name.."_results.txt","w")
	print("\n________________________________________________________________________________________________________")
	file:write("________________________________________________________________________________________________________\n")
	print("\nINPE-EM TOTAL RESULTS")
	file:write("\nINPE-EM TOTAL RESULTS")
	print("________________________________________________________________________________________________________")
	file:write("\n________________________________________________________________________________________________________\n")
	print("\nMODEL NAME = "..model.name)
	file:write("\nMODEL NAME = "..model.name)
	print("MODEL MODE = "..model.mode)
	file:write("\nMODEL MODE = "..model.mode)

	-- Only VR
	if (model.VR_flag == true and model.SV_flag == false and model.DEGRAD_flag == false) then
		print("SUBMODELS => Biomass = "..model.componentB.name..", Deforest = "..model.componentD.name..", Vegetation Removal = "..model.componentVR.name)
		file:write("\nSUBMODELS => Biomass = "..model.componentB.name..", Deforest = "..model.componentD.name..", Vegetation Removal = "..model.componentVR.name)
	end

	-- Only SV
	if (model.VR_flag == false and model.SV_flag == true and model.DEGRAD_flag == false) then
		print("SUBMODELS => Biomass = "..model.componentB.name..", Deforest = "..model.componentD.name..", Secondary Vegetation = "..model.componentSV.name)
		file:write("\nSUBMODELS => Biomass = "..model.componentB.name..", Deforest = "..model.componentD.name..", Secondary Vegetation = "..model.componentSV.name)
	end

	-- Only Degrad
	if (model.VR_flag == false and model.SV_flag == false and model.DEGRAD_flag == true) then
		print("SUBMODELS => Biomass = "..model.componentB.name..", Deforest = "..model.componentD.name..", Degrad = "..model.componentDEGRAD.name)
		file:write("\nSUBMODELS => Biomass = "..model.componentB.name..", Deforest = "..model.componentD.name..", Degrad = "..model.componentDEGRAD.name)
	end

	-- VR + SV
	if (model.VR_flag == true and model.SV_flag == true and model.DEGRAD_flag == false) then
		print("SUBMODELS => Biomass = "..model.componentB.name..", Deforest = "..model.componentD.name..", Vegetation Removal = "..model.componentVR.name..", Secondary Vegetation = "..model.componentSV.name)
		file:write("\nSUBMODELS => Biomass = "..model.componentB.name..", Deforest = "..model.componentD.name..", Vegetation Removal = "..model.componentVR.name..", Secondary Vegetation = "..model.componentSV.name)
	end

	-- VR + Degrad
	if (model.VR_flag == true and model.SV_flag == false and model.DEGRAD_flag == true) then
		print("SUBMODELS => Biomass = "..model.componentB.name..", Deforest = "..model.componentD.name..", Vegetation Removal = "..model.componentVR.name..", Degrad = "..model.componentDEGRAD.name)
		file:write("\nSUBMODELS => Biomass = "..model.componentB.name..", Deforest = "..model.componentD.name..", Vegetation Removal = "..model.componentVR.name..", Degrad = "..model.componentDEGRAD.name)
	end

	-- SV + Degrad
	if (model.VR_flag == false and model.SV_flag == true and model.DEGRAD_flag == true) then
		print("SUBMODELS => Biomass = "..model.componentB.name..", Deforest = "..", Secondary Vegetation = "..model.componentSV.name..", Degrad = "..model.componentDEGRAD.name)
		file:write("\nSUBMODELS => Biomass = "..model.componentB.name..", Deforest = "..model.componentD.name..", Secondary Vegetation = "..model.componentSV.name..", Degrad = "..model.componentDEGRAD.name)
	end

	-- VR + SV + Degrad
	if (model.VR_flag and model.SV_flag and model.DEGRAD_flag) then
		print("SUBMODELS => Biomass = "..model.componentB.name..", Deforest = "..model.componentD.name..", Vegetation Removal = "..model.componentVR.name..", Secondary Vegetation = "..model.componentSV.name..", Degrad = "..model.componentDEGRAD.name)
		file:write("\nSUBMODELS => Biomass = "..model.componentB.name..", Deforest = "..model.componentD.name..", Vegetation Removal = "..model.componentVR.name..", Secondary Vegetation = "..model.componentSV.name..", Degrad = "..model.componentDEGRAD.name)
	end

	print("\n________________________________________________________________________________________________________")
	file:write("\n________________________________________________________________________________________________________\n")

	-- Only VR
	if (model.VR_flag == true and model.SV_flag == false and model.DEGRAD_flag == false) then
		print("\nYear \tD_Area \tD_AreaAcc \t- \t \tVR_CO2_1stOrder \tVR_CO2_2ndOrder \tVR_CO2_2ndOrderFire \tVR_CO2_2ndOrderDecay \tVR_CH42Eq_2ndOrderFire \tVR_N2OEq_2ndOrderFire")
		file:write("\nYear;D_Area;D_AreaAcc;-;VR_CO2_1stOrder;VR_CO2_2ndOrder;VR_CO2_2ndOrderFire;VR_CO2_2ndOrderDecay;VR_CH42Eq_2ndOrderFire;VR_N2OEq_2ndOrderFire")
	end

	-- Only SV
	if (model.VR_flag == false and model.SV_flag == true and model.DEGRAD_flag == false) then
		print("\nYear \tD_Area \tD_AreaAcc \t- \t \tSV_AreaTotal \tSV_AreaCleared \tSV_CO2Emission \tSV_CO2Absorption")
		file:write("\nYear;D_Area;D_AreaAcc;-;SV_AreaTotal;SV_AreaCleared;SV_CO2Emission;SV_CO2Absorption")
	end

	-- Only Degrad
	if (model.VR_flag == false and model.SV_flag == false and model.DEGRAD_flag == true) then
		print("\nYear \tD_Area \tD_AreaAcc \tDEGRAD_Area \t- \t \tDEGRAD_CO2Emission \tDEGRAD_CO2Absorption")
		file:write("\nYear;D_Area;D_AreaAcc;DEGRAD_Area;-;DEGRAD_CO2Emission;DEGRAD_CO2Absorption")
	end

	-- VR + SV
	if (model.VR_flag == true and model.SV_flag == true and model.DEGRAD_flag == false) then
		print("\nYear \tD_Area \tD_AreaAcc \t- \t \tVR_CO2_1stOrder \tVR_CO2_2ndOrder \tVR_CO2_2ndOrderFire \tVR_CO2_2ndOrderDecay \tVR_CH42Eq_2ndOrderFire \tVR_N2OEq_2ndOrderFire \tSV_AreaTotal \tSV_AreaCleared \tSV_CO2Emission \tSV_CO2Absorption \tNET_CO2_2ndOrder")
		file:write("\nYear;D_Area;D_AreaAcc;-;VR_CO2_1stOrder;VR_CO2_2ndOrder;VR_CO2_2ndOrderFire;VR_CO2_2ndOrderDecay;VR_CH42Eq_2ndOrderFire;VR_N2OEq_2ndOrderFire;SV_AreaTotal;SV_AreaCleared;SV_CO2Emission;SV_CO2Absorption;NET_CO2_2ndOrder")
	end

	-- VR + Degrad
	if (model.VR_flag == true and model.SV_flag == false and model.DEGRAD_flag == true) then
		print("\nYear \tD_AreaAcc \tD_Area \tDEGRAD_Area \t-\t \t \tVR_CO2_1stOrder \tVR_CO2_2ndOrder \t-\t \t \tDEGRAD_CO2Emission \tDEGRAD_CO2Absorption".."\t-\t \t \tNET_1st_Order \tNET_2nd_Order")
		file:write("\nYear;D_AreaAcc;D_Area;DEGRAD_Area;-;VR_CO2_1stOrder;VR_CO2_2ndOrder;-;DEGRAD_CO2Emission;DEGRAD_CO2Absorption;-;NET_1st_Order;NET_2nd_Order")
	end

	-- SV + Degrad
	if (model.VR_flag == false and model.SV_flag == true and model.DEGRAD_flag == true) then
		print("\nYear \tD_AreaAcc \tD_Area \tDEGRAD_Area \t-\t \t \tSV_CO2Emission \tSV_CO2Absorption \t-\t \t \tDEGRAD_CO2Emission \tDEGRAD_CO2Absorption \t-\t \t \tNET_1st_Order \tNET_2nd_Order")
		file:write("\nYear;D_AreaAcc;D_Area;DEGRAD_Area;-;SV_CO2Emission;SV_CO2Absorption;-;DEGRAD_CO2Emission;DEGRAD_CO2Absorption;-;NET_1st_Order;NET_2nd_Order")
	end

	-- VR + SV + Degrad
	if (model.VR_flag and model.SV_flag and model.DEGRAD_flag) then
		print("\nYear \tD_AreaAcc \tD_Area \tDEGRAD_Area \t-\t \t \tVR_CO2_1stOrder \tVR_CO2_2ndOrder \tSV_CO2Emission \tSV_CO2Absorption \t-\t \t \tDEGRAD_CO2Emission \tDEGRAD_CO2Absorption \t-\t \t \tNET_1st_Order \tNET_2nd_Order")
		file:write("\nYear;D_AreaAcc;D_Area;DEGRAD_Area;-;VR_CO2_1stOrder;VR_CO2_2ndOrder;SV_CO2Emission;SV_CO2Absorption;-;DEGRAD_CO2Emission;DEGRAD_CO2Absorption;-;NET_1st_Order;NET_2nd_Order")
	end

	io.flush()

	for y = model.yearInit, model.yearFinal, 1 do
		a = math.floor(model.D_Result[y].D_Area)
		b = math.floor(model.D_Result[y].D_AreaAcc)
		b1 = math.floor (model.DEGRAD_Result[y].DEGRAD_Area)

		c = math.floor(model.VR_Result[y].VR_CO2_1stOrder / 1000000)
		d = math.floor(model.VR_Result[y].VR_CO2_2ndOrder / 1000000)
		e = math.floor(model.VR_Result[y].VR_CO2_2ndOrderFire / 1000000)
		f = math.floor(model.VR_Result[y].VR_CO2_2ndOrderDecay / 1000000)
		g = math.floor(model.VR_Result[y].VR_CH42Eq_2ndOrderFire / 1000000)
		h = math.floor(model.VR_Result[y].VR_N2OEq_2ndOrderFire / 1000000)

		k1 = math.floor(model.SV_Result[y].SV_AreaTotal)
		k = math.floor(model.SV_Result[y].SV_AreaCleared)
		l = math.floor(model.SV_Result[y].SV_CO2Emission / 1000000)
		m = math.floor(model.SV_Result[y].SV_CO2Absorption / 1000000) * (-1)

		o = math.floor(model.NET_Result[y].NET_CO2_2ndOrder / 1000000)
		r = math.floor(model.NET_Result[y].NET_CO2_1stOrder / 1000000)

		p = math.floor(model.DEGRAD_Result[y].DEGRAD_CO2Emission / 1000000)
		q = math.floor(model.DEGRAD_Result[y].DEGRAD_CO2Absorption / 1000000) * (-1)
		s = math.floor(model.DEGRAD_Result[y].DEGRAD_CO2EmissionAboveDegradLimiar / 1000000)
		t = math.floor(model.DEGRAD_Result[y].DEGRAD_CO2AbsorptionAboveDegradLimiar / 1000000) * (-1)
		u = math.floor(model.DEGRAD_Result[y].DEGRAD_CO2Balance / 1000000)
		u2 = math.floor(model.DEGRAD_Result[y].DEGRAD_AveLoss * 1000)

		-- Only VR
		if (model.VR_flag == true and model.SV_flag == false and model.DEGRAD_flag == false) then
			print(y, a, b, "-", c, d, e, f, g, h)
			file:write("\n"..y..";"..a..";"..b..";-;"..c..";"..d..";"..e..";"..f..";"..g..";"..h)
		end

		-- Only SV
		if (model.VR_flag == false and model.SV_flag == true and model.DEGRAD_flag == false) then
			print(y, a, b, "-", k1, k,l, m)
			file:write("\n"..y..";"..a..";"..b..";-;"..k1..";"..k..";"..l..";"..m)
		end

		-- Only Degrad
		if (model.VR_flag == false and model.SV_flag == false and model.DEGRAD_flag == true) then
			print(y, a, b, b1, "-", p, q)
			file:write("\n"..y..";"..a..";"..b..";"..b1..";-;"..p..";"..q)
		end

		-- VR + SV
		if (model.VR_flag == true and model.SV_flag == true and model.DEGRAD_flag == false) then
			print(y, a, b, "-", c, d, e, f, g, h, k1, k, l, m, o)
			file:write("\n"..y..";"..a..";"..b..";-;"..c..";"..d..";"..e..";"..f..";"..g..";"..h..";"..k1..";"..k..";"..l..";"..m..";"..o)
		end

		-- VR + Degrad
		if (model.VR_flag == true and model.SV_flag == false and model.DEGRAD_flag == true) then
			print(y, b, a, b1, "-", c, d, "-", p, q, s, t, "-", r, o)
			file:write("\n"..y..";"..b..";"..a..";"..b1..";-;"..c..";"..d..";-;"..p..";"..q..";-;"..r..";"..o)
		end

		-- SV + Degrad
		if (model.VR_flag == false and model.SV_flag == true and model.DEGRAD_flag == true) then
			print(y, b, a, b1, "-", l, m, "-", p, q, s, t, "-", r, o)
			file:write("\n"..y..";"..b..";"..a..";"..b1..";-;"..l..";"..m..";-;"..p..";"..q..";-;"..r..";"..o)
		end

		-- VR + SV + Degrad
		if (model.VR_flag == true and model.SV_flag == true and model.DEGRAD_flag == true) then
			print(y, b, a, b1, "-", c, d, l, m, "-", p, q, s, t, "-", r, o)
			file:write("\n"..y..";"..b..";"..a..";"..b1..";-;"..c..";"..d..";"..l..";"..m..";-;"..p..";"..q..";-;"..r..";"..o)
		end

		io.flush()
	end

	file:write("\n")
	print("\n(OBS: area in hecatares, CO2 in MtonCO2(= 10 12 g), other gases in CO2Eq)")
	print("\n")
	file:write("\n(OBS: area in hecatares, CO2 in MtonCO2(= 10 12 g), other gases in CO2Eq)\n")
	file:close()
end

-- Handles with the verify method of a Disturbance component.
-- @arg model A INPE-EM Model.
-- @usage --DONTRUN
-- component.componentD_verify(model)
function componentD_verify(model)
	if (model.componentD.name == nil) then
		print("Error - Missing Deforestaion parameter: name")
		os.exit()
	end

	if (model.componentB.description == nil) then
		print("Error - Missing Deforestation parameter: description")
		os.exit()
	end

	if (model.componentD.initialArea == nil) then
		print("Error - Missing Deforestaion parameter: initialArea")
		os.exit()
	end

	if (model.componentD.initialForest == nil) then
		print("Error - Missing Deforestaion parameter: initialForest")
		os.exit()
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
		os.exit()
	end

	if (model.componentB.description == nil) then
		print("Error - Missing Biomass parameter: description")
		os.exit()
	end

	if (model.componentB.averBGBPercAGB == nil) then
		print("Error - Missing Biomass parameter: averBGBPercAGB")
		os.exit()
	end

	if (model.componentB.averLitterPercAGB == nil) then
		print("Error - Missing Biomass parameter: averLitterPercAGB")
		os.exit()
	end

	if (model.componentB.averDeadWoodPercAGB == nil) then
		print("Error - Missing Biomass parameter: averDeadWoodPercAGB")
		os.exit()
	end

	if (model.componentB.averFactorB_C == nil) then
		print("Error - Missing B parameter: averFactorB_C")
		os.exit()
	end

	if (model.componentB.averFactorB_CO2 == nil) then
		print("Error - Missing B parameter: averFactorB_CO2")
		os.exit()
	end

	if (model.componentB.averFactorB_CO2_fire == nil) then
		print("Error - Missing B parameter: averFactorB_CO2_fire")
		os.exit()
	end

	if (model.componentB.averFactorB_CH4_fire == nil) then
		print("Error - Missing B parameter: averFactorB_CH4_fire")
		os.exit()
	end

	if (model.componentB.averFactorB_N2O_fire == nil) then
		print("Error - Missing B parameter: averFactorB_N2O_fire")
		os.exit()
	end

	if (model.componentB.averFactorB_NOx_fire == nil) then
		print("Error - Missing B parameter: averFactorB_NOx_fire")
		os.exit()
	end

	if (model.componentB.averFactorB_CO_fire == nil) then
		print("Error - Missing B parameter: averFactorB_CO_fire")
		os.exit()
	end

	return true
end
