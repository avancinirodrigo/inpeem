#include "stdafx.h"
#include "MyForm.h"
#include "NovoModelo.h"
#include "LanguageForm.h"
#include "AboutForm.h"
#include "EquationForm.h"

using namespace INPEEM;
using namespace System;
using namespace System::ComponentModel;
using namespace System::Collections;
using namespace System::Windows::Forms;
using namespace System::Data;
using namespace System::Drawing;

System::Void INPEEM::MyForm::bNovoModelo_Click(System::Object ^ sender, System::EventArgs ^ e)
{
	INPEEM::NovoModelo^ novoModelo = gcnew INPEEM::NovoModelo(lLanguage, false, 0);
	this->Visible = false;
	novoModelo->ShowDialog();
	try {
		this->Visible = true;
	} catch (ObjectDisposedException^) {
		Application::Exit();
	}
	lLanguage = novoModelo->lLanguage;
	checkLanguage();
	MyForm::Update();
	if (novoModelo->lReturn == 1) {
		bNovoModelo_Click(sender, e);
	}
	if (novoModelo->lReturn == 2) {
		bAbrirModelo_Click(sender, e);
	}
}

System::Void INPEEM::MyForm::MyForm_Load(System::Object ^ sender, System::EventArgs ^ e)
{
	checkLanguage();
	this->Visible = true;
}

System::Void INPEEM::MyForm::checkLanguage()
{
	String^ fileName = "language.dat";
	try {
		StreamReader^ din = File::OpenText(fileName);
		lLanguage = din->ReadLine();
		din->Close();
	}
	catch (Exception^)
	{
		lLanguage = DEFAULTLANGUAGE;
	}
	
	if (lLanguage == "en") {
		this->Text = "INPE-EM LUCC - Model Manager";
		bNovoModelo->Text = "New Model";
		bAbrirModelo->Text = "Open Model";
		arquivoToolStripMenuItem->Text = "File";
		novoToolStripMenuItem->Text = "New";
		abrirToolStripMenuItem->Text = "Open";
		sairToolStripMenuItem->Text = "Exit";
		prefer�nciasToolStripMenuItem->Text = "Preferences";
		idiomaToolStripMenuItem->Text = "Language";
		equationsManagerToolStripMenuItem->Text = "Equations Manager";
		ajudaToolStripMenuItem->Text = "Help";
		sobreToolStripMenuItem->Text = "About";
	}
	else {
		this->Text = "INPE-EM LUCC - Gerenciador de Modelos";
		bNovoModelo->Text = "Novo Modelo";
		bAbrirModelo->Text = "Abrir Modelo";
		arquivoToolStripMenuItem->Text = "Arquivo";
		novoToolStripMenuItem->Text = "Novo";
		abrirToolStripMenuItem->Text = "Abrir";
		sairToolStripMenuItem->Text = "Sair";
		prefer�nciasToolStripMenuItem->Text = "Prefer�ncias";
		idiomaToolStripMenuItem->Text = "Idioma";
		equationsManagerToolStripMenuItem->Text = "Gerenciar F�rmulas";
		ajudaToolStripMenuItem->Text = "Ajuda";
		sobreToolStripMenuItem->Text = "Sobre";
	}
}

System::Void INPEEM::MyForm::idiomaToolStripMenuItem_Click(System::Object ^ sender, System::EventArgs ^ e)
{
	LanguageForm^ languageForm = gcnew LanguageForm(lLanguage);
	languageForm->ShowDialog();
	lLanguage = languageForm->lLanguage;
	checkLanguage();
	MyForm::Update();
}

System::Void INPEEM::MyForm::sairToolStripMenuItem_Click(System::Object ^ sender, System::EventArgs ^ e)
{
	this->Close();
}

System::Void INPEEM::MyForm::sobreToolStripMenuItem_Click(System::Object ^ sender, System::EventArgs ^ e)
{
	AboutForm^ aboutForm = gcnew AboutForm(lLanguage);
	aboutForm->ShowDialog();
}

System::Void INPEEM::MyForm::bAbrirModelo_Click(System::Object ^ sender, System::EventArgs ^ e)
{
	INPEEM::NovoModelo^ novoModelo = gcnew INPEEM::NovoModelo(lLanguage, true, 0);
	this->Visible = false;
	novoModelo->ShowDialog();
	try {
		this->Visible = true;
	}
	catch (ObjectDisposedException^) {
		Application::Exit();
	}
	lLanguage = novoModelo->lLanguage;
	checkLanguage();
	MyForm::Update();
	if (novoModelo->lReturn == 1) {
		bNovoModelo_Click(sender, e);
	}
	if (novoModelo->lReturn == 2) {
		bAbrirModelo_Click(sender, e);
	}
}

System::Void INPEEM::MyForm::luccMEToolStripMenuItem_Click(System::Object ^ sender, System::EventArgs ^ e)
{
	if (lLanguage == "en") {
		Help::ShowHelp(this, "help.chm");
	}
	else {
		Help::ShowHelp(this, "ajuda.chm");
	}
}

System::Void INPEEM::MyForm::equationsManagerToolStripMenuItem_Click(System::Object^  sender, System::EventArgs^  e)
{
	EquationForm^ equationForm = gcnew EquationForm(lLanguage);
	equationForm->ShowDialog();
	MyForm::Update();
}