<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Pagos3.aspx.vb" Inherits="MiFuncionalidad_Pagos3" %>
<%@ Register Assembly="DevExpress.Data.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <dx:ASPxRoundPanel ID="ASPxRoundPanel4" runat="server" ShowCollapseButton="True" ShowHeader="False" Theme="Office2003Blue" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">
                        <table>
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
            <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" ShowCollapseButton="True" ShowHeader="False" Theme="Office2003Olive" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">


                        <table style="width: 100%">

                            <tr>

                                <td style="width: 3%">
                                    <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Cliente" Width="50%">
                                    </dx:ASPxButton>
                                </td>

                                <td style="width: 4%">
                                    <dx:ASPxComboBox ID="oom1" runat="server" ClientInstanceName="oom1" Theme="Office2010Blue" Width="90%">
                                        <Items>
                                            <dx:ListEditItem Text="01" Value="1" />
                                            <dx:ListEditItem Text="02" Value="1" />
                                            <dx:ListEditItem Text="03" Value="1" />

                                        </Items>
                                    </dx:ASPxComboBox>
                                </td>

                                <td style="width: 40%">
                                    <dx:ASPxComboBox ID="ASPxComboBox1" runat="server" ClientInstanceName="oom1" Theme="Office2010Blue" Width="60%">
                                        <Items>
                                            <dx:ListEditItem Text="Nombre cliente1" Value="1" />
                                            <dx:ListEditItem Text="Nombre cliente2" Value="1" />
                                            <dx:ListEditItem Text="Nombre cliente3" Value="1" />

                                        </Items>
                                    </dx:ASPxComboBox>
                                </td>

                            </tr>


                        </table>

                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>

            <br />
            <br />
        </div>
        <%--busqueda--%>


        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="True" ShowHeader="False" Theme="Office2003Blue" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">


                    <div>
                        <table style="width: 80%">

                            <tr>
                                <td colspan="2">&nbsp;
                                    
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="ID fiscal" Width="100%" Font-Size="Medium" Style="text-align: left"></dx:ASPxLabel>
                                </td>

                                <td colspan="2">
                                    <dx:ASPxTextBox ID="ASPxTextBox2" runat="server" Width="100%">
                                    </dx:ASPxTextBox>
                                </td>

                            </tr>

                            <tr>
                                <td colspan="2">&nbsp;
                                    
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Total bruto" Width="100%" Font-Size="Medium" Style="text-align: left"></dx:ASPxLabel>
                                </td>

                                <td colspan="2">
                                    <dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="100%">
                                    </dx:ASPxTextBox>
                                </td>

                            </tr>

                            <tr>
                                <td colspan="2">&nbsp;
                                    
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Total impuestos" Width="100%" Font-Size="Medium" Style="text-align: left"></dx:ASPxLabel>
                                </td>

                                <td colspan="2">
                                    <dx:ASPxTextBox ID="ASPxTextBox3" runat="server" Width="100%">
                                    </dx:ASPxTextBox>
                                </td>

                            </tr>

                            <tr>
                                <td colspan="2">&nbsp;
                                    
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Fecha de corte" Width="100%" Font-Size="Medium" Style="text-align: left"></dx:ASPxLabel>
                                </td>

                                <td colspan="2">
                                    <dx:ASPxTextBox ID="ASPxTextBox4" runat="server" Width="100%">
                                    </dx:ASPxTextBox>
                                </td>

                            </tr>

                            <tr>
                                <td colspan="2">&nbsp;
                                    
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Fecha de pago" Width="100%" Font-Size="Medium" Style="text-align: left"></dx:ASPxLabel>
                                </td>

                                <td colspan="2">
                                    <dx:ASPxTextBox ID="ASPxTextBox5" runat="server" Width="100%">
                                    </dx:ASPxTextBox>
                                </td>

                            </tr>

                            <tr>
                                <td colspan="2">&nbsp;
                                    
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Días de retraso" Width="100%" Font-Size="Medium" Style="text-align: left"></dx:ASPxLabel>
                                </td>

                                <td colspan="2">
                                    <dx:ASPxTextBox ID="ASPxTextBox6" runat="server" Width="100%">
                                    </dx:ASPxTextBox>
                                </td>

                            </tr>

                            <tr>
                                <td colspan="2">&nbsp;
                                    
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Moratorios" Width="100%" Font-Size="Medium" Style="text-align: left"></dx:ASPxLabel>
                                </td>

                                <td colspan="2">
                                    <dx:ASPxTextBox ID="ASPxTextBox7" runat="server" Width="100%">
                                    </dx:ASPxTextBox>
                                </td>

                            </tr>

                            <tr>
                                <td colspan="2">&nbsp;
                                    
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="Aplicación notas de crédito" Width="100%" Font-Size="Medium" Style="text-align: left"></dx:ASPxLabel>
                                </td>

                                <td colspan="2">
                                    <dx:ASPxTextBox ID="ASPxTextBox8" runat="server" Width="100%">
                                    </dx:ASPxTextBox>
                                </td>
                                <td style="width:5%">

                                    <dx:ASPxLabel ID="ASPxLabel13" runat="server" Visible="false" Text="Aplicación notas de crédito" Width="100%" Font-Size="Medium" Style="text-align: left"></dx:ASPxLabel>
                                </td>

                                <td >
                                    <dx:ASPxButton ID="ASPxButton2" runat="server" Font-Size="Medium" Text="Reg. NC" Width="90%">
                                    </dx:ASPxButton>
                                </td>

                            </tr>

                            <tr>
                                <td colspan="2">&nbsp;
                                    
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="Saldo calculado" Width="100%" Font-Size="Medium" Style="text-align: left"></dx:ASPxLabel>
                                </td>

                                <td colspan="2">
                                    <dx:ASPxTextBox ID="ASPxTextBox9" runat="server" Width="100%">
                                    </dx:ASPxTextBox>
                                </td>

                            </tr>

                            <tr>
                                <td colspan="2">&nbsp;
                                    
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="Descuento moratorio" Width="100%" Font-Size="Medium" Style="text-align: left"></dx:ASPxLabel>
                                </td>

                                <td colspan="2">
                                    <dx:ASPxTextBox ID="ASPxTextBox10" runat="server" Width="100%">
                                    </dx:ASPxTextBox>
                                </td>

                                <td style="width:5%">
                                    <dx:ASPxLabel ID="ASPxLabel12" Visible="false" runat="server" Text="firmas" Width="100%" Font-Size="Medium" Style="text-align: left"></dx:ASPxLabel>
                                </td>

                                <td >
                                    <dx:ASPxButton ID="ASPxButton5" runat="server" Font-Size="Medium" Text="Autorizar" Width="90%">
                                    </dx:ASPxButton>
                                </td>
                                <td style="width: 5%"></td>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabel98" runat="server" Font-Size="small" Font-Underline="true" Text="Autorizó Verónica Díaz">
                                    </dx:ASPxLabel>
                                </td>
                                <td style="width: 5%"></td>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabel99" runat="server" Font-Size="small" Style="text-align: right" Font-Underline="true" Text="Autorizó Alessandro del Campo">
                                    </dx:ASPxLabel>
                                </td>


                            </tr>

                            <tr>
                                <td colspan="2">&nbsp;
                                    
                                </td>
                            </tr>

                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="Pago en la moneda de la factura" Width="100%" Font-Size="Medium" Style="text-align: left"></dx:ASPxLabel>
                                </td>

                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextBox11" runat="server" Width="100%">
                                    </dx:ASPxTextBox>
                                </td>

                            </tr>

                            <tr>
                                <td colspan="2">&nbsp;
                                    
                                </td>
                            </tr>


                        </table>


                    </div>





                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>



    </form>
</body>
</html>
