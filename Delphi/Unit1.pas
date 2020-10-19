unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  C64,
  ShellAPI;

type
  TForm1 = class(TForm)
    mmo1: TMemo;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    C64         : TC64;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
var
  i : integer;
  H : HWND;
begin
  C64                   := TC64.create;
  C64.OutputFileName    := 'out.prg';
  C64.ProgramStart($0810);

  C64.lda($ff);
  for i := 0 to 99 do C64.sta($2000 + i);
  
  C64.lda($00);
  C64.sta(ADDR_BORDERCOLOR);

  C64.ldx(0);
  C64.lbl('LOOP_HERE');
  C64.stx(ADDR_SCREENCOLOR);
  C64.lda($F0);

  //for i := 0 to 10 do C64.sta(ADDR_SCREENMEMORY + i);

  C64.lda(01);
  C64.sta($D015);

  C64.lda($80);
  C64.sta($07F8);
  C64.lda($70);
  C64.sta($D000);
  C64.lda($70);
  C64.sta($D001);

  with C64 do
  begin
    lda($80);
    sta($07F8);
    lda($70);
    sta($D000);
    lda($70);
    sta($D001);
  end;

  C64.inx;
  C64.jmp('LOOP_HERE');
  C64.rts;

  C64.org($2000);

  Shellexecute(H,PChar('open'),PChar('D:\Games\c64\WinVICE-2.4.12\x64.exe'),pchar(extractfilepath(application.exename) + '\' + C64.OutputFileName),'',SW_SHOWNORMAL);
  Close;


end;

end.
