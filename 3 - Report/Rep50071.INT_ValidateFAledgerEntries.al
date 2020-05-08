report 50071 "INT_Validate FA ledger Entries"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    Permissions = TableData "FA Ledger Entry" = m;

    dataset
    {
        dataitem("FA Ledger Entry"; "FA Ledger Entry")
        {
            DataItemTableView = SORTING("Document No.");
            RequestFilterFields = "Document No.";

            trigger OnAfterGetRecord()
            begin
                "FA Ledger Entry"."FA Posting Date" := 20191231D;
                "FA Ledger Entry".Modify;
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