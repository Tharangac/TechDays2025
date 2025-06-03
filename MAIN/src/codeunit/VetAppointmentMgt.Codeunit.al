namespace DefaultPublisher.BCTechDays2025;

codeunit 50100 "VetAppointmentMgt._TD"
{

    procedure RequestAppointment(PuppyNo: Code[20]): Text
    var
        IAppointmentProvider: Interface IAppointmentProvider_TD;
    begin
        AppointmentproviderFactory(IAppointmentProvider);
        IAppointmentProvider.GetAppointment(PuppyNo);
    end;


    local procedure AppointmentproviderFactory(var iAppointmentProvider: Interface IAppointmentProvider_TD)
    var
        CustomIntegrationSetup: Record CustomIntegrationSetup_TD;
    begin
        CustomIntegrationSetup.Get();
        iAppointmentProvider := CustomIntegrationSetup."Integration Type";
    end;

}