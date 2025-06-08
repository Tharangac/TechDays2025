codeunit 50103 "ModernAppointmentProvider_TD" implements "IAppointmentProvider_TD"
{
    procedure RequestAppointment(var VetAppointment: Record "VetAppointment_TD")
    var
        VetAppointmentEvents: Codeunit "VetAppointmentEvents_TD";
    begin
        // Then raise the external business event to notify integrated systems
        VetAppointmentEvents.NewVetAppointmentRequestRaised(VetAppointment.SystemId);
    end;
}