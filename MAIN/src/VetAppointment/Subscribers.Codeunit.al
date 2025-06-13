namespace BCTechDays.PuppyMgt.VetAppointment;

using System.Utilities;
using Microsoft.Utilities;
using BCTechDays.PuppyMgt.Common;

codeunit 50104 "Subscribers_TD"
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

    [EventSubscriber(ObjectType::Table, Database::"Service Connection", OnRegisterServiceConnection, '', false, false)]
    local procedure OnRegisterServiceConnection(var ServiceConnection: Record "Service Connection" temporary)
    var
        PuppyMgtSetup: Record PuppyMgtSetup_TD;
        UrlBuilder: Codeunit "Uri Builder";
        ServiceNameTxt: Label 'Vet Appointment Service';
    begin
        PuppyMgtSetup.InsertIfNotExists();
        if PuppyMgtSetup."API Endpoint" <> '' then
            UrlBuilder.Init(PuppyMgtSetup."API Endpoint");
        ServiceConnection.InsertServiceConnection(
            ServiceConnection,
            PuppyMgtSetup.RecordId(),
            ServiceNameTxt,
            (PuppyMgtSetup."API Endpoint" <> '') ? UrlBuilder.GetHost() : '',
            Page::VetAppointmentServiceSetup_TD);

        ServiceConnection.Status := ServiceConnection.Status::Enabled;
        ServiceConnection.Modify(true);
    end;
}