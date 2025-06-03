enum 50101 "IntegrationType_TD" implements IAppointmentProvider_TD
{
    Extensible = true;

    value(0; "AL Way")
    {
        Implementation = IAppointmentProvider_TD = ALAppointmentProvider_TD;
    }

    value(1; "Modern Way")
    {
        Implementation = IAppointmentProvider_TD = ModernAppointmentProvider_TD;
    }
}