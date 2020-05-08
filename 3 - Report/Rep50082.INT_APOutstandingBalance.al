report 50082 "INT_AP Outstanding Balance"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/APOutstandingBalance.rdl';
    Caption = 'AP Outstanding Balance';

    dataset
    {
        dataitem("Vendor Ledger Entry"; "Vendor Ledger Entry")
        {
            DataItemTableView = sorting("Entry No.") where("Remaining Amount" = filter(<> 0));
            RequestFilterFields = "Vendor No.", "Vendor Posting Group", "Date Filter";

            column(GetFilter; "Vendor Ledger Entry".GetFilters)
            {

            }
            column(Vendor_No_; "Vendor No.")
            {
            }

            column(Vendor_Name; VendorTB.Name)
            {
            }

            column(PayablesAccount; PayablesAccount)
            {
            }

            column(Document_No_; "Document No.")
            {
            }

            column(Document_Date; FORMAT("Document Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(External_Document_No_; "External Document No.")
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
                Clear(VendorPostingGroupTB);
                VendorPostingGroupTB.SetCurrentKey(Code);
                VendorPostingGroupTB.SetRange(Code, "Vendor Ledger Entry"."Vendor Posting Group");
                if VendorPostingGroupTB.FindFirst() then
                    PayablesAccount := VendorPostingGroupTB."Payables Account";

                Clear(VendorTB);
                if VendorTB.Get("Vendor Ledger Entry"."Vendor No.") then;
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
        PayablesAccount: Code[20];
        VendorPostingGroupTB: Record "Vendor Posting Group";
        VendorTB: Record Vendor;
}