namespace DefaultPublisher.BCTechDays2025;

table 50102 "Puppy Mood Log"
{
    DataClassification = CustomerContent;
    Caption = 'Puppy Mood Log';
    DrillDownPageId = "Puppy Mood Log List";
    LookupPageId = "Puppy Mood Log List";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            DataClassification = CustomerContent;
            AutoIncrement = true;
        }
        field(2; "Puppy No."; Code[20])
        {
            Caption = 'Puppy No.';
            DataClassification = CustomerContent;
            TableRelation = Puppy;

            trigger OnValidate()
            var
                Puppy: Record Puppy;
            begin
                if Puppy.Get("Puppy No.") then
                    "Puppy Name" := Puppy.Name
                else
                    "Puppy Name" := '';
            end;
        }
        field(3; "Puppy Name"; Text[100])
        {
            Caption = 'Puppy Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(4; "Log DateTime"; DateTime)
        {
            Caption = 'Log DateTime';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Log DateTime" = 0DT then
                    "Log DateTime" := CurrentDateTime;
            end;
        }
        field(5; "Mood State"; Enum "Puppy Mood State")
        {
            Caption = 'Mood State';
            DataClassification = CustomerContent;
        }
        field(6; Notes; Text[250])
        {
            Caption = 'Notes';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Puppy No.", "Log DateTime")
        {
        }
    }

    trigger OnInsert()
    begin
        if "Log DateTime" = 0DT then
            "Log DateTime" := CurrentDateTime;
    end;
}