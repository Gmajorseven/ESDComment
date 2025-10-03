pageextension 50105 "Inventory By Location" extends "Planning Worksheet"
{
    layout
    {
        addfirst(FactBoxes)
        {
            part(InventoryFactbox; "InventorybyLocationFactbox")
            {
                ApplicationArea = All;
                SubPageLink = "Item No." = field("No."), "Location Code" = field("Location Code");
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        CurrPage.InventoryFactbox.Page.UpdateInventoryQuantity(Rec."No.", Rec."Location Code");
    end;
}
