pageextension 50131 "INT_Purchase Order" extends "Purchase Order"
{
    layout
    {
        modify("Quote No.")
        {
            Editable = true;
            Enabled = true;
        }
        modify("Assigned User ID")
        {
            Editable = false;
        }
        addafter("FNGN011_Posting No. Series")
        {
            field("INT_Approve Name"; "INT_Approve Name")
            {
                Editable = true;
            }
        }
        /*addfirst(General)
        {
            field("INT_No.76914"; "No.")
            {
                ApplicationArea = All;
            }
        }*/
        modify("No.")
        {
            ApplicationArea = All;
            Visible = true;
        }
        addafter("Due Date")
        {
            field("INT_Posting Description29525"; "Posting Description")
            {
                ApplicationArea = All;
            }
        }
        modify("Buy-from City")
        {
            Visible = false;
        }
        modify("Buy-from Post Code")
        {
            Visible = false;
        }
        modify("Buy-from Country/Region Code")
        {
            Visible = false;
        }
        modify("Buy-from Contact No.")
        {
            Visible = false;
        }
        modify("Posting Date")
        {
            Visible = false;
        }
        modify("FNGN011_Purchase Status")
        {
            Visible = false;
        }


        modify("Purchaser Code")
        {
            Visible = false;
        }
        modify("No. of Archived Versions")
        {
            Visible = false;
        }
        modify("Vendor Shipment No.")
        {
            Visible = false;
        }
        modify("Order Address Code")
        {
            Visible = false;
        }
        modify("Responsibility Center")
        {
            Visible = false;
        }
        addafter("Buy-from Vendor Name")
        {
            field("INT_Buy-from Vendor Name 2"; "Buy-from Vendor Name 2")
            {
                ApplicationArea = all;
                //Editable = false;
            }
        }
        moveafter("Buy-from Contact"; "AVF_VAT Registration No.")
        moveafter("AVF_VAT Registration No."; "AVF_Vendor Branch No.")
        modify("Due Date")
        {
            Visible = false;
        }
        modify("Order Date")
        {
            Visible = false;
        }
        moveafter("Order Date"; "FNGN011_Posting No. Series")
        modify("Prepayment %")
        {
            Visible = false;
        }
        modify("Compress Prepayment")
        {
            Visible = false;
        }
        modify("Prepmt. Payment Terms Code")
        {
            Visible = false;
        }
        modify("Prepayment Due Date")
        {
            Visible = false;
        }
        modify("Prepmt. Payment Discount %")
        {
            Visible = false;
        }
        modify("Prepmt. Pmt. Discount Date")
        {
            Visible = false;
        }
        modify("Vendor Cr. Memo No.")
        {
            Visible = false;
        }
        modify("Transaction Specification")
        {
            Visible = false;
        }
        modify("Transaction Type")
        {
            Visible = false;
        }
        modify("Transport Method")
        {
            Visible = false;
        }
        modify("Entry Point")
        {
            Visible = false;
        }
        modify("Area")
        {
            Visible = false;
        }
        modify("Ship-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Pay-to Country/Region Code")
        {
            Visible = false;
        }
        modify("Pay-to Contact No.")
        {
            Visible = false;
        }
        modify("Tax Liable")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Shipment Method Code")
        {
            Visible = false;
        }
        modify("Creditor No.")
        {
            Visible = false;
        }
        modify("Payment Reference")
        {
            Visible = false;
        }
        modify("On Hold")
        {
            Visible = false;
        }
        modify("Inbound Whse. Handling Time")
        {
            Visible = false;
        }
        modify("Lead Time Calculation")
        {
            Visible = false;
        }
        modify("Promised Receipt Date")
        {
            Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify("Pmt. Discount Date")
        {
            Visible = false;
        }
        moveafter("Posting Description"; "Quote No.")
        moveafter("Quote No."; "Vendor Order No.")
        moveafter("Document Date"; "Requested Receipt Date")
        moveafter("AVF_Vendor Branch No."; "Shortcut Dimension 1 Code")

        modify("FNGN011_Posting No. Series")
        {
            Visible = false;
        }

        modify(Prepayment)
        {
            Visible = false;
        }
        modify("Foreign Trade")
        {
            Visible = false;
        }
        modify("Expected Receipt Date")
        {
            Visible = false;
        }
        modify("Prices Including VAT")
        {
            Visible = false;
        }
        modify("Payment Discount %")
        {
            Visible = false;
        }
        moveafter("Posting Description"; "Quote No.")
        moveafter("Quote No."; "Vendor Order No.")
        modify("Pay-to City")
        {
            Visible = false;
        }
        modify("Pay-to Post Code")
        {
            Visible = false;
        }
        modify("Ship-to City")
        {
            Visible = false;
        }
        modify("Ship-to Post Code")
        {
            Visible = false;
        }
        addafter("Currency Code")
        {
            field("INT_Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = all;
                Caption = 'Gen. Bus. Posting Group';
            }
        }
        addafter("VAT Bus. Posting Group")
        {
            field("INT_AVF_WHT Business Posting Group"; "AVF_WHT Business Posting Group")
            {
                ApplicationArea = all;
                Caption = 'WHT Business Posting Group';
            }
        }
        movebefore("Payment Terms Code"; "Currency Code")
        movebefore("Vendor Invoice No."; "Quote No.")
        moveafter("Quote No."; "Vendor Order No.")
        modify("Shortcut Dimension 1 Code")
        {
            Visible = false;
        }
        modify("Payment Method Code")
        {
            Visible = false;
        }

    }

    actions
    {
        modify(Post)
        {
            trigger OnAfterAction()
            var
                PurchRcptH: Record "Purch. Rcpt. Header";
                DocNo: code[20];
                PosPurchReceipt: Page "Posted Purchase Receipt";
            begin
                Clear(DocNo);
                DocNo := Rec."No.";
                Clear(PurchRcptH);
                PurchRcptH.SetRange("Order No.", DocNo);
                if PurchRcptH.FindFirst then begin
                    PosPurchReceipt.SetRecord(PurchRcptH);
                    PosPurchReceipt.SetTableView(PurchRcptH);
                    PosPurchReceipt.Run();
                end;
            end;
        }
        modify("Create Inventor&y Put-away/Pick")
        {
            Promoted = false;
        }
        modify("FNPO001_Copy PR Line")
        {
            Promoted = false;
        }
        modify("Post and &Print")
        {
            Promoted = false;
        }
        modify(Approvals)
        {
            Promoted = false;
        }
        modify(SeeFlows)
        {
            Promoted = false;
        }
        modify(CancelApprovalRequest)
        {
            Promoted = false;
        }
        modify(SendApprovalRequest)
        {
            Promoted = false;
        }
        modify(SendCustom)
        {
            Promoted = false;
        }
        modify("Request Approval")
        {
            Visible = false;
        }
        modify(Action17)
        {
            Visible = false;
        }

        modify(Print)
        {
            Visible = false;
        }

        modify("P&osting")
        {
            Visible = false;
        }
        modify(Warehouse)
        {
            Visible = false;
        }
        modify("O&rder")
        {
            Visible = false;
        }
        modify(Documents)
        {
            Visible = false;
        }
        modify("F&unctions")
        {
            Visible = false;
        }
        modify(Release)
        {
            trigger OnBeforeAction()
            begin
                Clear(purchLineTB);
                purchLineTB.SetCurrentKey("Document No.");
                purchLineTB.SetRange("Document No.", "No.");
                purchLineTB.SetFilter("No.", '<>%1', '');
                if purchLineTB.FindSet() then begin
                    repeat
                        Clear(dimSetEntry);
                        dimSetEntry.SetCurrentKey("Dimension Set ID");
                        dimSetEntry.SetRange("Dimension Set ID", purchLineTB."Dimension Set ID");
                        dimSetEntry.SetFilter("Dimension Code", 'COST CENTER');
                        if Not dimSetEntry.FindFirst() then
                            Error('Line No. %1 Cost center must not be blank', purchLineTB."Line No.");

                        Clear(dimSetEntry);
                        dimSetEntry.SetCurrentKey("Dimension Set ID");
                        dimSetEntry.SetRange("Dimension Set ID", purchLineTB."Dimension Set ID");
                        dimSetEntry.SetFilter("Dimension Code", 'APPROVE PR PERSON');
                        if Not dimSetEntry.FindFirst() then
                            Error('Line No. %1 Approve pr person must not be blank', purchLineTB."Line No.");

                        if purchLineTB."No." = '0310099' then begin
                            Clear(dimSetEntry);
                            dimSetEntry.SetCurrentKey("Dimension Set ID");
                            dimSetEntry.SetRange("Dimension Set ID", purchLineTB."Dimension Set ID");
                            dimSetEntry.SetFilter("Dimension Code", 'BUDGET CODE NO.');
                            if Not dimSetEntry.FindFirst() then
                                Error('Line No. %1 Budget code no. must not be blank', purchLineTB."Line No.");
                        end;


                    until purchLineTB.Next() = 0;
                end;
            end;
        }



    }

    trigger OnAfterGetRecord()
    begin
        "Posting No. Series" := 'AP_PI_AO';
    end;

    var
        purchLineTB: Record "Purchase Line";
        dimSetEntry: Record "Dimension Set Entry";
}
