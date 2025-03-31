namespace DefaultPublisher.BCTechDays2025;

page 50102 "Puppy Card"
{
    PageType = Card;
    SourceTable = Puppy;
    Caption = 'Puppy Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy number.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy name.';
                    ShowMandatory = true;
                }
                field(Breed; Rec.Breed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy breed.';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy birth date.';
                }
            }
        }
        area(FactBoxes)
        {
            part("Puppy Mood History"; "Puppy Mood History FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Puppy No." = field("No.");
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(MoodLog)
            {
                ApplicationArea = All;
                Caption = 'Mood Log';
                Image = History;
                RunObject = Page "Puppy Mood Log List";
                RunPageLink = "Puppy No." = field("No.");
                ToolTip = 'View mood log entries for this puppy.';
            }
            action(NewMoodLog)
            {
                ApplicationArea = All;
                Caption = 'New Mood Log Entry';
                Image = New;
                RunObject = Page "Puppy Mood Log Card";
                RunPageLink = "Puppy No." = field("No.");
                RunPageMode = Create;
                ToolTip = 'Create a new mood log entry for this puppy.';
            }
        }
    }
}