#pragma once
#include "Function.h"

namespace INPEEM {

	using namespace System;
	using namespace System::ComponentModel;
	using namespace System::Collections;
	using namespace System::Windows::Forms;
	using namespace System::Data;
	using namespace System::Drawing;

	/// <summary>
	/// Summary for ComponentSecondaryVegetation
	/// </summary>
	public ref class ComponentSecondaryVegetation : public System::Windows::Forms::Form
	{
	public:
		String^ gSDataMissing = "";
		String^ gSDataMissingTitle = "";

	public:
		cReturn^ lReturn;
		ComponentSecondaryVegetation(cReturn^ pSecondaryVegetation)
		{
			InitializeComponent();
			lReturn = pSecondaryVegetation;
			//
			//TODO: Add the constructor code here
			//
		}

	protected:
		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		~ComponentSecondaryVegetation()
		{
			if (components)
			{
				delete components;
			}
		}
	


	private: System::Windows::Forms::TextBox^  tAverInitialAbandonmentCycle;
	private: System::Windows::Forms::Label^  lAverInitialAbandonmentCycle;
	private: System::Windows::Forms::TextBox^  tAverAgriculturalUseCycle;
	private: System::Windows::Forms::Label^  lAverAgriculturalUseCycle;
	private: System::Windows::Forms::TextBox^  tAverRecoveryPeriod2;
	private: System::Windows::Forms::Label^  lAverRecoveryPeriod2;
	private: System::Windows::Forms::TextBox^  tAverRecoveryPeriod1;
	private: System::Windows::Forms::Label^  lAverRecoveryPeriod1;
	private: System::Windows::Forms::TextBox^  tAverRecoveryPeriod2Perc;
	private: System::Windows::Forms::Label^  lAverRecoveryPeriod2Perc;
	private: System::Windows::Forms::TextBox^  tDescription;
	private: System::Windows::Forms::TextBox^  tAverRecoveryPeriod1Perc;
	private: System::Windows::Forms::TextBox^  tAverAreaAccPercVegSec;
	private: System::Windows::Forms::TextBox^  tAverAreaPercVegSec;
	private: System::Windows::Forms::Label^  lAverRecoveryPeriod1Perc;
	private: System::Windows::Forms::TextBox^  taverHalfLife;
	private: System::Windows::Forms::Label^  lAverAreaAccPercVegSec;
	private: System::Windows::Forms::TextBox^  tName;
	private: System::Windows::Forms::Label^  laverAreaPercVegSec;
	private: System::Windows::Forms::Label^  lDescription;
	private: System::Windows::Forms::Label^  lAverHalfLife;
	private: System::Windows::Forms::Label^  lName;
	private: System::Windows::Forms::Button^  bSalvar;
	private: System::Windows::Forms::PictureBox^  pbLogo1;
	private: System::Windows::Forms::CheckBox^  cbSave;

	private:
		/// <summary>
		/// Required designer variable.
		/// </summary>
		System::ComponentModel::Container ^components;

#pragma region Windows Form Designer generated code
		/// <summary>
		/// Required method for Designer support - do not modify
		/// the contents of this method with the code editor.
		/// </summary>
		void InitializeComponent(void)
		{
			System::ComponentModel::ComponentResourceManager^  resources = (gcnew System::ComponentModel::ComponentResourceManager(ComponentSecondaryVegetation::typeid));
			this->tAverInitialAbandonmentCycle = (gcnew System::Windows::Forms::TextBox());
			this->lAverInitialAbandonmentCycle = (gcnew System::Windows::Forms::Label());
			this->tAverAgriculturalUseCycle = (gcnew System::Windows::Forms::TextBox());
			this->lAverAgriculturalUseCycle = (gcnew System::Windows::Forms::Label());
			this->tAverRecoveryPeriod2 = (gcnew System::Windows::Forms::TextBox());
			this->lAverRecoveryPeriod2 = (gcnew System::Windows::Forms::Label());
			this->tAverRecoveryPeriod1 = (gcnew System::Windows::Forms::TextBox());
			this->lAverRecoveryPeriod1 = (gcnew System::Windows::Forms::Label());
			this->tAverRecoveryPeriod2Perc = (gcnew System::Windows::Forms::TextBox());
			this->lAverRecoveryPeriod2Perc = (gcnew System::Windows::Forms::Label());
			this->tDescription = (gcnew System::Windows::Forms::TextBox());
			this->tAverRecoveryPeriod1Perc = (gcnew System::Windows::Forms::TextBox());
			this->tAverAreaAccPercVegSec = (gcnew System::Windows::Forms::TextBox());
			this->tAverAreaPercVegSec = (gcnew System::Windows::Forms::TextBox());
			this->lAverRecoveryPeriod1Perc = (gcnew System::Windows::Forms::Label());
			this->taverHalfLife = (gcnew System::Windows::Forms::TextBox());
			this->lAverAreaAccPercVegSec = (gcnew System::Windows::Forms::Label());
			this->tName = (gcnew System::Windows::Forms::TextBox());
			this->laverAreaPercVegSec = (gcnew System::Windows::Forms::Label());
			this->lDescription = (gcnew System::Windows::Forms::Label());
			this->lAverHalfLife = (gcnew System::Windows::Forms::Label());
			this->lName = (gcnew System::Windows::Forms::Label());
			this->bSalvar = (gcnew System::Windows::Forms::Button());
			this->pbLogo1 = (gcnew System::Windows::Forms::PictureBox());
			this->cbSave = (gcnew System::Windows::Forms::CheckBox());
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pbLogo1))->BeginInit();
			this->SuspendLayout();
			// 
			// tAverInitialAbandonmentCycle
			// 
			this->tAverInitialAbandonmentCycle->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tAverInitialAbandonmentCycle->Location = System::Drawing::Point(272, 539);
			this->tAverInitialAbandonmentCycle->Name = L"tAverInitialAbandonmentCycle";
			this->tAverInitialAbandonmentCycle->Size = System::Drawing::Size(89, 20);
			this->tAverInitialAbandonmentCycle->TabIndex = 153;
			this->tAverInitialAbandonmentCycle->Text = L"3";
			this->tAverInitialAbandonmentCycle->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->tAverInitialAbandonmentCycle->Enter += gcnew System::EventHandler(this, &ComponentSecondaryVegetation::textBox_Enter);
			// 
			// lAverInitialAbandonmentCycle
			// 
			this->lAverInitialAbandonmentCycle->AutoSize = true;
			this->lAverInitialAbandonmentCycle->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lAverInitialAbandonmentCycle->Location = System::Drawing::Point(21, 539);
			this->lAverInitialAbandonmentCycle->Name = L"lAverInitialAbandonmentCycle";
			this->lAverInitialAbandonmentCycle->Size = System::Drawing::Size(245, 23);
			this->lAverInitialAbandonmentCycle->TabIndex = 163;
			this->lAverInitialAbandonmentCycle->Text = L"averInitialAbandonmentCycle";
			this->lAverInitialAbandonmentCycle->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// tAverAgriculturalUseCycle
			// 
			this->tAverAgriculturalUseCycle->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tAverAgriculturalUseCycle->Location = System::Drawing::Point(272, 503);
			this->tAverAgriculturalUseCycle->Name = L"tAverAgriculturalUseCycle";
			this->tAverAgriculturalUseCycle->Size = System::Drawing::Size(89, 20);
			this->tAverAgriculturalUseCycle->TabIndex = 152;
			this->tAverAgriculturalUseCycle->Text = L"2";
			this->tAverAgriculturalUseCycle->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->tAverAgriculturalUseCycle->Enter += gcnew System::EventHandler(this, &ComponentSecondaryVegetation::textBox_Enter);
			// 
			// lAverAgriculturalUseCycle
			// 
			this->lAverAgriculturalUseCycle->AutoSize = true;
			this->lAverAgriculturalUseCycle->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lAverAgriculturalUseCycle->Location = System::Drawing::Point(55, 503);
			this->lAverAgriculturalUseCycle->Name = L"lAverAgriculturalUseCycle";
			this->lAverAgriculturalUseCycle->Size = System::Drawing::Size(211, 23);
			this->lAverAgriculturalUseCycle->TabIndex = 161;
			this->lAverAgriculturalUseCycle->Text = L"averAgriculturalUseCycle";
			this->lAverAgriculturalUseCycle->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// tAverRecoveryPeriod2
			// 
			this->tAverRecoveryPeriod2->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tAverRecoveryPeriod2->Location = System::Drawing::Point(272, 467);
			this->tAverRecoveryPeriod2->Name = L"tAverRecoveryPeriod2";
			this->tAverRecoveryPeriod2->Size = System::Drawing::Size(89, 20);
			this->tAverRecoveryPeriod2->TabIndex = 151;
			this->tAverRecoveryPeriod2->Text = L"50";
			this->tAverRecoveryPeriod2->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->tAverRecoveryPeriod2->Enter += gcnew System::EventHandler(this, &ComponentSecondaryVegetation::textBox_Enter);
			// 
			// lAverRecoveryPeriod2
			// 
			this->lAverRecoveryPeriod2->AutoSize = true;
			this->lAverRecoveryPeriod2->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lAverRecoveryPeriod2->Location = System::Drawing::Point(85, 467);
			this->lAverRecoveryPeriod2->Name = L"lAverRecoveryPeriod2";
			this->lAverRecoveryPeriod2->Size = System::Drawing::Size(181, 23);
			this->lAverRecoveryPeriod2->TabIndex = 159;
			this->lAverRecoveryPeriod2->Text = L"averRecoveryPeriod2";
			this->lAverRecoveryPeriod2->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// tAverRecoveryPeriod1
			// 
			this->tAverRecoveryPeriod1->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tAverRecoveryPeriod1->Location = System::Drawing::Point(272, 395);
			this->tAverRecoveryPeriod1->Name = L"tAverRecoveryPeriod1";
			this->tAverRecoveryPeriod1->Size = System::Drawing::Size(89, 20);
			this->tAverRecoveryPeriod1->TabIndex = 149;
			this->tAverRecoveryPeriod1->Text = L"25";
			this->tAverRecoveryPeriod1->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->tAverRecoveryPeriod1->Enter += gcnew System::EventHandler(this, &ComponentSecondaryVegetation::textBox_Enter);
			// 
			// lAverRecoveryPeriod1
			// 
			this->lAverRecoveryPeriod1->AutoSize = true;
			this->lAverRecoveryPeriod1->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lAverRecoveryPeriod1->Location = System::Drawing::Point(85, 395);
			this->lAverRecoveryPeriod1->Name = L"lAverRecoveryPeriod1";
			this->lAverRecoveryPeriod1->Size = System::Drawing::Size(181, 23);
			this->lAverRecoveryPeriod1->TabIndex = 157;
			this->lAverRecoveryPeriod1->Text = L"averRecoveryPeriod1";
			this->lAverRecoveryPeriod1->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// tAverRecoveryPeriod2Perc
			// 
			this->tAverRecoveryPeriod2Perc->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tAverRecoveryPeriod2Perc->Location = System::Drawing::Point(272, 431);
			this->tAverRecoveryPeriod2Perc->Name = L"tAverRecoveryPeriod2Perc";
			this->tAverRecoveryPeriod2Perc->Size = System::Drawing::Size(89, 20);
			this->tAverRecoveryPeriod2Perc->TabIndex = 150;
			this->tAverRecoveryPeriod2Perc->Text = L"0.3";
			this->tAverRecoveryPeriod2Perc->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->tAverRecoveryPeriod2Perc->Enter += gcnew System::EventHandler(this, &ComponentSecondaryVegetation::textBox_Enter);
			// 
			// lAverRecoveryPeriod2Perc
			// 
			this->lAverRecoveryPeriod2Perc->AutoSize = true;
			this->lAverRecoveryPeriod2Perc->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lAverRecoveryPeriod2Perc->Location = System::Drawing::Point(50, 431);
			this->lAverRecoveryPeriod2Perc->Name = L"lAverRecoveryPeriod2Perc";
			this->lAverRecoveryPeriod2Perc->Size = System::Drawing::Size(216, 23);
			this->lAverRecoveryPeriod2Perc->TabIndex = 155;
			this->lAverRecoveryPeriod2Perc->Text = L"averRecoveryPeriod2Perc";
			this->lAverRecoveryPeriod2Perc->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// tDescription
			// 
			this->tDescription->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tDescription->Location = System::Drawing::Point(152, 183);
			this->tDescription->Name = L"tDescription";
			this->tDescription->Size = System::Drawing::Size(278, 20);
			this->tDescription->TabIndex = 144;
			this->tDescription->Text = L"Descri�ao do Componente";
			this->tDescription->Enter += gcnew System::EventHandler(this, &ComponentSecondaryVegetation::textBox_Enter);
			// 
			// tAverRecoveryPeriod1Perc
			// 
			this->tAverRecoveryPeriod1Perc->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tAverRecoveryPeriod1Perc->Location = System::Drawing::Point(272, 359);
			this->tAverRecoveryPeriod1Perc->Name = L"tAverRecoveryPeriod1Perc";
			this->tAverRecoveryPeriod1Perc->Size = System::Drawing::Size(89, 20);
			this->tAverRecoveryPeriod1Perc->TabIndex = 148;
			this->tAverRecoveryPeriod1Perc->Text = L"0.7";
			this->tAverRecoveryPeriod1Perc->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->tAverRecoveryPeriod1Perc->Enter += gcnew System::EventHandler(this, &ComponentSecondaryVegetation::textBox_Enter);
			// 
			// tAverAreaAccPercVegSec
			// 
			this->tAverAreaAccPercVegSec->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tAverAreaAccPercVegSec->Location = System::Drawing::Point(272, 323);
			this->tAverAreaAccPercVegSec->Name = L"tAverAreaAccPercVegSec";
			this->tAverAreaAccPercVegSec->Size = System::Drawing::Size(89, 20);
			this->tAverAreaAccPercVegSec->TabIndex = 147;
			this->tAverAreaAccPercVegSec->Text = L"0";
			this->tAverAreaAccPercVegSec->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->tAverAreaAccPercVegSec->Enter += gcnew System::EventHandler(this, &ComponentSecondaryVegetation::textBox_Enter);
			// 
			// tAverAreaPercVegSec
			// 
			this->tAverAreaPercVegSec->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tAverAreaPercVegSec->Location = System::Drawing::Point(272, 287);
			this->tAverAreaPercVegSec->Name = L"tAverAreaPercVegSec";
			this->tAverAreaPercVegSec->Size = System::Drawing::Size(89, 20);
			this->tAverAreaPercVegSec->TabIndex = 146;
			this->tAverAreaPercVegSec->Text = L"0.21";
			this->tAverAreaPercVegSec->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->tAverAreaPercVegSec->Enter += gcnew System::EventHandler(this, &ComponentSecondaryVegetation::textBox_Enter);
			// 
			// lAverRecoveryPeriod1Perc
			// 
			this->lAverRecoveryPeriod1Perc->AutoSize = true;
			this->lAverRecoveryPeriod1Perc->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lAverRecoveryPeriod1Perc->Location = System::Drawing::Point(50, 359);
			this->lAverRecoveryPeriod1Perc->Name = L"lAverRecoveryPeriod1Perc";
			this->lAverRecoveryPeriod1Perc->Size = System::Drawing::Size(216, 23);
			this->lAverRecoveryPeriod1Perc->TabIndex = 145;
			this->lAverRecoveryPeriod1Perc->Text = L"averRecoveryPeriod1Perc";
			this->lAverRecoveryPeriod1Perc->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// taverHalfLife
			// 
			this->taverHalfLife->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->taverHalfLife->Location = System::Drawing::Point(272, 251);
			this->taverHalfLife->Name = L"taverHalfLife";
			this->taverHalfLife->Size = System::Drawing::Size(89, 20);
			this->taverHalfLife->TabIndex = 145;
			this->taverHalfLife->Text = L"5";
			this->taverHalfLife->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->taverHalfLife->Enter += gcnew System::EventHandler(this, &ComponentSecondaryVegetation::textBox_Enter);
			// 
			// lAverAreaAccPercVegSec
			// 
			this->lAverAreaAccPercVegSec->AutoSize = true;
			this->lAverAreaAccPercVegSec->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lAverAreaAccPercVegSec->Location = System::Drawing::Point(64, 323);
			this->lAverAreaAccPercVegSec->Name = L"lAverAreaAccPercVegSec";
			this->lAverAreaAccPercVegSec->Size = System::Drawing::Size(202, 23);
			this->lAverAreaAccPercVegSec->TabIndex = 144;
			this->lAverAreaAccPercVegSec->Text = L"averAreaAccPercVegSec";
			this->lAverAreaAccPercVegSec->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// tName
			// 
			this->tName->CharacterCasing = System::Windows::Forms::CharacterCasing::Lower;
			this->tName->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tName->Location = System::Drawing::Point(152, 157);
			this->tName->MaxLength = 2;
			this->tName->Name = L"tName";
			this->tName->Size = System::Drawing::Size(53, 20);
			this->tName->TabIndex = 143;
			this->tName->Text = L"sv";
			this->tName->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->tName->Enter += gcnew System::EventHandler(this, &ComponentSecondaryVegetation::textBox_Enter);
			// 
			// laverAreaPercVegSec
			// 
			this->laverAreaPercVegSec->AutoSize = true;
			this->laverAreaPercVegSec->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->laverAreaPercVegSec->Location = System::Drawing::Point(92, 287);
			this->laverAreaPercVegSec->Name = L"laverAreaPercVegSec";
			this->laverAreaPercVegSec->Size = System::Drawing::Size(174, 23);
			this->laverAreaPercVegSec->TabIndex = 143;
			this->laverAreaPercVegSec->Text = L"averAreaPercVegSec";
			this->laverAreaPercVegSec->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// lDescription
			// 
			this->lDescription->AutoSize = true;
			this->lDescription->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lDescription->Location = System::Drawing::Point(62, 181);
			this->lDescription->Name = L"lDescription";
			this->lDescription->Size = System::Drawing::Size(87, 23);
			this->lDescription->TabIndex = 146;
			this->lDescription->Text = L"Descri��o";
			this->lDescription->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// lAverHalfLife
			// 
			this->lAverHalfLife->AutoSize = true;
			this->lAverHalfLife->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lAverHalfLife->Location = System::Drawing::Point(160, 251);
			this->lAverHalfLife->Name = L"lAverHalfLife";
			this->lAverHalfLife->Size = System::Drawing::Size(106, 23);
			this->lAverHalfLife->TabIndex = 147;
			this->lAverHalfLife->Text = L"averHalfLife";
			this->lAverHalfLife->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// lName
			// 
			this->lName->AutoSize = true;
			this->lName->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lName->Location = System::Drawing::Point(91, 155);
			this->lName->Name = L"lName";
			this->lName->Size = System::Drawing::Size(58, 23);
			this->lName->TabIndex = 148;
			this->lName->Text = L"Nome";
			this->lName->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// bSalvar
			// 
			this->bSalvar->Location = System::Drawing::Point(211, 642);
			this->bSalvar->Name = L"bSalvar";
			this->bSalvar->Size = System::Drawing::Size(75, 23);
			this->bSalvar->TabIndex = 142;
			this->bSalvar->Text = L"Salvar";
			this->bSalvar->UseVisualStyleBackColor = true;
			this->bSalvar->Click += gcnew System::EventHandler(this, &ComponentSecondaryVegetation::bSalvar_Click);
			// 
			// pbLogo1
			// 
			this->pbLogo1->Image = (cli::safe_cast<System::Drawing::Image^>(resources->GetObject(L"pbLogo1.Image")));
			this->pbLogo1->Location = System::Drawing::Point(70, 12);
			this->pbLogo1->Name = L"pbLogo1";
			this->pbLogo1->Size = System::Drawing::Size(367, 134);
			this->pbLogo1->SizeMode = System::Windows::Forms::PictureBoxSizeMode::StretchImage;
			this->pbLogo1->TabIndex = 141;
			this->pbLogo1->TabStop = false;
			// 
			// cbSave
			// 
			this->cbSave->AutoSize = true;
			this->cbSave->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold));
			this->cbSave->Location = System::Drawing::Point(160, 600);
			this->cbSave->Name = L"cbSave";
			this->cbSave->Size = System::Drawing::Size(170, 27);
			this->cbSave->TabIndex = 155;
			this->cbSave->Text = L"Salvar em arquivo";
			this->cbSave->UseVisualStyleBackColor = true;
			// 
			// ComponentSecondaryVegetation
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->AutoScroll = true;
			this->ClientSize = System::Drawing::Size(495, 677);
			this->Controls->Add(this->cbSave);
			this->Controls->Add(this->tAverInitialAbandonmentCycle);
			this->Controls->Add(this->lAverInitialAbandonmentCycle);
			this->Controls->Add(this->tAverAgriculturalUseCycle);
			this->Controls->Add(this->lAverAgriculturalUseCycle);
			this->Controls->Add(this->tAverRecoveryPeriod2);
			this->Controls->Add(this->lAverRecoveryPeriod2);
			this->Controls->Add(this->tAverRecoveryPeriod1);
			this->Controls->Add(this->lAverRecoveryPeriod1);
			this->Controls->Add(this->tAverRecoveryPeriod2Perc);
			this->Controls->Add(this->lAverRecoveryPeriod2Perc);
			this->Controls->Add(this->tDescription);
			this->Controls->Add(this->tAverRecoveryPeriod1Perc);
			this->Controls->Add(this->tAverAreaAccPercVegSec);
			this->Controls->Add(this->tAverAreaPercVegSec);
			this->Controls->Add(this->lAverRecoveryPeriod1Perc);
			this->Controls->Add(this->taverHalfLife);
			this->Controls->Add(this->lAverAreaAccPercVegSec);
			this->Controls->Add(this->tName);
			this->Controls->Add(this->laverAreaPercVegSec);
			this->Controls->Add(this->lDescription);
			this->Controls->Add(this->lAverHalfLife);
			this->Controls->Add(this->lName);
			this->Controls->Add(this->bSalvar);
			this->Controls->Add(this->pbLogo1);
			this->Name = L"ComponentSecondaryVegetation";
			this->ShowInTaskbar = false;
			this->StartPosition = System::Windows::Forms::FormStartPosition::CenterScreen;
			this->Text = L"Component - SecondaryVegetation";
			this->Shown += gcnew System::EventHandler(this, &ComponentSecondaryVegetation::ComponentSecondaryVegetation_Shown);
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pbLogo1))->EndInit();
			this->ResumeLayout(false);
			this->PerformLayout();

		}
#pragma endregion
	private: System::Void textBox_Enter(System::Object^  sender, System::EventArgs^  e);
	private: System::Void ComponentSecondaryVegetation_Shown(System::Object^  sender, System::EventArgs^  e);
	private: System::Void bSalvar_Click(System::Object^  sender, System::EventArgs^  e);
};
}
