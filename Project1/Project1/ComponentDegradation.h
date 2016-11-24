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
	/// Summary for ComponentDegradation
	/// </summary>
	public ref class ComponentDegradation : public System::Windows::Forms::Form
	{
	public:
		cReturn^ lReturn;
		ComponentDegradation(cReturn^ pDegradation)
		{
			InitializeComponent();
			lReturn = pDegradation;
			//
			//TODO: Add the constructor code here
			//
		}

	protected:
		/// <summary>
		/// Clean up any resources being used.
		/// </summary>
		~ComponentDegradation()
		{
			if (components)
			{
				delete components;
			}
		}

	protected:






	private: System::Windows::Forms::TextBox^  tAverLimiarDegradLoss;

	private: System::Windows::Forms::Label^  lAverLimiarDegradLoss;

	private: System::Windows::Forms::TextBox^  tAverLimiarDegradYears;

	private: System::Windows::Forms::Label^  lAverLimiarDegradYears;

	private: System::Windows::Forms::TextBox^  tAverAGB_percReduction;

	private: System::Windows::Forms::Label^  lAverAGB_percReduction;
	private: System::Windows::Forms::TextBox^  tAverPeriodRegrow;


	private: System::Windows::Forms::Label^  lAverPeriodRegrow;

	private: System::Windows::Forms::TextBox^  tDescription;
	private: System::Windows::Forms::TextBox^  tAverLitter_loss;

	private: System::Windows::Forms::TextBox^  tAverDeadWood_loss;

	private: System::Windows::Forms::TextBox^  tAverBGB_loss;
	private: System::Windows::Forms::Label^  lAverLitter_loss;


	private: System::Windows::Forms::TextBox^  tAverAGB_loss;
	private: System::Windows::Forms::Label^  lAverDeadWood_loss;


	private: System::Windows::Forms::TextBox^  tName;
	private: System::Windows::Forms::Label^  lAverBGB_loss;

	private: System::Windows::Forms::Label^  lDescription;
	private: System::Windows::Forms::Label^  lAverAGB_loss;

	private: System::Windows::Forms::Label^  lName;
	private: System::Windows::Forms::Button^  bSalvar;
	private: System::Windows::Forms::PictureBox^  pbLogo1;

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
			System::ComponentModel::ComponentResourceManager^  resources = (gcnew System::ComponentModel::ComponentResourceManager(ComponentDegradation::typeid));
			this->tAverLimiarDegradLoss = (gcnew System::Windows::Forms::TextBox());
			this->lAverLimiarDegradLoss = (gcnew System::Windows::Forms::Label());
			this->tAverLimiarDegradYears = (gcnew System::Windows::Forms::TextBox());
			this->lAverLimiarDegradYears = (gcnew System::Windows::Forms::Label());
			this->tAverAGB_percReduction = (gcnew System::Windows::Forms::TextBox());
			this->lAverAGB_percReduction = (gcnew System::Windows::Forms::Label());
			this->tAverPeriodRegrow = (gcnew System::Windows::Forms::TextBox());
			this->lAverPeriodRegrow = (gcnew System::Windows::Forms::Label());
			this->tDescription = (gcnew System::Windows::Forms::TextBox());
			this->tAverLitter_loss = (gcnew System::Windows::Forms::TextBox());
			this->tAverDeadWood_loss = (gcnew System::Windows::Forms::TextBox());
			this->tAverBGB_loss = (gcnew System::Windows::Forms::TextBox());
			this->lAverLitter_loss = (gcnew System::Windows::Forms::Label());
			this->tAverAGB_loss = (gcnew System::Windows::Forms::TextBox());
			this->lAverDeadWood_loss = (gcnew System::Windows::Forms::Label());
			this->tName = (gcnew System::Windows::Forms::TextBox());
			this->lAverBGB_loss = (gcnew System::Windows::Forms::Label());
			this->lDescription = (gcnew System::Windows::Forms::Label());
			this->lAverAGB_loss = (gcnew System::Windows::Forms::Label());
			this->lName = (gcnew System::Windows::Forms::Label());
			this->bSalvar = (gcnew System::Windows::Forms::Button());
			this->pbLogo1 = (gcnew System::Windows::Forms::PictureBox());
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pbLogo1))->BeginInit();
			this->SuspendLayout();
			// 
			// tAverLimiarDegradLoss
			// 
			this->tAverLimiarDegradLoss->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tAverLimiarDegradLoss->Location = System::Drawing::Point(266, 572);
			this->tAverLimiarDegradLoss->Name = L"tAverLimiarDegradLoss";
			this->tAverLimiarDegradLoss->Size = System::Drawing::Size(89, 20);
			this->tAverLimiarDegradLoss->TabIndex = 162;
			this->tAverLimiarDegradLoss->Text = L"0.01";
			this->tAverLimiarDegradLoss->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->tAverLimiarDegradLoss->Enter += gcnew System::EventHandler(this, &ComponentDegradation::textBox_Enter);
			// 
			// lAverLimiarDegradLoss
			// 
			this->lAverLimiarDegradLoss->AutoSize = true;
			this->lAverLimiarDegradLoss->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lAverLimiarDegradLoss->Location = System::Drawing::Point(77, 570);
			this->lAverLimiarDegradLoss->Name = L"lAverLimiarDegradLoss";
			this->lAverLimiarDegradLoss->Size = System::Drawing::Size(185, 23);
			this->lAverLimiarDegradLoss->TabIndex = 161;
			this->lAverLimiarDegradLoss->Text = L"averLimiarDegradLoss";
			this->lAverLimiarDegradLoss->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// tAverLimiarDegradYears
			// 
			this->tAverLimiarDegradYears->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tAverLimiarDegradYears->Location = System::Drawing::Point(266, 531);
			this->tAverLimiarDegradYears->Name = L"tAverLimiarDegradYears";
			this->tAverLimiarDegradYears->Size = System::Drawing::Size(89, 20);
			this->tAverLimiarDegradYears->TabIndex = 160;
			this->tAverLimiarDegradYears->Text = L"1";
			this->tAverLimiarDegradYears->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->tAverLimiarDegradYears->Enter += gcnew System::EventHandler(this, &ComponentDegradation::textBox_Enter);
			// 
			// lAverLimiarDegradYears
			// 
			this->lAverLimiarDegradYears->AutoSize = true;
			this->lAverLimiarDegradYears->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lAverLimiarDegradYears->Location = System::Drawing::Point(69, 529);
			this->lAverLimiarDegradYears->Name = L"lAverLimiarDegradYears";
			this->lAverLimiarDegradYears->Size = System::Drawing::Size(193, 23);
			this->lAverLimiarDegradYears->TabIndex = 159;
			this->lAverLimiarDegradYears->Text = L"averLimiarDegradYears";
			this->lAverLimiarDegradYears->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// tAverAGB_percReduction
			// 
			this->tAverAGB_percReduction->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tAverAGB_percReduction->Location = System::Drawing::Point(266, 449);
			this->tAverAGB_percReduction->Name = L"tAverAGB_percReduction";
			this->tAverAGB_percReduction->Size = System::Drawing::Size(89, 20);
			this->tAverAGB_percReduction->TabIndex = 158;
			this->tAverAGB_percReduction->Text = L"0.034";
			this->tAverAGB_percReduction->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->tAverAGB_percReduction->Enter += gcnew System::EventHandler(this, &ComponentDegradation::textBox_Enter);
			// 
			// lAverAGB_percReduction
			// 
			this->lAverAGB_percReduction->AutoSize = true;
			this->lAverAGB_percReduction->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lAverAGB_percReduction->Location = System::Drawing::Point(58, 447);
			this->lAverAGB_percReduction->Name = L"lAverAGB_percReduction";
			this->lAverAGB_percReduction->Size = System::Drawing::Size(204, 23);
			this->lAverAGB_percReduction->TabIndex = 157;
			this->lAverAGB_percReduction->Text = L"averAGB_percReduction";
			this->lAverAGB_percReduction->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// tAverPeriodRegrow
			// 
			this->tAverPeriodRegrow->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tAverPeriodRegrow->Location = System::Drawing::Point(266, 490);
			this->tAverPeriodRegrow->Name = L"tAverPeriodRegrow";
			this->tAverPeriodRegrow->Size = System::Drawing::Size(89, 20);
			this->tAverPeriodRegrow->TabIndex = 156;
			this->tAverPeriodRegrow->Text = L"50";
			this->tAverPeriodRegrow->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->tAverPeriodRegrow->Enter += gcnew System::EventHandler(this, &ComponentDegradation::textBox_Enter);
			// 
			// lAverPeriodRegrow
			// 
			this->lAverPeriodRegrow->AutoSize = true;
			this->lAverPeriodRegrow->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lAverPeriodRegrow->Location = System::Drawing::Point(104, 488);
			this->lAverPeriodRegrow->Name = L"lAverPeriodRegrow";
			this->lAverPeriodRegrow->Size = System::Drawing::Size(158, 23);
			this->lAverPeriodRegrow->TabIndex = 155;
			this->lAverPeriodRegrow->Text = L"averPeriodRegrow";
			this->lAverPeriodRegrow->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// tDescription
			// 
			this->tDescription->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tDescription->Location = System::Drawing::Point(156, 213);
			this->tDescription->Name = L"tDescription";
			this->tDescription->Size = System::Drawing::Size(278, 20);
			this->tDescription->TabIndex = 149;
			this->tDescription->Text = L"Descri�ao do Componente";
			this->tDescription->Enter += gcnew System::EventHandler(this, &ComponentDegradation::textBox_Enter);
			// 
			// tAverLitter_loss
			// 
			this->tAverLitter_loss->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tAverLitter_loss->Location = System::Drawing::Point(266, 408);
			this->tAverLitter_loss->Name = L"tAverLitter_loss";
			this->tAverLitter_loss->Size = System::Drawing::Size(89, 20);
			this->tAverLitter_loss->TabIndex = 152;
			this->tAverLitter_loss->Text = L"0";
			this->tAverLitter_loss->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->tAverLitter_loss->Enter += gcnew System::EventHandler(this, &ComponentDegradation::textBox_Enter);
			// 
			// tAverDeadWood_loss
			// 
			this->tAverDeadWood_loss->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tAverDeadWood_loss->Location = System::Drawing::Point(266, 367);
			this->tAverDeadWood_loss->Name = L"tAverDeadWood_loss";
			this->tAverDeadWood_loss->Size = System::Drawing::Size(89, 20);
			this->tAverDeadWood_loss->TabIndex = 151;
			this->tAverDeadWood_loss->Text = L"0";
			this->tAverDeadWood_loss->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->tAverDeadWood_loss->Enter += gcnew System::EventHandler(this, &ComponentDegradation::textBox_Enter);
			// 
			// tAverBGB_loss
			// 
			this->tAverBGB_loss->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tAverBGB_loss->Location = System::Drawing::Point(266, 326);
			this->tAverBGB_loss->Name = L"tAverBGB_loss";
			this->tAverBGB_loss->Size = System::Drawing::Size(89, 20);
			this->tAverBGB_loss->TabIndex = 150;
			this->tAverBGB_loss->Text = L"0";
			this->tAverBGB_loss->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->tAverBGB_loss->Enter += gcnew System::EventHandler(this, &ComponentDegradation::textBox_Enter);
			// 
			// lAverLitter_loss
			// 
			this->lAverLitter_loss->AutoSize = true;
			this->lAverLitter_loss->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lAverLitter_loss->Location = System::Drawing::Point(135, 406);
			this->lAverLitter_loss->Name = L"lAverLitter_loss";
			this->lAverLitter_loss->Size = System::Drawing::Size(127, 23);
			this->lAverLitter_loss->TabIndex = 145;
			this->lAverLitter_loss->Text = L"averLitter_loss";
			this->lAverLitter_loss->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// tAverAGB_loss
			// 
			this->tAverAGB_loss->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tAverAGB_loss->Location = System::Drawing::Point(266, 285);
			this->tAverAGB_loss->Name = L"tAverAGB_loss";
			this->tAverAGB_loss->Size = System::Drawing::Size(89, 20);
			this->tAverAGB_loss->TabIndex = 153;
			this->tAverAGB_loss->Text = L"0.4";
			this->tAverAGB_loss->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->tAverAGB_loss->Enter += gcnew System::EventHandler(this, &ComponentDegradation::textBox_Enter);
			// 
			// lAverDeadWood_loss
			// 
			this->lAverDeadWood_loss->AutoSize = true;
			this->lAverDeadWood_loss->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lAverDeadWood_loss->Location = System::Drawing::Point(90, 365);
			this->lAverDeadWood_loss->Name = L"lAverDeadWood_loss";
			this->lAverDeadWood_loss->Size = System::Drawing::Size(172, 23);
			this->lAverDeadWood_loss->TabIndex = 144;
			this->lAverDeadWood_loss->Text = L"averDeadWood_loss";
			this->lAverDeadWood_loss->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// tName
			// 
			this->tName->CharacterCasing = System::Windows::Forms::CharacterCasing::Lower;
			this->tName->ForeColor = System::Drawing::SystemColors::ScrollBar;
			this->tName->Location = System::Drawing::Point(126, 187);
			this->tName->MaxLength = 2;
			this->tName->Name = L"tName";
			this->tName->Size = System::Drawing::Size(53, 20);
			this->tName->TabIndex = 154;
			this->tName->Text = L"b";
			this->tName->TextAlign = System::Windows::Forms::HorizontalAlignment::Center;
			this->tName->Enter += gcnew System::EventHandler(this, &ComponentDegradation::textBox_Enter);
			// 
			// lAverBGB_loss
			// 
			this->lAverBGB_loss->AutoSize = true;
			this->lAverBGB_loss->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lAverBGB_loss->Location = System::Drawing::Point(143, 324);
			this->lAverBGB_loss->Name = L"lAverBGB_loss";
			this->lAverBGB_loss->Size = System::Drawing::Size(119, 23);
			this->lAverBGB_loss->TabIndex = 143;
			this->lAverBGB_loss->Text = L"averBGB_loss";
			this->lAverBGB_loss->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// lDescription
			// 
			this->lDescription->AutoSize = true;
			this->lDescription->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lDescription->Location = System::Drawing::Point(66, 210);
			this->lDescription->Name = L"lDescription";
			this->lDescription->Size = System::Drawing::Size(87, 23);
			this->lDescription->TabIndex = 146;
			this->lDescription->Text = L"Descri��o";
			this->lDescription->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// lAverAGB_loss
			// 
			this->lAverAGB_loss->AutoSize = true;
			this->lAverAGB_loss->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lAverAGB_loss->Location = System::Drawing::Point(142, 283);
			this->lAverAGB_loss->Name = L"lAverAGB_loss";
			this->lAverAGB_loss->Size = System::Drawing::Size(120, 23);
			this->lAverAGB_loss->TabIndex = 147;
			this->lAverAGB_loss->Text = L"averAGB_loss";
			this->lAverAGB_loss->TextAlign = System::Drawing::ContentAlignment::TopRight;
			// 
			// lName
			// 
			this->lName->AutoSize = true;
			this->lName->Font = (gcnew System::Drawing::Font(L"Calibri", 14.25F, System::Drawing::FontStyle::Bold, System::Drawing::GraphicsUnit::Point,
				static_cast<System::Byte>(0)));
			this->lName->Location = System::Drawing::Point(65, 184);
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
			// ComponentDegradation
			// 
			this->AutoScaleDimensions = System::Drawing::SizeF(6, 13);
			this->AutoScaleMode = System::Windows::Forms::AutoScaleMode::Font;
			this->ClientSize = System::Drawing::Size(495, 677);
			this->Controls->Add(this->tAverLimiarDegradLoss);
			this->Controls->Add(this->lAverLimiarDegradLoss);
			this->Controls->Add(this->tAverLimiarDegradYears);
			this->Controls->Add(this->lAverLimiarDegradYears);
			this->Controls->Add(this->tAverAGB_percReduction);
			this->Controls->Add(this->lAverAGB_percReduction);
			this->Controls->Add(this->tAverPeriodRegrow);
			this->Controls->Add(this->lAverPeriodRegrow);
			this->Controls->Add(this->tDescription);
			this->Controls->Add(this->tAverLitter_loss);
			this->Controls->Add(this->tAverDeadWood_loss);
			this->Controls->Add(this->tAverBGB_loss);
			this->Controls->Add(this->lAverLitter_loss);
			this->Controls->Add(this->tAverAGB_loss);
			this->Controls->Add(this->lAverDeadWood_loss);
			this->Controls->Add(this->tName);
			this->Controls->Add(this->lAverBGB_loss);
			this->Controls->Add(this->lDescription);
			this->Controls->Add(this->lAverAGB_loss);
			this->Controls->Add(this->lName);
			this->Controls->Add(this->bSalvar);
			this->Controls->Add(this->pbLogo1);
			this->Name = L"ComponentDegradation";
			this->ShowInTaskbar = false;
			this->Text = L"ComponentDegradation";
			(cli::safe_cast<System::ComponentModel::ISupportInitialize^>(this->pbLogo1))->EndInit();
			this->ResumeLayout(false);
			this->PerformLayout();

		}
#pragma endregion
		private: System::Void textBox_Enter(System::Object^  sender, System::EventArgs^  e);
	};
}
