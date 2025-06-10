namespace BCTechDays.PuppyMgt.Common;

page 50100 "PuppyMgtSetup_TD"
{
    ApplicationArea = All;
    Caption = 'Puppy Management Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    PromotedActionCategories = 'Setup';
    SourceTable = PuppyMgtSetup_TD;
    UsageCategory = Administration;
    InherentEntitlements = X;
    InherentPermissions = X;

    layout
    {
        area(content)
        {

            group(NoSeries)
            {
                Caption = 'No. Series';

                field("Puppy No. Series"; Rec."Puppy No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Puppy No. Series field.';
                }
                field("Appointment No. Series"; Rec."Appointment No. Series")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Appointment No. Series field.';
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.InsertIfNotExists();
    end;
}