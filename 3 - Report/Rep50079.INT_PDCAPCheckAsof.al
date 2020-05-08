report 50079 "INT_PDC-AP Check As of"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/PDC-AP Check As of.rdl';
    CaptionML = ENU = 'PDC-AP Check As of';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem("Check Ledger Entry"; "Check Ledger Entry")
        {
            DataItemTableView = SORTING("Document No.", "Bank Account No.", "Check No.", "Entry No.");
            RequestFilterFields = "Posting Date", "Bank Account No.", "Document No.", "FNGL002_Transfer Date";

            column(a; "Check Ledger Entry"."AVF_Pay-to Description")
            {
            }
            column(b; recVenLed.Description)
            {
            }
            column(c; recGLEn.Description)
            {
            }
            column(ComName; CompanyInfo.Name + ' ' + CompanyInfo."Name 2")
            {
            }
            column(EntryNo_CheckLedgerEntry; "Check Ledger Entry"."Entry No.")
            {
            }
            column(RunningNo; RunningNo)
            {
            }
            column(userid; USERID)
            {
            }
            column(DatePrint; FORMAT(TODAY) + ' ' + FORMAT(TIME))
            {
            }
            column(CheckFilter; "Check Ledger Entry".GETFILTERS)
            {
            }
            column(Vendor_No; VendLedTB."Vendor No.")
            {
            }
            column(Vendor_Name; VendorName)
            {
            }
            column(Amount_CheckLedgerEntry; "Check Ledger Entry".Amount)
            {
            }
            column(CheckDate_CheckLedgerEntry; FORMAT("Check Ledger Entry"."Check Date", 0, 1))
            {
            }
            column(CheckNo_CheckLedgerEntry; "Check Ledger Entry"."Check No.")
            {
            }
            column(TransferDate_CheckLedgerEntry; FORMAT("Check Ledger Entry"."FNGL002_Transfer Date", 0, 1))
            {
            }
            column(PostingDate_CheckLedgerEntry; FORMAT("Check Ledger Entry"."Posting Date", 0, 1))
            {
            }
            column(DocumentNo_CheckLedgerEntry; "Check Ledger Entry"."Document No.")
            {
            }
            column(KeepText_1; KeepText[1])
            {
            }
            column(KeepText_2; KeepText[2])
            {
            }
            column(KeepText_3; KeepText[3])
            {
            }
            column(KeepText_4; KeepText[4])
            {
            }
            column(RefPostedDocNo_CheckLedgerEntry; "Check Ledger Entry"."FNGL002_Ref. Posted Doc. No.")
            {
            }

            column(GLEntryAmount; GLEntryAmount)
            {
            }

            trigger OnPreDataItem()
            begin
                CLEAR(RunningNo);
                CompanyInfo.GET;
                //CompanyInfo.CALCFIELDS(CompanyInfo."Logo Voucher");

                IF ShowAsofDateChecknotPass <> 0D THEN
                    "Check Ledger Entry".SETFILTER("FNGL002_Transfer Date", '%1|>%2', 0D, ShowAsofDateChecknotPass);
            end;

            trigger OnAfterGetRecord()
            begin
                CLEAR(KeepText);
                CLEAR(recVenLed);
                CLEAR(recGLEn);
                CLEAR(GLEntryAmount);
                RunningNo += 1;
                KeepText[1] := "Check Ledger Entry"."AVF_Pay-to Description";

                IF KeepText[1] = '' THEN BEGIN
                    CLEAR(recVenLed);
                    recVenLed.SETRANGE("Document No.", "Document No.");
                    IF recVenLed.FINDFIRST THEN
                        KeepText[1] := recVenLed.Description;
                END;

                IF KeepText[1] = '' THEN BEGIN
                    CLEAR(recGLEn);
                    recGLEn.SETRANGE("Document No.", "Document No.");
                    IF recGLEn.FINDFIRST THEN
                        KeepText[1] := recGLEn.Description;
                END;

                //AVWNFPPC.001 250618
                CLEAR(VendorTB);
                CLEAR(VendLedTB);
                CLEAR(GLEntryTB);
                VendLedTB.SETCURRENTKEY("Document No.");
                VendLedTB.SETRANGE(VendLedTB."Document No.", "Check Ledger Entry"."Document No.");
                IF VendLedTB.FINDFIRST THEN BEGIN
                    VendorTB.SETCURRENTKEY("No.");
                    VendorTB.SETRANGE(VendorTB."No.", VendLedTB."Vendor No.");
                    IF VendorTB.FINDFIRST THEN
                        VendorName := VendorTB.Name;//+ ' ' + VendorTB."Name 2";
                END
                ELSE BEGIN
                    VendorName := "Check Ledger Entry"."AVF_Pay-to Description";
                END;

                GLEntryTB.SETCURRENTKEY("Entry No.");
                GLEntryTB.SETRANGE(GLEntryTB."Document No.", "Check Ledger Entry"."Document No.");
                GLEntryTB.SETFILTER(GLEntryTB."G/L Account No.", '%1|%2', '1160208', '1160207');
                IF GLEntryTB.FIND('-') THEN BEGIN
                    REPEAT
                        GLEntryAmount += GLEntryTB.Amount
                    UNTIL GLEntryTB.NEXT = 0;
                END;

                //C-AVWNFPPC.001 250618

                IF "Check Ledger Entry".FNGL002_Transferred THEN
                    KeepText[3] := 'P';
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                field(ShowAsofDateChecknotPass; ShowAsofDateChecknotPass)
                {
                    Caption = 'กรณีต้องการโชว์เฉพาะเช็คที่ยังไม่ผ่าน กรุณากรอกวันที่s';
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    var
        KeepText: Array[10] of Text[1024];
        recVenLed: Record "Vendor Ledger Entry";
        VendLedTB: Record "Vendor Ledger Entry";
        VendorTB: Record Vendor;
        recGLEn: Record "G/L Entry";
        GLEntryTB: Record "G/L Entry";
        CompanyInfo: Record "Company Information";
        RunningNo: Integer;
        VendorName: Text[100];
        ShowAsofDateChecknotPass: Date;
        GLEntryAmount: Decimal;



}