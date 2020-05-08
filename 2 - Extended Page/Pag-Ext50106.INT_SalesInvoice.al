pageextension 50106 "INT_Sales Invoice" extends "Sales Invoice"
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
        modify("Sell-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Sell-to Contact No.")
        {
            Visible = false;
        }
        modify("Salesperson Code")
        {
            Visible = false;
        }
        modify("Campaign No.")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify(WorkDescription)
        {
            Visible = false;
        }
        addafter("External Document No.")
        {
            field("INT_Shortcut Dimension 1 Code40104"; "Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("INT_Shortcut Dimension 2 Code89186"; "Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;
            }
        }
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify(SelectedPayments)
        {
            Visible = false;
        }
        modify("EU 3-Party Trade")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Direct Debit Mandate ID")
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
        modify("Package Tracking No.")
        {
            Visible = false;
        }
        addafter(Status)
        {
            field("INT_Posting Description New"; "Posting Description")
            {
                Caption = 'Posting Description';
                Visible = true;
                Editable = true;
                ApplicationArea = All;
                ShowMandatory = true;
            }
        }
        addafter("AVF_Customer Branch No.")
        {
            field("INT_Posting No. Series"; "Posting No. Series")
            {
                ApplicationArea = All;
            }
        }
        /*
        addafter("AVF_Customer Branch No.")
        {
            field("INT_Posting No. Series"; "Posting No. Series")
            {
                ApplicationArea = All;
                Visible = true;
                Editable = true;
            }
        }
        */
        modify("Work Description")
        {
            Visible = false;
        }

        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                if "No." = 'SIO' then
                    "Posting No. Series" := 'AR1_IO';
                if "No." = 'SIT' then
                    "Posting No. Series" := 'AR1_IT';

            end;
        }
        modify("Assigned User ID")
        {
            Editable = false;
        }
        modify("Due Date")
        {
            trigger OnAfterValidate()
            begin
                if "Due Date" < "Posting Date" then
                    Error('Due Date must more than Posting Date');
            end;
        }
        modify("Sell-to Customer Name")
        {
            Visible = false;
        }
        addafter("Sell-to Customer Name")
        {
            field("INT_AV Edit Customer Name"; "INT_AV Edit Customer Name")
            {
                ApplicationArea = All;
            }
        }
        addafter("INT_AV Edit Customer Name")
        {
            field("INT_Sell-to Customer Name"; "Sell-to Customer Name")
            {
                Caption = 'Customer Name';
                ApplicationArea = All;
                Editable = false;
            }
            field("INT_Sell-to Customer Name 2"; "Sell-to Customer Name 2")
            {
                Caption = 'Customer Name 2';
                ApplicationArea = All;
                Editable = true;
            }
        }



    }
    actions
    {
        modify(PostAndSend)
        {
            Promoted = false;
        }
        modify(PostAndNew)
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
    }
}
