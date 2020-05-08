pageextension 50136 "INT_FA GL Journal" extends "Fixed Asset G/L Journal"
{
    layout
    {
        modify("Document Type")
        {
            Visible = false;
        }
        modify("Bal. Account No.")
        {
            Visible = false;
        }
        modify("Bal. Account Type")
        {
            Visible = false;
        }
        modify("Bal. Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Bal. Gen. Prod. Posting Group")
        {
            Visible = false;
        }
        modify("FA Error Entry No.")
        {
            Visible = false;
        }
        movebefore(ShortcutDimCode3; ShortcutDimCode5)
        modify(ShortcutDimCode4)
        {
            Visible = false;
        }
        /*
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        */
        modify("Bal. Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        moveafter(Description; Amount)
        addafter(Description)
        {
            field("INT_Debit Amount"; "Debit Amount")
            {
                ApplicationArea = All;
                Width = 12;
            }
            field("INT_Credit Amount"; "Credit Amount")
            {
                ApplicationArea = All;
                Width = 11;
            }
        }

        modify("Depr. Acquisition Cost")
        {
            Visible = false;
        }
        modify("FA Reclassification Entry")
        {
            Visible = false;
        }
        modify("Budgeted FA No.")
        {
            Visible = false;
        }
        addafter("Gen. Prod. Posting Group")
        {
            field("INT_VAT Bus. Posting Group"; "VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                Width = 12;
            }
            field("INT_VAT Prod. Posting Group"; "VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                Width = 12;
            }
            field("INT_VAT Amount"; "VAT Amount")
            {
                ApplicationArea = All;
                Width = 14;
            }
        }
        modify("Depr. until FA Posting Date")
        {
            Width = 9;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Width = 10;
        }
        modify(ShortcutDimCode3)
        {
            Width = 10;
        }
        modify("Gen. Posting Type")
        {
            Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
            Visible = true;
        }
        modify("Gen. Prod. Posting Group")
        {
            Visible = true;
        }
        modify("VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("VAT Prod. Posting Group")
        {
            Visible = false;
        }
        modify("VAT Amount")
        {
            Visible = false;
        }
        addafter("Depreciation Book Code")
        {
            field("INT_Duplicate in Depreciation Book"; "Duplicate in Depreciation Book")
            {
                ApplicationArea = All;
            }
        }
        /*
        modify("Document No.")
        {
            trigger OnBeforeValidate()
            begin
                if "Journal Template Name" = 'ASSETS' then begin
                    if "Document No." = 'BF-FA-ACQ' then begin
                        DefaultShortcutDimCode5 := '010';
                        ValidateShortcutDimCode(5, DefaultShortcutDimCode5);
                    end;
                    if "Document No." = 'BF-FA-DEP' then begin
                        DefaultShortcutDimCode5 := '060';
                        ValidateShortcutDimCode(5, DefaultShortcutDimCode5);
                    end;
                end;
            end;
        }
        */
    }
    actions
    {
        modify("Post and &Print")
        {
            Promoted = false;
            Visible = false;
        }
        modify("Apply Entries")
        {
            Promoted = false;
        }
        modify("Insert FA &Bal. Account")
        {
            Promoted = false;
        }
        modify("F&unctions")
        {
            Visible = false;
        }
        modify("Test Report")
        {
            Visible = false;
        }
        modify(Reconcile)
        {
            Visible = false;
        }
        modify("&Line")
        {
            Visible = false;
        }
        modify("P&ost")
        {
            Promoted = false;
            //AVWNFINT.001 17/12/2019
            //Add code for run report after post
            trigger OnBeforeAction()
            begin
                CLEAR(AVDoc);
                AVDoc := "Document No.";
                //Message('1 : ' + Format(AVDoc));
            end;

            trigger OnAfterAction()
            begin
                //Message('2 : ' + Format(AVDoc));
                JournalBatchNameForReport := GETRANGEMAX("Journal Batch Name");
                CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                CurrPage.UPDATE(FALSE);

                IF CurrentJnlBatchName <> AVDoc THEN BEGIN
                    CLEAR(recGLEntry);
                    recGLEntry.SETRANGE("Journal Batch Name", JournalBatchNameForReport);
                    recGLEntry.SetRange("Document No.", AVDoc);
                    if recGLEntry.FindFirst() then
                        REPORT.RUN(REPORT::"INT_Journals Report", TRUE, FALSE, recGLEntry)
                END;
            end;
            //C-AVWNFINT.001 29/11/2019
        }

        addbefore("P&ost")
        {
            action("INT_Preview")
            {
                ApplicationArea = FixedAssets;
                Caption = 'Preview Posting';
                Image = ViewPostedOrder;
                ToolTip = 'Review the different types of entries that will be created when you post the document or journal.';

                trigger OnAction()
                var
                    GenJnlPost: Codeunit "Gen. Jnl.-Post";
                begin
                    GenJnlPost.Preview(Rec);
                end;
            }
        }
        modify(Preview)
        {
            Visible = false;
        }

        addafter(Dimensions)
        {
            action("INT_ValidateDimTransactionType")
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedCategory = Process;
                Caption = 'Validate Transaction Type';
                Image = UpdateDescription;

                trigger OnAction()
                begin
                    /*
                    if "Account Type" = "Account Type"::"Fixed Asset" then begin
                        if "FA Posting Type" = "FA Posting Type"::Depreciation then begin
                            DefaultShortcutDimCode5 := '060';
                            ValidateShortcutDimCode(5, DefaultShortcutDimCode5);
                        end;
                    end;
                    */

                    JournalBatchNameForReport := GETRANGEMAX("Journal Batch Name");
                    CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");

                    Clear(GenJnlLine);
                    GenJnlLine.SetCurrentKey("Journal Batch Name", "Journal Template Name");
                    GenJnlLine.SetRange("Journal Template Name", 'ASSETS');
                    GenJnlLine.SetRange("Journal Batch Name", CurrentJnlBatchName);
                    if GenJnlLine.Find('-') then begin
                        repeat
                            if GenJnlLine."Account Type" = GenJnlLine."Account Type"::"Fixed Asset" then begin
                                if GenJnlLine."FA Posting Type" = GenJnlLine."FA Posting Type"::Depreciation then begin
                                    DefaultShortcutDimCode5 := '060';
                                    GenJnlLine.ValidateShortcutDimCode(5, DefaultShortcutDimCode5);
                                    GenJnlLine.Modify;
                                end;
                            end;
                        until GenJnlLine.Next = 0;
                    end;

                    Message('Validate Transaction Type Complete.');
                end;

            }
        }

    }
    var
        GenJnlLine: Record "Gen. Journal Line";
        CurrentJnlBatchName: code[20];
        AVDoc: Code[20];
        recGLEntry: Record "G/L Entry";
        JournalBatchNameForReport: Code[20];
        DefaultShortcutDimCode5: Code[20];
}
