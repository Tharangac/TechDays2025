table 50103 "Breed_TD"
{
    Caption = 'Breed';
    DataClassification = SystemMetadata;
    LookupPageId = "Breed List_TD";
    DrillDownPageId = "Breed List_TD";

    fields
    {
        field(1; "Code"; Code[20])
        {
            Caption = 'Code';
        }
        field(2; Name; Text[50])
        {
            Caption = 'Name';
        }
    }
    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
