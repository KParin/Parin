report 50065 "INT_RPAP_Inv.App History-AP"
{
    // version AVTHLC1.0

    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/Invoice Application History-AP.rdlc';
    CaptionML = ENU = 'Invoice Application History-AP';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            //DataItemTableView = SORTING("Purchaser Code","Vendor No.","Posting Date") ORDER(Ascending) WHERE("Document Type"=FILTER(Invoice));
            DataItemTableView = where ("Document Type" = FILTER (Invoice));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Vendor No.", "Posting Date", "Document No.";
            column(COMPANYNAME; CompanyInfo.Name + ' ' + CompanyInfo."Name 2")
            {
            }
            column(Filters; STRSUBSTNO('Filters : %1', GETFILTERS))
            {
            }
            column(GroupBy; GroupBy)
            {
            }
            column(PurchaserCode_VendorLedgerEntry; "Vendor Ledger Entry"."Purchaser Code")
            {
            }
            column(Purchaser_Name; Purchaser.Name)
            {
            }
            column(VendorNo_VendorLedgerEntry; "Vendor Ledger Entry"."Vendor No.")
            {
            }
            column(Vendor_Name; Vendor.Name)
            {
            }
            column(DocumentType_VendorLedgerEntry; "Vendor Ledger Entry"."Document Type")
            {
            }
            column(PostingDate_VendorLedgerEntry; FORMAT("Vendor Ledger Entry"."Posting Date", 0, 1))
            {
            }
            column(DueDate_VendorLedgerEntry; FORMAT("Vendor Ledger Entry"."Due Date", 0, 1))
            {
            }
            column(DocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."Document No.")
            {
            }
            column(Description_VendorLedgerEntry; "Vendor Ledger Entry".Description)
            {
            }
            column(CurrencyCode_VendorLedgerEntry; "Vendor Ledger Entry"."Currency Code")
            {
            }
            column(Amount_VendorLedgerEntry; "Vendor Ledger Entry".Amount)
            {
            }
            column(AmountLCY_VendorLedgerEntry; "Vendor Ledger Entry"."Amount (LCY)")
            {
            }
            column(PrintedDate; FORMAT(TODAY, 0, 1) + ' ' + FORMAT(TIME, 0, '<Hours12>:<Minutes,2>:<Second,2> <AM/PM>'))
            {
            }
            dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
            {
                DataItemLink = "Vendor Ledger Entry No." = FIELD ("Entry No.");
                DataItemTableView = SORTING ("Vendor Ledger Entry No.", "Entry Type", "Posting Date") WHERE ("Entry Type" = CONST (Application), Unapplied = CONST (false));
                column(VendorLedgerEntryNo_DetailedVendorLedgEntry; "Detailed Vendor Ledg. Entry"."Vendor Ledger Entry No.")
                {
                }
                column(DocumentType_DetailedVendorLedgEntry; "Detailed Vendor Ledg. Entry"."Document Type")
                {
                }
                column(PostingDate_DetailedVendorLedgEntry; "Detailed Vendor Ledg. Entry"."Posting Date")
                {
                }
                column(DocumentNo_DetailedVendorLedgEntry; "Detailed Vendor Ledg. Entry"."Document No.")
                {
                }
                column(CurrencyCode_DetailedVendorLedgEntry; "Detailed Vendor Ledg. Entry"."Currency Code")
                {
                }
                column(Amount_DetailedVendorLedgEntry; "Detailed Vendor Ledg. Entry".Amount)
                {
                }
                column(AmountLCY_DetailedVendorLedgEntry; "Detailed Vendor Ledg. Entry"."Amount (LCY)")
                {
                }
                column(PeriodAppliedAmt_1; PeriodAppliedAmt[1])
                {
                }
                column(PeriodAppliedAmt_2; PeriodAppliedAmt[2])
                {
                }
                column(PeriodAppliedAmt_3; PeriodAppliedAmt[3])
                {
                }
                column(PeriodAppliedAmt_4; PeriodAppliedAmt[4])
                {
                }
                column(PeriodAppliedAmt_5; PeriodAppliedAmt[5])
                {
                }
                column(PeriodAppliedAmt_6; PeriodAppliedAmt[6])
                {
                }
                column(NumDays; Days)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(PeriodAppliedAmt);
                    PeriodStartDate := "Vendor Ledger Entry"."Posting Date";
                    for i := 1 to ARRAYLEN(PeriodAppliedAmt) do begin
                        PeriodEndDate := CALCDATE(PeriodLength, PeriodStartDate);
                        if "Posting Date" in [PeriodStartDate .. PeriodEndDate] then
                            PeriodAppliedAmt[i] := "Amount (LCY)";
                        PeriodStartDate := CALCDATE('1D', PeriodEndDate);
                    end;

                    Days := "Detailed Vendor Ledg. Entry"."Posting Date" - "Vendor Ledger Entry"."Due Date";//AVICA 01/04/2014
                end;
            }

            trigger OnAfterGetRecord();
            begin
                if AVNotFull = true then begin
                    CLEAR(AVVendorLedger);
                    AVVendorNo := "Vendor Ledger Entry".GETFILTER("Vendor Ledger Entry"."Vendor No.");
                    AVPurchase := "Vendor Ledger Entry".GETFILTER("Vendor Ledger Entry"."Purchaser Code");


                    AVVendorLedger.SETCURRENTKEY(AVVendorLedger."Entry No.");
                    AVVendorLedger.SETRANGE(AVVendorLedger."Vendor No.", "Vendor Ledger Entry"."Vendor No.");
                    AVVendorLedger.SETRANGE(AVVendorLedger."Document Type", AVVendorLedger."Document Type"::Invoice);
                    if AVVendorLedger.FINDFIRST then begin
                        repeat
                            AVVendorAmount := AVVendorAmount + "Vendor Ledger Entry".Amount;

                            CLEAR(AVDetailedVendor);
                            AVDetailedVendor.SETCURRENTKEY(AVDetailedVendor."Entry No.");
                            AVDetailedVendor.SETRANGE(AVDetailedVendor."Vendor Ledger Entry No.", AVVendorLedger."Entry No.");
                            AVDetailedVendor.SETRANGE(AVDetailedVendor."Entry Type", AVDetailedVendor."Entry Type"::Application);
                            AVDetailedVendor.SETRANGE(AVDetailedVendor.Unapplied, false);
                            if AVDetailedVendor.FINDFIRST then begin
                                repeat
                                    AVDetailAmount := AVDetailAmount + AVDetailedVendor.Amount;
                                until AVDetailedVendor.NEXT = 0;
                            end;


                        until AVVendorLedger.NEXT = 0;
                        if AVVendorAmount + AVDetailAmount = 0 then
                            CurrReport.SKIP;
                    end
                end;

                CLEAR(AVDetailAmount);
                CLEAR(AVVendorAmount);


                if not Purchaser.GET("Purchaser Code") then
                    Purchaser.Name := '<Blank Salesperson>';

                if Vendor.GET("Vendor No.") then begin end;



                case GroupBy of
                    GroupBy::Vendor:
                        SETCURRENTKEY("Vendor No.", "Posting Date");
                    GroupBy::"Purchaser by Vendor":
                        SETCURRENTKEY("Purchaser Code", "Vendor No.", "Posting Date");
                end;
            end;

            trigger OnPreDataItem();
            begin
                CompanyInfo.GET;

                CLEAR(AVDetailAmount);
                CLEAR(AVVendorAmount);
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group(Period)
                {
                    Caption = 'Period';
                    Visible = false;
                    field(PeriodLength; "PeriodLength")
                    {
                        Caption = 'Period Length';
                        Visible = false;
                    }
                    field(GroupBy; "GroupBy")
                    {
                        Caption = 'Group By';
                        Visible = false;
                    }
                    field(AVNotFull; "AVNotFull")
                    {
                        Caption = 'Only Invoice Not Full Paid';
                        Visible = false;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            EVALUATE(PeriodLength, '30D');
        end;
    }

    labels
    {
    }

    var
        CompanyInfo: Record "Company Information";
        PeriodAppliedAmt: array[6] of Decimal;
        Purchaser: Record "Salesperson/Purchaser";
        Vendor: Record Vendor;
        PeriodLength: DateFormula;
        PeriodStartDate: Date;
        PeriodEndDate: Date;
        i: Integer;
        GroupBy: Option Vendor,"Purchaser by Vendor";
        AVNotFull: Boolean;
        AVVendorLedger: Record "Vendor Ledger Entry";
        AVDetailedVendor: Record "Detailed Vendor Ledg. Entry";
        AVVendorNo: Code[20];
        AVPostingDate: Date;
        AVPurchase: Code[20];
        AVDetailAmount: Decimal;
        AVVendorAmount: Decimal;
        BBBBB: Integer;
        GGG: Code[10];
        HHH: Code[20];
        JJJ: Decimal;
        KKK: Decimal;
        Days: Integer;
}

