namespace BCTechDays.PuppyMgt.HTTPClient;

using System.Threading;
using System.RestClient;
using BCTechDays.PuppyMgt.Common;
using BCTechDays.PuppyMgt.VetAppointment;

codeunit 50102 "HTTPClientVetApptProvider_TD" implements "IVetAppointmentProvider_TD"
{
    Access = Internal;
    TableNo = "Job Queue Entry";
    InherentEntitlements = X;
    InherentPermissions = X;

    procedure RequestAppointment(var VetAppointment: Record "VetAppointment_TD")
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JobQueueEntry.ScheduleJobQueueEntry(Codeunit::HTTPClientVetApptProvider_TD, VetAppointment.RecordId())
    end;

    trigger OnRun()
    var
        VetAppointment: Record "VetAppointment_TD";
        PuppyMgtSetup: Record PuppyMgtSetup_TD;
        Content: Codeunit "Http Content";
        Client: Codeunit "Http Client Handler";
        RequestMessage: Codeunit "Http Request Message";
        ResponseMessage: Codeunit "Http Response Message";
        CurrHttpClientInstance: HttpClient;
        Response: JsonToken;
    begin
        if not PuppyMgtSetup.IsEnabled() then
            Error('Vet service is no enabled.');
        VetAppointment.Get(Rec."Record ID to Process");
        VetAppointment.LockTable();
        // prepare request
        RequestMessage.Create(
            "Http Method"::POST,
            PuppyMgtSetup."API Endpoint",
            Content.Create(GetPayload(VetAppointment))
        );
        // send request
        if not Client.Send(CurrHttpClientInstance, RequestMessage, ResponseMessage) then
            Error('Failed to send request to Vet Service');
        if not ResponseMessage.GetIsSuccessStatusCode() then
            Error('Vet service request failed with status code %1', ResponseMessage.GetHttpStatusCode());
        Response := ResponseMessage.GetContent().AsJson();
        // handle response
        VetAppointment."External Reference" := CopyStr(Response.AsObject().GetText('appointmentId'), 1, 100);
        VetAppointment."Appointment DateTime" := Response.AsObject().GetDateTime('appointmentDatetime');
        VetAppointment.Status := VetAppointment.Status::Confirmed;
        VetAppointment.Modify(true);
    end;

    local procedure GetPayload(VetAppointment: Record "VetAppointment_TD") Payload: JsonObject
    var
        Puppy: Record Puppy_TD;
    begin
        Puppy.Get(VetAppointment."Puppy No.");
        Payload.Add('petName', Puppy.Name);
        Payload.Add('petBreed', Puppy.Breed);
    end;
}