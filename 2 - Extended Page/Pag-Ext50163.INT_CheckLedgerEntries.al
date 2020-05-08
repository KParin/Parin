pageextension 50163 "INT_Check Ledger Entries" extends "Check Ledger Entries"
{
    layout
    {
        addafter("Check Date")
        {
            field("INT_Document No."; "Document No.")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}