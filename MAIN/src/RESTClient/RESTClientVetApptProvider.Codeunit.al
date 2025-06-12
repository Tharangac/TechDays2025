namespace BCTechDays.PuppyMgt.RESTClient;

using System.Threading;
using System.RestClient;
using BCTechDays.PuppyMgt.Common;
using BCTechDays.PuppyMgt.VetAppointment;

codeunit 50103 "RESTClientVetApptProvider_TD" implements "IVetAppointmentProvider_TD"
{
    Access = Internal;
    TableNo = "Job Queue Entry";
    InherentEntitlements = X;
    InherentPermissions = X;

    procedure RequestAppointment(var VetAppointment: Record "VetAppointment_TD")
    var
        JobQueueEntry: Record "Job Queue Entry";
    begin
        JobQueueEntry.ScheduleJobQueueEntry(Codeunit::RESTClientVetApptProvider_TD, VetAppointment.RecordId())
    end;

    trigger OnRun()
    var
        VetAppointment: Record "VetAppointment_TD";
        PuppyMgtSetup: Record PuppyMgtSetup_TD;
        RestClient: Codeunit "Rest Client";
        Response: JsonToken;
    begin
        if not PuppyMgtSetup.IsEnabled() then
            Error('Vet service is no enabled.');
        VetAppointment.Get(Rec."Record ID to Process");
        VetAppointment.LockTable();
        // prepare and send response
        Response := RestClient.PostAsJson(PuppyMgtSetup."API Endpoint", GetPayload(VetAppointment));
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
        ParsingTechnics();
        Puppy.Get(VetAppointment."Puppy No.");
        Payload.Add('petName', Puppy.Name);
        Payload.Add('petBreed', Puppy.Breed);
    end;

    local procedure ParsingTechnics()
    var
        JsonObject: JsonObject;
        ElementJsonToken: JsonToken;
        JsonToken: JsonToken;
        Value: Variant;
        DefaultIfNotFound: Boolean;
        "Key": Text;
    begin
        JsonObject.ReadFrom('{"propArray": [{"some":"other"}], "propObject": {"prop1": "value1", "prop2": "value2"}}');
        Value := JsonObject.GetArray('propArray', DefaultIfNotFound);
        Value := JsonObject.GetBigInteger('propBigInt', DefaultIfNotFound);
        Value := JsonObject.GetBoolean('propBool', DefaultIfNotFound);
        Value := JsonObject.GetByte('propByte', DefaultIfNotFound);
        Value := JsonObject.GetChar('propChar', DefaultIfNotFound);
        Value := JsonObject.GetDate('propDate', DefaultIfNotFound);
        Value := JsonObject.GetDateTime('propDateTime', DefaultIfNotFound);
        Value := JsonObject.GetDecimal('propDecimal', DefaultIfNotFound);
        Value := JsonObject.GetDuration('propDuration', DefaultIfNotFound);
        Value := JsonObject.GetInteger('propInt', DefaultIfNotFound);
        Value := JsonObject.GetObject('propObject', DefaultIfNotFound);
        Value := JsonObject.GetOption('propOption', DefaultIfNotFound);
        Value := JsonObject.GetText('propText', DefaultIfNotFound);
        Value := JsonObject.GetTime('propTime', DefaultIfNotFound);

        // loop through array
        foreach ElementJsonToken in JsonObject.GetArray('propArray', DefaultIfNotFound) do begin
            // parsing ElementJsonToken
            // ...
        end;

        // loop through object properties
        foreach "Key" in JsonObject.Keys() do begin
            Value := JsonObject.GetText(Key, DefaultIfNotFound)
            // ...
        end;
    end;
}