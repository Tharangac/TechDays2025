namespace DefaultPublisher.BCTechDays2025;
using TechDays.TechDays;
using Microsoft.Inventory.Item;
using MAIN.MAIN;
using Microsoft.Sales.Customer;

page 50101 "PuppyList_TD"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Puppy_TD;
    CardPageId = "PuppyCard_TD";
    Editable = false;
    Caption = 'Puppies';
    InherentPermissions = X;
    InherentEntitlements = X;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy number.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy name.';
                }
                field(Breed; Rec.Breed)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy breed.';
                }
                field("Birth Date"; Rec."Birth Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy birth date.';
                }
            }
        }
        area(FactBoxes)
        {
            part(vetAppointmentHistory; VetAppointmentHisFactBox_TD)
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
                Caption = 'Vet Appointment History';
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RequestVetAppointment)
            {
                ApplicationArea = All;
                Caption = 'Request Vet Appointment';
                Image = Calendar;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Request a new veterinary appointment for this puppy.';

                trigger OnAction()
                var
                    VetAppointmentMgt: Codeunit "VetAppointmentMgt._TD";
                    VetAppointmentRequestMessageLbl: Label 'Do you want to request a vet appointment for %1?', Comment = '%1 is the puppy name';
                    RequestSentNotificationLbl: Label 'Appointment request sent.';
                begin
                    if not Confirm(VetAppointmentRequestMessageLbl, true, Rec.Name) then
                        exit;

                    VetAppointmentMgt.RequestAppointment(Rec."No.");
                    Message(RequestSentNotificationLbl);
                end;
            }
        }
        area(Navigation)
        {
            action(ShowAppointmentHistory)
            {
                ApplicationArea = All;
                Caption = 'Show Appointment History';
                Image = History;
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'View the appointment history for the selected puppy.';

                trigger OnAction()
                var
                    VetAppointment: Record "VetAppointment_TD";
                    VetAppointmentList: Page VetAppointmentList_TD;
                begin
                    VetAppointment.SetFilter("Puppy No.", Rec."No.");
                    VetAppointmentList.SetTableView(VetAppointment);
                    VetAppointmentList.RunModal();
                end;
            }
        }
    }
}