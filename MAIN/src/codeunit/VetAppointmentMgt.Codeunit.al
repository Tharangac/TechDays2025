namespace DefaultPublisher.BCTechDays2025;
codeunit 50100 "VetAppointmentMgt._TD"
{
    procedure RequestAppointment(PuppyNo: Code[20]): Text
    var
        IAppointmentProvider: Interface IAppointmentProvider_TD;
    begin
        // Initialize the provider based on system configuration
        AppointmentProviderFactory(IAppointmentProvider);
        // Use the provider to schedule an appointment
        IAppointmentProvider.GetAppointment(PuppyNo);
    end;

    local procedure AppointmentProviderFactory(var iAppointmentProvider: Interface IAppointmentProvider_TD)
    var
        PuppyMgtSetup: Record "PuppyMgtSetup_TD";
    begin
        PuppyMgtSetup.Get();
        // Assign the appropriate provider implementation based on the configured integration type
        iAppointmentProvider := PuppyMgtSetup."Integration Type";
    end;
}