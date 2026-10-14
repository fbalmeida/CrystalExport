program prjCrystalExport;

uses
  Vcl.Forms,
  frmCrystalExport in 'frmCrystalExport.pas' {frm_crystal_export},
  CrystalEmulation in 'CrystalEmulation.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tfrm_crystal_export, frm_crystal_export);
  Application.Run;
end.
