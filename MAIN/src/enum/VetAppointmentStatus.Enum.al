namespace DefaultPublisher.BCTechDays2025;

enum 50100 "VetAppointmentStatus_TD"
{
    Extensible = true;

    value(0; Requested)
    {
        Caption = 'Requested';
    }
    value(1; Confirmed)
    {
        Caption = 'Confirmed';
    }
    value(2; Completed)
    {
        Caption = 'Completed';
    }
    value(3; Cancelled)
    {
        Caption = 'Cancelled';
    }
}