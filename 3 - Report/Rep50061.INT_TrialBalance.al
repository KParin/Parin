report 50061 "INT_Trial Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/TrialBalance.rdl';
    Caption = 'Trial Balance';

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";

            column(HideNoTransAccLayout; HideNoTransAccLayout)
            {
            }
            column(HideNoTransAcc; HideNoTransAcc)
            {
            }
            column(ShowAll; ShowAll)
            {
            }
            column(STRSUBSTNO_Text000_PeriodText_; STRSUBSTNO(Text000, PeriodText))
            {
            }
            column(PrintDate; FORMAT(TODAY, 0, 1) + ' ' + FORMAT(TIME, 0, '<Hours12>:<Minutes,2>:<Second,2> <AM/PM>'))
            {
            }
            /*
            column(CurrReport_PAGENO; CurrReport.PAGENO)
            {
            }
            */
            column(COMPANYNAME; '')
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
            column(SumNetDr; SumNetDr)
            {
            }
            column(SumNetCr; SumNetCr)
            {
            }
            column(SumBalDr; SumBalDr)
            {
            }
            column(SumBalCr; SumBalCr)
            {
            }

            dataitem(Integer;
            Integer)
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                DataItemLinkReference = "G/L Account";

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


                dataitem(BlankLineRepeater; Integer)
                {
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



                trigger OnAfterGetRecord()
                begin
                    BlankLineNo := "G/L Account"."No. of Blank Lines" + 1;


                    //AVWISTD.001 04.07.2010
                    //Add Code for Sum Begining Balance on trigger Integer, Body (1) - OnPreSection()
                    IF "G/L Account"."Account Type" = "G/L Account"."Account Type"::Posting THEN BEGIN
                        IF "G/L Account"."Net Change" > 0 THEN
                            SumNetDr := SumNetDr + "G/L Account"."Net Change"
                        ELSE
                            SumNetCr := SumNetCr + -"G/L Account"."Net Change";

                        IF "G/L Account"."Balance at Date" > 0 THEN
                            SumBalDr := SumBalDr + "G/L Account"."Balance at Date"
                        ELSE
                            SumBalCr := SumBalCr + -"G/L Account"."Balance at Date";
                    END ELSE BEGIN
                        SumNetCr := SumNetCr;
                        SumNetDr := SumNetDr;
                        SumBalCr := SumBalCr;
                        SumBalDr := SumBalDr;
                    END;
                    //C-AVWISTD.001 04.07.2010
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


                //AVWISTD.002 04.07.2010
                //Add Code for Clear Value on trigger G/L Account - OnPreDataItem()
                BalDr := 0;
                BalCr := 0;
                //C-AVWISTD.002 04.07.2010
            end;

            trigger OnAfterGetRecord()
            begin
                //AVWISTD.003 04.07.2010
                //Add Code for Find Begining Balance on trigger G/L Account - OnAfterGetRecord()
                StartBalanceDr := 0;
                StartBalanceCr := 0;
                IF PeriodText <> '' THEN
                    IF GETRANGEMIN("Date Filter") <> 0D THEN BEGIN
                        CLEAR(GLAccount);
                        GLAccount.COPY("G/L Account");
                        GLAccount.SETRANGE("No.", "G/L Account"."No.");
                        GLAccount.SETRANGE("Date Filter", 0D, CLOSINGDATE(GETRANGEMIN("Date Filter") - 1));
                        IF GLAccount.FINDFIRST THEN
                            REPEAT
                                GLAccount.CALCFIELDS("Net Change");
                                IF GLAccount."Net Change" > 0 THEN BEGIN
                                    StartBalanceDr := StartBalanceDr + GLAccount."Net Change";
                                    IF GLAccount."Account Type" = GLAccount."Account Type"::Posting THEN
                                        BalDr := BalDr + GLAccount."Net Change";
                                END ELSE BEGIN
                                    StartBalanceCr := StartBalanceCr - GLAccount."Net Change";
                                    IF GLAccount."Account Type" = GLAccount."Account Type"::Posting THEN
                                        BalCr := BalCr - GLAccount."Net Change";
                                END;
                            UNTIL (GLAccount.NEXT = 0);
                    END;
                //C-AVWISTD.003 04.07.2010

                CALCFIELDS("Net Change", "Balance at Date");
                IF PrintToExcel THEN
                    MakeExcelDataBody;

                IF ChangeGroupNo THEN BEGIN
                    PageGroupNo += 1;
                    ChangeGroupNo := FALSE;
                END;

                ChangeGroupNo := "New Page";

                HideNoTransAccLayout := true;
                if HideNoTransAcc then begin
                    if (StartBalanceDr = 0) AND (StartBalanceCr = 0)
                    AND ("G/L Account"."Net Change" = 0) AND (-"G/L Account"."Net Change" = 0)
                    AND ("G/L Account"."Balance at Date" = 0) AND (-"G/L Account"."Balance at Date" = 0)
                    then begin
                        HideNoTransAccLayout := false;
                    end;
                end;


            end;





        }



    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    field(ShowAll; ShowAll)
                    {
                        Caption = 'Show All';
                    }
                    field(HideNoTransAcc; HideNoTransAcc)
                    {
                        Caption = 'Hide No Transaction Account';
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
                    ApplicationArea = All;

                }

            }
        }
    }

    procedure MakeExcelInfo()
    begin

    end;

    procedure MakeExcelDataHeader()
    begin

    end;

    procedure MakeExcelDataBody()
    begin

    end;

    procedure CreateExcelbook()
    begin

    end;

    procedure MakeExcelDataFooter()
    begin

    end;


    trigger OnPreReport()
    begin
        GLFilter := "G/L Account".GETFILTERS;
        PeriodText := "G/L Account".GETFILTER("Date Filter");
        IF PrintToExcel THEN
            MakeExcelInfo;
    end;

    trigger OnPostReport()
    begin
        IF PrintToExcel THEN BEGIN
            MakeExcelDataFooter;
            CreateExcelbook;
        END;
    end;



    var
        ShowAll: Boolean;
        ExcelBuf: Record "Excel Buffer";
        GLFilter: Text;
        PeriodText: Text[30];
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
        SumBeginDr: Decimal;
        SumBeginCr: Decimal;
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
        Trial_BalanceCaptionLbl: TextConst ENU = 'Trial Balance';
        CurrReport_PAGENOCaptionLbl: TextConst ENU = 'Page';
        Net_ChangeCaptionLbl: TextConst ENU = 'Net Change';
        BalanceCaptionLbl: TextConst ENU = 'Balance';
        PADSTR_____G_L_Account__Indentation___2___G_L_Account__NameCaptionLbl: TextConst ENU = 'Name';
        G_L_Account___Net_Change_CaptionLbl: TextConst ENU = 'Debit';
        G_L_Account___Net_Change__Control22CaptionLbl: TextConst ENU = 'Credit';
        G_L_Account___Balance_at_Date_CaptionLbl: TextConst ENU = 'Debit';
        G_L_Account___Balance_at_Date__Control24CaptionLbl: TextConst ENU = 'Credit';
        HideNoTransAcc: Boolean;
        HideNoTransAccLayout: Boolean;


}