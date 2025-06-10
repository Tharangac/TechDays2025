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
        Puppy: Record Puppy_TD;
        Content: Codeunit "Http Content";
        Client: Codeunit "Http Client Handler";
        RequestMessage: Codeunit "Http Request Message";
        ResponseMessage: Codeunit "Http Response Message";
        CurrHttpClientInstance: HttpClient;
        RequestObject: JsonObject;
        ResponseJsonObject: JsonObject;
    begin
        VetAppointment.Get(Rec."Record ID to Process");
        VetAppointment.LockTable();
        Puppy.Get(VetAppointment."Puppy No.");
        if not PuppyMgtSetup.IsEnabled() then
            Error('Vet service is no enabled.');
        // prepare content
        RequestObject.Add('petName', Puppy.Name);
        RequestObject.Add('petBreed', Puppy.Breed);
        // prepare request
        RequestMessage.Create(
            "Http Method"::POST,
            PuppyMgtSetup."API Endpoint",
            Content.Create(RequestObject)
        );
        // send a request
        if not Client.Send(CurrHttpClientInstance, RequestMessage, ResponseMessage) then
            Error('Failed to send request to Vet Service');
        // handle response
        if not ResponseMessage.GetIsSuccessStatusCode() then
            Error('Vet service request failed with status code %1', ResponseMessage.GetHttpStatusCode());
        ResponseJsonObject := ResponseMessage.GetContent().AsJson().AsObject();
        VetAppointment."External Reference" := CopyStr(ResponseJsonObject.GetText('appointmentId'), 1, 100);
        VetAppointment."Appointment DateTime" := ResponseJsonObject.GetDateTime('appointmentDatetime');
        VetAppointment.Status := VetAppointment.Status::Confirmed;
        VetAppointment.Modify(true);
    end;
}