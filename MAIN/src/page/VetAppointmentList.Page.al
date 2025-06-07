namespace DefaultPublisher.BCTechDays2025;

page 50103 "VetAppointmentList_TD"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "VetAppointment_TD";
    Editable = false;
    Caption = 'Vet Appointments';
    InherentPermissions = X;
    InherentEntitlements = X;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; Rec."Appointment ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the appointment ID.';
                }
                field("Puppy No."; Rec."Puppy No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy number for this appointment.';
                }
                field("Appointment Date"; Rec."Appointment DateTime")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the date of the appointment.';
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the status of the appointment.';
                    StyleExpr = StatusStyleTxt;
                }
            }
        }
    }

    views
    {
        view(Requested)
        {
            Caption = 'Requested';
            Filters = where(Status = const(Requested));
        }
        view(Confirmed)
        {
            Caption = 'Confirmed';
            Filters = where(Status = const(Confirmed));
        }
    }

    trigger OnAfterGetRecord()
    begin
        SetStatusStyle();
    end;

    var
        StatusStyleTxt: Text;

    local procedure SetStatusStyle()
    begin
        StatusStyleTxt := 'Standard';
        case Rec.Status of
            Rec.Status::Requested:
                StatusStyleTxt := 'Attention';
            Rec.Status::Confirmed:
                StatusStyleTxt := 'Favorable';
        end;
    end;
}