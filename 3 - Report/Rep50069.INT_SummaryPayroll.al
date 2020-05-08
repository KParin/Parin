report 50069 "INT_Summary Payroll"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/SummaryPayroll.rdl';
    Caption = 'Summary Payroll';

    dataset
    {
        dataitem("Dimension Value"; "Dimension Value")
        {
            DataItemTableView = SORTING("Dimension Code", Code) WHERE("Dimension Code" = filter('COST CENTER'));
            RequestFilterFields = Code;

            column(CostCenterCode; Code)
            {
            }
            column(SAL; SAL)
            {
            }
            column(ZS; ZS)
            {
            }
            column(ZW; ZW)
            {
            }
            column(SOC; SOC)
            {
            }
            column(PFC; PFC)
            {
            }
            column(PF; PF)
            {
            }
            column(TAX; TAX)
            {
            }
            column(ZE; ZE)
            {
            }
            column(ZA; ZA)
            {
            }
            column(TotalByCostCenter; TotalByCostCenter)
            {
            }


            trigger OnAfterGetRecord()
            begin
                Clear(SAL);
                Clear(ZS);
                Clear(ZW);
                Clear(SOC);
                Clear(PFC);
                Clear(PF);
                Clear(TAX);
                Clear(ZE);
                Clear(ZA);
                Clear(GenJnlLineTB);
                GenJnlLineTB.SetCurrentKey("Dimension Set ID");
                GenJnlLineTB.SetRange("Shortcut Dimension 1 Code", "Dimension Value".Code);
                GenJnlLineTB.SetRange("Journal Template Name", 'JV-PAYROLL');
                GenJnlLineTB.SetRange("Journal Batch Name", 'JV-JP');
                if GenJnlLineTB.Find('-') then begin
                    repeat
                        Clear(TotalByCostCenter);
                        Clear(DimensionSetEntryTB);
                        DimensionSetEntryTB.SetCurrentKey("Dimension Set ID", "Dimension Code");
                        DimensionSetEntryTB.SetRange("Dimension Set ID", GenJnlLineTB."Dimension Set ID");
                        DimensionSetEntryTB.SetRange("Dimension Code", 'PAYROLL TYPE');
                        if DimensionSetEntryTB.Find('-') then begin
                            repeat
                                if CopyStr(DimensionSetEntryTB."Dimension Value Code", 1, 3) = 'SAL' then begin
                                    SAL += GenJnlLineTB.Amount;
                                end;
                                if CopyStr(DimensionSetEntryTB."Dimension Value Code", 1, 2) = 'ZS' then begin
                                    ZS += GenJnlLineTB.Amount;
                                end;
                                if CopyStr(DimensionSetEntryTB."Dimension Value Code", 1, 2) = 'ZA' then begin
                                    ZA += GenJnlLineTB.Amount;
                                end;
                                if CopyStr(DimensionSetEntryTB."Dimension Value Code", 1, 2) = 'ZW' then begin
                                    ZW += GenJnlLineTB.Amount;
                                end;
                                if CopyStr(DimensionSetEntryTB."Dimension Value Code", 1, 3) = 'SOC' then begin
                                    SOC += GenJnlLineTB.Amount;
                                end;
                                if CopyStr(DimensionSetEntryTB."Dimension Value Code", 1, 3) = 'PFC' then begin
                                    PFC += GenJnlLineTB.Amount;
                                end else
                                    if CopyStr(DimensionSetEntryTB."Dimension Value Code", 1, 2) = 'PF' then begin
                                        PF += GenJnlLineTB.Amount;
                                    end;
                                if CopyStr(DimensionSetEntryTB."Dimension Value Code", 1, 3) = 'TAX' then begin
                                    TAX += GenJnlLineTB.Amount;
                                end;
                                if CopyStr(DimensionSetEntryTB."Dimension Value Code", 1, 2) = 'ZE' then begin
                                    ZE += GenJnlLineTB.Amount;
                                end;

                                TotalByCostCenter := SAL + ZS + ZA + ZW - SOC + PF + TAX + ZE;


                            until DimensionSetEntryTB.Next = 0;
                        end;
                    until GenJnlLineTB.Next = 0;



                end;
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
        DimensionSetEntryTB: Record "Dimension Set Entry";
        //GLEntryTB: Record "G/L Entry";
        GenJnlLineTB: Record "Gen. Journal Line";
        SAL: Decimal;

        ZS: Decimal;

        ZW: Decimal;

        SOC: Decimal;

        PFC: Decimal;

        PF: Decimal;

        TAX: Decimal;

        ZE: Decimal;
        ZA: Decimal;

        TotalByCostCenter: Decimal;
        TotalByType: Decimal;
}