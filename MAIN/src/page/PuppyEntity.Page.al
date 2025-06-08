page 50105 "PuppyEntity_TD"
{
    PageType = API;
    APIPublisher = 'techDays';
    APIGroup = 'puppymgt';
    APIVersion = 'v1.0';
    EntityName = 'puppy';
    EntitySetName = 'puppies';
    SourceTable = Puppy_TD;
    DelayedInsert = true;
    ODataKeyFields = SystemId;
    ApplicationArea = All;
    Caption = 'puppyEntity';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(systemId; Rec.SystemId)
                {
                    Caption = 'System ID';
                    Editable = false;
                }
                field(puppyNo; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field(breed; Rec.Breed)
                {
                    Caption = 'Breed';
                }
                field(birthDate; Rec."Birth Date")
                {
                    Caption = 'Birth Date';
                }
            }
        }
    }
}
