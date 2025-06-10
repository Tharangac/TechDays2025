namespace BCTechDays.PuppyMgt.Webhooks;

using BCTechDays.PuppyMgt.VetAppointment;

codeunit 50110 "WHVetApptProvider_TD" implements "IVetAppointmentProvider_TD"
{
    procedure RequestAppointment(var VetAppointment: Record "VetAppointment_TD")
    var
        VetAppointmentEvents: Codeunit "WHVetApptEvents_TD";
    begin
        VetAppointmentEvents.VetAppointmentCreated(VetAppointment.SystemId);
    end;
}