report 50043 "INT_Receipt Tax Invoice"
{
    // version AVTHLC1.0

    DefaultLayout = RDLC;
    Caption = 'Receipt/Tax Invoice';
    RDLCLayout = 'Rdlc/ReceiptTax Invoice.rdl';
    PreviewMode = PrintLayout;

    dataset
    {
        dataitem("Receipt/Tax Invoice Header"; "AVF_Receipt/Tax Invoice Header")
        {
            DataItemTableView = SORTING("Receipt No.");
            RequestFilterFields = "Receipt No.";
            column(AuthorizePerson; AuthorizePerson)
            {

            }
            column(PIC_COMINFO; TCompany.Picture)
            {
            }
            column(TextCompany_name; TextCompany_name)
            {
            }
            column(TextCompany_add; TextCompany_add)
            {
            }
            column(TextCompany_add2; TextCompany_add2)
            {
            }
            column(TextCompany_phone; TextCompany_phone)
            {
            }
            column(VATID; VATID)
            {
            }
            column(Branch_COMINFO; TCompany.INT_Branch)
            {
            }
            column(NameEng_COMINFO; TCompany.FNGN001_NameEng)
            {
            }
            column(NameEng2_COMINFO; TCompany."FNGN001_NameEng 2")
            {
            }
            column(AddressEng_COMINFO; TCompany.FNGN001_AddressEng)
            {
            }
            column(AddressEng2_COMINFO; TCompany."FNGN001_AddressEng 2")
            {
            }
            column(Receipt_BillToCusNo; "Receipt/Tax Invoice Header"."Bill-to Customer No.")
            {
            }
            column(Receipt_BillToCusName; "Receipt/Tax Invoice Header"."Bill-to Customer Name")
            {
            }
            column(Receipt_BillToCusAddress1; "Receipt/Tax Invoice Header"."Bill-to Address")
            {
            }
            column(Receipt_BillToCusAddress2; "Receipt/Tax Invoice Header"."Bill-to Address 2" + ' ' + "Receipt/Tax Invoice Header"."Bill-to Address 3")
            {
            }
            column(Receipt_No; "Receipt/Tax Invoice Header"."Receipt No.")
            {
            }
            column(Receipt_Date; FORMAT("Receipt/Tax Invoice Header"."Receipt Date", 0, '<Closing><Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(VatPer; VatPer)
            {
            }
            column(Allpage; Allpage)
            {
            }
            column(RunPage; RunPage)
            {
            }
            column(VatRegisNo_ReceiptH; "Receipt/Tax Invoice Header"."VAT Registration No.")
            {
            }
            column(CustomerBranchNo_ReceiptH; "Receipt/Tax Invoice Header"."Customer Branch No.")
            {
            }
            column(Receipt_Remark; "Receipt/Tax Invoice Header".Remark)
            {
            }
            column(PhoneNo_Customer; "Customer TB"."Phone No.")
            {
            }
            column(FaxNo_Customer; "Customer TB"."Fax No.")
            {
            }
            column(EMail_Customer; "Customer TB"."E-Mail")
            {
            }
            column(Contact_Customer; "Customer TB".Contact)
            {
            }
            column(AMT; AMT)
            {
            }
            column(VATAmt; VATAmt)
            {
            }
            column(TotalAmt; TotalAmt)
            {
            }
            column(Amount_Excl_VAT; "Amount Excl. VAT")
            {
            }
            column(VAT; VAT)
            {
            }
            column(Amount; Amount)
            {
            }
            dataitem(CopyLoop; "Integer")
            {
                DataItemTableView = SORTING(Number);
                column(Number_CopyLoop; CopyLoop.Number)
                {
                }
                dataitem("Receipt/Tax Invoice Line"; "AVF_Receipt/Tax Invoice Line")
                {
                    DataItemLinkReference = "Receipt/Tax Invoice Header";
                    DataItemLink = "Receipt No." = FIELD("Receipt No.");
                    DataItemTableView = SORTING("Receipt No.", "Line No.");
                    column(Running; Running)
                    {
                    }
                    column(Receipt_DocNo; 'ได้รับเงินตามใบแจ้งหนี้เลขที่  ' + "Receipt/Tax Invoice Line"."Document No.")
                    {
                    }
                    column(InvDate; FORMAT(InvDate, 0, 1))
                    {
                    }
                    column(DueDate; FORMAT(DUEDATE, 0, 1))
                    {
                    }
                    column(RemainAMT; RemainAMT)
                    {
                    }
                    column(Remain_Minus_Amt; "Cust. Ledger Entry TB"."Remaining Amt. (LCY)" - Amount)
                    {
                    }
                    column(Receipt_Amount; "Receipt/Tax Invoice Line".Amount)
                    {
                    }
                    column(Receipt_Vat; "Receipt/Tax Invoice Line"."VAT Amount")
                    {
                    }
                    column(AmountExcluedVAT_ReceiptTaxInvoiceLine; "Receipt/Tax Invoice Line"."Amount Exclued. VAT")
                    {
                    }
                    column(TCash; TCash)
                    {
                    }
                    column(TCheque; TCheque)
                    {
                    }
                    column(TTransfer; TTransfer)
                    {
                    }
                    column(Receipt_CheckBank; "Receipt/Tax Invoice Header"."Check Bank")
                    {
                    }
                    column(Receipt_CheckBranch; "Receipt/Tax Invoice Header"."Check Branch")
                    {
                    }
                    column(Receipt_CheckNo; "Receipt/Tax Invoice Header"."Check No.")
                    {
                    }
                    column(Receipt_CheckDate; FORMAT("Receipt/Tax Invoice Header"."Check Date", 0, 1))
                    {
                    }
                    column(MaxPage; MaxPage)
                    {
                    }
                    dataitem("Sales Invoice Line"; "Sales Invoice Line")
                    {
                        DataItemLinkReference = "Receipt/Tax Invoice Line";
                        DataItemLink = "Document No." = FIELD("Document No.");
                        //column(DescInv; "Sales Invoice Line".Description + ' ' + "Sales Invoice Line"."Description 2")
                        column(DescInv; DescInv)
                        {
                        }
                        column(AmtInv; AmtInv)
                        {
                        }

                        column(ShowLineInv; ShowLineInv)
                        {
                        }
                        column(NoInv; "No.")
                        {

                        }
                        column(QuantityInv; Quantity)
                        {

                        }
                        column(UOMInv; "Unit of Measure Code")
                        {

                        }
                        column(UnitPriceInv; "Unit Price")
                        {

                        }

                        trigger OnAfterGetRecord();
                        begin
                            Clear(SaleInvHeadTB);
                            SaleInvHeadTB.SetCurrentKey("No.");
                            SaleInvHeadTB.SetRange("No.", "Sales Invoice Line"."Document No.");
                            if SaleInvHeadTB.FindFirst() then
                                SaleInvHeadTB.CalcFields(Amount);

                            Clear(DescInv);
                            Clear(AmtInv);
                            Clear(ShowLineInv);
                            if SaleInvHeadTB.Amount <> 0 then begin
                                AmtInv := ("Sales Invoice Line".Amount * "Receipt/Tax Invoice Line"."Amount Exclued. VAT") / SaleInvHeadTB.Amount;
                                VATAmt += (AmtInv * "Sales Invoice Line"."VAT %") / 100;
                                TotalAmt += AmtInv + ((AmtInv * "Sales Invoice Line"."VAT %") / 100);
                            end else
                                AmtInv := 0;

                            DescInv := "Sales Invoice Line".Description;
                            ShowLineInv := true;
                            //CountLine += 1;
                            AMT += AmtInv;
                        end;
                    }
                    dataitem("Sales Cr.Memo Line"; "Sales Cr.Memo Line")
                    {
                        DataItemLinkReference = "Receipt/Tax Invoice Line";
                        DataItemLink = "Document No." = FIELD("Document No.");
                        //column(DescCr; "Sales Cr.Memo Line".Description + ' ' + "Sales Cr.Memo Line"."Description 2")
                        column(DescCr; DescCr)
                        {
                        }
                        column(AmtCr; AmtCr)
                        {
                        }
                        column(ShowLineCr; ShowLineCr)
                        {
                        }
                        column(NoCr; "No.")
                        {

                        }
                        column(QuantityCr; Quantity)
                        {

                        }
                        column(UOMCr; "Unit of Measure Code")
                        {

                        }
                        column(UnitPriceCr; "Unit Price")
                        {

                        }

                        trigger OnAfterGetRecord();
                        begin
                            Clear(saleCrHeadTB);
                            saleCrHeadTB.SetCurrentKey("No.");
                            saleCrHeadTB.SetRange("No.", "Sales Cr.Memo Line"."Document No.");
                            if saleCrHeadTB.FindFirst() then;
                            saleCrHeadTB.CalcFields(Amount);

                            Clear(DescCr);
                            Clear(AmtCr);
                            Clear(ShowLineCr);
                            if saleCrHeadTB.Amount <> 0 then begin
                                AmtCr := ("Sales Cr.Memo Line".Amount * "Receipt/Tax Invoice Line"."Amount Exclued. VAT") / saleCrHeadTB.Amount;
                                VATAmt += (AmtCr * "Sales Cr.Memo Line"."VAT %") / 100;
                                TotalAmt += AmtCr + ((AmtCr * "Sales Cr.Memo Line"."VAT %") / 100);
                            end else
                                AmtCr := 0;

                            DescCr := "Sales Cr.Memo Line".Description;
                            ShowLineCr := true;
                            //CountLine += 1;
                            AMT += AmtCr;
                        end;
                    }

                    trigger OnAfterGetRecord();
                    begin
                        Running += 1;
                        CountLine := COUNT;
                        CLEAR(ReceiptInvLine);
                        ReceiptInvLine.SETCURRENTKEY(ReceiptInvLine."Receipt No.");
                        ReceiptInvLine.SETRANGE(ReceiptInvLine."Receipt No.", "Receipt No.");
                        if ReceiptInvLine.FindSet() then begin
                            repeat
                                Clear(SaleInvLineTB);
                                SaleInvLineTB.SetCurrentKey("Document No.");
                                SaleInvLineTB.SetRange("Document No.", ReceiptInvLine."Document No.");
                                if SaleInvLineTB.FINDFIRST then begin
                                    CountLine += SaleInvLineTB.COUNT;
                                end;

                                Clear(SaleCrLineTB);
                                SaleCrLineTB.SetCurrentKey("Document No.");
                                SaleCrLineTB.SetRange("Document No.", ReceiptInvLine."Document No.");
                                if SaleCrLineTB.FINDFIRST then begin
                                    CountLine += SaleCrLineTB.COUNT;
                                end;
                            until ReceiptInvLine.Next() = 0;
                        end;

                        Clear(DescInv);
                        Clear(AmtInv);
                        Clear(DescCr);
                        Clear(AmtCr);
                        Clear(ShowLineInv);
                        Clear(ShowLineCr);


                        //AVPPF.001 16/09/2013
                        if (Running mod MaxLine) = 1 then
                            RunPage += 1;
                        //C-AVPPF.001 16/09/2013


                        if Type = Type::Invoice then begin
                            CLEAR(InvHead);
                            InvHead.SETFILTER(InvHead."No.", "Document No.");
                            InvHead.NEXT;
                            InvDate := InvHead."Posting Date";
                            DocNo := InvHead."No.";
                            DUEDATE := InvHead."Due Date";

                        end
                        else
                            if Type = Type::"Credit Memo" then begin
                                CLEAR(CrHead);
                                CrHead.SETFILTER(CrHead."No.", "Document No.");
                                CrHead.NEXT;
                                InvDate := CrHead."Posting Date";
                                DocNo := CrHead."No.";
                                DUEDATE := CrHead."Due Date";
                            end;

                        /*
                        CLEAR("Cust. Ledger Entry TB");
                        CASE Type OF
                        Type::Invoice :
                            "Cust. Ledger Entry TB".SETRANGE("Document Type","Cust. Ledger Entry TB"."Document Type"::Invoice);
                        Type::"Credit Memo" :
                            "Cust. Ledger Entry TB".SETRANGE("Document Type","Cust. Ledger Entry TB"."Document Type"::"Credit Memo");
                        END;
                        
                        "Cust. Ledger Entry TB".SETRANGE("Document No.","Document No.");
                        IF "Cust. Ledger Entry TB".FIND('-') THEN
                        BEGIN
                            "Cust. Ledger Entry TB".CALCFIELDS("Original Amt. (LCY)","Remaining Amt. (LCY)");
                            CLEAR(RemainAMT);
                            RemainAMT := "Cust. Ledger Entry TB"."Remaining Amt. (LCY)";
                        END;
                        
                        
                        CLEAR(ReAMT);
                        ReAMT := ("Cust. Ledger Entry TB"."Remaining Amt. (LCY)" - Amount);
                        */

                        //AMT := AMT + "Receipt/Tax Invoice Line"."Amount Exclued. VAT"; //AVWNFVIP.001 281019

                        if "Receipt/Tax Invoice Line"."VAT %" <> 0 then VatPer := "Receipt/Tax Invoice Line"."VAT %";


                        CLEAR(TCash);
                        CLEAR(TCheque);

                        if "Receipt/Tax Invoice Header".Cash then
                            TCash := 'X';

                        if "Receipt/Tax Invoice Header".Check then
                            TCheque := 'X';

                        if "Receipt/Tax Invoice Header".Transfer then
                            TTransfer := 'X';

                    end;

                    trigger OnPostDataItem();
                    begin
                        CLEAR(AddLine);
                    end;

                    trigger OnPreDataItem();
                    begin
                        //AVPPF.001 16/09/2013
                        Allpage := ROUND(COUNT / MaxLine, 1, '>');
                        //C-AVPPF.001 16/09/2013
                        CLEAR(VatPer);
                    end;
                }
                dataitem("Empty Line"; "Integer")
                {
                    DataItemTableView = SORTING(Number);
                    column(addline; AddLine)
                    {
                    }

                    column(Number; Number)
                    {
                    }

                    trigger OnPreDataItem();
                    begin
                        /*if (Running = CountLine) and (Running <> MaxLine) then begin
                            AddLine := MaxLine - (CountLine mod MaxLine);
                            SETRANGE(Number, 1, AddLine);
                        end
                        else
                            SETRANGE(Number, 1, 0);*/

                        IF (CountLine MOD MaxLine) = 0 THEN
                            SETRANGE(Number, 1, 0)
                        ELSE BEGIN
                            AddLine := MaxLine - (CountLine MOD MaxLine);
                            SETRANGE(Number, 1, AddLine);
                        END;
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(Running);
                    CLEAR(AMT);
                    CLEAR(RunPage);
                    Clear(CountLine);
                    Clear(VATAmt);
                    Clear(TotalAmt);
                end;

                trigger OnPreDataItem();
                begin
                    NoOfLoops := ABS(NoOfCopies) + 1;
                    SETRANGE(Number, 1, NoOfLoops);
                end;
            }

            trigger OnAfterGetRecord();
            begin
                CLEAR("Customer TB");
                "Customer TB".GET("Bill-to Customer No.");

                if "Receipt/Tax Invoice Header".Cash then
                    RECEIPT[1] := 'x';

                if "Receipt/Tax Invoice Header".Transfer then
                    RECEIPT[2] := 'x';

                if "Receipt/Tax Invoice Header".Check then
                    RECEIPT[3] := 'x';

                CLEAR(VatBusPostingGroup);
                VatBusPostingGroup.SETRANGE(Code, "VAT Bus. Posting Group");
                if VatBusPostingGroup.FIND('-') then;

                VATID := 'Tax No.: ' +
                         TCompany."VAT Registration No." + ' ' + VatBusPostingGroup."AVF_Branch No.";

                Clear(CountLineRec);
                Clear(SaleInvLineTB);
                Clear(SaleCrLineTB);
                CLEAR(ReceiptInvLine);
                ReceiptInvLine.SETCURRENTKEY(ReceiptInvLine."Receipt No.");
                ReceiptInvLine.SETRANGE(ReceiptInvLine."Receipt No.", "Receipt No.");
                if ReceiptInvLine.FINDFIRST then begin
                    CountLineRec := ReceiptInvLine.COUNT;

                    Clear(SaleInvLineTB);
                    SaleInvLineTB.SetCurrentKey("Document No.");
                    SaleInvLineTB.SetRange("Document No.", ReceiptInvLine."Document No.");
                    if SaleInvLineTB.FINDFIRST then begin
                        CountLineRec += SaleInvLineTB.COUNT;
                    end;

                    Clear(SaleCrLineTB);
                    SaleCrLineTB.SetCurrentKey("Document No.");
                    SaleCrLineTB.SetRange("Document No.", ReceiptInvLine."Document No.");
                    if SaleCrLineTB.FINDFIRST then begin
                        CountLineRec += SaleCrLineTB.COUNT;
                    end;
                end;

                Clear(MaxPage);
                MaxPage := Round(CountLineRec / MaxLine, 1, '>');

                //if NoOfCopies = 1 then
                //    FooterWord := 'Customer';

                CLEAR(Running);
                CLEAR(AMT);
                CLEAR(RunPage);
                Clear(CountLine);
                Clear(VATAmt);
                Clear(TotalAmt);
            end;

            trigger OnPostDataItem();
            begin
                //AVNCCSTD.002 20.06.2012
                //IF NOT CurrReport.PREVIEW THEN BEGIN
                //  DocPrinted.UpdateNoOfPrintedReciept(1,"Receipt/Tax Invoice Header");
                //END;
                //E-AVNCCSTD.002 20.06.2012
            end;

            trigger OnPreDataItem();
            begin

                TCompany.GET;
                TextCompany_name := TCompany.Name + ' ' + TCompany."Name 2";
                TextCompany_add := TCompany.Address;
                TextCompany_add2 := TCompany."Address 2";
                //TextCompany_add2 := TCompany."Address 2" + ' ' + TCompany.City + ' ' +
                //TCompany."Country/Region Code" + ' ' + TCompany."Post Code";
                TextCompany_phone := 'Tel: ' + TCompany."Phone No." + ' Fax: ' + TCompany."Fax No.";
                TCompany.CALCFIELDS(Picture);
                //VATID := 'เลขประจำตัวผู้เสียภาษี : '+
                //TCompany."VAT Registration No.";
                //COPYSTR(TCompany."VAT Registration No.",1,1) + ' ' +
                //COPYSTR(TCompany."VAT Registration No.",2,2) + ' ' +
                //COPYSTR(TCompany."VAT Registration No.",4,1) + ' ' +
                //COPYSTR(TCompany."VAT Registration No.",5,5) + ' ' +
                //COPYSTR(TCompany."VAT Registration No.",10,1);

                CLEAR(MaxLine);
                MaxLine := 19;
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
                    field(AuthorizePerson; AuthorizePerson)
                    {
                        Caption = 'Authorize Person';
                        ApplicationArea = All;
                    }
                }
                group("สำเนาเอกสาร")
                {

                    field("No. Of Copies"; NoOfCopies)
                    {
                        ApplicationArea = All;
                        Caption = 'No. Of Copies';

                        trigger OnValidate();
                        begin
                            Enabled();
                        end;
                    }
                    field("CopyText[1]"; CopyText[1])
                    {
                        ApplicationArea = All;
                        Caption = 'Original Text';
                    }
                    field("CopyText[2]"; CopyText[2])
                    {
                        ApplicationArea = All;
                        Caption = 'Copy Text 1';
                        Editable = CopyTextEditable2;
                    }
                    field("CopyText[3]"; CopyText[3])
                    {
                        ApplicationArea = All;
                        Caption = 'Copy Text 2';
                        Editable = CopyTextEditable3;
                    }
                    field("CopyText[4]"; CopyText[4])
                    {
                        ApplicationArea = All;
                        Caption = 'Copy Text 3';
                        Editable = CopyTextEditable4;
                    }
                    field("CopyText[5]"; CopyText[5])
                    {
                        ApplicationArea = All;
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
            NoOfCopies := 2;
            Enabled;
            if CopyText[1] = '' then CopyText[1] := 'ต้นฉบับ / Original';
            if CopyText[2] = '' then CopyText[2] := 'สำเนาลูกค้า / Customer Copy';
            if CopyText[3] = '' then CopyText[3] := 'สำเนาบัญชี / Account Copy';
            if CopyText[4] = '' then CopyText[4] := 'สำเนาคลัง / Stock Copy';
        end;
    }

    labels
    {
    }

    var
        ThaiBath: Text[250];
        ConvertNumberToString: Report Check;
        InvHead: Record "Sales Invoice Header";
        CrHead: Record "Sales Cr.Memo Header";
        "Cust. Ledger Entry TB": Record "Cust. Ledger Entry";
        TCompany: Record "Company Information";
        "Customer TB": Record Customer;
        AVReceiptL: Record "AVF_Receipt/Tax Invoice Line";
        AVReceiptH: Record "AVF_Receipt/Tax Invoice Header";
        RECEIPT: array[3] of Text[1];
        VATID: Text[250];
        CHECKDAY: Text[2];
        CHECKMONTH: Text[2];
        CHECKYEAR: Text[4];
        AmtWord: array[2] of Text[1024];
        TCash: Text[1];
        TCheque: Text[1];
        TTransfer: Text[1];
        OldReceiptOrder: Code[20];
        OldReceiptOrder1: Code[20];
        DocNo: Code[20];
        CountLine: Integer;
        Line1: Integer;
        AddLine: Integer;
        ALLPAGES: Integer;
        MaxLine: Integer;
        Running: Integer;
        ReAMT: Decimal;
        AMT: Decimal;
        VATAmt: Decimal;
        TotalAmt: Decimal;
        RemainAMT: Decimal;
        AVVAT: Decimal;
        RecVat: Decimal;
        InvDate: Date;
        DUEDATE: Date;
        AuthorizePerson: Text[100];
        ApprovePerson: Text[100];
        TextCompany_name: Text[1024];
        TextCompany_add: Text[1024];
        TextCompany_phone: Text[1024];
        //DocPrinted: Codeunit "Document-Printed";
        RunPage: Integer;
        Allpage: Integer;
        TextCompany_add2: Text[250];
        VatPer: Decimal;
        VatBusPostingGroup: Record "VAT Business Posting Group";
        SaleInvHeadTB: Record "Sales Invoice Header";
        saleCrHeadTB: Record "Sales Cr.Memo Header";

        DescInv: Text[150];
        DescCr: Text[150];
        AmtInv: Decimal;
        AmtCr: Decimal;
        ShowLineInv: Boolean;
        ShowLineCr: Boolean;
        NoOfCopies: Integer;
        NoOfLoops: Integer;
        MaxPage: Decimal;
        CountLineRec: Integer;
        CopyText: array[5] of Text[200];
        CopyTextEditable2: Boolean;
        CopyTextEditable3: Boolean;
        CopyTextEditable4: Boolean;
        CopyTextEditable5: Boolean;

        ReceiptInvLine: Record "AVF_Receipt/Tax Invoice Line";
        SaleInvLineTB: Record "Sales Invoice Line";
        SaleCrLineTB: Record "Sales Cr.Memo Line";
        FooterWord: text[50];

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

