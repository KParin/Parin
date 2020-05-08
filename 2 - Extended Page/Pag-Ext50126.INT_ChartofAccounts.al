pageextension 50126 "INT_Chart of Accounts" extends "Chart of Accounts"
{
    layout
    {
        moveafter("Cost Type No."; "FNGN002_Created by")
        modify("FNGL001_Name Other")
        {
            Visible = false;
        }
        moveafter("Income/Balance"; "Account Type")
        modify("Cost Type No.")
        {
            Visible = false;
        }
        modify("Default Deferral Template Code")
        {
            Visible = false;
        }
        moveafter("FNGN002_Created by"; "FNGN002_Created Date")
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        moveafter("Account Type"; Totaling)
        modify("AVF_Name 2")
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
        addafter(Totaling)
        {
            field("INT_Indentation"; Indentation)
            {
                ApplicationArea = all;
            }
        }
        addafter(Balance)
        {
            field("INT_Budgeted Amount"; "Budgeted Amount")
            {
                ApplicationArea = all;
            }
        }
    }
    actions
    {
    }
}
