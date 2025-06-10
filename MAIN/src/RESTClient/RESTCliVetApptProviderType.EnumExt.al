namespace BCTechDays.PuppyMgt.RESTClient;

using BCTechDays.PuppyMgt.VetAppointment;

enumextension 50101 "RESTCliVetApptProviderType_TD" extends VetAppointmentProviderType_TD
{
    value(50101; RESTClient)
    {
        Implementation = IVetAppointmentProvider_TD = RESTClientVetApptProvider_TD;
    }
}