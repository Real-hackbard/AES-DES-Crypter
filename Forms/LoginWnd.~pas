unit LoginWnd;

interface

uses
  Windows, Messages, SysUtils,Classes, Graphics, Controls, Forms,
  Dialogs, SfcFastCrypt , StdCtrls;

type
  TForm2 = class(TForm)
    grpLogin: TGroupBox;
    lblUserName: TLabel;
    lblPassword: TLabel;
    txtUserName: TEdit;
    txtPassword: TEdit;
    btnGenerate: TButton;
    lblSecretKey: TLabel;
    txtSecretKey: TEdit;
    BtnCheck: TButton;
    txtIteration: TEdit;
    lblIteration: TLabel;
    txtKeyLen: TEdit;
    lblKeyLen: TLabel;
    chkHexa: TCheckBox;
    btnInternalCheck: TButton;
    procedure btnGenerateClick(Sender: TObject);
    procedure BtnCheckClick(Sender: TObject);
    procedure chkHexaClick(Sender: TObject);
    procedure btnInternalCheckClick(Sender: TObject);
  private
    { DÈclarations privÈes }
    procedure DoLogin;
    function  CheckPass(P1 , P2 : String):Boolean;
  public
    { DÈclarations publiques }
  end;

var
  Form2: TForm2;

implementation
Uses
Unit1;

{$R *.dfm}

Const
MySecretLogin = 'R´D«%ãdØw©)∂7‘qÀáÈB|cÒçC‰»EDMR';

procedure TForm2.btnGenerateClick(Sender: TObject);
begin
    DoLogin;
    Case chkHexa.State of
    cbChecked    : txtSecretKey.Text := Form1.FC.DataToHex;
    cbUnChecked  : txtSecretKey.Text := HexToStr(Form1.FC.DataToHex);
    end;
end;

procedure TForm2.BtnCheckClick(Sender: TObject);
begin
    DoLogin;
    Case chkHexa.State of
    cbChecked    : CheckPass(txtSecretKey.Text , Form1.FC.DataToHex);
    cbUnChecked  : CheckPass(txtSecretKey.Text , HexToStr(Form1.FC.DataToHex));
    end;
end;

procedure TForm2.chkHexaClick(Sender: TObject);
begin
    Case ChkHexa.State of
    cbChecked   : ChkHexa.Caption := 'HEX';
    cbUnChecked : ChkHexa.Caption := 'ASCii';
    end;
end;

procedure TForm2.btnInternalCheckClick(Sender: TObject);
begin
    DoLogin;
    CheckPass( MySecretLogin , HexToStr(Form1.FC.DataToHex));
end;

procedure TForm2.DoLogin;
var
  Login : TFastCryptLoginInfo;
begin
    with Login do
    begin
        UserName  := txtUserName.Text;
        Password  := txtPassword.Text;
        Iteration := StrToIntDef(txtIteration.Text , 1);
        KeyLen    := StrToIntDef(txtKeyLen.Text    , 32);
        Form1.FC.GeneratePass(Login);
    end;
end;

function TForm2.CheckPass(P1, P2: String): Boolean;
begin
    result := False;
    if SameText(P1                          , P2) then
       begin
           MessageDlg('Correct password !!!'   , mtInformation , [mbOk] , 0);
           Result := True;
       end else
       MessageDlg('Incorrect password !!!'     , mtWarning     , [mbOk] , 0);
end;

end.
