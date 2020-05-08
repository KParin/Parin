report 50060 "INT_Sales Debit Note 2"
{
    // version AVTHLC1.0
    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/Sales Debit Note 2.rdl';
    Caption = 'Sales Debit Note 2';

    dataset
    {
        dataitem("Sales Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            //PrintOnlyIfDetail = true;

            column(CountPage; CountPage)
            {
            }
            column(OptionHeaderTHA; OptionHeaderTHA)
            {
            }
            column(OptionHeaderEN; OptionHeaderEN)
            {
            }
            column(No_SalesInvoiceHeader; "Sales Invoice Header"."No.")
            {
            }
            column(InvAmount; InvAmt)
            {
            }
            column(AppliedInv1; AppliedInv1)
            {
            }
            column(PostingDate1; RefInvDateText)
            {
            }
            column(RefInvAmt; RefInvAmt)
            {
            }
            column(Text1; Text1)
            {
            }
            column(Text2; Text2)
            {
            }
            column(PaymentTerm_Desc; PaymentTermTB.Description)
            {
            }


            dataitem(CopyLoop; Integer)
            {
                DataItemTableView = SORTING(Number);
                //PrintOnlyIfDetail = true;
                //DataItemLinkReference = "Sales Invoice Header";


                column(CommentTxt1; CommentTxt[1])
                {
                }
                column(CommentTxt2; CommentTxt[2])
                {
                }
                column(CommentTxt3; CommentTxt[3])
                {
                }


                column(PostingDate_SalesInvoiceHeader; PostDateText)
                {
                }
                column(YourReference_SalesInvoiceHeader; "Sales Invoice Header"."Your Reference")
                {
                }

                column(SelltoCustomerNo_SalesInvoiceHeader; "Sales Invoice Header"."Sell-to Customer No.")
                {
                }
                column(BilltoCustomerNo_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Customer No.")
                {
                }
                column(BilltoName_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Name")
                {
                }
                column(BilltoName2_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Name 2")
                {
                }
                column(BilltoAddress_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Address")
                {
                }
                column(BilltoAddress2_SalesInvoiceHeader; "Sales Invoice Header"."Bill-to Address 2" + ' ' + "Sales Invoice Header"."AVF_Bill-to Address 3")
                {
                }

                column(PostingDescription_SalesInvoiceHeader; "Sales Invoice Header"."Posting Description")
                {
                }
                column(VATRegistrationNo_SalesInvoiceHeader; "Sales Invoice Header"."VAT Registration No.")
                {
                }

                column(AddLine; AddLine)
                {
                }
                column(DueDate_SalesInvoiceHeader; DueDateText)
                {
                }


                column(CompanyNameEng; CompanyInfo.FNGN001_NameEng)
                {
                }
                column(CompanyAdressEng; CompanyInfo.FNGN001_AddressEng)
                {
                }
                column(CompanyAdressEng2; CompanyInfo."FNGN001_AddressEng 2")
                {
                }

                column(CompanyFaxNo; CompanyInfo."Fax No.")
                {
                }


                column(CompanyPhoneNo; 'โทร/TEL. ' + CompanyInfo."Phone No." + '  แฟกซ์/FAX. ' + CompanyInfo."Fax No.")
                {
                }

                column(CompanyInfo_AddressEng; CompanyInfo.FNGN001_AddressEng)
                {
                }
                column(CompanyInfo_AddressEng2; CompanyInfo."FNGN001_AddressEng 2")
                {
                }
                column(CompanyInfo_HomePage; CompanyInfo."Home Page")
                {
                }
                column(CompanyInfo_NameEng; CompanyInfo.FNGN001_NameEng + ' ' + CompanyInfo."FNGN001_NameEng 2")
                {
                }

                column(OutputNo; OutputNo)
                {
                }
                column(Number_Loop; format(Number))
                {
                }
                column(HeaderText; HeaderText)
                {
                }
                column(CompanyName; CompanyInfo.Name)
                {
                }
                column(CompanyPicture; CompanyInfo.Picture)
                {
                }
                column(CompanyAddress; CompanyInfo.Address)
                {
                }
                column(CompanyAddress2; CompanyInfo."Address 2")
                {
                }
                column(CompanyPhone; 'Tel: ' + CompanyInfo."Phone No." + ' Fax: ' + CompanyInfo."Fax No.")
                {
                }
                column(CompanyVAT; 'Tax No.: ' + CompanyInfo."VAT Registration No.")
                {
                }
                column(CompanyEmail; 'E: ' + CompanyInfo."E-Mail")
                {
                }
                column(CompanyHomePage; 'W: ' + CompanyInfo."Home Page")
                {
                }
                column(PostingDate_SalesCrMemoHeader; FORMAT("Sales Invoice Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                {
                }
                column(YourReference_SalesCrMemoHeader; "Sales Invoice Header"."Your Reference")
                {
                }
                column(RefSalesperson; Salesperson.Name)
                {
                }
                column(SelltoCustomerNo_SalesCrMemoHeader; "Sales Invoice Header"."Sell-to Customer No.")
                {
                }
                column(BilltoCustomerNo_SalesCrMemoHeader; "Sales Invoice Header"."Bill-to Customer No.")
                {
                }
                column(BilltoName_SalesCrMemoHeader; "Sales Invoice Header"."Bill-to Name")
                {
                }
                column(BilltoName2_SalesCrMemoHeader; "Sales Invoice Header"."Bill-to Name 2")
                {
                }
                column(BilltoAddress_SalesCrMemoHeader; "Sales Invoice Header"."Bill-to Address")
                {
                }
                column(BilltoAddress2_SalesCrMemoHeader; "Sales Invoice Header"."Bill-to Address 2")
                {
                }
                column(BilltoAddress3_SalesCrMemoHeader; "Sales Invoice Header"."AVF_Bill-to Address 3")
                {
                }
                column(CustomerBranchNo_SalesCrMemoHeader; "Sales Invoice Header"."AVF_Customer Branch No.")
                {
                }
                column(PhoneNo_Customer; Customer."Phone No.")
                {
                }
                column(FaxNo_Customer; Customer."Fax No.")
                {
                }
                column(Email_Customer; Customer."E-Mail")
                {
                }
                column(PostingDescription_SalesCrMemoHeader; "Sales Invoice Header"."Posting Description")
                {
                }
                column(VATBusPostingGroup_SalesCrMemoHeader; "Sales Invoice Header"."VAT Registration No.")
                {
                }
                column(Descrip_VatBusPos; VatBusPos."AVF_Branch No.")
                {
                }
                column(VATPersent; VATPersent)
                {
                }

                dataitem("Sales Invoice Line"; "Sales Invoice Line")
                {
                    DataItemTableView = SORTING("Document No.", "Line No.");
                    DataItemLinkReference = "Sales Invoice Header";
                    DataItemLink = "Document No." = FIELD("No.");


                    column(RunningNo; RunningNo)
                    {
                    }
                    column(Line; Line)
                    {
                    }
                    column(AllLine; AllLine)
                    {
                    }
                    column(Type_SalesInvoiceLine; "Sales Invoice Line".Type)
                    {
                    }
                    column(No_SalesInvoiceLine; "Sales Invoice Line"."No.")
                    {
                    }
                    column(Description_SalesInvoiceLine; "Sales Invoice Line".Description)
                    {
                    }
                    column(Description2_SalesInvoiceLine; "Sales Invoice Line"."Description 2")
                    {
                    }
                    column(UnitofMeasure_SalesInvoiceLine; UOM)
                    {
                    }
                    column(Quantity_SalesInvoiceLine; "Sales Invoice Line".Quantity)
                    {
                    }
                    column(UnitPrice_SalesInvoiceLine; "Sales Invoice Line"."Unit Price")
                    {
                    }
                    column(LineAmount_SalesInvoiceLine; "Sales Invoice Line"."Amount Including VAT")
                    {
                    }
                    column(InvDiscountAmount_SalesInvoiceLine; "Sales Invoice Line"."Inv. Discount Amount")
                    {
                    }
                    column(LineDiscountAmount_SalesInvoiceLine; Disc)
                    {
                    }
                    column(Amount_SalesInvoiceLine; "Sales Invoice Line".Amount)
                    {
                    }
                    column(AmountIncludingVAT_SalesInvoiceLine; "Sales Invoice Line"."Amount Including VAT")
                    {
                    }
                    column(LineAmount; LineAmount)
                    {
                    }
                    column(SubTotal; SubTotal)
                    {
                    }
                    column(LineVAT; LineVAT)
                    {
                    }
                    column(SumAmtIncl; "Sales Invoice Line"."Amount Including VAT")
                    {
                    }


                    trigger OnPreDataItem()
                    begin
                        IF I > 0 THEN
                            CLEAR(CompanyInfo);

                        I := 1;
                        RunningNo := 0;
                        CLEAR(Vatpersent);

                        CLEAR(SalesInvL);
                        SalesInvL.SETCURRENTKEY("Document No.", "Line No.");
                        SalesInvL.SETRANGE("Document No.", "Sales Invoice Header"."No.");
                        IF SalesInvL.FINDSET THEN BEGIN
                            REPEAT
                                IF SalesInvL.Description <> '' THEN
                                    AllLine += 1;
                            //IF SalesInvL."Description 2" <> '' THEN //AVWNFCNX.001 220519
                            //AllLine +=1; //AVWNFCNX.001 220519
                            UNTIL SalesInvL.NEXT = 0;
                        END;
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        //Message('No. : %1', "Sales Invoice Line"."No.");
                        //RunningNo += 1;
                        IF Description <> '' THEN
                            Line += 1;
                        IF "Sales Invoice Line"."No." <> '' THEN
                            RunningNo += 1;
                        SubTotal += Amount;
                        IF ("Sales Invoice Line"."VAT %" <> 0) AND ("Sales Invoice Line"."No." <> '') THEN
                            VATPersent := FORMAT("Sales Invoice Line"."VAT %", 0, '<Precision,0:0><Sign><Integer Thousand><Decimals>') + '%';
                        if "VAT Prod. Posting Group" = 'NOVAT' then
                            VATPersent := '';

                        if (((Line - 1) mod MaxLine) = 0) and (Line <> 1) then
                            CountPage += 1;

                        LineVAT := ("Sales Invoice Line".Amount * "Sales Invoice Line"."VAT %") / 100;

                    end;

                }

                dataitem("Empty Line"; Integer)
                {
                    DataItemTableView = SORTING(Number);
                    //DataItemLinkReference = CopyLoop;

                    column(Number_EmptyLine; "Empty Line".Number)
                    {
                    }
                    column(SumLineAmt; "Sales Invoice Line"."Line Amount")
                    {
                    }



                    trigger OnPreDataItem()
                    begin
                        IF Line = AllLine THEN BEGIN
                            IF (Line MOD MaxLine = 0) THEN
                                SETRANGE(Number, 1, 0)
                            ELSE BEGIN
                                AddLine := MaxLine - (Line MOD MaxLine);
                                SETRANGE(Number, 1, AddLine);
                            END;
                        END
                        ELSE
                            SETRANGE(Number, 1, 0);
                    end;
                }

                trigger OnPreDataItem()
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    IF NoOfLoops <= 0 THEN
                        NoOfLoops := 1;
                    IF CopyText[1] = '' THEN
                        CopyText[1] := 'ต้นฉบับ/Original';
                    SETRANGE(Number, 1, NoOfLoops);
                    OutputNo := 1;
                end;

                trigger OnAfterGetRecord()
                begin
                    IF Number > 1 THEN BEGIN
                        //CopyText := STRSUBSTNO(Text003,CopyText[]);
                        OutputNo += 1;
                    END;
                    //CurrReport.PAGENO := 1;
                    CLEAR(AllLine);
                    CLEAR(RunningNo);
                    CLEAR(Line);
                    CLEAR(SumLineAmt);
                    CLEAR(LineVAT);
                    CLEAR(SumAmtIncl);
                    CountPage := 1;
                    HeaderText := GetHeaderText(CopyLoop.Number);

                end;
            }


            trigger OnPreDataItem()
            begin
                //CurrReport.LANGUAGE := Language.GetLanguageID("Language Code");
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture);
                MaxLine := 17;
                //MaxLine := 14;
                //AVKSAFERRUM 19/06/2017
                IF Text1 = Text1::"ใบเพิ่มหนี้" THEN
                    Text2 := Text2::"Debit Note"
                ELSE
                    IF Text1 = Text1::"ใบเพิ่มหนี้/ใบกำกับภาษี" THEN
                        Text2 := Text2::"Debit Note/Tax Invoice";
                //C-AVKSAFERRUM 19/06/2017
            end;

            trigger OnAfterGetRecord()
            begin
                CLEAR(AllLine);
                CLEAR(RunningNo);
                CLEAR(Line);

                CLEAR(Customer);
                CLEAR(Salesperson);

                CountPage := 1;

                //AVWNFCNX.001 280619
                PostDateText := ThaiCU.FormatThaiDate("Sales Invoice Header"."Posting Date", 3);
                DueDateText := ThaiCU.FormatThaiDate("Sales Invoice Header"."Due Date", 3);
                //C-AVWNFCNX.001 280619

                IF OptionHeaderTHA = OptionHeaderTHA::"ใบเพิ่มหนี้" then
                    OptionHeaderEN := OptionHeaderEN::"Debit Note"
                else
                    OptionHeaderEN := OptionHeaderEN::"Debit Note/Tax";

                IF "Bill-to Customer No." <> '' THEN
                    Customer.GET("Bill-to Customer No.")
                ELSE
                    Customer.GET("Sell-to Customer No.");

                IF "Salesperson Code" <> '' THEN
                    Salesperson.GET("Salesperson Code");

                CLEAR(AppliedInv);
                IF "Your Reference" <> '' THEN BEGIN
                    AppliedInv := "Your Reference";
                    //AVWCACIP.001 15.06.2014 Add code for Ref. Invoice Date & Ref. Invoice Amt.
                    IF "Sales Invoice Header"."FNGN002_Ref. Invoice Date" <> 0D THEN BEGIN
                        RefInvDate := FORMAT("Sales Invoice Header"."FNGN002_Ref. Invoice Date", 0, 1);
                        RefInvDateText := ThaiCU.FormatThaiDate("Sales Invoice Header"."FNGN002_Ref. Invoice Date", 3);
                    END ELSE BEGIN
                        //C-AVWCACIP.001 15.06.2014 Add code for Ref. Invoice Date & Ref. Invoice Amt.
                        REPEAT
                            CLEAR(POS);
                            POS := STRPOS(AppliedInv, ',');
                            IF POS > 0 THEN BEGIN
                                IF AppliedInv1 = '' THEN BEGIN
                                    AppliedInv1 := AppliedInv1 + COPYSTR(AppliedInv, 1, POS - 1);

                                    CLEAR(refSalesInvHead);
                                    refSalesInvHead.SETRANGE(refSalesInvHead."No.", COPYSTR(AppliedInv, 1, POS - 1));
                                    IF refSalesInvHead.FINDFIRST THEN BEGIN
                                        refSalesInvHead.CALCFIELDS("Amount Including VAT");
                                        RefInvDate := FORMAT(refSalesInvHead."Document Date", 0, 1);
                                        RefInvDateText := ThaiCU.FormatThaiDate(refSalesInvHead."Document Date", 3);
                                    END;
                                END
                                ELSE BEGIN
                                    AppliedInv1 := AppliedInv1 + '|' + COPYSTR(AppliedInv, 1, POS - 1);

                                    CLEAR(refSalesInvHead);
                                    refSalesInvHead.SETRANGE(refSalesInvHead."No.", COPYSTR(AppliedInv, 1, POS - 1));
                                    IF refSalesInvHead.FINDFIRST THEN BEGIN
                                        refSalesInvHead.CALCFIELDS("Amount Including VAT");
                                        RefInvDate += ', ' + FORMAT(refSalesInvHead."Document Date", 0, 1);
                                        RefInvDateText += ', ' + ThaiCU.FormatThaiDate(refSalesInvHead."Document Date", 3);
                                    END;
                                END;
                                AppliedInv := DELSTR(AppliedInv, 1, POS);
                            END
                            ELSE BEGIN
                                IF (AppliedInv <> '') AND (AppliedInv1 <> '') THEN BEGIN
                                    AppliedInv1 := AppliedInv1 + '|' + AppliedInv;

                                    CLEAR(refSalesInvHead);
                                    refSalesInvHead.SETRANGE(refSalesInvHead."No.", AppliedInv);
                                    IF refSalesInvHead.FINDFIRST THEN BEGIN
                                        refSalesInvHead.CALCFIELDS("Amount Including VAT");
                                        RefInvDate += ', ' + FORMAT(refSalesInvHead."Document Date", 0, 1);
                                        RefInvDateText += ', ' + ThaiCU.FormatThaiDate(refSalesInvHead."Document Date", 3);
                                    END;
                                END
                                ELSE BEGIN
                                    CLEAR(refSalesInvHead);
                                    refSalesInvHead.SETRANGE(refSalesInvHead."No.", AppliedInv);
                                    IF refSalesInvHead.FINDFIRST THEN BEGIN
                                        refSalesInvHead.CALCFIELDS("Amount Including VAT");
                                        RefInvDate := FORMAT(refSalesInvHead."Document Date", 0, 1);
                                        RefInvDateText := ThaiCU.FormatThaiDate(refSalesInvHead."Document Date", 3);
                                    END;
                                END;
                            END;

                        UNTIL (POS = 0);
                        //AVWCACIP.001 15.06.2014 Add code for Ref. Invoice Date & Ref. Invoice Amt.
                    END;
                    //C-AVWCACIP.001 15.06.2014 Add code for Ref. Invoice Date & Ref. Invoice Amt.
                    AppliedInv1 := AppliedInv;
                END;

                CLEAR(InvAmt);
                CLEAR(SalesInvHead);
                //AVWCACIP.001 15.06.2014 Add code for Ref. Invoice Date & Ref. Invoice Amt.
                IF (AppliedInv1 <> '') AND ("Sales Invoice Header"."FNGN002_Ref.Inv.Amt.Incd.VAT" = 0) THEN BEGIN
                    //IF AppliedInv1 <> '' THEN
                    //C-AVWCACIP.001 15.06.2014 Add code for Ref. Invoice Date & Ref. Invoice Amt.
                    SalesInvHead.SETCURRENTKEY("No.");
                    SalesInvHead.SETFILTER("No.", AppliedInv1);
                    IF SalesInvHead.FINDSET THEN BEGIN
                        REPEAT
                            SalesInvHead.CALCFIELDS(Amount, "Amount Including VAT");
                            InvAmt := InvAmt + SalesInvHead.Amount;
                            InvIncAmt += SalesInvHead."Amount Including VAT";
                        UNTIL SalesInvHead.NEXT = 0;
                    END;
                END
                //AVWCACIP.001 15.06.2014 Add code for Ref. Invoice Date & Ref. Invoice Amt.
                ELSE BEGIN
                    InvAmt := "Sales Invoice Header"."FNGN002_Ref.Inv.Amt.Incd.VAT" / 1.07;
                    InvIncAmt := "Sales Invoice Header"."FNGN002_Ref.Inv.Amt.Incd.VAT";
                END;
                //E-AVWCACIP.001 15.06.2014 Add code for Ref. Invoice Date & Ref. Invoice Amt.


                IF InvIncAmt <> 0 THEN
                    RefInvAmt := FORMAT(InvIncAmt, 0, '<Precision,2:2><Integer Thousand><Decimals>')
                ELSE
                    RefInvAmt := '';
                //AVNOJ VIP3 050913
                CLEAR(VatBusPos);
                IF VatBusPos.GET("VAT Bus. Posting Group") THEN;
                //END AVNOJ VIP3 050913

                //AVWNFCNX.001 220519
                CLEAR(CommentTxt);
                CLEAR(CountComment);
                CLEAR(SaleComLineTB);
                SaleComLineTB.SETCURRENTKEY("Document Type", "No.", "Document Line No.", "Line No.");
                SaleComLineTB.SETRANGE("No.", "Sales Invoice Header"."No.");
                IF SaleComLineTB.FINDSET THEN BEGIN
                    REPEAT
                        CountComment += 1;
                        IF CountComment <= 3 THEN
                            CommentTxt[CountComment] := SaleComLineTB.Comment;
                    UNTIL SaleComLineTB.NEXT = 0;
                END;
                //C-AVWNFCNX.001 220519

                //AVWNFCNX.001 290419
                CLEAR(PaymentTermTB);
                PaymentTermTB.SETCURRENTKEY(Code);
                PaymentTermTB.SETRANGE(Code, "Sales Invoice Header"."Payment Terms Code");
                IF PaymentTermTB.FINDFIRST THEN;
                //C-AVWNFCNX.001 290419

            end;

        }
    }




    requestpage
    {

        layout
        {
            area(content)
            {

                group(Options)
                {
                    Caption = 'Options';
                    field(NoOfCopy; NoOfCopies)
                    {
                        ApplicationArea = all;
                        Caption = 'No. of Copies';
                        MaxValue = 1;
                        MinValue = 0;

                        trigger OnValidate();
                        begin
                            EnableControl();
                        end;
                    }
                    field(OriginalText; CopyText[1])
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Original Text',
                                    THA = 'Original Text';
                    }
                    field(CopyText1; CopyText[2])
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Copy Text 1',
                                    THA = 'Copy Text 1';
                        Editable = EnaCopyText1;
                    }
                    field(CopyText2; CopyText[3])
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Copy Text 2',
                                    THA = 'Copy Text 2';
                        Editable = EnaCopyText2;
                    }
                    field(CopyText3; CopyText[4])
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Copy Text 3',
                                    THA = 'Copy Text 3';
                        Editable = EnaCopyText3;
                    }
                    field(CopyText4; CopyText[5])
                    {
                        ApplicationArea = all;
                        CaptionML = ENU = 'Copy Text 4',
                                    THA = 'Copy Text 4';
                        Editable = EnaCopyText4;
                    }
                    field(OptionHeaderTHA; OptionHeaderTHA)
                    {
                        ApplicationArea = all;
                        Caption = 'Option Header';
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnInit();
        begin
            EnaCopyText1 := false;
            EnaCopyText2 := false;
            EnaCopyText3 := false;
            EnaCopyText4 := false;
            EnableControl();
        end;

        trigger OnOpenPage();
        begin
            if CopyText[1] = '' then CopyText[1] := 'ต้นฉบับ / Original';
            if CopyText[2] = '' then CopyText[2] := 'สำเนา / Copy';
            //if CopyText[3] = '' then CopyText[3] := 'สำเนาบัญชี / Account Copy';
            NoOfCopies := 1;
            EnableControl();
        end;
    }

    trigger OnInitReport()
    begin
        NoOfCopies := 2;
    end;

    procedure EnableControl()
    begin
        IF NoOfCopies < 1 THEN BEGIN
            EnaCopyText1 := FALSE;
            EnaCopyText2 := FALSE;
            EnaCopyText3 := FALSE;
            EnaCopyText4 := FALSE;
        END;

        IF NoOfCopies >= 4 THEN BEGIN
            EnaCopyText1 := TRUE;
            EnaCopyText2 := TRUE;
            EnaCopyText3 := TRUE;
            EnaCopyText4 := TRUE;
        END
        ELSE
            IF NoOfCopies >= 3 THEN BEGIN
                EnaCopyText1 := TRUE;
                EnaCopyText2 := TRUE;
                EnaCopyText3 := TRUE;
                EnaCopyText4 := FALSE;
            END
            ELSE
                IF NoOfCopies >= 2 THEN BEGIN
                    EnaCopyText1 := TRUE;
                    EnaCopyText2 := TRUE;
                    EnaCopyText3 := FALSE;
                    EnaCopyText4 := FALSE;
                END
                ELSE
                    IF NoOfCopies >= 1 THEN BEGIN
                        EnaCopyText1 := TRUE;
                        EnaCopyText2 := FALSE;
                        EnaCopyText3 := FALSE;
                        EnaCopyText4 := FALSE;
                    END;

        //RequestOptionsPage.UPDATE;

    end;



    procedure GetHeaderText(pInt: Integer): Text[50]
    begin
        EXIT(CopyText[pInt])
    end;

    procedure TextHeader(Text11: option "ใบเพิ่มหนี้/ใบกำกับภาษี","ใบเพิ่มหนี้")
    begin
        //AVKSAFERRUM 16/10/2017
        IF Text11 = Text11::"ใบเพิ่มหนี้" THEN
            Text1 := Text1::"ใบเพิ่มหนี้"
        ELSE
            IF Text11 = Text11::"ใบเพิ่มหนี้/ใบกำกับภาษี" THEN
                Text1 := Text1::"ใบเพิ่มหนี้/ใบกำกับภาษี";
        //C-AVKSAFERRUM 16/10/2017
    end;




    var
        Language: Record Language;
        CompanyInfo: Record "Company Information";
        Customer: Record Customer;
        AVInvCNL: Record "Sales Cr.Memo Line";
        Salesperson: Record "Salesperson/Purchaser";
        refSalesInvHead: Record "Sales Invoice Header";
        SalesInvHead: Record "Sales Invoice Header";
        SalesInvL: Record "Sales Invoice Line";
        VatBusPos: Record "VAT Business Posting Group";
        SalesInvLine: Record "Sales Invoice Line";
        ValueEntry: Record "VAT Entry";
        ItemLedgerEntry: Record "Item Ledger Entry";
        OutputNo: Integer;
        NoOfLoops: Integer;
        NoOfCopies: Integer;
        CopyText: array[5] of Text;
        HeaderText: Text[50];
        TextComment: text[50];
        AppliedInv: text;
        AppliedInv1: text;
        POS: Integer;
        OldSaleInvoice: Code[20];
        AVNo: Code[20];
        DiscountTxt: text;
        InvAmount: Decimal;
        Qty: Decimal;
        UnitPrice: Decimal;
        LineAmount: Decimal;
        LineVAT: Decimal;
        PostingDate1: Date;
        EnaCopyText1: Boolean;
        EnaCopyText2: Boolean;
        EnaCopyText3: Boolean;
        EnaCopyText4: Boolean;
        Line: Integer;
        MaxLine: Integer;
        AddLine: Integer;
        InvAmt: Decimal;
        AllPages: Integer;
        AllLine: Integer;
        RunningNo: Integer;
        SubTotal: Decimal;
        OldDuc: Text;
        //Vatpersent: Integer;
        VATPersent: Text[10];
        RefInvDate: Text[100];
        RefInvAmt: Text[100];
        RefSalesperson: Text[100];
        InvIncAmt: Decimal;
        Text1: Option "ใบเพิ่มหนี้/ใบกำกับภาษี","ใบเพิ่มหนี้";
        Text2: Option "Debit Note/Tax Invoice","Debit Note";
        J: Integer;
        ItemNo: Code[20];
        Desc1: Text[50];
        Desc2: text[50];
        UOM: Code[10];
        RunNo: Integer;
        Quty: Decimal;
        UnitP: Decimal;
        Amt: Decimal;
        Disc: Decimal;
        SumLineAmt: Decimal;
        SumAmtIncl: Decimal;
        I: Integer;
        OldEntry: Integer;
        CurrEntry: Integer;
        AVSaleCommentL: Record "Sales Comment Line";
        SaleComLineTB: Record "Sales Comment Line";
        CommentTxt: array[5] of Text[250];
        CountComment: Integer;
        PaymentTermTB: Record "Payment Terms";
        ThaiCU: Codeunit AVF_Thai;
        PostDateText: Text[100];
        DueDateText: Text[100];
        RefInvDateText: Text[100];
        Showserial: Boolean;
        SerialText: array[5000] of Text[50];
        OptionHeaderTHA: Option "ใบเพิ่มหนี้","ใบเพิ่มหนี้/ใบกำกับภาษี";
        OptionHeaderEN: Option "Debit Note","Debit Note/Tax";
        CountPage: Integer;




}

