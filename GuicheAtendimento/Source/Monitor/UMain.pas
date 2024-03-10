unit UMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.FMXUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, System.Classes, FMX.Media;

type
  TFrmMain = class(TForm)
    Rectangle1: TRectangle;
    LabelSenha: TLabel;
    Label1: TLabel;
    FDConnection1: TFDConnection;
    QrySenha: TFDQuery;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    MediaPlayer1: TMediaPlayer;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;
  PodeSair : boolean = false;

implementation



{$R *.fmx}

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  PodeSair := true;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  Thread : TThread;
begin
   sleep(2000);
   Thread := TThread.CreateAnonymousThread(
   procedure
   var
     som, sequencia : integer;
   begin
      som := 0;
      sequencia := 0;
      while not PodeSair do
      begin
        QrySenha.Close;
        QrySenha.Params.ParamByName('data').AsDate := trunc(date);
        QrySenha.Open();

        Thread.Synchronize(Thread.CurrentThread ,
        procedure
        begin
          if sequencia <> QrySenha.FieldByName('sequencia').AsInteger then
          begin

            LabelSenha.Text := QrySenha.FieldByName('sequencia').AsString;
            MediaPlayer1.FileName := 'D:\Projetos Video\GuicheAtendimento\error.wav';

            if som <= 2 then
            begin
               MediaPlayer1.Play;
               inc(som);
            end
            else
            begin
              som := 0;
              sequencia := QrySenha.FieldByName('sequencia').AsInteger;
            end;

          end;

        end);

        sleep(2000);
      end;
   end
   );

   Thread.Start;

end;

end.
end;
