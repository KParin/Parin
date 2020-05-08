pageextension 50105 "INT_Sales Inv Subform" extends "Sales Invoice Subform"
{
    layout
    {
        modify("FNGN004_G/L_Temp")
        {
            Visible = false;
        }
        modify(Control1)
        {
            FreezeColumn = "No.";
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Line Discount %")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("AVF_Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("AVF_WHT Business Posting Group")
        {
            Visible = false;
        }
        modify("AVF_VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("AVF_Description 2")
        {
            Visible = false;
        }
        addafter("AVF_VAT Bus. Posting Group")
        {
            field("INT_Depreciation Book Code"; "Depreciation Book Code")
            {
                ApplicationArea = all;
            }
        }
        movebefore("Unit of Measure Code"; Quantity)
        moveafter("AVF_Description 2"; "AVF_Gen. Prod. Posting Group")
        moveafter("AVF_Gen. Prod. Posting Group"; "AVF_VAT Prod. Posting Group19752")
        moveafter("AVF_VAT Prod. Posting Group19752"; "AVF_WHT Product Posting Group")
        modify("No.")
        {
            trigger OnAfterValidate()
            var
                FADepreBookTB: Record "FA Depreciation Book";
            begin
                if Rec.Type = rec.Type::"Fixed Asset" then begin
                    Clear(FADepreBookTB);
                    FADepreBookTB.SetCurrentKey("FA No.");
                    FADepreBookTB.SetRange("FA No.", "No.");
                    if FADepreBookTB.FindFirst() then begin
                        Rec."Depreciation Book Code" := FADepreBookTB."Depreciation Book Code";

                        if FADepreBookTB."Disposal Date" <> 0D then
                            Error('Cannot select FA No. because already Disposted.');

                    end;

                    "Depr. until FA Posting Date" := true;
                    "AVF_WHT Product Posting Group" := 'NOWHT';
                end;
            end;
        }
        addlast(Control1)
        {
            field("INT_Depr. until FA Posting Date"; "Depr. until FA Posting Date")
            {
                Visible = true;
            }
        }
    }
    actions
    {
        addafter("&Line")
        {
            group("INT_DimensionsGroup")
            {
                Caption = 'Dimensions';
                action("INT_Dimensions")
                {
                    AccessByPermission = TableData Dimension = R;
                    ApplicationArea = Dimensions;
                    Caption = 'Dimensions';
                    Image = Dimensions;
                    Scope = Repeater;
                    ShortCutKey = 'Alt+D';
                    ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                    trigger OnAction()
                    begin
                        ShowDimensions;
                    end;
                }
            }
        }
    }
}
