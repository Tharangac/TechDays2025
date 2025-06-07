namespace DefaultPublisher.BCTechDays2025;

page 50102 "PuppyCard_TD"
{
    PageType = Card;
    SourceTable = Puppy_TD;
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
    }

    actions
    {
        area(Processing)
        {
            action(RequestVetAppointment)
            {
                ApplicationArea = All;
                Caption = 'Request Vet Appointment';
                Image = Calendar;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Request a new veterinary appointment for this puppy.';

                trigger OnAction()
                begin
                    Rec.ReqeustVetAppointment();
                end;
            }
        }
    }
}