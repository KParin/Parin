page 50085 "INT_AC-MA Role Center"
{
    PageType = RoleCenter;
    Caption = 'AC-MA Role Center';

    layout
    {
        area(RoleCenter)
        {
            part(Headline; "Headline RC Accountant")
            {
                ApplicationArea = Basic, Suite;
            }

            part(Activities; "Small Business Owner Act.")
            {
                ApplicationArea = Basic, Suite;
            }
            part(GenericChart; "Generic Chart")
            {
                ApplicationArea = Basic, Suite;
                Visible = true;
            }
            part("Finance Performance"; "Finance Performance")
            {
                ApplicationArea = Basic, Suite;
            }
            part("My Vendors"; "My Vendors")
            {
                ApplicationArea = Basic, Suite;
            }
            part("My Customers"; "My Customers")
            {
                ApplicationArea = Basic, Suite;
            }

        }
    }

    actions
    {
        /*area(Creation)
        {
            action(AppNameDocumentCard)
            {
                RunPageMode = Create;
                Caption = 'AppNameDocumentCard';
                ToolTip = 'Add some tooltip here';
                Image = New;
                RunObject = page "AppNameDocumentCard";
                ApplicationArea = Basic, Suite;
            }
        }*/
        /*area(Processing)
        {
            group(New)
            {
                action(AppNameMasterData)
                {
                    RunPageMode = Create;
                    Caption = 'AppNameMasterData';
                    ToolTip = 'Register new AppNameMasterData';
                    RunObject = page "AppNameMasterData Card";
                    Image = DataEntry;
                    ApplicationArea = Basic, Suite;
                }
            }
            group("AppNameSomeProcess Group")
            {
                action(AppNameSomeProcess)
                {
                    Caption = 'AppNameSomeProcess';
                    ToolTip = 'AppNameSomeProcess description';
                    Image = Process;
                    RunObject = Codeunit "AppNameSomeProcess";
                    ApplicationArea = Basic, Suite;
                }
            }
            group("AppName Reports")
            {
                action(AppNameSomeReport)
                {
                    Caption = 'AppNameSomeReport';
                    ToolTip = 'AppNameSomeReport description';
                    Image = Report;
                    RunObject = report "AppNameSomeReport";
                    ApplicationArea = Basic, Suite;
                }
            }
        }*/
        /*area(Reporting)
        {
            action(AppNameSomeReport)
            {
                Caption = 'AppNameSomeReport';
                ToolTip = 'AppNameSomeReport description';
                Image = Report;
                RunObject = report "AppNameSomeReport";
                Promoted = true;
                PromotedCategory = Report;
                PromotedIsBig = true;
                ApplicationArea = Basic, Suite;
            }

        }*/
        /*area(Embedding)
        {
            action("AppNameMasterData List")
            {
                RunObject = page "AppNameMasterData List";
                ApplicationArea = Basic, Suite;
            }

        }*/
        area(Sections)
        {
            group("INT_Interface Bank BBL")
            {
                Caption = 'Interface Bank BBL';
                Visible = false;

                action("INT_Bank BBL Generate")
                {
                    Caption = 'Bank BBL Generate';
                    RunObject = Page "INT_Bank BBL Generate";
                    ApplicationArea = Basic, Suite;
                }

                action("INT_Interface Bank BBL List")
                {
                    Caption = 'Interface Bank BBL List';
                    RunObject = Page "INT_Bank BBL List";
                    ApplicationArea = Basic, Suite;
                }

                action("INT_Interface Bank BBL Posted List")
                {
                    Caption = 'Interface Bank BBL Posted List';
                    RunObject = Page "INT_Bank BBL Posted List";
                    ApplicationArea = Basic, Suite;
                }

            }
            group("INT_Interface Bank DBK")
            {
                Caption = 'Interface Bank DBK';
                Visible = false;

                action("INT_Bank DBK Generate")
                {
                    Caption = 'Bank DBK Generate';
                    RunObject = Page "INT_Bank DBK Generate";
                    ApplicationArea = Basic, Suite;
                }

                action("INT_Interface Bank DBK List")
                {
                    Caption = 'Interface Bank DBK List';
                    RunObject = Page "INT_Bank DBK List";
                    ApplicationArea = Basic, Suite;
                }

                action("INT_Interface Bank DBK Posted List")
                {
                    Caption = 'Interface Bank DBK Posted List';
                    RunObject = Page "INT_Bank DBK Posted List";
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Import Payroll")
            {
                Caption = 'Import Payroll';
                Visible = false;
                action("import Payroll2")
                {
                    Caption = 'Import Payroll';
                    RunObject = xmlport INT_ImportPayroll;
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Import ทุน")
            {
                Caption = 'Import ทุน';
                Visible = false;
                action("import Scholarship")
                {
                    Caption = 'import Scholarship';
                    RunObject = page "Config. Packages";
                    ApplicationArea = Basic, Suite;
                }
            }
            group("Create Master 1")
            {
                Caption = 'Create Master 1';
                //ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                //Image = Setup;
                Visible = false;

                action(Vendors1)
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Vendor List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';

                }
                action(Customers1)
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Customer List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';

                }
                action(Currencies1)
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page Currencies;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Currencies';
                }
                action(Dimensions1)
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page Dimensions;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Dimensions';
                }
                action("Payment Terms1")
                {
                    RunObject = Page "Payment Terms";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Terms';
                }

            }
            group("Create Master 2")
            {
                Caption = 'Create Master 2';
                //ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                //Image = Setup;
                Visible = false;

                action("Chart of Accounts")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Chart of Accounts";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Chart of Accounts';
                }
                action("Bank Accounts")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Bank Account List";
                    ApplicationArea = Basic, Suite;

                }
                /*action("G/L Accounts Master")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "G/L Account List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Accounts';
                    Visible = true;
                }
                action(Vendors)
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Vendor List";
                    ApplicationArea = Basic, Suite;

                }
                action(Customers)
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Customer List";
                    ApplicationArea = Basic, Suite;

                }
                action("Items Master")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Item List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Items';
                    Visible = false;

                }
                action(Currencies)
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page Currencies;
                    ApplicationArea = Basic, Suite;

                }
                action(Dimensions)
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page Dimensions;
                    ApplicationArea = Basic, Suite;

                }
                action("Salespersons/Purchasers")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Salespersons/Purchasers";
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                action("Payment Terms")
                {
                    RunObject = Page "Payment Terms";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Payment Terms';
                }
                */
            }
            group(PO)
            {
                Caption = 'PO';
                //ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                Image = Purchasing;
                Visible = false;

                action(Vendors3)
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Vendor List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';

                }
                action("Purchase Orders")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Purchase Order List";
                    ApplicationArea = Basic, Suite;

                }
                action("Purchase Orders - Finished")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "FNGN011_Purch. Order-FIN List";
                    ApplicationArea = Basic, Suite;

                }
                action("Posted Purchase Receipts")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Posted Purchase Receipts";
                    ApplicationArea = Basic, Suite;

                }
                action("Report Purchase")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "AVF_Object Report List";
                    ApplicationArea = Basic, Suite;
                    RunPageView = where("Group Report Filter" = const('PURCHASE'));

                }
            }
            group("AP Account")
            {
                Caption = 'AP Account';
                //ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                Image = Payables;
                Visible = false;

                action("Vendors AP Acc")
                {
                    RunObject = Page "Vendor List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';
                }
                action("G/L Accounts AP Acc")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "G/L Account List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Accounts';
                    Visible = true;
                }
                action("Purchase Invoices AP Acc")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Purchase Invoices";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Invoices';
                }
                action("Purchase Credit Memos AP Acc")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Purchase Credit Memos";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Purchase Credit Memos';
                }
                action("Posted Purchase Invoices AP Acc")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Posted Purchase Invoices";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Invoices';
                }
                action("Posted Purchase Credit Memos AP Acc")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                }
                action("Posted Purchase Receipts AP Acc")
                {
                    RunObject = Page "Posted Purchase Receipts";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Receipts';
                }
                action("Report Account Payable AP Acc")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "AVF_Object Report List";
                    ApplicationArea = Basic, Suite;
                    RunPageView = where("Group Report Filter" = const('AP'));
                    Caption = 'Report Account Payable';
                }
            }
            group("AP Payment")
            {
                Caption = 'AP Payment';
                //ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                Image = Payables;
                Visible = false;

                action("Vendors AP Pay")
                {
                    RunObject = Page "Vendor List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Vendors';
                }
                action("G/L Accounts AP Pay")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "G/L Account List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Accounts';
                    Visible = true;
                }
                action("Payment Journals AP Pay")
                {
                    //ToolTip = 'Setup AppName';
                    ApplicationArea = Basic, Suite;
                    RunObject = Page "General Journal Batches";
                    RunPageView = where("Template Type" = const(Payments), Recurring = const(false));
                    Caption = 'Payment Journals';
                }
                action("WHT Orders")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "AVF_WHT Lists (Open)";
                    ApplicationArea = Basic, Suite;
                }
                action("WHT Orders - Close")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "AVF_WHT Lists (Close)";
                    ApplicationArea = Basic, Suite;
                }
                action("Vendor Invoice No.")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "AVF_Update Vendor Invoice No.";
                    ApplicationArea = Basic, Suite;
                }
                action("Posted Purchase Credit Memos AP Pay")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Posted Purchase Credit Memos";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Credit Memos';
                }
                action("Posted Purchase Receipts AP Pay")
                {
                    RunObject = Page "Posted Purchase Receipts";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Posted Purchase Receipts';
                }
                action("Report Account Payable AP Pay")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "AVF_Object Report List";
                    ApplicationArea = Basic, Suite;
                    RunPageView = where("Group Report Filter" = const('AP'));
                    Caption = 'Report Account Payable';
                }
            }
            group("AR Account")
            {
                Caption = 'AR Account';
                //ToolTip = 'Overview and change system and application settings, and manage extensions and services';
                Image = Receivables;
                Visible = false;

                action("Customers AR")
                {
                    RunObject = Page "Customer List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customers';
                }
                action("G/L Accounts AR")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "G/L Account List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Accounts';
                    Visible = true;
                }
                action("Sales Invoices")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Sales Invoice List";
                    ApplicationArea = Basic, Suite;

                }
                action("Sales Credit Memos")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Sales Credit Memos";
                    ApplicationArea = Basic, Suite;

                }
                action("AR Billing")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "FNAR001_AR-Billing List";
                    ApplicationArea = Basic, Suite;

                }
                action("Receipt/Tax Invoices")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "AVF_Receipt/Tax Invoice List";
                    ApplicationArea = Basic, Suite;

                }
                /*action("Posted Receipt/Tax Invoices")
                {
                    Visible = false;
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "AVF_Posted Receipt/TaxInv.List";
                    ApplicationArea = Basic, Suite;

                }*/
                action("Cash Receipt Journals")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "General Journal Batches";
                    ApplicationArea = Basic, Suite;
                    RunPageView = where("Template Type" = const("Cash Receipts"), Recurring = const(false));

                }
                action("Posted Sales Invoices")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Posted Sales Invoices";
                    ApplicationArea = Basic, Suite;

                }
                action("Posted Sales Credit Memos")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Posted Sales Credit Memos";
                    ApplicationArea = Basic, Suite;

                }
                action("Customer Invoice No.")
                {
                    RunObject = page "AVF_Update Customer Inv. No.";
                    ApplicationArea = Basic, Suite;
                }
                action("Report Account Receivable")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "AVF_Object Report List";
                    ApplicationArea = Basic, Suite;
                    RunPageView = where("Group Report Filter" = const('AR'));

                }
            }
            group("Create FA")
            {
                Caption = 'Create FA';
                //ToolTip = 'XXX';
                Image = Setup;
                Visible = false;

                action("Fixed Assets Cre FA")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Fixed Asset List";
                    ApplicationArea = Basic, Suite;

                }
            }
            group("FA Account")
            {
                Caption = 'FA Account';
                //ToolTip = 'XXX';
                Image = Setup;
                Visible = false;

                action("Fixed Assets FA Acc")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Fixed Asset List";
                    ApplicationArea = Basic, Suite;

                }
                action("Fixed Assets G/L Journals")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "General Journal Batches";
                    ApplicationArea = Basic, Suite;
                    RunPageView = where("Template Type" = const(Assets), Recurring = const(false));

                }
                action("Fixed Assets Journals")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "FA Journal Batches";
                    ApplicationArea = Basic, Suite;
                    RunPageView = where(Recurring = const(false));

                }
                action("Fixed Assets Reclass. Journals")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "FA Reclass. Journal Batches";
                    ApplicationArea = Basic, Suite;

                }
                action("FA Posting Groups FA Acc")
                {
                    RunObject = Page "FA Posting Groups";
                    ApplicationArea = Basic, Suite;
                    Caption = 'FA Posting Groups';
                }

                action("FA Classes")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "FA Classes";
                    ApplicationArea = Basic, Suite;

                }
                action("FA Sub Classes")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "FA Subclasses";
                    ApplicationArea = Basic, Suite;

                }
                action("FA Locations")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "FA Locations";
                    ApplicationArea = Basic, Suite;

                }
                action("Depreciation Books")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Depreciation Book List";
                    ApplicationArea = Basic, Suite;

                }
                action("Report Fixed Asset")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "AVF_Object Report List";
                    ApplicationArea = Basic, Suite;
                    RunPageView = where("Group Report Filter" = const('Fixed Asset'));

                }
            }
            group("Budget Account")
            {
                Caption = 'Budget Account';
                Visible = true;

                action("G/L Accounts BG")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "G/L Account List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Accounts';
                    Visible = true;
                }
                action("G/L Budget Names")
                {
                    Caption = 'G/L Budget';
                    RunObject = page "G/L Budget Names";
                }
                action("G/L Budget Entries")
                {
                    RunObject = Page "G/L Budget Entries";
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Budget Entries';
                }
                action("Account Schedule BG")
                {
                    RunObject = Page "Account Schedule";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Account Schedule';
                }
                action("Analysis by Dimensions")
                {
                    RunObject = Page "Analysis by Dimensions";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Analysis by Dimensions';
                }
                action("Report Budget")
                {
                    Caption = 'Report Budget';
                    RunObject = Page "AVF_Object Report List";
                    ApplicationArea = Basic, Suite;
                    RunPageView = where("Group Report Filter" = const('Budget'));
                }
            }
            group("G/L Account")
            {
                Caption = 'G/L Account';
                //ToolTip = 'XXX';
                Image = Journals;
                Visible = false;

                action("G/L Accounts")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "G/L Account List";
                    ApplicationArea = Basic, Suite;

                }
                action("General Journals")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "General Journal Batches";
                    ApplicationArea = Basic, Suite;
                    RunPageView = where("Template Type" = const(General), Recurring = const(false));

                }
                action("Recurring General Journals")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "General Journal Batches";
                    ApplicationArea = Basic, Suite;
                    RunPageView = where("Template Type" = const(General), Recurring = const(true));

                }
                action("Account Schedule")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Account Schedule Names";
                    ApplicationArea = Basic, Suite;

                }
                action("Analysis View")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Analysis View List";
                    ApplicationArea = Basic, Suite;

                }
                action("Accounting Periods")
                {
                    RunObject = Page "Accounting Periods";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Accounting Periods';
                }
                action("General Ledger Setup GL")
                {
                    RunObject = Page "General Ledger Setup";
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Ledger Setup';
                }
                action("G/L Registers")
                {
                    RunObject = Page "G/L Registers";
                    ApplicationArea = Basic, Suite;
                    Caption = 'G/L Registers';
                }
            }
            group(Setup)
            {
                Caption = 'Setup';
                //ToolTip = 'XXX';
                Image = Setup;
                Visible = false;

                action(Users)
                {
                    RunObject = Page Users;
                    ApplicationArea = Basic, Suite;
                    Caption = 'Users';
                }
                action(Profiles)
                {
                    RunObject = Page "Profile List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Profiles';
                }
                action("Users Personalize")
                {
                    RunObject = Page "User Personalization List";
                    ApplicationArea = Basic, Suite;
                    Caption = 'Users Personalize';
                }
                action("General Ledger Setup")
                {
                    RunObject = Page "General Ledger Setup";
                    ApplicationArea = Basic, Suite;
                    Caption = 'General Ledger Setup';
                }
                action("Vendor Posting Groups")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Vendor Posting Groups";
                    ApplicationArea = Basic, Suite;

                }
                action("Customer Posting Groups")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Customer Posting Groups";
                    ApplicationArea = Basic, Suite;

                }
                action("Bank Account Posting Groups")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Bank Account Posting Groups";
                    ApplicationArea = Basic, Suite;

                }
                action("Inventory Posting Group")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Inventory Posting Groups";
                    ApplicationArea = Basic, Suite;

                }
                action("Gen. Business Posting Groups")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Gen. Business Posting Groups";
                    ApplicationArea = Basic, Suite;

                }
                action("Gen. Product Posting Groups")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Gen. Product Posting Groups";
                    ApplicationArea = Basic, Suite;

                }
                action("VAT Business Posting Groups")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "VAT Business Posting Groups";
                    ApplicationArea = Basic, Suite;

                }
                action("VAT Product Posting Groups")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "VAT Product Posting Groups";
                    ApplicationArea = Basic, Suite;

                }
                action("WHT Business Posting Group")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "AVF_WHT Business Posting Group";
                    ApplicationArea = Basic, Suite;

                }
                action("WHT Product Posting Group")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "AVF_WHT Product Posting Group";
                    ApplicationArea = Basic, Suite;

                }
                action("FA Posting Groups")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "FA Posting Groups";
                    ApplicationArea = Basic, Suite;

                }
                action("Unit of Measure")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Units of Measure";
                    ApplicationArea = Basic, Suite;

                }
                action("Locations List")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "Location List";
                    ApplicationArea = Basic, Suite;

                }
                /*action("No. Series")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "No. Series";
                    ApplicationArea = Basic, Suite;

                }
                action("Object Report List Setup")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "AVF_Object Report List Setup";
                    ApplicationArea = Basic, Suite;
                    //RunPageView = where("Group Report Filter" = const('Setup'));
                }*/
            }
            group("Report ALL")
            {
                Caption = 'Report ALL';
                //ToolTip = 'XXX';
                Image = Setup;
                Visible = true;

                action("Object Report List Setup")
                {
                    //ToolTip = 'Setup AppName';
                    RunObject = Page "AVF_Object Report List Setup";
                    ApplicationArea = Basic, Suite;
                    //RunPageView = where("Group Report Filter" = const('Setup'));
                }
            }
        }

    }

}