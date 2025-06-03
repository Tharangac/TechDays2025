codeunit 50103 "ModernAppointmentProvider_TD" implements "IAppointmentProvider_TD"
{
    /// <summary>
    /// Implementation of the IAppointmentProvider_TD interface method.
    /// Requests a new appointment for the specified puppy.
    /// </summary>
    /// <param name="PuppyNo">The unique identifier for the puppy.</param>
    /// <returns>Text representation of the appointment request result.</returns>
    procedure GetAppointment(PuppyNo: Code[20]): Text
    begin
        // Delegates to the internal RequestAppointment method
        exit(RequestAppointment(PuppyNo));
    end;

    /// <summary>
    /// Creates a new appointment request and raises the external business event.
    /// </summary>
    /// <param name="PuppyNo">The unique identifier for the puppy.</param>
    /// <returns>Text representation of the appointment request result.</returns>
    procedure RequestAppointment(PuppyNo: Code[20]): Text
    var
        VetAppointmentEvents: Codeunit "VetAppointmentEvents_TD";
        AppointmentID: Guid;
    begin
        // First create the appointment record in the database
        AppointmentID := CreateNewAppointment(PuppyNo);

        // Then raise the external business event to notify integrated systems
        VetAppointmentEvents.NewVetAppointmentRequestRaised(AppointmentID);
    end;

    /// <summary>
    /// Creates a new appointment record in the database.
    /// </summary>
    /// <param name="PuppyNo">The unique identifier for the puppy.</param>
    /// <returns>The GUID of the newly created appointment.</returns>
    local procedure CreateNewAppointment(PuppyNo: Code[20]): Guid
    var
        VetAppointment: Record "VetAppointment_TD";
    begin
        // insert a new appointment record and return the appointment ID
        VetAppointment.Init();
        VetAppointment."Appointment ID" := CreateGuid();
        VetAppointment."Puppy No." := PuppyNo;
        VetAppointment.Status := VetAppointment.Status::Requested;
        VetAppointment.Insert();
        exit(VetAppointment."Appointment ID");
    end;
}