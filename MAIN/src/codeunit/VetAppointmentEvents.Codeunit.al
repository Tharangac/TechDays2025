namespace DefaultPublisher.BCTechDays2025;
using TechDays.TechDays;
using System.Integration;

codeunit 50101 "VetAppointmentEvents_TD"
{
    [ExternalBusinessEvent('puppymgt_newvetappointmentrequestraised',
                                'Puppy Mgt - New Vet Appointment Request Raised',
                                    'Triggered when new vet appointment request is raised',
                                        EventCategory::"Puppy Management")]
    [RequiredPermissions(PermissionObjectType::TableData, Database::"VetAppointment_TD", 'R')]
    procedure NewVetAppointmentRequestRaised(appointmentSystemID: Guid)
    begin
    end;

    [ExternalBusinessEvent('puppymgt_cancelvetappointmentrequestraised',
                                'Puppy Mgt - Cancel Vet Appointment Request Raised',
                                    'Triggered when cancel vet appointment request raised',
                                        EventCategory::"Puppy Management")]
    [RequiredPermissions(PermissionObjectType::TableData, Database::"VetAppointment_TD", 'R')]
    procedure CancelVetAppointmentRequestRaised(appointmentSystemID: Guid)
    begin
    end;

    var
        EventCategory: Enum EventCategory;
}