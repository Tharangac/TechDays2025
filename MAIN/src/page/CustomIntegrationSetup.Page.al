page 50100 "CustomIntegrationSetup_TD"
{
    ApplicationArea = All;
    Caption = 'Custom Integration Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'Setup';
    SourceTable = "CustomIntegrationSetup_TD";
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Maximo)
            {
                Caption = 'Maximo';
                field("Maximo Item Template"; Rec."Integration Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Maximo Default Item Template field.';
                }
            }
        }
    }
    trigger OnOpenPage();
    begin
        Rec.InsertIfNotExists();
    end;
}