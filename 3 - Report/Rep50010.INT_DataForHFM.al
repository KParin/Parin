report 50010 "INT_Data For HFM"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/DataForHFM.rdl';
    Caption = 'Data for HFM';

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.") WHERE("Account Type" = CONST(Posting));
            RequestFilterFields = "No.", "Account Type", "Global Dimension 1 Filter", "Global Dimension 2 Filter";

            column(STRSUBSTNO_Text000_PeriodText_; STRSUBSTNO(Text000, PeriodText))
            {
            }
            column(PrintDate; FORMAT(TODAY, 0, 1) + ' ' + FORMAT(TIME, 0, '<Hours12>:<Minutes,2>:<Second,2> <AM/PM>'))
            {
            }
            column(COMPANYNAME; companyinfo.Name)
            {
            }
            column(PeriodText; PeriodText)
            {
            }
            column(G_L_Account__TABLECAPTION__________GLFilter; TABLECAPTION + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(G_L_Account_No_; "No.")
            {
            }
            column(GLAccNoAndDepCode; GLAccNoAndDepCode + FixBlank2)
            {
            }
            column(GLAccNo; "G/L Account"."No.")
            {
            }
            column(SCC; 'SCC' + FixBlank1)
            {
            }
            column(FixBlank1; FixBlank1)
            {
            }
            column(FixBlankInt1; FixBlankInt1)
            {
            }
            column(Trial_BalanceCaption; Trial_BalanceCaptionLbl)
            {
            }
            column(CurrReport_PAGENOCaption; CurrReport_PAGENOCaptionLbl)
            {
            }
            column(Net_ChangeCaption; Net_ChangeCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(G_L_Account___No__Caption; FIELDCAPTION("No."))
            {
            }
            column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaption; PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl)
            {
            }
            column(G_L_Account___Net_Change_Caption; G_L_Account___Net_Change_CaptionLbl)
            {
            }
            column(G_L_Account___Net_Change__Control22Caption; G_L_Account___Net_Change__Control22CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date_Caption; G_L_Account___Balance_at_Date_CaptionLbl)
            {
            }
            column(G_L_Account___Balance_at_Date__Control24Caption; G_L_Account___Balance_at_Date__Control24CaptionLbl)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(StartBalanceDr; StartBalanceDr)
            {
            }
            column(StartBalanceCr; StartBalanceCr)
            {
            }
            column(BalDr; BalDr)
            {
            }
            column(BalCr; BalCr)
            {
            }
            column(ShowZero; ShowZero)
            {
            }
            column(GrantTotal1; SumNetDr)
            {
            }
            column(GrantTotal2; SumNetCr)
            {
            }
            column(GrantTotal3; SumBalDr)
            {
            }
            column(GrantTotal4; SumBalCr)
            {
            }
            column(PrintToExcel; PrintToExcel)
            {
            }
            column(CostOption; FORMAT(CostOption))
            {
            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {
            }
            column(Net_Change; "Net Change")
            {
            }
            column(CountAccount; CountAccount)
            {
            }

            dataitem(Integer; Integer)
            {
                DataItemTableView = SORTING(Number);
                DataItemLinkReference = "G/L Account";
                column(DimValue_Site_Code; TraddingPartnersCode)
                {
                }
                column(FilterGlobal2Code; FilterGlobal2Code)
                {
                }
                column(FilterGlobal2CodeShow; FilterGlobal2CodeShow + FixBlank3)
                {
                }
                column(FilterDepCode; FilterDepCode)
                {
                }
                column(Net_ChangeShow; FixBlank4 + Net_ChangeShow)
                {
                }
                column(G_L_Account___No__; "G/L Account"."No.")
                {
                }
                column(PADSTR_____G_L_Account__Indentation___2___G_L_Account__Name; PADSTR('', "G/L Account".Indentation * 2) + "G/L Account".Name)
                {
                }
                column(G_L_Account___Net_Change_; "G/L Account"."Net Change")
                {
                }
                column(G_L_Account___Net_Change__Control22; -"G/L Account"."Net Change")
                {
                }
                column(G_L_Account___Balance_at_Date_; "G/L Account"."Balance at Date")
                {
                }
                column(G_L_Account___Balance_at_Date__Control24; -"G/L Account"."Balance at Date")
                {
                }
                column(G_L_Account___Account_Type_; FORMAT("G/L Account"."Account Type", 0, 2))
                {
                }
                column(No__of_Blank_Lines; "G/L Account"."No. of Blank Lines")
                {
                }
                column(Sign; Sign)
                {
                }

                dataitem(BlankLineRepeater; Integer)
                {
                    DataItemTableView = SORTING(Number);
                    DataItemLinkReference = Integer;
                    column(BlankLineNo; BlankLineNo)
                    {
                    }

                    trigger OnAfterGetRecord()
                    begin
                        IF BlankLineNo = 0 THEN
                            CurrReport.BREAK;
                        BlankLineNo -= 1;
                    end;
                }

                trigger OnPreDataItem()
                begin
                    CLEAR(GLNo);
                    CLEAR(CountAccount);
                    CLEAR(CountDep);
                    TmpDimValue_Dep.SETCURRENTKEY(TmpDimValue_Dep."Dimension Code");
                    TmpDimValue_Dep.SETRANGE(TmpDimValue_Dep."Dimension Code", 'COST CENTER');
                    IF TmpDimValue_Dep.FINDFIRST THEN
                        CountDep := TmpDimValue_Dep.COUNT;

                    CountDep += 1;
                    SETRANGE(Number, 1, CountDep);

                    /*
                    Clear(i);
                    Clear(FixBlank1);
                    Clear(FixBlankInt1);
                    FixBlankInt1 := 1;
                    repeat
                        i += 1;
                        FixBlank1 += '-';
                    until i >= FixBlankInt1;

                    Clear(j);
                    Clear(FixBlank2);
                    Clear(FixBlankInt2);
                    GLAccNoAndDepCode := "G/L Account"."No." + FilterDepCode;
                    FixBlankInt2 := 17 - StrLen(GLAccNoAndDepCode);
                    repeat
                        j += 1;
                        FixBlank2 += '-';
                    until j >= FixBlankInt2;

                    Clear(k);
                    Clear(FixBlank3);
                    Clear(FixBlankInt3);
                    FilterGlobal2CodeShow :=
                    FixBlankInt3 := 4 - StrLen(FilterGlobal2CodeShow);
                    repeat
                        k += 1;
                        FixBlank3 += '-';
                    until k >= FixBlankInt3;
                    Message('FixBlankInt3 : %1', FixBlankInt3);

                    Clear(l);
                    Clear(FixBlank4);
                    Clear(FixBlankInt4);
                    "G/L Account".CALCFIELDS("Net Change");
                    Net_ChangeShow := FORMAT(ABS("G/L Account"."Net Change"), 0, '<Integer><Decimals,3>');
                    //Message('len Net_ChangeShow : %1', StrLen(Net_ChangeShow));
                    FixBlankInt4 := 17 - StrLen(Net_ChangeShow);
                    repeat
                        l += 1;
                        FixBlank4 += '-';
                    until l >= FixBlankInt4;
                    Message('FixBlankInt4 : %1', FixBlankInt4);
                    */

                end;

                trigger OnAfterGetRecord()
                begin
                    CountAccount += 1;

                    CLEAR(FilterDepCode);
                    CLEAR(FilterGlobal2Code);
                    Clear(FilterGlobal2CodeShow);


                    /*
                    if (CopyStr("G/L Account"."No.", 1, 1) = '0') or (CopyStr("G/L Account"."No.", 1, 1) = '1') then begin
                        FilterDepCode := '';
                        FilterGlobal2Code := '';
                    end;
                    */


                    IF CountAccount = 1 THEN begin
                        FilterDepCode := '';
                        //Net_ChangeShow := '111111';
                        "G/L Account".SETRANGE("G/L Account"."Global Dimension 1 Filter", FilterDepCode);
                        "G/L Account".SETRANGE("G/L Account"."Global Dimension 2 Filter", FilterGlobal2Code);
                        "G/L Account".CALCFIELDS("Net Change", "Balance at Date");
                        Net_ChangeShow := FORMAT(ABS("G/L Account"."Net Change"), 0, '<Integer><Decimals,3>');

                        if "G/L Account"."Net Change" < 0 then
                            Sign := '-'
                        else
                            Sign := '';
                    end ELSE
                        IF CountAccount = 2 THEN BEGIN
                            FilterDepCode := TmpDimValue_Dep.Name;
                            FilterGlobal2Code := TmpDimValue_Dep."INT_External Document No.";


                            //FilterGlobal2CodeShow := FilterGlobal2Code;
                            if (COPYSTR(FORMAT("G/L Account"."No."), 1, 1) = '2')
                                or (COPYSTR(FORMAT("G/L Account"."No."), 1, 1) = '3')
                                or (COPYSTR(FORMAT("G/L Account"."No."), 1, 1) = '4') then begin

                                if FilterGlobal2Code = '' then
                                    FilterGlobal2CodeShow := 'ZZZZ'
                                else
                                    FilterGlobal2CodeShow := Copystr(FilterGlobal2Code, 1, 4);

                            end else
                                FilterGlobal2CodeShow := Copystr(FilterGlobal2Code, 1, 4);

                            //Net_ChangeShow := '9999';
                            "G/L Account".CALCFIELDS("Net Change", "Balance at Date");
                            Net_ChangeShow := FORMAT(ABS("G/L Account"."Net Change"), 0, '<Integer><Decimals,3>');

                            if "G/L Account"."Net Change" < 0 then
                                Sign := '-'
                            else
                                Sign := '';
                        END ELSE
                            IF CountAccount > 2 THEN BEGIN


                                TmpDimValue_Dep.NEXT;
                                FilterDepCode := TmpDimValue_Dep.Name;
                                FilterGlobal2Code := TmpDimValue_Dep."INT_External Document No.";
                                //FilterGlobal2CodeShow := FilterGlobal2Code;
                                if (COPYSTR(FORMAT("G/L Account"."No."), 1, 1) = '2')
                                or (COPYSTR(FORMAT("G/L Account"."No."), 1, 1) = '3')
                                or (COPYSTR(FORMAT("G/L Account"."No."), 1, 1) = '4') then begin

                                    if FilterGlobal2Code = '' then
                                        FilterGlobal2CodeShow := 'ZZZZ'
                                    else
                                        FilterGlobal2CodeShow := Copystr(FilterGlobal2Code, 1, 4);
                                END else
                                    FilterGlobal2CodeShow := Copystr(FilterGlobal2Code, 1, 4);

                                //AVPKJINT 19/02/2020
                                //if (CopyStr("G/L Account"."No.", 1, 1) <> '0') and (CopyStr("G/L Account"."No.", 1, 1) <> '1') then begin
                                "G/L Account".SETRANGE("G/L Account"."Global Dimension 1 Filter", FilterDepCode);
                                "G/L Account".SETRANGE("G/L Account"."Global Dimension 2 Filter", FilterGlobal2Code);
                                //end;

                                "G/L Account".CALCFIELDS("Net Change", "Balance at Date");
                                Net_ChangeShow := FORMAT(ABS("G/L Account"."Net Change"), 0, '<Integer><Decimals,3>');
                                //Net_ChangeShow := '555';
                                BlankLineNo := "G/L Account"."No. of Blank Lines" + 1;


                                //Evaluate(NetChangeInt, Net_ChangeShow);
                                //if NetChangeInt < 0 then
                                if "G/L Account"."Net Change" < 0 then
                                    Sign := '-'
                                else
                                    Sign := '';


                                IF PrintToExcel AND (((StartBalanceDr <> 0) OR (StartBalanceCr <> 0)) OR ("G/L Account"."Net Change" <> 0) OR ("G/L Account"."Balance at Date" <> 0)) THEN//AVKPM 270219
                                    MakeExcelDataBody;
                            end;

                    Clear(i);
                    Clear(FixBlank1);
                    Clear(FixBlankInt1);
                    FixBlankInt1 := 1;
                    repeat
                        i += 1;
                        FixBlank1 += ' ';
                    until i >= FixBlankInt1;

                    Clear(j);
                    Clear(FixBlank2);
                    Clear(FixBlankInt2);
                    GLAccNoAndDepCode := "G/L Account"."No." + FilterDepCode;
                    FixBlankInt2 := 17 - StrLen(GLAccNoAndDepCode);
                    repeat
                        j += 1;
                        FixBlank2 += ' ';
                    until j >= FixBlankInt2;

                    Clear(k);
                    Clear(FixBlank3);
                    Clear(FixBlankInt3);
                    FixBlankInt3 := 3 - StrLen(FilterGlobal2CodeShow);
                    repeat
                        k += 1;
                        FixBlank3 += ' ';
                    until k >= FixBlankInt3;


                    Clear(l);
                    Clear(FixBlank4);
                    Clear(FixBlankInt4);

                    "G/L Account".CALCFIELDS("Net Change");
                    //Message("G/L Account".GetFilters);
                    ///Jaa Net_ChangeShow := FORMAT(ABS("G/L Account"."Net Change"), 0, '<Integer><Decimals,3>');
                    //Net_ChangeShow := '777';
                    //Message('len Net_ChangeShow : %1', StrLen(Net_ChangeShow));

                    if FilterGlobal2CodeShow = '' then begin
                        FixBlankInt4 := 17 - StrLen(Net_ChangeShow);
                    end else begin
                        if StrLen(FilterGlobal2CodeShow) <> 4 then
                            FixBlankInt4 := 16 - StrLen(Net_ChangeShow) + (4 - StrLen(FilterGlobal2CodeShow))
                        else
                            FixBlankInt4 := 16 - StrLen(Net_ChangeShow);
                    end;
                    repeat
                        l += 1;
                        FixBlank4 += ' ';
                    until l >= FixBlankInt4;


                end;
            }

            trigger OnPreDataItem()
            begin

                PageGroupNo := 0;
                ChangeGroupNo := FALSE;
                //AVPDB.001 12.06.2014
                //Add Code for Get Value Company Infomation - OnPreDataItem()
                companyinfo.GET;
                //E-AVPDB.001 12.06.2014   

                ////////////////////////////////////
                /*
                "G/L Account".SetFilter("Date Filter", GetFilter("Date Filter"));
                Clear(DimValueTradingParter);
                DimValueTradingParter.SetCurrentKey("Dimension Code", Code);
                DimValueTradingParter.SetRange(DimValueTradingParter.Code, "G/L Account"."Global Dimension 2 Code");
                if DimValueTradingParter.Find('-') then begin
                    repeat
                        DimValueTradingParter."INT_For HFM" := false;
                        DimValueTradingParter.Modify;
                    until DimValueTradingParter.Next() = 0;
                end;

                Clear(DimValueTradingParter);
                DimValueTradingParter.SetCurrentKey("Dimension Code", Code);
                DimValueTradingParter.SetRange(DimValueTradingParter.Code, "G/L Account"."Global Dimension 2 Code");
                if DimValueTradingParter.Find('-') then begin
                    repeat
                        DimValueTradingParter."INT_For HFM" := true;
                        DimValueTradingParter.Modify;
                    until DimValueTradingParter.Next() = 0;
                end;
                ////////////////////////////////////
                */


                //Insert Table Tmp Dimension
                CLEAR(TmpDimValue_Dep);
                TmpDimValue_Dep.DELETEALL;
                CLEAR(Running);
                CLEAR(DimGloal1);
                DimGloal1.SETCURRENTKEY(DimGloal1."Dimension Code");
                DimGloal1.SETRANGE(DimGloal1."Dimension Code", 'COST CENTER');
                IF DimGloal1.FIND('-') THEN BEGIN
                    Running += 1;
                    TmpDimValue_Dep.INIT;
                    TmpDimValue_Dep."Dimension Code" := 'COST CENTER';
                    TmpDimValue_Dep.Code := FORMAT(Running);
                    TmpDimValue_Dep.Name := '';
                    TmpDimValue_Dep."INT_External Document No." := '';
                    TmpDimValue_Dep.INSERT;
                    REPEAT
                        Running += 1;
                        TmpDimValue_Dep.INIT;
                        TmpDimValue_Dep."Dimension Code" := 'COST CENTER';
                        TmpDimValue_Dep.Code := FORMAT(Running);
                        TmpDimValue_Dep.Name := DimGloal1.Code;
                        TmpDimValue_Dep."INT_External Document No." := '';
                        TmpDimValue_Dep.INSERT;

                        CLEAR(DimGloal2);
                        DimGloal2.SETCURRENTKEY(DimGloal2."Dimension Code");
                        DimGloal2.SETRANGE(DimGloal2."Dimension Code", 'TRADING PARTNERS');
                        //DimGloal2.SETRANGE(Blocked, false);
                        DimGloal2.SetRange("INT_For HFM", true);
                        IF DimGloal2.FIND('-') THEN BEGIN
                            REPEAT
                                Running += 1;
                                TmpDimValue_Dep.INIT;
                                TmpDimValue_Dep."Dimension Code" := 'COST CENTER';
                                TmpDimValue_Dep.Code := FORMAT(Running);
                                TmpDimValue_Dep.Name := DimGloal1.Code;
                                TmpDimValue_Dep."INT_External Document No." := DimGloal2.Code;
                                TmpDimValue_Dep.INSERT;

                            UNTIL DimGloal2.NEXT = 0;
                        END;
                    UNTIL DimGloal1.NEXT = 0;
                END;




                CLEAR(DimGloal2);
                DimGloal2.SETCURRENTKEY(DimGloal2."Dimension Code");
                DimGloal2.SETRANGE(DimGloal2."Dimension Code", 'TRADING PARTNERS');
                //DimGloal2.SETRANGE(Blocked, false);
                DimGloal2.SetRange("INT_For HFM", true);
                IF DimGloal2.FIND('-') THEN BEGIN
                    REPEAT
                        Running += 1;
                        TmpDimValue_Dep.INIT;
                        TmpDimValue_Dep."Dimension Code" := 'COST CENTER';
                        TmpDimValue_Dep.Code := FORMAT(Running);
                        TmpDimValue_Dep.Name := '';
                        TmpDimValue_Dep."INT_External Document No." := DimGloal2.Code;
                        TmpDimValue_Dep.INSERT;

                    UNTIL DimGloal2.NEXT = 0;
                END;



            end;

            trigger OnAfterGetRecord()
            begin

                //AVPKJINT 20/02/2020
                if (CopyStr("G/L Account"."No.", 1, 1) = '0') or (CopyStr("G/L Account"."No.", 1, 1) = '1') then
                    "G/L Account".SetFilter("Date Filter", '..%1', EndDate)
                else
                    "G/L Account".SetFilter("Date Filter", '%1..%2', StartDate, EndDate);
                //C-AVPKJINT 20/02/2020

                IF ChangeGroupNo THEN BEGIN
                    PageGroupNo += 1;
                    ChangeGroupNo := FALSE;
                END;

                ChangeGroupNo := "New Page";

            end;



        }


    }


    requestpage
    {
        SaveValues = true;
        layout
        {
            area(Content)
            {
                field("Start Date"; StartDate)
                {
                    Caption = 'Start Date';
                }
                field("End Date"; EndDate)
                {
                    Caption = 'End Date';
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    trigger OnPreReport()
    var
        DimValueTB: Record "Dimension Value";
        GLEntryTB: Record "G/L Entry";
    begin
        if StartDate = 0D then
            Error('Start Date must not be blank.');
        if EndDate = 0D then
            Error('End Date must not be blank.');

        GLFilter := "G/L Account".GETFILTERS;
        PeriodText := "G/L Account".GETFILTER("Date Filter");
        TxtFilter := "G/L Account".GETFILTER("G/L Account"."Global Dimension 1 Filter");

        IF PrintToExcel THEN
            MakeExcelInfo;


        Clear(DimValueTB);
        DimValueTB.SetCurrentKey("Dimension Code", Code);
        DimValueTB.SetRange("Dimension Code", 'TRADING PARTNERS');
        if DimValueTB.Find('-') then begin
            repeat
                Clear(GLEntryTB);
                GLEntryTB.SetCurrentKey("Global Dimension 2 Code");
                GLEntryTB.SetRange("Global Dimension 2 Code", DimValueTB.Code);
                GLEntryTB.SetFilter("Posting Date", PeriodText);
                if GLEntryTB.FindFirst then begin
                    DimValueTB."INT_For HFM" := true;
                    DimValueTB.Modify;
                end else begin
                    DimValueTB."INT_For HFM" := false;
                    DimValueTB.Modify;
                end;
            until DimValueTB.Next = 0;
        end;

    end;

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN BEGIN
            MakeExcelDataFooter;
            CreateExcelbook;
        END;
    end;

    var
        NetChangeInt: Integer;
        DimValueTradingParter: Record "Dimension Value";
        TraddingPartnersCode: Code[20];
        Text000: TextConst ENU = 'Period: %1';
        Text001: TextConst ENU = 'Trial Balance';
        Text002: TextConst ENU = 'Data';
        Text003: TextConst ENU = 'Debit';
        Text004: TextConst ENU = 'Credit';
        Text005: TextConst ENU = 'Company Name';
        Text006: TextConst ENU = 'Report No.';
        Text007: TextConst ENU = 'Report Name';
        Text008: TextConst ENU = 'User ID';
        Text009: TextConst ENU = 'Date';
        Text010: TextConst ENU = 'G/L Filter';
        Text011: TextConst ENU = 'Period Filter';
        Trial_BalanceCaptionLbl: TextConst ENU = 'Trial Balance by Department';
        CurrReport_PAGENOCaptionLbl: TextConst ENU = 'Page';
        Net_ChangeCaptionLbl: TextConst ENU = 'Net Change';
        BalanceCaptionLbl: TextConst ENU = 'Balance';
        PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: TextConst ENU = 'Name';
        G_L_Account___Net_Change_CaptionLbl: TextConst ENU = 'Debit';
        G_L_Account___Net_Change__Control22CaptionLbl: TextConst ENU = 'Credit';
        G_L_Account___Balance_at_Date_CaptionLbl: TextConst ENU = 'Debit';
        G_L_Account___Balance_at_Date__Control24CaptionLbl: TextConst ENU = 'Credit';
        ExcelBuf: Record "Excel Buffer";
        GLFilter: text;
        PeriodText: text[30];
        PrintToExcel: Boolean;
        PageGroupNo: Integer;
        ChangeGroupNo: Boolean;
        BlankLineNo: Integer;
        StartBalanceDr: Decimal;
        StartBalanceCr: Decimal;
        GLAccount: Record "G/L Account";
        SumNetCr: Decimal;
        SumNetDr: Decimal;
        SumBalCr: Decimal;
        SumBalDr: Decimal;
        companyinfo: Record "Company Information";
        BalDr: Decimal;
        BalCr: Decimal;
        ShowZero: Boolean;
        TmpDimValue_Dep: Record "Dimension Value" temporary;
        CountDep: Integer;
        CountAccount: Integer;
        FilterDepCode: Code[20];
        GLNo: Integer;
        TxtFilter: text[250];
        CostOption: Option ,DL,OH,"I-OH";
        DimGloal1: Record "Dimension Value";
        DimGloal2: Record "Dimension Value";
        FilterGlobal2Code: Code[20];
        FilterGlobal2CodeShow: Code[20];
        Running: Integer;
        Net_ChangeShow: text[100];
        FixBlank1: Text[250];
        FixBlankInt1: Integer;
        FixBlank2: Text[250];
        FixBlankInt2: Integer;
        FixBlank3: Text[250];
        FixBlankInt3: Integer;
        FixBlank4: Text[250];
        FixBlankInt4: Integer;
        i: Integer;
        j: Integer;
        k: Integer;
        l: Integer;
        SCC: Text[3];
        GLAccNoAndDepCode: Text[100];
        Sign: text[1];
        StartDate: Date;
        EndDate: Date;


    procedure MakeExcelInfo()
    begin
        ExcelBuf.SetUseInfoSheet;
        ExcelBuf.AddInfoColumn(FORMAT(Text005), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(COMPANYNAME, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text007), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(FORMAT(Text001), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text006), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(REPORT::"Trial Balance", FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Number);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text008), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(USERID, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text009), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn(TODAY, FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Date);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text010), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GETFILTER("No."), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddInfoColumn(FORMAT(Text011), FALSE, TRUE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddInfoColumn("G/L Account".GETFILTER("Date Filter"), FALSE, FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.ClearNewRow;
        MakeExcelDataHeader;
    end;

    local procedure MakeExcelDataHeader()
    begin
        ExcelBuf.AddColumn("G/L Account".FIELDCAPTION("No."), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn("G/L Account".FIELDCAPTION(Name), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
        FORMAT('Beginning - ' + Text003), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
        FORMAT('Beginning - ' + Text004), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
        FORMAT("G/L Account".FIELDCAPTION("Net Change") + ' - ' + Text003), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
        FORMAT("G/L Account".FIELDCAPTION("Net Change") + ' - ' + Text004), FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
        FORMAT("G/L Account".FIELDCAPTION("Balance at Date") + ' - ' + Text003), FALSE, '', TRUE, FALSE, TRUE, '',
        ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(
        FORMAT("G/L Account".FIELDCAPTION("Balance at Date") + ' - ' + Text004), FALSE, '', TRUE, FALSE, TRUE, '',
        ExcelBuf."Cell Type"::Text);
    end;

    procedure MakeExcelDataBody()
    var
        BlankFiller: text[250];
    begin
        BlankFiller := PADSTR(' ', MAXSTRLEN(BlankFiller), ' ');
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn(
        "G/L Account"."No.", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
        ExcelBuf."Cell Type"::Text);
        IF "G/L Account".Indentation = 0 THEN
            ExcelBuf.AddColumn(
                "G/L Account".Name, FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                ExcelBuf."Cell Type"::Text)
        ELSE
            ExcelBuf.AddColumn(
                COPYSTR(BlankFiller, 1, 2 * "G/L Account".Indentation) + "G/L Account".Name,
                FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text);


        ExcelBuf.AddColumn(FilterDepCode, FALSE, '', FALSE, FALSE, FALSE, '', ExcelBuf."Cell Type"::Text); //AVWNFBFOODS.001 270219

        //AVWNFBFOODS.001 180219
        CASE TRUE OF
            (StartBalanceDr = 0) AND (StartBalanceCr = 0):
                BEGIN
                    ExcelBuf.AddColumn(
                        '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                        ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                        '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                        ExcelBuf."Cell Type"::Number);
                END;
            StartBalanceDr <> 0:
                BEGIN
                    ExcelBuf.AddColumn(
                        StartBalanceDr, FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                        FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                        '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                        ExcelBuf."Cell Type"::Number);
                END;
            StartBalanceCr <> 0:
                BEGIN
                    ExcelBuf.AddColumn(
                        '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                        ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                        StartBalanceCr, FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                        FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                END;
        END;
        //C-AVWNFBFOODS.001 180219

        CASE TRUE OF
            "G/L Account"."Net Change" = 0:
                BEGIN
                    ExcelBuf.AddColumn(
                        '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                        ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                        '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                        ExcelBuf."Cell Type"::Number);
                END;
            "G/L Account"."Net Change" > 0:
                BEGIN
                    ExcelBuf.AddColumn(
                        "G/L Account"."Net Change", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                        FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                        '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                        ExcelBuf."Cell Type"::Number);
                END;
            "G/L Account"."Net Change" < 0:
                BEGIN
                    ExcelBuf.AddColumn(
                        '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                        ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                        -"G/L Account"."Net Change", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                        FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                END;
        END;

        CASE TRUE OF
            "G/L Account"."Balance at Date" = 0:
                BEGIN
                    ExcelBuf.AddColumn(
                        '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                        ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                        '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                        ExcelBuf."Cell Type"::Number);
                END;
            "G/L Account"."Balance at Date" > 0:
                BEGIN
                    ExcelBuf.AddColumn(
                        "G/L Account"."Balance at Date", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                        FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                        '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                        ExcelBuf."Cell Type"::Number);
                END;
            "G/L Account"."Balance at Date" < 0:
                BEGIN
                    ExcelBuf.AddColumn(
                        '', FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting, FALSE, FALSE, '',
                        ExcelBuf."Cell Type"::Number);
                    ExcelBuf.AddColumn(
                        -"G/L Account"."Balance at Date", FALSE, '', "G/L Account"."Account Type" <> "G/L Account"."Account Type"::Posting,
                        FALSE, FALSE, '#,##0.00', ExcelBuf."Cell Type"::Number);
                END;
        END;
    end;

    procedure CreateExcelbook()
    begin
        //ExcelBuf.CreateBookAndOpenExcel('', Text002, Text001, COMPANYNAME, USERID);
        //ERROR('');
    end;

    local procedure MakeExcelDataFooter()
    begin
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.NewRow;
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('Total', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn('', FALSE, '', TRUE, FALSE, TRUE, '', ExcelBuf."Cell Type"::Text);
        ExcelBuf.AddColumn(BalDr, FALSE, '', TRUE, FALSE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(BalCr, FALSE, '', TRUE, FALSE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(SumNetDr, FALSE, '', TRUE, FALSE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(SumNetCr, FALSE, '', TRUE, FALSE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(SumBalDr, FALSE, '', TRUE, FALSE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);
        ExcelBuf.AddColumn(SumBalCr, FALSE, '', TRUE, FALSE, TRUE, '#,##0.00', ExcelBuf."Cell Type"::Number);

    end;


}