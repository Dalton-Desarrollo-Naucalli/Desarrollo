<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pagos.aspx.vb" Inherits="MiFuncionalidad_Pagos" %>
<%@ Register Assembly="DevExpress.Data.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <a href="http://localhost:50134/PagosC/">http://localhost:50134/PagosC/</a>
    <form id="form1" runat="server">
        <div>

            <dx:ASPxRoundPanel ID="ASPxRoundPanel4" runat="server" ShowCollapseButton="True" ShowHeader="False" Theme="Office2003Blue" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">
                        <table class="auto-style40">
                            <tr>
                                <td>
                                    <dx:ASPxButton ID="btnAgregar" runat="server" ToolTip="Agregar" ClientInstanceName="btnAgregar" AutoPostBack="False" EnableClientSideAPI="false">
                                        <ClientSideEvents Click="function(s, e) {
	               OnNewRowClicked();
                                     }" />
                                        <Image IconID="actions_add_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnEditar" runat="server" ToolTip="Editar" ClientInstanceName="btnEditar" AutoPostBack="False" EnableClientSideAPI="false">
                                        <ClientSideEvents Click="function(s, e) {
                           OnEditRowClicked();	
                                              }" />
                                        <Image IconID="edit_edit_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnEliminar" runat="server" ToolTip="Eliminar" AutoPostBack="False" ClientInstanceName="btnEliminar" EnableClientSideAPI="True">
                                        <ClientSideEvents Click="function(s, e) {
	                                        OnConfirmDeleteRowsClicked();
                                        }" />
                                        <Image IconID="edit_delete_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnCancelar" runat="server" AutoPostBack="False" ClientInstanceName="btnCancelar" ToolTip="Cancelar" EnableClientSideAPI="True">
                                        <ClientSideEvents Click="function(s, e) {
	                                        OnDiscardChangesClicked();
                                        }" />
                                        <Image IconID="actions_cancel_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnAplicar" runat="server" AutoPostBack="False" ClientInstanceName="btnAplicar" ToolTip="Aplicar" ValidationGroup="reqError1" EnableClientSideAPI="true" CausesValidation="False">
                                        <ClientSideEvents Click="function(s, e) {
                                            OnSaveChangesClicked();
                                            }" />
                                        <Image IconID="actions_apply_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnFiltrar" runat="server" AutoPostBack="False" ClientInstanceName="btnFiltrar" ToolTip="Filtrar" EnableClientSideAPI="True">
                                        <ClientSideEvents Click="function(s, e) {
	                                        OnFilterClicked();
                                               }" />
                                        <Image IconID="filter_filter_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnBuscar" runat="server" ClientInstanceName="btnBuscar" ToolTip="Buscar" EnableClientSideAPI="True">
                                        <Image IconID="find_find_32x32">
                                        </Image>
                                    </dx:ASPxButton>

                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnDeshacer" runat="server" ClientInstanceName="btnDeshacer" ToolTip="Deshacer" AutoPostBack="False" EnableClientSideAPI="True">
                                        <ClientSideEvents Click="function(s, e) {
	                                        OnUndoChangesClicked();
                                                           }" />
                                        <Image IconID="history_undo_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnRehacer" runat="server" ClientInstanceName="btnRehacer" ToolTip="Rehacer" AutoPostBack="False" EnableClientSideAPI="True">
                                        <ClientSideEvents Click="function(s, e) {
	                                        OnRedoChangesClicked();
                                                          }" />
                                        <Image IconID="history_redo_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>

                                <td>
                                    <dx:ASPxButton ID="btnNuevo" runat="server" ClientInstanceName="btnNuevo" ToolTip="Imprimir" AutoPostBack="False" EnableClientSideAPI="True">
                                        <ClientSideEvents Click="function(s, e) {
	                                        OnRedoChangesClicked();
                                                          }" />
                                        <Image IconID="businessobjects_boresume_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>

                                <td>
                                    <dx:ASPxButton ID="ASPxButton2" runat="server" ClientInstanceName="btnNuevo" ToolTip="Imprimir" AutoPostBack="False" EnableClientSideAPI="True">
                                        <ClientSideEvents Click="function(s, e) {
	                                        OnRedoChangesClicked();
                                                          }" />
                                        <Image IconID="print_printer_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>




                            </tr>
                        </table>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>
            <br />
            <br />
        </div>
        <%--botones--%>

        <div>
            <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="True" ShowHeader="False" Theme="Office2003Blue" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">


                    <dx:ASPxPageControl ID="prod" runat="server" ActiveTabIndex="4" EnableTheming="True" Theme="Office2010Blue" Width="100%">
                        <TabPages>


                            <dx:TabPage Name="tabMnto" Text="Criterios de busquedas de ordenes de compra" ActiveTabStyle-Font-Size="Medium">
                                <ActiveTabStyle Font-Size="Medium"></ActiveTabStyle>
                                <ContentCollection>
                                    <dx:ContentControl runat="server">

                                        <table style="width:50%">
                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>

                                               <tr>
                                                <td>
                                                    <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Ordenes de compra por rango de fecha" Width="40%"></dx:ASPxButton>
                                                </td>
                                             </tr>
                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>
                                            <tr>

                                                <td>
                                                    <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Ordenes de compra por Proveedor" Width="40%"></dx:ASPxButton>
                                                </td>                                               
                                            </tr>
                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dx:ASPxButton ID="ASPxButton4" runat="server" Text="Ordenes de compra pendeientes de surtir" Width="40%"></dx:ASPxButton>
                                                </td>
                                          </tr>
                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dx:ASPxButton ID="ASPxButton5"  runat="server" Text="Ordenes de compra no vàlidas" Width="40%"></dx:ASPxButton>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>
                                           
                                        </table>
                                        <br />
                                        <br />
                                        
                                      <table class="dxrpControl_Office2010Blue" style="width: 100%; border-collapse: initial; background-color: #E8F4F7">

                                            <tr>
                                                <td colspan="3" class="dxrpHeader_Office2010Blue dx-borderBox" style="width: 100%">
                                                    <dx:ASPxLabel ID="ASPxLabel99" runat="server" Text=" Impresión de pedidos" Font-Size="Medium" Width="100%" Style="text-align: left" Height="19px"></dx:ASPxLabel>
                                                </td>
                                            </tr>
                                          <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>
                                          <tr>
                                                 <td style="width:10%">
                                                    <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Clave pedido" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                                 <td style="width:20%">
                                                    <dx:ASPxComboBox ID="ASPxComboBox1" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="90%">
                                                        <Items>
                                                            <dx:ListEditItem Text="Clave 1" Value="1" />
                                                            <dx:ListEditItem Text="Clave 2" Value="1" />
                                                            <dx:ListEditItem Text="Clave 3" Value="1" />
                                                  
                                                        </Items>
                                                    </dx:ASPxComboBox>
                                                </td>
                                            
                                            <td>
                                                <dx:ASPxButton ID="ASPxButton6" runat="server" Text="Imprime pedido por clave"></dx:ASPxButton>
                                            </td>
                                                 </tr>

                                        </table>
                                        <br />
                                        <br />

                                         <table class="dxrpControl_Office2010Blue" style="width: 100%; border-collapse: initial; background-color: #E8F4F7">

                                            <tr>
                                                <td colspan="3" class="dxrpHeader_Office2010Blue dx-borderBox" style="width: 100%">
                                                    <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text=" Pedidos con observaciones documentación" Font-Size="Medium" Width="100%" Style="text-align: left" Height="19px"></dx:ASPxLabel>
                                                </td>
                                            </tr>
                                          <tr>
                                                <td colspan="3">&nbsp;
                                                </td>
                                            </tr>
                                          <tr>
                                                 <td style="width:10%">
                                                    <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Fecha inicial" Font-Size="medium"  Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                                <td colspan="2">
                                                    <dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="20%"></dx:ASPxTextBox>
                                                </td>
                                              </tr>
                                             <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>
                                             <tr>
                                                   <td style="width:10%">
                                                    <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Fecha final" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                                <td style="width:20%">
                                                    <dx:ASPxTextBox ID="ASPxTextBox2" runat="server" Width="90%"></dx:ASPxTextBox>
                                                </td>
                                            
                                            <td >
                                                <dx:ASPxButton ID="ASPxButton7" runat="server" Text="Reporte con observaciones de documentación"></dx:ASPxButton>
                                            </td>
                                                 </tr>

                                        </table>




                                        
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>


                            <dx:TabPage Name="tabMnto" Text="" ActiveTabStyle-Font-Size="Medium">
                                <ActiveTabStyle Font-Size="Medium"></ActiveTabStyle>
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        

                                        <table style="width:50%">
                                            <tr>
                                                 <td style="width:10%">
                                                    <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Proveedor" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                                 <td style="width:20%">
                                                    <dx:ASPxComboBox ID="ASPxComboBox2" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="90%">
                                                        <Items>
                                                            <dx:ListEditItem Text="Clave 1" Value="1" />
                                                            <dx:ListEditItem Text="Clave 2" Value="1" />
                                                            <dx:ListEditItem Text="Clave 3" Value="1" />
                                                  
                                                        </Items>
                                                    </dx:ASPxComboBox>
                                                </td>

                                                 <td style="width:10%">
                                                    <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Número de orden" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                                 <td style="width:20%">
                                                    <dx:ASPxComboBox ID="ASPxComboBox3" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="90%">
                                                        <Items>
                                                            <dx:ListEditItem Text="Clave 1" Value="1" />
                                                            <dx:ListEditItem Text="Clave 2" Value="1" />
                                                            <dx:ListEditItem Text="Clave 3" Value="1" />
                                                  
                                                        </Items>
                                                    </dx:ASPxComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dx:ASPxButton ID="ASPxButton8" runat="server" Text="Imprimir"></dx:ASPxButton>
                                                </td>
                                                <td>
                                                    <dx:ASPxButton ID="ASPxButton9" runat="server" Text="Consultar"></dx:ASPxButton>
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



        </div>
    </form>
</body>



</html>

 