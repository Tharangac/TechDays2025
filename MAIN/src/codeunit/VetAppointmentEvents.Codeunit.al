namespace DefaultPublisher.BCTechDays2025;
using System.Integration;
using TechDays.TechDays;
codeunit 50101 "Vet Appointment Events_TD"
{

    [ExternalBusinessEvent('puppymgt_newvetappointmentrequestraised', 'Puppy Mgt - New Vet Appointment Request Raised', 'Triggered when new vet appointment request is raised', EventCategory::"Puppy Management")]
    [RequiredPermissions(PermissionObjectType::TableData, Database::"Vet Appointment_TD", 'R')]
    procedure NewVetAppointmentRequestRaised(appointmentID: Guid)
    begin

    end;

    [ExternalBusinessEvent('puppymgt_cancelvetappointmentrequestraised', 'Puppy Mgt - Cancel Vet Appointment Request Raised', 'Triggered when cancel vet appointment request raised', EventCategory::"Puppy Management")]
    [RequiredPermissions(PermissionObjectType::TableData, Database::"Vet Appointment_TD", 'R')]
    procedure CancelVetAppointmentRequestRaised(appointmentID: Guid)
    begin

    end;

    var
        EventCategory: Enum EventCategory;

}