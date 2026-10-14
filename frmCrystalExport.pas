unit frmCrystalExport;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, CrystalEmulation;

type
  Tfrm_crystal_export = class(TForm)
    ButtonImprimir: TButton;
    edtParam1: TEdit;
    edtParam2: TEdit;
    edtParam3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    edtServer: TEdit;
    edtDatabase: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    edtUser: TEdit;
    edtPassword: TEdit;
    Label7: TLabel;
    procedure ButtonImprimirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Crpe1: TCrpe;
  public
    { Public declarations }
  end;

var
  frm_crystal_export: Tfrm_crystal_export;

implementation

{$R *.dfm}

procedure Tfrm_crystal_export.ButtonImprimirClick(Sender: TObject);
begin
  // Load the RPT and SQL params
  Crpe1.ReportName := GetCurrentDir  + '\CRAA001.rpt';

  Crpe1.Connect.ServerName   := edtServer.Text; //'localhost';
  Crpe1.Connect.DatabaseName := edtDatabase.Text; //'ArturAlaor';
  Crpe1.Connect.UserID       := edtUser.Text; //'sa';
  Crpe1.Connect.Password     := edtPassword.Text; //'sa123';

  // Parametros
  Crpe1.ParamFields[0].Name := 'cdCobranca';
  Crpe1.ParamFields[0].CurrentValue := edtParam1.Text; //'00032';

  Crpe1.ParamFields[1].Name := 'nrCNPJEmpresa';
  Crpe1.ParamFields[1].CurrentValue := edtParam2.Text; //'91.882.596/0001-56';

  Crpe1.ParamFields[2].Name := 'nrCPFCNPJCliente';
  Crpe1.ParamFields[2].CurrentValue := edtParam3.Text; //'214.342.140-01';

  Crpe1.Execute;
end;

procedure Tfrm_crystal_export.FormCreate(Sender: TObject);
begin
  Crpe1 := TCrpe.Create;
end;

end.
