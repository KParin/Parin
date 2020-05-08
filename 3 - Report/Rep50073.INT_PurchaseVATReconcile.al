report 50073 "INT_Purchase VAT Reconcile"
{
    // version AVFTH1.0

    // Microsoft Dynamic NAV
    // ----------------------------------------
    // Project: Localization TH
    // AVNVKSTD : Natee Visedkajee
    // 
    // No.   Date         Sign       Description
    // --------------------------------------------------
    // 001   12.07.2012   AVNVKSTD   Localization.
    DefaultLayout = RDLC;
    RDLCLayout = 'Rdlc/Purchase VAT Reconcile.rdl';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    Caption = 'Purchase VAT Reconcile 2';

    dataset
    {
        dataitem("VAT Entry"; "VAT Entry")
        {
            DataItemTableView = SORTING("Posting Date", Type, "Document No.") WHERE(Type = FILTER(Purchase), Base = FILTER(<> 0), Amount = FILTER(<> 0));
            column(USERID; USERID)
            {
            }
            column(CompanyName1; Company.Name + Company."Name 2")
            {
            }
            column(CompanyName2; Company.Name + Company."Name 2")
            {
            }
            column(VATRegistrationNo; Company."VAT Registration No.")
            {
            }
            column(Running; Running)
            {
            }
            column(PostingDate_VATEntry; Format("VAT Entry"."Posting Date", 0, '<Day,2>/<Month,2>/<Year4>'))
            {
            }
            column(A; "VAT Entry"."Document Type")
            {
            }
            column(DocumentNo_VATEntry; "VAT Entry"."Document No.")
            {
            }
            column(VenName; PAYTO)
            {
            }
            column(VAT; VATPostingSetup."VAT %")
            {
            }
            column(FBase; FBase)
            {
            }
            column(FAmount; FAmount)
            {
            }
            column(FAMT; FAMT)
            {
            }
            column(TotalBaseAMT; BaseAMT)
            {
            }
            column(TotalVATAMT; VATAMT)
            {
            }
            column(Base_VATEntry; "VAT Entry".Base)
            {
            }
            column(Amount_VATEntry; "VAT Entry".Amount)
            {
            }
            column(DatePrint; FORMAT(TODAY, 0, 1) + ' ' + FORMAT(TIME, 0, '<Hours12>:<Minutes,2>:<Second,2> <AM/PM>'))
            {
            }
            column(Asofdate; 'As Of ' + FORMAT(DATE2DMY(Asofdate, 1)) + ' ' + Month + ' ' + textyear)
            {
            }
            column(AVShowBranchCode; AVShowBranchCode)
            {
            }

            trigger OnAfterGetRecord();
            begin
                //Month := Thai.MonthWords('E',DATE2DMY("From Date",2));
                //Year := DATE2DMY("From Date",3);
                //textyear := FORMAT(Year);

                BaseAMT += Base;
                VATAMT += Amount;

                if OldDocNo <> "Document No." then begin
                    Running += 1;
                end;
                OldDocNo := "Document No.";

                CLEAR(VATPostingSetup);
                VATPostingSetup.SetRange("VAT Bus. Posting Group", "VAT Bus. Posting Group");
                VATPostingSetup.SetRange("VAT Prod. Posting Group", "VAT Prod. Posting Group");
                if VATPostingSetup.FindFirst then;

                CLEAR(PAYTO);
                if ("Document Type" = "Document Type"::Payment) or ("Document Type" = "Document Type"::" ") or
                    ("Document Type" = "Document Type"::Refund) then begin
                    //CLEAR(Ven);
                    //Ven.SetRange("No.","Bill-to/Pay-to No.");
                    //Ven.NEXT;
                    //PAYTO := Ven.Name + ' ' + Ven."Name 2";
                    CLEAR(Ven);
                    if Ven.GET("Bill-to/Pay-to No.") then
                        PAYTO := Ven.Name + ' ' + Ven."Name 2";

                    //C-AVANCOK.002   09.03.2010
                end
                else
                    if ("Document Type" = "Document Type"::Invoice) then begin
                        CLEAR(PurchInvHead);
                        PurchInvHead.SetRange("No.", "Document No.");
                        if PurchInvHead.FIND('-') then
                            PAYTO := PurchInvHead."Buy-from Vendor Name" + PurchInvHead."Buy-from Vendor Name 2"
                        else begin
                            //CLEAR(Ven);
                            //Ven.SetRange("No.","Bill-to/Pay-to No.");
                            //Ven.NEXT;
                            //PAYTO := Ven.Name + ' ' + Ven."Name 2";
                            CLEAR(Ven);
                            if Ven.GET("Bill-to/Pay-to No.") then
                                PAYTO := Ven.Name + ' ' + Ven."Name 2";
                        end;
                        //C-AVANCOK.002   09.03.2010
                    end
                    else
                        if ("Document Type" = "Document Type"::"Credit Memo") then begin
                            CLEAR(PurchCrHead);
                            PurchCrHead.SetRange("No.", "Document No.");
                            if PurchCrHead.FIND('-') then
                                PAYTO := PurchCrHead."Buy-from Vendor Name" + PurchCrHead."Buy-from Vendor Name 2"
                            else begin
                                //CLEAR(Ven);
                                //Ven.SetRange("No.","Bill-to/Pay-to No.");
                                //Ven.NEXT;
                                //PAYTO := Ven.Name + ' ' + Ven."Name 2";
                                CLEAR(Ven);
                                if Ven.GET("Bill-to/Pay-to No.") then
                                    PAYTO := Ven.Name + ' ' + Ven."Name 2";
                            end;
                        end;
                //ELSE
                //  begin
                //    if "VAT Entry"."Bill-to/Pay-to No." = '' then
                //      repeat
                //        if "VAT Entry".Description <> '' then
                //        PAYTO := "VAT Entry".Description;
                //      UNTIL "VAT Entry".NEXT = 0;
                //  end;

                //AVANCOK.002   05.10.2009
                if PAYTO = '' then
                    PAYTO := "VAT Entry".AVF_Description;
                //C-AVANCOK.002   05.10.2009
            end;

            trigger OnPreDataItem();
            begin
                UpdateIntRefNo;
                Running := 0;
                Company.GET;
                CLEAR(BaseAMT);
                CLEAR(VATAMT);

                //SETFILTER("Posting Date",'%1..%2',"From Date","To Date");
                SETFILTER("Posting Date", '..%1', Asofdate);
                Month := Thai.MonthWords('E', DATE2DMY(Asofdate, 2));
                Year := DATE2DMY(Asofdate, 3);
                textyear := FORMAT(Year);


                if "VAT BUS. POSTING G TB".Code <> '' then begin
                    SETFILTER("VAT Bus. Posting Group", "VAT BUS. POSTING G TB".Code);
                    CLEAR("VAT BUS. POSTING G TB1");
                    "VAT BUS. POSTING G TB1".SetCurrentKey("VAT BUS. POSTING G TB1".Code);
                    "VAT BUS. POSTING G TB1".SetRange("VAT BUS. POSTING G TB1".Code, "VAT BUS. POSTING G TB".Code);
                    if "VAT BUS. POSTING G TB1".FindFirst then
                        AVShowBranchName := "VAT BUS. POSTING G TB1".Description;
                    AVShowBranchCode := "VAT BUS. POSTING G TB".Code + ' - ' + "VAT BUS. POSTING G TB1".Description;

                end
                else begin
                    AVShowBranchName := 'ALL';
                    AVShowBranchCode := 'ALL';
                end;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("Option")
                {
                    Caption = 'Option';
                    field("""VAT BUS. POSTING G TB"".Code"; "VAT BUS. POSTING G TB".Code)
                    {
                        ApplicationArea = All;
                        Caption = 'VAT Bus. Posting Group';
                        TableRelation = "VAT Business Posting Group";
                    }
                    field(Asofdate; Asofdate)
                    {
                        ApplicationArea = All;
                        Caption = 'As of Date';
                    }
                    grid(Control3)
                    {
                        GridLayout = Rows;
                        Visible = false;
                        group(Control4)
                        {
                            //The GridLayout property is only supported on controls of type Grid
                            //GridLayout = Columns;
                            field(Year; Year)
                            {
                                ApplicationArea = All;
                                Caption = 'Year';

                                trigger OnValidate();
                                begin
                                    Month := Thai.MonthWords('T', Period);
                                    MonthEng := Thai.MonthWords('E', Period);
                                    if Month <> '' then begin
                                        "From Date" := DMY2DATE(1, Period, Year);
                                        "To Date" := CALCDATE('1M', "From Date") - 1;
                                    end;
                                end;
                            }
                            field(Period; Period)
                            {
                                ApplicationArea = All;
                                Caption = 'Period';

                                trigger OnValidate();
                                begin
                                    Month := Thai.MonthWords('T', Period);
                                    MonthEng := Thai.MonthWords('E', Period);
                                    if Month <> '' then begin
                                        "From Date" := DMY2DATE(1, Period, Year);
                                        "To Date" := CALCDATE('1M', "From Date") - 1;
                                    end;
                                end;
                            }
                            field(MonthEng; MonthEng)
                            {
                                ApplicationArea = All;
                                Editable = false;
                            }
                            field(Month; Month)
                            {
                                ApplicationArea = All;
                                Visible = false;
                            }
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            Period := DATE2DMY(TODAY, 2);
            Year := DATE2DMY(TODAY, 3);
            Month := Thai.MonthWords('T', Period);
            MonthEng := Thai.MonthWords('E', Period);
            if Month <> '' then begin
                "From Date" := DMY2DATE(1, Period, Year);
                "To Date" := CALCDATE('1M', "From Date") - 1;
            end;
        end;
    }

    labels
    {
    }

    var
        PAYTO: Text[120];
        Ven: Record Vendor;
        Tbase: Decimal;
        Running: Integer;
        Vendor: Record Vendor;
        Company: Record "Company Information";
        Thai: Codeunit AVF_Thai;
        "From Date": Date;
        "To Date": Date;
        CellColumn: Integer;
        CellRow: Integer;
        TempText: Text[250];
        VATPostingSetup: Record "VAT Posting Setup";
        FDATE: Text[30];
        TDATE: Text[30];
        BaseAMT: Decimal;
        VATAMT: Decimal;
        InvDate: Text[30];
        FBase: Text[100];
        FAmount: Text[100];
        FAMT: Text[100];
        Year: Integer;
        Period: Integer;
        Month: Text[100];
        Text002: Label '"Period should be in 1-12. Please enter valid period. "';
        MonthEng: Text[100];
        OldDocNo: Code[20];
        textyear: Text[10];
        "VAT BUS. POSTING G TB": Record "VAT Business Posting Group";
        "VAT BUS. POSTING G TB1": Record "VAT Business Posting Group";
        AVShowBranchName: Text[60];
        AVShowBranchCode: Code[100];
        PurchInvHead: Record "Purch. Inv. Header";
        PurchCrHead: Record "Purch. Cr. Memo Hdr.";
        Asofdate: Date;

    procedure UpdateIntRefNo();
    var
        VATEntry: Record "VAT Entry";
        InvDate: Text[30];
        i: Integer;
    begin
        VATEntry.SetRange(Type, VATEntry.Type::Purchase);
        VATEntry.SETFILTER(Amount, '<>0');
        VATEntry.SETFILTER(Base, '<>0');
        VATEntry.SETFILTER("External Document No.", '<>''''');
        VATEntry.SETFILTER("Internal Ref. No.", '=''''');
        VATEntry.NEXT;

        for i := 1 to VATEntry.COUNT do begin
            CODEUNIT.RUN(CODEUNIT::"AVF_Update Vendor Invoice No.", VATEntry);
            //VATEntry."Internal Ref. No." := InvDate;
            //VATEntry.MODifY;
            VATEntry.NEXT;
        end;
    end;
}

