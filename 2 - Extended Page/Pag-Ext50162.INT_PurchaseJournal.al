pageextension 50162 "INT_PurchaseJournal" extends "Purchase Journal"
{
    layout
    {
        addbefore("Account No.")
        {
            field("INT_Account Type"; "Account Type")
            {
                ApplicationArea = All;
            }
        }
    }


}