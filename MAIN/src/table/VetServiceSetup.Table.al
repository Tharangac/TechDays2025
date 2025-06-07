namespace DefaultPublisher.BCTechDays2025;

table 50103 "Vet Service Setup"
{
    Caption = 'Vet Service Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = CustomerContent;
        }
        field(2; "API Endpoint"; Text[250])
        {
            Caption = 'API Endpoint';
            DataClassification = CustomerContent;
        }
        field(3; "API Key"; Text[250])
        {
            Caption = 'API Key';
            DataClassification = CustomerContent;
            ExtendedDatatype = Masked;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    internal procedure InsertIfNotExists()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;
}