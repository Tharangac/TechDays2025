namespace DefaultPublisher.BCTechDays2025;

using Microsoft.Foundation.NoSeries;

table 50101 "Puppy_TD"
{
    DataClassification = CustomerContent;
    Caption = 'Puppy';
    LookupPageId = "PuppyList_TD";
    DrillDownPageId = "PuppyList_TD";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                if (Rec.Name <> xRec.Name) and (Rec.Name <> '') then
                    TestField("No.");
            end;
        }
        field(3; Breed; Text[50])
        {
            Caption = 'Breed';
            DataClassification = CustomerContent;
        }
        field(4; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
            DataClassification = CustomerContent;
        }
        field(5; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    var
        NoSeriesMgt: Codeunit "No. Series";

    trigger OnInsert()
    begin
        if "No." = '' then begin
            TestNoSeries();
            "No." := NoSeriesMgt.GetNextNo("No. Series");
        end;
    end;

    local procedure TestNoSeries()
    begin
        TestField("No.", '');
    end;
}