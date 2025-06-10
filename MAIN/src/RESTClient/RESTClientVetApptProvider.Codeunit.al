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
        ResponseJsonToken: JsonToken;
    begin
        if not PuppyMgtSetup.IsEnabled() then
            Error('Vet service is no enabled.');
        VetAppointment.Get(Rec."Record ID to Process");
        VetAppointment.LockTable();
        // prepare and send response
        ResponseJsonToken := RestClient.PostAsJson(PuppyMgtSetup."API Endpoint", GetPayload(VetAppointment));
        // handle response
        VetAppointment."External Reference" := CopyStr(ResponseJsonToken.AsObject().GetText('appointmentId'), 1, 100);
        VetAppointment."Appointment DateTime" := ResponseJsonToken.AsObject().GetDateTime('appointmentDatetime');
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