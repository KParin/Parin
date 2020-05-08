pageextension 50139 "INT_General Journal" extends "General Journal"
{
    layout
    {
        addafter("Credit Amount")
        {
            field("INT_Amount"; Amount)
            {
                Caption = 'Amount';
                ApplicationArea = All;
            }
            field("INT_Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("INT_Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;
            }
            field(INT_ShortcutDimCode3; ShortcutDimCode[3])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,3';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                //ToolTip = 'Specifies the dimension value code linked to the journal line.';
                Visible = true;

                trigger OnValidate()
                begin
                    ValidateShortcutDimCode(3, ShortcutDimCode[3]);
                end;
            }
            field(INT_ShortcutDimCode4; ShortcutDimCode[4])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,4';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                //ToolTip = 'Specifies the dimension value code linked to the journal line.';
                Visible = true;

                trigger OnValidate()
                begin
                    ValidateShortcutDimCode(4, ShortcutDimCode[4]);
                end;
            }
            field(INT_ShortcutDimCode5; ShortcutDimCode[5])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,5';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                //ToolTip = 'Specifies the dimension value code linked to the journal line.';
                Visible = true;

                trigger OnValidate()
                begin
                    ValidateShortcutDimCode(5, ShortcutDimCode[5]);
                end;
            }
            field(INT_ShortcutDimCode6; ShortcutDimCode[6])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,6';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                //ToolTip = 'Specifies the dimension value code linked to the journal line.';
                Visible = true;

                trigger OnValidate()
                begin
                    ValidateShortcutDimCode(6, ShortcutDimCode[6]);
                end;
            }
            field(INT_ShortcutDimCode7; ShortcutDimCode[7])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,7';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                //ToolTip = 'Specifies the dimension value code linked to the journal line.';
                Visible = true;

                trigger OnValidate()
                begin
                    ValidateShortcutDimCode(7, ShortcutDimCode[7]);
                end;
            }
            field(INT_ShortcutDimCode8; ShortcutDimCode[8])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,8';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8), "Dimension Value Type" = CONST(Standard), Blocked = CONST(false));
                //ToolTip = 'Specifies the dimension value code linked to the journal line.';
                Visible = true;

                trigger OnValidate()
                begin
                    ValidateShortcutDimCode(8, ShortcutDimCode[8]);
                end;
            }
            field("INT_Gen. Posting Type"; "Gen. Posting Type")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("INT_Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("INT_Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("INT_VAT Bus. Posting Group"; "VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("INT_VAT Prod. Posting Group"; "VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                Visible = false;
            }
            field("INT_Account Type"; "Account Type")
            {

            }
            field("INT_AVF_Type of Payment"; "AVF_Type of Payment")
            {

            }
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("G/L_Temp")
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
        addbefore("Debit Amount")
        {
            field("INT_External Document No."; "External Document No.")
            {
                ApplicationArea = All;
                Visible = true;
            }
        }

        addbefore("Account No.")
        {
            field("INT_Document No."; "Document No.")
            {
                ApplicationArea = All;
                Visible = true;
            }
        }
        addafter("Document No.")
        {
            field("INT_Posting Date"; "Posting Date")
            {
                ApplicationArea = All;
                Visible = true;
            }
        }

        /*modify("Bal. Account Type")
        {
            ApplicationArea = All;
            Visible = true;
            Editable = true;
        }
        modify("Bal. Account No.")
        {
            ApplicationArea = All;
            Visible = true;
            Editable = true;
        }*/
    }
    actions
    {
        modify(Reconcile)
        {
            Visible = false;
            Promoted = false;
        }
        modify("Apply Entries")
        {
            Visible = false;
            Promoted = false;
        }
        modify(Approvals)
        {
            Visible = false;
            Promoted = false;
        }
        modify("Insert Conv. LCY Rndg. Lines")
        {
            Visible = false;
            Promoted = false;
        }
        modify(GetStandardJournals)
        {
            Visible = false;
            Promoted = false;
        }
        modify(SaveAsStandardJournal)
        {
            Visible = false;
            Promoted = false;
        }
        modify("Test Report")
        {
            Visible = false;
            Promoted = false;
        }
        modify(PostAndPrint)
        {
            Visible = false;
            Promoted = false;
        }
        modify(DeferralSchedule)
        {
            Visible = false;
            Promoted = false;
        }
        modify(IncomingDocument)
        {
            Visible = false;
            //Promoted = false;
        }
        modify("B&ank")
        {
            Visible = false;
            //Promoted = false;
        }
        modify("Request Approval")
        {
            Visible = false;
            //Promoted = false;
        }
        modify(SendApprovalRequest)
        {
            Visible = false;
            //Promoted = false;
        }
        modify(CancelApprovalRequest)
        {
            Visible = false;
            //Promoted = false;
        }
        modify(SeeFlows)
        {
            Visible = false;
            Promoted = false;
        }
        modify("Opening Balance")
        {
            Visible = false;
            //Promoted = false;
        }
        modify("Prepare journal")
        {
            Visible = false;
            //Promoted = false;
        }
        modify("G/L Accounts Opening balance ")
        {
            Visible = false;
            Promoted = false;
        }
        modify("Customers Opening balance")
        {
            Visible = false;
            Promoted = false;
        }
        modify("Vendors Opening balance")
        {
            Visible = false;
            Promoted = false;
        }
        modify(Post)
        {
            //AVPKJINT.001 20/01/2020 Add code for run report after post
            trigger OnBeforeAction()
            var
                DefaultDimTB: Record "Default Dimension";
            begin
                CLEAR(AVDoc);
                AVDoc := "Document No.";
                //Message('1 : ' + Format(AVDoc));

                if "Source Code" = 'CLSINCOME' then begin
                    Clear(DefaultDimTB);
                    DefaultDimTB.SetCurrentKey("Table ID");
                    DefaultDimTB.SetRange("Table ID", 15);
                    DefaultDimTB.SetRange("No.", "Account No.");
                    if DefaultDimTB.Find('-') then begin
                        repeat
                            DefaultDimTB."Value Posting" := DefaultDimTB."Value Posting"::"Code Mandatory";
                            DefaultDimTB.Modify;
                        until DefaultDimTB.Next = 0;
                    end;
                end;

            end;
            //C-AVPKJINT.001 20/01/2020

            trigger OnAfterAction()
            var
                DefaultDimTB: Record "Default Dimension";
            begin
                //AVPKJINT.001 20/01/2020
                //Add code for run report payment journal after post payment journal
                //CLEAR(AVDoc);
                //AVDoc := "Document No.";
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
                //C-AVPKJINT.001 20/01/2020

                /*
                if "Source Code" = 'CLSINCOME' then begin
                    Clear(DefaultDimTB);
                    DefaultDimTB.SetCurrentKey("Table ID");
                    DefaultDimTB.SetRange("Table ID", 15);
                    DefaultDimTB.SetRange("No.", "Account No.");
                    if DefaultDimTB.Find('-') then begin
                        repeat
                            DefaultDimTB."Value Posting" := DefaultDimTB."Value Posting"::"Code Mandatory";
                            DefaultDimTB.Modify;
                        until DefaultDimTB.Next = 0;
                    end;
                end;
                */

            end;
        }

        addbefore(Post)
        {
            action("INT_ClearDimForClosePeriod")
            {
                Caption = 'Clear Dim. for Close Period';
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction()
                var
                    DefaultDimTB: Record "Default Dimension";
                    GenJnlLine: Record "Gen. Journal Line";
                begin
                    Clear(GenJnlLine);
                    GenJnlLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                    GenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
                    GenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
                    GenJnlLine.SetRange("Document No.", "Document No.");
                    if GenJnlLine.Find('-') then begin
                        repeat
                            Clear(DefaultDimTB);
                            DefaultDimTB.SetCurrentKey("Table ID");
                            DefaultDimTB.SetRange("Table ID", 15);
                            DefaultDimTB.SetRange("No.", GenJnlLine."Account No.");
                            if DefaultDimTB.Find('-') then begin
                                repeat
                                    DefaultDimTB."Value Posting" := DefaultDimTB."Value Posting"::" ";
                                    DefaultDimTB.Modify;
                                until DefaultDimTB.Next = 0;
                            end;
                        until GenJnlLine.Next = 0;
                    end;
                    Message('Clear Dimension for Close Period Complete.');
                end;
            }
        }

        addbefore(PostAndPrint)
        {

            action("INT_SummaryPayroll")
            {
                Caption = 'Report Summary Payroll';
                Promoted = true;
                PromotedCategory = Report;
                RunObject = report 50069;
            }

            action("INT_Group Payroll")
            {
                Caption = 'Group Payroll';
                Promoted = true;
                PromotedCategory = Process;


                trigger OnAction()
                var
                    AVGenJnlLineCheck: Record "Gen. Journal Line";
                    sumAmount: Decimal;
                begin
                    if "Journal Template Name" <> 'JV-PAYROLL' then
                        Error('This function for Interface Payroll.');

                    //ถ้าเป็น Cost Center & Payroll Type เดียวกันให้ delete บรรทัดแล้ว sum amount                   
                    Clear(sumAmount);
                    Clear(RecGenJnlLine);
                    RecGenJnlLine.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                    RecGenJnlLine.SetRange("Journal Template Name", 'JV-PAYROLL');
                    RecGenJnlLine.SetRange("Journal Batch Name", 'JV-JP');
                    RecGenJnlLine.SetRange("Document No.", "Document No.");
                    if RecGenJnlLine.Find('-') then begin
                        repeat

                            Clear(AVGenJnlLineCheck);
                            AVGenJnlLineCheck.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                            AVGenJnlLineCheck.SetRange("Journal Template Name", 'JV-PAYROLL');
                            AVGenJnlLineCheck.SetRange("Journal Batch Name", 'JV-JP');
                            AVGenJnlLineCheck.SetRange("Document No.", RecGenJnlLine."Document No.");
                            AVGenJnlLineCheck.SetRange("Shortcut Dimension 1 Code", RecGenJnlLine."Shortcut Dimension 1 Code");
                            AVGenJnlLineCheck.SetRange("Account No.", RecGenJnlLine."Account No.");
                            AVGenJnlLineCheck.SetRange("External Document No.", RecGenJnlLine."External Document No.");
                            AVGenJnlLineCheck.SetFilter("Line No.", '<>%1', RecGenJnlLine."Line No.");
                            if AVGenJnlLineCheck.FindFirst then begin

                                //sumAmount += FieldAmount;
                                //AVGenJnlLineCheck.Validate(Amount, sumAmount);

                                if (CopyStr(RecGenJnlLine."External Document No.", 1, 3) = 'SAL') OR
                                (CopyStr(RecGenJnlLine."External Document No.", 1, 3) = 'PFC') OR
                                (CopyStr(RecGenJnlLine."External Document No.", 1, 3) = 'SOC') OR
                                (CopyStr(RecGenJnlLine."External Document No.", 1, 2) = 'ZS') OR
                                (CopyStr(RecGenJnlLine."External Document No.", 1, 2) = 'ZE') OR
                                (CopyStr(RecGenJnlLine."External Document No.", 1, 2) = 'ZA') OR
                                (CopyStr(RecGenJnlLine."External Document No.", 1, 2) = 'ZW') OR
                                (CopyStr(RecGenJnlLine."External Document No.", 1, 2) = 'PF') OR
                                (CopyStr(RecGenJnlLine."External Document No.", 1, 3) = 'TAX') OR
                                (CopyStr(RecGenJnlLine."External Document No.", 1, 7) = 'SUM_PFC') OR
                                (CopyStr(RecGenJnlLine."External Document No.", 1, 7) = 'SUM_SOC') then begin
                                    //sumAmount += AVGenJnlLineCheck.Amount;
                                    //RecGenJnlLine.Validate(Amount, sumAmount);
                                    RecGenJnlLine."Debit Amount" += AVGenJnlLineCheck.Amount;
                                    RecGenJnlLine.Amount += AVGenJnlLineCheck.Amount;
                                    RecGenJnlLine.Modify;
                                    AVGenJnlLineCheck.Delete;
                                end;
                                /*
                                end else begin
                                    AVGenJnlLineCheck.Amount += AVGenJnlLineCheck.Amount * -1;
                                    AVGenJnlLineCheck."Credit Amount" += AVGenJnlLineCheck.Amount * -1;

                                end;
                                */


                                //AVGenJnlLineCheck.Delete;
                            end;
                        until RecGenJnlLine.Next = 0;
                    end;
                    //C-ถ้าเป็น Cost Center & Payroll Type เดียวกันให้ delete บรรทัดแล้ว sum amount                   

                    Message('Group Payroll Complete.');
                end;

            }

        }
    }
    trigger OnAfterGetRecord()
    begin
        ShowShortcutDimCode(ShortcutDimCode);
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(ShortcutDimCode);
    end;

    var
        ShortcutDimCode: array[8] of Code[20];
        GenJnlLine: Record "Gen. Journal Line";
        RecGenJnlLine: Record "Gen. Journal Line";
        CurrentJnlBatchName: code[20];
        AVDoc: Code[20];
        recGLEntry: Record "G/L Entry";
        JournalBatchNameForReport: Code[20];
}
