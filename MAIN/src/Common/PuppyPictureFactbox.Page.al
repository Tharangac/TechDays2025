namespace BCTechDays.PuppyMgt.Common;

using System.IO;
using System.Device;

page 50106 "PuppyPictureFactbox_TD"
{
    Caption = 'Puppy Picture';
    DeleteAllowed = false;
    InsertAllowed = false;
    LinksAllowed = false;
    PageType = CardPart;
    SourceTable = Puppy_TD;
    InherentEntitlements = X;
    InherentPermissions = X;

    layout
    {
        area(content)
        {
            field(Image; Rec.Image)
            {
                ApplicationArea = All;
                ShowCaption = false;
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(TakePicture)
            {
                ApplicationArea = All;
                Caption = 'Take';
                Image = Camera;
                ToolTip = 'Activate the camera on the device.';
                Visible = CameraAvailable;

                trigger OnAction()
                begin
                    TakeNewPicture();
                end;
            }
            action(ImportPicture)
            {
                ApplicationArea = All;
                Caption = 'Import';
                Image = Import;
                ToolTip = 'Import a picture file.';

                trigger OnAction()
                var
                    FileManagement: Codeunit "File Management";
                    FileName: Text;
                    ClientFileName: Text;
                    InStr: InStream;
                begin
                    Rec.TestField("No.");
                    if Rec.Name = '' then
                        Error(MustSpecifyNameErr);

                    if Rec.Image.HasValue then
                        if not Confirm(OverrideImageQst) then
                            Error('');

                    ClientFileName := '';
                    UploadIntoStream(SelectPictureTxt, '', '', ClientFileName, InStr);
                    if ClientFileName <> '' then
                        FileName := FileManagement.GetFileName(ClientFileName);
                    if FileName = '' then
                        Error('');

                    Clear(Rec.Image);
                    Rec.Image.ImportStream(InStr, FileName);
                    Rec.Modify(true);
                end;
            }
            action(DeletePicture)
            {
                ApplicationArea = All;
                Caption = 'Delete';
                Enabled = DeleteExportEnabled;
                Image = Delete;
                ToolTip = 'Delete the record.';

                trigger OnAction()
                begin
                    Rec.TestField("No.");

                    if not Confirm(DeleteImageQst) then
                        exit;

                    Clear(Rec.Image);
                    Rec.Modify(true);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        SetEditableOnPictureActions();
    end;

    trigger OnOpenPage()
    begin
        CameraAvailable := Camera.IsAvailable();
    end;

    var
        Camera: Codeunit Camera;
        CameraAvailable: Boolean;
        OverrideImageQst: Label 'The existing picture will be replaced. Do you want to continue?';
        DeleteImageQst: Label 'Are you sure you want to delete the picture?';
        SelectPictureTxt: Label 'Select a picture to upload';
        DeleteExportEnabled: Boolean;
        MustSpecifyNameErr: Label 'You must specify a name before you can import a picture.';
        MimeTypeTok: Label 'image/jpeg', Locked = true;

    procedure TakeNewPicture()
    var
        PictureInstream: InStream;
        PictureDescription: Text;
    begin
        Rec.Find();
        Rec.TestField("No.");
        Rec.TestField(Name);

        if Rec.Image.HasValue() then
            if not Confirm(OverrideImageQst) then
                exit;

        if Camera.GetPicture(PictureInstream, PictureDescription) then begin
            Clear(Rec.Image);
            Rec.Image.ImportStream(PictureInstream, PictureDescription, MimeTypeTok);
            Rec.Modify(true)
        end;
    end;

    local procedure SetEditableOnPictureActions()
    begin
        DeleteExportEnabled := Rec.Image.HasValue;
    end;

    procedure IsCameraAvailable(): Boolean
    begin
        exit(Camera.IsAvailable());
    end;
}
