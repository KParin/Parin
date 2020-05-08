report 50075 "INT_Purchases VAT"
{
    // version AVFTH1.0

    // Microsoft Dynamic NAV
    // ----------------------------------------
    // Project: Localization TH
    // AVNVKSTD : Natee Visedkajee
    // 
    // No.   Date         Sign       Description
    // --------------------------------------------------
    // 001   20.07.2012   AVNVKSTD   Localization.
    // 002   18.09.2013   AVWCASTD   Add Branch.
    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/Purchases VAT.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Input Tax Report';

    dataset
    {
        dataitem("VAT Entry"; "VAT Entry")
        {
            DataItemTableView = SORTING("Document Date", "External Document No.", "VAT Bus. Posting Group", "Posting Date", Type, "Document No.") WHERE(Type = FILTER(Purchase), Base = FILTER(<> 0), "External Document No." = FILTER(<> ''), Amount = FILTER(<> 0), "VAT Prod. Posting Group" = FILTER('<>UVAT'));
            //AVPKJINT 12/03/2020 
            //DataItemTableView = SORTING(Type, Closed, "VAT Bus. Posting Group", "VAT Prod. Posting Group", "Posting Date") WHERE(Type = FILTER(Purchase), Base = FILTER(<> 0), "External Document No." = FILTER(<> ''), Amount = FILTER(<> 0), "VAT Prod. Posting Group" = FILTER('<>UVAT'));
            column(DateOfPrint; 'ประจำเดือน ' + Month + ' ปี ' + FORMAT(Year))
            {
            }
            column(VATExternalDocumentNo; "VAT Entry"."External Document No.")
            {
            }
            column(company_name; CompanyNameText)
            {
            }
            column(company_add; CompanyAddText)
            {
            }
            column(company_vat; VATNo)
            {
            }
            column(VATNo1; COPYSTR(VATNo, 1, 1))
            {
            }
            column(VATNo2; COPYSTR(VATNo, 2, 1))
            {
            }
            column(VATNo3; COPYSTR(VATNo, 3, 1))
            {
            }
            column(VATNo4; COPYSTR(VATNo, 4, 1))
            {
            }
            column(VATNo5; COPYSTR(VATNo, 5, 1))
            {
            }
            column(VATNo6; COPYSTR(VATNo, 6, 1))
            {
            }
            column(VATNo7; COPYSTR(VATNo, 7, 1))
            {
            }
            column(VATNo8; COPYSTR(VATNo, 8, 1))
            {
            }
            column(VATNo9; COPYSTR(VATNo, 9, 1))
            {
            }
            column(VATNo10; COPYSTR(VATNo, 10, 1))
            {
            }
            column(VATNo11; COPYSTR(VATNo, 11, 1))
            {
            }
            column(VATNo12; COPYSTR(VATNo, 12, 1))
            {
            }
            column(VATNo13; COPYSTR(VATNo, 13, 1))
            {
            }
            column(index; index)
            {
            }
            column(DocumentDate_VATEntry; "VAT Entry"."Document Date")
            {
            }
            column(showdate; ShowDate)
            {
            }
            column(payto; PAYTO)
            {
            }
            column(fbase; FBase)
            {
            }
            column(famount; FAmount)
            {
            }
            column(tbase; Tbase)
            {
            }
            column(tamount; TAmount)
            {
            }
            column(Base_VATEntry; "VAT Entry".Base)
            {
            }
            column(Amount_VATEntry; "VAT Entry".Amount)
            {
            }
            column(EDN; "VAT Entry"."External Document No.")
            {
            }
            column(BP; "VAT Entry"."External Document No.")
            {
            }
            column(VATReg; "VAT Entry"."VAT Registration No.")
            {
            }
            column(month; Month)
            {
            }
            column(year; TextYear)
            {
            }
            column(Dbase; "VAT Entry".Base)
            {
            }
            column(DAmount; "VAT Entry".Amount)
            {
            }
            column(PageNo; PageNo)
            {
            }
            column(VATAddress1; VATAddress[1])
            {
            }
            column(VATAddress2; VATAddress[2])
            {
            }
            column(Branch1; Branch[1])
            {
            }
            column(Branch2; Branch[2])
            {
            }
            column(Showheadoffice; Showheadoffice)
            {
            }
            column(SumTotalBase; SumTotalBase)
            {
            }
            column(SumTotalAMT; SumTotalAMT)
            {
            }
            column(DocumentNo_VATEntry; "VAT Entry"."Document No.")
            {
            }
            column(VatRegiNo_VatEntry; LineVATNo)
            {
            }
            column(VatCen; VatCen)
            {
            }
            column(VatSub; VatSub)
            {
            }

            trigger OnAfterGetRecord();
            begin

                CLEAR(PAYTO);
                if ("Document Type" = "Document Type"::Payment) or ("Document Type" = "Document Type"::" ") then begin
                    if ("Bill-to/Pay-to No." = '') then begin
                        CLEAR(CheckLedger);
                        CheckLedger.SetRange("Document No.", "Document No.");
                        CheckLedger.SetRange("External Document No.", "External Document No.");
                        if CheckLedger.FIND('-') then PAYTO := CheckLedger."AVF_Pay-to Description";
                    end
                    else begin
                        CLEAR(Ven);
                        Ven.SetRange("No.", "Bill-to/Pay-to No.");
                        Ven.NEXT;
                        PAYTO := Ven.Name + ' ' + Ven."Name 2";
                    end;
                end
                else
                    if ("Document Type" = "Document Type"::Invoice) then begin
                        CLEAR(PurchInvHead);
                        PurchInvHead.SetRange("No.", "Document No.");
                        if PurchInvHead.FIND('-') then
                            PAYTO := PurchInvHead."Buy-from Vendor Name" + PurchInvHead."Buy-from Vendor Name 2"
                        else
                            if ("Bill-to/Pay-to No." = '') then begin
                                CLEAR(CheckLedger);
                                CheckLedger.SetRange("Document No.", "Document No.");
                                CheckLedger.SetRange("External Document No.", "External Document No.");
                                if CheckLedger.FIND('-') then PAYTO := CheckLedger."AVF_Pay-to Description";
                            end
                            else begin
                                CLEAR(Ven);
                                Ven.SetRange("No.", "Bill-to/Pay-to No.");
                                Ven.NEXT;
                                PAYTO := Ven.Name + ' ' + Ven."Name 2";
                            end;
                    end
                    else
                        if ("Document Type" = "Document Type"::"Credit Memo") then begin
                            CLEAR(PurchCrHead);
                            PurchCrHead.SetRange("No.", "Document No.");
                            if PurchCrHead.FIND('-') then
                                PAYTO := PurchCrHead."Buy-from Vendor Name" + PurchCrHead."Buy-from Vendor Name 2";
                        end
                        else begin
                            CLEAR(Ven);
                            Ven.SetRange("No.", "Bill-to/Pay-to No.");
                            Ven.NEXT;
                            PAYTO := Ven.Name + ' ' + Ven."Name 2";
                        end;

                if "VAT Entry".AVF_Description <> '' then
                    PAYTO := "VAT Entry".AVF_Description;

                CLEAR(VATPostingSetup);
                VATPostingSetup.SetRange("VAT Bus. Posting Group", "VAT Bus. Posting Group");
                VATPostingSetup.SetRange("VAT Prod. Posting Group", "VAT Prod. Posting Group");
                VATPostingSetup.NEXT;



                BaseAMT := BaseAMT + Base;
                VATAMT := VATAMT + Amount;
                BaseTOT := BaseTOT + Base;
                VATTOT := VATTOT + Amount;



                CLEAR(ShowDate);
                //ShowDate := FORMAT("Document Date",0,'<Day,2>') +'/'+ FORMAT(DATE2DMY("Document Date",2),0,'<MM>') + '/' +
                //            FORMAT(DATE2DMY("Document Date",3)+543);
                ShowDate := cuThai.FormatThaiDate("Document Date", 3);

                /*if Base < 0 then
                  FBase := '(' + FORMAT(Base,0,'<Integer Thousand><Decimals,3>') + ')'
                ELSE
                  FBase := FORMAT(Base,0,'<Integer Thousand><Decimals,3>');
                if Amount < 0 then
                  FAmount := '(' + FORMAT(Amount,0,'<Integer Thousand><Decimals,3>') + ')'
                ELSE
                  FAmount := FORMAT(Amount,0,'<Integer Thousand><Decimals,3>');
                if (Amount + Base) < 0 then
                  FAMT := '(' + FORMAT((Amount + Base),0,'<Integer Thousand><Decimals,3>') + ')'
                ELSE
                  FAMT := FORMAT((Amount + Base),0,'<Integer Thousand><Decimals,3>');*/

                //index += 1;
                Tbase := Tbase + Base;
                TAmount := TAmount + Amount;
                Total := Total + (Amount + Base);

                SumTotalBase += Base;
                SumTotalAMT += Amount;

                LineVATNo := COPYSTR("VAT Entry"."VAT Registration No.", 1, 1) + '-' +
                              COPYSTR("VAT Entry"."VAT Registration No.", 2, 4) + '-' +
                              COPYSTR("VAT Entry"."VAT Registration No.", 6, 5) + '-' +
                              COPYSTR("VAT Entry"."VAT Registration No.", 11, 2) + '-' +
                              COPYSTR("VAT Entry"."VAT Registration No.", 13, 1);


                if index = 0 then
                    index := 1
                else
                    if OldExternal <> "External Document No." then begin
                        //SumBase += Base;
                        //SumAmt += Amount;
                        //if SumBase + SumAmt <> 0 then begin
                        index += 1;
                        //end;
                    end;
                OldExternal := "External Document No.";
                ///newpage
                /*if (index MOD MaxLine) = 1 then
                PageNo +=1;
                */

                //AVNOJ VIP3 030913
                CLEAR(VatCen);
                CLEAR(VatSub);
                if ("VAT Entry"."AVF_Branch No." = '00000') or ("VAT Entry"."AVF_Branch No." = 'สำนักงานใหญ่')
                or (StrPos("VAT Entry"."AVF_Branch No.", 'สำนักงาน') <> 0) or (StrPos("VAT Entry"."AVF_Branch No.", 'Head') <> 0)
                or (StrPos("VAT Entry"."AVF_Branch No.", 'HEAD') <> 0) or (StrPos("VAT Entry"."AVF_Branch No.", 'head') <> 0)
                then
                    VatCen := 'X'//"VAT Entry"."Branch No."
                else
                    VatSub := "VAT Entry"."AVF_Branch No.";
                //end AVNOJ VIP3 030913

            end;

            trigger OnPreDataItem();
            var
                VatEntryTB: Record "VAT Entry";

            begin
                UpdateIntRefNo;
                CLEAR(BaseTOT);
                CLEAR(VATTOT);
                CLEAR(PageNo);
                CLEAR(index);
                CompanyInfo.GET;
                PageNo := 1;
                MaxLine := 25;


                CLEAR(CompanyNameText);
                CLEAR(CompanyAddText);
                CompanyNameText := CompanyInfo.Name + ' ' + CompanyInfo."Name 2";
                //CompanyAddText := Company.Address +' '+ Company."Address 2";

                VATNo := CompanyInfo."VAT Registration No.";


                //AVPKJINT 29/04/2020
                Clear(SumBase);
                Clear(SumAmt);
                Clear(VatEntryTB);
                VatEntryTB.SetCurrentKey("Document Date", "External Document No.", "VAT Bus. Posting Group", "Posting Date", Type, "Document No.");
                VatEntryTB.SetRange(Type, Type::Purchase);
                VatEntryTB.SetFilter(Base, '<>%1', 0);
                VatEntryTB.SetFilter("External Document No.", '<>%1', '');
                VatEntryTB.SetFilter(Amount, '<>%1', 0);
                VatEntryTB.SetFilter("VAT Prod. Posting Group", '<>%1', 'UVAT');
                if VatEntryTB.Find('-') then begin
                    repeat
                        SumBase += VatEntryTB.Base;
                        SumAmt += VatEntryTB.Amount;
                    until VatEntryTB.Next = 0;
                end;
                //C-AVPKJINT 29/04/2020




                if CheckFrom = true then begin
                    SETFILTER("Posting Date", '%1..%2', "From Date", "To Date");
                    Year := DATE2DMY("From Date", 3) + 543;
                    Period := DATE2DMY("From Date", 2);
                    ValidateMonth;
                end
                else
                    if CheckYear = true then begin
                        SETFILTER("AVF_Period Submit", '%1', Period);
                        SETFILTER("AVF_Year Submit", '%1', Year);
                        Year := Year + 543;

                    end;
                TextYear := FORMAT(Year);

                //AVWCASTD.002 18/09/2013
                //Add Branch
                CLEAR(Branch);
                if VATBusFilter <> '' then begin
                    CLEAR(VATBusPostingGroup);
                    VATBusPostingGroup.SetRange(Code, VATBusFilter);
                    if VATBusPostingGroup.FindFirst then begin
                        if VATBusPostingGroup."AVF_Default Head Office" = true then begin
                            Branch[1] := 'สำนักงานใหญ่';//VATBusPostingGroup.Description;
                            Branch[2] := '';
                            VATAddress[1] := VATBusPostingGroup."AVF_VAT Address";
                            Showheadoffice := VATBusPostingGroup."AVF_Default Head Office";
                        end else begin
                            Branch[1] := 'สำนักงานใหญ่';
                            VATAddress[2] := VATBusPostingGroup."AVF_VAT Address";
                            Branch[2] := VATBusPostingGroup."AVF_Branch No.";
                            //Branch[2]:=VATBusPostingGroup.Description;
                            Showheadoffice := VATBusPostingGroup."AVF_Default Head Office";
                        end;
                    end;
                end;

                //if VATBusFilter<>'' then begin
                //  SETFILTER("VAT Bus. Posting Group",VATBusFilter);
                //  CLEAR(VATBusPostingGroup);
                //  VATBusPostingGroup.SetRange(Code,VATBusFilter);
                //  if VATBusPostingGroup.FindFirst then
                //  begin
                //    if VATBusPostingGroup."Default Head Office"=TRUE then begin
                //      VATAddress[1]:=VATBusPostingGroup."VAT Address";
                //      Branch[1]:=VATBusPostingGroup.Description;
                //      Showheadoffice:=VATBusPostingGroup."Default Head Office";
                //       CompanyAddText := VATBusPostingGroup."VAT Address";

                //    end ELSE begin
                //      CLEAR(VATBusPostingGroup2);
                //      VATBusPostingGroup2.SetRange(VATBusPostingGroup2."Default Head Office",TRUE);
                //      if VATBusPostingGroup2.FindFirst then begin
                //         VATAddress[1]:=VATBusPostingGroup2."VAT Address";
                //         Branch[1]:=VATBusPostingGroup2.Description;
                //      end;
                //      VATAddress[2]:=VATBusPostingGroup."VAT Address";
                //      Branch[2]:=VATBusPostingGroup.Description;
                //      Showheadoffice:=VATBusPostingGroup."Default Head Office";
                //       CompanyAddText := VATBusPostingGroup."VAT Address";

                //    end;
                //  end;
                //end;
                //C-AVWCASTD.002 18/09/2013

                if VATBusFilter <> '' then
                    SETFILTER("VAT Entry"."VAT Bus. Posting Group", VATBusFilter);

                CLEAR(BaseAMT);
                CLEAR(VATAMT);
                CLEAR(index);
                CLEAR(Tbase);
                CLEAR(TAmount);
                CLEAR(Total);
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
                    field(CheckYear; CheckYear)
                    {
                        ApplicationArea = All;
                        Caption = 'Submit Report';

                        trigger OnValidate();
                        begin
                            CheckFrom := false;
                            if CheckFrom = false then begin
                                CLEAR("From Date");
                                CLEAR("To Date");
                            end;
                            Period := DATE2DMY(TODAY, 2);
                            Year := DATE2DMY(TODAY, 3);
                            if Period <> 0 then
                                ValidateMonth;

                            if (CheckFrom = false) and (CheckYear = false) then begin
                                CheckYear := false;
                                CheckFrom := true;
                                CLEAR(Period);
                                CLEAR(Year);
                                CLEAR(Month);
                                if "From Date" = 0D then "From Date" := DMY2DATE(1, DATE2DMY(TODAY, 2), DATE2DMY(TODAY, 3));
                                if "To Date" = 0D then "To Date" := CALCDATE('1M', "From Date") - 1;
                                if Period <> 0 then
                                    ValidateMonth;
                            end;
                        end;
                    }
                    grid(Control1)
                    {
                        GridLayout = Rows;
                        group(Control2)
                        {
                            ShowCaption = false;
                            field(Year; Year)
                            {
                                ApplicationArea = All;
                                Caption = 'Year';
                                Enabled = CheckYear;

                                trigger OnValidate();
                                begin
                                    CLEAR("From Date");
                                    CLEAR("To Date");
                                end;
                            }
                            field(Period; Period)
                            {
                                ApplicationArea = All;
                                Caption = 'Month';
                                Enabled = CheckYear;

                                trigger OnValidate();
                                begin
                                    CLEAR("From Date");
                                    CLEAR("To Date");
                                    ValidateMonth;
                                end;
                            }
                            field(MonthEng; MonthEng)
                            {
                                Caption = 'Month';
                                ApplicationArea = All;
                                Editable = false;
                                Enabled = true;
                            }
                        }
                    }
                    field(CheckFrom; CheckFrom)
                    {
                        ApplicationArea = All;
                        Caption = 'Daily Post Checking';

                        trigger OnValidate();
                        begin
                            CheckYear := false;
                            if CheckYear = false then begin
                                CLEAR(Year);
                                CLEAR(Period);
                                CLEAR(Month);
                                if "From Date" = 0D then "From Date" := DMY2DATE(1, DATE2DMY(TODAY, 2), DATE2DMY(TODAY, 3));
                                if "To Date" = 0D then "To Date" := CALCDATE('1M', "From Date") - 1;
                            end;

                            if (CheckFrom = false) and (CheckYear = false) then begin
                                Period := DATE2DMY(TODAY, 2);
                                Year := DATE2DMY(TODAY, 3);
                                CheckYear := true;
                                CheckFrom := false;
                                CLEAR("From Date");
                                CLEAR("To Date");
                                if Period <> 0 then
                                    ValidateMonth;

                            end;
                        end;
                    }
                    field(FromDate; "From Date")
                    {
                        ApplicationArea = All;
                        Caption = 'From Date';
                        Enabled = CheckFrom;

                        trigger OnValidate();
                        begin
                            CLEAR(Year);
                            CLEAR(Period);
                        end;
                    }
                    field(ToDate; "To Date")
                    {
                        ApplicationArea = All;
                        Caption = 'To Date';
                        Enabled = CheckFrom;

                        trigger OnValidate();
                        begin
                            //"To Date":=CALCDATE('1M',"From Date")-1;
                            CLEAR(Year);
                            CLEAR(Period);
                        end;
                    }
                    field("VAT Bus. Posting Group"; VATBusFilter)
                    {
                        ApplicationArea = All;
                        Caption = 'VAT Bus. Posting Group';
                        TableRelation = "VAT Business Posting Group";

                        trigger OnValidate();
                        begin
                            if VATBusFilter = '' then
                                ERROR('"VAT Bus. Posting Group" must not empty');
                        end;
                    }
                    field(Month; Month)
                    {
                        ApplicationArea = All;
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
            Period := DATE2DMY(TODAY, 2);
            Year := DATE2DMY(TODAY, 3);
            ValidateMonth;
            CheckYear := true;
            CheckFrom := false;

            CLEAR(VATBusPostingGroup);
            VATBusPostingGroup.FindFirst;
            VATBusFilter := VATBusPostingGroup.Code;
        end;
    }

    labels
    {
    }

    var
        SumBase: Decimal;
        SumAmt: Decimal;
        Ven: Record Vendor;
        TAmount: Decimal;
        Tbase: Decimal;
        Total: Decimal;
        index: Integer;
        Vendor: Record Vendor;
        CompanyInfo: Record "Company Information";
        "From Date": Date;
        "To Date": Date;
        TempText: Text[250];
        VATPostingSetup: Record "VAT Posting Setup";
        FDATE: Text[30];
        TDATE: Text[30];
        BaseAMT: Decimal;
        VATAMT: Decimal;
        BaseTOT: Decimal;
        VATTOT: Decimal;
        InvDate: Text[30];
        FBase: Text[100];
        FAmount: Text[100];
        FAMT: Text[100];
        PAYTO: Text[100];
        PurchInvHead: Record "Purch. Inv. Header";
        PurchCrHead: Record "Purch. Cr. Memo Hdr.";
        Period: Integer;
        Year: Integer;
        Month: Text[40];
        MonthEng: Text[40];
        Branch: array[5] of Text[50];
        ShowDate: Text[30];
        VATBusFilter: Text[30];
        Text002: Label '"Period should be in 1-12. Please enter valid period. "';
        CompanyNameText: Text[1024];
        CompanyAddText: Text[1024];
        TextYear: Text[5];
        [InDataSet]
        CheckYear: Boolean;
        [InDataSet]
        CheckFrom: Boolean;
        PageNo: Integer;
        MaxLine: Integer;
        CountIndex: Integer;
        CheckLedger: Record "Check Ledger Entry";
        Showheadoffice: Boolean;
        VATAddress: array[5] of Text[250];
        VATBusPostingGroup: Record "VAT Business Posting Group";
        VATBusPostingGroup2: Record "VAT Business Posting Group";
        OldExternal: Code[30];
        SumTotalBase: Decimal;
        SumTotalAMT: Decimal;
        VatBus: Record "VAT Business Posting Group";
        OrderDate: Date;
        VatCen: Text[50];
        VatSub: Text[50];
        VATNo: Text[50];
        LineVATNo: Text[50];
        cuThai: Codeunit AVF_Thai;

    procedure ValidateMonth();
    begin
        if Period = 1 then begin
            Month := 'มกราคม';
            MonthEng := 'January';
        end else
            if Period = 2 then begin
                Month := 'กุมภาพันธ์';
                MonthEng := 'February';
            end else
                if Period = 3 then begin
                    Month := 'มีนาคม';
                    MonthEng := 'March';
                end else
                    if Period = 4 then begin
                        Month := 'เมษายน';
                        MonthEng := 'April';
                    end else
                        if Period = 5 then begin
                            Month := 'พฤษภาคม';
                            MonthEng := 'May';
                        end else
                            if Period = 6 then begin
                                Month := 'มิถุนายน';
                                MonthEng := 'June';
                            end else
                                if Period = 7 then begin
                                    Month := 'กรกฎาคม';
                                    MonthEng := 'July';
                                end else
                                    if Period = 8 then begin
                                        Month := 'สิงหาคม';
                                        MonthEng := 'August';
                                    end else
                                        if Period = 9 then begin
                                            Month := 'กันยายน';
                                            MonthEng := 'September';
                                        end else
                                            if Period = 10 then begin
                                                Month := 'ตุลาคม';
                                                MonthEng := 'October';
                                            end else
                                                if Period = 11 then begin
                                                    Month := 'พฤศจิกายน';
                                                    MonthEng := 'November';
                                                end else
                                                    if Period = 12 then begin
                                                        Month := 'ธันวาคม';
                                                        MonthEng := 'December';
                                                    end else begin
                                                        Month := '';
                                                        MonthEng := '';
                                                        MESSAGE('%1', Text002);
                                                    end;


        /*
       if Month <> '' then
       begin
         "From Date" := DMY2DATE(1,Period,Year);
         "To Date":=CALCDATE('1M',"From Date")-1;
       end;
        */

    end;

    procedure UpdateIntRefNo();
    var
        VATEntry: Record "VAT Entry";
        InvDate: Text[30];
        i: Integer;
    begin
        VATEntry.SetRange(Type, VATEntry.Type::Purchase);
        VATEntry.SETFILTER(Amount, '<>0');
        VATEntry.SETFILTER(Base, '<>0');
        //VATEntry.SETFILTER("External Document No.",'<>%1','');
        VATEntry.SETFILTER("AVF_Period Submit", '=%1', 0);
        VATEntry.SETFILTER("AVF_Year Submit", '=%1', 0);
        VATEntry.NEXT;

        for i := 1 to VATEntry.COUNT do begin
            CODEUNIT.RUN(CODEUNIT::"AVF_Update Vendor Invoice No.", VATEntry);
            VATEntry.NEXT;
        end;
    end;
}

