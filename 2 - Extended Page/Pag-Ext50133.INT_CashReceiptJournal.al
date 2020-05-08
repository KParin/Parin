pageextension 50133 "INT_Cash Receipt Journal" extends "Cash Receipt Journal"
{
    layout
    {
        modify("G/L_Temp")
        {
            Visible = false;
        }

        addafter(Description)
        {
            field("INT_Debit Amount New"; "Debit Amount")
            {
                Caption = 'Debit Amount';
                Visible = true;
                Editable = true;
            }
            field("INT_Credit Amount New"; "Credit Amount")
            {
                Caption = 'Credit Amount';
                Visible = true;
                Editable = true;
            }
        }
        moveafter("Credit Amount"; Amount)
        modify("Amount (LCY)")
        {
            Visible = false;
        }
        modify("Bal. Account Type")
        {
            Visible = false;
        }
        modify("Bal. Account No.")
        {
            Visible = false;
        }
        modify(Correction)
        {
            Visible = false;
        }
        /*modify(ref)
        {
            Visible = false;
        }*/

        moveafter("FNAR003_Ref. Customer No."; "FNAR003_Ref. Customer Name")




    }



    actions
    {
        modify(Reconcile)
        {
            Visible = false;
            Promoted = false;
        }
        modify("Request Approval")
        {
            Visible = false;
        }
        modify(Post)
        {
            //AVWNFINT.001 17/12/2019
            //Add code for run report after post
            trigger OnBeforeAction()
            var
                GenJnlLineTB: Record "Gen. Journal Line";
            begin
                CLEAR(AVDoc);
                AVDoc := "Document No.";
                //Message('1 : ' + Format(AVDoc));

                Clear(GenJnlLineTB);
                GenJnlLineTB.SetCurrentKey("Journal Template Name", "Journal Batch Name", "Line No.");
                GenJnlLineTB.SetRange("Journal Template Name", "Journal Template Name");
                GenJnlLineTB.SetRange("Journal Batch Name", "Journal Batch Name");
                if GenJnlLineTB.Find('-') then begin
                    repeat
                        if GenJnlLineTB."Account No." <> '' then begin
                            Clear(GLAccount);
                            if GLAccount.get(GenJnlLineTB."Account No.") then;
                            if GLAccount."AVF_WHT Account - RV" then begin
                                GenJnlLineTB.TestField("FNAR003_Ref. WHT Base");
                                GenJnlLineTB.TestField("FNAR003_Ref. WHT%");
                                GenJnlLineTB.TestField("FNAR003_Ref. WHT Type");
                                GenJnlLineTB.TestField("FNAR003_WHT No. - RV");
                                GenJnlLineTB.TestField("FNAR002_Ref. Customer Name");
                                GenJnlLineTB.TestField("FNAR002_Ref. Cust. Post Date");
                                GenJnlLineTB.TestField("FNAR002_Ref. Customer No.");
                            end;
                        end;
                    until GenJnlLineTB.Next = 0;
                end;

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
                        REPORT.RUN(REPORT::"INT_Receipt Voucher", TRUE, FALSE, recGLEntry)
                END;
            end;
            //C-AVWNFINT.001 29/11/2019
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        "Document Type" := "Document Type"::Payment;
    end;

    trigger OnAfterGetRecord()
    begin
        //EditableRV := true;
        if "Account No." <> '' then begin
            Clear(GLAccount);
            if GLAccount.get("Account No.") then;
            if GLAccount."AVF_WHT Account - RV" then
                EditableRV := false
            else
                EditableRV := true;
        end;
    end;

    var
        GenJnlLine: Record "Gen. Journal Line";
        CurrentJnlBatchName: code[20];
        AVDoc: Code[20];
        recGLEntry: Record "G/L Entry";
        JournalBatchNameForReport: Code[20];
        GLAccount: Record "G/L Account";
        EditableRV: Boolean;
}