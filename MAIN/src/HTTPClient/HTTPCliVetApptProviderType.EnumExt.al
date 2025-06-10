namespace BCTechDays.PuppyMgt.HTTPClient;

using BCTechDays.PuppyMgt.VetAppointment;

enumextension 50100 "HTTPCliVetApptProviderType_TD" extends VetAppointmentProviderType_TD
{
    value(50100; HTTPClient)
    {
        Implementation = IVetAppointmentProvider_TD = HTTPClientVetApptProvider_TD;
    }
}