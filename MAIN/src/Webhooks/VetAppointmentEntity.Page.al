namespace BCTechDays.PuppyMgt.VetAppointment;

page 50110 "VetAppointmentEntity_TD"
{
    PageType = API;
    APIPublisher = 'bcTechDays';
    APIGroup = 'puppymgt';
    APIVersion = 'v1.0';
    EntityName = 'vetAppointment';
    EntitySetName = 'vetAppointments';
    SourceTable = "VetAppointment_TD";
    ODataKeyFields = SystemId;
    DelayedInsert = true;
    ApplicationArea = All;
    Caption = 'vetAppointmentEntity';
    InherentEntitlements = X;
    InherentPermissions = X;

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
                field(appointmentNo; Rec."No.")
                {
                    Caption = 'No.';
                }
                field(puppyNo; Rec."Puppy No.")
                {
                    Caption = 'Puppy No.';
                }
                field(externalReference; Rec."External Reference")
                {
                    Caption = 'External Reference';
                }
                field(appointmenDateTime; Rec."Appointment DateTime")
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
