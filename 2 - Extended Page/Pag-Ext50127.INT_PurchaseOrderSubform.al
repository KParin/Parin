pageextension 50127 "INT_Purchase Order Subform" extends "Purchase Order Subform"
{
    layout
    {
        modify("Line No.")
        {
            Visible = true;
        }
        modify("FNPO001_Ref. Line No.")
        {
            Visible = false;
        }
        modify("FNPO001_Ref. Doc. No.")
        {
            Visible = false;
        }
        modify("FNGN004_G/L_Temp")
        {
            Visible = false;
        }
        modify("AVF_VAT Bus. Posting Group")
        {
            Visible = false;
        }
        modify("AVF_Gen. Bus. Posting Group")
        {
            Visible = false;
        }
        modify("AVF_WHT Business Posting Group")
        {
            Visible = false;
        }
        moveafter("No."; Description)
        modify("AVF_Gen. Prod. Posting Group")
        {
            Width = 10;
        }
        moveafter(Description; "AVF_Gen. Prod. Posting Group")
        modify("Location Code")
        {
            Visible = false;
        }
        modify("Bin Code")
        {
            Visible = false;
        }
        modify("Reserved Quantity")
        {
            Visible = false;
        }
        modify("Tax Area Code")
        {
            Visible = false;
        }
        modify("Tax Group Code")
        {
            Visible = false;
        }
        modify("Qty. to Assign")
        {
            Visible = false;
        }
        modify("Qty. Assigned")
        {
            Visible = false;
        }
        modify("Promised Receipt Date")
        {
            Visible = false;
        }
        modify("Planned Receipt Date")
        {
            Visible = false;
        }
        modify("Expected Receipt Date")
        {
            Visible = false;
        }
        /*modify(ShortcutDimCode5)
        {
            Visible = false;
        }*/
        modify("Shortcut Dimension 2 Code")
        {
            Visible = false;
        }
        modify(ShortcutDimCode4)
        {
            Visible = false;
        }
        addafter(ShortcutDimCode3)
        {
            field("INT_Allow Invoice Disc.21024"; "Allow Invoice Disc.")
            {
                ApplicationArea = All;
            }
        }

        movebefore(ShortcutDimCode3; ShortcutDimCode5)
        /*addafter("AVF_WHT Product Posting Group")
        {
            field("INT_WHT Absorb Base"; "AVF_WHT Absorb Base")
            {
                ApplicationArea = All;
            }
        }
    }*/
        /*addafter("AVF_WHT Product Posting Group")
        {
            field("INT_WHT Absorb Base"; "AVF_WHT Absorb Base")
            {
                ApplicationArea = All;
            }
        }*/
        //AVWIINT.011 26/11/2019 
        //Comment Code for Hide Field
        /*addafter("Direct Unit Cost")
        {
            field("INT_Line Discount Amount"; "Line Discount Amount")
            {
                ApplicationArea = All;
                Width = 12;
            }
            field("INT_Line Discount %"; "Line Discount %")
            {
                ApplicationArea = All;
                Width = 13;
            }
        }*/

        modify(AmountBeforeDiscount)
        {
            Visible = false;
        }
        movefirst(Control37; "Total Amount Excl. VAT")
        //movebefore("Direct Unit Cost","AVF_WHT Absorb Base")

        addAfter("Direct Unit Cost")
        {
            field("INT_AVF_WHT Absorb Base"; "AVF_WHT Absorb Base")
            {
                ApplicationArea = All;
            }
        }
        modify(ShortcutDimCode7)
        {
            Visible = false;
        }


    }
    actions
    {
    }
}
