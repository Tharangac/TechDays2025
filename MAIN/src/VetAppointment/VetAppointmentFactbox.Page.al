namespace BCTechDays.PuppyMgt.VetAppointment;

page 50107 "VetAppointmentFactbox_TD"
{
    ApplicationArea = All;
    Caption = 'Vet Appointment';
    PageType = CardPart;
    SourceTable = VetAppointment_TD;
    InherentEntitlements = X;
    InherentPermissions = X;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appointment ID.';
                }
                field("Puppy No."; Rec."Puppy No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy number for this appointment.';
                }
                field("Appointment Date"; Rec."Appointment DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the appointment.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the appointment.';
                }
            }
        }
    }
}
