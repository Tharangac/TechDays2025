namespace DefaultPublisher.BCTechDays2025;

table 50102 "VetAppointment_TD"
{
    DataClassification = CustomerContent;
    Caption = 'Vet Appointment';

    fields
    {
        field(1; "Appointment ID"; Guid)
        {
            Caption = 'Appointment ID';
            DataClassification = CustomerContent;
        }
        field(2; "Puppy No."; Code[20])
        {
            Caption = 'Puppy No.';
            TableRelation = Puppy_TD;
            DataClassification = CustomerContent;
        }
        field(3; "Appointment DateTime"; DateTime)
        {
            Caption = 'Appointment Date/Time';
            DataClassification = CustomerContent;
        }
        field(5; Status; Enum "VetAppointmentStatus_TD")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }
        field(7; "External Reference"; Text[100])
        {
            Caption = 'External Reference';
            DataClassification = CustomerContent;
        }
        field(8; "API Request ID"; Text[50])
        {
            Caption = 'API Request ID';
            DataClassification = CustomerContent;
        }
        field(9; "Last Error"; Text[250])
        {
            Caption = 'Last Error';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Appointment ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        Status := Status::Requested;
    end;
}