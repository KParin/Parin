report 50077 "INT_AP Aging"
{
    // version AVTHLC1.0

    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/AP Aging.rdl';
    CaptionML = ENU = 'AP Aging';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    dataset
    {
        dataitem(Vendor; Vendor)
        {
            PrintOnlyIfDetail = true;
            RequestFilterFields = "No.", "Search Name", "Vendor Posting Group", "Currency Filter", "Responsibility Center";
            column(VentorFilter; VentorFilter)
            {
            }
            column(No_Vendor; Vendor."No.")
            {
            }
            column(DatePrint; 'Printed Date : ' + FORMAT(TODAY, 0, 1) + ' ' + FORMAT(TIME, 0, '<Hours12>:<Minutes,2>:<Second,2> <AM/PM>'))
            {
            }
            column(CompanyInfoName; CompanyInfo.Name + ' ' + CompanyInfo."Name 2")
            {
            }
            column(ACCOUNTS_PAYABLE; 'ACCOUNTS PAYABLE ')
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
            column(GCURR_1; FORMAT(ABS(GCURR[1]), 0, '<Precision,2:2><Standard Format,0>'))
            {
            }
            column(GCURR_2; FORMAT(ABS(GCURR[2]), 0, '<Precision,2:2><Standard Format,0>'))
            {
            }
            column(GCURR_3; FORMAT(ABS(GCURR[3]), 0, '<Precision,2:2><Standard Format,0>'))
            {
            }
            column(GCURR_4; FORMAT(ABS(GCURR[4]), 0, '<Precision,2:2><Standard Format,0>'))
            {
            }
            column(GCURR_5; FORMAT(ABS(GCURR[5]), 0, '<Precision,2:2><Standard Format,0>'))
            {
            }
            column(GCURR_6; FORMAT(ABS(GCURR[6]), 0, '<Precision,2:2><Standard Format,0>'))
            {
            }
            column(GCURR_7; FORMAT(ABS(GCURR[7]), 0, '<Precision,2:2><Standard Format,0>'))
            {
            }
            column(GCURR_8; FORMAT(ABS(GCURR[8]), 0, '<Precision,2:2><Standard Format,0>'))
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
            dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
            {
                CalcFields = "Remaining Amount", "Remaining Amt. (LCY)";
                DataItemLink = "Vendor No." = FIELD("No."), "Currency Code" = FIELD("Currency Filter");
                DataItemTableView = SORTING("Vendor No.", "Posting Date", "Currency Code") ORDER(Ascending) WHERE("Document Type" = FILTER(Invoice | "Credit Memo"));
                column(Vendor_Name; Vendor.Name)
                {
                }
                column(VendorNo_VendorLedgerEntry; "Vendor Ledger Entry"."Vendor No.")
                {
                }
                column(EntryNo_VendorLedgerEntry; "Vendor Ledger Entry"."Entry No.")
                {
                }
                column(SumAMTlcyApp; SumAMTlcyApp)
                {
                }
                column(GLAccountNo; GLEntryTB."G/L Account No.")
                {
                }
                dataitem("Detailed Vendor Ledg. Entry"; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Entry No.") ORDER(Ascending);
                    column(DetailLedEntry_EntryNo; "Detailed Vendor Ledg. Entry"."Entry No.")
                    {
                    }
                    column(VendorLedgerEntry_DocumentDate; FORMAT("Vendor Ledger Entry"."Document Date", 0, '<Closing><Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(VendorLedgerEntry_DocumentNo; "Vendor Ledger Entry"."Document No.")
                    {
                    }
                    column(VendorLedgerEntry_ExternalDocumentNo; "Vendor Ledger Entry"."External Document No.")
                    {
                    }
                    column(VendorLedgerEntry_DueDate; FORMAT("Vendor Ledger Entry"."Due Date", 0, '<Closing><Day,2>/<Month,2>/<Year4>'))
                    {
                    }
                    column(GetPayTerms; GetPayTerms("Document No.", "Document Type", CurrencyCode))
                    {
                    }
                    column(AltCode; COPYSTR(AltCode, 1, 3))
                    {
                    }
                    column(AltCurrency; AltCurrency)
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
                    column(STTotalAmount; FORMAT(STTotalAmount, 0, '<Precision,2:2><Standard Format,0>'))
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin

                        //check if overdue
                        //AmtCurr :=  -"Remaining Amt. (LCY)";
                        if "Amount (LCY)" = 0 then
                            CurrReport.SKIP;

                        AmtCurrency += Amount;
                        CLEAR(ShowOverDue);

                        if "Vendor Ledger Entry"."Due Date" >= AsOfDate then
                            AmtCurr := -"Amount (LCY)"
                        else begin
                            NumDays := AsOfDate - "Vendor Ledger Entry"."Due Date";
                            if ((NumDays > 0) and (NumDays <= Day1)) then begin
                                Amt130 := -"Amount (LCY)";
                                ShowOverDue := NumDays;
                                STAmt130 := STAmt130 + (-"Amount (LCY)");
                                GTAmt130 := GTAmt130 + (-"Amount (LCY)");
                            end
                            else
                                if ((NumDays > (Day1)) and (NumDays <= Day2)) then begin
                                    Amt3160 := -"Amount (LCY)";
                                    ShowOverDue := NumDays;
                                    STAmt3160 := STAmt3160 + (-"Amount (LCY)");
                                    GTAmt3160 := GTAmt3160 + (-"Amount (LCY)");
                                end
                                else
                                    if ((NumDays > (Day2)) and (NumDays <= Day3)) then begin
                                        Amt6190 := -"Amount (LCY)";
                                        ShowOverDue := NumDays;
                                        STAmt6190 := STAmt6190 + (-"Amount (LCY)");
                                        GTAmt6190 := GTAmt6190 + (-"Amount (LCY)");
                                    end
                                    else
                                        if ((NumDays > (Day3)) and (NumDays <= Day4)) then begin
                                            Amt91120 := -"Amount (LCY)";
                                            ShowOverDue := NumDays;
                                            STAmt91120 := STAmt91120 + (-"Amount (LCY)");
                                            GTAmt91120 := GTAmt91120 + (-"Amount (LCY)");
                                        end
                                        else
                                            if NumDays > (Day4) then begin
                                                Amt121 := -"Amount (LCY)";
                                                ShowOverDue := NumDays;
                                                STAmt121 := STAmt121 + (-"Amount (LCY)");
                                                GTAmt121 := GTAmt121 + (-"Amount (LCY)");
                                            end;
                        end;

                        TotalOverdue := Amt130 + Amt3160 + Amt6190 + Amt91120 + Amt121;
                        TotalAmount += -"Amount (LCY)";



                        //only show alternate currency if not Thai Baht
                        if (("Vendor Ledger Entry"."Currency Code" <> '') and ("Vendor Ledger Entry"."Currency Code" <> 'THB')) then begin
                            //AltCurrency := FORMAT(-AmtCurrency, 0, '<Sign><Integer Thousand><Decimals,3>');
                            AltCurrency := FORMAT(-AmtCurrency, 0, '<Precision,2:2><Standard Format,0>');
                            AltCode := "Vendor Ledger Entry"."Currency Code";
                            STotal += ABS(ABS(Amount));
                            GTotal += ABS(ABS(Amount));

                            //AVVCCCS.01 070614
                            if GCODE[1] = '' then begin
                                GCODE[1] := "Vendor Ledger Entry"."Currency Code";
                                GCURR[1] := GCURR[1] + Amount;
                            end
                            else begin
                                if GCODE[1] = "Vendor Ledger Entry"."Currency Code" then begin
                                    GCURR[1] := GCURR[1] + Amount;
                                end
                                else begin
                                    if GCODE[2] = '' then begin
                                        GCODE[2] := "Vendor Ledger Entry"."Currency Code";
                                        GCURR[2] := GCURR[2] + Amount;
                                    end
                                    else begin
                                        if GCODE[2] = "Vendor Ledger Entry"."Currency Code" then begin
                                            GCURR[2] := GCURR[2] + Amount;
                                        end
                                        else begin
                                            if GCODE[3] = '' then begin
                                                GCODE[3] := "Vendor Ledger Entry"."Currency Code";
                                                GCURR[3] := GCURR[3] + Amount;
                                            end
                                            else begin
                                                if GCODE[3] = "Vendor Ledger Entry"."Currency Code" then begin
                                                    GCURR[3] := GCURR[3] + Amount;
                                                end
                                                else begin
                                                    if GCODE[4] = '' then begin
                                                        GCODE[4] := "Vendor Ledger Entry"."Currency Code";
                                                        GCURR[4] := GCURR[4] + Amount;
                                                    end
                                                    else begin
                                                        if GCODE[4] = "Vendor Ledger Entry"."Currency Code" then begin
                                                            GCURR[4] := GCURR[4] + Amount;
                                                        end
                                                        else begin
                                                            if GCODE[5] = '' then begin
                                                                GCODE[5] := "Vendor Ledger Entry"."Currency Code";
                                                                GCURR[5] := GCURR[5] + Amount;
                                                            end
                                                            else begin
                                                                if GCODE[5] = "Vendor Ledger Entry"."Currency Code" then begin
                                                                    GCURR[5] := GCURR[5] + Amount;
                                                                end
                                                                else begin
                                                                    if GCODE[6] = '' then begin
                                                                        GCODE[6] := "Vendor Ledger Entry"."Currency Code";
                                                                        GCURR[6] := GCURR[6] + Amount;
                                                                    end
                                                                    else begin
                                                                        if GCODE[6] = "Vendor Ledger Entry"."Currency Code" then begin
                                                                            GCURR[6] := GCURR[6] + Amount;
                                                                        end
                                                                        else begin
                                                                            if GCODE[7] = '' then begin
                                                                                GCODE[7] := "Vendor Ledger Entry"."Currency Code";
                                                                                GCURR[7] := GCURR[7] + Amount;
                                                                            end
                                                                            else begin
                                                                                if GCODE[7] = "Vendor Ledger Entry"."Currency Code" then begin
                                                                                    GCURR[7] := GCURR[7] + Amount;
                                                                                end
                                                                                else begin
                                                                                    if GCODE[8] = '' then begin
                                                                                        GCODE[8] := "Vendor Ledger Entry"."Currency Code";
                                                                                        GCURR[8] := GCURR[8] + Amount;
                                                                                    end
                                                                                    else begin
                                                                                        if GCODE[8] = "Vendor Ledger Entry"."Currency Code" then begin
                                                                                            GCURR[8] := GCURR[8] + Amount;
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
                            end;
                            //C-AVVCCCS.01 070614
                        end
                        else begin
                            AltCurrency := '';
                            AltCode := '';
                        end;


                        TotalAMT += ABS(ABS(Amount));
                        TotalLCY += ABS("Amount (LCY)");
                        if (AltCode <> '') and (TotalAMT <> 0) then
                            ExchRate := TotalLCY / TotalAMT//ABS("Amount (LCY)")/ABS(Amount) //1/"Vendor Ledger Entry"."Adjusted Currency Factor"
                        else
                            ExchRate := 0;


                        //accum the subtotals
                        STTotalOverdue := STTotalOverdue + TotalOverdue;
                        STTotalAmount := STTotalAmount + (-"Amount (LCY)");
                        STAmtCurr := STAmtCurr + AmtCurr;
                        //STAmtCurr := STAmtCurr + -"Amount (LCY)";
                        STAmt := STAmt + (-Amount);//(-"Amount (LCY)");
                        //STAmtCurrency := STAmtCurrency + AmtCurrency;

                        //Accum the Grand Totals
                        GTTotalOverdue := GTTotalOverdue + TotalOverdue;
                        GTTotalAmount := GTTotalAmount + (-"Amount (LCY)");
                        GTAmtCurr := GTAmtCurr + AmtCurr;
                        GTAmt := GTAmt + (-Amount);// (LCY)");
                        //GTAmtCurrency := GTAmtCurrency + AmtCurrency;
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
                            CLEAR(VendLedgEntry);
                            VendLedgEntry.SETCURRENTKEY("Entry No.");
                            VendLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                            if VendLedgEntry.FINDFIRST then begin
                                if VendLedgEntry."Document Type" = VendLedgEntry."Document Type"::Invoice then
                                    CurrReport.SKIP;
                            end;
                        end;
                    end;

                    //AVNVKSTD 24.07.13
                    CLEAR(SumAMTApp);
                    CLEAR(SumAMTlcyApp);
                    CLEAR(TotalAMT);
                    CLEAR(TotalLCY);
                    FindApplnEntriesDtldtLedgEntry;
                    if SumAMTlcyApp = 0 then
                        CurrReport.SKIP;
                    //C-AVNVKSTD 24.07.13

                    //init values
                    Amt130 := 0;
                    Amt3160 := 0;
                    Amt6190 := 0;
                    Amt91120 := 0;
                    Amt121 := 0;
                    AmtCurr := 0;
                    TotalAmount := 0;
                    TotalOverdue := 0;
                    AmtCurrency := 0;

                    Clear(GLEntryTB);
                    GLEntryTB.SetCurrentKey("Entry No.");
                    GLEntryTB.SetRange("Entry No.", "Vendor Ledger Entry"."Entry No.");
                    if GLEntryTB.FindFirst then;
                end;

                trigger OnPreDataItem();
                begin
                    //AVWITEAM.004 16.09.2011
                    //Add code for Filter vendor Ledger Entry on trigger Vendor Ledger Entry - OnPreDataItem()
                    //IF (VendBalance = 0) AND (AVVendShow = FALSE) THEN SETRANGE("Entry No.",0);
                    SETFILTER("Posting Date", '<=%1', AsOfDate);
                    CLEAR(OVend);
                    //C-AVWITEAM.004 16.09.2011

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
                end;
            }
            dataitem("Sum by Currency"; "Vendor Ledger Entry")
            {
                CalcFields = "Remaining Amount", "Remaining Amt. (LCY)";
                DataItemLink = "Vendor No." = FIELD("No."), "Currency Code" = FIELD("Currency Filter");
                DataItemTableView = SORTING("Vendor No.", "Currency Code", "Posting Date") ORDER(Ascending) WHERE("Document Type" = FILTER(Invoice | "Credit Memo"), "Currency Code" = FILTER(<> ''));
                PrintOnlyIfDetail = true;
                column(Currency_Code; COPYSTR(OldCurr, 1, 3))
                {
                }
                column(AmtPerCurrency; FORMAT(AmtPerCurrency, 0, '<Precision,2:2><Standard Format,0>'))
                {
                }
                column(CurrAmtText; CurrAmtText)
                {
                }
                dataitem("Detailed Vend. Ledg."; "Detailed Vendor Ledg. Entry")
                {
                    DataItemLink = "Vendor Ledger Entry No." = FIELD("Entry No.");
                    DataItemTableView = SORTING("Entry No.") ORDER(Ascending);

                    trigger OnAfterGetRecord();
                    begin
                        AmtPerCurrency := AmtPerCurrency + (-Amount);
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
                            CLEAR(VendLedgEntry);
                            VendLedgEntry.SETCURRENTKEY("Entry No.");
                            VendLedgEntry.SETRANGE("Entry No.", "Closed by Entry No.");
                            if VendLedgEntry.FIND('-') then begin
                                if VendLedgEntry."Document Type" = VendLedgEntry."Document Type"::Invoice then
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
                    //IF VendBalance = 0 THEN SETRANGE("Entry No.",0);
                    SETFILTER("Currency Code", '<>THB');
                    SETFILTER("Posting Date", '<=%1', AsOfDate);

                    CLEAR(OldCurr);
                    CLEAR(CurrAmtText);
                end;
            }

            trigger OnAfterGetRecord();
            begin

                /*//AVWITEAM.003 16.09.2011
                //Add Code for Find Balance before Run this Vendor on trigger Vendor - OnAfterGetRecord()
                CLEAR(VendBalance);
                CLEAR(DtlVendLedgEntry);
                CLEAR(AVVendLedger);
                CLEAR(AVVendShow);
                DtlVendLedgEntry.SETCURRENTKEY(DtlVendLedgEntry."Vendor No.");
                DtlVendLedgEntry.SETRANGE("Vendor No.","No.");
                DtlVendLedgEntry.SETFILTER("Posting Date", '<=%1', AsOfDate);
                IF DtlVendLedgEntry.FINDFIRST THEN
                REPEAT
                  VendBalance := VendBalance + DtlVendLedgEntry."Amount (LCY)";
                  CLEAR(AVVendLedger);
                  AVVendLedger.SETCURRENTKEY(AVVendLedger."Entry No.");
                  AVVendLedger.SETRANGE(AVVendLedger."Entry No.",DtlVendLedgEntry."Vendor Ledger Entry No.");
                  IF AVVendLedger.FINDFIRST THEN BEGIN
                     AVVendLedger.CALCFIELDS(AVVendLedger."Remaining Amount");
                     IF AVVendLedger."Remaining Amount" <> 0 THEN
                       AVVendShow := TRUE;
                  END;
                UNTIL(DtlVendLedgEntry.NEXT = 0);*/
                //C-AVWITEAM.003 16.09.2011

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
                VendPostingGroup := Vendor.GETFILTER("Vendor Posting Group");
                VendFilter := Vendor.GETFILTER("No.");
                if VendPostingGroup = '' then VendPostingGroup := 'ALL';
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
                    grid(Control1000000003)
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
        VentorFilter := Vendor.GETFILTERS;
    end;

    var
        AmtCurr: Decimal;
        AmtCurrency: Decimal;
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
        AltCurrency: Text[30];
        CurrencyCode: Code[10];
        AsOfDate: Date;
        AltCode: Code[10];
        VendPostingGroup: Text[100];
        AmtPerCurrency: Decimal;
        OldCurrency: Code[10];
        ExchRate: Decimal;
        VendLedgEntry: Record "Vendor Ledger Entry";
        VendFilter: Text[1024];
        OVend: Code[20];
        AmtPerCurr: Decimal;
        DtlVendLedgEntry: Record "Detailed Vendor Ledg. Entry";
        VendBalance: Decimal;
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
        RunningNo: Integer;
        GCURR: array[8] of Decimal;
        GCODE: array[8] of Code[20];
        "VENDER LEDGER ENTRY TB": Record "Vendor Ledger Entry";
        "REMAIN AMOUNT": Decimal;
        "SALES CODE FILTER": Text[100];
        "CURR CODE FILTER": Text[100];
        "COUNT REM": Integer;
        TxtFilter: Text[1024];
        AVUserSetupM: Codeunit "User Setup Management";
        ShowOverDue: Integer;
        AVVendLedger: Record "Vendor Ledger Entry";
        AVVendShow: Boolean;
        OldCurr: Text[30];
        ShowVenLeg1: Boolean;
        CurrAmtText: Text[1024];
        AVGLEntry: Record "G/L Entry";
        SumAMTApp: Decimal;
        SumAMTlcyApp: Decimal;
        OldDoc: Text[30];
        TotalAMT: Decimal;
        TotalLCY: Decimal;
        STotal: Decimal;
        GTotal: Decimal;
        VentorFilter: Text[1024];
        GLEntryTB: Record "G/L Entry";



    procedure GetPayTerms(InvNum: Code[30]; DocType: Option; var CurrCode: Code[10]) Terms: Code[10];
    var
        PInv: Record "Purch. Inv. Header";
        CRInv: Record "Purch. Cr. Memo Hdr.";
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
        DtldVendLedgEntry0: Record "Detailed Vendor Ledg. Entry";
        DtldVendLedgEntry1: Record "Detailed Vendor Ledg. Entry";
        DtldVendLedgEntry2: Record "Detailed Vendor Ledg. Entry";
    begin
        CLEAR(AVGLEntry);
        AVGLEntry.SETCURRENTKEY(AVGLEntry."Source Code", AVGLEntry."Document No.");
        AVGLEntry.SETRANGE(AVGLEntry."Document No.", "Vendor Ledger Entry"."Document No.");
        if AVGLEntry.FINDFIRST then begin
            repeat
                CLEAR(DtldVendLedgEntry1);
                DtldVendLedgEntry1.SETCURRENTKEY("Vendor Ledger Entry No.");
                DtldVendLedgEntry1.SETRANGE("Vendor Ledger Entry No.", AVGLEntry."Entry No.");
                DtldVendLedgEntry1.SETRANGE(Unapplied, false);
                DtldVendLedgEntry1.SETFILTER("Posting Date", '..%1', AsOfDate);
                if DtldVendLedgEntry1.FIND('-') then begin
                    repeat
                        SumAMTApp += DtldVendLedgEntry1.Amount;
                        SumAMTlcyApp += DtldVendLedgEntry1."Amount (LCY)";
                    until DtldVendLedgEntry1.NEXT = 0;
                end;
            until AVGLEntry.NEXT = 0;
        end;
    end;
}

