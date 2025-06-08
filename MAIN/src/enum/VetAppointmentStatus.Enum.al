namespace DefaultPublisher.BCTechDays2025;

enum 50100 "VetAppointmentStatus_TD"
{
    Extensible = true;

    value(0; Created)
    {
        Caption = 'Created';
    }
    value(1; Requested)
    {
        Caption = 'Confirmed';
    }
    value(2; Confirmed)
    {
        Caption = 'Completed';
    }
    value(3; Cancelled)
    {
        Caption = 'Cancelled';
    }
}