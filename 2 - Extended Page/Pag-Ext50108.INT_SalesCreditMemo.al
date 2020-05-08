pageextension 50108 "INT_Sales Credit Memo" extends "Sales Credit Memo"
{
    layout
    {
        modify("Sell-to City")
        {
            Visible = false;
        }
        modify("Sell-to Post Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Sell-to Country/Region Code")
        {
            Visible = false;
        }
        moveafter("Sell-to Contact"; "AVF_VAT Registration No.")
        moveafter("AVF_VAT Registration No."; "AVF_Customer Branch No.")
        modify("Campaign No.")
        {
            Visible = false;
        }
        moveafter("AVF_Customer Branch No."; "Document Date")
        moveafter("External Document No."; "Your Reference")
        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify(WorkDescription)
        {
            Visible = false;
        }
        addafter("Due Date")
        {
            field("INT_Posting Description"; "Posting Description")
            {
                ApplicationArea = All;
                ShowMandatory = true;
            }
        }
        modify("Document Date")
        {
            Importance = Standard;
        }
        modify("Sell-to Address")
        {
            Importance = Standard;
        }
        modify("Sell-to Address 2")
        {
            Importance = Standard;
        }
        modify("AVF_Sell-to Address 3")
        {
            Importance = Standard;
        }
        modify("Sell-to Customer No.")
        {
            Importance = Standard;
        }
        modify("Transaction Specification")
        {
            Visible = false;
        }
        modify("Transaction Type")
        {
            Visible = false;
        }
        modify("Transport Method")
        {
            Visible = false;
        }
        modify("Exit Point")
        {
            Visible = false;
        }
        modify("Area")
        {
            Visible = false;
        }
        modify("Bill-to City")
        {
            Visible = false;
        }
        modify("Bill-to Post Code")
        {
            Visible = false;
        }
        modify("Bill-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Payment Discount %")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Shipment Date")
        {
            Visible = false;
        }
        modify("Applies-to ID")
        {
            Visible = false;
        }
        addafter("Applies-to Doc. No.")
        {
            field("INT_Posting No. Series"; "Posting No. Series")
            {
                ApplicationArea = All;
                Visible = false;
                Editable = false;
            }
        }
        modify("Work Description")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Sell-to Contact No.")
        {
            Visible = false;
        }
        //moveafter("External Document No."; "Shortcut Dimension 1 Code")
        //moveafter("Shortcut Dimension 1 Code"; "Shortcut Dimension 2 Code")
        modify("Assigned User ID")
        {
            Editable = false;
        }
        addafter("Sell-to Customer Name")
        {
            field("INT_AV Edit Customer Name"; "INT_AV Edit Customer Name")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(PostAndSend)
        {
            Visible = false;
            Promoted = false;
        }
        modify("Request Approval")
        {
            Visible = false;
        }
    }
}
