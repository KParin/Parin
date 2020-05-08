pageextension 50117 "INT_Fixed Asset List" extends "Fixed Asset List"
{
    Editable = true;
    layout
    {
        moveafter("FA Location Code"; "Responsible Employee")
        modify("Responsible Employee")
        {
            Visible = false;
        }
        addafter("FA Location Code")
        {
            field("INT_Global Dimension 1 Code"; "Global Dimension 1 Code")
            {
                ApplicationArea = all;
            }
        }
        modify("FA Subclass Code")
        {
            Visible = false;
        }

    }
    actions
    {
        modify(CalculateDepreciation)
        {
            Visible = false;
            Promoted = false;
        }
        addafter("Fixed Asset G/L Journal")
        {
            action("INT_CalculateDepreciation2")
            {
                Caption = 'Calculate Depreciation 2';
                RunObject = report "INT_Calculate Depreciation 2";
                Image = Report;
                Promoted = true;
                PromotedCategory = Process;
                //trigger OnAction()
                //begin

                //end;
            }
        }
    }
}
