program C64PasTest;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  C64 in 'C64.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
