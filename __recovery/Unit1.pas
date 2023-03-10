unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,ComObj,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    btndataTime: TButton;
    edt1: TEdit;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure btndataTimeClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  fptr: OleVariant;
  mark:     Array[0 .. 19] of Byte = ($52, $55, $2d, $34, $33, $30, $33, $30, $32, $2d, $41, $41, $41, $34, $30, $35, $30, $31, $30, $38);

     command_byte_array: Array[0 .. 21] of Byte = ($52, $46, $52, $55, $2d, $34, $33, $30, $33, $30, $32, $2d, $41, $41, $41, $34, $30, $35, $30, $31, $30, $38);
   command_variant:       Variant;
      i:                     Integer;
      k:                     Integer;
      answer:                Variant;
      date: TDateTime;

implementation

{$R *.dfm}

//function WindowFromPoint(Point: TPoint): HWnd;




procedure TForm1.FormCreate(Sender: TObject);
begin
    fptr := CreateOleObject('AddIn.Fptr10');
end;





procedure TForm1.Button1Click(Sender: TObject);
var
  settings: String;
  serialNumber:       String;
  configurationVersion: String;
  hex1174: string;


  shiftState:       Longint;
    date: TDateTime;
    correctionInfo: Variant;
     isCoverOpened:           LongBool;

begin


 //settings := Format('{"%s": %s, "%s": %s, "%s": "%s", "%s": %s}',
   // [fptr.LIBFPTR_SETTING_MODEL, IntToStr(fptr.LIBFPTR_MODEL_ATOL_AUTO),
    //fptr.LIBFPTR_SETTING_PORT, IntToStr(fptr.LIBFPTR_PORT_COM),
    //fptr.LIBFPTR_SETTING_COM_FILE, '53',
    //fptr.LIBFPTR_SETTING_BAUDRATE, IntToStr(fptr.LIBFPTR_PORT_BR_115200)]);
     //fptr.setSettings(settings);


ShowMessage('settings');
fptr.showProperties(fptr.LIBFPTR_GUI_PARENT_NATIVE, '0');

//fptr.showProperties(fptr.LIBFPTR_GUI_PARENT_NATIVE, FindWindow('Form1',nil));





//settings := fptr.getSettings;

//settings := '{"AccessPassword" : "0","AutoDisableBluetooth" : false,"AutoEnableBluetooth" : true,"BaudRate" : 115200,"Bits" : 8,"ComFile" : "1","IPAddress" : "192.168.0.166","IPPort" : 5555,"'  +

//'LibraryPath" : "","MACAddress" : "FF:FF:FF:FF:FF:FF","Model" : 62,"OfdChannel" : 0,"Parity" : 0,"Port" : 2,"StopBits" : 0,"UsbDevicePath" : "auto","UserPassword" : "30"}';















    fptr.setSettings(settings);
ShowMessage(settings);

fptr.open;

fptr.setParam(fptr.LIBFPTR_PARAM_DATA_TYPE, fptr.LIBFPTR_DT_STATUS);
fptr.queryData;

serialNumber    := fptr.getParamStr(fptr.LIBFPTR_PARAM_SERIAL_NUMBER);
shiftState      := fptr.getParamInt(fptr.LIBFPTR_PARAM_SHIFT_NUMBER);

    isCoverOpened           := fptr.getParamBool(fptr.LIBFPTR_PARAM_COVER_OPENED);


 ShowMessage('isCoverOpened ' + BoolToStr(isCoverOpened));


    fptr.setParam(fptr.LIBFPTR_PARAM_DATA_TYPE, fptr.LIBFPTR_DT_UNIT_VERSION);
    fptr.setParam(fptr.LIBFPTR_PARAM_UNIT_TYPE, fptr.LIBFPTR_UT_CONFIGURATION);
    fptr.queryData;

    configurationVersion := fptr.getParamString(fptr.LIBFPTR_PARAM_UNIT_VERSION);
    ShowMessage(configurationVersion);

    fptr.readModelFlags;
    ShowMessage('PARAM_CAP_54FZ ' + BoolToStr(fptr.getParamBool(fptr.LIBFPTR_PARAM_CAP_54FZ)));
    ShowMessage('MANUAL_CLICHE_CONTROL ' + BoolToStr(fptr.getParamBool(fptr.LIBFPTR_PARAM_CAP_MANUAL_CLICHE_CONTROL)));


{


//    fptr.setParam(fptr.LIBFPTR_PARAM_TEXT, '????????????');
//    fptr.printText;


    date := StrToDate('2018-01-01');
    fptr.setParam(1177, '???????????????? ?????????????????? ??????????????????');
    fptr.setParam(1178, date);
    fptr.setParam(1179, '???1234');
    fptr.utilFormTlv;
    correctionInfo := fptr.getParamByteArray(fptr.LIBFPTR_PARAM_TAG_VALUE);

    hex1174 :=  fptr.getParamString(fptr.LIBFPTR_PARAM_TAG_VALUE);
    ShowMessage(hex1174);


    fptr.setParam(fptr.LIBFPTR_PARAM_RECEIPT_TYPE, fptr.LIBFPTR_RT_SELL_CORRECTION);
    fptr.setParam(1173, 1);
//    fptr.setParam(1174, correctionInfo);
    fptr.setParamStrHex(1174, hex1174);
    fptr.openReceipt;


    fptr.setParam(fptr.LIBFPTR_PARAM_COMMODITY_NAME, '?????');
    fptr.setParam(fptr.LIBFPTR_PARAM_PRICE, 100);
    fptr.setParam(fptr.LIBFPTR_PARAM_QUANTITY, 5);
    fptr.setParam(fptr.LIBFPTR_PARAM_TAX_TYPE, fptr.LIBFPTR_TAX_VAT0);
    fptr.setParam(fptr.LIBFPTR_PARAM_USE_ONLY_TAX_TYPE, True);
    fptr.registration;


    fptr.setParam(fptr.LIBFPTR_PARAM_SUM, 500.00);
    fptr.receiptTotal;

    fptr.closeReceipt;
}

end;


procedure TForm1.Button2Click(Sender: TObject);
Var   Res: TDateTime;

    receiptType:           Longint;
    receiptNumber:  Longint;
    documentNumber: Longint;
    sum:            Double;
    remainder:      Double;
    change:         Double;
    isCoverOpened:           LongBool;
    dateTime:   TDateTime;
    dateTimest: string;

 begin
//    Res:= StrToDate('2018-01-01');
//    ShowMessage(DateToStr(res));
    fptr.showProperties(fptr.LIBFPTR_GUI_PARENT_NATIVE, '0');
    fptr.open;
    fptr.setParam(fptr.LIBFPTR_PARAM_DATA_TYPE, fptr.LIBFPTR_DT_RECEIPT_STATE);
    fptr.queryData;

    receiptType            := fptr.getParamInt(fptr.LIBFPTR_PARAM_RECEIPT_TYPE);
    receiptNumber   := fptr.getParamInt(fptr.LIBFPTR_PARAM_RECEIPT_NUMBER);
    documentNumber  := fptr.getParamInt(fptr.LIBFPTR_PARAM_DOCUMENT_NUMBER);
    sum             := fptr.getParamDouble(fptr.LIBFPTR_PARAM_RECEIPT_SUM);
    remainder       := fptr.getParamDouble(fptr.LIBFPTR_PARAM_REMAINDER);
    change          := fptr.getParamDouble(fptr.LIBFPTR_PARAM_CHANGE);


//    ShowMessage(IntToStr((receiptType)));


fptr.setParam(fptr.LIBFPTR_PARAM_DATA_TYPE, fptr.LIBFPTR_DT_STATUS);
fptr.queryData;


    isCoverOpened           := fptr.getParamBool(fptr.LIBFPTR_PARAM_COVER_OPENED);


    fptr.setParam(fptr.LIBFPTR_PARAM_DATA_TYPE, fptr.LIBFPTR_DT_SHIFT_STATE);
    fptr.queryData;

    dateTime    := fptr.getParamDateTime(fptr.LIBFPTR_PARAM_DATE_TIME);
    dateTimest    := fptr.getParamString(fptr.LIBFPTR_PARAM_DATE_TIME);


 ShowMessage('dateTime: ' + FormatDateTime('c', dateTime));
 ShowMessage('dateTime-st: ' + dateTimest);


 end;


procedure TForm1.Button3Click(Sender: TObject);
var
 t: Boolean;
begin
 t:= true;
 ShowMessage(BoolToStr(t, true));

end;

procedure TForm1.btndataTimeClick(Sender: TObject);

var
      state:      Longint;
    number:     Longint;
    dateTime:   TDateTime;
begin



    fptr.showProperties(fptr.LIBFPTR_GUI_PARENT_NATIVE, FindWindow('Form1',nil));
    fptr.open;

    fptr.showProperties(fptr.LIBFPTR_GUI_PARENT_NATIVE, '0');
    fptr.setParam(fptr.LIBFPTR_PARAM_DATA_TYPE, fptr.LIBFPTR_DT_SHIFT_STATE);
    fptr.queryData;

    state       := fptr.getParamInt(fptr.LIBFPTR_PARAM_SHIFT_STATE);
    number      := fptr.getParamInt(fptr.LIBFPTR_PARAM_SHIFT_NUMBER);
    dateTime    := fptr.getParamDateTime(fptr.LIBFPTR_PARAM_DATE_TIME);


    



end;


procedure TForm1.Button4Click(Sender: TObject);


var
    mark: String;
    status: Integer;
    validationResult: Integer;
begin


    fptr.showProperties(fptr.LIBFPTR_GUI_PARENT_NATIVE, FindWindow('Form1',nil));
    fptr.open;

    mark := '014494550435306821QXYXSALGLMYQQ\u001D91EE06\u001D92YWCXbmK6SN8vvwoxZFk7WAY8WoJNMGGr6Cgtiuja04c=';
    status := 2;

    // ?????????????????? ???????????????? ????
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE_TYPE, fptr.LIBFPTR_MCT12_AUTO);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE, mark);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE_STATUS, status);
    fptr.setParam(fptr.LIBFPTR_PARAM_QUANTITY, 1.000);
    fptr.setParam(fptr.LIBFPTR_PARAM_MEASUREMENT_UNIT, 0);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_WAIT_FOR_VALIDATION_RESULT, True);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_PROCESSING_MODE, 0);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_FRACTIONAL_QUANTITY, '1/2');
    fptr.beginMarkingCodeValidation;

    // ???????????????????? ?????????????????? ???????????????? ?? ???????????????????? ??????????????????
    while True do
    begin
        fptr.getMarkingCodeValidationStatus;
        if fptr.getParamBool(fptr.LIBFPTR_PARAM_MARKING_CODE_VALIDATION_READY) then
            break;
    end;
    validationResult := fptr.getParamInt(fptr.LIBFPTR_PARAM_MARKING_CODE_ONLINE_VALIDATION_RESULT);

    // ???????????????????????? ???????????????????? ???????????? ?? ?????????????????? ????
    fptr.acceptMarkingCode;

    // ... ?????????????????? ?????????????????? ????

    fptr.cancelReceipt;

    // ?????????????????? ??????
    fptr.setParam(fptr.LIBFPTR_PARAM_RECEIPT_TYPE, fptr.LIBFPTR_RT_SELL);
    fptr.openReceipt;

    fptr.setParam(fptr.LIBFPTR_PARAM_COMMODITY_NAME, '????????????');
    fptr.setParam(fptr.LIBFPTR_PARAM_PRICE, 80);
    fptr.setParam(fptr.LIBFPTR_PARAM_QUANTITY, 1.000);
    fptr.setParam(fptr.LIBFPTR_PARAM_MEASUREMENT_UNIT, 0);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_FRACTIONAL_QUANTITY, '1/2');
    fptr.setParam(fptr.LIBFPTR_PARAM_TAX_TYPE, fptr.LIBFPTR_TAX_VAT10);
    fptr.setParam(1212, 1);
    fptr.setParam(1214, 4);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE, mark);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE_STATUS, status);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE_ONLINE_VALIDATION_RESULT, validationResult);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_PROCESSING_MODE, 0);
    fptr.registration;

    // ... ???????????????????????? ?????????????????? ??????????????

    fptr.setParam(fptr.LIBFPTR_PARAM_SUM, 120);
    fptr.receiptTotal;

    fptr.setParam(fptr.LIBFPTR_PARAM_PAYMENT_TYPE, fptr.LIBFPTR_PT_CASH);
    fptr.setParam(fptr.LIBFPTR_PARAM_PAYMENT_SUM, 1000);
    fptr.payment;

    // ?????????? ?????????????????? ??????????????????, ?????? ?????? ???? ?????????????????????? (???? ????????????, ???????? ???????? ???????????????? ???? ?????? ???????????????? ????????????????????
    while True do
    begin
        fptr.checkMarkingCodeValidationsReady;
        if fptr.getParamBool(fptr.LIBFPTR_PARAM_MARKING_CODE_VALIDATION_READY) then
            break;
    end;

    fptr.closeReceipt;
end;


//var
//    cashSum: Double;
//begin
//    fptr.setParam(fptr.LIBFPTR_PARAM_DATA_TYPE, fptr.LIBFPTR_DT_CASH_SUM);
//    fptr.queryData;
//
//    cashSum := fptr.getParamDouble(fptr.LIBFPTR_PARAM_SUM);
//end;

procedure TForm1.Button5Click(Sender: TObject);


var
      //mark:     Array[0 .. 19] of Byte = ($52, $55, $2d, $34, $33, $30, $33, $30, $32, $2d, $41, $41, $41, $34, $30, $35, $30, $31, $30, $38);
      //mark: array[0 .. 19] of Byte;

      i:        Integer;
      mark_var: Variant;
     result: String;
        //result: widechar


      //const
    //command_byte_array:    Array[0 .. 19] of Byte = ($15, $20, $04, $41, $A9, $80, $EC, $16, $54, $54, $54, $30, $30, $30, $30, $30, $34, $39, $34, $39);

begin







    fptr := CreateOleObject('AddIn.Fptr10');
    fptr.setSingleSetting(fptr.LIBFPTR_SETTING_MODEL, IntToStr(fptr.LIBFPTR_MODEL_ATOL_AUTO));
    fptr.setSingleSetting(fptr.LIBFPTR_SETTING_PORT, IntToStr(fptr.LIBFPTR_PORT_COM));
    fptr.setSingleSetting(fptr.LIBFPTR_SETTING_COM_FILE, 'COM9');
    fptr.setSingleSetting(fptr.LIBFPTR_SETTING_BAUDRATE, IntToStr(fptr.LIBFPTR_PORT_BR_115200));
    fptr.applySingleSettings;

    //fptr.showProperties(fptr.LIBFPTR_GUI_PARENT_NATIVE, FindWindow('Form1',nil));
    fptr.open;

    fptr.showProperties(fptr.LIBFPTR_GUI_PARENT_NATIVE, '0');

    // ???????????????????? ?? ??????
    fptr.open;


//
//    fptr.setParam(fptr.LIBFPTR_PARAM_JSON_DATA, '');
//    fptr.processJson;
//
//    result := fptr.getParamString(fptr.LIBFPTR_PARAM_JSON_DATA);

//
    fptr.setParam(1021, '???????????? ???????????? ??.');
    fptr.setParam(1203, '123456789047');
    fptr.operatorLogin;

    fptr.setParam(fptr.LIBFPTR_PARAM_RECEIPT_TYPE, fptr.LIBFPTR_RT_SELL);
    fptr.openReceipt;

    fptr.setParam(fptr.LIBFPTR_PARAM_COMMODITY_NAME, '??????????');
    fptr.setParam(fptr.LIBFPTR_PARAM_PRICE, 100);
    fptr.setParam(fptr.LIBFPTR_PARAM_QUANTITY, 5.10);
    fptr.setParam(fptr.LIBFPTR_PARAM_TAX_TYPE, fptr.LIBFPTR_TAX_VAT0);
    fptr.setParam(fptr.LIBFPTR_PARAM_TAX_SUM, 510.00);

      mark_var := VarArrayCreate([0, high(mark)], varByte);
    for i := VarArrayLowBound(mark_var, 1) to VarArrayHighBound(mark_var, 1) do
    begin
        VarArrayPut(mark_var, mark[i], [i]);
    end;
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE, mark_var);

    fptr.registration;

    fptr.closeReceipt;

end;

procedure TForm1.Button6Click(Sender: TObject);


var
    mark: String;
    status: Integer;
    validationResult: Integer;
    result: Integer;
    error: Integer;
    info: Integer;
    processingResult: Integer;
    processingCode: Integer;
    ready: Boolean;
    isRequestSent: Boolean;
    errorDescription: String;


begin


    fptr.showProperties(fptr.LIBFPTR_GUI_PARENT_NATIVE, FindWindow('Form1',nil));
    fptr.open;



    fptr.cancelMarkingCodeValidation;

    sleep(100);



//    var
//    mark:     Array[30 31 30 31 32 33 34 35 36 37 38 39 30 31 32 33 32 31 4d 2c 37 61 4c 30 4a 44 47 62 4a 43 57 61 1d 39 31 38 30 38 42 1d 39 32 43 75 45 32 62 34 77 42 68 50 76 39 58 65 6f 42 51 44 45 75 78 39 77 4f 4b 65 4e 52 34 76 66 34 49 2b 71 2f 51 62 68 71 7a 68 52 47 79 59 51 79 6d 6b 6b 70 67 74 41 5a 55 74 50 48 6c 66 70 30 54 48 47 56 4e 36 69 2b 44 38 5a 78 5a 51 63 62 54 6e 76 45 4d 67 3d 3d] of Byte = (<???????????? ???????????? ???? ??????????????>);
//    mark_var: Variant;
//    i:        Integer;
//begin
//    fptr.setParam(fptr.LIBFPTR_PARAM_COMMODITY_NAME, '??????????');
//    fptr.setParam(fptr.LIBFPTR_PARAM_PRICE, 100);
//    fptr.setParam(fptr.LIBFPTR_PARAM_QUANTITY, 5.15);
//    fptr.setParam(fptr.LIBFPTR_PARAM_TAX_TYPE, fptr.LIBFPTR_TAX_VAT0);
//    fptr.setParam(fptr.LIBFPTR_PARAM_TAX_SUM, 51.5);
//    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE_TYPE, fptr.LIBFPTR_PARAM_PRODUCT_CODE);
//
//    mark_var := VarArrayCreate([0, high(mark)], varByte);
//    for i := VarArrayLowBound(mark_var, 1) to VarArrayHighBound(mark_var, 1) do
//    begin
//        VarArrayPut(mark_var, mark[i], [i]);
//    end;
//    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE, mark_var);
//
//    fptr.registration;
//end;

 //   mark:     Array[30 31 30 31 32 33 34 35 36 37 38 39 30 31 32 33 32 31 4d 2c 37 61 4c 30 4a 44 47 62 4a 43 57 61 1d 39 31 38 30 38 42 1d 39 32 43 75 45 32 62 34 77 42 68 50 76 39 58 65 6f 42 51 44 45 75 78 39 77 4f 4b 65 4e 52 34 76 66 34 49 2b 71 2f 51 62 68 71 7a 68 52 47 79 59 51 79 6d 6b 6b 70 67 74 41 5a 55 74 50 48 6c 66 70 30 54 48 47 56 4e 36 69 2b 44 38 5a 78 5a 51 63 62 54 6e 76 45 4d 67 3d 3d] of Byte = (<???????????? ???????????? ???? ??????????????>);

    mark := '01040130540087822170MB9XCDMRHRH' + #29 + '91FFD0' + #29 + '92dGVzdMVbL99yJzdm6AmsfbMoAmUmoxOJAubZE82ysVA=';
    status := 2;

    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE_TYPE, fptr.LIBFPTR_MCT12_AUTO);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE, mark);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE_STATUS, 2);
    fptr.setParam(fptr.LIBFPTR_PARAM_QUANTITY, 1.000);
    fptr.setParam(fptr.LIBFPTR_PARAM_MEASUREMENT_UNIT, 0);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_PROCESSING_MODE, 0);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_FRACTIONAL_QUANTITY, '1/2');
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_WAIT_FOR_VALIDATION_RESULT, True);

    fptr.beginMarkingCodeValidation;


      while True do
    begin
        fptr.getMarkingCodeValidationStatus;
        if fptr.getParamBool(fptr.LIBFPTR_PARAM_MARKING_CODE_VALIDATION_READY) then
            break;
    end;
    validationResult := fptr.getParamInt(fptr.LIBFPTR_PARAM_MARKING_CODE_ONLINE_VALIDATION_RESULT);

    //sleep(200);

//    // ???????????????????????? ???????????????????? ???????????? ?? ?????????????????? ????
    fptr.acceptMarkingCode;

   // fptr.getMarkingCodeValidationStatus();

//    fptr.showProperties(fptr.LIBFPTR_GUI_PARENT_NATIVE, '0');
//    mark := '014494550435306821QXYXSALGLMYQQ\u001D91EE06\u001D92YWCXbmK6SN8vvwoxZFk7WAY8WoJNMGGr6Cgtiuja04c=';
//    status := 2;

    // ?????????????????? ???????????????? ????
//    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE_TYPE, fptr.LIBFPTR_MCT12_AUTO);
//    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE, mark);
//    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE_STATUS, status);
//    fptr.setParam(fptr.LIBFPTR_PARAM_QUANTITY, 1.000);
//    fptr.setParam(fptr.LIBFPTR_PARAM_MEASUREMENT_UNIT, 0);
//    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_WAIT_FOR_VALIDATION_RESULT, True);
//    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_PROCESSING_MODE, 0);
//    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_FRACTIONAL_QUANTITY, '1/2');
//    fptr.beginMarkingCodeValidation();

    // ???????????????????? ?????????????????? ???????????????? ?? ???????????????????? ??????????????????
//    while True do
//    begin
//        fptr.getMarkingCodeValidationStatus();
//        if fptr.getParamBool(fptr.LIBFPTR_PARAM_MARKING_CODE_VALIDATION_READY) then
//            break;
//    end;
//    validationResult := fptr.getParamInt(fptr.LIBFPTR_PARAM_MARKING_CODE_ONLINE_VALIDATION_RESULT);
//
//    // ???????????????????????? ???????????????????? ???????????? ?? ?????????????????? ????
//    fptr.acceptMarkingCode();

    // ... ?????????????????? ?????????????????? ????

//    // ?????????????????? ??????

//

    ShowMessage(fptr.version);

    fptr.setParam(1021, '???????????? ???????????? ??.');
    fptr.setParam(1203, '123456789047');
    fptr.operatorLogin;

    fptr.setParam(fptr.LIBFPTR_PARAM_RECEIPT_TYPE, fptr.LIBFPTR_RT_SELL);
    fptr.openReceipt;


//    fptr.setParam(1228, '123456789047');
//    fptr.setParam(1262, '016');
//    fptr.setParam(1263, '24.09.2020');
//    fptr.setParam(1264, '8252');
//    fptr.setParam(1265, '????????????????');
//    fptr.writeSalesNotice;
////
//

    fptr.setParam(fptr.LIBFPTR_PARAM_COMMODITY_NAME, '????????????');
    fptr.setParam(fptr.LIBFPTR_PARAM_PRICE, 80);
    fptr.setParam(fptr.LIBFPTR_PARAM_QUANTITY, 1.000);

    fptr.setParam(fptr.LIBFPTR_PARAM_POSITION_SUM, 80.000);
    fptr.setParam(fptr.LIBFPTR_PARAM_MEASUREMENT_UNIT, 0);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_FRACTIONAL_QUANTITY, '1/2');
    fptr.setParam(fptr.LIBFPTR_PARAM_TAX_TYPE, fptr.LIBFPTR_TAX_VAT10);
    fptr.setParam(1212, 31);
    fptr.setParam(1214, 4);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE, mark);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE_STATUS, status);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_CODE_ONLINE_VALIDATION_RESULT, validationResult);
    fptr.setParam(fptr.LIBFPTR_PARAM_MARKING_PROCESSING_MODE, 0);
    fptr.registration;

    // ... ???????????????????????? ?????????????????? ??????????????

    fptr.setParam(fptr.LIBFPTR_PARAM_SUM, 120);
    fptr.receiptTotal;

    fptr.setParam(fptr.LIBFPTR_PARAM_PAYMENT_TYPE, fptr.LIBFPTR_PT_CASH);
    fptr.setParam(fptr.LIBFPTR_PARAM_PAYMENT_SUM, 1000);
    fptr.payment;

    // ?????????? ?????????????????? ??????????????????, ?????? ?????? ???? ?????????????????????? (???? ????????????, ???????? ???????? ???????????????? ???? ?????? ???????????????? ????????????????????
    while True do
             begin
        fptr.checkMarkingCodeValidationsReady;
        if fptr.getParamBool(fptr.LIBFPTR_PARAM_MARKING_CODE_VALIDATION_READY) then
            break;
             end;


    fptr.closeReceipt;







//    fptr.getMarkingCodeValidationStatus();
//    fptr.getParamBool(fptr.LIBFPTR_PARAM_MARKING_CODE_VALIDATION_READY);
//
//    validationResult := fptr.getParamInt(fptr.LIBFPTR_PARAM_MARKING_CODE_ONLINE_VALIDATION_RESULT);
//
//    // ???????????????????????? ???????????????????? ???????????? ?? ?????????????????? ????
//    fptr.acceptMarkingCode();




//
//    fptr.getMarkingCodeValidationStatus;
//    ready := fptr.getParamBool(fptr.LIBFPTR_PARAM_MARKING_CODE_VALIDATION_READY);
//    if ready then
//
//        result := fptr.getParamInt(fptr.LIBFPTR_PARAM_MARKING_CODE_ONLINE_VALIDATION_RESULT);
//        isRequestSent := fptr.getParamBool(fptr.LIBFPTR_PARAM_IS_REQUEST_SENT);
//        error := fptr.getParamInt(fptr.LIBFPTR_PARAM_MARKING_CODE_ONLINE_VALIDATION_ERROR);
//        errorDescription := fptr.getParamString(fptr.LIBFPTR_PARAM_MARKING_CODE_ONLINE_VALIDATION_ERROR_DESCRIPTION);
//        info := fptr.getParamInt(2109);
//        processingResult := fptr.getParamInt(2005);
//        processingCode := fptr.getParamInt(2105);

    end;



procedure TForm1.Button7Click(Sender: TObject);

begin
 date := StrToDateTime('20.02.2020 12:30:00');
    fptr.setParam(fptr.LIBFPTR_PARAM_DATE_TIME, date);
    fptr.writeDateTime;
end;

procedure TForm1.Button8Click(Sender: TObject);

var

   Result:Boolean;
   DoPrintDoc:Boolean;
   deviceFfdVersion:   Longint;
   fnFfdVersion:       Longint;
   maxFnFfdVersion:    Longint;
   ffdVersion:         Longint;
   maxFfdVersion:      Longint;
   minFfdVersion:      Longint;
   versionKKT:         Longint;

begin
    fptr.showProperties(fptr.LIBFPTR_GUI_PARENT_NATIVE, FindWindow('Form1',nil));
    fptr.open;


    for k := 1 to 1001 do


    begin

    fptr.setParam(fptr.LIBFPTR_PARAM_FN_DATA_TYPE, fptr.LIBFPTR_FNDT_FFD_VERSIONS);
    ffdVersion          := fptr.getParamInt(fptr.LIBFPTR_PARAM_FFD_VERSION);
    fptr.fnQueryData;
    deviceFfdVersion    := fptr.getParamInt(fptr.LIBFPTR_PARAM_DEVICE_FFD_VERSION);
    fnFfdVersion        := fptr.getParamInt(fptr.LIBFPTR_PARAM_FN_FFD_VERSION);
    maxFnFfdVersion     := fptr.getParamInt(fptr.LIBFPTR_PARAM_FN_MAX_FFD_VERSION);
    ffdVersion          := fptr.getParamInt(fptr.LIBFPTR_PARAM_FFD_VERSION);
    maxFfdVersion       := fptr.getParamInt(fptr.LIBFPTR_PARAM_DEVICE_MAX_FFD_VERSION);
    minFfdVersion       := fptr.getParamInt(fptr.LIBFPTR_PARAM_DEVICE_MIN_FFD_VERSION);
    versionKKT          := fptr.getParamInt(fptr.LIBFPTR_PARAM_VERSION);
    sleep(30);


    if fptr.checkDocumentClosed <> 0 then
    raise Exception.Create('???????????????? ?????????? ?? ??????, ?????????????????? ?????????????????? ????????????????????'); {  begin
    // ???? ?????????????? ?????????????????? ?????????????????? ??????????????????. ?????????????? ???????????????????????? ?????????? ????????????, ?????????????????? ?????????????????? ?????????????????? ?? ?????????????????? ????????????
    showmessage(fptr.errorDescription);
    Continue;
  end;}



// False - ???????????????? ???? ????????????????. ?????????????????? ?????? ???????????????? (???????? ?????? ??????) ?? ???????????????????????? ????????????
    Result     := fptr.getParamBool(fptr.LIBFPTR_PARAM_DOCUMENT_CLOSED);
    DoPrintDoc := not fptr.getParamBool(fptr.LIBFPTR_PARAM_DOCUMENT_PRINTED);
{      // ?????????? ?????????? ?????????????? ?????????? ?????????????????????????? ??????????????????, ???? ???????????????????? ?? ??????????????, ???????? ?????? ????????????????????
      While fptr.continuePrint <> 0 do
      begin
          // ???????? ???? ?????????????? ???????????????????? ???????????????? - ???????????????? ???????????????????????? ???????????? ?? ?????????????????????? ?????? ??????.
          showmessage('???? ?????????????? ???????????????????? ???????????????? (???????????? "' + fptr.errorDescription + '"). ?????????????????? ?????????????????? ?? ??????????????????.');
          Continue;
      end;}


    end;








//    Continue;











      fptr.close;
    fptr.destroy;

end;

end.

