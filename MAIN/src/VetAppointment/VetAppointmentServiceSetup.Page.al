namespace BCTechDays.PuppyMgt.VetAppointment;

using System.Utilities;
using System.Environment;
using BCTechDays.PuppyMgt.Common;
using BCTechDays.PuppyMgt.RESTClient;
using BCTechDays.PuppyMgt.HTTPClient;

page 50112 "VetAppointmentServiceSetup_TD"
{
    Caption = 'Vet Appointment Service Setup';
    PageType = NavigatePage;
    SourceTable = PuppyMgtSetup_TD;
    SourceTableTemporary = true;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(StandardBanner)
            {
                ShowCaption = false;
                Editable = false;
                Visible = TopBannerVisible and not (Step = Step::Finish);
                field(MediaResourcesStandard; MediaResourcesStandard."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }
            group(FinishedBanner)
            {
                ShowCaption = false;
                Editable = false;
                Visible = TopBannerVisible and (Step = Step::Finish);
                field(MediaResourcesDone; MediaResourcesDone."Media Reference")
                {
                    ApplicationArea = All;
                    Editable = false;
                    ShowCaption = false;
                }
            }

            group(Intro)
            {
                ShowCaption = false;
                Visible = Step = Step::Start;
                group(Welcome)
                {
                    Caption = 'Welcome to Vet Appointment Service Setup';
                    group(Group18)
                    {
                        ShowCaption = false;
                        InstructionalText = 'You can set up a Vet Appointment service connection to enable seamless integration.';
                    }
                }
            }

            group(Step2)
            {
                ShowCaption = false;
                InstructionalText = 'Select type of integration with your VET service provider and then specify connection information.';
                Visible = Step = Step::EndpointSetup;

                field("Integration Type"; Rec."Integration Type")
                {
                    ToolTip = 'Integration Type';
                    ShowMandatory = true;
                }
                group(HTTPClientConnectionInfo)
                {
                    ShowCaption = false;
                    Visible = Rec."Integration Type" in [Rec."Integration Type"::HTTPClient, Rec."Integration Type"::RESTClient];

                    field("API Endpoint"; Rec."API Endpoint")
                    {
                        ToolTip = 'API Endpoint';
                        ExtendedDatatype = URL;
                        ShowMandatory = true;
                    }
                }
            }
            group(Step3)
            {
                ShowCaption = false;
                Visible = Step = Step::Finish;

                group("That's it!")
                {
                    Caption = 'That''s it!';
                    group(Group25)
                    {
                        ShowCaption = false;
                        InstructionalText = 'To save this setup, choose Finish.';
                    }
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(ActionBack)
            {
                ApplicationArea = All;
                Caption = 'Back';
                Enabled = Step <> Step::Start;
                Image = PreviousRecord;
                InFooterBar = true;
                trigger OnAction()
                begin
                    NextStep(true);
                end;
            }
            action(ActionNext)
            {
                ApplicationArea = All;
                Caption = 'Next';
                Enabled = Step <> Step::Finish;
                Image = NextRecord;
                InFooterBar = true;
                trigger OnAction()
                begin
                    NextStep(false);
                end;
            }
            action(ActionFinish)
            {
                ApplicationArea = All;
                Caption = 'Finish';
                Enabled = Step = Step::Finish;
                Image = Approve;
                InFooterBar = true;
                trigger OnAction()
                begin
                    FinishAction();
                end;
            }
        }
    }

    trigger OnInit()
    begin
        LoadTopBanners();
    end;

    trigger OnOpenPage()
    var
        VetServiceSetup: Record PuppyMgtSetup_TD;
    begin
        Rec.Init();
        if VetServiceSetup.Get() then
            Rec.TransferFields(VetServiceSetup);
        if Rec.Insert() then;
        Step := (Rec."API Endpoint" <> '') ? Step::EndpointSetup : Step::Start;
    end;

    var
        MediaRepositoryDone: Record "Media Repository";
        MediaRepositoryStandard: Record "Media Repository";
        MediaResourcesDone: Record "Media Resources";
        MediaResourcesStandard: Record "Media Resources";
        Step: Option Start,EndpointSetup,Finish;
        // TODO: add a point to presentaiton to make sure we use SecretText and do not store secrets in table field directly.
        TopBannerVisible: Boolean;

    local procedure StorePuppyMgtSetup()
    var
        PuppyMgtSetup: Record PuppyMgtSetup_TD;
    begin
        PuppyMgtSetup.InsertIfNotExists();
        PuppyMgtSetup.TransferFields(Rec, false);
        PuppyMgtSetup.Modify(true);
    end;

    local procedure FinishAction()
    begin
        StorePuppyMgtSetup();
        CurrPage.Close();
    end;

    local procedure NextStep(Backwards: Boolean)
    begin
        if Backwards then
            Step := Step - 1
        else
            Step := Step + 1;
    end;

    local procedure LoadTopBanners()
    begin
        if MediaRepositoryStandard.Get('AssistedSetup-NoText-400px.png', Format(CurrentClientType())) and
            MediaRepositoryDone.Get('AssistedSetupDone-NoText-400px.png', Format(CurrentClientType()))
        then
            if MediaResourcesStandard.Get(MediaRepositoryStandard."Media Resources Ref") and
                MediaResourcesDone.Get(MediaRepositoryDone."Media Resources Ref")
        then
                TopBannerVisible := MediaResourcesDone."Media Reference".HasValue();
    end;
}
