pageextension 50102 "INT_Customer Card" extends "Customer Card"
{
    layout
    {
        modify("IC Partner Code")
        {
            Visible = false;
        }
        modify("Credit Limit (LCY)")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Service Zone Code")
        {
            Visible = false;
        }
        modify("Document Sending Profile")
        {
            Visible = false;
        }
        modify(TotalSales2)
        {
            Visible = false;
        }
        modify("CustSalesLCY - CustProfit - AdjmtCostLCY")
        {
            Visible = false;
        }
        modify(AdjCustProfit)
        {
            Visible = false;
        }
        modify(AdjProfitPct)
        {
            Visible = false;
        }
        modify("Disable Search by Name")
        {
            Visible = false;
        }
        modify("Country/Region Code")
        {
            Visible = false;
        }
        modify(City)
        {
            Visible = false;
        }
        modify("Post Code")
        {
            Visible = false;
        }
        modify("Primary Contact No.")
        {
            Visible = false;
        }
        modify("Language Code")
        {
            Visible = false;
        }
        modify(GLN)
        {
            Visible = false;
        }
        modify("Copy Sell-to Addr. to Qte From")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Invoice Copies")
        {
            Visible = false;
        }
        modify("Customer Price Group")
        {
            Visible = false;
        }
        modify("Customer Disc. Group")
        {
            Visible = false;
        }
        modify("Allow Line Disc.")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        moveafter("FNGN002_Created Date"; "Last Date Modified")
        moveafter("Privacy Blocked"; "AVF_Customer Branch No.")
        moveafter("AVF_Customer Branch No."; "VAT Registration No.")
        modify("Prepayment %")
        {
            Visible = false;
        }
        modify("Application Method")
        {
            Visible = false;
        }
        modify("Cash Flow Payment Terms Code")
        {
            Visible = false;
        }
        modify("Last Statement No.")
        {
            Visible = false;
        }
        modify("Fin. Charge Terms Code")
        {
            Visible = false;
        }
        modify("Print Statements")
        {
            Visible = false;
        }
        modify("Reminder Terms Code")
        {
            Visible = false;
        }
        modify("Preferred Bank Account Code")
        {
            Visible = false;
        }
        modify("Block Payment Tolerance")
        {
            Visible = false;
        }
        modify("Partner Type")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify(Reserve)
        {
            Visible = false;
        }
        modify("Shipping Time")
        {
            Visible = false;
        }
        modify("Shipping Agent Code")
        {
            Visible = false;
        }
        modify("Shipping Agent Service Code")
        {
            Visible = false;
        }
        modify("Customized Calendar")
        {
            Visible = false;
        }
        modify("Base Calendar Code")
        {
            Visible = false;
        }
        modify("Shipping Advice")
        {
            Visible = false;
        }
        modify("Combine Shipments")
        {
            Visible = false;
        }
        modify("Ship-to Code")
        {
            Visible = false;
        }
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        addafter(Name)
        {
            field("INT_Name 2"; "Name 2")
            {
                Caption = 'Name 2';
                Visible = true;
                Editable = true;
            }
        }
        addafter("FNGN002_Created by")
        {
            field("INT_Remark"; INT_Remark)
            {
                ApplicationArea = all;
                Editable = true;
                Caption = 'Remark';
            }
        }
        addafter(Blocked)
        {
            field("INT_Block Comment"; "INT_Block Comment")
            {
                ApplicationArea = all;
                Editable = true;
                Caption = 'Block Comment';
            }
        }
        modify(Shipping)
        {
            Visible = false;
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }


    }
    actions
    {
        modify(NewSalesQuote)
        {
            Promoted = false;
        }
        modify(SendApprovalRequest)
        {
            Promoted = false;
        }
        modify(CancelApprovalRequest)
        {
            Promoted = false;
        }
        modify(SeeFlows)
        {
            Promoted = false;
        }
        modify(Quotes)
        {
            Promoted = false;
        }
        modify("Return Orders")
        {
            Promoted = false;
        }
        modify("Cross Re&ferences")
        {
            Promoted = false;
        }
        modify(ApprovalEntries)
        {
            Promoted = false;
        }
        modify(Workflow)
        {
            Visible = false;
        }
        modify("Request Approval")
        {
            Visible = false;
        }
        modify(Service)
        {
            Visible = false;
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        "AVF_WHT Business Posting Group" := 'CLIENT';
        "VAT Bus. Posting Group" := 'HEADOFFICE';
        if NoSeriesTB.Get("No. Series") then
            "Customer Posting Group" := NoSeriesTB."INT_Cust Posting Group";
    end;

    var
        NoSeriesTB: Record "No. Series";
}
