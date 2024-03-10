program Monitor;

uses
  System.StartUpCopy,
  FMX.Forms,
  UMain in 'UMain.pas' {FrmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
