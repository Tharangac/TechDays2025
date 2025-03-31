namespace DefaultPublisher.BCTechDays2025;

page 50101 "Puppy List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Puppy;
    CardPageId = "Puppy Card";
    Editable = false;
    Caption = 'Puppies';
    InherentPermissions = X;
    InherentEntitlements = X;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy number.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy name.';
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
                ToolTip = 'View mood log entries for the selected puppy.';
            }
        }
    }
}