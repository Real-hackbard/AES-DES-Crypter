unit Unit1;

interface

uses
   Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
   Dialogs, StdCtrls, SfcFastCrypt, ExtCtrls, Menus, ImgList, ComCtrls,
   ToolWin, jpeg, MPHexEditor, XPMan;

{$WARN UNSAFE_TYPE OFF}


type   

  TFileType =(
                ftUnknown   ,
                ftText      ,
                ftBinary    ,
                ftAudio     ,
                ftGraphics  ,
                ftAll
                );

  TFilterInfo = record
    Title  : String;
    Filter : String;
    fType  : TFileType;
  end;

const
  MaxFilter = 7;
  TFilterLookup : array[1..MaxFilter] of TFilterInfo =
  (
   ( Title : 'fichier txt(*.txt)'                   ; Filter : '|*.txt|'            ; fType : ftText     ) ,
   ( Title : 'fichier dat(*.dat)'                   ; Filter : '|*.dat|'            ; fType : ftBinary   ) ,
   ( Title : 'fichier bin(*.bin)'                   ; Filter : '|*.bin|'            ; fType : ftBinary   ) ,
   ( Title : 'fichier exe(*.exe)'                   ; Filter : '|*.exe|'            ; fType : ftBinary   ) ,
   ( Title : 'fichier audio(*.wav;*.mp3)'           ; Filter : '|*.wav;*.mp3|'      ; fType : ftAudio    ) ,
   ( Title : 'fichier graphique(*.jpg;*.bmp;*.png)' ; Filter : '|*.jpg;*.bmp;*.png|'; fType : ftGraphics ) ,
   ( Title : 'tout (*.*)'                           ; Filter : ' |*.*'              ; fType : ftAll      )
   );


Type
  TForm1 = class(TForm)
    ToolBarMain: TToolBar;
    tbSep1: TToolButton;
    Panel1: TPanel;
    rgpModeCrypt: TRadioGroup;
    Panel2: TPanel;
    Memo: TMemo;
    ImgListToolBar: TImageList;
    OpenDlg: TOpenDialog;
    SaveDlg: TSaveDialog;
    Panel3: TPanel;
    lblPassword: TLabel;
    txtPassword: TEdit;
    btnRndKey: TButton;
    Panel4: TPanel;
    txtHash: TEdit;
    btnHash: TButton;
    RadioGroup1: TRadioGroup;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    btnCrypt: TButton;
    btnDecrypt: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rgpModeCryptClick(Sender: TObject);
    procedure btnCryptClick(Sender: TObject);
    procedure btnDecryptClick(Sender: TObject);
    procedure btnHashClick(Sender: TObject);
    procedure btnRndKeyClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Declarations privates }
    FFileName      : String;
    IsExternalFile : Boolean;
    MaxKeyLen      : Integer;
    MinKeyLen      : Integer;
    HexEdit        : TMPHexEditor;
    CurrFileType   : TFileType;
    function  GenerateKey:String;
    procedure DoChangeMemo(IsMemo : Boolean = False);
    procedure LoadFromFile;
    procedure SaveToFile;
    procedure OnFastCryptModeChange (Sender : TObject);
  public
    FC             : TSfcFastCrypt;
    procedure Update_rgpModeCrypt;
    function  GetKeyLen  : Integer;
    function  GetMemoLen : Integer;
    function  Ready      : Boolean;
    function  CanHash    : Boolean;
    procedure Alert(const Mess :  String ; const Args : array of Const);overload;
    procedure Alert(const Mess :  String);overload;
    { Declarations publique }
  end;

var
  Form1: TForm1;


function IsValidHex(const Data : String):Boolean;

implementation

uses LoginWnd;

{$R *.dfm}

function  GetFilters : String;
var
i : Integer;
begin
    result := '';
    for i := Low(TFilterLookup) to High(TFilterLookup) do
    result := result + TFilterLookup[i].Title + TFilterLookup[i].Filter;
end;

function IndexToFilterInfo(Index : Integer): TFilterInfo;
begin
    result := TFilterLookup[Index];
end;

function IsValidHex(const Data : String):Boolean;
var
  P : PChar;
begin
    result := False;
    if (Data = '') then Exit;
    result := True;
    P      := PChar(Data);
    while (P^ <> #0) do
    begin
        if not(P^ in ['a'..'f' , 'A'..'F', '0'..'9']) then
        begin
            result := False;
            Break;
        end;
        inc(P);
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    MinKeyLen             := AES_128Bits;
    MaxKeyLen             := AES_256Bits;
    IsExternalFile        := False;
    FFileName             := '';
    txtPassword.Text      := GenerateKey;
    FC                    := TSfcFastCrypt.Create(txtPassword.Text);
    with FC do
    begin
        ModeCrypt         := mcAES;
        OnModeCryptChange := OnFastCryptModeChange;
    end;
    HexEdit               := TMPHexEditor.Create(nil);
    HexEdit.Align         := alClient;
    //ToolBarMain.Width     := ControlBar.Width;
    CurrFileType          := ftUnknown;
    Memo.Text             := 'This is a test, put your data here';
    Update_rgpModeCrypt;
    rgpModeCrypt.ItemIndex := 0;
    rgpModeCryptClick(nil);
//    Memo.MaxLength        := $FFFFFFFF;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
    FC.Free;
    HexEdit.Free;
end;

procedure TForm1.rgpModeCryptClick(Sender: TObject);
var
   Index : Integer;
begin
    Index := rgpModeCrypt.ItemIndex;
    if Index = -1 then Exit;
    FC.ModeCrypt := TModeCrypt(Index);
end;

function TForm1.GetKeyLen: Integer;
begin
    result := Length(Trim(txtPassword.Text));
end;

function TForm1.Ready: Boolean;
begin
    if IsExternalFile = False then
    if GetMemoLen = 0 then
    begin
        Alert('Please first fill out the Memo field. !!');
        Result := False;
        Exit;
    end;

    if (GetKeyLen < MinKeyLen) or (GetKeyLen > MaxKeyLen) then
    begin
        Alert('Warning incorrect key length!!, expected minimum %u maximum %u but found %u', [MinKeyLen , MaxKeyLen , GetKeyLen]);
        Result := False;
        Exit;
    end;
    result := True;
end;

procedure TForm1.btnCryptClick(Sender: TObject);
begin
    if Ready then
    begin
        Screen.Cursor := crHourGlass;
        FC.Password := txtPassword.Text;
        FC.Stream.Clear;
        if IsExternalFile = False then
        begin
            Memo.Lines.SaveToStream(FC.Stream);
            if FC.Crypt then
            begin
                Memo.Text := FC.DataToHex;
            end else
            Alert('Failed to Encrypt Memo Data');
        end else
        begin
            Case CurrFileType of

            ftText     :
            begin
                FC.LoadFromFile(FFileName);
                if FC.Crypt then
                begin
                    Memo.Text := FC.DataToHex;
                    DoChangeMemo(True);
                end else
                Alert('Failed to Encrypt File %s' , [FFileName]);
            end;

            ftBinary, ftAudio, ftGraphics :
            begin
                HexEdit.SaveToStream(FC.Stream);
                if FC.Crypt then
                begin
                    HexEdit.LoadFromStream(FC.Data);
                    DoChangeMemo;
                end else
                Alert('Failed to Encrypt File %s' , [FFileName]);
            end;
            end;
        end;
    end;
    Screen.Cursor := crDefault;
end;

function TForm1.GetMemoLen: Integer;
begin
    result := Length(Trim(Memo.Text));
end;

procedure TForm1.OnFastCryptModeChange(Sender: TObject);
var
  Index : Integer;
  Info  : TModeCryptInfo;
begin
    Index := rgpModeCrypt.ItemIndex;
    if Index = -1 then Exit;

    Info := TModeCryptLookup[TModeCrypt(Index)];

    case Info.Kind of
       mck_Crypt :
       begin
           txtPassword.Enabled := True;
           btnCrypt.Enabled    := True;
           btnDecrypt.Enabled  := True;
           btnRndKey.Enabled   := True;
           btnHash.Enabled     := False;
           txtHash.Enabled     := False;
           MinKeyLen           := Info.KeyMin;
           MaxKeyLen           := Info.KeyMax;
       end;

       mck_Hash, mck_CheckSum :
       begin
           btnHash.Enabled     := True;
           txtHash.Enabled     := True;
           btnCrypt.Enabled    := False;
           btnDecrypt.Enabled  := False;
           btnRndKey.Enabled   := False;
           txtPassword.Enabled := False;
       end;
    end;
end;

procedure TForm1.btnDecryptClick(Sender: TObject);
begin
    if Ready then
    begin
        Screen.Cursor := crHourGlass;
        FC.Password := txtPassword.Text;
        FC.Stream.Clear;
        if IsExternalFile = False then
        begin
            if IsValidHex(Memo.Text) then
            begin
                FC.LoadFromString(HexToStr(Memo.Lines.Text));
                if FC.Decrypt then
                begin
                    Memo.Lines.LoadFromStream(FC.Data);
                end else // Decrypt = true
                Alert('Failed to decrypt Memo data');
            end else
            Alert('Error the data does not have a valid Hex format');
        end else
        begin
            case CurrFileType of
            ftText     :
            begin
                FC.LoadFromString(HexToStr((Memo.Text)));
                if FC.Decrypt then
                begin
                    Memo.Lines.LoadFromStream(FC.Data);
                    DoChangeMemo(True);
                end else
                Alert('Failed to Encrypt File %s' , [FFileName]);
            end;

            ftBinary, ftAudio, ftGraphics :
            begin
                HexEdit.SaveToStream(FC.Stream);
                if FC.Decrypt then
                begin
                    HexEdit.LoadFromStream(FC.Data);
                    DoChangeMemo;
                end else
                Alert('Failed to Encrypt File %s' , [FFileName]);
            end;
            end;
        end;
    end;
    Screen.Cursor := crDefault;
end;

procedure TForm1.btnHashClick(Sender: TObject);
begin
    if CanHash then
    begin
    Screen.Cursor := crHourGlass;
        if not(IsExternalFile) then
        begin
            FC.Clear(True , True);
            FC.LoadFromStrings(Memo.lines);
            if FC.Hash then
               txtHash.Text := FC.DataToHex
             else
                Alert('Failure when Hashing the Memo');
        end else
        begin
            FC.Stream.Clear;
            HexEdit.SaveToStream(FC.Stream);
            if FC.Hash then
               txtHash.Text := FC.DataToHex else
               Alert('Failed to Hash file %s', [FFileName]);
        end;
        Screen.Cursor := crDefault;
    end else
    txtHash.Text := 'Failure !!!';
    Screen.Cursor := crDefault;
end;

function TForm1.CanHash: Boolean;
begin
    result := False;
    if rgpModeCrypt.ItemIndex = -1 then Exit;
    if (IsExternalFile = False) and (GetMemoLen=0) then
    begin
        Alert('Please note, please fill out the Memo field');
        Exit;
    end;

    case TModeCryptLookup[TModeCrypt(rgpModeCrypt.ItemIndex)].Kind of
       mck_Hash, mck_CheckSum : result := true;
       else
          Alert('Attention please choose a mode "HASH"')
    end;
end;

procedure TForm1.Alert(const Mess : String; const Args: array of Const);
begin
    MessageDlg(Format(Mess  , Args), mtWarning , [mbOk] , 0);
end;

procedure TForm1.Alert(const Mess: String);
begin
    Alert(Mess , []);
end;

procedure TForm1.LoadFromFile;
begin
    with OpenDlg do
    begin
        InitialDir   := Application.ExeName;
        Filter       := GetFilters;
        FFileName    := '';
        CurrFileType := ftUnknown;
        if Execute then
        begin
            Memo.Clear;
            FC.LoadFromFile(OpenDlg.FileName);
            IsExternalFile := True;
            FFileName      := OpenDlg.FileName;

            CurrFileType := IndexToFilterInfo(OpenDlg.FilterIndex).fType;

            Case CurrFileType  of
            ftText     :
            begin
                Memo.Lines.LoadFromFile(OpenDlg.FileName);
                DoChangeMemo(True)
            end;

            ftBinary, ftAudio, ftGraphics   :
            begin
                DoChangeMemo;
                HexEdit.LoadFromFile(OpenDlg.FileName);
            end
            end;
            Caption := FFileName;
        end;
    end;
end;

procedure TForm1.SaveToFile;
begin
    if IsExternalFile then
    begin
        with SaveDlg do
        begin
            InitialDir  := FFileName;
            Filter      := GetFilters;
            FilterIndex := OpenDlg.FilterIndex;
            if Execute then
            begin
                if ExtractFileExt(FileName) = '' then
                   FileName := ChangeFileExt(FileName , ExtractFileExt(FFileName));
                FC.SaveToFile(SaveDlg.FileName);
            end;
        end;
    end;
end;

procedure TForm1.DoChangeMemo(IsMemo: Boolean);
var
   WinCtrl : TWinControl;
begin
    WinCtrl := nil;
    case IsMemo of
       True  : WinCtrl := Memo;
       False : WinCtrl := HexEdit;
    end;
    with WinCtrl  do
    begin
        BringToFront;
    end;
end;

function TForm1.GenerateKey: String;
var
  I : Integer;
begin
    Randomize;
    result := '';
    for i:= 1 to (MaxKeyLen div 2) do
      result := result + IntToHex(Random(256) , 2);
end;

procedure TForm1.btnRndKeyClick(Sender: TObject);
begin
    txtPassword.Text := GenerateKey;
end;

procedure TForm1.Update_rgpModeCrypt;
var
   i : Integer;
   s : String;
begin
    rgpModeCrypt.Items.Clear;
    for i := Ord(Low(TModeCryptLookup)) to Ord(High(TModeCryptLookup)) do
    begin
        s := TModeCryptLookup[TModeCrypt(i)].Name + ' (' + ModeCryptKindToStr(TModeCryptLookup[TModeCrypt(i)].mc) + ')';
        rgpModeCrypt.Items.Add(s);
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  LoadFromFile;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  SaveToFile;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  isExternalFile := False;
    Memo.Clear;
    DoChangeMemo(True);
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
var i : integer;
begin
  Screen.Cursor := crHourGlass;
  case RadioGroup1.ItemIndex of
  0 : Begin
      txtHash.Text := UpperCase(txtHash.Text);

      for i := 0 to Memo.Lines.Count -1 do begin
      Memo.Lines.Text := UpperCase(memo.Lines.Text);
      end;

      end;


  1 : begin
      txtHash.Text := LowerCase(txtHash.Text);

      for i := 0 to Memo.Lines.Count -1 do begin
      Memo.Lines.Text := LowerCase(memo.Lines.Text);

      end;
      end;


  end;
  Screen.Cursor := crDefault;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Form2.Show;
end;

end.
