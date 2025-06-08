namespace DefaultPublisher.BCTechDays2025;

using Microsoft.Foundation.NoSeries;
using Microsoft.Sales.Customer;

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
        }
        field(2; Name; Text[100])
        {
            Caption = 'Name';
            trigger OnValidate()
            begin
                if (Rec.Name <> xRec.Name) and (Rec.Name <> '') then
                    TestField("No.");
            end;
        }
        field(3; Breed; Code[20])
        {
            Caption = 'Breed';
            TableRelation = "Breed_TD".Code;
        }
        field(4; "Birth Date"; Date)
        {
            Caption = 'Birth Date';
        }
        field(5; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
        field(6; Image; Media)
        {
            Caption = 'Image';
            ExtendedDatatype = Person;
            ToolTip = 'Specifies the picture of the puppy.';
        }
        field(7; "Requested Appointment"; Integer)
        {
            CalcFormula = count(VetAppointment_TD where("Puppy No." = field("No."), "Status" = const("Requested")));
            Caption = 'No. of Requested Appointment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Confirmed Appointment"; Integer)
        {
            CalcFormula = count(VetAppointment_TD where("Puppy No." = field("No."), "Status" = const("Confirmed")));
            Caption = 'No. of Confirmed Appointment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Completed Appointment"; Integer)
        {
            CalcFormula = count(VetAppointment_TD where("Puppy No." = field("No."), "Status" = const("Completed")));
            Caption = 'No. of Completed Appointment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(10; "Cancelled Appointment"; Integer)
        {
            CalcFormula = count(VetAppointment_TD where("Puppy No." = field("No."), "Status" = const("Cancelled")));
            Caption = 'No. of Cancelled Appointment';
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        if "No." = '' then begin
            PuppyMgtSetup.Get();
            PuppyMgtSetup.TestField("Puppy No. Series");

            "No. Series" := PuppyMgtSetup."Puppy No. Series";
            "No." := NoSeries.GetNextNo("No. Series");
        end;
    end;

    var
        PuppyMgtSetup: Record "PuppyMgtSetup_TD";
        NoSeries: Codeunit "No. Series";
}