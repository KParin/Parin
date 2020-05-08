pageextension 50159 "INT_WHTOrderClose" extends "AVF_WHT Order (Close)"
{
    layout
    {
        modify("Applied to Document No.")
        {
            Editable = true;
        }
    }


    actions
    {
        modify("WHT Slip")
        {
            Visible = false;
        }


        /*
        addafter("WHT Slip")
        {
            action("INT_WHT Slip")
            {
                Caption = 'WHT Slip 2';
                trigger OnAction()
                begin
                    REPORT.RUN(REPORT::"INT_WHT Slip", TRUE, FALSE, rec)
                end;
            }
        }
        */



    }


}