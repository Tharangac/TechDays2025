table 50100 "PuppyMgtSetup_TD"
{
    Caption = 'Puppy Management Setup';
    DataClassification = SystemMetadata;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
        }

        field(2; "Puppy No. Series"; Code[20])
        {
            Caption = 'Puppy No. Series';
            TableRelation = "No. Series";
        }

        field(3; "Appointment No. Series"; Code[20])
        {
            Caption = 'Appointment No. Series';
            TableRelation = "No. Series";
        }

        field(4; "Integration Type"; Enum "IntegrationType_TD")
        {
            Caption = 'Integration Type';
        }

        field(5; "API Endpoint"; Text[250])
        {
            Caption = 'API Endpoint';
            DataClassification = CustomerContent;
        }
        field(6; "API Key"; Text[250])
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

    internal procedure IsEnabled(): Boolean
    begin
        if not Get() then
            exit;
        exit("API Endpoint" <> '');
    end;
}
