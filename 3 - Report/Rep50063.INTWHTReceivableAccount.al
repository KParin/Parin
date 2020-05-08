report 50063 "INT_WHT Receivable Account"
{
    // version AVFTH1.0

    // Microsoft Dynamic NAV
    // ----------------------------------------
    // Project: Localization TH
    // AVNVKSTD : Natee Visedkajee
    // 
    // No.   Date         Sign       Description
    // --------------------------------------------------
    // 001   18.07.2012   AVNVKSTD   Localization.
    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/WHT Receivable Account.rdl';
    CaptionML = ENU = 'WHT Receivable Account';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            DataItemTableView = SORTING("G/L Account No.", "Posting Date");
            column(FILTERDATE; FILTERDATE)
            {
            }
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(PrintDate; FORMAT(TODAY, 0, 1) + '  ' + FORMAT(TIME, 0, '<Hours12>:<Minutes,2>:<Seconds,2> <AM/PM>'))
            {
            }
            column(UserId; USERID)
            {
            }
            column(CompanyVATRegistrationNo; 'เลขที่ประจำตัวผู้เสียภาษี :  ' + CompanyInfo."VAT Registration No.")
            {
            }
            column(PostingDate; FORMAT("Posting Date", 0, 1))
            {
            }
            column(DocumentNo; "Document No.")
            {
            }
            column(CustName; "Cust Name")
            {
            }
            column(RefWHTType; "FNAR003_Ref. WHT Type")
            {
            }
            column(RefWHTBase; "FNAR003_Ref. WHT Base")
            {
            }
            column(RefWHT; "FNAR003_Ref. WHT%")
            {
            }
            column(Amount; Amount)
            {
            }
            column(SumTrans; 'Total ' + FORMAT(SumTrans))
            {
            }
            column(BaseWHT; BaseWHT)
            {
            }
            column(TotalAmt; TotalAmt)
            {
            }
            column(RefCusPostDate; "G/L Entry"."FNAR003_Ref. Cust. Post Date")
            {
            }
            column(FNAR003_WHT_No____RV; "FNAR003_WHT No. - RV")//AVKSAVIP 30/10/2019 Add field
            {
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR(GLAcc);
                if GLAcc.GET("G/L Account No.") then
                    if not GLAcc."AVF_WHT Account - RV" then
                        CurrReport.SKIP;


                CLEAR("Cust Name");
                if "G/L Entry"."FNAR003_Ref. Custmer Name" <> '' then
                    "Cust Name" := "FNAR003_Ref. Custmer Name"
                else
                    if "G/L Entry"."FNAR003_Ref. Custmer Name" = '' then begin
                        CLEAR(AVCustomer);
                        AVCustomer.SetCurrentKey(AVCustomer."No.");
                        AVCustomer.SetRange(AVCustomer."No.", "FNAR003_Ref. Customer No.");
                        if AVCustomer.FindFirst then
                            "Cust Name" := AVCustomer.Name + ' ' + AVCustomer."Name 2";
                    end;

                SumTrans += 1;
                BaseWHT += "FNAR003_Ref. WHT Base";
                "WHT%" += "FNAR003_Ref. WHT%";
                TotalAmt += Amount;
            end;

            trigger OnPreDataItem();
            begin
                CLEAR(CompanyInfo);
                CompanyInfo.GET;
                SETFILTER("Posting Date", FILTERDATE);
                PMonth := Thai.MonthWords('T', DATE2DMY(TODAY, 2));
                PYear := DATE2DMY(TODAY, 3) + 543;


                CLEAR(Running);
                CLEAR(SumTrans);
                CLEAR(BaseWHT);
                CLEAR("WHT%");
                CLEAR(TotalAmt);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Option")
                {
                    CaptionML = ENU = 'Option';
                    field("Posting Date"; "FILTERDATE")
                    {
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin

                            "G/L Entry".SETFILTER("Posting Date", FILTERDATE);
                            FILTERDATE := "G/L Entry".GETFILTER("Posting Date");
                        end;
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        CompanyInfo: Record "Company Information";
        PMonth: Text[30];
        PYear: Integer;
        Thai: Codeunit AVF_Thai;
        SumCntTrans: Integer;
        GLAcc: Record "G/L Account";
        SumAmt: Decimal;
        SumQty: Decimal;
        CellRow: Integer;
        Running: Integer;
        SumTrans: Integer;
        BaseWHT: Decimal;
        TotalAmt: Decimal;
        "WHT%": Decimal;
        AVCustomer: Record Customer;
        "Cust Name": Text[50];
        FILTERDATE: Text[30];
}

