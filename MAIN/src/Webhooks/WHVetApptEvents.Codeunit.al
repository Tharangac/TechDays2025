namespace BCTechDays.PuppyMgt.Webhooks;

using System.Integration;
using BCTechDays.PuppyMgt.VetAppointment;

codeunit 50111 "WHVetApptEvents_TD"
{
    Access = Internal;
    InherentEntitlements = X;
    InherentPermissions = X;

    [ExternalBusinessEvent(
        'vetappointmentcreated',
        'Vet Appointment Created',
        'Triggered when new vet appointment is created.',
        EventCategory::"Puppy Management")]
    [RequiredPermissions(PermissionObjectType::TableData, Database::"VetAppointment_TD", 'R')]
    procedure VetAppointmentCreated(appointmentSystemID: Guid)
    begin
    end;
}