<%@ Page Language="VB" AutoEventWireup="true" CodeFile="WfPagoDeClientes.aspx.vb" Inherits="Cobranza_WfPagoDeClientes" %>
<%@ Register Assembly="DevExpress.Data.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Gestión de Cobraza con Promesa de Pago, Moratorios y Bonificación</title>
    <link href="../Estilos/Principal.css" type="text/css" rel="stylesheet" />   
  


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
                    <table border="0">
                        <tr>
                            <td style="text-align:center">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblNombre" runat="server" Text="Cliente:"/>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="comboCliente" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="text-align:left; width:50%">
                                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <dx:ASPxLabel ID="txtNombreCliente" runat="server" Text="Nombre del Cliente"/>
                            </td>
                            <td style="text-align:center;"></td>
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
                            <dx:TabPage Name="tabMnto" Text="Pagos Renta Clientes" Enabled="true">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                        <table style="width:100%" border="0" >
                                            <tr>
                                                <td style="text-align:left; width:50%">
                                                    <table style="width:100%" border="0">
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblNombreCliente" runat="server" Text="Nombre de cliente:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtNombreDeCliente" runat="server" Width="250px" NullText="Nombre de cliente..." />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblIDCuenta" runat="server" Text="ID Cuenta:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxComboBox ID="comboIDCuenta" runat="server"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblNoIngreso" runat="server" Text="No Ingreso:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxComboBox ID="comboNoIngreso" runat="server"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left" rowspan="2">
                                                                <dx:ASPxLabel ID="lblNota" runat="server" Text="Nota:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtNota" runat="server" Width="250px" NullText="Nota..." />
                                                            </td>
                                                        </tr>
                                                    </table>                                                 
                                                </td>
                                                <td style="text-align:left; width:50%">
                                                    <table style="width:100%" border="0">
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblTipoPago" runat="server" Text="Tipo pago:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxComboBox ID="comboTipoPago" runat="server"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblFechaPago" runat="server" Text="Fecha pago:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtFechaDePago" runat="server" Width="250px" NullText="Fecha de pago..." />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblReferencia3" runat="server" Text="Referencia:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtReferencia" runat="server" Width="250px" NullText="Referencia..." />
                                                            </td>
                                                        </tr>                                                 
                                                    </table>                                                 
                                                </td>
                                            </tr>
                                            <tr style="height:20px"></tr>
                                            <tr>
                                                <td style="text-align:left; width:100%;" colspan="2">
                                                    <table style="width:100%" border="0">
                                                        <tr>
                                                            <td>
                                                                <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                                                            </td>
                                                        </tr> 
                                                    </table>                                                 
                                                </td>
                                            </tr>
                                            <tr style="height:20px"></tr>
                                            <tr>
                                                <td style="text-align:left; width:50%">
                                                    <table style="width:100%" border="0">
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblFacturasAdeudadas" runat="server" Text="Facturas adeudadas:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtFacturasAdeudadas" runat="server" Width="250px" NullText="Facturas adeudadas..." />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblSaldoEnCuenta" runat="server" Text="Saldo en cuenta:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtSaldoEnCuenta" runat="server" Width="250px" NullText="Saldo en cuenta..." />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblTotalNCAsignada" runat="server" Text="Total NC Asignada:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtTotalNCASignada" runat="server" Width="250px" NullText="Total NC Asignada..." />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left" rowspan="2">
                                                                <dx:ASPxLabel ID="lblSaldoAFavorPorNotasDeCredito" runat="server" Text="Saldo a favor por notas de crédito:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtSaldoAFavorPorNotasDeCredito" runat="server" Width="250px" NullText="Saldo a favor por notas de crédito..." />
                                                            </td>
                                                        </tr>
                                                    </table>                                                 
                                                </td>
                                                <td style="text-align:left; width:50%">
                                                    <table style="width:100%" border="0">
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblDifCambiaria" runat="server" Text="Dif cambiaria:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtDifCambiaria" runat="server" Width="250px" NullText="Dif cambiaria..." />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblTotales" runat="server" Text="Totales:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtTotales" runat="server" Width="250px" NullText="Totales..." />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblImporteDelDeposito" runat="server" Text="Importe del depósito:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtImporteDelDeposito" runat="server" Width="250px" NullText="Importe del depósito..." />
                                                            </td>
                                                        </tr>     
                                                        <tr>
                                                            <td style="width:15%; text-align:center">
                                                                <asp:Button ID="buttonActualizaPagos" runat="server" Text="Actualiza Pagos" />
                                                            </td>
                                                            <td style="width:35%; text-align:center">
                                                                <asp:Button ID="buttonAplicaPagos" runat="server" Text="Aplica Pagos" />
                                                            </td>
                                                        </tr>                                                        
                                                    </table>                                                 
                                                </td>
                                            </tr>
                                        </table>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                       
                            <dx:TabPage Name="tabMnto" Text="Asignación de Notas">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                         <table style="width:100%" border="0" >
                                            <tr>
                                                <td style="text-align:left">
                                                    <table style="width:100%" border="0">
                                                        <tr>
                                                            <td>

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




