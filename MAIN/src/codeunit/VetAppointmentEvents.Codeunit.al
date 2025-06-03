namespace DefaultPublisher.BCTechDays2025;
using System.Integration;
using TechDays.TechDays;

/// <summary>
/// Codeunit 50101 VetAppointmentEvents_TD
/// Provides external business events related to veterinary appointment management.
/// These events enable integration with external systems and services.
/// </summary>
codeunit 50101 "VetAppointmentEvents_TD"
{
    /// <summary>
    /// External business event triggered when a new veterinary appointment request is raised.
    /// This event allows external systems to respond to new appointment requests.
    /// </summary>
    /// <param name="appointmentID">The unique identifier (GUID) of the new appointment request.</param>
    /// <remarks>
    /// Requires read permission on the VetAppointment_TD table.
    /// Event category is set to "Puppy Management".
    /// </remarks>
    [ExternalBusinessEvent('puppymgt_newvetappointmentrequestraised', 'Puppy Mgt - New Vet Appointment Request Raised', 'Triggered when new vet appointment request is raised', EventCategory::"Puppy Management")]
    [RequiredPermissions(PermissionObjectType::TableData, Database::"VetAppointment_TD", 'R')]
    procedure NewVetAppointmentRequestRaised(appointmentID: Guid)
    begin
        // Event implementation left empty intentionally
        // External subscribers will implement the handling logic
    end;

    /// <summary>
    /// External business event triggered when a veterinary appointment cancellation is requested.
    /// This event allows external systems to respond to appointment cancellation requests.
    /// </summary>
    /// <param name="appointmentID">The unique identifier (GUID) of the appointment to be cancelled.</param>
    /// <remarks>
    /// Requires read permission on the VetAppointment_TD table.
    /// Event category is set to "Puppy Management".
    /// </remarks>
    [ExternalBusinessEvent('puppymgt_cancelvetappointmentrequestraised', 'Puppy Mgt - Cancel Vet Appointment Request Raised', 'Triggered when cancel vet appointment request raised', EventCategory::"Puppy Management")]
    [RequiredPermissions(PermissionObjectType::TableData, Database::"VetAppointment_TD", 'R')]
    procedure CancelVetAppointmentRequestRaised(appointmentID: Guid)
    begin
        // Event implementation left empty intentionally
        // External subscribers will implement the handling logic
    end;

    var
        /// <summary>
        /// Variable for the EventCategory enum used to categorize the business events.
        /// </summary>
        EventCategory: Enum EventCategory;
}