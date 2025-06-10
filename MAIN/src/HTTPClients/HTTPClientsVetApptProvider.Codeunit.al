namespace BCTechDays.PuppyMgt.HTTPClients;

using System.Threading;
using System.RestClient;
using BCTechDays.PuppyMgt.Common;
using BCTechDays.PuppyMgt.VetAppointment;

codeunit 50102 "HTTPClientsVetApptProvider_TD" implements "IVetAppointmentProvider_TD"
{
    Access = Internal;
    TableNo = "Job Queue Entry";
    InherentEntitlements = X;
    InherentPermissions = X;

    procedure RequestAppointment(var VetAppointment: Record "VetAppointment_TD")
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueManagement: Codeunit "Job Queue Management";
    begin
        JobQueueEntry.Init();
        JobQueueEntry.Validate("Object Type to Run", JobQueueEntry."Object Type to Run"::Codeunit);
        JobQueueEntry.Validate("Object ID to Run", Codeunit::HTTPClientsVetApptProvider_TD);
        JobQueueManagement.CreateJobQueueEntry(JobQueueEntry);
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
        VetAppointmentRecRef: RecordRef;
        CurrHttpClientInstance: HttpClient;
        RequestObject: JsonObject;
    begin
        VetAppointmentRecRef.Get(Rec."Record ID to Process");
        VetAppointmentRecRef.SetTable(VetAppointment);
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

        //Json.InitializeObject(ResponseMessage.GetContent().AsText());
        //Json.GetValueAndSetToRecFieldNo(VetAppointmentRecRef, '*.appointmentDaeTime', VetAppointment.FieldNo("Appointment DateTime"));
        // TODO: add response handling
    end;
}