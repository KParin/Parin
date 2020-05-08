report 50066 "INT_A/R Movement"
{
    // version AVTHLC1.0

    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/AR Movement.rdl';
    CaptionML = ENU = 'INT_A/R Movement';
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No.");
                DataItemTableView = SORTING("Posting Date", "Document Type", "Document No.");
                RequestFilterFields = "Customer No.", "Posting Date";


                column(UserId; USERID)
                {
                }
                column(PrintDate; FORMAT(TODAY, 0, 1) + ' ' + FORMAT(TIME, 0, '<Hours12>:<Minutes,2>:<Seconds,2> <AM/PM>'))
                {
                }
                column(ShowCustLine; ShowCustLine)
                {
                }
                column(CustomerNo_CustLedgerEntry; "Cust. Ledger Entry"."Customer No.")
                {
                }
                column(EntryNo_CustLedgerEntry; "Cust. Ledger Entry"."Entry No.")
                {
                }
                column(CompanyInfo_Name; CompanyInfo.Name)
                {
                }
                column(FilHead; FilHead)
                {
                }
                column(Customer_No; Customer."No.")
                {
                }
                column(Customer_Name; Customer.Name + ' ' + Customer."Name 2")
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
                column(PostingDate_CustLedgerEntry; FORMAT("Cust. Ledger Entry"."Posting Date", 0, 1))
                {
                }

                column(DocumentType_CustLedgerEntry; "Cust. Ledger Entry"."Document Type")
                {
                }
                column(DocType; DocType)
                {
                }
                column(DocumentNo_CustLedgerEntry; "Cust. Ledger Entry"."Document No.")
                {
                }
                column(DueDate_CustLedgerEntry; FORMAT("Cust. Ledger Entry"."Due Date", 0, 1))
                {
                }
                column(TaxInv; TaxInv)
                {
                }
                column(DebitAmount_CustLedgerEntry; "Cust. Ledger Entry"."Debit Amount (LCY)")
                {
                }
                column(CreditAmount_CustLedgerEntry; "Cust. Ledger Entry"."Credit Amount (LCY)")
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
                column(CheckAmount; CheckAmount)
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
                column(CheckLedgEntry_Amount; CheckLedgEntry.Amount)
                {
                }
                column(PostingDate_Sort; "Cust. Ledger Entry"."Posting Date")
                {
                }

                column(CustLedgEntry_Description; Description)
                {
                }
                dataitem("RV Head"; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(GLAccountNo; GLAccountNo)
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
                        //Clear(GLEntryTB);
                        //GLEntryTB.SetCurrentKey("Entry No.");
                        //GLEntryTB.SetRange("Entry No.", "Cust. Ledger Entry"."Entry No.");
                        //if GLEntryTB.FindFirst then begin
                        //    GLAccountNo := GLEntryTB."G/L Account No.";
                        //    //Message('GLAccountNo : %1', GLAccountNo);
                        //end;
                        CLEAR(GLAccountNo);
                        CLEAR(AVCustomer);
                        AVCustomer.SetCurrentKey("No.");
                        AVCustomer.SetRange("No.", "Cust. Ledger Entry"."Customer No.");
                        IF AVCustomer.FindFirst() THEN begin
                            AVCustomerPostGroup.SetCurrentKey(Code);
                            AVCustomerPostGroup.SetRange(code, AVCustomer."Customer Posting Group");
                            IF AVCustomerPostGroup.FindFirst() then
                                GLAccountNo := AVCustomerPostGroup."Receivables Account";


                        end;
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
                dataitem("Closed at Invoice"; "Cust. Ledger Entry")
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
                    column(Description_ClosedatInvoice; "Closed at Invoice".Description)
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
                        //AVNPEPS.01
                        if ("Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::Payment)
                           and ("Document Type" = "Document Type"::Payment) then begin
                            ShowClosedatInvoice := false;
                        end;
                        //C-AVNPEPS.01
                    end;

                    trigger OnPreDataItem();
                    begin
                        if ("Cust. Ledger Entry"."Document Type" <> "Cust. Ledger Entry"."Document Type"::Payment) then
                            SETRANGE("Entry No.", 0);
                    end;
                }
                dataitem("Closed at Payment"; "Cust. Ledger Entry")
                {
                    DataItemLink = "Entry No." = FIELD("Closed by Entry No.");
                    DataItemTableView = SORTING("Document No.", "Document Type", "Customer No.");
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
                    column(ClosedbyAmountLCY_ClosedatPayment; "Closed at Payment"."Closed by Amount (LCY)")
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        ShowClosedatPayment := true;
                        //AVNPEPS.01
                        if ("Cust. Ledger Entry"."Document Type" = "Cust. Ledger Entry"."Document Type"::Payment)
                           and ("Document Type" = "Document Type"::Payment) then begin
                            ShowClosedatPayment := false;
                        end;
                        //C-AVNPEPS.01
                    end;

                    trigger OnPreDataItem();
                    begin
                        if ("Cust. Ledger Entry"."Document Type" <> "Cust. Ledger Entry"."Document Type"::Payment) then
                            SETRANGE("Entry No.", 0);
                    end;
                }
                dataitem("Applied to ID"; "Cust. Ledger Entry")
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
                    column(PostingDate_AppliedtoID; FORMAT("Applied to ID"."Posting Date", 0, 1))
                    {
                    }
                    column(INVAmount_AppliedtoID; INVAmount)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        ShowAppliedtoID := true;
                        CLEAR(SalesInvLine);
                        CLEAR(INVAmount);
                        SalesInvLine.SETRANGE("Document No.", "Document No.");
                        if SalesInvLine.FIND('-') then
                            repeat
                                INVAmount := INVAmount + SalesInvLine."Amount Including VAT";
                            until (SalesInvLine.NEXT = 0);
                    end;

                    trigger OnPreDataItem();
                    begin
                        if ("Cust. Ledger Entry"."Document Type" <> "Cust. Ledger Entry"."Document Type"::Payment) then
                            SETRANGE("Entry No.", 0);
                    end;
                }
                dataitem("Applied to Invoice"; "Cust. Ledger Entry")
                {
                    DataItemLink = "Document No." = FIELD("Applies-to Doc. No.");
                    DataItemTableView = SORTING("Entry No.");
                    column(ShowAppliedtoInvoice; ShowAppliedtoInvoice)
                    {
                    }
                    column(ExternalDocumentNo_AppliedtoInvoice; "Applied to Invoice"."External Document No.")
                    {
                    }
                    column(DocumentNo_AppliedtoInvoice; "Applied to Invoice"."Document No.")
                    {
                    }
                    column(PostingDate_AppliedtoInvoice; FORMAT("Applied to Invoice"."Posting Date", 0, 1))
                    {
                    }
                    column(INVAmount_AppliedtoInvoice; INVAmount)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        ShowAppliedtoInvoice := true;
                        CLEAR(SalesInvLine);
                        CLEAR(INVAmount);
                        SalesInvLine.SETRANGE("Document No.", "Document No.");
                        if SalesInvLine.FIND('-') then
                            repeat
                                INVAmount := INVAmount + SalesInvLine."Amount Including VAT";
                            until (SalesInvLine.NEXT = 0);
                    end;

                    trigger OnPreDataItem();
                    begin
                        if ("Cust. Ledger Entry"."Document Type" <> "Cust. Ledger Entry"."Document Type"::Payment) then
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
                    /*
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
                            KeepCheckAmt[i] := recCheck.Amount;
                        until (recCheck.NEXT = 0) or (i >= 300);
                    end;
                    */
                    Clear(BankLedEntry);
                    BankLedEntry.SetCurrentKey("Entry No.");
                    BankLedEntry.SetRange("Document No.", "Document No.");
                    if BankLedEntry.FindSet() then begin
                        repeat
                            i += 1;
                            KeepCheckText[1] [i] := BankLedEntry."FNGN005_Check No.";
                            KeepCheckDate[i] := BankLedEntry."FNGN005_Check Date";
                            KeepCheckText[2] [i] := BankLedEntry."FNGN005_Bank Branch - Cheque";
                            KeepCheckAmt[i] := BankLedEntry."Amount (LCY)";
                        until (BankLedEntry.NEXT = 0) or (i >= 300);
                    end;

                    CountHead[2] := i;

                    //==========================================================================================================
                    ShowCustLine := true;
                    CLEAR(TaxInv);
                    if ("Document Type" = "Document Type"::Invoice) or ("Document Type" = "Document Type"::"Credit Memo") then
                        TaxInv := "Document No.";

                    RemainAmt := RemainAmt + ("Debit Amount (LCY)" - "Credit Amount (LCY)");

                    /*
                  {
                  CLEAR(CheckLedgEntry);
                  CLEAR(CheckAmount);
                  CLEAR(CashAmount);
                  CLEAR(TransAmount);
                  CLEAR(NameBranch);

                  CheckLedgEntry.SETRANGE("Document No.","Document No.");
                  IF CheckLedgEntry.FIND('-') THEN BEGIN
                    CheckAmount := -CheckLedgEntry.Amount;
                    IF (CheckLedgEntry."Bank Name - Cheque" = '') AND (CheckLedgEntry."Bank Branch - Cheque" = '') THEN
                      NameBranch := ''
                    ELSE
                      NameBranch := CheckLedgEntry."Bank Name - Cheque" + '/' + CheckLedgEntry."Bank Branch - Cheque";
                  END ELSE BEGIN
                    //AVNPMFP.01 080807
                   // CashAmount := -Amount;
                    IF ("Document Type" = "Document Type"::Payment) AND ("Bal. Account Type"="Bal. Account Type"::"Bank Account") THEN
                      IF(("Bal. Account No."='CASH') OR ("Bal. Account No."='PETTY CASH')) THEN BEGIN
                        CashAmount := -Amount;
                      END ELSE BEGIN
                        TransAmount := -Amount;
                        BankAcct.GET("Bal. Account No.");
                        NameBranch := BankAcct.Name;
                      END;
                    //C-AVNPMFP.01
                  END;
                  }
                  //AVNSDSTD  02/04/2014  Comment Old Code

                  //AVNPMFP.01 100807
                  //RemainAmt:=RemainAmt+"Debit Amount"-"Credit Amount";
                  //C-AVNPMFP.01

                  //C-AVNSDSTD  02/04/2014  Comment Old Code






                  //AVNSDSTD 02/04/2014 Change Field From Debit Amount to Debit Amount (LCY) & From Credit Amount to Credit Amount (LCY)
                  RemainAmt:=RemainAmt+"Debit Amount (LCY)"-"Credit Amount (LCY)";
                  //C-AVNSDSTD 02/04/2014 Change Field From Debit Amount to Debit Amount (LCY) & From Credit Amount to Credit Amount (LCY)
                  */

                    DocType := "Document Type";

                    //----------------------------------------------------------------------------------------------------//

                    if ("Document Type" = "Document Type"::Payment) then begin
                        CLEAR(CustLedgCheck);
                        CustLedgCheck.SETRANGE("Closed by Entry No.", "Entry No.");
                        if CustLedgCheck.FIND('-') then begin
                            if CustLedgCheck."Document Type" = CustLedgCheck."Document Type"::Payment then begin
                                ShowCustLine := false;
                            end;
                        end;
                        CLEAR(CustLedgCheck);
                        CustLedgCheck.SETRANGE("Entry No.", "Closed by Entry No.");
                        if CustLedgCheck.FIND('-') then begin
                            if CustLedgCheck."Document Type" = CustLedgCheck."Document Type"::Payment then begin
                                ShowCustLine := false;
                            end;
                        end;
                    end;
                    //C-AVNPEPS.01

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
                    IF GETFILTER("Customer No.") <> '' THEN BEGIN
                      FilHead := FilHead + 'จากรหัสลูกหนี้  ' + GETFILTER("Customer No.");
                    END ELSE
                      FilHead := FilHead + 'จากรหัสลูกหนี้ทั้งหมด';
                    */

                    PMonth := Thai.MonthWords('T', DATE2DMY(TODAY, 2));
                    PYear := DATE2DMY(TODAY, 3) + 543;
                    //AVNPMFP.01 14-08-07
                    if MemPageNo = 0 then begin
                        //MemPageNo := CurrReport.PAGENO;
                        TxtDisplay001 := 'ยอดหนี้คงเหลือ';
                        TxtDisplay002 := ':';
                    end else begin
                        CLEAR(TxtDisplay001);
                        CLEAR(TxtDisplay002);
                        CLEAR(AllRemainAmt);
                    end;
                    //C-AVNPMFP.01

                end;
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR(Salesperson);
                if "Salesperson Code" <> '' then
                    Salesperson.GET("Salesperson Code");
                //AVNPMFP.01 14-08-07
                CLEAR(SumAmt);
                CLEAR(RemainAmt);
                CLEAR(AllRemainAmt);
                CLEAR(MemPageNo);
                CLEAR(CustLedgEntry1);
                CustLedgEntry1.SETRANGE("Customer No.", "No.");
                CustLedgEntry1.SETFILTER("Document Type", 'Invoice|Payment|Credit Memo|%1', CustLedgEntry1."Document Type"::" ");
                CustLedgEntry1.SETFILTER("Posting Date", '<%1', GetMinFilter);
                if CustLedgEntry1.FIND('-') then begin
                    repeat
                        CustLedgEntry1.CALCFIELDS("Amount (LCY)");
                        SumAmt := SumAmt + CustLedgEntry1."Amount (LCY)";
                    until CustLedgEntry1.NEXT = 0;
                    RemainAmt := SumAmt;
                end;
                CLEAR(DrAmt);
                CLEAR(CrAmt);
                CLEAR(CustLedgEntry2);
                CustLedgEntry2.SETRANGE("Customer No.", "No.");
                CustLedgEntry2.SETFILTER("Document Type", 'Invoice|Payment|Credit Memo|%1', CustLedgEntry2."Document Type"::" ");
                CustLedgEntry2.SETFILTER("Posting Date", GetDateFilter);
                if CustLedgEntry2.FIND('-') then begin
                    repeat
                        //AVNSDSTD  02/04/2014  Comment Old Code
                        //CustLedgEntry2.CALCFIELDS("Debit Amount","Credit Amount");
                        //DrAmt := DrAmt + CustLedgEntry2."Debit Amount";
                        //CrAmt := CrAmt + CustLedgEntry2."Credit Amount";
                        //C-AVNSDSTD  02/04/2014  Comment Old Code

                        //AVNSDSTD  02/04/2014  Change Field From Debit Amount to Debit Amount (LCY) & From Credit Amount to Credit Amount (LCY)
                        CustLedgEntry2.CALCFIELDS("Debit Amount (LCY)", "Credit Amount (LCY)");
                        DrAmt := DrAmt + CustLedgEntry2."Debit Amount (LCY)";
                        CrAmt := CrAmt + CustLedgEntry2."Credit Amount (LCY)";
                    //AVNSDSTD  02/04/2014  Change Field From Debit Amount to Debit Amount (LCY) & From Credit Amount to Credit Amount (LCY)

                    until CustLedgEntry2.NEXT = 0;
                    AllRemainAmt := SumAmt + (DrAmt - CrAmt);
                end;
                //C-AVNPMFP.01





            end;

            trigger OnPreDataItem();
            begin
                if GetCusFilter <> '' then
                    SETFILTER("No.", GetCusFilter);

                CLEAR(CompanyInfo);
                CompanyInfo.GET;
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
        FilHead := "Cust. Ledger Entry".GETFILTERS;
        GetCusFilter := "Cust. Ledger Entry".GETFILTER("Customer No.");
        GetDateFilter := "Cust. Ledger Entry".GETFILTER("Posting Date");
        GetMinFilter := "Cust. Ledger Entry".GETRANGEMIN("Posting Date");
        if GetMinFilter = 0D then
            GetMinFilter := TODAY;
    end;

    var
        CompanyInfo: Record "Company Information";
        PMonth: Text[30];
        PYear: Integer;
        Thai: Codeunit AVF_Thai;
        POS: Integer;
        "Filter": Text[100];
        FilHead: Text[1024];
        D1: Date;
        Salesperson: Record "Salesperson/Purchaser";
        TaxInv: Text[50];
        CheckLedgEntry: Record "Check Ledger Entry";
        CheckAmount: Decimal;
        CashAmount: Decimal;
        TransAmount: Decimal;
        NameBranch: Text[150];
        SalesInvLine: Record "Sales Invoice Line";
        INVAmount: Decimal;
        CustLedgCheck: Record "Cust. Ledger Entry";
        CntRunning: Integer;
        GetCusFilter: Text[250];
        GetDateFilter: Text[250];
        SumAmt: Decimal;
        CustLedgEntry1: Record "Cust. Ledger Entry";
        CustLedgEntry2: Record "Cust. Ledger Entry";
        BankAcct: Record "Bank Account";
        GetMinFilter: Date;
        RemainAmt: Decimal;
        DrAmt: Decimal;
        CrAmt: Decimal;
        MemPageNo: Integer;
        AllRemainAmt: Decimal;
        TxtDisplay001: Text[30];
        TxtDisplay002: Text[10];
        ShowCustLine: Boolean;
        ShowClosedatInvoice: Boolean;
        ShowClosedatPayment: Boolean;
        ShowAppliedtoID: Boolean;
        ShowAppliedtoInvoice: Boolean;
        DocType: Option;
        "AAAAAAA-------------------------------------------------------------------------------------": Integer;
        CountHead: array[4] of Integer;
        KeepBankAmt: array[4, 300] of Decimal;
        KeepCheckText: array[2, 300] of Text[100];
        KeepCheckDate: array[300] of Date;
        KeepCheckAmt: array[300] of Decimal;
        KeepBankText: array[2, 300] of Text[100];
        recBank: Record "Bank Account Ledger Entry";
        recCheck: Record "Check Ledger Entry";
        BankLedEntry: Record "Bank Account Ledger Entry";
        recGL: Record "G/L Entry";
        i: Integer;
        SumCC: array[5] of Decimal;
        GLEntryTB: Record "G/L Entry";
        GLAccountNo: code[20];
        AVCustomerPostGroup: Record "Customer Posting group";
        AVCustomer: Record Customer;
}

