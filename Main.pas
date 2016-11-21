unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Threading, Vcl.Buttons;

type
  TForm1 = class(TForm)
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private êÈåæ }
  public
    { Public êÈåæ }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  Current: ITask;
begin
  Current := TTask.Run(
    procedure
    begin
      Sleep(10000);
      TThread.Synchronize(nil,
        procedure
        begin
          ShowMessage('End');
        end
      );
    end
  );

  while not TTask.WaitForAll([Current], 1) do
  begin
    Application.ProcessMessages();
  end;
end;

end.
