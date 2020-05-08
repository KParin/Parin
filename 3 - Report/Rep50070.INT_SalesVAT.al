report 50070 "INT_Sales VAT"
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
    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/Sales VAT.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Output Tax Report';

    dataset
    {
        dataitem("VAT Entry"; "VAT Entry")
        {
            DataItemTableView = SORTING("Posting Date", Type, "Document No.") WHERE(Type = CONST(Sale), "VAT Prod. Posting Group" = FILTER('<>NOVAT'));
            column(DateOfPrint; 'ประจำเดือน ' + Month + ' ปี ' + FORMAT(Year))
            {
            }
            column(CompanyName; Company.Name + Company."Name 2")
            {
            }
            column(CompanyAddress; Company.Address + ' ' + Company."Address 2")
            {
            }
            column(CompanyVATRegistrationNo; VATNo)
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
            column(indexLine; indexLine)
            {
            }
            column(ShowDate; ShowDate)
            {
            }
            column(ShowDoc; ShowDoc)
            {
            }
            column(ShowDes; ShowDes)
            {
            }
            column(ShowAmt; ShowAmt)
            {
            }
            column(ShowVAT; ShowVAT)
            {
            }
            column(AVBase; AVBase)
            {
            }
            column(AVAmount; AVAmount)
            {
            }
            column(DocumentNo_VATEntry; "Document No.")
            {
            }
            column(ExternalDocumentNo_VATEntry; "External Document No.")
            {

            }
            column(ShowReport; ShowReport)
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
            column(VatCen; VatCen)
            {
            }
            column(VatSub; VatSub)
            {
            }
            column(VatRegisNo_VATEntry; VatRegID)
            {
            }

            trigger OnAfterGetRecord();
            begin
                //if NOT Ven.GET("Bill-to/Pay-to No.") then CLEAR(Ven);
                Base := Base * -1;
                Amount := Amount * -1;

                CLEAR(VATPostingSetup);
                VATPostingSetup.SetRange("VAT Bus. Posting Group", "VAT Bus. Posting Group");
                VATPostingSetup.SetRange("VAT Prod. Posting Group", "VAT Prod. Posting Group");
                VATPostingSetup.NEXT;


                CLEAR(ShowDes);
                CLEAR(ShowAmt);
                CLEAR(ShowVAT);


                ShowReport := false;


                CLEAR(ShowDate);
                ShowDate := cuThai.FormatThaiDate("Posting Date", 3);
                //ShowDate := FORMAT("Posting Date",0,'<Day>') +'/'+ FORMAT(DATE2DMY("Posting Date",2)) + '/' +
                //            FORMAT(DATE2DMY("Posting Date",3) + 543);

                CLEAR(ShowDoc);
                if "Document Type" = "Document Type"::Payment then
                    ShowDoc := "External Document No."
                else
                    if "Document Type" = "Document Type"::"Credit Memo" then
                        ShowDoc := "Document No."
                    else
                        ShowDoc := "Document No.";

                CLEAR(VATPostingSetup2);
                VATPostingSetup2.SetCurrentKey("VAT Prod. Posting Group", "VAT Bus. Posting Group");
                VATPostingSetup2.SetRange("VAT Prod. Posting Group", "VAT Entry"."VAT Prod. Posting Group");
                VATPostingSetup2.SetRange("VAT Bus. Posting Group", "VAT Entry"."VAT Bus. Posting Group");
                if VATPostingSetup2.FindFirst then begin
                    if "Document Type" = "Document Type"::"Credit Memo" then begin
                        CLEAR(AVSalesCrH2);
                        AVSalesCrH2.SetCurrentKey("No.");
                        AVSalesCrH2.SetRange("No.", "VAT Entry"."Document No.");
                        if AVSalesCrH2.FindFirst then
                            ShowDoc := AVSalesCrH2."No.";
                    end else
                        if "Document Type" = "Document Type"::Invoice then begin
                            CLEAR(AVSalesInvH3);
                            AVSalesInvH3.SetCurrentKey("No.");
                            AVSalesInvH3.SetRange("No.", "VAT Entry"."Document No.");
                            if AVSalesInvH3.FindFirst then begin
                                if VATPostingSetup2."VAT %" > 0 then
                                    ShowDoc := AVSalesInvH3."No."
                                else
                                    ShowDoc := AVSalesInvH3."Pre-Assigned No.";
                            end;
                        end;
                end;

                ShowAmt := Base;
                ShowVAT := Amount;

                //AVWCAVIP 16/04/2014
                CLEAR(ShowDes);
                ShowDes := "VAT Entry".AVF_Description;
                if "VAT Entry"."Document Type" = "VAT Entry"."Document Type"::Invoice then begin
                    CLEAR(AVSalesInvH);
                    if AVSalesInvH.GET("VAT Entry"."Document No.") then
                        ShowDes := AVSalesInvH."Bill-to Name" + ' ' + AVSalesInvH."Bill-to Name 2";
                end
                else
                    if "VAT Entry"."Document Type" = "VAT Entry"."Document Type"::"Credit Memo" then begin
                        CLEAR(AVSalesCrH);
                        if AVSalesCrH.GET("VAT Entry"."Document No.") then
                            ShowDes := AVSalesCrH."Bill-to Name" + ' ' + AVSalesCrH."Bill-to Name 2";
                    end
                    else begin
                        CLEAR(Customer);
                        if Customer.GET("VAT Entry"."Bill-to/Pay-to No.") then
                            ShowDes := Customer.Name + ' ' + Customer."Name 2";
                    end;
                if "VAT Entry".AVF_Description <> '' then
                    ShowDes := "VAT Entry".AVF_Description;
                //AVWCAVIP 16/04/2014

                //AVSSMMIC-Cancel Code
                /*

                if ("VAT Entry".Type = "VAT Entry".Type::Sale) AND ("VAT Entry"."Document Type" = "VAT Entry"."Document Type"::Invoice) then
                begin
                  CLEAR(AVSalesInvH);
                  AVSalesInvH.SetCurrentKey("No.");
                  AVSalesInvH.SetRange("No.","Document No.");
                  if AVSalesInvH.FindFirst
                  then begin
                    if AVSalesInvH."Cancel CN" then
                      ShowReport:=TRUE

                    ELSE if AVSalesInvH."Cancel Bill" then
                    begin
                      ShowDes := 'ยกเลิก';
                      ShowAmt := 0;
                      ShowVAT := 0;
                    end
                    ELSE if (Base = 0) AND (Amount = 0) then
                      ShowReport:=TRUE
                    ELSE
                    begin
                      if (Base = 0) AND (Amount = 0) then
                        ShowReport:=TRUE
                      ELSE
                      if (AVSalesInvH."Cancel Bill" = FALSE) AND (AVSalesInvH."Cancel CN" = FALSE) then
                      begin
                        ShowDes := AVSalesInvH."Sell-to Customer Name";
                        ShowAmt := Base;
                        ShowVAT := Amount;
                      end
                      ELSE begin
                        ShowDes := AVSalesInvH."Sell-to Customer Name";
                        ShowAmt := Base;
                        ShowVAT := Amount;
                      end;
                    end;
                  end;
                end
                ELSE if ("VAT Entry".Type = "VAT Entry".Type::Sale) AND
                        ("VAT Entry"."Document Type" = "VAT Entry"."Document Type"::"Credit Memo") then
                begin
                    CLEAR(AVSalesCrH);
                    AVSalesCrH.SetCurrentKey(AVSalesCrH."No.");
                    AVSalesCrH.SetRange(AVSalesCrH."No.","VAT Entry"."Document No.");
                    if AVSalesCrH.FindFirst then
                    begin
                      if AVSalesCrH."Cancel Bill" = TRUE then
                        ShowReport:=TRUE
                      ELSE  if AVSalesCrH."Cancel CN" = TRUE then
                      begin
                        ShowDes := 'ยกเลิก';

                        ShowAmt := 0;
                        ShowVAT := 0;
                      end
                      ELSE if (AVSalesInvH."Cancel Bill" = FALSE) AND (AVSalesInvH."Cancel CN" = FALSE) then
                      begin
                        ShowDes := AVSalesInvH."Sell-to Customer Name";
                        ShowAmt := Base;
                        ShowVAT := Amount;
                      end
                      ELSE
                      begin
                        if (Base = 0) AND (Amount = 0) then
                          ShowReport:=TRUE
                        ELSE begin
                          ShowDes := AVSalesInvH."Sell-to Customer Name";
                          ShowAmt := Base;
                          ShowVAT := Amount;
                        end;
                      end;
                    end;
                  end ELSE begin
                    CLEAR(Customer);
                    Customer.SetCurrentKey("No.");
                    Customer.SetRange("No.","VAT Entry"."Bill-to/Pay-to No.");
                    if Customer.FindFirst then
                    begin
                      ShowDes := Customer.Name+' K3';
                      ShowAmt := "VAT Entry".Base;
                      ShowVAT := "VAT Entry".Amount;
                    end;
                    if (Base = 0) AND (Amount = 0) then
                      ShowReport:=TRUE;
                end;
                */
                /*
                //AVSSMVIP3-START
                Partial:=FALSE;
                CLEAR(CustLedgerEntry);
                CLEAR(AVCancelTxt);
                CustLedgerEntry.SetCurrentKey("Document No.","Document Type","Customer No.");
                CustLedgerEntry.SetRange("Document No.","Document No.");
                CustLedgerEntry.SetRange("Document Type","Document Type");
                if CustLedgerEntry.FindFirst then begin
                    if CustLedgerEntry."Closed by Entry No."<>0 then begin
                       AVCancelTxt:='ยกเลิก';
                       Partial:=FALSE;
                       CustLedgerEntry.CALCFIELDS("Remaining Amount");
                       if CustLedgerEntry."Remaining Amount"<>0 then begin
                           Partial:=FALSE;
                           AVCancelTxt:='';//Partial
                       end;

                       CLEAR(AppCustLedgerEntry);
                       AppCustLedgerEntry.SetCurrentKey("Document No.","Document Type","Customer No.");
                       AppCustLedgerEntry.SetRange("Entry No.",CustLedgerEntry."Closed by Entry No.");
                       if AppCustLedgerEntry.FindFirst then begin
                       AppCustLedgerEntry.CALCFIELDS("Remaining Amount");
                       AppCustLedgerEntry.CALCFIELDS("Original Amount");
                          if AppCustLedgerEntry."Remaining Amount"<>0 then begin
                              Partial:=FALSE;
                              AVCancelTxt:='';//Partial
                          end;
                          if (AppCustLedgerEntry."Document Type"<>AppCustLedgerEntry."Document Type"::"Credit Memo") AND
                             (AppCustLedgerEntry."Document Type"<>AppCustLedgerEntry."Document Type"::Invoice) then begin
                              Partial:=FALSE;
                              AVCancelTxt:='';//Payment
                          end;
                          if ABS(AppCustLedgerEntry."Original Amount")<>ABS(Base+Amount) then begin
                              Partial:=FALSE;
                              AVCancelTxt:='';//Partial
                          end;
                       end;
                    end ELSE begin
                       CLEAR(AppCustLedgerEntry);
                       AppCustLedgerEntry.SetCurrentKey("Document No.","Document Type","Customer No.");
                       AppCustLedgerEntry.SetRange("Closed by Entry No.",CustLedgerEntry."Entry No.");
                       if AppCustLedgerEntry.FindFirst then begin
                          AppCustLedgerEntry.CALCFIELDS("Remaining Amount");
                          CustLedgerEntry.CALCFIELDS("Remaining Amount");
                          if CustLedgerEntry."Remaining Amount"<>0 then begin
                              Partial:=FALSE;
                              AVCancelTxt:='';//Partial
                          end ELSE
                          if AppCustLedgerEntry."Remaining Amount"<>0 then begin
                              Partial:=FALSE;
                              AVCancelTxt:='';//Partial
                          end ELSE
                          if "VAT Entry"."VAT Prod. Posting Group"<>'SVAT' then
                            Partial:=TRUE;

                       end;

                    end;
                end;

                if (AVCancelTxt<>'')AND("VAT Entry"."VAT Prod. Posting Group"<>'SVAT') then begin
                   ShowDes :=AVCancelTxt;
                   ShowAmt :=0;
                   ShowVAT :=0;
                end;
                */
                //AVSSMVIP3-end


                ShowReport := ShowReport or Partial;

                if (not ShowReport) and (ShowDes <> 'ยกเลิก') then begin
                    if ShowAmt = 83.31 then
                        Check := "Document No."
                    else begin
                        AVBase += ShowAmt;//Base;
                        AVAmount += ShowVAT;//Amount;
                    end;
                end;

                CLEAR(TempVAT);
                CLEAR(SumA);
                CLEAR(SumB);
                TempVAT.SetCurrentKey("Posting Date", Type, "Document No.");
                TempVAT.COPYFILTERS("VAT Entry");
                TempVAT.SetRange("Posting Date", "Posting Date");
                TempVAT.SetRange("Document No.", "Document No.");
                if TempVAT.FIND('-') then begin
                    repeat
                        SumA += TempVAT.Amount;
                        SumB += TempVAT.Base;
                    until TempVAT.NEXT = 0;
                end;
                if (SumA = 0) and (SumB = 0) and (ShowDes <> 'ยกเลิก') then
                    CurrReport.SKIP;

                if ShowReport then
                    CurrReport.SKIP;

                CLEAR(TempVAT);
                TempVAT.COPY("VAT Entry");
                //if (TempVAT.NEXT>0) AND (TempVAT."Document No."<>"Document No.")then begin
                //  if (NOT ShowReport)then;
                //indexLine := indexLine + 1;
                /*end ELSE */

                if indexLine = 0 then
                    indexLine := 1
                else
                    //if OldDoc <> "Document No." then
                    //    indexLine += 1;
                    if OldDoc <> "External Document No." then
                        indexLine += 1;
                //else begin
                //    Clear(indexLine);
                //    indexLine += 1;
                //end;

                OldDoc := "External Document No.";


                //AVNOJ STD 03/09/13
                CLEAR(VatCen);
                CLEAR(VatSub);
                //if ("AVF_Branch No." = '00000') or ("AVF_Branch No." = 'สำนักงานใหญ่') then
                if ("AVF_Branch No." = '00000') or ("AVF_Branch No." = 'สำนักงานใหญ่') or ("AVF_Branch No." = 'Head') or ("AVF_Branch No." = 'HEAD') or ("AVF_Branch No." = 'head') or (StrPos("AVF_Branch No.", 'สำนักงาน') <> 0) then
                    //if "Branch No." = '0000' then
                    VatCen := 'X'//"VAT Entry"."Branch No."
                else
                    VatSub := "VAT Entry"."AVF_Branch No.";
                //end AVNOJ STD 03/09/13

                CLEAR(VatRegID);
                //VatRegID:="VAT Registration No.";
                VatRegID := COPYSTR("VAT Registration No.", 1, 1) + '-' +
                            COPYSTR("VAT Registration No.", 2, 4) + '-' +
                            COPYSTR("VAT Registration No.", 6, 5) + '-' +
                            COPYSTR("VAT Registration No.", 11, 2) + '-' +
                            COPYSTR("VAT Registration No.", 13, 1);


                if ShowDes = 'ยกเลิก' then begin
                    CLEAR(VatSub);
                    CLEAR(VatCen);
                    CLEAR(VatRegID);
                end;

            end;

            trigger OnPreDataItem();
            begin
                UpdateIntRefNo;
                PrintHead := true;
                indexLine := 0;
                CLEAR(VATAddress);
                CLEAR(Showheadoffice);
                CLEAR(Branch);

                Company.GET;
                SETFILTER("VAT Entry"."VAT Prod. Posting Group", '<>%1', 'VAT0');

                VATNo := Company."VAT Registration No.";

                if FilterOption2 then begin
                    SETFILTER("Posting Date", '%1..%2', "From Date", "To Date");
                    Year := DATE2DMY("From Date", 3) + 543;
                    Period := DATE2DMY("From Date", 2);
                    ValidateMonth;
                end
                else
                    if FilterOption1 then begin
                        SETFILTER("AVF_Period Submit", '%1', Period);
                        SETFILTER("AVF_Year Submit", '%1', Year);
                        Year := Year + 543;
                    end;

                // Get Branch //
                //AVWCASTD.001 18/09/2013
                //Add Branch
                CLEAR(Branch);
                if VatBus <> '' then begin
                    CLEAR(VATBusPostingGroup);
                    VATBusPostingGroup.SetRange(Code, VatBus);
                    if VATBusPostingGroup.FindFirst then begin
                        if VATBusPostingGroup."AVF_Default Head Office" = true then begin
                            Branch[1] := 'สำนักงานใหญ่';//VATBusPostingGroup.Description;
                            Branch[2] := '';
                            VATAddress[1] := VATBusPostingGroup."AVF_VAT Address";//Company.Address+' '+Company."Address 2";
                            Showheadoffice := VATBusPostingGroup."AVF_Default Head Office";
                        end else begin
                            VATAddress[2] := VATBusPostingGroup."AVF_VAT Address";
                            Branch[1] := 'สำนักงานใหญ่';
                            Branch[2] := VATBusPostingGroup."AVF_Branch No.";
                            //Branch[2]:= VATBusPostingGroup.Description;
                            Showheadoffice := VATBusPostingGroup."AVF_Default Head Office";
                        end;
                    end;
                end;
                //{
                //if VatBus<>'' then begin
                //  CLEAR(VATBusPostingGroup);
                //  VATBusPostingGroup.SetRange(Code,VatBus);
                //  if VATBusPostingGroup.FindFirst then begin
                //    if VATBusPostingGroup."Default Head Office"=TRUE then begin
                //      VATAddress[1]:=Company.Address+' '+Company."Address 2";//VATBusPostingGroup."VAT Address";
                //      Branch[1]:='สำนักงานใหญ่';//VATBusPostingGroup.Description;
                //      Showheadoffice:=VATBusPostingGroup."Default Head Office";
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
                //    end;
                //  end;
                //end;
                //Showheadoffice:=TRUE;
                //VATAddress[1]:=Company.Address+' '+Company."Address 2";
                //Branch[1]:='สำนักงานใหญ่';
                //VATAddress[2]:=Company.Address+' '+Company."Address 2";
                //Branch[2]:='สาขา';
                //}
                //C-AVWCASTD.001 18/09/2013

                if VatBus <> '' then
                    SETFILTER("VAT Entry"."VAT Bus. Posting Group", VatBus);
                if VatProd <> '' then
                    SETFILTER("VAT Entry"."VAT Prod. Posting Group", VatProd);
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
                    field("Submit Report"; FilterOption1)
                    {
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            FilterOption2 := false;
                            if FilterOption2 = false then begin
                                CLEAR("From Date");
                                CLEAR("To Date");
                            end;
                            Period := DATE2DMY(TODAY, 2);
                            Year := DATE2DMY(TODAY, 3);
                            if Period <> 0 then
                                ValidateMonth;

                            if (FilterOption1 = false) and (FilterOption2 = false) then begin
                                CLEAR(Period);
                                CLEAR(Year);
                                CLEAR(Month);
                                FilterOption2 := true;
                                FilterOption1 := false;
                                if "From Date" = 0D then "From Date" := DMY2DATE(1, DATE2DMY(TODAY, 2), DATE2DMY(TODAY, 3));
                                if "To Date" = 0D then "To Date" := CALCDATE('1M', "From Date") - 1;
                            end;
                        end;
                    }
                    grid(Control11)
                    {
                        GridLayout = Rows;
                        group(Control13)
                        {
                            //The GridLayout property is only supported on controls of type Grid
                            //GridLayout = Columns;
                            ShowCaption = false;
                            field(Year; Year)
                            {
                                ApplicationArea = All;
                                Editable = FilterOption1;
                            }
                            field(Period; Period)
                            {
                                ApplicationArea = All;
                                Enabled = FilterOption1;

                                trigger OnValidate();
                                begin
                                    ValidateMonth;
                                end;
                            }
                            field(MonthEng; MonthEng)
                            {
                                Caption = 'Month';
                                ApplicationArea = All;
                                Enabled = false;
                            }
                        }
                    }
                    field("Daily Post Checking"; FilterOption2)
                    {
                        ApplicationArea = All;

                        trigger OnValidate();
                        begin
                            FilterOption1 := false;
                            if FilterOption1 = false then begin
                                CLEAR(Year);
                                CLEAR(Period);
                                CLEAR(Month);
                                if "From Date" = 0D then "From Date" := DMY2DATE(1, DATE2DMY(TODAY, 2), DATE2DMY(TODAY, 3));
                                if "To Date" = 0D then "To Date" := CALCDATE('1M', "From Date") - 1;
                            end;

                            if (FilterOption1 = false) and (FilterOption2 = false) then begin
                                Period := DATE2DMY(TODAY, 2);
                                Year := DATE2DMY(TODAY, 3);
                                FilterOption1 := true;
                                FilterOption2 := false;
                                CLEAR("From Date");
                                CLEAR("To Date");
                                if Period <> 0 then
                                    ValidateMonth;
                            end;
                        end;
                    }
                    field("To Date"; "To Date")
                    {
                        ApplicationArea = All;
                        Enabled = FilterOption2;
                    }
                    field("From Date"; "From Date")
                    {
                        ApplicationArea = All;
                        Enabled = FilterOption2;

                        trigger OnValidate();
                        begin
                            "To Date" := CALCDATE('1M', "From Date") - 1;
                        end;
                    }
                    field("VAT Bus. Posting Group"; VatBus)
                    {
                        ApplicationArea = All;
                        TableRelation = "VAT Business Posting Group";

                        trigger OnValidate();
                        begin
                            if VatBus = '' then
                                ERROR('"VAT Bus. Posting Group" must not empty');
                        end;
                    }
                    field("VAT Prod. Posting Group"; VatProd)
                    {
                        ApplicationArea = All;
                        TableRelation = "VAT Product Posting Group";
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
            FilterOption1 := true;
            Period := DATE2DMY(TODAY, 2);
            Year := DATE2DMY(TODAY, 3);
            ValidateMonth;
            CLEAR(VATBusPostingGroup);
            VATBusPostingGroup.FindFirst();
            VatBus := VATBusPostingGroup.Code;
        end;
    }

    labels
    {
    }

    var
        Ven: Record Customer;
        Tbase: Decimal;
        indexLine: Integer;
        Company: Record "Company Information";
        Thai: Codeunit AVF_Thai;
        "From Date": Date;
        "To Date": Date;
        TempText: Text[14];
        VATPostingSetup: Record "VAT Posting Setup";
        Period: Integer;
        Year: Integer;
        Month: Text[30];
        MonthEng: Text[30];
        VATBusPostingGroup: Record "VAT Business Posting Group";
        VATBusPostingGroup2: Record "VAT Business Posting Group";
        Branch: array[5] of Text[50];
        PrintHead: Boolean;
        ShowDoc: Code[35];
        ShowDate: Text[30];
        ShowDes: Text[200];
        ShowAmt: Decimal;
        ShowVAT: Decimal;
        AVSalesInvH: Record "Sales Invoice Header";
        AVSalesCrH: Record "Sales Cr.Memo Header";
        AVSalesInvH2: Record "Sales Invoice Header";
        Customer: Record Customer;
        AVBase: Decimal;
        AVAmount: Decimal;
        Check: Code[20];
        VatProd: Code[20];
        VatBus: Code[20];
        VATPostingSetup2: Record "VAT Posting Setup";
        AVSalesInvH3: Record "Sales Invoice Header";
        AVSalesCrH2: Record "Sales Cr.Memo Header";
        [InDataSet]
        FilterOption1: Boolean;
        Text002: Label '"Period should be in 1-12. Please enter valid period. "';
        [InDataSet]
        FilterOption2: Boolean;
        TempVAT: Record "VAT Entry";
        ShowReport: Boolean;
        OldDoc: Code[20];
        Showheadoffice: Boolean;
        VATAddress: array[5] of Text[250];
        AVCancelTxt: Text[30];
        Partial: Boolean;
        CustLedgerEntry: Record "Cust. Ledger Entry";
        AppCustLedgerEntry: Record "Cust. Ledger Entry";
        VatCen: Text[50];
        VatSub: Text[50];
        VatRegID: Text[50];
        SumB: Decimal;
        SumA: Decimal;
        VATNo: Text[50];
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
    end;

    procedure UpdateIntRefNo();
    var
        VATEntry: Record "VAT Entry";
        InvDate: Text[30];
        i: Integer;
    begin
        VATEntry.SetRange(Type, VATEntry.Type::Sale);
        //VATEntry.SETFILTER(Amount,'<>0');
        //VATEntry.SETFILTER(Base,'<>0');
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

