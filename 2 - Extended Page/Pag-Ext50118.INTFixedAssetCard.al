pageextension 50118 "INT_Fixed Asset Card" extends "Fixed Asset Card"
{
    layout
    {
        addfirst(Control34)
        {
            field("INT_FA Posting Group"; "FA Posting Group")
            {
                ApplicationArea = All;
                trigger OnValidate()
                begin
                    "FA Subclass Code" := "FA Posting Group";
                    "FA Class Code" := "FA Posting Group";
                    Clear(FADepreBookTB);
                    FADepreBookTB.SetCurrentKey("FA No.");
                    FADepreBookTB.SetRange("FA No.", "No.");
                    if FADepreBookTB.FindSet() then begin
                        FADepreBookTB."FA Posting Group" := "FA Posting Group";
                        FADepreBookTB.Modify();
                    end;
                end;
            }
        }
        movefirst(Control34; "FNGN002_Old Code")
        modify(Inactive)
        {
            Visible = false;
        }
        modify(Acquired)
        {
            Visible = false;
        }
        modify("Main Asset/Component")
        {
            Visible = false;
        }
        modify("Component of Main Asset")
        {
            Visible = false;
        }
        modify("Search Description")
        {
            Visible = false;
        }
        modify("Vendor No.")
        {
            Visible = false;
        }
        modify("Maintenance Vendor No.")
        {
            Visible = false;
        }
        modify("Under Maintenance")
        {
            Visible = false;
        }
        modify("Next Service Date")
        {
            Visible = false;
        }
        modify("Warranty Date")
        {
            Visible = false;
        }
        modify(Insured)
        {
            Visible = false;
        }
        addafter("FA Location Code")
        {
            field("INT_Global Dimension 1 Code"; "Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
        }
        modify("Budgeted Asset")
        {
            Visible = false;
        }
        moveafter("FA Location Code"; "Serial No.")
        modify("FA Subclass Code")
        {
            Visible = false;
        }
        modify("Responsible Employee")
        {
            Visible = false;
        }
        modify("FA Class Code")
        {
            Visible = false;
        }
        modify(Maintenance)
        {
            Visible = false;
        }
    }
    actions
    {
        modify("Maintenance &Registration")
        {
            Promoted = false;
            Visible = false;
        }
        modify(Acquire)
        {
            Visible = false;
        }
        modify(Insurance)
        {
            Visible = false;
        }
        modify("Main Asset")
        {
            Visible = false;
        }
        modify("FA Book Value")
        {
            Promoted = true;
            PromotedCategory = Report;
            PromotedOnly = true;
        }
        modify("FA Book Val. - Appr. & Write-D")
        {
            Promoted = true;
            PromotedCategory = Report;
            PromotedOnly = true;
        }
        modify("G/L Analysis")
        {
            Promoted = true;
            PromotedCategory = Report;
            PromotedOnly = true;
        }
        modify(Register)
        {
            Promoted = true;
            PromotedCategory = Report;
            PromotedOnly = true;
        }
        modify(Details)
        {
            Promoted = true;
            PromotedCategory = Report;
            PromotedOnly = true;
        }
        modify(Analysis)
        {
            Promoted = true;
            PromotedCategory = Report;
            PromotedOnly = true;
        }
        modify("Projected Value")
        {
            Promoted = true;
            PromotedCategory = Report;
            PromotedOnly = true;
        }
        modify("Main&tenance Ledger Entries")
        {
            Visible = false;
        }
        modify("Error Ledger Entries")
        {
            Visible = false;
        }
        modify("FA Posting Types Overview")
        {
            Visible = false;
        }
    }

    trigger OnClosePage()
    begin
        TestField("Global Dimension 1 Code");
    end;

    var
        FADepreBookTB: Record "FA Depreciation Book";
}
