namespace TechDays;

using DefaultPublisher.BCTechDays2025;
using TechDays.TechDays;

permissionset 50100 "TechDays_TD"
{
    Assignable = true;
    Permissions = tabledata Puppy_TD = RIMD,
        tabledata "Vet Appointment_TD" = RIMD,
        table Puppy_TD = X,
        table "Vet Appointment_TD" = X,
        codeunit "Vet Appointment Events_TD" = X,
        codeunit "Vet Appointment Mgt._TD" = X,
        page "Appointment Entity_TD" = X,
        page "Puppy Card_TD" = X,
        page "Puppy List_TD" = X,
        page "Vet Appointment List_TD" = X;
}