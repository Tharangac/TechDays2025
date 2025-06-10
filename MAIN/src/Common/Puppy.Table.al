namespace BCTechDays.PuppyMgt.Common;

using Microsoft.Foundation.NoSeries;
using BCTechDays.PuppyMgt.VetAppointment;

table 50101 "Puppy_TD"
{
    DataClassification = CustomerContent;
    Caption = 'Puppy';
    LookupPageId = "PuppyList_TD";
    DrillDownPageId = "PuppyList_TD";
    InherentEntitlements = RIMDX;
    InherentPermissions = RIMDX;

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
        field(7; "Created Appointment"; Integer)
        {
            CalcFormula = count(VetAppointment_TD where("Puppy No." = field("No."), "Status" = const("Created")));
            Caption = 'No. of Created Appointment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(8; "Requested Appointment"; Integer)
        {
            CalcFormula = count(VetAppointment_TD where("Puppy No." = field("No."), "Status" = const("Requested")));
            Caption = 'No. of Requested Appointment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Confirmed Appointment"; Integer)
        {
            CalcFormula = count(VetAppointment_TD where("Puppy No." = field("No."), "Status" = const("Confirmed")));
            Caption = 'No. of Confirmed Appointment';
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

    internal procedure ReqeustVetAppointment()
    var
        VetAppointment: Record VetAppointment_TD;
    begin
        VetAppointment.RequestAppointment(Rec);
    end;

    var
        PuppyMgtSetup: Record "PuppyMgtSetup_TD";
        NoSeries: Codeunit "No. Series";
}