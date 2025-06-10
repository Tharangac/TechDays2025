namespace BCTechDays.PuppyMgt.Webhooks;

using BCTechDays.PuppyMgt.VetAppointment;

enumextension 50110 "WHVetApptProviderType_TD" extends VetAppointmentProviderType_TD
{
    value(50110; "Webhooks")
    {
        Implementation = IVetAppointmentProvider_TD = WHVetApptProvider_TD;
    }
}