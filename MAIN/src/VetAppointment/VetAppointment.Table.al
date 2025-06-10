namespace BCTechDays.PuppyMgt.VetAppointment;

using BCTechDays.PuppyMgt.Common;
using Microsoft.Foundation.NoSeries;

table 50102 "VetAppointment_TD"
{
    Caption = 'Vet Appointment';
    DataClassification = CustomerContent;
    InherentEntitlements = RIMDX;
    InherentPermissions = RIMDX;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; "Puppy No."; Code[20])
        {
            Caption = 'Puppy No.';
            TableRelation = Puppy_TD;
        }
        field(3; "Appointment DateTime"; DateTime)
        {
            Caption = 'Appointment Date/Time';
        }
        field(5; Status; Enum "VetAppointmentStatus_TD")
        {
            Caption = 'Status';
        }
        field(7; "External Reference"; Text[100])
        {
            Caption = 'External Reference';
        }
        field(8; "API Request ID"; Text[50])
        {
            Caption = 'API Request ID';
        }
        field(9; "Last Error"; Text[250])
        {
            Caption = 'Last Error';
        }
        field(10; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
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
            GetSetup();

            "No. Series" := PuppyMgtSetup."Appointment No. Series";
            "No." := NoSeries.GetNextNo("No. Series");
        end;

        Status := Status::Requested;
    end;

    procedure RequestAppointment(Puppy: Record Puppy_TD)
    begin
        InsertVetAppointment(Puppy);
    end;

    local procedure InsertVetAppointment(Puppy: Record Puppy_TD): Guid
    var
        VetAppointment: Record "VetAppointment_TD";
    begin
        VetAppointment.Init();
        VetAppointment.Validate("Puppy No.", Puppy."No.");
        VetAppointment.Validate(Status, VetAppointment.Status::Requested);
        VetAppointment.Insert(true);
    end;

    local procedure GetSetup()
    begin
        PuppyMgtSetup.Get();
        PuppyMgtSetup.TestField("Appointment No. Series");
    end;


    var
        PuppyMgtSetup: Record "PuppyMgtSetup_TD";
        NoSeries: Codeunit "No. Series";
}