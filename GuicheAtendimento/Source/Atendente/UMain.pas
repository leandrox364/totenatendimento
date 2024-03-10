unit UMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.FMXUI.Wait, FMX.Edit,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FireDAC.Comp.UI,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmMain = class(TForm)
    FDConnection1: TFDConnection;
    QryAtendente: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    Rectangle1: TRectangle;
    LabelSenha: TLabel;
    Label1: TLabel;
    EdtProximaSenha: TEdit;
    QrySequencia: TFDQuery;
    QrySequenciaSEQUENCIA: TIntegerField;
    procedure EdtProximaSenhaKeyDown(Sender: TObject; var Key: Word;
      var KeyChar: Char; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.fmx}

procedure TFrmMain.EdtProximaSenhaKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin

  if KeyChar = #0 then
  begin
    QryAtendente.Close;
    QryAtendente.Params.ParamByName('data').AsDate := trunc(date);

    if EdtProximaSenha.Text = '' then
       QryAtendente.Params.ParamByName('sequencia').AsInteger := LabelSenha.Tag + 1
    else
       QryAtendente.Params.ParamByName('sequencia').AsInteger := strtoint(EdtProximaSenha.Text);
    QryAtendente.Open();


    LabelSenha.Text := 'SENHA '+ QryAtendente.Params.ParamByName('sequencia').AsString;
    LabelSenha.Tag := QryAtendente.Params.ParamByName('sequencia').AsInteger;
    EdtProximaSenha.Text:='';
  end;

end;

procedure TFrmMain.FormActivate(Sender: TObject);
begin
    QrySequencia.Close;
    QrySequencia.Params.ParamByName('data').AsDate := trunc(date);
    QrySequencia.Open();

    LabelSenha.Text := 'SENHA '+ QrySequencia.FieldByName('sequencia').AsString;
    LabelSenha.Tag := QrySequencia.FieldByName('sequencia').AsInteger;
    EdtProximaSenha.Text:='';

end;

end.
