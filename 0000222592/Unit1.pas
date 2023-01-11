unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComObj;

type
  TForm1 = class(TForm)
    Button1: TButton;
    btnSetting: TButton;
    procedure Button1Click(Sender: TObject);
    procedure btnSettingClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  settings: String;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
    fptr: OleVariant;
    mark: String;
    status: Integer;
    validationResult: Integer;
begin
    fptr := CreateOleObject('AddIn.Fptr10');
    fptr.showProperties(fptr.LIBFPTR_GUI_PARENT_NATIVE, 0);

    fptr.open;

    //showmessage(IntToStr(fptr.errorCode));



    {fptr.setSingleSetting(fptr.LIBFPTR_SETTING_MODEL, IntToStr(fptr.LIBFPTR_MODEL_ATOL_AUTO));
    fptr.setSingleSetting(fptr.LIBFPTR_SETTING_PORT, IntToStr(fptr.LIBFPTR_PORT_COM));
    fptr.setSingleSetting(fptr.LIBFPTR_SETTING_COM_FILE, 39);
    fptr.setSingleSetting(fptr.LIBFPTR_SETTING_BAUDRATE, IntToStr(fptr.LIBFPTR_PORT_BR_115200));
    fptr.applySingleSettings;


    fptr.setParam(fptr.LIBFPTR_PARAM_REPORT_TYPE, fptr.LIBFPTR_RT_X);
    fptr.report; }
end;

procedure TForm1.btnSettingClick(Sender: TObject);


var
    fptr: OleVariant;
    mark: String;
    status: Integer;
    validationResult: Integer;
begin



      mark := '014494550435306821QXYXSALGLMYQQ\u001D91EE06\u001D92YWCXbmK6SN8vvwoxZFk7WAY8WoJNMGGr6Cgtiuja04c=';
    status := 2;

    // Запускаем проверку КМ
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE_TYPE, fptr.LIBFPTR_MCT12_AUTO);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE, mark);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE_STATUS, status);
    fptr.setParam(fptr.LIBFPTR_PARAM_QUANTITY, 1.000);
    fptr.setParam(fptr.LIBFPTR_PARAM_MEASUREMENT_UNIT, 0);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_WAIT_FOR_VALIDATION_RESULT, True);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_PROCESSING_MODE, 0);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_FRACTIONAL_QUANTITY, '1/2');
    fptr.beginMarkingCodeValidation();

    // Дожидаемся окончания проверки и запоминаем результат
    while True do
    begin
        fptr.getMarkingCodeValidationStatus();
        if fptr.getParamBool(fptr.LIBFPTR_PARAM_MARKING_CODE_VALIDATION_READY) then
            break;
    end;
    validationResult := fptr.getParamInt(fptr.LIBFPTR_PARAM_MARKING_CODE_ONLINE_VALIDATION_RESULT);

    // Подтверждаем реализацию товара с указанным КМ
    fptr.acceptMarkingCode();

    // ... Проверяем остальные КМ





    //fptr.showProperties(fptr.LIBFPTR_GUI_PARENT_NATIVE, 0);


end;

end.
