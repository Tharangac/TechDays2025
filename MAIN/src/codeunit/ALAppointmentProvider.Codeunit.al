codeunit 50102 "ALAppointmentProvider_TD" implements "IAppointmentProvider_TD"
{
    Access = Internal;
    TableNo = "Job Queue Entry";

    procedure RequestAppointment(var VetAppointment: Record "VetAppointment_TD")
    var
        JobQueueEntry: Record "Job Queue Entry";
        JobQueueManagement: Codeunit "Job Queue Management";
    begin
        // TODO: Create a job queue entry
        //JobQueueManagement.CreateJobQueueEntry();
        //JobQueueEntry.Init();
    end;

    trigger OnRun()
    var
        VetAppointment: Record "VetAppointment_TD";
        VatServiceSetup: Record "Vet Service Setup";
        Puppy: Record Puppy_TD;
        Content: Codeunit "Http Content";
        Client: Codeunit "Http Client Handler";
        RequestMessage: Codeunit "Http Request Message";
        ResponseMessage: Codeunit "Http Response Message";
        Json: Codeunit Json;
        CurrHttpClientInstance: HttpClient;
        VetAppointmentRecRef: RecordRef;
        RequestHeaders: HttpHeaders;
        RequestObject: JsonObject;
        RequestContent: Text;
        ResponseObject: JsonObject;
    begin
        VetAppointmentRecRef.Get(Rec."Record ID to Process");
        VetAppointmentRecRef.SetTable(VetAppointment);
        Puppy.Get(VetAppointment."Puppy No.");
        if not VatServiceSetup.IsEnabled() then
            Error('Vat service is no enabled.');
        // prepare content
        RequestObject.Add('petName', Puppy.Name);
        RequestObject.Add('petBreed', Puppy.Breed);
        // prepare request
        RequestMessage.SetHttpMethod('POST');
        RequestMessage.SetRequestUri(VatServiceSetup."API Endpoint");
        RequestMessage.SetContent(Content.Create(RequestObject));
        // send a request
        if not Client.Send(CurrHttpClientInstance, RequestMessage, ResponseMessage) then
            Error('Failed to send request to Vet Service');
        // handle response
        if not ResponseMessage.GetIsSuccessStatusCode() then
            Error(StrSubstNo('Vet service request failed with status code %1', ResponseMessage.GetHttpStatusCode()));
        Json.InitializeObject(ResponseMessage.GetContent().AsText());
        // TODO: add response handling
    end;
}