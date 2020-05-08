xmlport 50000 "INT_ImportPayroll"
{
    Direction = Import;
    DefaultFieldsValidation = false;
    Format = VariableText;
    //UseRequestPage = false;
    UseRequestPage = true;
    FieldDelimiter = '';
    FieldSeparator = '|';

    schema
    {
        textelement(Root)
        {
            tableelement(GenJnlLine; "Gen. Journal Line")
            {
                //SourceTableView = SORTING(Description, "Shortcut Dimension 1 Code");
                SourceTableView = sorting("Journal Template Name", "Journal Batch Name", "Line No.");
                textelement(Field01)
                {
                }
                textelement(Field02)
                {
                }
                textelement(Field03)
                {
                }
                textelement(Field04)
                {
                }
                textelement(GlobalDimension1)
                {
                }
                textelement(ShortcutDim4)
                {
                }
                textelement(Field07)
                {
                }
                textelement(Field08)
                {
                }
                textelement(Field09)
                {
                }


                trigger OnBeforeInsertRecord()
                begin


                    Clear(AVGenJnlLine);
                    AVGenJnlLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                    AVGenJnlLine.SetRange("Journal Template Name", 'JV-PAYROLL');
                    AVGenJnlLine.SetRange("Journal Batch Name", 'JV-JP');
                    if AVGenJnlLine.FindLast then begin
                        LineNo := AVGenJnlLine."Line No.";
                    end;


                    LineNo += 10000;
                    GenJnlLine."Line No." := LineNo;

                    GenJnlLine."Journal Template Name" := 'JV-PAYROLL';
                    GenJnlLine."Journal Batch Name" := 'JV-JP';

                    //GenJnlLine."Document No." := NoSeriesMgt.GetNextNo('JV-JP', GenJnlLine."Posting Date", false);
                    //GenJnlLine."Document No." := AVGenJnlLine."Document No.";
                    GenJnlLine."Document No." := AVDocumentNo;


                    if EVALUATE(FieldYear, Field03) then;
                    if EVALUATE(FieldMonth, Field04) then;
                    if EVALUATE(FieldAmount, Field08) then;
                    RefDate := DMY2Date(1, FieldMonth, FieldYear);
                    GenJnlLine."Posting Date" := CALCDATE('<CM>', RefDate);

                    GenJnlLine.Validate(Amount, FieldAmount);
                    DimPayroll := ShortcutDim4;
                    GenJnlLine."External Document No." := DimPayroll;

                    //if GenJnlLine."Shortcut Dimension 1 Code" = '' then
                    //    Error('Dimension must not be blank : %1', ShortcutDim4);


                    //ถ้าเป็น account เดียวกันให้ skip แล้ว sum amount 
                    Clear(AVGenJnlLineCheck);
                    AVGenJnlLineCheck.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                    AVGenJnlLineCheck.SetRange("Journal Template Name", 'JV-PAYROLL');
                    AVGenJnlLineCheck.SetRange("Journal Batch Name", 'JV-JP');
                    AVGenJnlLineCheck.SetRange(Description, DimPayroll);
                    AVGenJnlLineCheck.SetRange(AVGenJnlLineCheck."Shortcut Dimension 1 Code", GlobalDimension1);
                    //AVGenJnlLineCheck.SetRange(AVGenJnlLineCheck."Account No.", GenJnlLine."Account No.");
                    if AVGenJnlLineCheck.FindFirst() then begin

                        //sumAmount += FieldAmount;
                        //AVGenJnlLineCheck.Validate(Amount, sumAmount);

                        if CopyStr(DimPayroll, 1, 3) <> 'SUM' then begin
                            AVGenJnlLineCheck.Amount += FieldAmount;
                            AVGenJnlLineCheck."Debit Amount" += FieldAmount;
                        end else begin
                            AVGenJnlLineCheck.Amount += FieldAmount * -1;
                            AVGenJnlLineCheck."Credit Amount" += FieldAmount * -1;

                        end;

                        AVGenJnlLineCheck.Modify;
                        currXMLport.Skip();
                    end;
                    //C-ถ้าเป็น account เดียวกันให้ skip แล้ว sum amount



                    if CopyStr(DimPayroll, 1, 3) <> 'SUM' then
                        GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                    //if CopyStr(DimPayroll, 1, 2) = 'ZE' then    //ZE* ไม่ต้องออก 05/02/2020
                    //    currXMLport.Skip();
                    //if CopyStr(DimPayroll, 1, 2) = 'PF' then    //PF* ไม่ต้องออก
                    //    currXMLport.Skip();
                    //Map Account
                    case DimPayroll of
                        //NET, TAX : ไม่มีการบันทึกบัญชี
                        'NET':
                            currXMLport.Skip();
                        //'SUM_SOC':
                        //    currXMLport.Skip();
                        //'TAX':                        //AVPKJINT.001 29/01/2020 comment code
                        //    currXMLport.Skip();
                        //'PF':                         //AVPKJINT.001 29/01/2020 comment code
                        //    currXMLport.Skip();
                        //NET, TAX : ไม่มีการบันทึกบัญชี


                        //AVPKJINT.001 29/01/2020
                        'SUM_PF':
                            currXMLport.Skip();
                        //'SUM_PFC':
                        //    currXMLport.Skip();
                        //'SUM_SOC':
                        //    currXMLport.Skip();
                        'SUM_TAX':
                            currXMLport.Skip();
                        //C-AVPKJINT.001 29/01/2020

                        //AVPKJINT.001 05/02/2020
                        'SUM_ZE04':
                            currXMLport.Skip();
                        'SUM_ZE31':
                            currXMLport.Skip();
                        'SUM_ZE62':
                            currXMLport.Skip();
                        'SUM_ZE80':
                            currXMLport.Skip();
                        'SUM_ZE81':
                            currXMLport.Skip();
                        'SUM_ZE82':
                            currXMLport.Skip();
                        'SUM_ZE93':
                            currXMLport.Skip();
                        'SUM_ZEAF':
                            currXMLport.Skip();
                        'SUM_ZEAP':
                            currXMLport.Skip();
                        'SUM_ZEX2':
                            currXMLport.Skip();
                        'SUM_ZE92':
                            currXMLport.Skip();
                        'SUM_ZE18':
                            currXMLport.Skip();
                        'SUM_ZE24':
                            currXMLport.Skip();
                        //C-AVPKJINT.001 05/02/2020

                        'PF':
                            begin
                                //GenJnlLine."Account No." := '4102006';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('PF');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('PF'));
                                GenJnlLine.Description := GetDescFromDimValue('PF');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                            end;

                        'PFC':
                            begin
                                //GenJnlLine."Account No." := '4102006';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('PFC');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('PFC'));
                                GenJnlLine.Description := GetDescFromDimValue('PFC');
                            end;

                        'SAL':
                            begin
                                //GenJnlLine."Account No." := '4101001';
                                if Field01 = '02' then
                                    //GenJnlLine."Account No." := GetGLAcc2FromDimValue('SAL')
                                    GenJnlLine.validate("Account No.", GetGLAcc2FromDimValue('SAL'))
                                else
                                    //GenJnlLine."Account No." := GetGLAccFromDimValue('SAL');
                                    GenJnlLine.validate("Account No.", GetGLAccFromDimValue('SAL'));

                                GenJnlLine.Description := GetDescFromDimValue('SAL');
                            end;

                        'SOC':
                            begin
                                //GenJnlLine."Account No." := '4102007';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('SOC');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('SOC'));
                                GenJnlLine.Description := GetDescFromDimValue('SOC');
                            end;

                        'TAX':
                            begin
                                //GenJnlLine."Account No." := '4102007';
                                if Field01 = '02' then
                                    //GenJnlLine."Account No." := GetGLAcc2FromDimValue('TAX')
                                    GenJnlLine.validate("Account No.", GetGLAcc2FromDimValue('TAX'))
                                else
                                    //GenJnlLine."Account No." := GetGLAccFromDimValue('TAX');
                                    GenJnlLine.validate("Account No.", GetGLAccFromDimValue('TAX'));
                                GenJnlLine.Description := GetDescFromDimValue('TAX');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                            end;

                        /* //เปลี่ยนเป็น ZA*
                        'ZA00':
                            begin
                                //GenJnlLine."Account No." := '4101006';
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZA00'));
                                GenJnlLine.Description := GetDescFromDimValue('ZA00');
                            end;
                        'ZA35':
                            begin
                                //GenJnlLine."Account No." := '4101008';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZA35');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZA35'));
                                GenJnlLine.Description := GetDescFromDimValue('ZA35');
                            end;
                        'ZA90':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZA90');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZA90'));
                                GenJnlLine.Description := GetDescFromDimValue('ZA90');
                            end;
                        'ZA99':
                            begin

                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZA99'));
                                GenJnlLine.Description := GetDescFromDimValue('ZA99');
                            end;
                        'ZABF':
                            begin
                                //GenJnlLine."Account No." := '4101008';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZABF');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZABF'));
                                GenJnlLine.Description := GetDescFromDimValue('ZABF');
                            end;
                        'ZABN':
                            begin
                                //GenJnlLine."Account No." := '4101008';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZABN');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZABN'));
                                GenJnlLine.Description := GetDescFromDimValue('ZABN');
                            end;
                        'ZA73':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZA73');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZA73'));
                                GenJnlLine.Description := GetDescFromDimValue('ZA73');
                            end;
                        */


                        /* //เปลี่ยนเป็น ZE*
                        'ZE04':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZE04');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZE04'));
                                GenJnlLine.Description := GetDescFromDimValue('ZE04');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);

                            end;
                        'ZEAF':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZEAF');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZEAF'));
                                GenJnlLine.Description := GetDescFromDimValue('ZEAF');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                            end;
                        'ZEAP':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZEAP');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZEAP'));
                                GenJnlLine.Description := GetDescFromDimValue('ZEAP');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                            end;
                        'ZEX2':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZEX2');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZEX2'));
                                GenJnlLine.Description := GetDescFromDimValue('ZEX2');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                            end;
                        'ZE31':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZE31');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZE31'));
                                GenJnlLine.Description := GetDescFromDimValue('ZE31');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                            end;
                        'ZE62':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZE62');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZE62'));
                                GenJnlLine.Description := GetDescFromDimValue('ZE62');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                            end;
                        'ZE80':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZE80');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZE80'));
                                GenJnlLine.Description := GetDescFromDimValue('ZE80');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                            end;
                        'ZE81':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZE81');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZE81'));
                                GenJnlLine.Description := GetDescFromDimValue('ZE81');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                            end;
                        'ZE82':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZE82');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZE82'));
                                GenJnlLine.Description := GetDescFromDimValue('ZE82');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                            end;
                        'ZE93':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZE93');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZE93'));
                                GenJnlLine.Description := GetDescFromDimValue('ZE93');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                            end;
                        'ZE92':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZE92');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZE92'));
                                GenJnlLine.Description := GetDescFromDimValue('ZE92');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                            end;
                        'ZE18':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZE18');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZE18'));
                                GenJnlLine.Description := GetDescFromDimValue('ZE18');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                            end;
                        'ZE24':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZE24');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZE24'));
                                GenJnlLine.Description := GetDescFromDimValue('ZE24');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                            end;
                        */
                        'ZS01':
                            begin
                                //GenJnlLine."Account No." := '4101009';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZS01');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZS01'));
                                GenJnlLine.Description := GetDescFromDimValue('ZS01');
                            end;
                        'ZS02':
                            begin
                                //GenJnlLine."Account No." := '4102009';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZS02');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZS02'));
                                GenJnlLine.Description := GetDescFromDimValue('ZS02');
                            end;
                        'ZS03':
                            begin
                                //GenJnlLine."Account No." := '4104002';
                                // GenJnlLine."Account No." := GetGLAccFromDimValue('ZS03');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZS03'));
                                GenJnlLine.Description := GetDescFromDimValue('ZS03');
                            end;
                        'ZS04':
                            begin
                                //GenJnlLine."Account No." := '4306003';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZS04');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZS04'));
                                GenJnlLine.Description := GetDescFromDimValue('ZS04');
                            end;
                        'ZS06':
                            begin
                                //GenJnlLine."Account No." := '4102009';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZS06');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZS06'));
                                GenJnlLine.Description := GetDescFromDimValue('ZS06');
                            end;
                        'ZW00':
                            begin
                                //GenJnlLine."Account No." := '4101003';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZW00');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZW00'));
                                GenJnlLine.Description := GetDescFromDimValue('ZW00');
                            end;

                        /* //เปลี่ยนเป็น ZA*
                        'ZABB':
                            begin
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('ZABB');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('ZABB'));
                                GenJnlLine.Description := GetDescFromDimValue('ZABB');
                            end;
                        */
                        'SUM_NET_BBL':
                            begin
                                //GenJnlLine."Account No." := '0113003';
                                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
                                //GenJnlLine."Account No." := 'BBL-SA02';
                                GenJnlLine.validate("Account No.", 'BBL-SA02');
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('SUM_NET_BBL');
                                GenJnlLine.Description := GetDescFromDimValue('SUM_NET_BBL');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                                GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                                GenJnlLine."AVF_Type of Payment" := GenJnlLine."AVF_Type of Payment"::Transfer;
                            end;
                        'SUM_NET_KBANK':
                            begin
                                //GenJnlLine."Account No." := '0112020';
                                GenJnlLine."Account Type" := GenJnlLine."Account Type"::"Bank Account";
                                //GenJnlLine."Account No." := 'KBANK-CA01';
                                GenJnlLine.validate("Account No.", 'KBANK-CA01');
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('SUM_NET_KBANK');
                                GenJnlLine.Description := GetDescFromDimValue('SUM_NET_KBANK');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                                GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                                GenJnlLine."AVF_Type of Payment" := GenJnlLine."AVF_Type of Payment"::Transfer;
                            end;

                        /*
                        'SUM_ZE04':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                GenJnlLine."Account No." := GetGLAccFromDimValue('SUM_ZE04');
                                GenJnlLine.Description := GetDescFromDimValue('SUM_ZE04');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                                GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                            end;
                        'SUM_ZE31':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                GenJnlLine."Account No." := GetGLAccFromDimValue('SUM_ZE31');
                                GenJnlLine.Description := GetDescFromDimValue('SUM_ZE31');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                                GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                            end;
                        'SUM_ZE62':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                GenJnlLine."Account No." := GetGLAccFromDimValue('SUM_ZE62');
                                GenJnlLine.Description := GetDescFromDimValue('SUM_ZE62');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                                GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                            end;
                        'SUM_ZE80':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                GenJnlLine."Account No." := GetGLAccFromDimValue('SUM_ZE80');
                                GenJnlLine.Description := GetDescFromDimValue('SUM_ZE80');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                                GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                            end;
                        'SUM_ZE82':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                GenJnlLine."Account No." := GetGLAccFromDimValue('SUM_ZE82');
                                GenJnlLine.Description := GetDescFromDimValue('SUM_ZE82');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                                GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                            end;
                        'SUM_ZE93':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                GenJnlLine."Account No." := GetGLAccFromDimValue('SUM_ZE93');
                                GenJnlLine.Description := GetDescFromDimValue('SUM_ZE93');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                                GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                            end;
                        'SUM_ZEAF':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                GenJnlLine."Account No." := GetGLAccFromDimValue('SUM_ZEAF');
                                GenJnlLine.Description := GetDescFromDimValue('SUM_ZEAF');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                                GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                            end;
                        'SUM_ZEX2':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                GenJnlLine."Account No." := GetGLAccFromDimValue('SUM_ZEX2');
                                GenJnlLine.Description := GetDescFromDimValue('SUM_ZEX2');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                                GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                            end;
                        */
                        /*   
                       'SUM_PF':
                           begin
                               //GenJnlLine."Account No." := '1160034';
                               GenJnlLine."Account No." := GetGLAccFromDimValue('SUM_PF');
                               GenJnlLine.Description := GetDescFromDimValue('SUM_PF');
                               GenJnlLine.Validate(Amount, FieldAmount * -1);
                               GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                           end;
                        */
                        'SUM_PFC':
                            begin
                                //GenJnlLine."Account No." := '1160034';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('SUM_PFC');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('SUM_PFC'));
                                GenJnlLine.Description := GetDescFromDimValue('SUM_PFC');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                                //GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                                GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                            end;

                        /*
                        'SUM_ZE92':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                GenJnlLine."Account No." := GetGLAccFromDimValue('SUM_ZE92');
                                GenJnlLine.Description := GetDescFromDimValue('SUM_ZE92');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                                GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                            end;
                        'SUM_ZE18':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                GenJnlLine."Account No." := GetGLAccFromDimValue('SUM_ZE18');
                                GenJnlLine.Description := GetDescFromDimValue('SUM_ZE18');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                                GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                            end;
                        'SUM_ZE24':
                            begin
                                //GenJnlLine."Account No." := '0152002';
                                GenJnlLine."Account No." := GetGLAccFromDimValue('SUM_ZE24');
                                GenJnlLine.Description := GetDescFromDimValue('SUM_ZE24');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                                GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                            end;
                        */

                        /*
                        'SUM_TAX':
                            begin
                                //GenJnlLine."Account No." := '1160204';
                                GenJnlLine."Account No." := GetGLAccFromDimValue('SUM_TAX');
                                GenJnlLine.Description := GetDescFromDimValue('SUM_TAX');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                                GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                            end;
                        */
                        'SUM_SOC':
                            begin
                                //GenJnlLine."Account No." := '1160038';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('SUM_SOC');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('SUM_SOC'));
                                GenJnlLine.Description := GetDescFromDimValue('SUM_SOC');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                                GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                            end;

                        'SUM_ZABB':
                            begin
                                //GenJnlLine."Account No." := '1160038';
                                //GenJnlLine."Account No." := GetGLAccFromDimValue('SUM_ZABB');
                                GenJnlLine.validate("Account No.", GetGLAccFromDimValue('SUM_ZABB'));
                                GenJnlLine.Description := GetDescFromDimValue('SUM_ZABB');
                                GenJnlLine.Validate(Amount, FieldAmount * -1);
                                GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);
                            end;

                    end;

                    if CopyStr(DimPayroll, 1, 2) = 'ZE' then begin
                        GenJnlLine.validate("Account No.", GetGLAccFromDimValue(DimPayroll));
                        GenJnlLine.Description := GetDescFromDimValue(DimPayroll);
                        GenJnlLine.Validate(Amount, FieldAmount * -1);
                    end;

                    if CopyStr(DimPayroll, 1, 2) = 'ZA' then begin
                        GenJnlLine.validate("Account No.", GetGLAccFromDimValue(DimPayroll));
                        GenJnlLine.Description := GetDescFromDimValue(DimPayroll);

                    end;

                    //if GenJnlLine."External Document No." <> 'PF' then
                    GenJnlLine.Validate("Shortcut Dimension 1 Code", GlobalDimension1);
                    GenJnlLine.ValidateShortcutDimCode(4, DimPayroll);

                    //if GenJnlLine.Description = '' then
                    //    Error('Dimension must not be blank : %1', ShortcutDim4);


                end;

            }
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(Additional; Additional)
                    {
                        Caption = 'Import เพิ่มเติม';
                        ApplicationArea = Basic, Suite;
                    }
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {

                }
            }
        }
    }

    trigger OnPreXmlPort()
    begin
        /*
        Clear(AVGenJnlLine);
        AVGenJnlLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
        AVGenJnlLine.SetRange("Journal Template Name", 'JV-PAYROLL');
        AVGenJnlLine.SetRange("Journal Batch Name", 'JV-JP');
        if AVGenJnlLine.FindFirst then begin
            //AVGenJnlLine."Document No." := NoSeriesMgt.GetNextNo('JV-JP', GenJnlLine."Posting Date", false);
            //Error('The record in table Gen. Journal Line already exists. Identification fields and values: Journal Template Name=%1,Journal Batch Name=%2', AVGenJnlLine."Journal Template Name", AVGenJnlLine."Journal Batch Name");
        end else begin
            AVGenJnlLine."Document No." := NoSeriesMgt.GetNextNo('JV-JP', GenJnlLine."Posting Date", false);
        end;
        */
        if Additional then
            //AVDocumentNo := AVDocumentNo
            AVDocumentNo := NoSeriesMgt.GetNextNo('JV-JP', GenJnlLine."Posting Date", false)
        else
            AVDocumentNo := NoSeriesMgt.GetNextNo('JV-JP', GenJnlLine."Posting Date", false);


    end;

    trigger OnPostXmlPort()
    begin
        MESSAGE('Import Payroll Complete.');
    end;

    procedure GetGLAccFromDimValue(DimCode: Code[20]): Code[20];
    begin
        Clear(AVDimValue);
        AVDimValue.SetCurrentKey("Dimension Code", Code);
        AVDimValue.SetRange("Dimension Code", 'PAYROLL TYPE');
        AVDimValue.SetRange(Code, DimCode);
        if AVDimValue.FindFirst then;
        AVDimValue.TestField(INT_GLAccoutNo);
        exit(AVDimValue.INT_GLAccoutNo);
    end;

    procedure GetGLAcc2FromDimValue(DimCode: Code[20]): Code[20];
    begin
        Clear(AVDimValue);
        AVDimValue.SetCurrentKey("Dimension Code", Code);
        AVDimValue.SetRange("Dimension Code", 'PAYROLL TYPE');
        AVDimValue.SetRange(Code, DimCode);
        if AVDimValue.FindFirst then;
        AVDimValue.TestField(INT_GLAccoutNo2);
        exit(AVDimValue.INT_GLAccoutNo2);
    end;

    procedure GetDescFromDimValue(DimCode: Code[50]): Code[50];
    begin
        Clear(AVDimValue);
        AVDimValue.SetCurrentKey("Dimension Code", Code);
        AVDimValue.SetRange("Dimension Code", 'PAYROLL TYPE');
        AVDimValue.SetRange(Code, DimCode);
        if AVDimValue.FindFirst then;
        exit(AVDimValue.Name + ' ' + Format(DATE2DMY(GenJnlLine."Posting Date", 2)) + '/' + Format(DATE2DMY(WorkDate, 3)));
    end;


    var
        AVGenJnlLine: Record "Gen. Journal Line";
        AVGenJnlLineCheck: Record "Gen. Journal Line";
        AVDimValue: Record "Dimension Value";
        LineNo: Integer;
        FieldYear: Integer;
        FieldMonth: Integer;
        FieldAmount: Decimal;
        RefDate: Date;
        DimPayroll: code[20];
        NoSeriesMgt: Codeunit NoSeriesManagement;
        OldDescription: code[30];
        OldCostCenter: Code[20];
        sumAmount: Decimal;
        AVDocumentNo: Code[30];
        Additional: Boolean;



}

