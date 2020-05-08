pageextension 50027 "INT_RecTaxInvoice" extends "AVF_Receipt/Tax Invoice"
{
    layout
    {
        modify("Bill-to Customer No.")
        {
            trigger OnAfterValidate()
            begin
                "Bal. Account Type" := "Bal. Account Type"::"Bank Account";
                "Bal. Account No." := 'BBL-CA01';
            end;
        }
        modify("Bal. Account Type")
        {
            Visible = false;
        }
        modify("Bal. Account No.")
        {
            Visible = false;
        }
        modify("Bill-to Post Code")
        {
            Visible = false;
        }
        modify("Bank Fee")
        {
            Visible = false;
        }
        modify("<Bank Fee1>")
        {
            Visible = false;
        }
        modify("WHT Amount")
        {
            Visible = false;
        }
        modify("<WHT Amount1>")
        {
            Visible = false;
        }
        modify("Gen. Journal Template Name")
        {
            Visible = false;
        }
        modify("Batch Name")
        {
            Visible = false;
        }
        modify(ChqAmt)
        {
            Visible = false;
        }
        modify(NetAmt)
        {
            Visible = false;
        }

    }

    actions
    {
        addfirst(Reporting)
        {

            action("INT_Receipt / Tax invoice")
            {
                Caption = 'Receipt / Tax Invoice';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                Image = Report;
                trigger OnAction()
                begin

                    Clear(RecTaxInvoiceHeader);
                    RecTaxInvoiceHeader.SetCurrentKey("Receipt No.");
                    RecTaxInvoiceHeader.SetRange("Receipt No.", Rec."Receipt No.");
                    if RecTaxInvoiceHeader.FindFirst() then;
                    Report.RunModal(50043, TRUE, FALSE, RecTaxInvoiceHeader);
                end;

            }


            action("INT_Print Receipt")
            {
                Caption = 'Receipt';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Report;
                Image = Report;
                trigger OnAction()
                begin

                    Clear(RecTaxInvoiceHeader);
                    RecTaxInvoiceHeader.SetCurrentKey("Receipt No.");
                    RecTaxInvoiceHeader.SetRange("Receipt No.", Rec."Receipt No.");
                    if RecTaxInvoiceHeader.FindFirst() then;
                    Report.RunModal(50042, TRUE, FALSE, RecTaxInvoiceHeader);
                end;

            }


        }

        modify("&Print")
        {
            Visible = false;
        }

        /*
        modify("FNAR002_Post to Cash Receipt Journal")
        {
            Visible = false;
            Promoted = false;
        }
        */

    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if "Receipt No." <> '' then
            "VAT Bus. Posting Group" := 'HEADOFFICE';
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin

    end;

    var
        //SaleInvHeadTB: Record "Sales Invoice Header";
        //GLEntry: Record "G/L Entry";
        RecTaxInvoiceHeader: Record "AVF_Receipt/Tax Invoice Header";
}