<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopUpComentario.aspx.cs" Inherits="Funcionalidad_PopUpComentario" %>
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
        function onSubmitButtonInit(s, e) {
            s.SetEnabled(true);
        }
        function onSubmitButtonClick(s, e) {
            if (formIsValid())
            {
                alert('Registro exitoso.');
                window.parent.hideModal();
            }
            else
            {
                alert('El comentario es requerido.');                
            }
        }
        function formIsValid() {
            return txtComentario.GetValue() !== ' ' && txtComentario.GetValue() !== 'undefined' && txtComentario.GetValue() !== null;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxHiddenField runat="server" ID="HiddenField" ClientInstanceName="HiddenField" />
        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="True"
            HeaderText="Agregar comentarios" Font-Bold="true" Font-Size="Medium" Width="100%">
            <PanelCollection>
                <dx:PanelContent>
                    <dx:ASPxFormLayout ID="FormLayout" runat="server" RequiredMarkDisplayMode="Auto"
                        Styles-LayoutGroupBox-Caption-CssClass="layoutGroupBoxCaption" UseDefaultPaddings="false" AlignItemCaptionsInAllGroups="true" Width="100%">
                        <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="500" />
                        <Items>
                            <dx:LayoutGroup Caption="Agregar comentario a la póliza de seguro">
                                <Items>
                                    <dx:LayoutItem Caption="Comentario">
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <div style="display: table; width: 100%">
                                                    <div class="content firstNamePadding">
                                                        <dx:ASPxTextBox ID="txtComentario" ClientInstanceName="txtComentario" runat="server" NullText="Ingrese su comentario" Width="100%" CssClass="maxWidth">
                                                            <ValidationSettings Display="Dynamic" RequiredField-IsRequired="false" ErrorDisplayMode="Text" SetFocusOnError="true" ErrorTextPosition="Bottom" />
                                                        </dx:ASPxTextBox>
                                                    </div>
                                                </div>
                                            </dx:LayoutItemNestedControlContainer>
                                        </LayoutItemNestedControlCollection>
                                    </dx:LayoutItem>

                                    <dx:EmptyLayoutItem Height="20" />

                                    <dx:LayoutItem HorizontalAlign="Right" ShowCaption="False">
                                        <ParentContainerStyle CssClass="mobileAlign"></ParentContainerStyle>
                                        <LayoutItemNestedControlCollection>
                                            <dx:LayoutItemNestedControlContainer>
                                                <table style="width:100%">
                                                    <tr>
                                                        <td style="padding:5px">
                                                            <dx:ASPxButton runat="server" ID="SubmitButton" ClientInstanceName="SubmitButton" Text="Agregar comentario" AutoPostBack="False"
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
