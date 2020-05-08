report 50056 "INT_Data For MRD"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/DataForMRD.rdl';
    Caption = 'Data for MRD';

    dataset
    {
        dataitem("G/L Account Filter"; "G/L Account")
        {
            RequestFilterFields = "No.", "Account Type", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
            trigger OnPreDataItem()
            begin
                "G/L Account Filter".SetRange("No.", '');
                StartMonthFilter := CopyStr("G/L Account Filter".GetFilter("Date Filter"), 4, 2);
                EndMonthFilter := CopyStr("G/L Account Filter".GetFilter("Date Filter"), 14, 2);
                //Message("G/L Account Filter".GetFilter("Date Filter"));
                //Date2DMY("G/L Account Filter".GetFilter("Date Filter"),2)
                evaluate(GLDateFilterStart, StartMonthFilter);
                evaluate(GLDateFilter, EndMonthFilter);
            end;
        }
        dataitem(Integer; Integer)
        {

            //DataItemTableView = SORTING(Number) WHERE(Number = filter(1 .. 12));
            DataItemTableView = SORTING(Number);

            column(CountInteger; CountInteger)
            {
            }
            column(GLDateFilter; GLDateFilter)
            {
            }
            column(GLDateFilterStart; GLDateFilterStart)
            {
            }

            dataitem("Dimension Value"; "Dimension Value")
            {
                DataItemTableView = SORTING(code);
                RequestFilterFields = Code;
                column(DimValueCode; Code)
                {
                }


                dataitem("G/L Account"; "G/L Account")
                {
                    DataItemTableView = SORTING("No.") WHERE("Account Type" = CONST(Posting));
                    DataItemLinkReference = "Dimension Value";
                    //DataItemLink = "Global Dimension 1 Code" = FIELD(Code);
                    //RequestFilterFields = "No.", "Account Type", "Date Filter", "Global Dimension 1 Filter", "Global Dimension 2 Filter";
                    column(GLAccNo_; "No.")
                    {
                    }
                    column(GLAccName; Name)
                    {
                    }
                    column(NetChangeShow; NetChangeShow)
                    {
                    }
                    column(BudgetAmount; BudgetAmount)
                    {
                    }
                    column(Variance; Variance)
                    {
                    }
                    column(PercentVariance; PercentVariance)
                    {
                    }

                    trigger OnPreDataItem()
                    begin
                        "G/L Account".SetFilter("No.", GLNoFilter);
                    end;

                    trigger OnAfterGetRecord()
                    begin
                        //SetRange("No.", "G/L Account Filter"."No.");
                        "G/L Account".SetFilter("No.", GLNoFilter);
                        "G/L Account".SetFilter("Date Filter", FORMAT(DMY2DATE(1, Integer.Number, DATE2DMY(WorkDate, 3))) + '..' + FORMAT(CALCDATE('<CM>', DMY2DATE(1, Integer.Number, DATE2DMY(WorkDate, 3)))));
                        "G/L Account".SetFilter("Global Dimension 1 Filter", "Dimension Value".Code);

                        "G/L Account".CalcFields("G/L Account"."Net Change", "G/L Account"."Budgeted Amount");
                        NetChangeShow := "G/L Account"."Net Change";
                        BudgetAmount := "G/L Account"."Budgeted Amount";
                        Variance := BudgetAmount - NetChangeShow;
                        if BudgetAmount <> 0 then
                            PercentVariance := (Variance * 100) / BudgetAmount
                        else
                            PercentVariance := 0;
                    end;

                }

                trigger OnPreDataItem()
                begin
                    SetRange("Dimension Value"."Dimension Code", 'COST CENTER');
                end;
            }

            trigger OnPreDataItem()
            begin

                SetRange(Number, 1, GLDateFilter);

            end;

            trigger OnAfterGetRecord()
            begin
                CountInteger += 1;
                Clear(NetChangeShow);
                Clear(BudgetAmount);

                //if (CountInteger < GLDateFilterStart) then
                //    CurrReport.Skip();

            end;

        }
    }

    requestpage
    {
        SaveValues = true;
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
        if "G/L Account Filter".GetFilter("No.") <> '' then
            GLNoFilter := "G/L Account Filter".GetFilter("No.");
    end;

    var
        CountInteger: Integer;
        DimensionValue: Record "Dimension Value";
        NetChangeShow: Decimal;
        NetChangeFilterDate: Decimal;
        BudgetAmount: Decimal;
        Variance: Decimal;
        PercentVariance: Decimal;
        AmountJAN: Decimal;
        AmountFEB: Decimal;
        AmountMAR: Decimal;
        AmountAPR: Decimal;
        AmountMAY: Decimal;
        AmountJUN: Decimal;
        AmountJUL: Decimal;
        AmountAUG: Decimal;
        AmountSEP: Decimal;
        AmountOCT: Decimal;
        AmountNOV: Decimal;
        AmountDEC: Decimal;
        AmountTotal: Decimal;
        GLDateFilter: Integer;
        GLDateFilterStart: Integer;
        GLNoFilter: code[250];
        EndMonthFilter: text[2];
        StartMonthFilter: text[2];

}