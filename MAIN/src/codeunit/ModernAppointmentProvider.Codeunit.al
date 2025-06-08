codeunit 50103 "ModernAppointmentProvider_TD" implements "IAppointmentProvider_TD"
{
    procedure GetAppointment(PuppyNo: Code[20]): Guid
    begin
        // Delegates to the internal RequestAppointment method
        exit(RequestAppointment(PuppyNo));
    end;

    procedure RequestAppointment(PuppyNo: Code[20]): Guid
    var
        Vetappointment: Record "VetAppointment_TD";
        VetAppointmentEvents: Codeunit "VetAppointmentEvents_TD";
        AppointmentSystemID: Guid;
    begin
        // First create the appointment record in the database
        AppointmentSystemID := Vetappointment.CreateNewAppointment(PuppyNo);

        // Then raise the external business event to notify integrated systems
        VetAppointmentEvents.NewVetAppointmentRequestRaised(AppointmentSystemID);
    end;
}