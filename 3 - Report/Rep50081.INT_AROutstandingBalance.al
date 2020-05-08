report 50081 "INT_AR Outstanding Balance"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/AROutstandingBalance.rdl';
    Caption = 'AR Outstanding Balance';

    dataset
    {
        dataitem("Cust. Ledger Entry"; "Cust. Ledger Entry")
        {
            DataItemTableView = sorting("Entry No.") where("Remaining Amount" = filter(<> 0));
            RequestFilterFields = "Customer No.", "Customer Posting Group", "Date Filter";

            column(GetFilter; "Cust. Ledger Entry".GetFilters)
            {

            }
            column(Customer_No_; "Customer No.")
            {
            }

            column(Customer_Name; "Customer Name")
            {
            }

            column(ReceivableAccount; ReceivableAccount)
            {
            }

            column(Document_No_; "Document No.")
            {
            }

            column(Document_Date; FORMAT("Document Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }

            column(Posting_Date; FORMAT("Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(Remaining_Amount; "Remaining Amount")
            {
            }
            column(Description; Description)
            {
            }
            column(Global_Dimension_2_Code; "Global Dimension 2 Code")
            {
            }

            trigger OnAfterGetRecord()
            begin
                Clear(CustPostingGroupTB);
                CustPostingGroupTB.SetCurrentKey(Code);
                CustPostingGroupTB.SetRange(Code, "Cust. Ledger Entry"."Customer Posting Group");
                if CustPostingGroupTB.FindFirst() then
                    ReceivableAccount := CustPostingGroupTB."Receivables Account";
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
        ReceivableAccount: Code[20];
        CustPostingGroupTB: Record "Customer Posting Group";
}