codeunit 50103 "ModernAppointmentProvider_TD" implements "IAppointmentProvider_TD"
{
    procedure RequestAppointment(var VetAppointment: Record "VetAppointment_TD")
    var
        VetAppointmentEvents: Codeunit "VetAppointmentEvents_TD";
    begin
        VetAppointmentEvents.NewVetAppointmentRequestRaised(VetAppointment.SystemId);
    end;
}