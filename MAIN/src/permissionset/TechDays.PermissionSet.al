namespace TechDays;

using DefaultPublisher.BCTechDays2025;
using TechDays.TechDays;

permissionset 50100 "TechDays_TD"
{
    Assignable = true;
    Permissions = tabledata Puppy_TD = RIMD,
        tabledata "VetAppointment_TD" = RIMD,
        table Puppy_TD = X,
        table "VetAppointment_TD" = X,
        codeunit "VetAppointmentEvents_TD" = X,
        codeunit "VetAppointmentMgt._TD" = X,
        page "AppointmentEntity_TD" = X,
        page "PuppyCard_TD" = X,
        page "PuppyList_TD" = X,
        page "VetAppointmentList_TD" = X,
        tabledata CustomIntegrationSetup_TD = RIMD,
        table CustomIntegrationSetup_TD = X,
        codeunit ALAppointmentProvider_TD = X,
        codeunit ModernAppointmentProvider_TD = X,
        page CustomIntegrationSetup_TSL_TD = X;
}