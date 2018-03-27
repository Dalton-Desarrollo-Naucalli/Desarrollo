<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Frm_MonitorGeneralSeguros.aspx.cs" Inherits="Funcionalidad_Frm_MonitorGeneralSeguros" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/Seguros.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .dxeBase {
            font: 12px Tahoma, Geneva, sans-serif;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <table class="auto-style1">
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td>
                        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="true" Width="100%" HeaderText="MONITOR GENERAL DE PÓLIZAS DE SEGUROS" HeaderStyle-HorizontalAlign="Center" Font-Size="Medium" ForeColor="Black">
                            <HeaderStyle HorizontalAlign="Center" />
                            <PanelCollection>
                                <dx:PanelContent runat="server">
                                    <table class="dx-justification">
                                        <tr>
                                            <td>
                                                <dx:ASPxTextBox ID="txtBan" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtBan" Width="170px" ClientVisible="False">
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <dx:ASPxGridView ID="gvMonitorSeg" runat="server" ClientIDMode="AutoID" ClientInstanceName="gvMonitorSeg" Width="100%" KeyFieldName="cred_id">
                                                    <ClientSideEvents
                                                        RowDblClick="function(s, e) {
                                                            OnGridFocusedRowChangedIdParMonitorSeguros();
                                                        }"
                                                        CustomButtonClick="function(s, e) {
                                                            if (e.buttonID == 'BTNRenovar'){
                                                                txtBan.SetText('Renovar');
                                                                OnGridFocusedRowChangedMonitor();
                                                            }
                                                            if (e.buttonID == 'BTNCancelar'){
                                                                txtBan.SetText('Cancelar');
                                                                //OnGridFocusedRowChangedMonitor();
                                                            }
                                                            if (e.buttonID == 'BTNAgregarEndoso'){
                                                                txtBan.SetText('AEndoso');
                                                                OnGridFocusedRowChangedMonitor();
                                                            }
                                                        }" />
                                                    <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" HorizontalScrollBarMode="Auto" />
                                                    <SettingsBehavior AllowSelectSingleRowOnly="True" AllowFocusedRow="True" ConfirmDelete="True" />
                                                    <SettingsPager EnableAdaptivity="true"></SettingsPager>
                                                    <SettingsPopup>
                                                        <EditForm Width="800px" />
                                                    </SettingsPopup>
                                                    <SettingsText ConfirmDelete="¿Esta usted seguro de cancelar el registro?" PopupEditFormCaption="Formulario" />
                                                    <EditFormLayoutProperties>
                                                        <SettingsItems Width="200px" />
                                                    </EditFormLayoutProperties>
                                                </dx:ASPxGridView>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                        </tr>
                                    </table>
                                    &nbsp;
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxRoundPanel>
                    </td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
