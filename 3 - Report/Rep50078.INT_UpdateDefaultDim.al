report 50078 "INT_UpdateDefaultDim"
{
    UsageCategory = Administration;
    ApplicationArea = All;

    dataset
    {
        dataitem("Default Dimension"; "Default Dimension")
        {
            DataItemTableView = sorting("Table ID");
            RequestFilterFields = "Table ID";

            trigger OnAfterGetRecord()
            begin
                "Default Dimension"."Value Posting" := "Default Dimension"."Value Posting"::"Code Mandatory";
                "Default Dimension".Modify;
            end;

            trigger OnPostDataItem()
            begin
                Message('Update Complete');
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
        myInt: Integer;
}