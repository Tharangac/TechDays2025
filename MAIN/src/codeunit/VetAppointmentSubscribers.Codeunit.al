codeunit 50104 "VetAppointmentSubscribers_TD"
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

    local procedure GetAppointmentProvider(): Interface iAppointmentProvider_TD
    var
        PuppyMgtSetup: Record "PuppyMgtSetup_TD";
    begin
        PuppyMgtSetup.Get();
        // Assign the appropriate provider implementation based on the configured integration type
        exit(PuppyMgtSetup."Integration Type");
    end;
}