report 50002 "INT_Sales Journal Voucher"
{
    // version AVTHLC1.0

    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/Sales Journal Voucher.rdl';
    Caption = 'Sales Journal Voucher';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("G/L Entry"; "G/L Entry")
        {
            //DataItemTableView = SORTING("Document No.","Source Code") WHERE(Amount=FILTER(<>0));
            DataItemTableView = where(Amount = filter(<> 0));
            RequestFilterFields = "Document No.", "Posting Date", "Source Code";
            column(CompanyInfoName; CompanyInfo.Name)
            {
            }
            column(UserID; 'User : ' + USERID)
            {
            }
            column(PrintDate; 'Date Printed : ' + FORMAT(TODAY, 0, 1) + '  ' + FORMAT(TIME, 0, '<HOURs12>:<Minute,2>:<Seconds,2> <AM/PM>'))
            {
            }
            column(HeadReport; HeadReport)
            {
            }
            column(HeadReportTH; HeadReportTH)
            {
            }
            column(DocumentNo; "G/L Entry"."Document No.")
            {
            }
            column(EntryNo; "Entry No.")
            {
            }
            column(PostingDate; FORMAT("Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(DocumentType; "Document Type")
            {
            }
            column(SourceCode; "Source Code")
            {
            }
            column(ExternalDocNo; "G/L Entry"."External Document No.")
            {
            }
            column(CustName; CustName)
            {
            }
            column(SalesInvHeader_ExternalDocumentNo; SalesInvHeader."External Document No.")
            {
            }
            column(SalesInvHeader_CustomerOrderNo; '')//SalesInvHeader."Customer Order No.")
            {
            }
            column(SalesInvHeader_PostingDescription; SalesInvHeader."Posting Description")
            {
            }
            column(RefDoc; RefDoc)
            {
            }
            column(Running; Running)
            {
            }
            column(GLAccountNo_GLAccountName; "G/L Account No." + ' - ' + GLAccount.Name)
            {
            }
            column(Description; Description)
            {
            }
            column(DebitAmount; ROUND("Debit Amount", 0.01, '='))
            {
            }
            column(CreditAmount; ROUND("Credit Amount", 0.01, '='))
            {
            }
            column(Comment; Comment)
            {
            }
            column(TotalCreditAmount; TotalCreditAmount)
            {
            }
            column(TotalDebitAmount; TotalDebitAmount)
            {
            }
            column(TotalFor_SourceCode; TotalFor + FIELDCAPTION("Source Code") + '  ' + "Source Code")
            {
            }
            column(AVCurrAmt; AVCurrAmt)
            {
            }
            column(ShowCurrRate; ShowCurrRate)
            {
            }
            column(CurrRate; CurrRate)
            {
            }
            //AVPKJINT.001 04/11/2019
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {
            }
            //C-AVPKJINT.001 04/11/2019

            dataitem("Dimension Set Entry"; "Dimension Set Entry")
            {
                DataItemLink = "Dimension Set ID" = FIELD("Dimension Set ID");
                DataItemTableView = SORTING("Dimension Set ID", "Dimension Code");
                column(DimensionText; DimensionText)
                {
                }
                column(ShowDimension; ShowDimension)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    //calcfields("Dimension Value Name");//เอาออกเนื่องจากอยากแสดงแต่โค้ด

                    if DimensionText = '' then
                        if "Dimension Value Name" <> '' then
                            DimensionText := "Dimension Code" + ' : ' + "Dimension Value Code" + ' = ' + "Dimension Value Name"
                        else
                            DimensionText := "Dimension Code" + ' : ' + "Dimension Value Code"
                    else
                        if "Dimension Value Name" <> '' then
                            DimensionText := DimensionText + ', ' + "Dimension Code" + ' : ' + "Dimension Value Code" + ' = ' + "Dimension Value Name"
                        else
                            DimensionText := DimensionText + ', ' + "Dimension Code" + ' : ' + "Dimension Value Code";
                end;

                trigger OnPreDataItem();
                begin
                    CLEAR(DimensionText);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                if (HeadReport = '') AND (HeadReportTH = '') then begin
                    Clear(HeadReport);
                    Clear(HeadReportTH);
                    if "Document Type" = "Document Type"::Invoice then begin
                        HeadReport := 'Sales Journal Voucher';
                        HeadReportTH := 'ใบสำคัญขาย';
                    end else
                        if "Document Type" = "Document Type"::"Credit Memo" then begin
                            HeadReport := 'Sales Credit Memo Voucher';
                            HeadReportTH := 'ใบสำคัญลดหนี้';
                        end else begin
                            HeadReport := 'Sales Journal Voucher';
                            HeadReportTH := 'ใบสำคัญขาย';
                        end;
                end;

                CLEAR(SourceCode);
                SourceCode.SETRANGE(Code, "Source Code");
                SourceCode.NEXT;

                CLEAR(ShowCurrRate);
                CLEAR(CurrRate);

                CLEAR(SalesInvHeader);
                SalesInvHeader.SETRANGE("No.", "Document No.");
                SalesInvHeader.NEXT;
                if SalesInvHeader."Sell-to Customer Name" <> '' then
                    CustName := SalesInvHeader."Sell-to Customer No." + ' - ' + SalesInvHeader."Sell-to Customer Name"
                else
                    CustName := SalesInvHeader."Sell-to Customer No." + ' - ' + SalesInvHeader."Sell-to Customer Name 2";
                if SalesInvHeader."Currency Factor" <> 0 then begin
                    ShowCurrRate := COPYSTR(SalesInvHeader."Currency Code", 1, 3);
                    CurrRate := 1 / SalesInvHeader."Currency Factor";
                    ShowCurrRate := ShowCurrRate;
                end;

                if CustName = ' - ' then begin
                    CLEAR(SalesCN);
                    SalesCN.SETRANGE(SalesCN."No.", "G/L Entry"."Document No.");
                    if SalesCN.FINDFIRST then
                        CustName := SalesCN."Sell-to Customer No." + ' - ' + SalesCN."Sell-to Customer Name" + SalesCN."Sell-to Customer Name 2";
                    if SalesCN."Currency Factor" <> 0 then begin
                        ShowCurrRate := COPYSTR(SalesCN."Currency Code", 1, 3);
                        CurrRate := 1 / SalesCN."Currency Factor";
                        ShowCurrRate := ShowCurrRate;
                    end;

                end;


                if (OldDoc <> '') and (OldDoc <> "Document No.") then begin
                    CLEAR(TotalCreditAmount);
                    CLEAR(TotalDebitAmount);
                    CLEAR(Running);
                    CLEAR(Vendor);
                    Vendor.SETRANGE("No.", "Source No.");
                    Vendor.NEXT;

                    CLEAR(SalesInvHeader);
                    SalesInvHeader.SETRANGE("No.", "Document No.");
                    if SalesInvHeader.FIND('-') then
                        RefDoc := SalesInvHeader."Your Reference";
                    //RefDoc := SalesInvHeader."Pre-Assigned No.";

                end;
                OldDoc := "Document No.";

                TotalCreditAmount += ROUND("Credit Amount", 0.01, '=');
                TotalDebitAmount += ROUND("Debit Amount", 0.01, '=');

                Running := Running + 1;

                // Get G/L Account Description //
                CLEAR(GLAccount);
                GLAccount.SETRANGE("No.", "G/L Account No.");
                GLAccount.NEXT;

                CLEAR(AVCurrAmt);
                if CurrRate <> 0 then begin
                    if "Debit Amount" <> 0 then begin
                        AVCurrAmt := "Debit Amount" / CurrRate;
                    end
                    else
                        if "Credit Amount" <> 0 then begin
                            AVCurrAmt := -"Credit Amount" / CurrRate;
                        end;
                end;
            end;

            trigger OnPreDataItem();
            begin
                CLEAR(CompanyInfo);
                CompanyInfo.GET();
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
                    Caption = 'Option';
                    field(ShowDimension; ShowDimension)
                    {
                        Caption = 'ShowDimension';
                    }
                    field(Comment; Comment)
                    {
                        Caption = 'Comment';
                        Visible = false;
                    }
                }

            }


        }

        actions
        {

        }

        trigger OnOpenPage()
        begin
            ShowDimension := true;
        end;

    }


    labels
    {
    }

    var
        FooterPrinted: Boolean;
        CompanyInfo: Record "Company Information";
        SourceCode: Record "Source Code";
        OldSource: Code[10];
        DateFilter: Text[50];
        DateHeader: Text[50];
        POS: Integer;
        Running: Integer;
        GLAccount: Record "G/L Account";
        CheckLedger: Record "Check Ledger Entry";
        CheckNo: Text[100];
        i: Integer;
        DimensionText: Text[500];
        ShowDimension: Boolean;
        DimensionValue: Record "Dimension Value";
        OldDoc: Code[30];
        Vendor: Record Vendor;
        SalesInvHeader: Record "Sales Invoice Header";
        CustName: Text[150];
        RefDoc: Code[20];
        Comment: Text[1024];
        TotalFor: Label '"Total for "';
        Text000: Label 'PURCHASES';
        TotalDebitAmount: Decimal;
        TotalCreditAmount: Decimal;
        SalesCN: Record "Sales Cr.Memo Header";
        AVCurrAmt: Decimal;
        ShowCurrRate: Text[30];
        CurrRate: Decimal;
        HeadReport: Text[100];
        HeadReportTH: Text[100];
}

