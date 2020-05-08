pageextension 50148 "INT_Fixed Asset Journal" extends "Fixed Asset Journal"
{
    layout
    {
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Depr. until FA Posting Date")
        {
            Visible = false;
        }
        modify("Depr. Acquisition Cost")
        {
            Visible = false;
        }
        modify("Budgeted FA No.")
        {
            Visible = false;
        }
        modify("FA Reclassification Entry")
        {
            Visible = false;
        }
        modify("FA Error Entry No.")
        {
            Visible = false;
        }
    }

    actions
    {
        modify("Post and &Print")
        {
            Visible = false;
            Promoted = false;
        }

        modify(Post)
        {
            Promoted = false;
        }


    }


}