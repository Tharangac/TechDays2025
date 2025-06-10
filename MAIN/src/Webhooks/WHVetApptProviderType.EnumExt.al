namespace BCTechDays.PuppyMgt.Webhooks;

using BCTechDays.PuppyMgt.VetAppointment;

enumextension 50101 "WHVetApptProviderType_TD" extends VetAppointmentProviderType_TD
{
    value(50101; "Webhooks")
    {
        Implementation = IVetAppointmentProvider_TD = WHVetApptProvider_TD;
    }
}