namespace BCTechDays.PuppyMgt.VetAppointment;

using BCTechDays.PuppyMgt.Common;

page 50109 "VetAppointmentHisFactBox_TD"
{
    ApplicationArea = All;
    Caption = 'Appointment History FactBox';
    PageType = CardPart;
    SourceTable = Puppy_TD;
    InherentEntitlements = X;
    InherentPermissions = X;

    layout
    {
        area(Content)
        {

            field("No."; Rec."No.")
            {
                ApplicationArea = All;
                Caption = 'Puppy No.';
                ToolTip = 'Puppy No. used to identify the puppy.';

                trigger OnDrillDown()
                begin
                    ShowDetails();
                end;
            }
            group(General)
            {
                Caption = 'General';
                ShowCaption = false;
                Visible = false;
                field("Created Appointment"; Rec."Created Appointment")
                {
                    ToolTip = 'No. of Created Appointment';
                    DrillDownPageId = VetAppointmentList_TD;
                }
                field("Requested Appointment"; Rec."Requested Appointment")
                {
                    ToolTip = 'No. of Requested Appointment';
                    DrillDownPageId = "VetAppointmentList_TD";
                }
                field("Confirmed Appointment"; Rec."Confirmed Appointment")
                {
                    ToolTip = 'No. of Confirmed Appointment';
                    DrillDownPageId = "VetAppointmentList_TD";
                }
                field("Cancelled Appointment"; Rec."Cancelled Appointment")
                {
                    ToolTip = 'No. of Cancelled Appointment';
                    DrillDownPageId = "VetAppointmentList_TD";
                }
            }
            cuegroup(Control2)
            {
                ShowCaption = false;
                field(NoofCreatedAppointment; Rec."Created Appointment")
                {
                    ToolTip = 'No. of Created Appointment';
                    DrillDownPageId = VetAppointmentList_TD;
                }
                field(oofRequestedAppointment; Rec."Requested Appointment")
                {
                    ToolTip = 'No. of Requested Appointment';
                    DrillDownPageId = "VetAppointmentList_TD";
                }
                field(oofConfirmedAppointment; Rec."Confirmed Appointment")
                {
                    ToolTip = 'No. of Confirmed Appointment';
                    DrillDownPageId = "VetAppointmentList_TD";
                }
                field(oofCancelledAppointment; Rec."Cancelled Appointment")
                {
                    ToolTip = 'No. of Cancelled Appointment';
                    DrillDownPageId = "VetAppointmentList_TD";
                }
            }
        }
    }

    local procedure ShowDetails()
    begin
        PAGE.Run(PAGE::PuppyCard_TD, Rec);
    end;
}