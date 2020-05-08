pageextension 50128 "INT_Payment Journal" extends "Payment Journal"
{
    layout
    {
        addafter("Account No.")
        {
            field("INT_Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Visible = false;
            }
        }

        modify("G/L_Temp")
        {
            Visible = false;
        }
        modify(Control1)
        {
            FreezeColumn = "Document No.";
        }
        modify("Recipient Bank Account")
        {
            Visible = false;
        }
        modify("Message to Recipient")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("Currency Code")
        {
            Visible = false;
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }
        moveafter(Description; "AVF_Debit Amount")
        moveafter("AVF_Debit Amount"; "AVF_Credit Amount")
        moveafter("AVF_Credit Amount"; Amount)
        moveafter(Amount; "Amount (LCY)")
        modify(Correction)
        {
            Visible = false;
        }
        modify(TotalExportedAmount)
        {
            Visible = false;
        }
        modify("Has Payment Export Error")
        {
            Visible = false;
        }
        modify("Exported to Payment File")
        {
            Visible = false;
        }
        modify(AppliesToDocNo)
        {
            Visible = false;
        }
        /*addlast(Control1)
        {
            field("INT_Applies-to Doc. Type"; "Applies-to Doc. Type")
            {
                Caption = 'Applies-to Doc. Type';
                Editable = true;
            }
            field("INT_Applies-to Doc. No."; "Applies-to Doc. No.")
            {
                Caption = 'Applies-to Doc. No.';
                Editable = true;
            }
        }*/
        movelast(Control1; "Applies-to Doc. Type")
        //movelast(Control1; "Applies-to Doc. No.")
        addlast(Control1)
        {
            field("INT_Applies-to Doc. No."; "Applies-to Doc. No.")
            {
                Caption = 'Applies-to Doc. No.';
                Editable = true;
            }
        }
        modify("Bank Payment Type")
        {
            Visible = false;
        }
        addafter("AVF_Pay-to Description")
        {
            field("INT_Pay-to Description 2"; "INT_Pay-to Description 2")
            {
                ApplicationArea = All;
            }
        }

    }
    actions
    {
        modify(VoidPayments)
        {
            Promoted = false;
        }
        modify(TransmitPayments)
        {
            Promoted = false;
        }
        modify(ExportPaymentsToFile)
        {
            Promoted = false;
        }
        modify(CreditTransferRegEntries)
        {
            Promoted = false;
        }
        modify(CreditTransferRegisters)
        {
            Promoted = false;
        }
        modify(Reconcile)
        {
            Promoted = false;
        }
        modify(SuggestEmployeePayments)
        {
            Promoted = false;
        }
        modify(SuggestVendorPayments)
        {
            Promoted = false;
        }
        modify(CalculatePostingDate)
        {
            Promoted = false;
        }
        modify(Approvals)
        {
            Promoted = false;
            Visible = false;
        }
        modify("Void Check")
        {
            Promoted = false;
            Visible = false;
        }
        modify("Void &All Checks")
        {
            Promoted = false;
            Visible = false;
        }
        modify(CreateApprovalWorkflow)
        {
            Visible = false;
        }
        modify(DMAP_PrepaymentAP)
        {
            Visible = false;
        }
        modify(PrintCheck)
        {
            Visible = false;
            Promoted = false;
        }
        modify(PreviewCheck)
        {
            Visible = false;
            Promoted = false;
        }
        addfirst("&Payments")
        {
            action("INT_Print Cheque BBL")
            {
                AccessByPermission = TableData "Check Ledger Entry" = R;
                ApplicationArea = Basic, Suite;
                Caption = 'Print Cheque BBL';
                Ellipsis = true;
                Image = PrintCheck;
                Promoted = true;
                PromotedCategory = Category11;
                ToolTip = 'Prepare to print the check.';

                trigger OnAction()
                begin
                    GenJnlLine.Reset;
                    GenJnlLine.Copy(Rec);
                    GenJnlLine.SetRange("Journal Template Name", "Journal Template Name");
                    GenJnlLine.SetRange("Journal Batch Name", "Journal Batch Name");
                    GenJnlLine.SetRange("Account Type", GenJnlLine."Account Type"::"Bank Account");
                    GenJnlLine.SetRange("AVF_Type of Payment", GenJnlLine."AVF_Type of Payment"::Check);
                    if GenJnlLine.FindFirst() then begin
                        Report.RunModal(50046, TRUE, FALSE, GenJnlLine);
                    end;
                    //DocPrint.PrintCheck(GenJnlLine);
                    //CODEUNIT.Run(CODEUNIT::"Adjust Gen. Journal Balance", Rec);
                end;
            }
        }
        modify(Post)
        {
            //AVPKJINT.001 20/01/2020 Add code for run report after post
            trigger OnBeforeAction()
            begin
                CLEAR(AVDoc);
                AVDoc := "Document No.";
            end;
            //C-AVPKJINT.001 20/01/2020

            trigger OnAfterAction()
            begin
                //AVPKJINT.001 29/11/2019
                //Add code for run report payment journal after post payment journal
                JournalBatchNameForReport := GETRANGEMAX("Journal Batch Name");
                CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                CurrPage.UPDATE(FALSE);

                IF CurrentJnlBatchName <> AVDoc THEN BEGIN
                    CLEAR(recGLEntry);
                    recGLEntry.SETRANGE("Journal Batch Name", JournalBatchNameForReport);
                    recGLEntry.SetRange("Document No.", AVDoc);
                    if recGLEntry.FindFirst() then
                        REPORT.RUN(REPORT::"INT_Payment Voucher", TRUE, FALSE, recGLEntry)
                END;
                //C-AVPKJINT.001 29/11/2019
            end;
        }


    }

    var
        GenJnlLine: Record "Gen. Journal Line";
        CurrentJnlBatchName: code[20];
        AVDoc: Code[20];
        recGLEntry: Record "G/L Entry";
        JournalBatchNameForReport: Code[20];
}
