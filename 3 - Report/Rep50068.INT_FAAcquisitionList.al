report 50068 "INT_FA - Acquisition List"
{
    DefaultLayout = RDLC;
    //RDLCLayout = './FixedAssetAcquisitionList.rdlc';
    RDLCLayout = 'Rdlc/FixedAssetAcquisitionList.rdl';
    ApplicationArea = FixedAssets;
    Caption = 'Fixed Asset Acquisition List';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            RequestFilterFields = "No.", "FA Class Code", "FA Subclass Code", "Budgeted Asset";
            column(CompanyName; COMPANYPROPERTY.DisplayName)
            {
            }
            column(DeprBookText; DeprBookText)
            {
            }
            column(FixAssetTableCaptFaFilter; TableCaption + ': ' + FAFilter)
            {
            }
            column(No_FixedAsset; "No.")
            {
                IncludeCaption = true;
            }
            column(Desc_FixedAsset; Description)
            {
                IncludeCaption = true;
            }
            column(LocCode_FixedAsset; "FA Location Code")
            {
                IncludeCaption = true;
            }
            column(RespEmp_FixedAsset; "Responsible Employee")
            {
                IncludeCaption = true;
            }
            column(SerialNo_FixedAsset; "Serial No.")
            {
                IncludeCaption = true;
            }
            column(FaDeprBookAcquDate; Format(FADeprBook."Acquisition Date"))
            {
            }
            column(FixedAssetAcqListCptn; FixedAssetAcqListCptnLbl)
            {
            }
            column(CurrReportPageNoCaption; CurrReportPageNoCaptionLbl)
            {
            }
            column(FADeprBkAcquisitionDtCptn; FADeprBkAcquisitionDtCptnLbl)
            {
            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }
            column(DocNo_PurchInvLine; PurchInvLine."Document No.")
            {
            }
            column(AmountGLEntry; AmountGLEntry)
            {
            }
            column("Amountจ่าย"; "Amountจ่าย")
            {
            }
            column("Amountค้างจ่าย"; "Amountค้างจ่าย")
            {
            }
            Column(showGLAccount; AVFAPostGroup."Acquisition Cost Account")
            {
            }
            column(AVPaymentDate; showPaymentDate)
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(FADeprBook);
                PrintFA := false;
                if not FADeprBook.Get("No.", DeprBookCode) then begin
                    if FAWithoutAcqDate then
                        PrintFA := true;
                end else begin
                    if FADeprBook."Acquisition Date" = 0D then begin
                        if FAWithoutAcqDate then
                            PrintFA := true;
                    end else
                        PrintFA := (FADeprBook."Acquisition Date" >= StartingDate) and
                          (FADeprBook."Acquisition Date" <= EndingDate);
                end;
                if not PrintFA then
                    CurrReport.Skip;


                CLEAR(AVFAPostGroup);
                AVFAPostGroup.SetCurrentKey(AVFAPostGroup.Code);
                AVFAPostGroup.setrange(code, "Fixed Asset"."FA Posting Group");
                IF AVFAPostGroup.FindFirst() then;

                //AVPKJINT.001 20/01/2020
                Clear(PurchInvLine);
                PurchInvLine.SetCurrentKey("No.");
                PurchInvLine.SetRange(Type, PurchInvLine.Type::"Fixed Asset");
                PurchInvLine.SetRange("No.", "Fixed Asset"."No.");
                if PurchInvLine.FindLast then;

                CLEAR(AVFALedgerentry);
                CLEAR(showPaymentDate);
                AVFALedgerentry.SetCurrentKey("Entry No.");
                AVFALedgerentry.setrange("FA No.", "Fixed Asset"."no.");
                AVFALedgerentry.SetRange("FA Posting Type", AVFALedgerentry."FA Posting Type"::"Acquisition Cost");
                AVFALedgerentry.SetRange("Depreciation Book Code", DeprBookCode);
                IF AVFALedgerentry.FindLast() THEN BEGIN
                    IF COPYSTR(AVFALedgerentry."Document No.", 1, 2) = 'RE' THEN begin //Reclass
                        showPaymentDate := 'RECLASS';
                    END;

                END;



                Clear(AmountGLEntry);
                FADeprBook.CalcFields("Acquisition Cost");
                AmountGLEntry := FADeprBook."Acquisition Cost";

                CLEAR(AVVendorLedger);
                CLEAR(AVPaymentDate);
                AVVendorLedger.SetCurrentKey("Document No.");
                AVVendorLedger.SetRange("Document No.", AVFALedgerentry."Document No.");
                IF AVVendorLedger.FindFirst() THEN begin
                    CLEAR(AVDetailedVendorLedger);
                    AVDetailedVendorLedger.SetCurrentKey("Vendor Ledger Entry No.");
                    AVDetailedVendorLedger.SetRange("Vendor Ledger Entry No.", AVVendorLedger."Entry No.");
                    AVDetailedVendorLedger.SetRange("Document Type", AVDetailedVendorLedger."Document Type"::Payment);
                    IF AVDetailedVendorLedger.Findlast() THEN begin
                        AVPaymentDate := AVDetailedVendorLedger."Posting Date";
                    End;
                END;
                IF showPaymentDate = '' then
                    showPaymentDate := FORMAT(AVPaymentDate);
                /*Clear("Amountจ่าย");
                Clear("Amountค้างจ่าย");
                Clear(GLEntry);
                GLEntry.SetCurrentKey("Document No.");
                GLEntry.SetRange("Document No.", PurchInvLine."Document No.");
                //GLEntry.setrange(docu)
                if GLEntry.Find('-') then begin
                    repeat
                        //AmountGLEntry := GLEntry.Amount; Comment by pum
                        if GLEntry."Document Type" = GLEntry."Document Type"::Payment then begin
                            "Amountจ่าย" := GLEntry.Amount;
                            "Amountค้างจ่าย" := 0;
                        end else begin
                            "Amountค้างจ่าย" := GLEntry.Amount;
                            "Amountจ่าย" := 0;
                        end;
                    until GLEntry.Next = 0;
                end;
                */
                //C-AVPKJINT.001 20/01/2020
            end;
        }
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(DeprBookCode; DeprBookCode)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Depreciation Book';
                        TableRelation = "Depreciation Book";
                        ToolTip = 'Specifies the code for the depreciation book to be included in the report or batch job.';
                    }
                    group("Acquisition Period")
                    {
                        Caption = 'Acquisition Period';
                        field(StartingDate; StartingDate)
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Starting Date';
                            ToolTip = 'Specifies the date when you want the report to start.';
                        }
                        field(EndingDate; EndingDate)
                        {
                            ApplicationArea = FixedAssets;
                            Caption = 'Ending Date';
                            ToolTip = 'Specifies the date when you want the report to end.';
                        }
                    }
                    field(FAWithoutAcqDate; FAWithoutAcqDate)
                    {
                        ApplicationArea = FixedAssets;
                        Caption = 'Include Fixed Assets Not Yet Acquired';
                        ToolTip = 'Specifies if you want to include a fixed asset for which the first acquisition cost has not yet been posted.';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            if DeprBookCode = '' then begin
                FASetup.Get;
                DeprBookCode := FASetup."Default Depr. Book";
            end;
        end;
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        FAGenReport.AppendFAPostingFilter("Fixed Asset", StartingDate, EndingDate);
        FAFilter := "Fixed Asset".GetFilters;
        DeprBookText := StrSubstNo('%1%2 %3', DeprBook.TableCaption, ':', DeprBookCode);
        ValidateDates(StartingDate, EndingDate);
        FAGenReport.ValidateDates(StartingDate, EndingDate);
    end;

    var
        FASetup: Record "FA Setup";
        DeprBook: Record "Depreciation Book";
        FADeprBook: Record "FA Depreciation Book";
        FAGenReport: Codeunit "FA General Report";
        DeprBookCode: Code[10];
        DeprBookText: Text[50];
        FAFilter: Text;
        StartingDate: Date;
        EndingDate: Date;
        FAWithoutAcqDate: Boolean;
        PrintFA: Boolean;
        Text001: Label 'You must specify a Starting Date.';
        Text002: Label 'You must specify an Ending Date.';
        Text003: Label 'You must specify an Ending Date that is later than the Starting Date.';
        FixedAssetAcqListCptnLbl: Label 'Fixed Asset - Acquisition List';
        CurrReportPageNoCaptionLbl: Label 'Page';
        FADeprBkAcquisitionDtCptnLbl: Label 'Acquisition Date';
        PurchInvLine: Record "Purch. Inv. Line";
        GLEntry: Record "G/L Entry";
        AmountGLEntry: Decimal;
        Amountจ่าย: Decimal;
        Amountค้างจ่าย: Decimal;
        AVFAPostGroup: Record "FA Posting Group";
        AVPaymentDate: Date;
        AVVendorLedger: Record "Vendor Ledger Entry";
        AVDetailedVendorLedger: Record "Detailed Vendor Ledg. Entry";
        AVFALedgerentry: Record "FA Ledger Entry";
        showPaymentDate: Text[50];

    local procedure ValidateDates(StartingDate: Date; EndingDate: Date)
    begin
        if StartingDate = 0D then
            Error(Text001);

        if EndingDate = 0D then
            Error(Text002);

        if StartingDate > EndingDate then
            Error(Text003);
    end;
}
