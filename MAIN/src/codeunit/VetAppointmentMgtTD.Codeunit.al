namespace DefaultPublisher.BCTechDays2025;

/// <summary>
/// Codeunit 50100 "VetAppointmentMgt_TD"._TD
/// Manages the appointment scheduling process for veterinary services.
/// </summary>
codeunit 50100 "VetAppointmentMgt._TD"
{
    /// <summary>
    /// Requests an appointment for a specific puppy using the configured appointment provider.
    /// </summary>
    /// <param name="PuppyNo">The unique identifier for the puppy.</param>
    /// <returns>Text result from the appointment request process.</returns>
    procedure RequestAppointment(PuppyNo: Code[20]): Text
    var
        IAppointmentProvider: Interface IAppointmentProvider_TD;
    begin
        // Initialize the provider based on system configuration
        AppointmentProviderFactory(IAppointmentProvider);
        // Use the provider to schedule an appointment
        IAppointmentProvider.GetAppointment(PuppyNo);
    end;

    /// <summary>
    /// Factory method that initializes the appropriate appointment provider
    /// based on the integration type configured in the system.
    /// </summary>
    /// <param name="iAppointmentProvider">Interface variable to be initialized with the proper provider.</param>
    local procedure AppointmentProviderFactory(var iAppointmentProvider: Interface IAppointmentProvider_TD)
    var
        CustomIntegrationSetup: Record CustomIntegrationSetup_TD;
    begin
        // Retrieve the current integration configuration
        CustomIntegrationSetup.Get();
        // Assign the appropriate provider implementation based on the configured integration type
        iAppointmentProvider := CustomIntegrationSetup."Integration Type";
    end;
}