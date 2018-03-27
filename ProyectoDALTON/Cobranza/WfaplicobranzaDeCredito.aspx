<%@ Page Language="VB" AutoEventWireup="false" CodeFile="WfaplicobranzaDeCredito.aspx.vb" Inherits="Cobranza_WfaplicobranzaDeCredito" %>
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
                                            <dx:ASPxLabel ID="ASPxLabel66" runat="server" Text="ID Cliente:"/>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="comboClientes" runat="server"/>
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
                            <dx:TabPage Name="tabMnto" Text="Aplicación de cobranza de crédito">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                        <table style="width:100%" border="0" >
                                            <tr>
                                                <td style="text-align:center">
                                                    <table>
                                                        <tr>
                                                            <td style="text-align:right">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="ASPxLabel63" runat="server" Text="Acreditado:"/>
                                                            </td>
                                                            <td style="width:5px"></td>
                                                            <td style="text-align:left">
                                                                <dx:ASPxLabel ID="lblAcreditado" runat="server" Text="Juan Pérez García"/>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table style="width:100%" border="0">
                                                        <tr>
                                                            <td style="text-align:right">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="ID Ingreso:"/>
                                                            </td>
                                                            <td style="width:5px"></td>
                                                            <td style="text-align:left">
                                                                <dx:ASPxComboBox ID="comboIngreso" runat="server"/>
                                                            </td>
                                                            <td style="width:10%; text-align:right">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Referencia:"/>
                                                            </td>
                                                            <td style="width:5px"></td>
                                                            <td style="text-align:left">
                                                                <dx:ASPxLabel ID="lblReferencia" runat="server" Text="1223995"/>
                                                            </td>
                                                            <td style="width:10%; text-align:right">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Fecha de Ingreso:"/>
                                                            </td>
                                                            <td style="width:5px"></td>
                                                            <td style="text-align:left">
                                                                <dx:ASPxLabel ID="lblFechaDeIngreso" runat="server" Text="01/09/2017"/>
                                                            </td>
                                                            <td style="width:10%; text-align:right">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Monto de Ingreso:"/>
                                                            </td>
                                                            <td style="width:5px"></td>
                                                            <td style="text-align:left">
                                                                <dx:ASPxLabel ID="lblMontoDeIngreso" runat="server" Text="$7,000.00"/>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <table style="width:100%" border="0">
                                                       <tr>
                                                            <td style="text-align:right">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Obligaciones Vencidas:"/>
                                                            </td>
                                                            <td style="width:5px"></td>
                                                            <td style="text-align:left">
                                                                <dx:ASPxLabel ID="ASPxLabel13" runat="server" Text="Fecha de Corte:"/>
                                                            </td>
                                                            <td style="width:10%; text-align:right">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="Referencia:"/>
                                                            </td>
                                                            <td style="width:5px"></td>
                                                            <td style="text-align:left">
                                                                <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="1223995"/>
                                                            </td>
                                                            <td style="width:10%; text-align:right">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="Fecha de Ingreso:"/>
                                                            </td>
                                                            <td style="width:5px"></td>
                                                            <td style="text-align:left">
                                                                <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="01/09/2017"/>
                                                            </td>
                                                            <td style="width:10%; text-align:right">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="Monto de Ingreso:"/>
                                                            </td>
                                                            <td style="width:5px"></td>
                                                            <td style="text-align:left">
                                                                <dx:ASPxLabel ID="ASPxLabel12" runat="server" Text="$7,000.00"/>
                                                            </td>
                                                        </tr>

                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align:left">
                                                    <table style="width:100%">
                                                        <tr>
                                                            <td style="text-align:center">
                                                                <asp:RadioButton ID="radioIniciales" Text="Iniciales" runat="server" GroupName="radioTipoFactura" />
                                                            </td>
                                                            <td style="text-align:center">
                                                                <asp:RadioButton ID="radioRentas" Text="Rentas" runat="server" GroupName="radioTipoFactura" />
                                                            </td>
                                                            <td style="text-align:center">
                                                                <asp:RadioButton ID="radioOtros" Text="Otros" runat="server" GroupName="radioTipoFactura" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="dxrpHeader_Office2010Blue dx-borderBox"  style="width:100%; background-color:#E8F4F7">
                                                  <table class="dxrpControl_Office2010Blue" style="width: 100%; border-collapse: initial;">
                                                        <tr>
                                                            <td class="dxrpHeader_Office2010Blue dx-borderBox" style="text-align:left">
                                                                <dx:ASPxLabel ID="ASPxLabel85" runat="server" Text="Renta" Style="text-align:left"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <table class="dxrpControl_Office2010Blue" style="width: 100%; border-collapse: initial;">
                                                                    <tr>
                                                                        <td style="text-align">
                                                                            <dx:ASPxGridView ID="ASPxGridRenta" runat="server" Width="100%" ></dx:ASPxGridView>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr style="height:25px"><td></td></tr>
                                                        <tr>
                                                            <td style="text-align:left">
                                                                <table class="dxrpControl_Office2010Blue" style="width: 100%; border-collapse: initial;background-color:#E8F4F7">
                                                                    <tr>
                                                                        <td class="dxrpHeader_Office2010Blue dx-borderBox" style="text-align:left">
                                                                            <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Crédito" Style="text-align:left"></dx:ASPxLabel>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align:center">
                                                                <table class="dxrpControl_Office2010Blue" style="width: 100%; border-collapse: initial; background-color:#E8F4F7">
                                                                    <tr>
                                                                        <td style="text-align">
                                                                            <dx:ASPxGridView ID="ASPxGridCredito" runat="server" Width="100%"></dx:ASPxGridView>
                                                                        </td>
                                                                    </tr>
                                                                </table>
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




