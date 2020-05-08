page 50103 "INT_WHT Line Sub Close EDIT"
{
    // version AVFTH1.0
    Caption = 'WHT Line Subform Close EDIT';
    AutoSplitKey = true;
    Editable = true;
    PageType = List;
    MultipleNewLines = true;
    LinksAllowed = false;
    SourceTable = "AVF_WHT Line";
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field("WHT Line No."; "WHT Line No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("WHT Prod. Posting Group"; "WHT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("WHT Revernue Type"; "WHT Revernue Type")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("WHT %"; "WHT %")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Detail PND1/PND2"; "Detail PND1/PND2")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Base; Base)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Auto Ref. Payment No."; "Auto Ref. Payment No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Ref. Invoice No."; "Ref. Invoice No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Remark; Remark)
                {
                    ApplicationArea = All;
                    Caption = '<Remark>';
                    Editable = false;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        CLEAR(WHT_Header);
        if WHT_Header.GET("WHT No.") then;
        "WHT Business Posting Group" := WHT_Header."WHT Business Posting Group";
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        CLEAR(WHT_Header);
        if WHT_Header.GET("WHT No.") then;
        "WHT Business Posting Group" := WHT_Header."WHT Business Posting Group";
    end;

    var
        WHT_Header: Record "AVF_WHT Header";
}
