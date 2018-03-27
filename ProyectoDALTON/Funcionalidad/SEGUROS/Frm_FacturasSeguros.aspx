<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Frm_FacturasSeguros.aspx.cs" Inherits="Frm_FacturasSeguros" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 27px;
            font-weight: 700;
        }
        .auto-style2 {
            height: 214px;
        }
    </style>
    <script type="text/javascript">
        function onFileUploadComplete(s, e) {
            //alert(e.errorText);
            if(e.callbackData) {
                var fileData = e.callbackData.split('|');
                var fileName = fileData[0],
                    fileUrl = fileData[1],
                    fileSize = fileData[2];
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <dx:ASPxRoundPanel ID="PanelPrincipal" runat="server" ClientIDMode="AutoID" ClientInstanceName="PanelPrincipal" ShowCollapseButton="True" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server" SupportsDisabledAttribute="True">
                        <table class="style16" width:"100%">
                            <tr>
                                <td align:"center" width:"800">
                                    <dx:ASPxLabel ID="lblAccesos" runat="server" ClientIDMode="AutoID" ClientInstanceName="lblAccesos" />
                                </td>
                            </tr>
                        </table>
                        <table style=" width:"100%">
                            <tr>
                                <td class="auto-style1" colspan="3">
                                    <dx:ASPxTextBox ID="txtNomArchivo" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtNomArchivo" ClientVisible="False" Height="16px" Width="170px">
                                    </dx:ASPxTextBox>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style1" colspan="2">
                                    <br />
                                    <dx:ASPxUploadControl ID="UploadControl" runat="server" ClientInstanceName="UploadControl" Width="100%" NullText="Seleccione los archivos XML..." UploadMode="Advanced" ShowUploadButton="True" ShowProgressPanel="True" OnFileUploadComplete="UploadControl_FileUploadComplete">
                                        <AdvancedModeSettings EnableMultiSelect="True" EnableFileList="False" EnableDragAndDrop="True" />
                                        <ValidationSettings MaxFileSize="4194304" AllowedFileExtensions=".xml">
                                        </ValidationSettings>
                                        <ClientSideEvents FilesUploadStart="function(s, e) { 
                                            //s.ClearText();
                                            Login.Hide();
                                            gvFacSeg.Refresh();
                                            gvNoMatch.Refresh(); 
                                            lblLeyenda.SetVisible(true);
                                            lblArchivos.SetVisible(true);
                                            
                                            if(txtNomArchivo.GetText() == ''){
                                                gvFacSeg.SetVisible(true); 
                                                gvNoMatch.SetVisible(true);
                                                gvNoAuto.SetVisible(true); 
                                                lblLeyenda.SetVisible(true);
                                                lblArchivos.SetVisible(true);
                                                lblArchivos.SetText(s.cpArchivos);
                                            }
                                        }" 
                                            FileUploadComplete="onFileUploadComplete" />
                                    </dx:ASPxUploadControl>
                                    <br />
                                    <br />
                                    
                                    <%--<dx:ASPxButton ID="btnalmacenar" runat="server" AutoPostBack="False" ClientInstanceName="btnalmacenar" CssFilePath="~/App_Themes/BlackGlass/{0}/styles.css" CssPostfix="BlackGlass" Font-Bold="True" SpriteCssFilePath="~/App_Themes/BlackGlass/{0}/sprite.css" Text="Almacenar" Width="150px">
                                        <ClientSideEvents Click="function(s, e) {Login.Show();calRenombrar.PerformCallback();}" />
                                        <Image Url="~/Imagenes/guardaPasoActual.png">
                                        </Image>
                                        <Border BorderStyle="Double" />
                                    </dx:ASPxButton>
                                    <dx:ASPxCallback ID="calRenombrar" runat="server" ClientIDMode="AutoID" ClientInstanceName="calRenombrar" OnCallback="calRenombrar_Callback">
                                        <ClientSideEvents CallbackComplete="function(s, e) {
                                            var str = s.cpError;  
                                            if(str != &quot;OK&quot;){ 
                                                alert(str);
                                            }
                                            else{
                                                alert('Proceso terminado');gvFacSeg.Refresh();
                                            }
                                            Login.Hide();
                                            gvFacSeg.Refresh();gvNoMatch.Refresh(); 
                                            lblLeyenda.SetVisible(true);lblArchivos.SetVisible(true);
                                            //if(txtNomArchivo.GetText() != ''){
                                            if(txtNomArchivo.GetText() == ''){
                                                gvFacSeg.SetVisible(true); 
                                                gvNoMatch.SetVisible(true);
                                                gvNoAuto.SetVisible(true); 
                                                lblLeyenda.SetVisible(true);
                                                lblArchivos.SetVisible(true);
                                                lblArchivos.SetText(s.cpArchivos);
                                            }
                                        }" />
                                    </dx:ASPxCallback>--%>
                                </td>
                                <td class="auto-style1">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="3" style="text-align: right">
                                    <dx:ASPxLabel ID="lblLeyenda" runat="server" ClientIDMode="AutoID" ClientInstanceName="lblLeyenda" ClientVisible="False" style="font-weight: 700; text-align: right; font-size: 13px;" Text="Facturas en archivo: ">
                                    </dx:ASPxLabel>
                                    <dx:ASPxLabel ID="lblArchivos" runat="server" ClientIDMode="AutoID" ClientInstanceName="lblArchivos" ClientVisible="False" style="font-weight: 700; text-decoration: underline; font-size: 14px; color: #0000CC;">
                                    </dx:ASPxLabel>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" style="text-align: right">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <dx:ASPxGridView ID="gvFacSeg" runat="server" ClientIDMode="AutoID" ClientInstanceName="gvFacSeg" ClientVisible="False" KeyFieldName="ID" OnBatchUpdate="gvFacSeg_BatchUpdate" Width="100%" AutoGenerateColumns="False" Caption="Pólizas en el sistema Vs. Facturas Conciliadas">
                                        <ClientSideEvents EndCallback="function(s, e) {
                                            if(s.cpCambio != ''){
                                                //OnActualizaNoMatch();OnActualizaNoAutorizadas();
                                            }
                                            lblArchivos.SetText(s.cpArchivos);}" 
                                        Init="function(s, e) {
                                                if(s.cpCambio != ''){
                                                    //OnActualizaNoMatch();OnActualizaNoAutorizadas();
                                                }
                                            }" 
                                        RowClick="function(s, e) {
                                            onRowClick(s,e);
                                        }" />
                                        <SettingsEditing Mode="Batch">
                                            <BatchEditSettings StartEditAction="DblClick" />
                                        </SettingsEditing>
                                        <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" />
                                        <SettingsBehavior AutoExpandAllGroups="True" ColumnResizeMode="Control" ConfirmDelete="True" />
                                        <SettingsCommandButton>
                                            <NewButton ButtonType="Image" RenderMode="Image" Text="Nuevo">
                                                <Image Height="20px" Url="~/Imagenes/NEW_.png" Width="20px">
                                                </Image>
                                            </NewButton>
                                            <UpdateButton ButtonType="Link" RenderMode="Link" Text="Validar">
                                                <Image Height="30px" Url="~/Imagenes/editar.png" Width="30px">
                                                </Image>
                                            </UpdateButton>
                                            <CancelButton Text="Cancelar cambios">
                                                <Image AlternateText="Cancelar cambios" Height="30px" Url="~/Imagenes/Delete.png" Width="30px">
                                                </Image>
                                            </CancelButton>
                                            <EditButton ButtonType="Image" RenderMode="Image" Text="Editar">
                                                <Image Height="16px" Url="~/Imagenes/editar.png" Width="16px">
                                                </Image>
                                            </EditButton>
                                            <DeleteButton ButtonType="Image" RenderMode="Image" Text="Eliminar">
                                                <Image Height="16px" Url="~/Imagenes/Delete.png" Width="16px">
                                                </Image>
                                            </DeleteButton>
                                        </SettingsCommandButton>
                                        <SettingsPopup>
                                            <EditForm CloseOnEscape="True" />
                                        </SettingsPopup>
                                    </dx:ASPxGridView>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">&nbsp;</td>
                            </tr>
                            <tr>
                                <td style="vertical-align:top" class="auto-style2">
                                    <dx:ASPxGridView ID="gvNoAuto" runat="server" ClientIDMode="AutoID" ClientInstanceName="gvNoAuto" ClientVisible="False" Width="100%" OnCustomCallback="gvNoAuto_CustomCallback">
                                        <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" />
                                    </dx:ASPxGridView>
                                </td>
                                <td class="auto-style2">&nbsp;&nbsp; &nbsp;</td>
                                <td style="vertical-align:top" class="auto-style2">
                                    <dx:ASPxGridView ID="gvNoMatch" runat="server" ClientIDMode="AutoID" ClientInstanceName="gvNoMatch" ClientVisible="False" Font-Bold="False" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" Width="100%" OnCustomCallback="gvNoMatch_CustomCallback">
                                        <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFooter="True" />
                                    </dx:ASPxGridView>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                    <dx:ASPxLoadingPanel ID="ASPxLoadingPanel1" runat="server" ClientInstanceName="Login" CssFilePath="~/App_Themes/Aqua/{0}/styles.css" CssPostfix="Aqua" ImagePosition="Top" Modal="True">
                                        <Image Url="~/App_Themes/Aqua/Web/Loading.gif">
                                        </Image>
                                    </dx:ASPxLoadingPanel>
                                </td>
                            </tr>
                        </table>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>
        </div>
        <div class="uploadContainer">
            <br />
            <br />
            <p class="note">
                <br />
            </p>
        </div>
    </form>
</body>
</html>
