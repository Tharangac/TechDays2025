namespace BCTechDays.PuppyMgt.VetAppointment;

using BCTechDays.PuppyMgt.Common;

codeunit 50104 "VetAppointmentSubscribers_TD"
{
    Access = Internal;
    SingleInstance = true;
    InherentEntitlements = X;
    InherentPermissions = X;

    [EventSubscriber(ObjectType::Table, Database::VetAppointment_TD, OnAfterInsertEvent, '', false, false)]
    local procedure OnAfterInsertVetAppointment(var Rec: Record VetAppointment_TD; RunTrigger: Boolean)
    var
        IAppointmentProvider: Interface IVetAppointmentProvider_TD;
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

    local procedure GetAppointmentProvider(): Interface IVetAppointmentProvider_TD
    var
        PuppyMgtSetup: Record "PuppyMgtSetup_TD";
    begin
        PuppyMgtSetup.Get();
        exit(PuppyMgtSetup."Integration Type");
    end;
}