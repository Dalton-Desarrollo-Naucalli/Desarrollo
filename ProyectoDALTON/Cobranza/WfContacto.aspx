<%@ Page Language="VB" AutoEventWireup="false" CodeFile="WfContacto.aspx.vb" Inherits="MiFuncionalidad_WfContacto" %>
<%@ Register Assembly="DevExpress.Data.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Pantalla Aplicación de Cobranza</title>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" ShowCollapseButton="True" ShowHeader="False" Theme="Office2003Blue" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <table class="auto-style40">
                        <tr>
                            <td>
                                <dx:ASPxButton ID="btnAgregar" runat="server" ToolTip="Agregar" ClientInstanceName="btnAgregar" AutoPostBack="False" EnableClientSideAPI="false">
                                    <ClientSideEvents Click="function(s, e) {OnNewRowClicked();}" />
                                    <Image IconID="actions_add_32x32"/>
                                </dx:ASPxButton>
                            </td>
                            <td>
                                <dx:ASPxButton ID="btnEditar" runat="server" ToolTip="Editar" ClientInstanceName="btnEditar" AutoPostBack="False" EnableClientSideAPI="false">
                                    <ClientSideEvents Click="function(s, e) {OnEditRowClicked();}" />
                                    <Image IconID="edit_edit_32x32"/>
                                </dx:ASPxButton>
                            </td>
                            <td>
                                <dx:ASPxButton ID="btnEliminar" runat="server" ToolTip="Eliminar" AutoPostBack="False" ClientInstanceName="btnEliminar" EnableClientSideAPI="True">
                                    <ClientSideEvents Click="function(s, e) {OnConfirmDeleteRowsClicked();}" />
                                    <Image IconID="edit_delete_32x32"/>
                                </dx:ASPxButton>
                            </td>
                            <td>
                                <dx:ASPxButton ID="btnCancelar" runat="server" AutoPostBack="False" ClientInstanceName="btnCancelar" ToolTip="Cancelar" EnableClientSideAPI="True">
                                    <ClientSideEvents Click="function(s, e) {OnDiscardChangesClicked();}" />
                                    <Image IconID="actions_cancel_32x32"/>
                                </dx:ASPxButton>
                            </td>
                            <td>
                                <dx:ASPxButton ID="btnAplicar" runat="server" AutoPostBack="False" ClientInstanceName="btnAplicar" ToolTip="Aplicar" ValidationGroup="reqError1" EnableClientSideAPI="true" CausesValidation="False">
                                    <ClientSideEvents Click="function(s, e) {OnSaveChangesClicked();}" />
                                    <Image IconID="actions_apply_32x32"/>
                                </dx:ASPxButton>
                            </td>
                            <td>
                                <dx:ASPxButton ID="btnFiltrar" runat="server" AutoPostBack="False" ClientInstanceName="btnFiltrar" ToolTip="Filtrar" EnableClientSideAPI="True">
                                    <ClientSideEvents Click="function(s, e) {OnFilterClicked(); }" />
                                        <Image IconID="filter_filter_32x32"/>
                                </dx:ASPxButton> 
                            </td>
                            <td> 
                                <dx:ASPxButton ID="btnBuscar" runat="server" ClientInstanceName="btnBuscar" ToolTip="Buscar"  EnableClientSideAPI="True">
                                    <Image IconID="find_find_32x32"/>
                                </dx:ASPxButton> 
                            </td>
                            <td> 
                                <dx:ASPxButton ID="btnDeshacer" runat="server" ClientInstanceName="btnDeshacer" ToolTip="Deshacer" AutoPostBack="False" EnableClientSideAPI="True">
                                    <ClientSideEvents Click="function(s, e) {OnUndoChangesClicked(); }" />
                                        <Image IconID="history_undo_32x32"/>
                                </dx:ASPxButton>
                            </td>
                            <td>
                                <dx:ASPxButton ID="btnRehacer" runat="server" ClientInstanceName="btnRehacer" ToolTip="Rehacer" AutoPostBack="False" EnableClientSideAPI="True">
                                    <ClientSideEvents Click="function(s, e) {OnRedoChangesClicked();}" />
                                    <Image IconID="history_redo_32x32" />
                                </dx:ASPxButton>
                            </td>
                        </tr>
                    </table>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>

        <br />
        
        <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" ShowCollapseButton="True" ShowHeader="False" Width="100%" Theme="Office2003Blue">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <table style="width:100%">
                        <tr>
                            <td style="text-align:center">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblNombre" runat="server" Text="Nombre:"/>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="comboNombre" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="text-align:center">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblVIN" runat="server" Text="VIN:"/>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="comboVIN" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="text-align:center">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblReferencia" runat="server" Text="Referencia:"/>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="comboReferencia" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="text-align:center">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblNoContrato" runat="server" Text="No de Contrato:"/>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="comboNoContrato" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>

        <br />
                            
        <dx:ASPxRoundPanel ID="ASPxRoundPanel3" runat="server" ShowCollapseButton="True" ShowHeader="False" Theme="Office2003Blue" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <dx:ASPxPageControl ID="prod" runat="server" EnableTheming="True" Theme="Office2010Blue" Width="100%">
                        <TabPages>
                            <dx:TabPage Name="tabMnto" Text="Contacto">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                        <table style="width:100%" border="0" >
                                            <tr>
                                                <td style="text-align:center">
                                                    <table style="width:50%" border="0">
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblNombreDeLaAgencia" runat="server" Text="Nombre de la agencia:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxLabel ID="txtNombreDeLaAgencia" runat="server" Text="Bimbo"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblNumeroDeContratoGBR" runat="server" Text="Número de Contrato GBR:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxLabel ID="txtNumeroDeContratoGBR" runat="server" Text="9653876309"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblDomicilio" runat="server" Text="Domicilio:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxLabel ID="txtDomicilio" runat="server" Text="Paseo de los gigantes #77, Mayorazgoz de los gigantes, Atizapan de Zaragoza"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblDomicilioAval" runat="server" Text="Domicilio Aval:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxLabel ID="txtDomicilioAval" runat="server" Text="Colima # 76, Colonia Roma, Miguel Hidalgo, CDMX"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblVIN1" runat="server" Text="VIN:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxLabel ID="txtVIN" runat="server" Text="645387923465"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblTelefono1" runat="server" Text="Teléfono1:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxLabel ID="txtTelefono1" runat="server" Text="0445514658099"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblTelefono2" runat="server" Text="Teléfono2:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxLabel ID="txtTelefono2" runat="server" Text="52159911"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblCorreo" runat="server" Text="Correo:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxLabel ID="txtCorreo" runat="server" Text="carlosv.bimbo@gmail.com"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblAval" runat="server" Text="Aval:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxLabel ID="txtAval" runat="server" Text="Carlos Pérez 66725598"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblReferencia1" runat="server" Text="Referencia1:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxLabel ID="txtReferencia1" runat="server" Text="María Díaz Ramírez 55221166"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblReferencia2" runat="server" Text="Referencia2:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxLabel ID="txtReferencia2" runat="server" Text="Juan López Pasos 55352760"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblDatosDelApoderado" runat="server" Text="Datos del Apoderado:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxLabel ID="txtDatosDelApoderado" runat="server" Text="Manuel López 55352760"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblLineaDeFondeoAsignada" runat="server" Text="Linea de Fondeo Asignada:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxLabel ID="txtLineaDeFondeoAsignada" runat="server" Text="BURSA"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblTipoDeCliente" runat="server" Text="Tipo de Cliente:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxLabel ID="txtTipoDeCliente" runat="server" Text="Agencia"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxButton ID="buttonBloqueo" runat="server" Text="Aviso de Bloqueo" AutoPostBack="true"  />
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxButton ID="buttonDesbloqueo" runat="server" Text="Aviso de Desbloqueo" AutoPostBack="true" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                        </TabPages>
                    </dx:ASPxPageControl>
                </dx:PanelContent>
          </PanelCollection>
        </dx:ASPxRoundPanel>
    </form>
</body>
</html>




