pageextension 50160 "INT_DimensionValue" extends "Dimension Values"
{
    layout
    {
        addafter(Name)
        {
            field("INT_Name 2"; "INT_Name 2")
            {
                Caption = 'Name 2';
            }
            field("INT_GLAccoutNo"; INT_GLAccoutNo)
            {
                Caption = 'G/L Accout No.';
            }
            field("INT_GLAccoutNo2"; INT_GLAccoutNo2)
            {
                Caption = 'G/L Accout No. 2';
            }
        }
    }
}