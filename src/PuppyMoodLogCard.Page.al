namespace DefaultPublisher.BCTechDays2025;

page 50104 "Puppy Mood Log Card"
{
    PageType = Card;
    SourceTable = "Puppy Mood Log";
    Caption = 'Puppy Mood Log Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';
                field("Puppy No."; Rec."Puppy No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy number.';
                    ShowMandatory = true;
                }
                field("Puppy Name"; Rec."Puppy Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy name.';
                }
                field("Log DateTime"; Rec."Log DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies when the mood was logged.';
                }
                field("Mood State"; Rec."Mood State")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy mood state.';
                    ShowMandatory = true;
                    Style = Strong;
                }
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies any additional notes about the mood.';
                    MultiLine = true;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(PuppyCard)
            {
                ApplicationArea = All;
                Caption = 'Puppy Card';
                Image = Card;
                RunObject = Page "Puppy Card";
                RunPageLink = "No." = field("Puppy No.");
                ToolTip = 'View the puppy card.';
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec."Log DateTime" = 0DT then
            Rec."Log DateTime" := CurrentDateTime;
    end;
}