codeunit 50103 "ModernAppointmentProvider_TD" implements "IAppointmentProvider_TD"
{

    procedure GetAppointment(PuppyNo: Code[20]): Text
    begin
        exit(RequestAppointment(PuppyNo));
    end;


    procedure RequestAppointment(PuppyNo: Code[20]): Text
    var
        VetAppointment: Record "VetAppointment_TD";
        VetAppointmentEvents: Codeunit "VetAppointmentEvents_TD";
    begin
        VetAppointment.Init();
        VetAppointment."Appointment ID" := CreateGuid();
        VetAppointment."Puppy No." := PuppyNo;
        VetAppointment.Status := VetAppointment.Status::Requested;
        VetAppointment.Insert();

        VetAppointmentEvents.NewVetAppointmentRequestRaised(VetAppointment."Appointment ID");
    end;
}