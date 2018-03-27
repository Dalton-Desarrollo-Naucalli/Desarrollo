<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopUpRenovacionSeguros.aspx.cs" Inherits="Funcionalidad_PopUpRenovacionSeguros" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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
            e.isValid = isValid;
            if (!isValid) {
                e.errorText = "Es necesario seleccionar un archivo para agregarlo a la renovación.";
            }
        }
        function onTokenBoxValueChanged(s, e) {
            updateTokenBoxVisibility();
        }
        function updateTokenBoxVisibility() {
            var isTokenBoxVisible = UploadedFilesTokenBox.GetTokenCollection().length > 0;
            UploadedFilesTokenBox.SetVisible(isTokenBoxVisible);
        }
        function formIsValid() {
            return true;//!ValidationSummary.IsVisible() && txtFolio.GetIsValid() && UploadedFilesTokenBox.GetIsValid() && !uploadErrorOccurred;
        }
        function calculaCostoTotal() {
            var costoSinIva = 0;
            var iva = 0;
            var costoTotal = 0;
            var recargos = 0;
            var gastos = 0;

            if (!isNaN(txtCosto.GetValue())) {
                costoSinIva = txtCosto.GetValue();
            }
            if (!isNaN(txtIva.GetValue())) {
                iva = txtIva.GetValue();
            }
            if (!isNaN(txtRecargos.GetValue())) {
                recargos = txtRecargos.GetValue();
            }
            if (!isNaN(txtGastos.GetValue())) {
                gastos = txtGastos.GetValue();
            }

            costoTotal = parseFloat(costoSinIva) + parseFloat(iva) + parseFloat(gastos) - parseFloat(recargos);
            
            if (!isNaN(costoTotal)) {
                txtCostoTotal.SetText(costoTotal);
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxHiddenField runat="server" ID="HiddenField" ClientInstanceName="HiddenField" />
        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="True"
            HeaderText="Renovación de póliza" Font-Bold="true" Font-Size="Medium" Width="100%">
            <PanelCollection>
                <dx:PanelContent>
                    <dx:ASPxFormLayout ID="FormLayout" runat="server" RequiredMarkDisplayMode="Auto"
                        Styles-LayoutGroupBox-Caption-CssClass="layoutGroupBoxCaption" UseDefaultPaddings="false" AlignItemCaptionsInAllGroups="true" Width="100%">
                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500" />
                        <Items>
                            <dx:LayoutGroup Caption="Renovar póliza">
                                <Items>
                                    <dx:LayoutItem Caption="Aseguradora:">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxComboBox ID="cmbAseguradora" runat="server" ClientInstanceName="cmbAseguradora" Font-Size="Medium" Width="75%" ClientEnabled="True" ForeColor="Black" TabIndex="3" AutoPostBack="False">
                                                        </dx:ASPxComboBox>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem Height="20" />
                                    <dx:LayoutItem Caption="Número de póliza:">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxTextBox ID="txtPoliza" ClientInstanceName="txtPoliza" runat="server" NullText="Ingrese el número de póliza" Width="100%" CssClass="maxWidth" Font-Size="Medium">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom">
                                                                <RequiredField IsRequired="True" ErrorText="El número de póliza es requerido" />
                                                            </ValidationSettings>
                                                        </dx:ASPxTextBox>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem Caption="Fecha de emisión:">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxDateEdit ID="txtFechaEmision" runat="server" Font-Size="Medium">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom">
                                                                <RequiredField IsRequired="True" ErrorText="Debe especificar la fecha de emisión de la póliza" />
                                                            </ValidationSettings>
                                                        </dx:ASPxDateEdit>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem Caption="Fecha de vigencia:">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxDateEdit ID="txtFechaVigencia" runat="server" Font-Size="Medium">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom">
                                                                <RequiredField IsRequired="True" ErrorText="Debe especificar la fecha de vigencia de la póliza" />
                                                            </ValidationSettings>
                                                        </dx:ASPxDateEdit>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem Caption="Fecha de vencimiento:">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxDateEdit ID="txtFechaVencimiento" runat="server" Font-Size="Medium">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom">
                                                                <RequiredField IsRequired="True" ErrorText="Debe especificar la fecha de vencimiento de la póliza" />
                                                            </ValidationSettings>
                                                        </dx:ASPxDateEdit>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem Caption="Costo de la póliza:">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxTextBox ID="txtCosto" ClientInstanceName="txtCosto" runat="server" NullText="Ingrese el costo de la póliza" Width="100%" CssClass="maxWidth" DisplayFormatString="c" Font-Size="Medium">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom">
                                                                <RequiredField IsRequired="True" ErrorText="El costo de la póliza es requerido" />
                                                            </ValidationSettings>
                                                            <ClientSideEvents TextChanged="calculaCostoTotal" />
                                                        </dx:ASPxTextBox>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem Caption="IVA:">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxTextBox ID="txtIva" ClientInstanceName="txtIva" runat="server" NullText="Ingrese el monto del IVA" Width="100%" CssClass="maxWidth" DisplayFormatString="c" Font-Size="Medium">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom">
                                                                <RequiredField IsRequired="True" ErrorText="El IVA es requerido" />
                                                            </ValidationSettings>
                                                            <ClientSideEvents TextChanged="calculaCostoTotal" />
                                                        </dx:ASPxTextBox>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem Caption="Importe de gastos">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxTextBox ID="txtGastos" ClientInstanceName="txtGastos" runat="server" Width="100%" CssClass="maxWidth" DisplayFormatString="c" Font-Size="Medium">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom">
                                                                <RequiredField IsRequired="True" ErrorText="El campo Gasto es requerido" />
                                                            </ValidationSettings>
                                                            <ClientSideEvents TextChanged="calculaCostoTotal" />
                                                        </dx:ASPxTextBox>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem Caption="Importe de recargos">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxTextBox ID="txtRecargos" ClientInstanceName="txtRecargos" runat="server" Width="100%" CssClass="maxWidth" DisplayFormatString="c" Font-Size="Medium">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom">
                                                                <RequiredField IsRequired="True" ErrorText="Los recargos son requeridos" />
                                                            </ValidationSettings>
                                                            <ClientSideEvents TextChanged="calculaCostoTotal" />
                                                        </dx:ASPxTextBox>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem Caption="Costo total:">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxTextBox ID="txtCostoTotal" ClientInstanceName="txtCostoTotal" runat="server" Width="100%" CssClass="maxWidth" DisplayFormatString="c" Font-Size="Medium">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom">
                                                                <RequiredField IsRequired="True" ErrorText="Campo requerido" />
                                                            </ValidationSettings>
                                                        </dx:ASPxTextBox>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem Caption="¿Existe deducible de eventos mayores?">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxRadioButtonList ID="rblDeducible" runat="server" RepeatDirection="Horizontal" Width="100%" Paddings-Padding="0">
                                                    <Items>
                                                        <dx:ListEditItem Text="Si" Value="1" />
                                                        <dx:ListEditItem Text="No" Value="0" Selected="true" />
                                                    </Items>
                                                    <Border BorderColor="Transparent" />
                                                </dx:ASPxRadioButtonList>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem Caption="¿Quién compra?">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxComboBox ID="cmbQuienCompra" runat="server" ClientInstanceName="cmbQuienCompra" Font-Size="Medium" Width="75%" ClientEnabled="True" ForeColor="Black" AutoPostBack="False">
                                                    <Items>
                                                        <dx:ListEditItem Text="DES" Value="1" Selected="true"/>
                                                        <dx:ListEditItem Text="Cliente" Value="2"/>
                                                    </Items>
                                                </dx:ASPxComboBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem Caption="Agente de seguro:">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxTextBox ID="txtAgente" ClientInstanceName="txtAgente" runat="server" NullText="Ingrese el nombre del agente" Width="100%" CssClass="maxWidth"  Font-Size="Medium">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom">
                                                                <RequiredField IsRequired="True" ErrorText="El agente es requerido" />
                                                            </ValidationSettings>
                                                        </dx:ASPxTextBox>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem Caption="Cobertura">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <dx:ASPxComboBox ID="cmbCobertura" runat="server" ClientInstanceName="cmbCobertura" Font-Size="Medium" Width="75%" ClientEnabled="True" ForeColor="Black" AutoPostBack="False">
                                                </dx:ASPxComboBox>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem Caption="% deducible por daños:">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxTextBox ID="txtPorcentajeDeducible" ClientInstanceName="txtPorcentajeDeducible" runat="server" NullText="Porcentaje del deducible" Width="100%" CssClass="maxWidth" Font-Size="Medium">
                                                            <MaskSettings Mask="<0..100g>%" IncludeLiterals="None" />
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom">
                                                                <RequiredField IsRequired="True" ErrorText="El campo es requerido" />
                                                            </ValidationSettings>
                                                        </dx:ASPxTextBox>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem Caption="% deducible por robo total:">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxTextBox ID="txtPorcentajeRobo" ClientInstanceName="txtPorcentajeRobo" runat="server" NullText="Porcentaje del deducible por robo" Width="100%" CssClass="maxWidth"  Font-Size="Medium" DisplayFormatString="P">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom">
                                                                <RequiredField IsRequired="True" ErrorText="El campo es requerido" />
                                                            </ValidationSettings>
                                                        </dx:ASPxTextBox>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem Caption="Límite de gastos médicos:">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxTextBox ID="txtLimiteGastos" ClientInstanceName="txtLimiteGastos" runat="server" Width="100%" CssClass="maxWidth" DisplayFormatString="c" Font-Size="Medium">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom">
                                                                <RequiredField IsRequired="True" ErrorText="El campo es requerido" />
                                                            </ValidationSettings>
                                                        </dx:ASPxTextBox>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem Caption="Límite de responsabilidad civil:">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxTextBox ID="txtLimiteResponsabilidad" ClientInstanceName="txtLimiteResponsabilidad" runat="server" Width="100%" CssClass="maxWidth" DisplayFormatString="c" Font-Size="Medium">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom">
                                                                <RequiredField IsRequired="True" ErrorText="El campo es requerido" />
                                                            </ValidationSettings>
                                                        </dx:ASPxTextBox>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>
                                    <dx:EmptyLayoutItem Height="20" />


                                    <dx:LayoutItem Caption="Clave AMIS:">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxTextBox ID="txtAmis" ClientInstanceName="txtAmis" runat="server" NullText="Clave AMIS" Width="100%" CssClass="maxWidth" Font-Size="Medium">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="true" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom">
                                                                <RequiredField IsRequired="True" ErrorText="El campo es requerido" />
                                                            </ValidationSettings>
                                                        </dx:ASPxTextBox>
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
                                                    AutoStartUpload="true" ShowProgressPanel="True" ShowTextBox="false" BrowseButton-Text="Agregar archivo de póliza" FileUploadMode="OnPageLoad"
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
                                                    NullText="Agregar archivo de póliza..." AllowCustomTokens="false" ClientVisible="false">
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
                                                            <dx:ASPxButton runat="server" ID="SubmitButton" ClientInstanceName="SubmitButton" Text="Guardar renovación" AutoPostBack="False"
                                                                OnClick="SubmitButton_Click" ValidateInvisibleEditors="true" ClientEnabled="false">
                                                                <ClientSideEvents Init="onSubmitButtonInit" Click="onSubmitButtonClick" />
                                                            </dx:ASPxButton>
                                                        </td>
                                                        <td style="padding:5px">
                                                            <dx:ASPxButton runat="server" ID="btnCancelar" ClientInstanceName="btnAbortar" Text="Cancelar operación">
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
