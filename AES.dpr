program AES;

uses
  Forms,
  Unit1 in 'Forms\Unit1.pas' {Form1},
  SfcFastCrypt in 'Units\SfcFastCrypt.pas',
  LoginWnd in 'Forms\LoginWnd.pas' {Form2},
  MPHexEditor in 'Units\ExLib\HexEditor\mpHexEditor.pas';

{$R *.res}

begin
    Application.Initialize;
    Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
