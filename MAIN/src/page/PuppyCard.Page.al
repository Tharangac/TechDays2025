namespace DefaultPublisher.BCTechDays2025;
using Microsoft.Inventory.Item;
using MAIN.MAIN;
using Microsoft.Sales.Customer;

page 50102 "PuppyCard_TD"
{
    PageType = Card;
    SourceTable = Puppy_TD;
    Caption = 'Puppy Card';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy number.';
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the puppy name.';
                    ShowMandatory = true;
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
            part(PuppyFactBox; "PuppyPictureFactbox_TD")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("No.");
                Caption = 'Puppy Picture';
            }
            part(VetAppointmentFactBox; VetAppointmentFactbox_TD)
            {
                ApplicationArea = All;
                SubPageLink = "Puppy No." = field("No.");
                Caption = 'Vet Appointment';
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
                    VetAppointmentRequestMessageLbl: Label 'Do you want to request a vet appointment for %1?', Comment = '%1 is the puppy name';
                    RequestSentNotificationLbl: Label 'Appointment request sent.';
                begin
                    if not Confirm(VetAppointmentRequestMessageLbl, true, Rec.Name) then
                        exit;

                    Rec.ReqeustVetAppointment();
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