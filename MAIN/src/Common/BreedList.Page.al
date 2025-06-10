namespace BCTechDays.PuppyMgt.Common;

page 50108 "Breed List_TD"
{
    ApplicationArea = All;
    Caption = 'Breeds';
    PageType = List;
    SourceTable = Breed_TD;
    UsageCategory = Lists;
    InherentEntitlements = X;
    InherentPermissions = X;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.', Comment = '%';
                }
            }
        }
    }
}
