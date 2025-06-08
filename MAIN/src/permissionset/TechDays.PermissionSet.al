namespace TechDays;

using DefaultPublisher.BCTechDays2025;
using TechDays.TechDays;
using MAIN.MAIN;

permissionset 50100 "TechDays_TD"
{
    Assignable = true;
    Permissions = tabledata Puppy_TD = RIMD,
        tabledata "VetAppointment_TD" = RIMD,
        table Puppy_TD = X,
        table "VetAppointment_TD" = X,
        codeunit "VetAppointmentEvents_TD" = X,
        codeunit "VetAppointmentMgt._TD" = X,
        page "PuppyCard_TD" = X,
        page "PuppyList_TD" = X,
        codeunit ALAppointmentProvider_TD = X,
        codeunit ModernAppointmentProvider_TD = X,
        tabledata PuppyMgtSetup_TD = RIMD,
        table PuppyMgtSetup_TD = X,
        page PuppyEntity_TD = X,
        page PuppyMgtSetup_TD = X,
        page VetAppointmentList_TD = X,
        page VetAppointmentEntity_TD = X,
        tabledata Breed_TD = RIMD,
        table Breed_TD = X,
        page PuppyPictureFactbox_TD = X,
        page VetAppointmentFactbox_TD = X;
}