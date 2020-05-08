report 50055 "INT_Detail Trial Balance"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/DetailTrialBalance.rdl';
    AdditionalSearchTerms = 'payment due,order status';
    ApplicationArea = Basic, Suite;
    Caption = 'Detail Trial Balance';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("G/L Account"; "G/L Account")
        {
            DataItemTableView = WHERE("Account Type" = CONST(Posting));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Income/Balance", "Debit/Credit", "Date Filter";
            column(PeriodGLDtFilter; StrSubstNo(Text000, GLDateFilter))
            {
            }
            column(CompanyName; COMPANYPROPERTY.DisplayName)
            {
            }
            column(ExcludeBalanceOnly; ExcludeBalanceOnly)
            {
            }
            column(PrintReversedEntries; PrintReversedEntries)
            {
            }
            column(PageGroupNo; PageGroupNo)
            {
            }
            column(PrintClosingEntries; PrintClosingEntries)
            {
            }
            column(PrintOnlyCorrections; PrintOnlyCorrections)
            {
            }
            column(GLAccTableCaption; TableCaption + ': ' + GLFilter)
            {
            }
            column(GLFilter; GLFilter)
            {
            }
            column(EmptyString; '')
            {
            }
            column(No_GLAcc; "No.")
            {
            }
            column(DetailTrialBalCaption; DetailTrialBalCaptionLbl)
            {
            }
            column(PageCaption; PageCaptionLbl)
            {
            }
            column(BalanceCaption; BalanceCaptionLbl)
            {
            }
            column(PeriodCaption; PeriodCaptionLbl)
            {
            }
            column(OnlyCorrectionsCaption; OnlyCorrectionsCaptionLbl)
            {
            }
            column(NetChangeCaption; NetChangeCaptionLbl)
            {
            }
            column(GLEntryDebitAmtCaption; GLEntryDebitAmtCaptionLbl)
            {
            }
            column(GLEntryCreditAmtCaption; GLEntryCreditAmtCaptionLbl)
            {
            }
            column(GLBalCaption; GLBalCaptionLbl)
            {
            }
            column(Global_Dimension_1_Code; "Global Dimension 1 Code")
            {
            }

            dataitem(PageCounter; "Integer")
            {
                DataItemTableView = SORTING(Number) WHERE(Number = CONST(1));
                column(Name_GLAcc; "G/L Account".Name)
                {
                }
                column(StartBalance; StartBalance)
                {
                    AutoFormatType = 1;
                }
                dataitem("G/L Entry"; "G/L Entry")
                {
                    DataItemLink = "G/L Account No." = FIELD("No."), "Posting Date" = FIELD("Date Filter"), "Global Dimension 1 Code" = FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code" = FIELD("Global Dimension 2 Filter"), "Business Unit Code" = FIELD("Business Unit Filter");
                    DataItemLinkReference = "G/L Account";
                    DataItemTableView = SORTING("G/L Account No.", "Posting Date");
                    column(VATAmount_GLEntry; "VAT Amount")
                    {
                        IncludeCaption = true;
                    }
                    column(DebitAmount_GLEntry; "Debit Amount")
                    {
                    }
                    column(CreditAmount_GLEntry; "Credit Amount")
                    {
                    }
                    column(PostingDate_GLEntry; Format("Posting Date"))
                    {
                    }
                    column(DocumentNo_GLEntry; "Document No.")
                    {
                    }
                    column(ExtDocNo_GLEntry; "External Document No.")
                    {
                        IncludeCaption = true;
                    }
                    column(Description_GLEntry; Description)
                    {
                    }

                    column(GLBalance; GLBalance)
                    {
                        AutoFormatType = 1;
                    }
                    column(EntryNo_GLEntry; "Entry No.")
                    {
                    }
                    column(ClosingEntry; ClosingEntry)
                    {
                    }
                    column(Reversed_GLEntry; Reversed)
                    {
                    }
                    column(NameVC; NameVC)
                    {
                    }
                    column(Global_Dimension_2_Code; "Global Dimension 2 Code")
                    {
                    }
                    column(User_ID; "User ID")
                    {
                    }
                    trigger OnAfterGetRecord()
                    begin
                        if PrintOnlyCorrections then
                            if not (("Debit Amount" < 0) or ("Credit Amount" < 0)) then
                                CurrReport.Skip;
                        if not PrintReversedEntries and Reversed then
                            CurrReport.Skip;

                        GLBalance := GLBalance + Amount;
                        if ("Posting Date" = ClosingDate("Posting Date")) and
                           not PrintClosingEntries
                        then begin
                            "Debit Amount" := 0;
                            "Credit Amount" := 0;
                        end;

                        if "Posting Date" = ClosingDate("Posting Date") then
                            ClosingEntry := true
                        else
                            ClosingEntry := false;

                        Clear(DimensionValueTB);
                        DimensionValueTB.SetCurrentKey("Dimension Code", Code);
                        DimensionValueTB.SetRange("Dimension Code", 'COST CENTER');
                        DimensionValueTB.SetRange(Code, "Global Dimension 1 Code");
                        if DimensionValueTB.FindFirst then;

                        CLEAR(NameVC);
                        CLEAR(CustomerTB);
                        CLEAR(VendorTB);
                        if (COPYSTR(FORMAT("G/L Entry"."G/L Account No."), 1, 1) = '0') OR (COPYSTR(FORMAT("G/L Entry"."G/L Account No."), 1, 1) = '1') then begin
                            IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Vendor THEN BEGIN
                                IF VendorTB.GET("G/L Entry"."Source No.") THEN
                                    NameVC := VendorTB.Name;
                            END ELSE
                                IF "G/L Entry"."Source Type" = "G/L Entry"."Source Type"::Customer THEN BEGIN
                                    IF CustomerTB.GET("G/L Entry"."Source No.") THEN
                                        NameVC := CustomerTB.Name;
                                END ELSE begin
                                    Clear(DimSetEntry);
                                    DimSetEntry.SetRange("Dimension Set ID", "G/L Entry"."Dimension Set ID");
                                    DimSetEntry.SetRange("Dimension Code", 'VENDOR NO.');
                                    if DimSetEntry.FindFirst then begin
                                        IF VendorTB.GET(DimSetEntry."Dimension Value Code") THEN
                                            NameVC := VendorTB.Name;
                                    end else begin
                                        Clear(DimSetEntry);
                                        DimSetEntry.SetRange("Dimension Set ID", "G/L Entry"."Dimension Set ID");
                                        DimSetEntry.SetRange("Dimension Code", 'CUSTOMER NO.');
                                        if DimSetEntry.FindFirst then begin
                                            IF CustomerTB.GET(DimSetEntry."Dimension Value Code") THEN
                                                NameVC := CustomerTB.Name;
                                        end;
                                    END;

                                    IF (NameVC = '') AND ("Global Dimension 1 Code" <> '') THEN BEGIN
                                        NameVC := "Global Dimension 1 Code";
                                    END;
                                end;


                            //AVPKJINT.001 15/01/2020 Add Code
                            Clear(DimSetEntry);
                            Clear(DimSetEntry);
                            DimSetEntry.SetRange("Dimension Set ID", "G/L Entry"."Dimension Set ID");
                            DimSetEntry.SetRange("Dimension Code", 'CUSTOMER NO.');
                            if DimSetEntry.FindFirst then begin
                                IF CustomerTB.GET(DimSetEntry."Dimension Value Code") THEN
                                    NameVC := CustomerTB.Name;
                            end else begin
                                Clear(DimSetEntry);
                                DimSetEntry.SetRange("Dimension Set ID", "G/L Entry"."Dimension Set ID");
                                DimSetEntry.SetRange("Dimension Code", 'VENDOR NO.');
                                if DimSetEntry.FindFirst then begin
                                    IF VendorTB.GET(DimSetEntry."Dimension Value Code") THEN
                                        NameVC := VendorTB.Name;

                                end;

                                IF (NameVC = '') AND ("Global Dimension 1 Code" <> '') THEN BEGIN
                                    NameVC := "Global Dimension 1 Code" + ' : ' + DimensionValueTB.Name;
                                END;
                            end;
                            //C-AVPKJINT.001 15/01/2020


                        end;
                        IF (NameVC = '') AND ("Global Dimension 1 Code" <> '') THEN BEGIN
                            NameVC := "Global Dimension 1 Code" + ' : ' + DimensionValueTB.Name;
                        END;
                    end;

                    trigger OnPreDataItem()
                    begin
                        GLBalance := StartBalance;
                    end;
                }

                trigger OnAfterGetRecord()
                begin
                    CurrReport.PrintOnlyIfDetail := ExcludeBalanceOnly or (StartBalance = 0);
                end;
            }

            trigger OnAfterGetRecord()
            var
                GLEntry: Record "G/L Entry";
                Date: Record Date;
            begin
                StartBalance := 0;
                if GLDateFilter <> '' then begin
                    Date.SetRange("Period Type", Date."Period Type"::Date);
                    Date.SetFilter("Period Start", GLDateFilter);
                    if Date.FindFirst then begin
                        SetRange("Date Filter", 0D, ClosingDate(Date."Period Start" - 1));
                        CalcFields("Net Change");
                        StartBalance := "Net Change";
                        SetFilter("Date Filter", GLDateFilter);
                    end;
                end;

                if PrintOnlyOnePerPage then begin
                    GLEntry.Reset;
                    GLEntry.SetRange("G/L Account No.", "No.");
                    if CurrReport.PrintOnlyIfDetail and GLEntry.FindFirst then
                        PageGroupNo := PageGroupNo + 1;
                end;
            end;

            trigger OnPreDataItem()
            begin
                PageGroupNo := 1;
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
                    field(NewPageperGLAcc; PrintOnlyOnePerPage)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'New Page per G/L Acc.';
                        ToolTip = 'Specifies if each G/L account information is printed on a new page if you have chosen two or more G/L accounts to be included in the report.';
                    }
                    field(ExcludeGLAccsHaveBalanceOnly; ExcludeBalanceOnly)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Exclude G/L Accs. That Have a Balance Only';
                        MultiLine = true;
                        ToolTip = 'Specifies if you do not want the report to include entries for G/L accounts that have a balance but do not have a net change during the selected time period.';
                    }
                    field(InclClosingEntriesWithinPeriod; PrintClosingEntries)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Include Closing Entries Within the Period';
                        MultiLine = true;
                        ToolTip = 'Specifies if you want the report to include closing entries. This is useful if the report covers an entire fiscal year. Closing entries are listed on a fictitious date between the last day of one fiscal year and the first day of the next one. They have a C before the date, such as C123194. If you do not select this field, no closing entries are shown.';
                    }
                    field(IncludeReversedEntries; PrintReversedEntries)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Include Reversed Entries';
                        ToolTip = 'Specifies if you want to include reversed entries in the report.';
                    }
                    field(PrintCorrectionsOnly; PrintOnlyCorrections)
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Print Corrections Only';
                        ToolTip = 'Specifies if you want the report to show only the entries that have been reversed and their matching correcting entries.';
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
        PostingDateCaption = 'Posting Date';
        DocNoCaption = 'Document No.';
        DescCaption = 'Description';
        VATAmtCaption = 'VAT Amount';
        EntryNoCaption = 'Entry No.';
    }

    trigger OnPreReport()
    begin
        GLFilter := "G/L Account".GetFilters;
        GLDateFilter := "G/L Account".GetFilter("Date Filter");
    end;

    var
        Text000: Label 'Period: %1';
        GLDateFilter: Text;
        GLFilter: Text;
        GLBalance: Decimal;
        StartBalance: Decimal;
        PrintOnlyOnePerPage: Boolean;
        ExcludeBalanceOnly: Boolean;
        PrintClosingEntries: Boolean;
        PrintOnlyCorrections: Boolean;
        PrintReversedEntries: Boolean;
        PageGroupNo: Integer;
        ClosingEntry: Boolean;
        DetailTrialBalCaptionLbl: Label 'Detail Trial Balance';
        PageCaptionLbl: Label 'Page';
        BalanceCaptionLbl: Label 'This also includes general ledger accounts that only have a balance.';
        PeriodCaptionLbl: Label 'This report also includes closing entries within the period.';
        OnlyCorrectionsCaptionLbl: Label 'Only corrections are included.';
        NetChangeCaptionLbl: Label 'Net Change';
        GLEntryDebitAmtCaptionLbl: Label 'Debit';
        GLEntryCreditAmtCaptionLbl: Label 'Credit';
        GLBalCaptionLbl: Label 'Balance';
        CustomerTB: Record Customer;
        VendorTB: Record Vendor;
        NameVC: Text[250];
        DimSetEntry: Record "Dimension Set Entry";
        DimensionValueTB: Record "Dimension Value";


    procedure InitializeRequest(NewPrintOnlyOnePerPage: Boolean; NewExcludeBalanceOnly: Boolean; NewPrintClosingEntries: Boolean; NewPrintReversedEntries: Boolean; NewPrintOnlyCorrections: Boolean)
    begin
        PrintOnlyOnePerPage := NewPrintOnlyOnePerPage;
        ExcludeBalanceOnly := NewExcludeBalanceOnly;
        PrintClosingEntries := NewPrintClosingEntries;
        PrintReversedEntries := NewPrintReversedEntries;
        PrintOnlyCorrections := NewPrintOnlyCorrections;
    end;
}
