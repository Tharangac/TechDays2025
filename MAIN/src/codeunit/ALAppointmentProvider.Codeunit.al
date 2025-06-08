codeunit 50102 "ALAppointmentProvider_TD" implements "IAppointmentProvider_TD"
{

    procedure GetAppointment(PuppyNo: Code[20]): Guid
    begin
        exit(RequestAppointment(PuppyNo));
    end;

    procedure RequestAppointment(PuppyNo: Code[20]): Guid
    var
        VetAppointment: Record "VetAppointment_TD";
        // TempBlob: Codeunit "Temp Blob";
        // RequestContent: InStream;
        // ResponseContent: InStream;
        // Client: HttpClient;
        // RequestMessage: HttpRequestMessage;
        // ResponseMessage: HttpResponseMessage;
        // RequestObject: JsonObject;
        // ResponseObject: JsonObject;
        // JToken: JsonToken;
        // RequestID: Text;
        // VetAppointmentEvent: Codeunit "VetAppointmentEvents_TD";
        AppointmentSystemID: Guid;
    begin
        AppointmentSystemID := VetAppointment.CreateNewAppointment(PuppyNo);

        // Initialize appointment record


        /*
                // Prepare API request
                RequestObject.Add('puppyId', PuppyNo);
                RequestObject.WriteTo(RequestContent);

                // Send request to Vet API
                RequestMessage.Method := 'POST';
                RequestMessage.SetRequestUri('https://api.vetservice.com/appointments'); // Replace with actual API endpoint
                RequestMessage.Content.WriteFrom(RequestContent);
                RequestMessage.Content.GetHeaders().Add('Content-Type', 'application/json');

                if not Client.Send(RequestMessage, ResponseMessage) then
                    Error('Failed to send request to Vet API');

                if not ResponseMessage.IsSuccessStatusCode then begin
                    VetAppointment."Last Error" := StrSubstNo('API request failed with status code %1', ResponseMessage.HttpStatusCode);
                    VetAppointment.Insert();
                    Error(VetAppointment."Last Error");
                end;

                // Process API response
                ResponseMessage.Content.ReadAs(ResponseContent);
                if not ResponseObject.ReadFrom(ResponseContent) then
                    Error('Invalid response from Vet API');

                if ResponseObject.Get('requestId', JToken) then
                    VetAppointment."API Request ID" := JToken.AsValue().AsText();

                if ResponseObject.Get('externalReference', JToken) then
                    VetAppointment."External Reference" := JToken.AsValue().AsText();

                if ResponseObject.Get('appointmen_TDateTime', JToken) then
                    VetAppointment."Appointment DateTime" := JToken.AsValue().AsDateTime();

                // Insert the appointment record
                VetAppointment.Insert();

                exit(VetAppointment."API Request ID");
                */
    end;

    procedure CheckAppointmentStatus(APIRequestID: Text): Enum "VetAppointmentStatus_TD"
    var
        VetAppointment: Record "VetAppointment_TD";
        Client: HttpClient;
        ResponseMessage: HttpResponseMessage;
        ResponseContent: InStream;
        ResponseObject: JsonObject;
        JToken: JsonToken;
        NewStatus: Text;
    begin
        VetAppointment.SetRange("API Request ID", APIRequestID);
        if not VetAppointment.FindFirst() then
            Error('Appointment not found for Request ID %1', APIRequestID);

        // Call API to check status
        if not Client.Get(StrSubstNo('https://api.vetservice.com/appointments/%1/status', APIRequestID), ResponseMessage) then
            Error('Failed to check appointment status');

        if not ResponseMessage.IsSuccessStatusCode then
            Error('Failed to get status from API');

        ResponseMessage.Content.ReadAs(ResponseContent);
        if not ResponseObject.ReadFrom(ResponseContent) then
            Error('Invalid response from Vet API');

        if not ResponseObject.Get('status', JToken) then
            Error('Status not found in API response');

        NewStatus := JToken.AsValue().AsText().ToUpper();
        case NewStatus of
            'CONFIRMED':
                VetAppointment.Status := VetAppointment.Status::Confirmed;
            'COMPLETED':
                VetAppointment.Status := VetAppointment.Status::Completed;
            'CANCELLED':
                VetAppointment.Status := VetAppointment.Status::Cancelled;
        end;

        VetAppointment.Modify();
        exit(VetAppointment.Status);
    end;

}