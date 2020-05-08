report 50064 "INT_FA Schedule V2"
{
    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/FAScheduleV2.rdl';
    Caption = 'FA Schedule V2';

    dataset
    {

        dataitem("FA Ledger Entry"; "FA Ledger Entry")
        {
            DataItemTableView = SORTING("FA No.", "Depreciation Book Code", "FA Posting Date");
            RequestFilterFields = "FA No.", "Depreciation Book Code", "FA Class Code", "FA Subclass Code", "FA Location Code", "Global Dimension 1 Code", "Global Dimension 2 Code";


            trigger OnPreDataItem()
            begin
                FaFilter := "FA Ledger Entry".GETFILTERS;   //AVTSB 12/01/2016
                                                            //"FA Ledger Entry".SETRANGE("FA Ledger Entry"."Posting Date",StartDate,EndDate);

                //AVWNFCNX.001 021019
                IF WriteOff THEN BEGIN
                    "FA Ledger Entry".SETRANGE("FA Ledger Entry"."FA Posting Category", "FA Ledger Entry"."FA Posting Category"::Disposal);
                    "FA Ledger Entry".SETFILTER("FA Ledger Entry"."Document No.", 'FA*');
                END;
                //C-AVWNFCNX.001 021019

                CopanyInFo.GET; //AVTSB 12/01/2016
            end;

            trigger OnAfterGetRecord()
            begin
                IF OldFANo <> "FA Ledger Entry"."FA No." THEN BEGIN
                    CLEAR(TmpFALedgerEntry);
                    TmpFALedgerEntry.INIT;
                    EntryNo += 1;
                    TmpFALedgerEntry := "FA Ledger Entry";
                    TmpFALedgerEntry."Entry No." := EntryNo;
                    //AVWNFCNX.001 140619
                    IF Show <> 0 THEN BEGIN
                        IF Show = Show::Block THEN BEGIN
                            CLEAR(FixedAssetTB);
                            FixedAssetTB.SETCURRENTKEY("No.");
                            FixedAssetTB.SETRANGE("No.", "FA Ledger Entry"."FA No.");
                            FixedAssetTB.SETRANGE(Blocked, TRUE);
                            IF FixedAssetTB.FINDFIRST THEN
                                TmpFALedgerEntry.INSERT;
                        END ELSE
                            IF Show = Show::"No Block" THEN BEGIN
                                CLEAR(FixedAssetTB);
                                FixedAssetTB.SETCURRENTKEY("No.");
                                FixedAssetTB.SETRANGE("No.", "FA Ledger Entry"."FA No.");
                                FixedAssetTB.SETRANGE(Blocked, FALSE);
                                IF FixedAssetTB.FINDFIRST THEN
                                    TmpFALedgerEntry.INSERT;
                            END;
                    END ELSE
                        TmpFALedgerEntry.INSERT;
                    //C-AVWNFCNX.001 140619
                    //TmpFALedgerEntry.INSERT; //AVWNFCNX.001 140619
                END;

                OldFANo := "FA Ledger Entry"."FA No.";
            end;
        }

        dataitem(RecLoop; Integer)
        {
            DataItemTableView = SORTING(Number);

            column(FaPostingGrp; TmpFALedgerEntry."FA Posting Group")
            {
            }
            column(DocumentNo; TmpFALedgerEntry."Document No.")
            {
            }
            column(FaPostingGrpDesc; FAPostingGroup.INT_Description)
            {
            }
            column(FANo; TmpFALedgerEntry."FA No.")
            {
            }
            column(FADesc; FixedAsset.Description + ' ' + FixedAsset."Description 2")
            {
            }
            column(FAAcquisDate; FORMAT(FADepreciationBook."Acquisition Date", 0, 1))
            {
            }
            column(FADeprecDate; FORMAT(FADepreciationBook."Depreciation Starting Date", 0, 1))
            {
            }
            column(StraightLinePercent; FADepreciationBook."Straight-Line %")
            {
            }
            column(DecArray1; DecArray[1])
            {
            }
            column(DecArray2; DecArray[2])
            {
            }
            column(DecArray3; DecArray[3])
            {
            }
            column(DecArray4; DecArray[4])
            {
            }
            column(DecArray5; DecArray[5])
            {
            }
            column(DecArray6; DecArray[6])
            {
            }
            column(DecArray7; DecArray[7])
            {
            }
            column(FALastDepDate; FORMAT(FADepreciationBook."Last Depreciation Date", 0, 1))
            {
            }
            column(FABranch; TmpFALedgerEntry."Global Dimension 2 Code")
            {
            }
            column(StartDate; FORMAT(StartDate, 0, 1))
            {
            }
            column(EndDate; FORMAT(EndDate, 0, 1))
            {
            }
            column(Fafilter; FaFilter)
            {
            }
            column(Name_CompanyInfo; CopanyInFo.Name)
            {
            }
            column(PrinDate; FORMAT(TODAY, 0, 1) + ' ' + FORMAT(TIME))
            {
            }
            column(SoldAssets; SoldAssets)
            {
            }
            column(WriteOff; WriteOff)
            {
            }
            column(DeptCode; FixedAsset."Global Dimension 1 Code")
            {
            }

            trigger OnPreDataItem()
            begin
                CLEAR(TmpFALedgerEntry);
                TmpFALedgerEntry.SETCURRENTKEY("Entry No.");
                RecLoop.SETRANGE(RecLoop.Number, 1, TmpFALedgerEntry.COUNT);
            end;

            trigger OnAfterGetRecord()
            begin
                IF RecLoop.Number = 1 THEN
                    TmpFALedgerEntry.FIND('-')
                ELSE
                    IF TmpFALedgerEntry.NEXT = 0 THEN
                        EXIT;

                CLEAR(FixedAsset);
                IF FixedAsset.GET(TmpFALedgerEntry."FA No.") THEN;

                CLEAR(FADepreciationBook);
                //AVWNFCNX.001 300919
                IF WriteOff THEN BEGIN
                    FADepreciationBook.SETCURRENTKEY("FA No.", "Depreciation Book Code");
                    FADepreciationBook.SETRANGE("FA No.", TmpFALedgerEntry."FA No.");
                    FADepreciationBook.SETRANGE("Depreciation Book Code", TmpFALedgerEntry."Depreciation Book Code");
                    IF (StartAcqDate <> 0D) AND (EndAcqDate <> 0D) THEN
                        FADepreciationBook.SETRANGE("Acquisition Date", StartAcqDate, EndAcqDate);
                    IF FADepreciationBook.FINDFIRST THEN BEGIN
                        //Nothing
                    END ELSE
                        CurrReport.SKIP;
                END ELSE BEGIN
                    IF (StartAcqDate <> 0D) AND (EndAcqDate <> 0D) THEN BEGIN
                        FADepreciationBook.SETCURRENTKEY("FA No.", "Depreciation Book Code");
                        FADepreciationBook.SETRANGE("FA No.", TmpFALedgerEntry."FA No.");
                        FADepreciationBook.SETRANGE("Depreciation Book Code", TmpFALedgerEntry."Depreciation Book Code");
                        FADepreciationBook.SETRANGE("Acquisition Date", StartAcqDate, EndAcqDate);
                        IF FADepreciationBook.FINDFIRST THEN BEGIN
                            //Nothing
                        END ELSE
                            CurrReport.SKIP;
                    END ELSE
                        IF FADepreciationBook.GET(TmpFALedgerEntry."FA No.", TmpFALedgerEntry."Depreciation Book Code") THEN;
                end;

                CLEAR(FAPostingGroup);
                IF FAPostingGroup.GET(TmpFALedgerEntry."FA Posting Group") THEN;
                IF SkipRecord THEN
                    CurrReport.SKIP;
                CLEAR(DecArray);
                CLEAR(FALedgerEntry);
                FALedgerEntry.SETCURRENTKEY("FA No.", "Depreciation Book Code", "FA Posting Date");
                FALedgerEntry.SETRANGE(FALedgerEntry."FA No.", TmpFALedgerEntry."FA No.");
                FALedgerEntry.SETFILTER(FALedgerEntry."Posting Date", '..%1', EndDate);
                FALedgerEntry.SETRANGE(FALedgerEntry."FA Posting Type", FALedgerEntry."FA Posting Type"::"Acquisition Cost");
                FALedgerEntry.SETFILTER(FALedgerEntry."FA Posting Category", '<>%1', FALedgerEntry."FA Posting Category"::Disposal);
                IF NOT FALedgerEntry.ISEMPTY THEN BEGIN
                    FALedgerEntry.CALCSUMS(FALedgerEntry.Amount);
                    DecArray[1] := FALedgerEntry.Amount;
                END;

                CLEAR(FALedgerEntry);
                FALedgerEntry.SETCURRENTKEY("FA No.", "Depreciation Book Code", "FA Posting Date");
                FALedgerEntry.SETRANGE(FALedgerEntry."FA No.", TmpFALedgerEntry."FA No.");
                FALedgerEntry.SETFILTER(FALedgerEntry."Posting Date", '%1..%2', StartDate, EndDate);
                FALedgerEntry.SETRANGE(FALedgerEntry."FA Posting Type", FALedgerEntry."FA Posting Type"::Depreciation);
                FALedgerEntry.SETFILTER(FALedgerEntry."FA Posting Category", '<>%1', FALedgerEntry."FA Posting Category"::Disposal);
                FALedgerEntry.SETRANGE(FALedgerEntry."Reclassification Entry", FALSE);
                IF NOT FALedgerEntry.ISEMPTY THEN BEGIN
                    FALedgerEntry.CALCSUMS(FALedgerEntry.Amount);
                    DecArray[2] := FALedgerEntry.Amount;
                END;

                CLEAR(FALedgerEntry);
                FALedgerEntry.SETCURRENTKEY("FA No.", "Depreciation Book Code", "FA Posting Date");
                FALedgerEntry.SETRANGE(FALedgerEntry."FA No.", TmpFALedgerEntry."FA No.");
                FALedgerEntry.SETFILTER(FALedgerEntry."Posting Date", '..%1', EndDate);
                FALedgerEntry.SETRANGE(FALedgerEntry."FA Posting Type", FALedgerEntry."FA Posting Type"::Depreciation);
                FALedgerEntry.SETFILTER(FALedgerEntry."FA Posting Category", '<>%1', FALedgerEntry."FA Posting Category"::Disposal);
                //FALedgerEntry.SETRANGE(FALedgerEntry."Reclassification Entry",FALSE);
                IF NOT FALedgerEntry.ISEMPTY THEN BEGIN
                    FALedgerEntry.CALCSUMS(FALedgerEntry.Amount);
                    DecArray[3] := FALedgerEntry.Amount;
                END;

                CLEAR(FALedgerEntry);
                FALedgerEntry.SETCURRENTKEY("FA No.", "Depreciation Book Code", "FA Posting Date");
                FALedgerEntry.SETRANGE(FALedgerEntry."FA No.", TmpFALedgerEntry."FA No.");
                FALedgerEntry.SETFILTER(FALedgerEntry."Posting Date", '<%1', StartDate);
                FALedgerEntry.SETFILTER(FALedgerEntry."FA Posting Category", '<>%1', FALedgerEntry."FA Posting Category"::Disposal);
                IF NOT FALedgerEntry.ISEMPTY THEN BEGIN
                    FALedgerEntry.CALCSUMS(FALedgerEntry.Amount);
                    DecArray[5] := FALedgerEntry.Amount;
                END;

                CLEAR(FALedgerEntry);
                FALedgerEntry.SETCURRENTKEY("FA No.", "Depreciation Book Code", "FA Posting Date");
                FALedgerEntry.SETRANGE(FALedgerEntry."FA No.", TmpFALedgerEntry."FA No.");
                FALedgerEntry.SETFILTER(FALedgerEntry."Posting Date", '<%1', StartDate);
                FALedgerEntry.SETFILTER(FALedgerEntry."FA Posting Type", 'Depreciation');
                FALedgerEntry.SETFILTER(FALedgerEntry."FA Posting Category", '<>%1', FALedgerEntry."FA Posting Category"::Disposal);
                IF NOT FALedgerEntry.ISEMPTY THEN BEGIN
                    FALedgerEntry.CALCSUMS(FALedgerEntry.Amount);
                    DecArray[6] := FALedgerEntry.Amount;
                END;

                CLEAR(FALedgerEntry);
                FALedgerEntry.SETCURRENTKEY("FA No.", "Depreciation Book Code", "FA Posting Date");
                FALedgerEntry.SETRANGE(FALedgerEntry."FA No.", TmpFALedgerEntry."FA No.");
                //FALedgerEntry.SETFILTER(FALedgerEntry."Posting Date",'%1..%2',StartDate,EndDate);
                FALedgerEntry.SETFILTER(FALedgerEntry."FA Posting Type", 'Salvage Value');
                FALedgerEntry.SETFILTER(FALedgerEntry."FA Posting Category", '<>%1', FALedgerEntry."FA Posting Category"::Disposal);
                IF NOT FALedgerEntry.ISEMPTY THEN BEGIN
                    FALedgerEntry.CALCSUMS(FALedgerEntry.Amount);
                    DecArray[7] := FALedgerEntry.Amount;
                END;

                CLEAR(FALedgerEntry);
                FALedgerEntry.SETCURRENTKEY("FA No.", "Depreciation Book Code", "FA Posting Date");
                FALedgerEntry.SETRANGE(FALedgerEntry."FA No.", TmpFALedgerEntry."FA No.");
                FALedgerEntry.SETRANGE(FALedgerEntry."Part of Book Value", TRUE);
                //FALedgerEntry.SETFILTER(FALedgerEntry."FA Posting Category",'<>%1',FALedgerEntry."FA Posting Category"::Disposal);
                FALedgerEntry.SETFILTER(FALedgerEntry."Posting Date", '..%1', EndDate);
                IF NOT FALedgerEntry.ISEMPTY THEN BEGIN
                    FALedgerEntry.CALCSUMS(FALedgerEntry.Amount);
                    DecArray[4] := FALedgerEntry.Amount + DecArray[7];
                    //pum 16112016
                    //IF (FADepreciationBook."Disposal Date" < EndDate) AND (FADepreciationBook."Disposal Date" <> 0D) THEN
                    //   DecArray[4] := 0;
                END;
            end;
        }


    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field("Start Date"; StartDate)
                    {
                        Caption = 'Start Date';
                        ApplicationArea = All;
                        //Visible = false;
                    }
                    field("End Date"; EndDate)
                    {
                        Caption = 'End Date';
                        ApplicationArea = All;
                        //Visible = false;
                    }


                    field("Only Sold Assets"; SoldAssets)
                    {
                        Caption = 'Only Sold Assets';
                        ApplicationArea = All;
                    }
                    field(Show; Show)
                    {
                        Caption = 'Show';
                        ApplicationArea = All;
                    }
                    field("Sold out"; ChkDisposalDate)
                    {
                        Caption = 'Sold out';
                        ApplicationArea = All;
                    }

                    field(WriteOff; WriteOff)
                    {
                        Caption = 'WriteOff';
                        ApplicationArea = All;
                    }
                    field("From Date"; StartAcqDate)
                    {
                        Caption = 'From Date';
                        ApplicationArea = All;
                    }
                    field("To Date"; EndAcqDate)
                    {
                        Caption = 'To Date';
                        ApplicationArea = All;
                    }
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
    LOCAL procedure SkipRecord(): Boolean
    begin
        DisposalDate := FADepreciationBook."Disposal Date";

        IF SoldAssets AND (DisposalDate = 0D) THEN
            EXIT(TRUE);

        IF SoldAssets AND ((DisposalDate = StartDate) OR (DisposalDate = EndDate)) THEN
            EXIT(FALSE);

        IF SoldAssets AND (EndDate > 0D) AND
           //   ((DisposalDate > EndDate) OR (DisposalDate < StartDate))
           ((DisposalDate > EndDate))
        THEN
            EXIT(TRUE);

        IF SoldAssets AND (EndDate > 0D) AND
           //   ((DisposalDate > EndDate) OR (DisposalDate < StartDate))
           ((DisposalDate <= StartDate))
        THEN
            EXIT(TRUE);

        //AVWNFCNX.001 021019
        IF WriteOff = FALSE THEN BEGIN
            //IF NOT SoldAssets AND (DisposalDate > 0D) AND (DisposalDate > StartDate) THEN
            IF NOT SoldAssets AND (DisposalDate > 0D) AND (DisposalDate <= EndDate) THEN
                EXIT(TRUE);
        END;
        //C-AVWNFCNX.001 021019
        EXIT(FALSE);
    end;

    trigger OnPreReport()
    begin
        IF (StartDate = 0D) OR (EndDate = 0D) THEN
            ERROR('Please specify Start Date and End Date.');
        //if (StartAcqDate = 0D) OR (EndAcqDate = 0D) then
        //    Error('Please specify From Date and To Date.');
    end;



    var
        DecArray: Array[10] of Decimal;
        FixedAsset: Record "Fixed Asset";
        FADepreciationBook: Record "FA Depreciation Book";
        FALedgerEntry: Record "FA Ledger Entry";
        TmpFALedgerEntry: Record "FA Ledger Entry" temporary;
        FAPostingGroup: Record "FA Posting Group";
        EntryNo: Integer;
        OldFANo: Code[20];
        StartDate: Date;
        EndDate: Date;
        FaFilter: Text[100];
        CopanyInFo: Record "Company Information";
        SoldAssets: Boolean;
        DisposalDate: Date;
        Show: Option ,Block,"No Block";
        FixedAssetTB: Record "Fixed Asset";
        StartAcqDate: Date;
        EndAcqDate: Date;
        ChkDisposalDate: Boolean;
        WriteOff: Boolean;


}