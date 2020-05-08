report 50076 "INT_AR Aging"
{
    // version AVTHLC1.0

    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/AR Aging.rdl';
    CaptionML = ENU = 'AR Aging';
    dataset
    {
        dataitem(Customer; Customer)
        {
            DataItemTableView = SORTING("No.");
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Customer Posting Group", "Statistics Group", "Payment Terms Code", "Responsibility Center", "Currency Filter";
            column(CusFilter; CusFilter)
            {
            }
            column(No_Customer; Customer."No.")
            {
            }
            column(CompanyInfoName; CompanyInfo.FNGN001_NameEng + ' ' + CompanyInfo."FNGN001_NameEng 2")
            {
            }
            column(DatePrint; 'Printed Date : ' + FORMAT(TODAY, 0, 1) + ' ' + FORMAT(TIME, 0, '<Hours12>:<Minutes,2>:<Second,2> <AM/PM>'))
            {
            }
            column(ACCOUNTS_RECEIVABLE; 'ACCOUNTS RECEIVABLE ')
            {
            }
            column(AGING_ANALYSIS_AS_OF; 'AGING ANALYSIS AS OF ' + UPPERCASE(FORMAT(AsOfDate, 0, '<Month Text> <Day>, <Year4>')))
            {
            }
            column(GTAmt; GTAmt)
            {
            }
            column(GTAmtCurr; GTAmtCurr)
            {
            }
            column(GTAmt130; GTAmt130)
            {
            }
            column(GTAmt3160; GTAmt3160)
            {
            }
            column(GTAmt6190; GTAmt6190)
            {
            }
            column(GTAmt91120; GTAmt91120)
            {
            }
            column(GTAmt121; GTAmt121)
            {
            }
            column(GTTotalAmount; FORMAT(GTTotalAmount, 0, '<Precision,2:2><Standard Format,0>'))
            {
            }
            column(GCODE_1; COPYSTR(GCODE[1], 1, 3))
            {
            }
            column(GCODE_2; COPYSTR(GCODE[2], 1, 3))
            {
            }
            column(GCODE_3; COPYSTR(GCODE[3], 1, 3))
            {
            }
            column(GCODE_4; COPYSTR(GCODE[4], 1, 3))
            {
            }
            column(GCODE_5; COPYSTR(GCODE[5], 1, 3))
            {
            }
            column(GCODE_6; COPYSTR(GCODE[6], 1, 3))
            {
            }
            column(GCODE_7; COPYSTR(GCODE[7], 1, 3))
            {
            }
            column(GCODE_8; COPYSTR(GCODE[8], 1, 3))
            {
            }
            column(GCURR_1; GCURR[1])
            {
            }
            column(GCURR_2; GCURR[2])
            {
            }
            column(GCURR_3; GCURR[3])
            {
            }
            column(GCURR_4; GCURR[4])
            {
            }
            column(GCURR_5; GCURR[5])
            {
            }
            column(GCURR_6; GCURR[6])
            {
            }
            column(GCURR_7; GCURR[7])
            {
            }
            column(GCURR_8; GCURR[8])
            {
            }
            column(Range1; Range1)
            {
            }
            column(Range2; Range2)
            {
            }
            column(Range3; Range3)
            {
            }
            column(Range4; Range4)
            {
            }
            column(Range5; Range5)
            {
            }
            column(ExchRate; ExchRate)
            {
            }
            column(STotal; STotal)
            {
            }
            column(GTotal; GTotal)
            {
            }
            column(TotalAMT; TotalAMT)
            {
            }
            column(TotalLCY; TotalLCY)
            {
            }
            dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
            {
                CalcFields = Amount;
                DataItemLink = "Customer No." = FIELD("No."), "Currency Code" = FIELD("Currency Filter");
                DataItemTableView = SORTING("Customer No.", "Posting Date", "Currency Code") ORDER(Ascending) WHERE("Document Type" = FILTER(Invoice | "Credit Memo"));
                column(Customer_Name; Customer.Name)
                {
                }
                column(EntryNo_CustLedgerEntry; "Cust. Ledger Entry"."Entry No.")
                {
                }
                column(CustomerNo_CustLedgerEntry; "Cust. Ledger Entry"."Customer No.")
                {
                }
                column(SumAMTApp; SumAMTApp)
                {
                }
                column(GLAccountNo; GLAccountNo)
                {
                }
                dataitem("Detailed Cust. Ledg. Entry";
                "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Cust. Ledger Entry No.", "Document No.") ORDER(Ascending);
                    column(EntryNo_DetailedCustLedgEntry; "Detailed Cust. Ledg. Entry"."Entry No.")
                    {
                    }
                    column(CustLedgerEntry_DocumentNo; "Cust. Ledger Entry"."Document No.")
                    {
                    }
                    column(CustLedgerEntry_DocumentDate; "Cust. Ledger Entry"."Document Date")
                    {
                    }
                    column(CustLedgerEntry_DueDate; "Cust. Ledger Entry"."Due Date")
                    {
                    }
                    column(GetPayTerms; GetPayTerms("Document No.", "Document Type", CurrencyCode))
                    {
                    }
                    column(AltCode; AltCode)
                    {
                    }
                    column(AltCurrency; SumAMTApp)
                    {
                    }
                    column(AmtCurr; AmtCurr)
                    {
                    }
                    column(ShowOverDue; ShowOverDue)
                    {
                    }
                    column(Amt130; Amt130)
                    {
                    }
                    column(Amt3160; Amt3160)
                    {
                    }
                    column(Amt6190; Amt6190)
                    {
                    }
                    column(Amt91120; Amt91120)
                    {
                    }
                    column(Amt121; Amt121)
                    {
                    }
                    column(TotalAmount; TotalAmount)
                    {
                    }
                    column(STAmt; STAmt)
                    {
                    }
                    column(STAmtCurr; STAmtCurr)
                    {
                    }
                    column(STAmt130; STAmt130)
                    {
                    }
                    column(STAmt3160; STAmt3160)
                    {
                    }
                    column(STAmt6190; STAmt6190)
                    {
                    }
                    column(STAmt91120; STAmt91120)
                    {
                    }
                    column(STAmt121; STAmt121)
                    {
                    }
                    column(STTotalAmount; STTotalAmount)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        CLEAR(AVShowSalePersonName);
                        CLEAR(AVSalePerson);
                        AVSalePerson.SETCURRENTKEY(AVSalePerson.Code);
                        AVSalePerson.SETRANGE(AVSalePerson.Code, "Cust. Ledger Entry"."Salesperson Code");
                        if AVSalePerson.FINDFIRST then
                            AVShowSalePersonName := AVSalePerson.Name;

                        //AVSSM
                        if "Amount (LCY)" = 0 then
                            CurrReport.SKIP;

                        AmtCurrency := SumAMTApp;
                        //AVSSM

                        //check if overdue

                        if OldDoc <> "Cust. Ledger Entry"."Document No." then begin
                            CLEAR(ShowOverDue);
                            if "Cust. Ledger Entry"."Due Date" >= AsOfDate then
                                AmtCurr := SumAMTlcyApp
                            else begin
                                NumDays := AsOfDate - "Cust. Ledger Entry"."Due Date";
                                if ((NumDays > 0) and (NumDays <= Day1)) then begin
                                    Amt130 := SumAMTlcyApp;
                                    ShowOverDue := NumDays;
                                end;
                                if ((NumDays > (Day1)) and (NumDays <= Day2)) then begin
                                    Amt3160 := SumAMTlcyApp;
                                    ShowOverDue := NumDays;
                                end;
                                if ((NumDays > (Day2)) and (NumDays <= Day3)) then begin
                                    Amt6190 := SumAMTlcyApp;
                                    ShowOverDue := NumDays;
                                end;
                                if ((NumDays > (Day3)) and (NumDays <= Day4)) then begin
                                    Amt91120 := SumAMTlcyApp;
                                    ShowOverDue := NumDays;
                                end;
                                if NumDays > (Day4) then begin
                                    Amt121 := SumAMTlcyApp;
                                    ShowOverDue := NumDays;
                                end;
                            end;
                            TotalOverdue := Amt130 + Amt3160 + Amt6190 + Amt91120 + Amt121;
                            TotalAmount := SumAMTlcyApp;
                            //accum the subtotals
                            STAmt130 := STAmt130 + Amt130;
                            STAmt3160 := STAmt3160 + Amt3160;
                            STAmt6190 := STAmt6190 + Amt6190;
                            STAmt91120 := STAmt91120 + Amt91120;
                            STAmt121 := STAmt121 + Amt121;
                            STTotalOverdue := STTotalOverdue + TotalOverdue;
                            STTotalAmount := STTotalAmount + TotalAmount;
                            STAmtCurr := STAmtCurr + AmtCurr;
                            STAmt := STAmt + SumAMTlcyApp;

                            //Accum the Grand Totals
                            GTAmt130 := GTAmt130 + Amt130;
                            GTAmt3160 := GTAmt3160 + Amt3160;
                            GTAmt6190 := GTAmt6190 + Amt6190;
                            GTAmt91120 := GTAmt91120 + Amt91120;
                            GTAmt121 := GTAmt121 + Amt121;
                            GTTotalOverdue := GTTotalOverdue + TotalOverdue;
                            GTTotalAmount := GTTotalAmount + TotalAmount;
                            GTAmtCurr := GTAmtCurr + AmtCurr;
                            GTAmt := GTAmt + SumAMTlcyApp;
                            //only show alternate currency if not Thai Baht
                            if (("Cust. Ledger Entry"."Currency Code" <> '')
                            and ("Cust. Ledger Entry"."Currency Code" <> 'THB')) then begin
                                AltCode := "Cust. Ledger Entry"."Currency Code";
                                STotal += ABS(ABS(Amount));
                                GTotal += ABS(ABS(Amount));

                                //AVVCSTD.02
                                if GCODE[1] = '' then begin
                                    GCODE[1] := "Cust. Ledger Entry"."Currency Code";
                                    GCURR[1] := GCURR[1] + SumAMTApp;
                                end else begin
                                    if GCODE[1] = "Cust. Ledger Entry"."Currency Code" then
                                        GCURR[1] := GCURR[1] + SumAMTApp
                                    else begin
                                        if GCODE[2] = '' then begin
                                            GCODE[2] := "Cust. Ledger Entry"."Currency Code";
                                            GCURR[2] := GCURR[2] + SumAMTApp;
                                        end else begin
                                            if GCODE[2] = "Cust. Ledger Entry"."Currency Code" then
                                                GCURR[2] := GCURR[2] + SumAMTApp
                                            else begin
                                                if GCODE[3] = '' then begin
                                                    GCODE[3] := "Cust. Ledger Entry"."Currency Code";
                                                    GCURR[3] := GCURR[3] + SumAMTApp;
                                                end else begin
                                                    if GCODE[3] = "Cust. Ledger Entry"."Currency Code" then
                                                        GCURR[3] := GCURR[3] + SumAMTApp
                                                    else begin
                                                        if GCODE[4] = '' then begin
                                                            GCODE[4] := "Cust. Ledger Entry"."Currency Code";
                                                            GCURR[4] := GCURR[4] + SumAMTApp;
                                                        end else begin
                                                            if GCODE[4] = "Cust. Ledger Entry"."Currency Code" then
                                                                GCURR[4] := GCURR[4] + SumAMTApp
                                                            else begin
                                                                if GCODE[5] = '' then begin
                                                                    GCODE[5] := "Cust. Ledger Entry"."Currency Code";
                                                                    GCURR[5] := GCURR[5] + SumAMTApp;
                                                                end else begin
                                                                    if GCODE[5] = "Cust. Ledger Entry"."Currency Code" then
                                                                        GCURR[5] := GCURR[5] + SumAMTApp
                                                                    else begin
                                                                        if GCODE[6] = '' then begin
                                                                            GCODE[6] := "Cust. Ledger Entry"."Currency Code";
                                                                            GCURR[6] := GCURR[6] + SumAMTApp;
                                                                        end else begin
                                                                            if GCODE[6] = "Cust. Ledger Entry"."Currency Code" then
                                                                                GCURR[6] := GCURR[6] + SumAMTApp
                                                                            else begin
                                                                                if GCODE[7] = '' then begin
                                                                                    GCODE[7] := "Cust. Ledger Entry"."Currency Code";
                                                                                    GCURR[7] := GCURR[7] + SumAMTApp;
                                                                                end else begin
                                                                                    if GCODE[7] = "Cust. Ledger Entry"."Currency Code" then
                                                                                        GCURR[7] := GCURR[7] + SumAMTApp
                                                                                    else begin
                                                                                        if GCODE[8] = '' then begin
                                                                                            GCODE[8] := "Cust. Ledger Entry"."Currency Code";
                                                                                            GCURR[8] := GCURR[8] + SumAMTApp;
                                                                                        end else begin
                                                                                            if GCODE[8] = "Cust. Ledger Entry"."Currency Code" then
                                                                                                GCURR[8] := GCURR[8] + SumAMTApp;
                                                                                        end;
                                                                                    end;
                                                                                end;
                                                                            end;
                                                                        end;
                                                                    end;
                                                                end;
                                                            end;
                                                        end;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                                //C-AVVCSTD.02
                            end
                            else begin
                                AltCurrency := '';
                                AltCode := '';
                            end;

                            TotalAMT += ABS(ABS(Amount));
                            TotalLCY := SumAMTlcyApp;//ABS("Amount (LCY)");
                            if (AltCode <> '') and (TotalAMT <> 0) then
                                ExchRate := TotalLCY / TotalAMT//ABS("Amount (LCY)")/ABS(Amount) //1/"Vendor Ledger Entry"."Adjusted Currency Factor"
                            else
                                ExchRate := 0;

                        end;
                        OldDoc := "Cust. Ledger Entry"."Document No.";
                    end;

                    trigger OnPreDataItem();
                    begin
                        SETFILTER("Posting Date", '<=%1', AsOfDate);
                    end;
                }

                trigger OnAfterGetRecord();
                var
                    CustLedgerEntryTB: Record "Cust. Ledger Entry";
                    GLEntryTB: Record "G/L Entry";
                begin
                    if "Document Type" = 3 then   //3=credit memo
                      begin
                        if "Remaining Amount" = 0 then begin
                            CLEAR(custLedgEntry);
                            custLedgEntry.SETCURRENTKEY("Entry No.");
                            custLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                            if custLedgEntry.FINDFIRST then begin
                                if custLedgEntry."Document Type" = custLedgEntry."Document Type"::Invoice then
                                    CurrReport.SKIP;
                            end;
                        end;
                    end;

                    //AVNVKSTD 19.07.13
                    CLEAR(SumAMTApp);
                    CLEAR(SumAMTlcyApp);
                    CLEAR(TotalAMT);
                    CLEAR(TotalLCY);
                    FindApplnEntriesDtldtLedgEntry;
                    if SumAMTlcyApp = 0 then
                        CurrReport.SKIP;
                    //C-AVNVKSTD 19.07.13


                    //init values
                    Amt130 := 0;
                    Amt3160 := 0;
                    Amt6190 := 0;
                    Amt91120 := 0;
                    Amt121 := 0;
                    AmtCurr := 0;
                    TotalAmount := 0;
                    TotalOverdue := 0;

                    //AVPKJINT 12/03/2020
                    Clear(GLEntryTB);
                    GLEntryTB.SetCurrentKey("Entry No.");
                    GLEntryTB.SetRange("Entry No.", "Cust. Ledger Entry"."Entry No.");
                    if GLEntryTB.FindFirst then begin
                        GLAccountNo := GLEntryTB."G/L Account No.";
                    end;
                    //C-AVPKJINT 12/03/2020
                end;

                trigger OnPreDataItem();
                begin
                    SETFILTER("Posting Date", '<=%1', AsOfDate);
                    CLEAR(OCust);

                    //init values
                    Amt130 := 0;
                    Amt3160 := 0;
                    Amt6190 := 0;
                    Amt91120 := 0;
                    Amt121 := 0;
                    AmtCurr := 0;
                    TotalAmount := 0;
                    TotalOverdue := 0;
                end;
            }
            dataitem("Sum by Currency"; "Cust. Ledger Entry")
            {
                DataItemLink = "Customer No." = FIELD("No."), "Currency Code" = FIELD("Currency Filter");
                DataItemTableView = SORTING("Customer No.", "Currency Code", "Posting Date") ORDER(Ascending) WHERE("Document Type" = FILTER(Invoice | "Credit Memo"), "Currency Code" = FILTER(<> ''), "Remaining Amount" = FILTER(<> 0));
                column(Currency_Code; COPYSTR(OldCurr, 1, 3))
                {
                }
                column(AmtPerCurrency; AmtPerCurrency)
                {
                }
                column(CurrAmtText; CurrAmtText)
                {
                }
                dataitem("Detailed Cust. Ledg."; "Detailed Cust. Ledg. Entry")
                {
                    DataItemLink = "Cust. Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Entry No.") ORDER(Ascending);

                    trigger OnAfterGetRecord();
                    begin
                        AmtPerCurrency := AmtPerCurrency + (Amount);
                    end;

                    trigger OnPreDataItem();
                    begin
                        SETFILTER("Posting Date", '<=%1', AsOfDate);
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    if "Document Type" = 3 then   //3=credit memo
                      begin
                        if "Remaining Amount" = 0 then begin
                            CLEAR(custLedgEntry);
                            custLedgEntry.SETCURRENTKEY("Entry No.");
                            custLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                            if custLedgEntry.FIND('-') then begin
                                if custLedgEntry."Document Type" = custLedgEntry."Document Type"::Invoice then
                                    CurrReport.SKIP;
                            end;
                        end;
                    end;

                    if OldCurr <> "Currency Code" then begin
                        OldCurr := "Currency Code";



                        if (CurrAmtText <> '') then
                            CurrAmtText += ' ' + FORMAT(AmtPerCurrency, 0, '<Precision,2:2><Standard Format,0>') + ' , ' + COPYSTR(OldCurr, 1, 3) + ' = '
                        else
                            if ("Currency Code" <> '') and (CurrAmtText = '') then
                                CurrAmtText := COPYSTR(OldCurr, 1, 3) + ' = ';
                        CLEAR(AmtPerCurrency);

                    end;
                end;

                trigger OnPreDataItem();
                begin
                    if "Cust. Ledger Entry".GETFILTER("Cust. Ledger Entry"."Salesperson Code") <> '' then
                        SETFILTER("Salesperson Code", "Cust. Ledger Entry".GETFILTER("Cust. Ledger Entry"."Salesperson Code"));

                    if CustBalance = 0 then SETRANGE("Entry No.", 0);
                    SETFILTER("Posting Date", '<=%1', AsOfDate);
                    CLEAR(OldCurr);
                    CLEAR(CurrAmtText);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                //reset subtotals for customer
                STAmt130 := 0;
                STAmt3160 := 0;
                STAmt6190 := 0;
                STAmt91120 := 0;
                STAmt121 := 0;
                STTotalOverdue := 0;
                STTotalAmount := 0;
                STAmtCurr := 0;
                STAmt := 0;
                STAmtCurrency := 0;
                Amt130 := 0;
                Amt3160 := 0;
                Amt6190 := 0;
                Amt91120 := 0;
                Amt121 := 0;
                AmtCurr := 0;
                TotalAmount := 0;
                TotalOverdue := 0;
                AmtPerCurrency := 0;
                STotal := 0;
                CLEAR(CurrAmtText);
            end;

            trigger OnPreDataItem();
            begin
                CustPostingGroup := Customer.GETFILTER("Customer Posting Group");
                CustFilter := Customer.GETFILTER("No.");
                if CustPostingGroup = '' then CustPostingGroup := 'ALL';

                CompanyInfo.GET;

                // Column Header //
                Range1 := '1 - ' + FORMAT(Day1) + ' DAYS';
                Range2 := FORMAT(Day1 + 1) + ' - ' + FORMAT(Day2) + ' DAYS';
                Range3 := FORMAT(Day2 + 1) + ' - ' + FORMAT(Day3) + ' DAYS';
                Range4 := FORMAT(Day3 + 1) + ' - ' + FORMAT(Day4) + ' DAYS';
                Range5 := 'OVER ' + FORMAT(Day4) + ' DAYS';
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
                    field(AsOfDate; "AsOfDate")
                    {
                        Caption = 'As Of Date';
                        ApplicationArea = All;
                    }
                    grid(Control1000000004)
                    {
                        GridLayout = Rows;
                        group("Overdue Range")
                        {
                            Caption = 'Overdue Range';
                            //The GridLayout property is only supported on controls of type Grid
                            //GridLayout = Columns;
                            field(Day1; "Day1")
                            {
                                ApplicationArea = All;
                                Caption = '';
                            }
                            field(Day2; "Day2")
                            {
                                ApplicationArea = All;
                                Caption = '';
                            }
                            field(Day3; "Day3")
                            {
                                ApplicationArea = All;
                                Caption = '';
                            }
                            field(Day4; "Day4")
                            {
                                ApplicationArea = All;
                                Caption = '';
                            }
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            AsOfDate := TODAY;
            if Day1 = 0 then Day1 := 30;
            if Day2 = 0 then Day2 := 60;
            if Day3 = 0 then Day3 := 90;
            if Day4 = 0 then Day4 := 120;
        end;
    }

    labels
    {
    }

    trigger OnInitReport();
    begin
        //reset the grand total amounts
        GTAmt130 := 0;
        GTAmt3160 := 0;
        GTAmt6190 := 0;
        GTAmt91120 := 0;
        GTAmt121 := 0;
        GTTotalOverdue := 0;
        GTTotalAmount := 0;
        GTAmtCurr := 0;
        GTAmt := 0;
        GTAmtCurrency := 0;
        GTotal := 0;
    end;

    trigger OnPreReport();
    begin
        CusFilter := Customer.GETFILTERS;
    end;

    var
        AmtCurrency: Decimal;
        AmtCurr: Decimal;
        Amt130: Decimal;
        Amt3160: Decimal;
        Amt6190: Decimal;
        Amt91120: Decimal;
        Amt121: Decimal;
        TotalAmount: Decimal;
        TotalOverdue: Decimal;
        tmpDate: Date;
        NumDays: Integer;
        STAmtCurr: Decimal;
        STAmt130: Decimal;
        STAmt3160: Decimal;
        STAmt6190: Decimal;
        STAmt91120: Decimal;
        STAmt121: Decimal;
        STTotalAmount: Decimal;
        STTotalOverdue: Decimal;
        STAmt: Decimal;
        STAmtCurrency: Decimal;
        GTAmtCurr: Decimal;
        GTAmt130: Decimal;
        GTAmt3160: Decimal;
        GTAmt6190: Decimal;
        GTAmt91120: Decimal;
        GTAmt121: Decimal;
        GTTotalAmount: Decimal;
        GTTotalOverdue: Decimal;
        GTAmt: Decimal;
        GTAmtCurrency: Decimal;
        TermDays: Code[10];
        AltCurrency: Text[40];
        CurrencyCode: Code[10];
        AsOfDate: Date;
        AltCode: Code[10];
        CustPostingGroup: Text[100];
        AmtPerCurrency: Decimal;
        ExchRate: Decimal;
        CustFilter: Text[1024];
        OCust: Code[20];
        AmtPerCurr: Decimal;
        DtlCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        CustBalance: Decimal;
        CompanyInfo: Record "Company Information";
        Range1: Text[30];
        Range2: Text[30];
        Range3: Text[30];
        Range4: Text[30];
        Range5: Text[30];
        Day1: Integer;
        Day2: Integer;
        Day3: Integer;
        Day4: Integer;
        GCURR: array[8] of Decimal;
        GCODE: array[8] of Code[20];
        "CUST. LEDGER ENTRY TB": Record "Cust. Ledger Entry";
        "REMAIN AMOUNT": Decimal;
        "SALES CODE FILTER": Text[100];
        "CURR CODE FILTER": Text[100];
        "COUNT REM": Integer;
        I: Integer;
        ThaiCode: Codeunit AVF_Thai;
        "PDC No.": Code[20];
        AVUserSetupM: Codeunit "User Setup Management";
        TxtFilter: Text[1024];
        AVCustomer: Record Customer;
        AVSalesPerson: Record "Salesperson/Purchaser";
        AVSalesInvH: Record "Sales Invoice Header";
        AVSalesCNH: Record "Sales Cr.Memo Header";
        CustName: Text[100];
        SalesInvHd: Record "Sales Invoice Header";
        SalesCNHd: Record "Sales Cr.Memo Header";
        AVShowSalePersonName: Text[60];
        AVSalePerson: Record "Salesperson/Purchaser";
        ShowOverDue: Integer;
        AVCustLedger: Record "Cust. Ledger Entry";
        AVCustShow: Boolean;
        OldCurr: Text[30];
        CurrAmtText: Text[1024];
        custLedgEntry: Record "Cust. Ledger Entry";
        TmpTBCustLedgerApplied: Record "Cust. Ledger Entry" temporary;
        AVDetailedCustLedger: Record "Detailed Cust. Ledg. Entry";
        AVGLEntry: Record "G/L Entry";
        AllApplied: Integer;
        SumAMTApp: Decimal;
        SumAMTlcyApp: Decimal;
        OldDoc: Text[30];
        TotalAMT: Decimal;
        TotalLCY: Decimal;
        STotal: Decimal;
        GTotal: Decimal;
        CusFilter: Text[1024];
        GLAccountNo: Code[20];

    procedure GetPayTerms(InvNum: Code[30]; DocType: Option; var CurrCode: Code[10]) Terms: Code[10];
    var
        PInv: Record "Sales Invoice Header";
        CRInv: Record "Sales Cr.Memo Header";
    begin
        //get the payment terms code
        if DocType = 2 then  //2=invoice  3=credit memo
          begin
            CLEAR(PInv);
            PInv.SETCURRENTKEY("No.");
            PInv.SETRANGE("No.", InvNum);
            if PInv.FINDFIRST then begin
                Terms := PInv."Payment Terms Code";
                CurrCode := PInv."Currency Code";
            end;
        end
        else begin
            CLEAR(CRInv);
            CRInv.SETCURRENTKEY("No.");
            CRInv.SETRANGE("No.", InvNum);
            if CRInv.FINDFIRST then begin
                Terms := CRInv."Payment Terms Code";
                CurrCode := CRInv."Currency Code";
            end;
        end;
    end;

    procedure FindApplnEntriesDtldtLedgEntry();
    var
        DtldcustLedgEntry1: Record "Detailed Cust. Ledg. Entry";
        DtldcustLedgEntry2: Record "Detailed Cust. Ledg. Entry";
    begin
        //AVNVKSTD 23/07/13
        CLEAR(AVGLEntry);
        AVGLEntry.SETCURRENTKEY(AVGLEntry."Source Code", AVGLEntry."Document No.");
        AVGLEntry.SETRANGE(AVGLEntry."Document No.", "Cust. Ledger Entry"."Document No.");
        if AVGLEntry.FINDFIRST then begin
            repeat
                DtldcustLedgEntry1.SETCURRENTKEY("Cust. Ledger Entry No.");
                DtldcustLedgEntry1.SETRANGE("Cust. Ledger Entry No.", AVGLEntry."Entry No.");
                DtldcustLedgEntry1.SETRANGE(Unapplied, false);
                DtldcustLedgEntry1.SETFILTER("Posting Date", '..%1', AsOfDate);
                if DtldcustLedgEntry1.FIND('-') then begin
                    repeat
                        SumAMTApp += DtldcustLedgEntry1.Amount;
                        SumAMTlcyApp += DtldcustLedgEntry1."Amount (LCY)";
                    until DtldcustLedgEntry1.NEXT = 0;
                end;
            until AVGLEntry.NEXT = 0;
        end;
        //C-AVNVKSTD 23/07/13
    end;
}

