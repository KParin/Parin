report 50057 "INT_Fixed Asset"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/FixedAsset.rdl';
    Caption = 'Fixed Asset';

    dataset
    {
        dataitem("Fixed Asset"; "Fixed Asset")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.", "FA Posting Group", "Global Dimension 1 Code", "Global Dimension 2 Code";

            column(Com_Name; CompanyInfoTB.FNGN001_NameEng)
            {
            }
            column(FixedAsset_No; "Fixed Asset"."No.")
            {
            }
            column(FixedAsset_Des1; "Fixed Asset".Description)
            {
            }
            column(FixedAsset_Des2; "Fixed Asset"."Description 2")
            {
            }
            column(FixedAsset_FAPosting_Group; "Fixed Asset"."FA Posting Group")
            {
            }
            column(Running; Running)
            {
            }
            column(PrintDate; 'Date : ' + FORMAT(TODAY, 0, 1))
            {
            }
            column(FA_DepreBook_Acquisition_Cost; FADepreciationBookTB."Acquisition Cost")
            {
            }
            column(FA_DepreBook_Depreciation_Method; FADepreciationBookTB."Depreciation Method")
            {
            }
            column(FA_DepreBook_StraightLine; FADepreciationBookTB."Straight-Line %")
            {
            }
            column(FA_DepreBook_Acquisition_Date; FORMAT(FADepreciationBookTB."Acquisition Date", 0, 1))
            {
            }
            column(FA_Classs; FADepreciationBookTB."FA Posting Group")
            {
            }
            column(FA_Depreciation; FADepreciationBookTB.Depreciation)
            {
            }
            column(BoolValue; FADepreciationBookTB."Book Value")
            {
            }
            column(FA_Dim1; "Fixed Asset"."Global Dimension 1 Code")
            {
            }
            column(AcqusCostAccount; FAPostingGroup."Acquisition Cost Account")
            {
            }
            column(Olds; Olds)
            {
            }
            column(FA_DepreBook_Old_Code; "Fixed Asset"."FNGN002_Old Code")
            {
            }
            column(FAPostingGroupFilter; FAPostingGroupFilter)
            {
            }
            column(FACodeFilter; FACodeFilter)
            {
            }
            column(CostCenterFilter; CostCenterFilter)
            {
            }

            trigger OnPreDataItem()
            begin
                CLEAR(CompanyInfoTB);
                CompanyInfoTB.GET;
                CLEAR(Running);

                FAPostingGroupFilter := "Fixed Asset".GetFilter("FA Posting Group");
                FACodeFilter := "Fixed Asset".GetFilter("No.");
                CostCenterFilter := "Fixed Asset"."Global Dimension 1 Code";

            end;

            trigger OnAfterGetRecord()
            begin
                CLEAR(FADepreciationBookTB);
                FADepreciationBookTB.SETCURRENTKEY(FADepreciationBookTB."FA No.");
                FADepreciationBookTB.SETRANGE(FADepreciationBookTB."FA No.", "Fixed Asset"."No.");
                IF FADepreciationBookTB.FIND('-') THEN;

                Running += 1;
                FADepreciationBookTB.CALCFIELDS(FADepreciationBookTB."Acquisition Cost", FADepreciationBookTB.Depreciation, FADepreciationBookTB."Book Value");
                CLEAR(Olds);
                IF FADepreciationBookTB."Straight-Line %" <> 0 THEN
                    Olds := 100 / FADepreciationBookTB."Straight-Line %";

                Clear(FAPostingGroup);
                FAPostingGroup.SetCurrentKey(code);
                FAPostingGroup.SetRange(code, FADepreciationBookTB."FA Posting Group");
                if FAPostingGroup.FindFirst then;

            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {

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
        CompanyInfoTB: Record "Company Information";
        Running: Integer;
        FADepreciationBookTB: Record "FA Depreciation Book";
        Olds: Decimal;
        FAPostingGroup: Record "FA Posting Group";
        FAPostingGroupFilter: Code[20];
        FACodeFilter: Code[20];
        CostCenterFilter: Code[20];

}