page 50100 InventoryByLocationFactbox
{
    ApplicationArea = All;
    Caption = 'InventoryByLocationFactbox';
    PageType = CardPart;
    SourceTable = "Item Ledger Entry";
    SourceTableTemporary = true;
    Editable = false;


    layout
    {
        area(Content)
        {
            field("Item No."; Rec."Item No.")
            {
                ApplicationArea = Planning;
                Visible = false;
            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = Planning;
                Visible = false;
            }
            field("Remaining Quantity"; Rec."Remaining Quantity")
            {
                ApplicationArea = Planning;
                ToolTip = 'Specifies the remaining quantity of the item in the specified location.';
            }

        }
    }
    var

        GlobalItemNo: Code[20];
        GlobalLocationCode: Code[20];

    procedure CalculateInventoryQuantity()
    var
        LocationCode: Code[20];
        RemainingQty: Decimal;
        ItemLedgerEntry: Record "Item Ledger Entry";
        EntryNo: Integer;
    begin
        Rec.DeleteAll();
        Rec.Reset();
        if Rec.FindLast() then
            EntryNo := Rec."Entry No." + 1
        else
            EntryNo := 1;
        ItemLedgerEntry.Reset();
        ItemLedgerEntry.SetCurrentKey("Location Code");
        ItemLedgerEntry.SetAscending("Location Code", true);
        ItemLedgerEntry.SetRange("Item No.", GlobalItemNo);
        ItemLedgerEntry.SetRange("Location Code", GlobalLocationCode);

        RemainingQty := 0;
        ItemLedgerEntry.CalcSums(Quantity);
        RemainingQty := ItemLedgerEntry.Quantity;

        Rec.Init();
        Rec."Entry No." := EntryNo;
        Rec."Item No." := GlobalItemNo;
        Rec."Location Code" := GlobalLocationCode;
        Rec."Remaining Quantity" := RemainingQty;
        Rec.Insert();
    end;

    internal procedure UpdateInventoryQuantity(ItemNo: Code[20]; LocationCode: Code[20])
    begin
        GlobalItemNo := ItemNo;
        GlobalLocationCode := LocationCode;
        CalculateInventoryQuantity();
    end;
}

