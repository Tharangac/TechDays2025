namespace TechDays.TechDays;

using DefaultPublisher.BCTechDays2025;
page 50104 "AppointmentEntity_TD"
{
    PageType = API;
    APIPublisher = 'techDays';
    APIGroup = 'puppymgt';
    APIVersion = 'v1.0';
    EntityName = 'appointment';
    EntitySetName = 'appointments';
    SourceTable = "VetAppointment_TD";
    ODataKeyFields = "Appointment ID";
    DelayedInsert = true;
    ApplicationArea = All;
    Caption = 'appointmentEntity';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(appointmentID; Rec."Appointment ID")
                {
                    Caption = 'Appointment ID';
                }
                field(puppyNo; Rec."Puppy No.")
                {
                    Caption = 'Puppy No.';
                }
                field(externalReference; Rec."External Reference")
                {
                    Caption = 'External Reference';
                }
                field(appointmentDateTime; Rec."Appointment DateTime")
                {
                    Caption = 'Appointment Date/Time';
                }
                field(apiRequestID; Rec."API Request ID")
                {
                    Caption = 'API Request ID';
                }
                field(status; Rec.Status)
                {
                    Caption = 'Status';
                }
                field(lastError; Rec."Last Error")
                {
                    Caption = 'Last Error';
                }
            }
        }
    }
}
