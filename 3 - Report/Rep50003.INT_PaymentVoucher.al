report 50003 "INT_Payment Voucher"
{
    // version AVTHLC1.0

    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/Payment Voucher.rdl';
    Caption = 'Payment Journal Voucher';

    dataset
    {
        dataitem("Group by PV No."; "G/L Entry")
        {
            DataItemTableView = SORTING("Document No.") WHERE("Source Code" = FILTER('PAYMENTJNL|PURCHJNL'));
            //DataItemTableView = SORTING("Source Code","Document No.") WHERE("Source Code"=FILTER('PAYMENTJNL|PURCHJNL'));
            RequestFilterFields = "Document No.", "Posting Date", "Journal Batch Name";
            column(Comment; Comment)
            {
            }
            column(DocumentNo_GroupbyPVNo; "Group by PV No."."Document No.")
            {
            }
            column(TotalDebitAmount; TotalDebitAmount)
            {
            }
            column(TotalCreditAmount; TotalCreditAmount)
            {
            }
            column(NETTEXT1_NETTEXT2; NETTEXT[1] + ' ' + NETTEXT[2])
            {
            }
            column(NETPAID; -NETPAID)
            {
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                //DataItemTableView = SORTING("Source Code","Document No.") WHERE("Source Code"=FILTER('PAYMENTJNL|PURCHJNL'),Amount=FILTER(<>0));
                DataItemTableView = SORTING("Document No.") WHERE("Source Code" = FILTER('PAYMENTJNL|PURCHJNL'), Amount = FILTER(<> 0));
                column(CompanyInfoName; CompanyInfo.Name + ' ' + CompanyInfo."Name 2")
                {
                }
                column(SourceCodeDescription; SourceCode.Description + ' Voucher')
                {
                }
                column(PrintDate; FORMAT(TODAY, 0, '<Day,2>/<Month,2>/<Year4>') + '  ' + FORMAT(TIME, 0, '<Hours12>:<Minutes,2>:<Seconds,2> <AM/PM>'))
                {
                }
                column(UserID; USERID)
                {
                }
                column(PayTo; PayTo)
                {
                }
                column(Forpayment; Forpayment)
                {
                }
                column(ExternalNo; ExternalNo)
                {
                }
                column(DocDate; FORMAT("Document Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                {
                }
                column(DocumentNo; "Document No.")
                {
                }
                column(JournalBatchName; "Journal Batch Name")
                {
                }
                column(PostingDate; FORMAT("Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                {
                }
                column(CheckLedger_CheckDate; FORMAT(CheckLedger."Check Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                {
                }
                column(BankCode; BankCode)
                {
                }
                column(BankName; BankName)
                {
                }
                column(BankBranch; BankBranch)
                {
                }
                column(PCurr; PCurr)
                {
                }
                column(Rate; Rate)
                {
                }
                column(ExchangeRate; ExchangeRate)
                {
                }
                /* column(JournalBatchDescription;"Journal Batch Description")
                {
                } */
                column(Running; Running)
                {
                }
                column(GLAccountNo_GLAccountName; "G/L Account No." + ' - ' + GLAccount.Name)
                {
                }
                column(GLDesc; Description)
                {
                }
                column(DebitAmount; ROUND("Debit Amount", 0.01, '='))
                {
                }
                column(CreditAmount; ROUND("Credit Amount", 0.01, '='))
                {
                }
                column(xCash; xCash)
                {
                }
                column(xTransfer; xTransfer)
                {
                }
                column(xCredit; xCredit)
                {
                }
                column(xCheque; xCheque)
                {
                }
                column(CheckNo; CheckNo)
                {
                }
                column(ShowDTL; ShowDTL)
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
                    PrintOnlyifDetail = false;
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
                    if OldDocumentNo <> "Document No." then begin
                        CLEAR(Running);
                        CLEAR(TotalCreditAmount);
                        CLEAR(TotalDebitAmount);
                    end;
                    OldDocumentNo := "Document No.";

                    CLEAR(SourceCode);
                    SourceCode.SetRange(Code, "Source Code");
                    SourceCode.NEXT;

                    Running := Running + 1;

                    if ShowDTL then begin
                        TotalCreditAmount += ROUND("Credit Amount", 0.01, '=');
                        TotalDebitAmount += ROUND("Debit Amount", 0.01, '=');
                    end;
                    // Get G/L Account Description //
                    CLEAR(GLAccount);
                    GLAccount.SetRange("No.", "G/L Account No.");
                    GLAccount.NEXT;

                    if "G/L Account No." = BankAcctNo then
                        NETPAID := NETPAID + Amount;

                    if CheckNo <> '' then begin
                        CheckReport.InitTextVariable;
                        CheckReport.FormatNoText(NETTEXT, (-NETPAID), CurrencyCode);
                    end
                end;

                trigger OnPreDataItem();
                begin
                    CLEAR(NETPAID);
                    LastFieldNo := FIELDNO("Document No.");
                    CompanyInfo.GET;

                    // GET Date Filter For Showing in Page Header //
                    DateFilter := "G/L Entry".GETFILTER("Posting Date");
                    if DateFilter = '' then
                        DateHeader := ''
                    else begin
                        CLEAR(POS);
                        POS := STRPOS(DateFilter, '..');
                        if POS = 0 then begin
                            DateHeader := 'From ' + DateFilter + ' To ' + DateFilter;
                        end
                        else begin
                            DateHeader := 'From ' + COPYSTR(DateFilter, 1, POS - 1) + ' TO ' + COPYSTR(DateFilter, POS + 2, STRLEN(DateFilter));
                        end;
                    end;

                    //--------------------------------------------------------------------------------------------------------

                    CLEAR(ExchText);
                    CLEAR(PCurr);
                    CLEAR(PExch);
                    CLEAR(GLEntry);
                    CLEAR(BankName);
                    CLEAR(InPaymentOf);
                    CLEAR(ExchangeRate);

                    // GET Check No.
                    CLEAR(CheckLedger);
                    CLEAR(CheckNo);
                    CLEAR(OldCheck);
                    CheckLedger.SetRange("Document No.", "Group by PV No."."Document No.");
                    CheckLedger.NEXT;

                    //AVWCAVIP 18/03/14
                    for i := 1 to CheckLedger.COUNT do begin
                        if (OldCheck <> CheckLedger."Check No.") then
                            if CheckNo = '' then
                                CheckNo := CheckLedger."Check No."

                            else
                                CheckNo := CheckNo + ', ' + CheckLedger."Check No.";
                        CheckDate := CheckLedger."Check Date";
                        PayTo := CheckLedger."AVF_Pay-to Description";
                        OldCheck := CheckLedger."Check No.";
                        CheckLedger.NEXT;
                    end;
                    //AVWCAVIP 18/03/14
                    GLEntry.SetCurrentKey("Document No."); //AVSupport
                    GLEntry.SetRange("Document No.", "Group by PV No."."Document No.");
                    GLEntry.NEXT;
                    for a := 1 to GLEntry.COUNT do begin
                        CLEAR(BankCode);
                        //if (GLEntry."Bal. Account Type" = GLEntry."Bal. Account Type"::"Bank Account") AND (GLEntry.Amount > 0) then
                        //  BankCode := GLEntry."Bal. Account No."
                        //ELSE
                        //begin
                        if GLEntry."Source Type" = GLEntry."Source Type"::"Bank Account" then BankCode := GLEntry."Source No.";
                        //end;

                        //AVWCAVIP 18/03/14
                        if PayTo = '' then begin
                            if GLEntry."Source Type" = GLEntry."Source Type"::Vendor then
                                if recVendor.GET(GLEntry."Source No.") then
                                    if CopyStr(recVendor."No.", 1, 9) <> 'Z-ONETIME' then
                                        PayTo := recVendor.Name + ' ' + recVendor."Name 2";
                        end;
                        //AVWCAVIP 18/03/14

                        if PayTo = '' then
                            PayTo := GLEntry.Description;

                        if Forpayment = '' then
                            Forpayment := GLEntry."FNGN006_Jnl Batch Description";

                        if ExternalNo = '' then
                            ExternalNo := GLEntry."External Document No.";

                        if BankCode <> '' then begin
                            // Get BANK NAME
                            CLEAR(BankAccount);
                            BankAccount.SetRange("No.", BankCode);
                            BankAccount.NEXT;
                            BankName := BankAccount.Name + ' ' + BankAccount."Name 2";
                            //BankName := BankAccount."Bank Account Name";
                            //BankBranch := BankAccount."Bank Branch Name";
                            InPaymentOf := Description;
                            // Get BANK ACCOUNT
                            CLEAR(BankAcctPostingGroup);
                            BankAcctPostingGroup.SetRange(Code, BankAccount."Bank Acc. Posting Group");
                            BankAcctPostingGroup.NEXT;
                            BankAcctNo := BankAcctPostingGroup."G/L Account No.";
                        end;

                        PCurr := GLEntry."FNGN006_Currency Code";
                        if PCurr <> '' then
                            Rate := ROUND(1 / GLEntry."FNGN006_Org Currency Factor", 0.01, '=');
                        /*
                        if GLEntry."Bal. Account Type" = GLEntry."Bal. Account Type"::Vendor then begin
                          CLEAR(VendLedgEntry1);
                          VendLedgEntry1.SetRange("Document No.",GLEntry."Document No.");
                          if VendLedgEntry1.FIND('-') then
                          repeat
                            if i < 5 then begin
                              i := i + 1;
                              if VendLedgEntry1."Currency Code" <> '' then begin
                                if VendLedgEntry1."Adjusted Currency Factor" <> 0 then begin
                                  PExch[i] := ROUND(1/VendLedgEntry1."Adjusted Currency Factor",0.00001,'=');
                                end;
                                PCurr := COPYSTR(VendLedgEntry1."Currency Code",1,3);
                                ExchText := 'EXCH. RATE'
                              end;
                            end;
                          UNTIL(VendLedgEntry1.NEXT = 0);
                          FOR i := 1 TO 4 DO begin
                            FOR j := i+1 TO 5 DO begin
                              if PExch[i] = PExch[j] then
                                PExch[j] := 0;
                            end;
                          end;
                          CLEAR(ExchangeRate);
                          FOR i := 1 TO 5 DO begin
                            if PExch[i] <> 0 then begin
                              if ExchangeRate = '' then
                                ExchangeRate := FORMAT(PExch[i])
                              ELSE
                                ExchangeRate := ExchangeRate + ', ' + FORMAT(PExch[i]);
                            end;
                          end;
                        end;
                        */

                        GLEntry.NEXT;
                    end;

                    /*
                    // GET Check No.
                    CLEAR(CheckLedger);
                    CLEAR(CheckNo);
                    CLEAR(OldCheck);
                    CheckLedger.SetRange("Document No.","Group by PV No."."Document No.");
                    CheckLedger.NEXT;
                    
                    FOR i := 1 TO CheckLedger.COUNT DO
                    begin
                      if (OldCheck <> CheckLedger."Check No.") then
                        if CheckNo = '' then
                          CheckNo := CheckLedger."Check No."
                    
                        ELSE
                          CheckNo := CheckNo + ', ' + CheckLedger."Check No.";
                        CheckDate := CheckLedger."Check Date";
                        PayTo     := CheckLedger."Pay-to Description";
                      OldCheck := CheckLedger."Check No.";
                      CheckLedger.NEXT;
                    end;
                    */

                end;
            }
            dataitem("Find Applied Entry"; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(TmpTBVendLedgerApplied_VendorNo; TmpTBVendLedgerApplied."Vendor No.")
                {
                }
                column(TmpTBVendLedgerApplied_DocumentNo; TmpTBVendLedgerApplied."Document No.")
                {
                }
                column(TmpTBVendLedgerApplied_ExternalDocumentNo; TmpTBVendLedgerApplied."External Document No.")
                {
                }
                column(TmpTBVendLedgerApplied_Description; TmpTBVendLedgerApplied.Description)
                {
                }
                column(AVAmountFCY; AVAmountFCY)
                {
                }
                column(ExchRate; ExchRate)
                {
                }
                column(AVDetailedVendorLedger_AmountLCY; AVDetailedVendorLedger."Amount (LCY)")
                {
                }
                column(AmountLangB1_AmountLangB2; AmountLangB[1] + ' ' + AmountLangB[2])
                {
                }
                column(InvAMT; InvAMT)
                {
                }
                column(ShowFindAppliedEntry; ShowFindAppliedEntry)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    CountApplied += 1;
                    if CountApplied <> 1 then
                        TmpTBVendLedgerApplied.NEXT;

                    ShowFindAppliedEntry := true;
                    CLEAR(AVAmountFCY);
                    CLEAR(ExchRate);
                    CLEAR(AVDetailedVendorLedger);
                    AVDetailedVendorLedger.SetCurrentKey("Entry No.");
                    AVDetailedVendorLedger.SetRange("Entry No.", TmpTBVendLedgerApplied."Reversed Entry No.");
                    AVDetailedVendorLedger.SetRange("Vendor Ledger Entry No.", TmpTBVendLedgerApplied."Reversed by Entry No.");
                    AVDetailedVendorLedger.SetRange("Document No.", "G/L Entry"."Document No.");
                    if AVDetailedVendorLedger.FindFirst then begin
                        if TmpTBVendLedgerApplied."Currency Code" <> '' then begin
                            if TmpTBVendLedgerApplied."Adjusted Currency Factor" <> 0 then begin
                                ExchRate := ROUND(1 / TmpTBVendLedgerApplied."Adjusted Currency Factor", 0.01, '=');
                                AVAmountFCY := ROUND(AVDetailedVendorLedger.Amount);
                            end;
                        end;
                    end;

                    CLEAR(InvWHTEntry);
                    CLEAR(b);
                    InvWHTEntry.SetCurrentKey(InvWHTEntry."Document No.");
                    InvWHTEntry.SetRange("Document No.", TmpTBVendLedgerApplied."Document No.");
                    InvWHTEntry.SetRange("Original Document No.", "G/L Entry"."Document No.");
                    InvWHTEntry.NEXT;
                    for b := 1 to InvWHTEntry.COUNT do begin
                        WHTAMT := WHTAMT + InvWHTEntry."Amount (LCY)";
                        InvWHTEntry.NEXT;
                    end;

                    InvAMT := InvAMT + AVDetailedVendorLedger."Amount (LCY)";

                    CheckReport.InitTextVariable;
                    CheckReport.FormatNoText(AmountLangB, InvAMT - WHTAMT, CurrencyCode);
                end;

                trigger OnPreDataItem();
                begin
                    CLEAR(CountApplied);
                    CLEAR(AllApplied);
                    CLEAR(WHTAMT);
                    CLEAR(InvAMT);


                    if (OldDocApplied <> "Group by PV No."."Document No.") then begin
                        FindApplnEntriesDtldtLedgEntry;
                    end;

                    if TmpTBVendLedgerApplied.FindFirst then begin end;

                    SetRange(Number, 1, AllApplied);

                    OldDocApplied := "Group by PV No."."Document No.";
                end;
            }

            trigger OnAfterGetRecord();
            begin
                if OldPV <> "Document No." then begin
                    ShowDTL := true;
                    ShowInv := false;
                    CLEAR(ExternalNo);
                    CLEAR(PayTo);
                    CLEAR(Forpayment);
                end else begin
                    ShowDTL := false;
                    CurrReport.SKIP;
                end;
                OldPV := "Document No.";


                CLEAR(GLENTB);
                //AVSupport
                //GLENTB.SetCurrentKey("Entry No.");
                GLENTB.SetCurrentKey("Document No.");
                //C-AVSupport
                GLENTB.SetRange("Document No.", "Document No.");
                GLENTB.SetRange("Source Type", "Source Type"::"Bank Account");
                if GLENTB.FindFirst then begin

                    CLEAR(xCheque);
                    CLEAR(xCash);
                    CLEAR(xTransfer);
                    CLEAR(xCredit);

                    if GLENTB."FNGN005_Type of Payment" = GLENTB."FNGN005_Type of Payment"::Check then
                        xCheque := 'X'
                    else
                        if GLENTB."FNGN005_Type of Payment" = GLENTB."FNGN005_Type of Payment"::Cash then
                            xCash := 'X'
                        else
                            if GLENTB."FNGN005_Type of Payment" = GLENTB."FNGN005_Type of Payment"::Transfer then
                                xTransfer := 'X'
                            else
                                if GLENTB."FNGN005_Type of Payment" = GLENTB."FNGN005_Type of Payment"::"Credit Card" then
                                    xCredit := 'X';
                end;

                //ShowFindAppliedEntry:=FALSE;
            end;

            trigger OnPreDataItem();
            begin
                CLEAR(OldDocApplied);
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
        CurrencyCodeCaption = 'Currency Code'; PageCaption = 'Page'; DocDateCaption = 'Document Date'; EmailCaption = 'E-Mail'; HomePageCaption = 'Home Page';
    }

    var
        LastFieldNo: Integer;
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
        OldDoc: Code[20];
        BankAccount: Record "Bank Account";
        BankCode: Code[20];
        GLEntry: Record "G/L Entry";
        InPaymentOf: Text[100];
        BankName: Text[100];
        Vendor: Record Vendor;
        PayTo: Text[1000];
        a: Integer;
        WHTEntry: Record "AVF_WHT Entry";
        OldVend: Text[100];
        OldPV: Code[20];
        ShowDTL: Boolean;
        InvWHTEntry: Record "AVF_WHT Entry";
        b: Integer;
        WHTAMT: Decimal;
        InvAMT: Decimal;
        VendLedgEntry1: Record "Vendor Ledger Entry";
        VendLedgEntry2: Record "Vendor Ledger Entry";
        ShowInv: Boolean;
        c1: Integer;
        c2: Integer;
        AmountLangB: array[2] of Text[80];
        CheckReport: Report Check;
        CurrencyCode: Text[30];
        OldPayto: Text[100];
        PVClosedBy: Boolean;
        OldDocNo: Code[20];
        BankAcctPostingGroup: Record "Bank Account Posting Group";
        BankAcctNo: Code[20];
        NETPAID: Decimal;
        NETTEXT: array[2] of Text[80];
        OldCheck: Code[20];
        ExchRate: Decimal;
        ExchText: Text[50];
        CheckDate: Date;
        Comment: Text[1024];
        PCurr: Text[30];
        PExch: array[5] of Decimal;
        DtlVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        "IAmt(LCY)": Decimal;
        "IAmt(FCY)": Decimal;
        Line: Integer;
        InvLine: Integer;
        j: Integer;
        ExchangeRate: Text[30];
        AVVendLedger: Record "Vendor Ledger Entry";
        AllApplied: Integer;
        TmpTBVendLedgerApplied: Record "Vendor Ledger Entry" temporary;
        CountApplied: Integer;
        AVDetailedVendorLedger: Record "Detailed Vendor Ledg. Entry";
        AVAmountFCY: Decimal;
        AVGLEntry: Record "G/L Entry";
        OldDocApplied: Code[20];
        BankBranch: Text[60];
        xCredit: Text[2];
        xCheque: Text[2];
        xCash: Text[2];
        xTransfer: Text[2];
        GLENTB: Record "G/L Entry";
        OldDocumentNo: Text[30];
        TotalDebitAmount: Decimal;
        TotalCreditAmount: Decimal;
        ShowFindAppliedEntry: Boolean;
        Forpayment: Text[50];
        ExternalNo: Text[50];
        recVendor: Record Vendor;
        Rate: Decimal;

    procedure FindApplnEntriesDtldtLedgEntry();
    var
        DtldVendLedgEntry0: Record "Detailed Vendor Ledg. Entry";
        DtldVendLedgEntry1: Record "Detailed Vendor Ledg. Entry";
        DtldVendLedgEntry2: Record "Detailed Vendor Ledg. Entry";
    begin
        CLEAR(TmpTBVendLedgerApplied);
        TmpTBVendLedgerApplied.DELETEALL;

        CLEAR(AVGLEntry);
        AVGLEntry.SetCurrentKey(AVGLEntry."Source Code", AVGLEntry."Document No.");
        AVGLEntry.SetRange(AVGLEntry."Document No.", "Group by PV No."."Document No.");
        if AVGLEntry.FindFirst then begin
            repeat
                CLEAR(DtldVendLedgEntry1);
                DtldVendLedgEntry1.SetCurrentKey("Vendor Ledger Entry No.");
                //DtldVendLedgEntry1.SetRange("Document No.",DtldVendLedgEntry0."Document No.");
                DtldVendLedgEntry1.SetRange("Vendor Ledger Entry No.", AVGLEntry."Entry No.");
                DtldVendLedgEntry1.SetRange(Unapplied, false);
                if DtldVendLedgEntry1.FIND('-') then begin
                    repeat
                        if DtldVendLedgEntry1."Vendor Ledger Entry No." =
                          DtldVendLedgEntry1."Applied Vend. Ledger Entry No."
                        then begin
                            DtldVendLedgEntry2.Init;
                            DtldVendLedgEntry2.SetCurrentKey("Applied Vend. Ledger Entry No.", "Entry Type");
                            DtldVendLedgEntry2.SetRange(
                              "Applied Vend. Ledger Entry No.", DtldVendLedgEntry1."Applied Vend. Ledger Entry No.");
                            DtldVendLedgEntry2.SetRange("Entry Type", DtldVendLedgEntry2."Entry Type"::Application);
                            DtldVendLedgEntry2.SetRange(Unapplied, false);
                            if DtldVendLedgEntry2.FIND('-') then begin
                                repeat
                                    if DtldVendLedgEntry2."Vendor Ledger Entry No." <>
                                       DtldVendLedgEntry2."Applied Vend. Ledger Entry No."
                                    then begin
                                        AVVendLedger.SetCurrentKey("Entry No.");
                                        AVVendLedger.SetRange("Entry No.", DtldVendLedgEntry2."Vendor Ledger Entry No.");
                                        if AVVendLedger.FIND('-') then begin
                                            CLEAR(TmpTBVendLedgerApplied);
                                            AllApplied += 1;
                                            TmpTBVendLedgerApplied.Init;
                                            TmpTBVendLedgerApplied.TRANSFERFIELDS(AVVendLedger);
                                            TmpTBVendLedgerApplied."Reversed by Entry No." := AVVendLedger."Entry No.";
                                            TmpTBVendLedgerApplied."Reversed Entry No." := DtldVendLedgEntry2."Entry No.";
                                            TmpTBVendLedgerApplied."Entry No." := AllApplied;

                                            TmpTBVendLedgerApplied.INSERT;
                                        end;
                                    end;
                                until DtldVendLedgEntry2.NEXT = 0;
                            end;
                        end else begin
                            AVVendLedger.SetCurrentKey("Entry No.");
                            AVVendLedger.SetRange("Entry No.", DtldVendLedgEntry1."Applied Vend. Ledger Entry No.");
                            if AVVendLedger.FIND('-') then begin
                                CLEAR(TmpTBVendLedgerApplied);
                                AllApplied += 1;
                                TmpTBVendLedgerApplied.Init;
                                TmpTBVendLedgerApplied.TRANSFERFIELDS(AVVendLedger);
                                TmpTBVendLedgerApplied."Reversed by Entry No." := AVVendLedger."Entry No.";
                                TmpTBVendLedgerApplied."Reversed Entry No." := DtldVendLedgEntry1."Entry No.";
                                TmpTBVendLedgerApplied."Entry No." := AllApplied;
                                TmpTBVendLedgerApplied.INSERT;

                            end;
                        end;
                    until DtldVendLedgEntry1.NEXT = 0;
                end;
            until AVGLEntry.NEXT = 0;
        end;
    end;
}

