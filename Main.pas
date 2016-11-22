unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Threading, Vcl.Buttons;

type
  TForm1 = class(TForm)
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private 宣言 }
  public
    { Public 宣言 }
  end;



var
  Form1: TForm1;

implementation

{$R *.dfm}

type
  TMyClass = class
  strict private
    FMsg: string;
  public
    constructor Create(const AMsg: string);
    function Execute(): ITask;
  end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  Current: ITask;
  MyClass: TMyClass;
begin
  MyClass := TMyClass.Create('End');
  try
    Current := MyClass.Execute();

    while not Current.Wait(10) do
    begin
      Application.ProcessMessages();
    end;

  finally
    MyClass.Free;
  end;
end;

{ TMyClass }

constructor TMyClass.Create(const AMsg: string);
begin

  FMsg := EmptyStr;
  FMsg := AMsg;
end;

function TMyClass.Execute: ITask;
begin
  Result :=
   TTask.Run(
    procedure
    begin
      Sleep(4000);
      TThread.Synchronize(nil,
        procedure
        begin
          ShowMessage(Self.FMsg);
        end
      );
    end
  );
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var
  Current: ITask;
  MyClass: TMyClass;
begin
  MyClass := TMyClass.Create('End');
  try
    Current := MyClass.Execute();

   finally
    MyClass.Free;
  end;
end;

end.
