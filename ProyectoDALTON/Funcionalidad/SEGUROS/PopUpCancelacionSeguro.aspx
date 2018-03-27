<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopUpCancelacionSeguro.aspx.cs" Inherits="Funcionalidad_DemoForm" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript">
        var uploadInProgress = false,
            submitInitiated = false,
            uploadErrorOccurred = false;
        uploadedFiles = [];
        function onFileUploadComplete(s, e) {
            var callbackData = e.callbackData.split("|"),
                uploadedFileName = callbackData[0],
                isSubmissionExpired = callbackData[1] === "True";
            uploadedFiles.push(uploadedFileName);

            if (e.errorText.length > 0 || !e.isValid)
                uploadErrorOccurred = true;

            if (isSubmissionExpired && UploadedFilesTokenBox.GetText().length > 0) {
                var removedAfterTimeoutFiles = UploadedFilesTokenBox.GetTokenCollection().join("\n");
                UploadedFilesTokenBox.ClearTokenCollection();
            }
        }
        function onFileUploadStart(s, e) {
            uploadInProgress = true;
            uploadErrorOccurred = false;
            UploadedFilesTokenBox.SetIsValid(true);
        }
        function onFilesUploadComplete(s, e) {
            uploadInProgress = false;
            for (var i = 0; i < uploadedFiles.length; i++)
                UploadedFilesTokenBox.AddToken(uploadedFiles[i]);
            updateTokenBoxVisibility();
            uploadedFiles = [];
            if (submitInitiated) {
                SubmitButton.SetEnabled(true);
                SubmitButton.DoClick();
            }
        }
        function onSubmitButtonInit(s, e) {
            s.SetEnabled(true);
        }
        function onSubmitButtonClick(s, e) {
            ASPxClientEdit.ValidateGroup();
            if (!formIsValid())
                e.processOnServer = false;
            else if (uploadInProgress) {
                s.SetEnabled(false);
                submitInitiated = true;
                e.processOnServer = false;
            }
        }
        function onTokenBoxValidation(s, e) {
            var isValid = DocumentsUploadControl.GetText().length > 0 || UploadedFilesTokenBox.GetText().length > 0;
            e.isValid = true;
        }
        function onTokenBoxValueChanged(s, e) {
            updateTokenBoxVisibility();
        }
        function updateTokenBoxVisibility() {
            var isTokenBoxVisible = UploadedFilesTokenBox.GetTokenCollection().length > 0;
            UploadedFilesTokenBox.SetVisible(isTokenBoxVisible);
        }
        function formIsValid() {
            return !ValidationSummary.IsVisible() && true && UploadedFilesTokenBox.GetIsValid() && true;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxHiddenField runat="server" ID="HiddenField" ClientInstanceName="HiddenField" />
        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="True"
            HeaderText="Registro de cancelación de pólizas" Font-Bold="true" Font-Size="Medium" Width="100%">
            <PanelCollection>
                <dx:PanelContent>
                    <dx:ASPxFormLayout ID="FormLayout" runat="server" RequiredMarkDisplayMode="Auto"
                        Styles-LayoutGroupBox-Caption-CssClass="layoutGroupBoxCaption" UseDefaultPaddings="false" AlignItemCaptionsInAllGroups="true" Width="100%">
                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500" />
                        <Items>
                            <dx:LayoutGroup Caption="Cancelar póliza de seguro">
                                <Items>
                                    <dx:LayoutItem Caption="Folio de cancelación">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxTextBox ID="txtFolio" runat="server" NullText="Ingrese el folio de cancelación" Width="100%" CssClass="maxWidth">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="false" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom" />
                                                        </dx:ASPxTextBox>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>

                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem Caption="Fecha de cancelación">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxDateEdit ID="txtFechaCancelacion" runat="server">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom">
                                                                <RequiredField IsRequired="True" ErrorText="Debe especificar la fecha de cancelación de la póliza" />
                                                            </ValidationSettings>
                                                        </dx:ASPxDateEdit>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>

                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem ShowCaption="False">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxUploadControl runat="server" ID="DocumentsUploadControl" ClientInstanceName="DocumentsUploadControl" Width="100%"
                                                    AutoStartUpload="true" ShowProgressPanel="True" ShowTextBox="false" BrowseButton-Text="Agregar archivo de cancelación" FileUploadMode="OnPageLoad"
                                                    OnFileUploadComplete="DocumentsUploadControl_FileUploadComplete">
                                                    <AdvancedModeSettings EnableMultiSelect="true" EnableDragAndDrop="true" ExternalDropZoneID="dropZone" />
                                                    <ValidationSettings
                                                        AllowedFileExtensions=".pdf"
                                                        MaxFileSize="4194304">
                                                    </ValidationSettings>
                                                    <ClientSideEvents
                                                        FileUploadComplete="onFileUploadComplete"
                                                        FilesUploadComplete="onFilesUploadComplete"
                                                        FilesUploadStart="onFileUploadStart" />
                                                </dx:ASPxUploadControl>
                                                <br /> 
                                                <dx:ASPxValidationSummary runat="server" ID="ValidationSummary" ClientInstanceName="ValidationSummary"
                                                    RenderMode="Table" Width="250px" ShowErrorAsLink="false" />
                                                <br />
                                                
                                                <dx:ASPxTokenBox runat="server" Width="100%" ID="UploadedFilesTokenBox" ClientInstanceName="UploadedFilesTokenBox"
                                                    NullText="Buscar archivo de cancelación..." AllowCustomTokens="false" ClientVisible="false">
                                                    <ClientSideEvents Init="updateTokenBoxVisibility" ValueChanged="onTokenBoxValueChanged" Validation="onTokenBoxValidation" />
                                                    <ValidationSettings EnableCustomValidation="true" />
                                                </dx:ASPxTokenBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>

                                    <dx:LayoutItem HorizontalAlign="Right" ShowCaption="False">
                                        <ParentContainerStyle CssClass="mobileAlign"></ParentContainerStyle>
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <table style="width:100%">
                                                    <tr>
                                                        <td style="padding:5px">
                                                            <dx:ASPxButton runat="server" ID="SubmitButton" ClientInstanceName="SubmitButton" Text="Confirmar cancelación" AutoPostBack="False"
                                                                OnClick="SubmitButton_Click" ValidateInvisibleEditors="true" ClientEnabled="false">
                                                                <ClientSideEvents Init="onSubmitButtonInit" Click="onSubmitButtonClick" />
                                                            </dx:ASPxButton>
                                                        </td>
                                                        <td style="padding:5px">
                                                            <dx:ASPxButton runat="server" ID="btnAbortar" ClientInstanceName="btnAbortar" Text="Cancelar operación">
                                                                <ClientSideEvents Click="function(s, e){window.parent.hideModal();}" />
                                                            </dx:ASPxButton>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                </Items>
                            </dx:LayoutGroup>
                        </Items>
                    </dx:ASPxFormLayout>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>
    </form>
</body>
</html>
