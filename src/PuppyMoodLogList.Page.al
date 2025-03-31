namespace DefaultPublisher.BCTechDays2025;

page 50103 "Puppy Mood Log List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Puppy Mood Log";
    CardPageId = "Puppy Mood Log Card";
    Editable = false;
    Caption = 'Puppy Mood Logs';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the entry number.';
                }
                field("Puppy No."; Rec."Puppy No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy number.';
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
                    Style = Strong;
                }
                field(Notes; Rec.Notes)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies any additional notes about the mood.';
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
}