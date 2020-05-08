report 50067 "INT_A/P Movement"
{
    // version AVTHLC1.0

    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/AP Movement.rdl';
    CaptionML = ENU = 'INT_A/P Movement';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem(Vendor; Vendor)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                CalcFields = Amount, "Debit Amount (LCY)", "Credit Amount (LCY)";
                DataItemLink = "Vendor No." = FIELD("No.");
                DataItemTableView = SORTING("Posting Date", "Document Type", "Document No.");
                RequestFilterFields = "Vendor No.", "Posting Date";


                column(VendorNo_VendorLedgerEntry; "Vendor Ledger Entry"."Vendor No.")
                {
                }
                column(EntryNo_VendorLedgerEntry; "Vendor Ledger Entry"."Entry No.")
                {
                }
                column(ShowVendorLedgerEntry; ShowVendorLedgerEntry)
                {
                }
                column(FilHead; FilHead)
                {
                }
                column(UserId; USERID)
                {
                }
                column(PrintDate; FORMAT(TODAY, 0, 1) + ' ' + FORMAT(TIME, 0, '<Hours12>:<Minutes,2>:<Seconds,2> <AM/PM>'))
                {
                }
                column(CompanyInfo_Name; CompanyInfo.Name)
                {
                }
                column(Vendor_No; Vendor."No.")
                {
                }
                column(Vendor_Name; Vendor.Name + ' ' + Vendor."Name 2")
                {
                }
                column(TxtDisplay001; TxtDisplay001)
                {
                }
                column(TxtDisplay002; TxtDisplay002)
                {
                }
                column(AllRemainAmt; AllRemainAmt)
                {
                }
                column(SumAmt; SumAmt)
                {
                }
                column(PostingDate_VendorLedgerEntry; FORMAT("Vendor Ledger Entry"."Posting Date", 0, 1))
                {
                }
                column(DocumentType_VendorLedgerEntry; "Vendor Ledger Entry"."Document Type")
                {
                }
                column(DocType; DocType)
                {
                }
                column(DocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."Document No.")
                {
                }
                column(DueDate_VendorLedgerEntry; FORMAT("Vendor Ledger Entry"."Due Date", 0, 1))
                {
                }
                column(ExternalDocumentNo_VendorLedgerEntry; "Vendor Ledger Entry"."External Document No.")
                {
                }
                column(DebitAmountLCY_VendorLedgerEntry; "Vendor Ledger Entry"."Debit Amount (LCY)")
                {
                }
                column(CreditAmountLCY_VendorLedgerEntry; "Vendor Ledger Entry"."Credit Amount (LCY)")
                {
                }
                column(RemainAmt; RemainAmt)
                {
                }
                column(CashAmount; CashAmount)
                {
                }
                column(TransAmount; TransAmount)
                {
                }
                column(CheckAmount; -CheckAmount)
                {
                }
                column(CheckLedgEntry_CheckNo; CheckLedgEntry."Check No.")
                {
                }
                column(CheckLedgEntry_CheckDate; FORMAT(CheckLedgEntry."Check Date", 0, 1))
                {
                }
                column(NameBranch; NameBranch)
                {
                }
                column(CheckLedgEntry_Amount; -CheckLedgEntry.Amount)
                {
                }
                column(PostingDate_Sort; "Vendor Ledger Entry"."Posting Date")
                {
                }
                dataitem("RV Head"; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(GLAccountNo; GLEntryTB."G/L Account No.")
                    {
                    }
                    column(Number_RVHead; "RV Head".Number)
                    {
                    }
                    column(RV_CashAmt; KeepBankAmt[1] [Number])
                    {
                    }
                    column(RV_SumCheckAmt; KeepBankAmt[2] [Number])
                    {
                    }
                    column(RV_CreditCardAmt; KeepBankAmt[3] [Number])
                    {
                    }
                    column(RV_TransferAmt; KeepBankAmt[4] [Number])
                    {
                    }
                    column(RV_BankCode; KeepBankText[1] [Number])
                    {
                    }
                    column(RV_CheckNo; KeepCheckText[1] [Number])
                    {
                    }
                    column(RV_CheckDate; FORMAT(KeepCheckDate[Number], 0, 1))
                    {
                    }
                    column(RV_CheckBranch; KeepCheckText[2] [Number])
                    {
                    }
                    column(RV_CheckAmt; KeepCheckAmt[Number])
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        //CustLine:=FALSE;
                        //CustGLLine:=FALSE;
                        Clear(GLEntryTB);
                        GLEntryTB.SetCurrentKey("Entry No.");
                        GLEntryTB.SetRange("Entry No.", "Vendor Ledger Entry"."Entry No.");
                        if GLEntryTB.FindFirst then;
                    end;

                    trigger OnPreDataItem();
                    begin
                        if (CountHead[1] <> 0) or (CountHead[2] <> 0) or (CountHead[3] <> 0) or (CountHead[4] <> 0) then begin
                            if (CountHead[1] >= CountHead[2]) and
                               (CountHead[1] >= CountHead[3]) and
                               (CountHead[1] >= CountHead[4]) then
                                SETRANGE(Number, 1, CountHead[1])
                            else
                                if (CountHead[2] >= CountHead[1]) and
                                   (CountHead[2] >= CountHead[3]) and
                                   (CountHead[2] >= CountHead[4]) then
                                    SETRANGE(Number, 1, CountHead[2])
                                else
                                    if (CountHead[3] >= CountHead[1]) and
                                       (CountHead[3] >= CountHead[2]) and
                                       (CountHead[3] >= CountHead[4]) then
                                        SETRANGE(Number, 1, CountHead[3])
                                    else
                                        if (CountHead[4] >= CountHead[1]) and
                                           (CountHead[4] >= CountHead[2]) and
                                           (CountHead[4] >= CountHead[4]) then
                                            SETRANGE(Number, 1, CountHead[4]);
                        end else
                            SETRANGE(Number, 1, 0);
                    end;
                }
                dataitem("Closed at Invoice"; "Vendor Ledger Entry")
                {
                    DataItemLink = "Closed by Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Entry No.");
                    column(ShowClosedatInvoice; ShowClosedatInvoice)
                    {
                    }
                    column(DocumentNo_ClosedatInvoice; "Closed at Invoice"."Document No.")
                    {
                    }
                    column(ExternalDocumentNo_ClosedatInvoice; "Closed at Invoice"."External Document No.")
                    {
                    }
                    column(PostingDate_ClosedatInvoice; FORMAT("Closed at Invoice"."Posting Date", 0, 1))
                    {
                    }
                    column(ClosedbyAmountLCY_ClosedatInvoice; "Closed at Invoice"."Closed by Amount (LCY)")
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        ShowClosedatInvoice := true;
                        if ("Vendor Ledger Entry"."Document Type" = "Vendor Ledger Entry"."Document Type"::Payment)
                           and ("Document Type" = "Document Type"::Payment) then begin
                            ShowClosedatInvoice := false;
                        end;
                    end;

                    trigger OnPreDataItem();
                    begin
                        if ("Vendor Ledger Entry"."Document Type" <> "Vendor Ledger Entry"."Document Type"::Payment) then
                            SETRANGE("Entry No.", 0);
                    end;
                }
                dataitem("Closed at Payment"; "Vendor Ledger Entry")
                {
                    DataItemLink = "Entry No." = FIELD("Closed by Entry No.");
                    DataItemTableView = SORTING("Document No.", "Document Type", "Vendor No.");
                    column(ShowClosedatPayment; ShowClosedatPayment)
                    {
                    }
                    column(DocumentNo_ClosedatPayment; "Closed at Payment"."Document No.")
                    {
                    }
                    column(ExternalDocumentNo_ClosedatPayment; "Closed at Payment"."External Document No.")
                    {
                    }
                    column(PostingDate_ClosedatPayment; FORMAT("Closed at Payment"."Posting Date", 0, 1))
                    {
                    }
                    column(VendorLedgerEntry_ClosedbyAmountLCY; "Vendor Ledger Entry"."Closed by Amount (LCY)")
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        ShowClosedatPayment := true;
                        if ("Vendor Ledger Entry"."Document Type" = "Vendor Ledger Entry"."Document Type"::Payment)
                           and ("Document Type" = "Document Type"::Payment) then begin
                            ShowClosedatPayment := false;
                        end;
                    end;

                    trigger OnPreDataItem();
                    begin
                        if ("Vendor Ledger Entry"."Document Type" <> "Vendor Ledger Entry"."Document Type"::Payment) then
                            SETRANGE("Entry No.", 0);
                    end;
                }
                dataitem("Applied to ID"; "Vendor Ledger Entry")
                {
                    DataItemLink = "Applies-to ID" = FIELD("Document No.");
                    DataItemTableView = SORTING("Entry No.");
                    column(ShowAppliedtoID; ShowAppliedtoID)
                    {
                    }
                    column(DocumentNo_AppliedtoID; "Applied to ID"."Document No.")
                    {
                    }
                    column(ExternalDocumentNo_AppliedtoID; "Applied to ID"."External Document No.")
                    {
                    }
                    column(PostingDate_AppliedtoID; FORMAT("Applied to ID"."Posting Date", 0, 2))
                    {
                    }
                    column(INVAmount_ApptoID; INVAmount)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        ShowAppliedtoID := true;
                        CLEAR(PurchInvLine);
                        CLEAR(INVAmount);
                        PurchInvLine.SETRANGE("Document No.", "Document No.");
                        if PurchInvLine.FIND('-') then
                            repeat
                                INVAmount := INVAmount + PurchInvLine."Amount Including VAT";
                            until (PurchInvLine.NEXT = 0);
                    end;

                    trigger OnPreDataItem();
                    begin
                        if ("Vendor Ledger Entry"."Document Type" <> "Vendor Ledger Entry"."Document Type"::Payment) then
                            SETRANGE("Entry No.", 0);
                    end;
                }
                dataitem("Applied to Invoice"; "Vendor Ledger Entry")
                {
                    DataItemLink = "Document No." = FIELD("Applies-to Doc. No.");
                    DataItemTableView = SORTING("Entry No.");
                    column(ShowAppliedtoInvoice; ShowAppliedtoInvoice)
                    {
                    }
                    column(DocumentNo_AppliedtoInvoice; "Applied to Invoice"."Document No.")
                    {
                    }
                    column(ExternalDocumentNo_AppliedtoInvoice; "Applied to Invoice"."External Document No.")
                    {
                    }
                    column(PostingDate_AppliedtoInvoice; FORMAT("Applied to Invoice"."Posting Date", 0, 1))
                    {
                    }
                    column(INVAmount_ApptoInvoice; INVAmount)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        ShowAppliedtoInvoice := true;
                        CLEAR(PurchInvLine);
                        CLEAR(INVAmount);
                        PurchInvLine.SETRANGE("Document No.", "Document No.");
                        if PurchInvLine.FIND('-') then
                            repeat
                                INVAmount := INVAmount + PurchInvLine."Amount Including VAT";
                            until (PurchInvLine.NEXT = 0);
                    end;

                    trigger OnPreDataItem();
                    begin
                        if ("Vendor Ledger Entry"."Document Type" <> "Vendor Ledger Entry"."Document Type"::Payment) then
                            SETRANGE("Entry No.", 0);
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(KeepBankAmt);
                    CLEAR(KeepCheckText);
                    CLEAR(KeepCheckDate);
                    CLEAR(KeepCheckAmt);
                    //CLEAR(KeepGLAmt);
                    CLEAR(KeepBankText);

                    CLEAR(CountHead);
                    CLEAR(i);
                    CLEAR(SumCC);

                    CLEAR(recBank);
                    recBank.SETCURRENTKEY("Entry No.");
                    recBank.SETRANGE("Document No.", "Document No.");
                    if recBank.FIND('-') then begin
                        repeat
                            if recBank."FNGN005_Type of Payment" = recBank."FNGN005_Type of Payment"::Cash then begin
                                i += 1;
                                if recBank.Amount < 0 then
                                    KeepBankAmt[1] [i] := (-1) * recBank.Amount
                                else
                                    KeepBankAmt[1] [i] := recBank.Amount;
                                SumCC[1] += ABS(recBank.Amount);
                            end else
                                if recBank."FNGN005_Type of Payment" = recBank."FNGN005_Type of Payment"::Check then begin
                                    if recBank.Amount < 0 then
                                        KeepBankAmt[2] [1] += (-1) * recBank.Amount//Sum At First Line
                                    else
                                        KeepBankAmt[2] [1] += recBank.Amount;//Sum At First Line
                                    SumCC[2] += ABS(recBank.Amount);
                                end else
                                    if recBank."FNGN005_Type of Payment" = recBank."FNGN005_Type of Payment"::"Credit Card" then begin
                                        if recBank.Amount < 0 then
                                            KeepBankAmt[3] [1] += (-1) * recBank.Amount//Sum At First Line
                                        else
                                            KeepBankAmt[3] [1] += recBank.Amount;//Sum At First Line
                                        SumCC[3] += ABS(recBank.Amount);
                                    end else
                                        if recBank."FNGN005_Type of Payment" = recBank."FNGN005_Type of Payment"::Transfer then begin
                                            if recBank.Amount < 0 then
                                                KeepBankAmt[4] [1] += (-1) * recBank.Amount//Sum At First Line
                                            else
                                                KeepBankAmt[4] [1] += recBank.Amount;//Sum At First Line
                                            SumCC[4] += ABS(recBank.Amount);
                                            recGL.SETRANGE("Document No.", recBank."Document No.");
                                            recGL.SETRANGE("FNGN005_Type of Payment", recGL."FNGN005_Type of Payment"::Transfer);
                                            if recGL.FIND('-') then begin
                                                repeat
                                                    KeepBankText[1] [1] := recGL."Source No.";
                                                until recGL.NEXT = 0;
                                            end;
                                        end;
                        until (recBank.NEXT = 0) or (i >= 300);
                    end;
                    if i <> 0 then
                        CountHead[1] := i
                    else
                        CountHead[1] := 1;

                    CLEAR(i);
                    CLEAR(recCheck);
                    recCheck.SETCURRENTKEY("Document No.", "Posting Date");
                    recCheck.SETRANGE("Document No.", "Document No.");
                    if recCheck.FIND('-') then begin
                        repeat
                            i += 1;
                            KeepCheckText[1] [i] := recCheck."Check No.";
                            KeepCheckDate[i] := recCheck."Check Date";
                            KeepCheckText[2] [i] := recCheck."FNGN005_Bank Branch - Cheque";
                            KeepCheckAmt[i] := -recCheck.Amount;
                        until (recCheck.NEXT = 0) or (i >= 300);
                    end;

                    CountHead[2] := i;


                    //=====================================================================================================
                    ShowVendorLedgerEntry := true;
                    CLEAR(TaxInv);
                    if ("Document Type" = "Document Type"::Invoice) or ("Document Type" = "Document Type"::"Credit Memo") then
                        TaxInv := "Document No.";

                    RemainAmt := RemainAmt + ("Debit Amount (LCY)" - "Credit Amount (LCY)");

                    /*
                    CLEAR(CheckLedgEntry);
                    CLEAR(CheckAmount);
                    CLEAR(CashAmount);
                    CLEAR(TransAmount);
                    CLEAR(NameBranch);
                    CheckLedgEntry.SETRANGE("Document No.","Document No.");
                    IF CheckLedgEntry.FIND('-') THEN BEGIN
                      CheckAmount := CheckLedgEntry.Amount;
                      NameBranch := CheckLedgEntry."Bank Name - Cheque" + '/' + CheckLedgEntry."Bank Branch - Cheque";
                    END ELSE BEGIN
                      //AVNPMFP.01 080807
                     // CashAmount := -Amount;
                      IF ("Document Type" = "Document Type"::Payment) AND ("Bal. Account Type"="Bal. Account Type"::"Bank Account") THEN
                        IF(("Bal. Account No."='CASH') OR ("Bal. Account No."='PETTY CASH')) THEN BEGIN
                          CashAmount := -Amount
                        END ELSE BEGIN
                          TransAmount := -Amount;
                          BankAcct.GET("Bal. Account No.");
                          NameBranch:=BankAcct.Name;
                        END;
                      //C-AVNPMFP.01
                    END;
                    //AVNPMFP.01 100807
                    RemainAmt:=RemainAmt+("Debit Amount (LCY)"-"Credit Amount (LCY)");
                    //C-AVNPMFP.01
                    */
                    //------------------------------------------------------------------------------------//

                    DocType := "Document Type";

                    if ("Document Type" = "Document Type"::Payment) then begin
                        CLEAR(CustLedgCheck);
                        CustLedgCheck.SETRANGE("Closed by Entry No.", "Entry No.");
                        if CustLedgCheck.FIND('-') then begin
                            if CustLedgCheck."Document Type" = CustLedgCheck."Document Type"::Payment then begin
                                ShowVendorLedgerEntry := false;
                            end;
                        end;
                        CLEAR(CustLedgCheck);
                        CustLedgCheck.SETRANGE("Entry No.", "Closed by Entry No.");
                        if CustLedgCheck.FIND('-') then begin
                            if CustLedgCheck."Document Type" = CustLedgCheck."Document Type"::Payment then begin
                                ShowVendorLedgerEntry := false;
                            end;
                        end;
                    end;

                end;

                trigger OnPreDataItem();
                begin
                    /*
                    CLEAR(Filter);
                    IF GETFILTER("Posting Date") <> '' THEN BEGIN
                      Filter := GETFILTER("Posting Date");
                      CLEAR(POS);
                      POS := STRPOS(Filter,'..');
                      IF POS > 0 THEN BEGIN
                        FilHead := 'จากวันที่  ';
                        IF POS <> 1 THEN BEGIN
                          EVALUATE(D1,COPYSTR(Filter,1,POS-1));
                          FilHead := FilHead + FORMAT(D1,0,'<Day,2> ') + Thai.MonthWords('T',DATE2DMY(D1,2)) + ' ' + FORMAT(DATE2DMY(D1,3)+543);
                        END;
                        FilHead := FilHead + '  ถึง  ';
                        EVALUATE(D1,COPYSTR(Filter,POS+2,STRLEN(Filter)));
                        FilHead := FilHead + FORMAT(D1,0,'<Day,2> ') + Thai.MonthWords('T',DATE2DMY(D1,2)) + ' ' + FORMAT(DATE2DMY(D1,3)+543);
                      END ELSE BEGIN
                        EVALUATE(D1,Filter);
                        FilHead := 'วันที่  ' + FORMAT(D1,0,'<Day,2> ') + Thai.MonthWords('T',DATE2DMY(D1,2)) + ' ' + FORMAT(DATE2DMY(D1,3)+543);
                      END;
                    END ELSE
                      FilHead := 'จากวันที่ทั้งหมด';
                    
                    FilHead := FilHead + '      ';
                    CLEAR(Filter);
                    IF GETFILTER("Vendor No.") <> '' THEN BEGIN
                      FilHead := FilHead + 'จากรหัสเจ้าหนี้  ' + GETFILTER("Vendor No.");
                    END ELSE
                      FilHead := FilHead + 'จากรหัสเจ้าหนี้ทั้งหมด';
                    */

                    PMonth := Thai.MonthWords('T', DATE2DMY(TODAY, 2));
                    PYear := DATE2DMY(TODAY, 3) + 543;
                    if MemPageNo = 0 then begin
                        //MemPageNo := CurrReport.PAGENO;
                        TxtDisplay001 := 'ยอดหนี้คงเหลือ';
                        TxtDisplay002 := ':';
                    end else begin
                        CLEAR(TxtDisplay001);
                        CLEAR(TxtDisplay002);
                        CLEAR(AllRemainAmt);
                    end;

                end;
            }

            trigger OnAfterGetRecord();
            begin

                CLEAR(SumAmt);
                CLEAR(RemainAmt);
                CLEAR(VendLedgEntry);
                CLEAR(AllRemainAmt);
                VendLedgEntry.SETRANGE("Vendor No.", "No.");
                VendLedgEntry.SETFILTER("Document Type", 'Invoice|Payment|Credit Memo|%1', VendLedgEntry."Document Type"::" ");
                VendLedgEntry.SETFILTER("Posting Date", '<%1', GetMinFilter);
                if VendLedgEntry.FIND('-') then begin
                    repeat
                        VendLedgEntry.CALCFIELDS("Amount (LCY)");
                        SumAmt := SumAmt + VendLedgEntry."Amount (LCY)";
                    until VendLedgEntry.NEXT = 0;
                    RemainAmt := SumAmt;
                end;
                CLEAR(MemPageNo);
                CLEAR(DrAmt);
                CLEAR(CrAmt);
                CLEAR(VendLedgEntry1);
                VendLedgEntry1.SETRANGE("Vendor No.", "No.");
                VendLedgEntry1.SETFILTER("Document Type", 'Invoice|Payment|Credit Memo|%1', VendLedgEntry1."Document Type"::" ");
                VendLedgEntry1.SETFILTER("Posting Date", GetDateFilter);
                if VendLedgEntry1.FIND('-') then begin
                    repeat
                        VendLedgEntry1.CALCFIELDS("Debit Amount (LCY)", "Credit Amount (LCY)");
                        DrAmt := DrAmt + VendLedgEntry1."Debit Amount (LCY)";
                        CrAmt := CrAmt + VendLedgEntry1."Credit Amount (LCY)";
                    until VendLedgEntry1.NEXT = 0;
                    AllRemainAmt := SumAmt + (DrAmt - CrAmt);
                end;



            end;

            trigger OnPreDataItem();
            begin
                CLEAR(CompanyInfo);
                CompanyInfo.GET;

                if GetVendFilter <> '' then
                    SETFILTER("No.", GetVendFilter);
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        FilHead := "Vendor Ledger Entry".GETFILTERS;
        GetVendFilter := "Vendor Ledger Entry".GETFILTER("Vendor No.");
        GetDateFilter := "Vendor Ledger Entry".GETFILTER("Posting Date");
        GetMinFilter := "Vendor Ledger Entry".GETRANGEMIN("Posting Date");
        if GetMinFilter = 0D then
            GetMinFilter := TODAY;
    end;

    var
        CompanyInfo: Record "Company Information";
        CheckLedgEntry: Record "Check Ledger Entry";
        PurchInvLine: Record "Purch. Inv. Line";
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendLedgEntry1: Record "Vendor Ledger Entry";
        CustLedgCheck: Record "Cust. Ledger Entry";
        Thai: Codeunit AVF_Thai;
        GetMinFilter: Date;
        D1: Date;
        POS: Integer;
        "Filter": Text[100];
        FilHead: Text[1024];
        GetVendFilter: Text[250];
        GetDateFilter: Text[250];
        TaxInv: Text[50];
        NameBranch: Text[150];
        CheckAmount: Decimal;
        CashAmount: Decimal;
        TransAmount: Decimal;
        INVAmount: Decimal;
        RemainAmt: Decimal;
        SumAmt: Decimal;
        PMonth: Text[30];
        PYear: Integer;
        CustLedgEntry2: Record "Cust. Ledger Entry";
        DrAmt: Decimal;
        CrAmt: Decimal;
        MemPageNo: Integer;
        AllRemainAmt: Decimal;
        TxtDisplay001: Text[30];
        TxtDisplay002: Text[10];
        BankAcct: Record "Bank Account";
        ShowVendorLedgerEntry: Boolean;
        ShowClosedatInvoice: Boolean;
        ShowClosedatPayment: Boolean;
        ShowAppliedtoID: Boolean;
        ShowAppliedtoInvoice: Boolean;
        DocType: Option;
        DateFilters: Text[50];
        "AAAAAAA-------------------------------------------------------------------------------------": Integer;
        CountHead: array[4] of Integer;
        KeepBankAmt: array[4, 300] of Decimal;
        KeepCheckText: array[2, 300] of Text[100];
        KeepCheckDate: array[300] of Date;
        KeepCheckAmt: array[300] of Decimal;
        KeepBankText: array[2, 300] of Text[100];
        recBank: Record "Bank Account Ledger Entry";
        recCheck: Record "Check Ledger Entry";
        recGL: Record "G/L Entry";
        i: Integer;
        SumCC: array[5] of Decimal;
        GLEntryTB: Record "G/L Entry";
}

