namespace BCTechDays.PuppyMgt.HTTPClients;

using BCTechDays.PuppyMgt.VetAppointment;

enumextension 50100 "HTTPClientsVetApptProviderType_TD" extends VetAppointmentProviderType_TD
{
    value(50100; HTTPClients)
    {
        Implementation = IVetAppointmentProvider_TD = HTTPClientsVetApptProvider_TD;
    }
}