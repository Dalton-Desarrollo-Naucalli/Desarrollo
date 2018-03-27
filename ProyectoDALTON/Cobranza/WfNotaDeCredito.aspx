<%@ Page Language="VB" AutoEventWireup="false" CodeFile="WfNotaDeCredito.aspx.vb" Inherits="MiFuncionalidad_WfNotaDeCredito" %>
<%@ Register Assembly="DevExpress.Data.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Pantalla Nota de Crédito</title>
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
                            <td>
                                <asp:Button ID="Button3" runat="server" Text="Cliente" />
                            </td>
                            <td style="width:25px"></td>
                            <td style="text-align:center">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxComboBox ID="comboNombre" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="width:25px"></td>
                            <td style="text-align:center">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxComboBox ID="comboVIN" runat="server" Width="800px"/>
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
                            <dx:TabPage Name="tabMnto" Text="Asignación de Notas">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                        <table style="width:100%" border="0" >
                                            <tr>
                                                <td style="text-align:center">
                                                    <table style="width:50%" border="0">
                                                        <tr>
                                                            <td style="width:200px; padding:6px; text-align:center">
                                                                <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="ID Fiscal:"/>
                                                            </td>
                                                            <td style="padding:6px">
                                                                <dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="250px" NullText="ID Fiscal..." />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:200px; padding:6px; text-align:left">
                                                                <dx:ASPxLabel ID="lblNumSucursal" runat="server" Text="ID Fiscal:"/>
                                                            </td>
                                                            <td style="padding:6px">
                                                                <dx:ASPxTextBox ID="txtIDFiscal" runat="server" Width="250px" NullText="ID Fiscal..." />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:200px; padding:6px; text-align:left">
                                                                <dx:ASPxLabel ID="lblTotalBruto" runat="server" Text="Total Bruto:"/>
                                                            </td>
                                                            <td style="padding:6px">
                                                                <dx:ASPxTextBox ID="txtTotalBruto" runat="server" Width="250px" NullText="Total Bruto..." />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:200px; padding:6px; text-align:left">
                                                                <dx:ASPxLabel ID="lblTotalImpuestos" runat="server" Text="Total Impuestos:"/>
                                                            </td>
                                                            <td style="padding:6px">
                                                                <dx:ASPxTextBox ID="txtTotalImpuestos" runat="server" Width="250px" NullText="Total Impuestos..." />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:200px; padding:6px; text-align:left">
                                                                <dx:ASPxLabel ID="lblFechaDeCorte" runat="server" Text="Fecha de Corte:"/>
                                                            </td>
                                                            <td style="padding:6px">
                                                                <dx:ASPxCalendar ID="calFechaDeCorte" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:200px; padding:6px; text-align:left">
                                                                <dx:ASPxLabel ID="lblFechaDePago" runat="server" Text="Fecha de Pago:"/>
                                                            </td>
                                                            <td style="padding:6px">
                                                                <dx:ASPxCalendar ID="calFechaDePago" runat="server" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:200px; padding:6px; text-align:left">
                                                                <dx:ASPxLabel ID="lblDiasDeRetraso" runat="server" Text="Dias de retraso:"/>
                                                            </td>
                                                            <td style="padding:6px">
                                                                <dx:ASPxTextBox ID="txtDiasDeRetraso" runat="server" Width="250px" NullText="Dias de retraso..." />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:200px; padding:6px; text-align:left">
                                                                <dx:ASPxLabel ID="lblMoratorios" runat="server" Text="Moratorios:"/>
                                                            </td>
                                                            <td style="padding:6px">
                                                                <dx:ASPxTextBox ID="txtMoratorios" runat="server" Width="250px" NullText="Moratorios..." />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:200px; padding:6px; text-align:left">
                                                                <dx:ASPxLabel ID="lblAplicacionNotasDeCredito" runat="server" Text="Aplicación Notas de Crédito:"/>
                                                            </td>
                                                            <td style="padding:6px">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxTextBox ID="txtAplicacionNotasDeCredito" runat="server" Width="250px" NullText="Aplicación Notas de Crédito..." />
                                                                        </td>
                                                                        <td style="width:15px"></td>
                                                                        <td>
                                                                            <asp:Button ID="Button1" runat="server" Text="Reg. NC" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:200px; padding:6px; text-align:left">
                                                                <dx:ASPxLabel ID="lblSaldoCalculado" runat="server" Text="Saldo calculado:"/>
                                                            </td>
                                                            <td style="padding:6px">
                                                                <dx:ASPxTextBox ID="txtSaldoCalculado" runat="server" Width="250px" NullText="Saldo calculado..." />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:200px; padding:6px; text-align:left">
                                                                <dx:ASPxLabel ID="lblDescuentoMoratorio" runat="server" Text="Descuento moratorio:"/>
                                                            </td>
                                                            <td style="padding:6px">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxTextBox ID="txtDescuentoMoratorio" runat="server" Width="250px" NullText="Descuento moratorio..." />
                                                                        </td>
                                                                        <td style="width:15px"></td>
                                                                        <td>
                                                                            <asp:Button ID="Button2" runat="server" Text="Autorizar" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:200px; padding:6px; text-align:left">
                                                                <dx:ASPxLabel ID="lblPagoEnLaMonedaDeLaFactura" runat="server" Text="Pago en la moneda de la factura:"/>
                                                            </td>
                                                            <td style="padding:6px">
                                                                <dx:ASPxTextBox ID="txtPagoEnLaMonedaDeLaFactura" runat="server" Width="250px" NullText="Pago en la moneda de la factura..." />
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




