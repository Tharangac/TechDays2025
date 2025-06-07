codeunit 50104 VetAppointmentSubscribers
{
    Access = Internal;
    SingleInstance = true;

    [EventSubscriber(ObjectType::Table, Database::VetAppointment_TD, OnAfterInsertEvent, '', false, false)]
    local procedure OnAfterInsertVetAppointment(var Rec: Record VetAppointment_TD; RunTrigger: Boolean)
    var
        IAppointmentProvider: Interface IAppointmentProvider_TD;
    begin
        if Rec.IsTemporary() then
            exit;
        IAppointmentProvider := GetAppointmentProvider();
        IAppointmentProvider.RequestAppointment(Rec);
        if Rec.Status = Rec.Status::Created then begin
            Rec.Status := Rec.Status::Requested;
            Rec.Modify(true);
        end;
    end;

    local procedure GetAppointmentProvider(): Interface IAppointmentProvider_TD
    var
        CustomIntegrationSetup: Record CustomIntegrationSetup_TD;
    begin
        CustomIntegrationSetup.InsertIfNotExists();
        exit(CustomIntegrationSetup."Integration Type");
    end;
}