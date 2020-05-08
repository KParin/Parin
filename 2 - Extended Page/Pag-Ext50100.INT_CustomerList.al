pageextension 50100 "INT_Customer List" extends "Customer List"
{
    layout
    {
        modify("Responsibility Center")
        {
            Visible = false;
        }
        modify("Location Code")
        {
            Visible = false;
        }
        modify("AVF_WHT Business Posting Group")
        {
            Visible = false;
        }
        addafter(Name)
        {
            field("INT_Address"; Address)
            {
                ApplicationArea = All;
            }
            field("INT_Address 2"; "Address 2")
            {
                ApplicationArea = All;
            }
        }


    }
    actions
    {
        modify(PaymentRegistration)
        {
            Promoted = false;
        }
        modify(NewReminder)
        {
            Promoted = false;
        }
        modify(ApprovalEntries)
        {
            Promoted = false;
        }
    }
}
