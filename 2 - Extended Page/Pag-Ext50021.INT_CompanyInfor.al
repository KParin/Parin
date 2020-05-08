pageextension 50021 "INT_Company Infor" extends "Company Information"
{
    layout
    {
        addafter("VAT Registration No.")
        {
            field("INT_Branch"; INT_Branch)
            {
                Editable = true;
            }
        }
        addafter("Phone No.")
        {
            field("INT_Phone Purchase"; "INT_Phone Purchase")
            {
                Editable = true;
            }
        }
        modify(City)
        {
            Visible = false;
        }
        /*
        modify("Post Code")
        {
            Visible = true;
        }
        */
        modify("Country/Region Code")
        {
            Visible = false;
        }

    }

    actions
    {
        // Add changes to page actions here
    }


}