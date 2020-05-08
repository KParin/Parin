report 50006 "INT_Invoice/Tax"
{
    //แก้ไข Report 40014789 
    // version AVTHLC1.0

    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/InvoiceTax InvoiceReceipt1.rdl';
    Caption = 'Invoice/Tax Invoice';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Tax Invoice Header"; "Sales Invoice Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(MaxPage; MaxPage)
            {
            }
            column(CompanyInfo_Picture; CompanyInfo.Picture)
            {
            }
            column(CompanyInfo_NameEng; CompanyInfo.FNGN001_NameEng + ' ' + CompanyInfo."FNGN001_NameEng 2")
            {
            }
            column(CompanyInfo_Name; CompanyInfo.Name + ' ' + CompanyInfo."Name 2")
            {
            }
            column(CompanyInfo_Address; CompanyInfo.Address)
            {
            }
            column(CompanyInfo_Address2; CompanyInfo."Address 2")
            {
            }
            column(CompanyInfo_AddressEng; CompanyInfo.FNGN001_AddressEng)
            {
            }
            column(CompanyInfo_AddressEng2; CompanyInfo."FNGN001_AddressEng 2")
            {
            }
            column(CompanyInfo_PhoneNo; 'Tel: ' + CompanyInfo."Phone No." + '  Fax: ' + CompanyInfo."Fax No.")
            {
            }
            column(CompanyInfo_VATID; 'Tax No.:  ' + VATID)
            {
            }
            column(CompanyInfo_HomePage; CompanyInfo."Home Page")
            {
            }
            column(TextHeader_1; 'ใบแจ้งหนี้/ใบกำกับภาษี')
            {
            }
            column(TextHeader_2; 'Invoice/Tax Invoice')
            {
            }
            column(BilltoCustomerNo_TaxInvoiceHeader; "Tax Invoice Header"."Bill-to Customer No.")
            {
            }
            column(BilltoName_TaxInvoiceHeader; "Tax Invoice Header"."Bill-to Name")
            {
            }
            column(BilltoAddress_TaxInvoiceHeader; "Tax Invoice Header"."Sell-to Address")
            {
            }
            column(BilltoAddress2_TaxInvoiceHeader; "Tax Invoice Header"."Sell-to Address 2")
            {
            }
            column(BilltoAddress3_TaxInvoiceHeader; "Tax Invoice Header"."AVF_Sell-to Address 3")
            {
            }
            column(Customer_PhoneNo; Customer."Phone No.")
            {
            }
            column(Customer_FaxNo; Customer."Fax No.")
            {
            }
            column(Customer_VATRegistrationNo; "Tax Invoice Header"."VAT Registration No.")
            {
            }
            column(No_TaxInvoiceHeader; "Tax Invoice Header"."No.")
            {
            }
            column(Your_Reference; "Your Reference")
            {
            }
            column(Due_Date; FORMAT("Due Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(PostingDate_TaxInvoiceHeader; FORMAT("Tax Invoice Header"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Salesperson_Name; Salesperson.Name)
            {
            }
            column(PaymentTerm_Cose; PaymentTerms.Description)
            {
            }
            column(CustomerBranchNo_TaxInvoiceHeader; "Tax Invoice Header"."AVF_Customer Branch No.")
            {
            }
            column(Comments_1; Comments[1])
            {
            }
            column(Comments_2; Comments[2])
            {
            }
            column(Comments_3; Comments[3])
            {
            }
            column(Comments_4; Comments[4])
            {
            }
            column(Subtotal; format(Subtotal, 0, '<Sign><Integer Thousand><Decimals,3>'))
            {
            }
            column(TotalDiscount; format(TotalDiscount, 0, '<Sign><Integer Thousand><Decimals,3>'))
            {
            }
            column(AmountVat; format(AmountVat, 0, '<Sign><Integer Thousand><Decimals,3>'))
            {
            }
            column(NetTotal; format(NetTotal, 0, '<Sign><Integer Thousand><Decimals,3>'))
            {
            }
            column(NetAmount; format(NetAmount, 0, '<Sign><Integer Thousand><Decimals,3>'))
            {
            }

            column(AmtText; AmtText[1])
            {
            }
            column(VATPersent; VATPersent)
            {
            }
            column(Dexcrip_VatBusPos; VatBusPos."AVF_Branch No.")
            {
            }
            column(CurrencyTxt; CurrencyTxt)
            {
            }
            column(CurrencyRate; CurrencyRate)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(Number_CopyLoop; CopyLoop.Number)
                {
                }
                column(InvText; InvText)
                {
                }
                dataitem("Tax Invoice Line"; "Sales Invoice Line")
                {
                    DataItemLink = "Document No." = FIELD("No.");
                    DataItemLinkReference = "Tax Invoice Header";
                    DataItemTableView = SORTING("Document No.", "Line No.");
                    column(UnitofMeasure_TaxInvoiceLine; "Tax Invoice Line"."Unit of Measure")
                    {
                    }
                    column(Running; Running)
                    {
                    }
                    column(No_TaxInvoiceLine; "Tax Invoice Line"."No.")
                    {
                    }
                    column(Description_TaxInvoiceLine; "Tax Invoice Line".Description)
                    {
                    }
                    column(Description2_TaxInvoiceLine; "Tax Invoice Line"."Description 2")
                    {
                    }
                    column(Qty; Qty)
                    {
                    }
                    column(QtyText; QtyText)
                    {

                    }
                    column(UnitPrice; UnitPrice)
                    {
                    }
                    column(discountAmount; discountAmount)
                    {
                    }
                    column(AmountT; AmountT)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        if "No." <> '' then
                            Running += 1;
                        //AVKSAVIP 29/10/2019
                        RunLine += 1;
                        IF "Description 2" <> '' then
                            RunLine += 1;
                        //C-AVKSAVIP 29/10/2019
                        Subtotal := Subtotal + "Tax Invoice Line"."Line Amount";
                        TotalDiscount := TotalDiscount + "Tax Invoice Line"."Inv. Discount Amount";

                        if "Tax Invoice Line".Quantity <> 0 then begin
                            Qty := FORMAT("Tax Invoice Line".Quantity);
                            UnitPrice := FORMAT("Tax Invoice Line"."Unit Price", 0, '<Precision,2:2><Integer Thousand><Decimals>');
                            if "Tax Invoice Line"."Line Discount Amount" <> 0 then
                                discountAmount := FORMAT("Tax Invoice Line"."Line Discount Amount", 0, '<Precision,2:2><Integer Thousand><Decimals>');
                            AmountT := FORMAT("Tax Invoice Line"."Line Amount", 0, '<Precision,2:2><Integer Thousand><Decimals>');
                        end
                        else begin
                            Qty := '';
                            UnitPrice := '';
                            AmountT := '';
                        end;
                        AmountVat += ("Tax Invoice Line"."Amount Including VAT" - "Tax Invoice Line".Amount);
                        NetTotal := (Subtotal - TotalDiscount) + AmountVat;
                        NetAmount := (Subtotal - TotalDiscount);

                        CLEAR(AmtText);
                        AmtText[1] := THAI.ThaiAmountWords(ROUND(NetTotal, 0.01, '='));
                        //Clear(VATPersent);
                        if "Tax Invoice Line"."VAT %" <> 0 then
                            VATPersent := FORMAT("Tax Invoice Line"."VAT %", 0, '<Precision,0:0><Sign><Integer Thousand><Decimals>') + '%';
                        if "VAT Prod. Posting Group" = 'NOVAT' then
                            VATPersent := '';

                        //AVKSAVIP.001 30/10/2019
                        Clear(QtyText);
                        if Quantity mod 1 = 0 then
                            QtyText := Format(Quantity)
                        else
                            QtyText := Format(Quantity, 0, '<Precision,2:2><Sign><Integer Thousand><Decimals>');
                        IF QtyText = '0' then
                            QtyText := '';
                        //C-AVKSAVIP.001 30/10/2019
                    end;

                    trigger OnPreDataItem();
                    begin
                        Line := COUNT;
                    end;
                }
                dataitem(EmptyLine; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(Number_EmptyLine; EmptyLine.Number)
                    {
                    }

                    trigger OnPreDataItem();
                    begin
                        //if RunLine = CountLine then begin
                        if (RunLine mod MaxLine) = 0 then
                            SETRANGE(Number, 1, 0)
                        else begin
                            AddLine := MaxLine - (RunLine mod MaxLine);
                            SETRANGE(Number, 1, AddLine);
                        end;
                        //end
                        //else
                        //SETRANGE(Number, 1, 0);
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(Running);
                    CLEAR(Line);
                    CLEAR(InvText);
                    InvText := CopyText[Number];
                    CLEAR(Subtotal);
                    CLEAR(TotalDiscount);
                    CLEAR(AmountVat);
                    CLEAR(NetTotal);
                    Clear(NetAmount);
                    Clear(RunLine);
                end;

                trigger OnPreDataItem();
                begin
                    //NoOfLoops := ABS(NoOfCopies) + 1;
                    NoOfLoops := 3;
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR(Customer);
                CLEAR(Salesperson);
                CLEAR(Vatpersent);
                if "Tax Invoice Header"."Bill-to Customer No." <> '' then
                    Customer.GET("Tax Invoice Header"."Bill-to Customer No.")
                else
                    Customer.GET("Tax Invoice Header"."Sell-to Customer No.");

                if "Tax Invoice Header"."Salesperson Code" <> '' then
                    Salesperson.GET("Tax Invoice Header"."Salesperson Code");

                //AVKSAVIP 21/10/2019
                Clear(PaymentTerms);
                if PaymentTerms.Get("Tax Invoice Header"."Payment Terms Code") then;
                //C-AVKSAVIP 21/10/2019

                //AVKSAVIP 25/10/2019
                Clear(CountLine);
                clear(SalesInvLineCount);
                SalesInvLineCount.SetRange("Document No.", "Tax Invoice Header"."No.");
                IF SalesInvLineCount.FindSet then
                    repeat
                        CountLine += 1;
                        if SalesInvLineCount."Description 2" <> '' then
                            CountLine += 1;
                    until SalesInvLineCount.Next = 0;
                clear(MaxPage);
                MaxPage := Round(CountLine / MaxLine, 1, '>');

                IF "Tax Invoice Header"."Currency Code" <> '' then begin
                    CurrencyTxt := CopyStr("Tax Invoice Header"."Currency Code", 1, 3);
                    CurrencyRate := Round(1 / "Tax Invoice Header"."Currency Factor", 0.01, '=');
                end;
                //C-AVKSAVIP 25/10/2019

                //AVWCASTD.004 07.08.2012
                //Add comment
                CLEAR(Comments);
                CLEAR(SalesComment);
                SalesComment.SETCURRENTKEY(SalesComment."Document Type", SalesComment."No.");
                SalesComment.SETRANGE(SalesComment."No.", "No.");
                if SalesComment.FIND('-') then
                    repeat
                        i += 1;
                        if i <= 4 then
                            Comments[i] := SalesComment.Comment;
                    until (SalesComment.NEXT = 0);
                //E - AVWCASTD.004 07.08.2012

                //AVNOJ VIP3 050913
                CLEAR(VatBusPos);
                VatBusPos.SETCURRENTKEY(Code);
                VatBusPos.SETRANGE(VatBusPos.Code, "Tax Invoice Header"."VAT Bus. Posting Group");
                if VatBusPos.FIND('-') then;
                //END AVNOJ VIP3 050913
            end;

            trigger OnPostDataItem();
            begin
                //AVNCCSTD.003 29.06.2012
                //IF NOT CurrReport.PREVIEW THEN BEGIN
                //  DocPrinted.UpdateNoOfPrintedSales(2,"Tax Invoice Header");
                //END;
                //E-AVNCCSTD.003 20.06.2012
            end;

            trigger OnPreDataItem();
            begin
                CompanyInfo.GET;
                CompanyInfo.CALCFIELDS(Picture);

                VATID := CompanyInfo."VAT Registration No.";
                //         COPYSTR(CompanyInfo."VAT Registration No.",2,2) + ' ' +
                //         COPYSTR(CompanyInfo."VAT Registration No.",4,1) + ' ' +
                //         COPYSTR(CompanyInfo."VAT Registration No.",5,5) + ' ' +
                //         COPYSTR(CompanyInfo."VAT Registration No.",10,1);

                MaxLine := 15;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("สำเนาเอกสาร")
                {
                    Caption = 'สำเนาเอกสาร';
                    field(NoOfCopies; NoOfCopies)
                    {
                        ApplicationArea = all;
                        Caption = 'No. Of Copies';

                        trigger OnValidate();
                        begin
                            Enabled();
                        end;
                    }
                    field("CopyText[1]"; CopyText[1])
                    {
                        ApplicationArea = all;
                        Caption = 'Original Text';
                    }
                    field("CopyText[2]"; CopyText[2])
                    {
                        ApplicationArea = all;
                        Caption = 'Copy Text 1';
                        Editable = CopyTextEditable2;
                    }
                    field("CopyText[3]"; CopyText[3])
                    {
                        ApplicationArea = all;
                        Caption = 'Copy Text 2';
                        Editable = CopyTextEditable3;
                    }
                    field("CopyText[4]"; CopyText[4])
                    {
                        ApplicationArea = all;
                        Caption = 'Copy Text 3';
                        Editable = CopyTextEditable4;
                    }
                    field("CopyText[5]"; CopyText[5])
                    {
                        ApplicationArea = all;
                        Caption = 'Copy Text 4';
                        Editable = CopyTextEditable5;
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            NoOfCopies := 3;
            Enabled;
            if CopyText[1] = '' then CopyText[1] := 'ต้นฉบับ / Original';
            //if CopyText[2] = '' then CopyText[2] := 'สำเนาลูกค้า / Customer Copy';
            if CopyText[2] = '' then CopyText[2] := 'สำเนาบัญชี / Account Copy';
            if CopyText[3] = '' then CopyText[3] := 'สำเนา / Copy';
        end;
    }

    labels
    {
    }

    var
        Running: Integer;
        MaxLine: Integer;
        AddLine: Integer;
        CompanyInfo: Record "Company Information";
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        InvText: Text[500];
        CopyText: array[5] of Text[200];
        [InDataSet]
        CopyTextEditable2: Boolean;
        [InDataSet]
        CopyTextEditable3: Boolean;
        [InDataSet]
        CopyTextEditable4: Boolean;
        [InDataSet]
        CopyTextEditable5: Boolean;
        VATID: Text[30];
        Customer: Record Customer;
        Salesperson: Record "Salesperson/Purchaser";
        PaymentTerms: Record "Payment Terms";//AVKSAVIP 21/10/2019
        Subtotal: Decimal;
        TotalDiscount: Decimal;
        Qty: Text[30];
        UnitPrice: Text[30];
        AmountT: Text[30];
        discountAmount: Text[30];
        AmountVat: Decimal;
        AmtText: array[2] of Text[200];
        THAI: Codeunit AVF_Thai;
        Comments: array[5] of Text[100];
        SalesComment: Record "Sales Comment Line";
        i: Integer;
        NetTotal: Decimal;
        NetAmount: Decimal;
        //DocPrinted: Codeunit "Document-Printed";
        VatBusPos: Record "VAT Business Posting Group";
        Line: Integer;
        //VATPersent: Integer;
        VATPersent: Text[10];
        SalesInvLineCount: Record "Sales Invoice Line";
        CountLine: Integer;
        MaxPage: Integer;
        CurrencyTxt: Text;
        CurrencyRate: Decimal;
        QtyText: Text;
        RunLine: Integer;

    procedure Enabled();
    begin
        if NoOfCopies < 1 then begin
            CopyTextEditable2 := (false);
            CopyTextEditable3 := (false);
            CopyTextEditable4 := (false);
            CopyTextEditable5 := (false);
        end;

        if NoOfCopies >= 4 then begin
            CopyTextEditable2 := (true);
            CopyTextEditable3 := (true);
            CopyTextEditable4 := (true);
            CopyTextEditable5 := (true);
        end
        else
            if NoOfCopies >= 3 then begin
                CopyTextEditable2 := (true);
                CopyTextEditable3 := (true);
                CopyTextEditable4 := (true);
                CopyTextEditable5 := (false);
            end
            else
                if NoOfCopies >= 2 then begin
                    CopyTextEditable2 := (true);
                    CopyTextEditable3 := (true);
                    CopyTextEditable4 := (false);
                    CopyTextEditable5 := (false);
                end
                else
                    if NoOfCopies >= 1 then begin
                        CopyTextEditable2 := (true);
                        CopyTextEditable3 := (false);
                        CopyTextEditable4 := (false);
                        CopyTextEditable5 := (false);
                    end;
    end;
}

