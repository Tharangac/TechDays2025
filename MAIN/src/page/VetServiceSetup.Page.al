page 50105 "VetServiceSetup_TD"
{
    Caption = 'Vet Service Setup';
    PageType = NavigatePage;
    SourceTable = "Vet Service Setup";
    SourceTableTemporary = true;

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

            group(Step1)
            {
                ShowCaption = false;
                Visible = Step = Step::Start;
                group("Welcome to PageName")
                {
                    Caption = 'Welcome to PageName Setup';

                    group(Group18)
                    {
                        ShowCaption = false;
                        InstructionalText = 'Step1 - Replace this text with some instructions.';
                    }
                }
                group("Let's go!")
                {
                    Caption = 'Let''s go!';
                    group(Group22)
                    {
                        ShowCaption = false;
                        InstructionalText = 'Step1 - Replace this text with some more instructions.';
                    }
                }
            }

            group(Step2)
            {
                ShowCaption = false;
                InstructionalText = 'Step2 - Replace this text with some instructions.';
                Visible = Step = Step::EndpointSetup;
                //You might want to add fields here
            }


            group(Step3)
            {
                ShowCaption = false;
                Visible = Step = Step::Finish;
                group(Group23)
                {
                    ShowCaption = false;
                    InstructionalText = 'Step3 - Replace this text with some instructions.';
                }
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
        VetServiceSetup: Record "Vet Service Setup";
    begin
        Rec.Init();
        if VetServiceSetup.Get() then
            Rec.TransferFields(VetServiceSetup);
        Rec.Insert();
        Step := Step::Start;
    end;

    var
        MediaRepositoryDone: Record "Media Repository";
        MediaRepositoryStandard: Record "Media Repository";
        MediaResourcesDone: Record "Media Resources";
        MediaResourcesStandard: Record "Media Resources";
        Step: Option Start,EndpointSetup,Finish;
        // TODO: add a point to presentaiton to make sure we use SecretText and do not store secrets in table field directly. 
        TopBannerVisible: Boolean;

    local procedure StoreVetServiceSetup()
    var
        VetServiceSetup: Record "Vet Service Setup";
    begin
        VetServiceSetup.InsertIfNotExists();
        VetServiceSetup.TransferFields(Rec, false);
        VetServiceSetup.Modify(true);
    end;

    local procedure FinishAction()
    begin
        StoreVetServiceSetup();
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