report 50001 "INT_Purchased Journal Voucher"
{
    // version AVTHLC1.0

    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/Purchased Journal Voucher.rdl';
    PreviewMode = PrintLayout;
    Caption = 'Purchased Journal Voucher';

    dataset
    {
        dataitem(Group; "G/L Entry")
        {
            DataItemTableView = SORTING("Document No.", "Posting Date");
            RequestFilterFields = "Document No.", "Posting Date", "Source Code";
            column(DocumentNo_Group; Group."Document No.")
            {
            }
            dataitem("G/L Entry"; "G/L Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                DataItemTableView = SORTING("Document No.", "Posting Date") WHERE(Amount = FILTER(<> 0));
                column(Group_DocumentNo; Group."Document No.")
                {
                }
                column(Comment; Comment)
                {
                }
                column(ShowReceivedBy; ShowReceivedBy)
                {

                }
                column(USERIDtxt; 'User : ' + USERID)
                {
                }
                column(DatePrinted; 'Date Printed : ' + FORMAT(TODAY, 0, 1) + ' ' + FORMAT(TIME, 0, '<Hours12>:<Minutes,2>:<Seconds,2> <AM/PM>'))
                {
                }
                column(HeadReport; HeadReport)
                {
                }
                column(HeadReportTH; HeadReportTH)
                {
                }
                column(CompanyInfoName; CompanyInfo.Name)
                {
                }
                column(DocumentNo_GLEntry; "G/L Entry"."Document No.")
                {
                }
                column(EntryNo_GLEntry; "G/L Entry"."Entry No.")
                {
                }
                column(PostingDate_GLEntry; Format("G/L Entry"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
                {
                }
                column(DocumentType_GLEntry; "G/L Entry"."Document Type")
                {
                }
                column(PurchInvHeader_DueDate; FORMAT(PurchInvHeader."Due Date", 0, 1))
                {
                }
                column(PurchInvHeader_ChkDeliveryMethod; PurchInvHeader."INT_Cheque Delivery Method")
                {
                }
                column(PurchCRHeader_DueDate; FORMAT(PurchCRHeader."Due Date", 0, 1))
                {
                }
                column(VendName; VendName)
                {
                }
                column(VendDoc; VendDoc)
                {
                    //OptionCaption = '" ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund"';
                }
                column(PurchInvHeader_PostingDescription; PurchInvHeader."Posting Description" + PurchCRHeader."Posting Description")
                {
                }
                column(ShowCurrRate; ShowCurrRate)
                {
                }
                column(CurrRate; CurrRate)
                {
                }
                column(PurchInvHeader_YourReference; PurchInvHeader."Your Reference" + PurchCRHeader."Your Reference")
                {
                }
                column(PurchInvHeader_DocDate; FORMAT(PurchInvHeader."Document Date", 0, 1))
                {

                }
                column(PurchCRHeader_DocDate; FORMAT(PurchCRHeader."Document Date", 0, 1))
                {

                }
                column(Running; Running)
                {
                }
                column(GLAccountNo_Name; "G/L Account No." + ' - ' + GLAccount.Name)
                {
                }
                column(Description; Description)
                {
                }
                column(AVCurrAmt; AVCurrAmt)
                {
                }
                column(DebitAmount; ROUND("Debit Amount", 0.01, '='))
                {
                }
                column(CreditAmount; ROUND("Credit Amount", 0.01, '='))
                {
                }
                column(ShowDimension; ShowDimension)
                {
                }
                column(Show119401; Show119401)
                {
                }
                column(Show119402; Show119402)
                {
                }
                column(GLAccountNo_Name2; GLAccount."No." + ' - ' + GLAccount.Name)
                {
                }
                column(Desc119401; Desc119401)
                {
                }
                column(Desc119402; Desc119401)
                {
                }
                column(AMT119401; AMT119401)
                {
                }
                column(AMT119402; AMT119402)
                {
                }
                column(xAMT119401; -AMT119401)
                {
                }
                column(xAMT119402; -AMT119402)
                {
                }
                column(TotalCredit; TotalCredit)
                {
                }
                column(TotalDebit; TotalDebit)
                {
                }
                //AVPKJINT.001 04/11/2019
                column(Global_Dimension_1_Code; "Global Dimension 1 Code")
                {
                }
                column(Global_Dimension_2_Code; "Global Dimension 2 Code")
                {
                }
                column(GlobalDim1Caption; GlobalDim1Caption)
                {
                }
                column(GlobalDim2Caption; GlobalDim2Caption)
                {
                }
                //C-AVPKJINT.001 04/11/2019

                dataitem("Dimension Set Entry"; "Dimension Set Entry")
                {
                    DataItemLink = "Dimension Set ID" = FIELD("Dimension Set ID");
                    //DataItemTableView = SORTING("Dimension Set ID", "Dimension Code");    //AVPKJINT.001 26/11/2019 Comment Code
                    DataItemTableView = SORTING("Dimension Set ID", "Dimension Code") where("Dimension Code" = FILTER(<> 'COST CENTER' & <> 'TRADING PARTNERS'));      //AVPKJINT.001 26/11/2019 Add Code
                    column(DimensionSetID_DimensionSetEntry; "Dimension Set Entry"."Dimension Set ID")
                    {
                    }
                    column(DimensionText; DimensionText)
                    {
                    }

                    trigger OnAfterGetRecord();
                    begin
                        //calcfields("Dimension Value Name");//เอาออกเนื่องจากอยากแสดงแต่โค้ด

                        if DimensionText = '' then begin
                            if "Dimension Value Name" <> '' then begin
                                DimensionText := "Dimension Code" + ' : ' + "Dimension Value Code" + ' = ' + "Dimension Value Name";
                            end else begin
                                DimensionText := "Dimension Code" + ' : ' + "Dimension Value Code";
                            end;
                        end else begin
                            if "Dimension Value Name" <> '' then
                                DimensionText := DimensionText + ', ' + "Dimension Code" + ' : ' + "Dimension Value Code" + ' = ' + "Dimension Value Name"
                            else
                                DimensionText := DimensionText + ', ' + "Dimension Code" + ' : ' + "Dimension Value Code";
                        end;
                    end;

                    trigger OnPreDataItem();
                    begin
                        CLEAR(DimensionText);
                    end;
                }

                trigger OnAfterGetRecord();
                begin
                    CLEAR(SourceCode);
                    SourceCode.SETRANGE(Code, "Source Code");
                    SourceCode.NEXT;

                    if (HeadReport = '') AND (HeadReportTH = '') then begin
                        Clear(HeadReport);
                        Clear(HeadReportTH);
                        if "Document Type" = "Document Type"::Invoice then begin
                            HeadReport := 'Purchase Journal Voucher';
                            HeadReportTH := 'ใบสำคัญซื้อ';
                        end else begin
                            if "Document Type" = "Document Type"::"Credit Memo" then begin
                                HeadReport := 'Purchase Credit Memo Voucher';
                                HeadReportTH := 'ใบสำคัญลดหนี้';
                            end else begin
                                HeadReport := 'Purchase Journal Voucher';
                                HeadReportTH := 'ใบสำคัญซื้อ';
                            end;
                        end;
                    end;

                    // Find Vendor //
                    CLEAR(PurchInvHeader);
                    CLEAR(PurchCRHeader);
                    CLEAR(ShowCurrRate);
                    CLEAR(CurrRate);
                    if PurchInvHeader.GET("Document No.") then begin
                        CLEAR(PurchInvHeader);
                        PurchInvHeader.SETRANGE("No.", "Document No.");
                        PurchInvHeader.NEXT;
                        if PurchInvHeader."Buy-from Vendor Name" = '' then
                            VendName := PurchInvHeader."Buy-from Vendor No." + ' - ' + PurchInvHeader."Buy-from Vendor Name 2"
                        else
                            VendName := PurchInvHeader."Buy-from Vendor No." + ' - ' + PurchInvHeader."Buy-from Vendor Name"
                                                                             + ' - ' + PurchInvHeader."Buy-from Vendor Name 2";
                        VendDoc := PurchInvHeader."Vendor Invoice No.";

                        if PurchInvHeader."Currency Factor" <> 0 then begin
                            ShowCurrRate := COPYSTR(PurchInvHeader."Currency Code", 1, 3);
                            CurrRate := 1 / PurchInvHeader."Currency Factor";
                            ShowCurrRate := ShowCurrRate;
                        end;


                    end
                    else
                        if PurchCRHeader.GET("Document No.") then begin
                            CLEAR(PurchCRHeader);
                            PurchCRHeader.SETRANGE("No.", "Document No.");
                            PurchCRHeader.NEXT;
                            if PurchCRHeader."Buy-from Vendor Name" = '' then
                                VendName := PurchCRHeader."Buy-from Vendor No." + ' - ' + PurchCRHeader."Buy-from Vendor Name 2"
                            else
                                VendName := PurchCRHeader."Buy-from Vendor No." + ' - ' + PurchCRHeader."Buy-from Vendor Name"
                                                                                + ' - ' + PurchCRHeader."Buy-from Vendor Name 2";
                            VendDoc := PurchCRHeader."Vendor Cr. Memo No.";

                            if PurchCRHeader."Currency Factor" <> 0 then begin
                                ShowCurrRate := COPYSTR(PurchCRHeader."Currency Code", 1, 3);
                                CurrRate := 1 / PurchCRHeader."Currency Factor";
                                ShowCurrRate := ShowCurrRate;

                            end;

                        end
                        else begin
                            CLEAR(VendName);
                            CLEAR(VendDoc);
                        end;

                    if OldGLdoc <> "Document No." then begin

                        CLEAR(PurchInvHeader);
                        PurchInvHeader.SETRANGE("No.", "Document No.");
                        if PurchInvHeader.FIND('-') then
                            RefDoc := PurchInvHeader."Pre-Assigned No.";
                        CLEAR(TotalCredit);
                        CLEAR(TotalDebit);
                    end;
                    OldGLdoc := "Document No.";

                    TotalCredit += ROUND("Credit Amount", 0.01, '=');
                    TotalDebit += ROUND("Debit Amount", 0.01, '=');

                    if ("G/L Account No." = '119401') or ("G/L Account No." = '119402') then begin
                        //Do not thing
                    end else
                        Running := Running + 1;

                    // Get G/L Account Description //
                    CLEAR(GLAccount);
                    GLAccount.SETRANGE("No.", "G/L Account No.");
                    GLAccount.NEXT;

                    CLEAR(AVCurrAmt);
                    if CurrRate <> 0 then begin
                        if "Debit Amount" <> 0 then begin
                            AVCurrAmt := "Debit Amount" / CurrRate;
                        end
                        else
                            if "Credit Amount" <> 0 then begin
                                AVCurrAmt := -"Credit Amount" / CurrRate;
                            end;
                    end;

                    //---------------------------------footer----------------------------------
                    CLEAR(Show119401);
                    CLEAR(Show119402);
                    CLEAR(NextGL);
                    NextGL.COPY("G/L Entry");
                    NextGL.NEXT;
                    if NextGL."Document No." <> "G/L Entry"."Document No." then begin

                        CLEAR(GLEntry);
                        CLEAR(OldDesc);
                        GLEntry.SETRANGE("Document No.", "Document No.");
                        GLEntry.SETRANGE("G/L Account No.", '119401');
                        GLEntry.NEXT;
                        if GLEntry.COUNT = 0 then
                            Show119401 := true
                        else begin
                            CLEAR(AMT119401);
                            CLEAR(Desc119401);
                            //Running := Running + 1;
                            CLEAR(GLAccount);
                            GLAccount.SETRANGE("No.", GLEntry."G/L Account No.");
                            GLAccount.NEXT;
                            for a := 1 to GLEntry.COUNT do begin
                                AMT119401 := AMT119401 + GLEntry.Amount;
                                if OldDesc <> GLEntry.Description then begin
                                    if Desc119401 = '' then
                                        Desc119401 := GLEntry.Description
                                    else
                                        Desc119401 := Desc119401 + ', ' + GLEntry.Description;
                                    OldDesc := GLEntry.Description;
                                end;
                                GLEntry.NEXT;
                            end;
                        end;


                        CLEAR(GLEntry);
                        CLEAR(OldDesc);
                        GLEntry.SETRANGE("Document No.", "Document No.");
                        GLEntry.SETRANGE("G/L Account No.", '119402');
                        GLEntry.NEXT;
                        if GLEntry.COUNT = 0 then
                            Show119402 := true
                        else begin
                            CLEAR(AMT119402);
                            CLEAR(Desc119402);
                            //Running := Running + 1;
                            CLEAR(GLAccount);
                            GLAccount.SETRANGE("No.", GLEntry."G/L Account No.");
                            GLAccount.NEXT;
                            for a := 1 to GLEntry.COUNT do begin
                                AMT119402 := AMT119402 + GLEntry.Amount;
                                if OldDesc <> GLEntry.Description then begin
                                    if Desc119402 = '' then
                                        Desc119402 := GLEntry.Description
                                    else
                                        Desc119402 := Desc119402 + ', ' + GLEntry.Description;
                                    OldDesc := GLEntry.Description;
                                end;
                                GLEntry.NEXT;
                            end;
                        end;
                    end;

                    //AVPKJINT.001 04/11/2019
                    Clear(DimensionsTB);
                    DimensionsTB.SetCurrentKey(Code);
                    DimensionsTB.SetRange(DimensionsTB.Code, "G/L Entry"."Global Dimension 1 Code");
                    if DimensionsTB.FindFirst then;
                    //C-AVPKJINT.001 04/11/2019

                end;

                trigger OnPreDataItem();
                begin
                    LastFieldNo := FIELDNO("Document No.");
                    CompanyInfo.GET;
                    CLEAR(Running);

                    if Filter then SETFILTER("Entry No.", FORMAT(EntryNo));
                end;
            }
            dataitem("WHT Entry"; "AVF_WHT Entry")
            {
                DataItemLink = "Document No." = FIELD("Document No.");
                //DataItemTableView = SORTING("WHT Bus. Posting Group", "WHT Prod. Posting Group", "Posting Date", Settled) WHERE("Document Type" = FILTER(Invoice));
                DataItemTableView = SORTING("WHT Bus. Posting Group", "WHT Prod. Posting Group", "Posting Date", Settled) WHERE("Document Type" = FILTER(Invoice | "Credit Memo"));
                column(WHTProdPostingGroup_WHTEntry; "WHT Entry"."WHT Prod. Posting Group")
                {
                }
                column(WHTBusPostingGroup_WHTEntry; "WHT Entry"."WHT Bus. Posting Group")
                {
                }
                column(WHT_WHTEntry; "WHT Entry"."WHT %")
                {
                }
                column(UnrealizedBaseLCY_WHTEntry; "WHT Entry"."Unrealized Base (LCY)")
                {
                }
                column(UnrealizedAmountLCY_WHTEntry; "WHT Entry"."Unrealized Amount (LCY)")
                {
                }
                column(ShowWHT; ShowWHT)
                {
                }

                trigger OnAfterGetRecord();
                begin
                    ShowWHT := true;
                end;

                trigger OnPreDataItem();
                begin
                    if Filter then SETFILTER("Entry No.", FORMAT(EntryNo));
                end;
            }

            trigger OnAfterGetRecord();
            begin
                Filter := false;
                if (OldDoc <> '') and (OldDoc <> "Document No.") then begin


                end
                //CurrReport.NewPage()
                else
                    if (OldDoc <> '') and (OldDoc = "Document No.") then
                        Filter := true;
                OldDoc := "Document No.";
                CLEAR(ShowWHT);
            end;

            trigger OnPreDataItem();
            begin
                EntryNo := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Option")
                {
                    field(ShowDimension; ShowDimension)
                    {
                    }
                    field(Comment; Comment)
                    {
                        Visible = false;
                    }
                    field(ShowReceivedBy; ShowReceivedBy)
                    {
                        Caption = 'โชว์ผู้รับเงิน';
                    }

                }

            }
        }

        actions
        {
        }

        trigger OnOpenPage()
        begin
            ShowDimension := true;
        end;
    }

    labels
    {
    }

    var
        LastFieldNo: Integer;
        FooterPrinted: Boolean;
        CompanyInfo: Record "Company Information";
        SourceCode: Record "Source Code";
        OldSource: Code[10];
        DateFilter: Text[50];
        DateHeader: Text[50];
        POS: Integer;
        Running: Integer;
        GLAccount: Record "G/L Account";
        CheckLedger: Record "Check Ledger Entry";
        CheckNo: Text[100];
        i: Integer;
        DimensionText: Text[500];
        ShowDimension: Boolean;
        OldDoc: Code[30];
        Vendor: Record Vendor;
        PurchInvHeader: Record "Purch. Inv. Header";
        VendName: Text[150];
        PurchCRHeader: Record "Purch. Cr. Memo Hdr.";
        VendDoc: Text[50];
        EntryNo: Integer;
        "Filter": Boolean;
        GLEntry: Record "G/L Entry";
        AMT119401: Decimal;
        AMT119402: Decimal;
        Desc119401: Text[1000];
        Desc119402: Text[1000];
        a: Integer;
        OldDesc: Text[100];
        RefDoc: Code[20];
        Comment: Text[1024];
        ShowReceivedBy: Boolean;
        AVCurrAmt: Decimal;
        ShowCurrRate: Text[30];
        CurrRate: Decimal;
        OldGLdoc: Code[20];
        NextGL: Record "G/L Entry";
        Show119401: Boolean;
        Show119402: Boolean;
        TotalDebit: Decimal;
        TotalCredit: Decimal;
        ShowWHT: Boolean;

        //AVPKJINT.001 04/11/2019
        DimensionsTB: Record "Dimension";
        GlobalDim1Caption: Text[50];
        GlobalDim2Caption: Text[50];
        //C-AVPKJINT.001 04/11/2019
        HeadReport: Text[100];
        HeadReportTH: Text[100];
}

