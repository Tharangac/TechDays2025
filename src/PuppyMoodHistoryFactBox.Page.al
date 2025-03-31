namespace DefaultPublisher.BCTechDays2025;

page 50105 "Puppy Mood History FactBox"
{
    PageType = ListPart;
    SourceTable = "Puppy Mood Log";
    Caption = 'Puppy Mood History';
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Log DateTime"; Rec."Log DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the mood was logged.';
                }
                field("Mood State"; Rec."Mood State")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy mood state.';
                    Style = Strong;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.SetCurrentKey("Puppy No.", "Log DateTime");
        Rec.Ascending(false);
    end;
}