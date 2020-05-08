page 50099 "INT_WHT Entry EDIT"
{
    // version AVFTH1.0
    Caption = 'WHT Entry EDIT';
    Editable = true;
    PageType = List;
    SourceTable = "AVF_WHT Entry";
    Permissions = TableData "AVF_WHT Entry" = m;
    PromotedActionCategories = 'New,Process,Report,Entry';
    UsageCategory = History;

    layout
    {
        area(content)
        {
            repeater(Control1500000)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Gen. Prod. Posting Group"; "Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transaction Type"; "Transaction Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Base; Base)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("WHT Calculation Type"; "WHT Calculation Type")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Currency Code"; "Currency Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Bill-to/Pay-to No."; "Bill-to/Pay-to No.")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Source Code"; "Source Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Reason Code"; "Reason Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Closed by Entry No."; "Closed by Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field(Closed; Closed)
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Country/Region Code"; "Country/Region Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Transaction No."; "Transaction No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unrealized Amount"; "Unrealized Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unrealized Base"; "Unrealized Base")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Remaining Unrealized Amount"; "Remaining Unrealized Amount")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Remaining Unrealized Base"; "Remaining Unrealized Base")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("No. Series"; "No. Series")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unrealized WHT Entry No."; "Unrealized WHT Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("WHT Bus. Posting Group"; "WHT Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("WHT Prod. Posting Group"; "WHT Prod. Posting Group")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Base (LCY)"; "Base (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Amount (LCY)"; "Amount (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unrealized Amount (LCY)"; "Unrealized Amount (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Unrealized Base (LCY)"; "Unrealized Base (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("WHT %"; "WHT %")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rem Unrealized Amount (LCY)"; "Rem Unrealized Amount (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Rem Unrealized Base (LCY)"; "Rem Unrealized Base (LCY)")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("WHT Difference"; "WHT Difference")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("AVF_Ship-to/Order Address Code"; "Ship-to/Order Address Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Document Date"; "Document Date")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Actual Vendor No."; "Actual Vendor No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("WHT Certificate No."; "WHT Certificate No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Void Check"; "Void Check")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Original Document No."; "Original Document No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Void Payment Entry No."; "Void Payment Entry No.")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("WHT Report Line No"; "WHT Report Line No")
                {
                    ApplicationArea = All;
                    Editable = false;
                }
                field("WHT Report"; "WHT Report")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
                field("WHT Revenue Type"; "WHT Revenue Type")
                {
                    ApplicationArea = All;
                    Editable = true;
                }
            }
        }
    }
}
