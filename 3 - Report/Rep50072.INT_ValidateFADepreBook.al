report 50072 "INT_Validate FA Depre Book"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    //Permissions = TableData "FA Ledger Entry" = m;

    dataset
    {
        dataitem("FA Depreciation Book"; "FA Depreciation Book")
        {
            DataItemTableView = SORTING("FA No.");
            RequestFilterFields = "FA No.";

            trigger OnAfterGetRecord()
            begin
                "FA Depreciation Book"."Last Depreciation Date" := 20191231D;
                "FA Depreciation Book".Modify;
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

    trigger OnPreReport()
    begin
        Message('Validate Complete.');
    end;

    var
        myInt: Integer;
}