pageextension 50151 "INT_Gen Led Entries" extends "General Ledger Entries"
{
    layout
    {
        addafter("Bal. Account No.")
        {
            field("INT_Global Dimension 1 Code"; "Global Dimension 1 Code")
            {
                Visible = true;
                Editable = false;
            }
            field("INT_Global Dimension 2 Code"; "Global Dimension 2 Code")
            {
                Visible = true;
                Editable = false;
            }
        }
        modify("Type of Payment")
        {
            Visible = false;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("Bal. Account Type")
        {
            Visible = false;
        }
        modify("Bal. Account No.")
        {
            Visible = false;
        }

        addafter(Description)
        {
            field("INT_Debit Amount"; "Debit Amount")
            {
                ApplicationArea = All;
            }
            field("INT_Credit Amount"; "Credit Amount")
            {
                ApplicationArea = All;
            }
        }
        addafter("G/L Account No.")
        {
            field("INT_G/L Account Name"; "G/L Account Name")
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