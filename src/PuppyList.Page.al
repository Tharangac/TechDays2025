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
                ToolTip = 'Request a veterinary appointment for the selected puppy.';

                trigger OnAction()
                var
                    VetAppointmentMgt: Codeunit "Vet Appointment Mgt.";
                begin
                    VetAppointmentMgt.RequestAppointment(Rec."No.");
                    Message('Appointment request sent successfully.');
                end;
            }
        }
    }
}