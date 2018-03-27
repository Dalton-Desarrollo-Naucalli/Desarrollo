<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Frm_Pedido.aspx.vb" Inherits="Funcionalidad_Frm_Pedido" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/Pedidos.js"></script>
    <script type ="text/javascript" >
        function ValidaCampos() {
            if (cmbMoneda.GetValue() == null || cmbMoneda.GetValue() == '0') {
                alert('Debe capturar la Moneda.');
            } else if (dtFecha.GetValue() == null) {
                alert('Debe capturar la Fecha.');
            } else if (cmbAtencion.GetValue() == null || cmbAtencion.GetValue() == '0') {
                alert('Debe capturar el Contacto del Pedido.');
            } else if (cmbPersona.GetValue() == null || cmbAtencion.GetValue() == '0') {
                alert('Debe capturar el Vendedor del Pedido.');
            }
            else {
                cbGuardar.PerformCallback();
            }
        }
        </script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style type="text/css">
        
        .GlobalTextoPanel
{
	font-family: Arial; 
	font-size:11px;
	color:Navy ;
	font-weight :bold;
	padding-left:2px;
}
        </style>
</head>
<body onkeypress="return pulsar(event)">
    <form id="form1" runat="server">
        <div>
            <%--GRIDLOOKUP BUSQUEDA--%>
        
            <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" HeaderText="Búsqueda:" Font-Size="Medium" Font-Bold="false"  Width="100%" ClientVisible="true">
                <PanelCollection>
                    <dx:PanelContent runat="server">

                        <table>
                            <tr>
                                <td style="width:50%">
                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="50%" KeyFieldName="ped_id" AutoGenerateColumns="False" TextFormatString="{0} | {3} | {4}" TabIndex="1">
                            <GridViewProperties>   
                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
MuestraPedidos();
}" />
                            <ClientSideEvents TextChanged="function(s, e) {
	GVMovPedido.Refresh();
}"  />
                        </dx:ASPxGridLookup>
                                    
                                    </td>
                                <td style="width:10%">
                                           <dx:ASPxButton ID="btnNuevo" runat="server" AutoPostBack="False" ClientInstanceName="btnNuevo" EnableClientSideAPI="True" Height="30px" TabIndex="22" Text="NUEVO PEDIDO" ToolTip="Nuevo Pedido" Width="141px">
                                               <ClientSideEvents Click="function(s, e) {
cbGuardar.PerformCallback();
}" />
                                               <Image IconID="actions_addfile_16x16">
                                               </Image>
                                           </dx:ASPxButton>
                                           <dx:ASPxCallback ID="cbNuevo" runat="server" ClientInstanceName="cbNuevo">
                                           </dx:ASPxCallback>

                                     </td>
                                </tr>
                            </table>
                        <asp:Label ID="lblAccesos" runat="server" CssClass="GlobalTextoPanel" Visible="False"></asp:Label>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>
            <br />
        </div>

        <%--CABECERO--%>
        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Pedidos" Font-Bold="true" Font-Size="Medium"  Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" HeaderText="Ventas." Font-Size="Medium"  Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">

                                <table style="width: 100%">
                                    
                                    <tr >
                                        <td style="width:10%">
                                            <dx:ASPxLabel ID="lblNoPedido" runat="server" Text="No. Pedido:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblNoPedido"></dx:ASPxLabel>
                                        </td>
                                        <td  >
                                            <dx:ASPxTextBox ID="txtNoPedido" Font-Size="Medium" runat="server" ClientInstanceName="txtNoPedido" ClientIDMode="AutoID" Width="40%" Height="16px" ForeColor="Black" TabIndex="2" ClientEnabled ="False"></dx:ASPxTextBox>
                                        </td>
                                     <td style="width:10%">
                                            <dx:ASPxLabel ID="lblCvePedidoCte" runat="server" Text="Cve. Pedido Cte.:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblCvePedidoCte"></dx:ASPxLabel>
                                        </td>
                                       <td >
                                            <dx:ASPxTextBox ID="txtCvePedidoCte" runat="server" ClientInstanceName="txtCvePedidoCte" Font-Size="Medium"  Width="85%" ForeColor="Black" TabIndex="3"></dx:ASPxTextBox>
                                        </td>
                                       <td style="width:10%">
                                            <dx:ASPxLabel ID="lblFecha" ClientInstanceName="lblFecha" runat="server" Text="Fecha:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                      <td >
                                            <dx:ASPxDateEdit ID="dtFecha" runat="server" ClientInstanceName="dtFecha" Font-Size="Medium" Height="16px" Width="88%" ForeColor="Black" TabIndex="4" UseMaskBehavior="true">                                           
                                                <ClientSideEvents DateChanged="function(s, e) {	
}" Init="function(s, e) {
var fechaAct = new Date();
fechaAct.setHours(0, 0, 0, 0);
dtFecha.SetMinDate(fechaAct);
}" />
                                            </dx:ASPxDateEdit>
                                        </td>
                                        </tr>
                                     <tr>
                                        <td style="padding:4px"></td>
                                    </tr>

                                     <tr>
                                       <td style="width:10%">

                                            <dx:ASPxLabel ID="lblMoneda" runat="server" Text="Moneda:" ClientInstanceName="lblMoneda" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                       <td >
                                            <dx:ASPxComboBox ID="cmbMoneda" runat="server" ClientInstanceName="cmbMoneda" Font-Size="Medium" Width="85%" ForeColor="Black" TabIndex="5" />
                                      
                                       </td>                              
                                 
                                        <td style="width:10%">
                                            <dx:ASPxLabel ID="lblSucursal" runat="server" Text="Sucursal:" ClientInstanceName="lblSucursal" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                         <td colspan="3">
                                            <dx:ASPxCombobox ID="cmbSucursal" Font-Size="Medium" runat="server" ClientInstanceName="cmbSucursal" ClientIDMode="AutoID" Width="95%" Height="16px" ForeColor="Black" TabIndex="6"></dx:ASPxCombobox>
                                        </td>

                                         </tr>

                                     <tr>
                                        <td style="padding:4px"></td>
                                    </tr>
                                    <tr>
                                       
                                     <td style="width:15%">
                                            <dx:ASPxLabel ID="lblCliente" runat="server" Text="Cliente:" ClientInstanceName="lblCliente" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                       <td colspan="5">
                                            <dx:ASPxCombobox ID="cmbCliente" runat="server" ClientInstanceName="cmbCliente" Font-Size="Medium"  Width="97%" ForeColor="Black" TabIndex="7" Height="16px">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e) {
LlenaAtn();
LlenaSucCte();
}" />
                                            </dx:ASPxCombobox>                                                                                         
                                            
                                      </td>
                                        </tr>
                                     <tr>
                                        <td style="padding:4px"></td>
                                    </tr>
                                    <tr>
                                     
                                       <td style="width:10%">
                                            <dx:ASPxLabel ID="lblAtencion" runat="server" Text="Atención:" ClientInstanceName="lblAtencion" Font-Size="medium" Width="80%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                      <td >
                                            <dx:ASPxCombobox ID="cmbAtencion" runat="server" ClientInstanceName="cmbAtencion" Font-Size="Medium" Height="16px" Width="85%" ForeColor="Black" TabIndex="8"/>
                                        </td>                                        
                                  
                                       <td style="width:10%">
                                            <dx:ASPxLabel ID="lblSucursalCte" runat="server" Text="Sucursal Cliente:" ClientInstanceName="lblSucursalCte" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                       <td >
                                            <dx:ASPxComboBox ID="cmbSucursalCte" runat="server" ClientInstanceName="cmbSucursalCte" Font-Size="Medium" Width="85%" ForeColor="Black" TabIndex="9"></dx:ASPxComboBox>
                                        </td>
                                      <td style="width:10%">
                                            <dx:ASPxLabel ID="lblVendedor" runat="server" Text= "Vendedor" ClientInstanceName="lblVendedor" Font-Size="Medium"  Width="75%" ForeColor="Black" TabIndex="7"></dx:ASPxLabel>                                                                                         
                                            
                                        </td>
                                      <td >
                                            <dx:ASPxCombobox ID="cmbPersona" runat="server" ClientInstanceName="cmbPersona" Font-Size="Medium" Height="16px" Width="87%" ForeColor="Black" TabIndex="10"></dx:ASPxCombobox>
                                        </td>
                                        
                                        </tr>
                                     <tr>
                                        <td style="padding:4px"></td>
                                    </tr>
                                    <tr>
                                   

                                        <td style="width:10%">
                                            <dx:ASPxLabel ID="lblDiasCred" runat="server" Text="Días Crédito:" ClientInstanceName="lblDiasCred" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td >
                                            <dx:ASPxTextbox ID="txtFormaPago" Font-Size="Medium" runat="server" ClientInstanceName="txtFormaPago" ClientIDMode="AutoID" Width="87%" Height="16px" ForeColor="Black" TabIndex="11"></dx:ASPxTextbox>
                                        </td>
                                     <td colspan="2">
                                            <dx:ASPxTextbox ID="txtComentarioPlazo" runat="server" ClientInstanceName="txtComentarioPlazo" Font-Size="medium" Width="89%" Style="text-align: left" TabIndex="12"></dx:ASPxTextbox>
                                        </td>
                                        
                                       <td style="width:10%">
                                            <dx:ASPxLabel ID="lblTipoServicio" runat="server" Text="Tipo de Servicio:" ClientInstanceName="lblTipoServicio" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                       <td >
                                            <dx:ASPxComboBox ID="cmbTipoServicio" runat="server" ClientInstanceName="cmbTipoServicio" Font-Size="Medium" Width="85%" ForeColor="Black" TabIndex="13">
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                   
                                    <tr>
                                        <td style="padding:4px"></td>
                                    </tr>
                                    <tr>
                                        <td  colspan="6">                                            
                                            <dx:ASPxGridView ID="GVMovPedido" runat="server" AutoGenerateColumns="False" Width="97%" ClientIDMode="AutoID" ClientInstanceName="GVMovPedido" KeyFieldName="prod_id" ForeColor="Black" TabIndex="14">                               
                                                <ClientSideEvents EndCallback="OnEndCallback"
BeginCallback="OnBeginCallback" />
                                             <SettingsEditing Mode="Batch" UseFormLayout="False" BatchEditSettings-EditMode="Row">
                                                 <BatchEditSettings ShowConfirmOnLosingChanges="false" />
                                                </SettingsEditing>
                                                <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" ConfirmDelete="True"/>
                                                <SettingsCommandButton>
                                                    <NewButton ButtonType="Image" RenderMode="Image" Text="Nuevo">
                                                        <Image Height="20px" Url="~/Imagenes/NEW_.png" Width="20px">
                                                        </Image>
                                                    </NewButton>
                                                    <EditButton ButtonType="Image" RenderMode="Image" Text="Editar">
                                                        <Image Height="16px" Url="~/Imagenes/editar.png" Width="16px">
                                                        </Image>
                                                    </EditButton>
                                                    <DeleteButton ButtonType="Image" RenderMode="Image" Text="Eliminar">
                                                        <Image Height="16px" Url="~/Imagenes/Delete.png" Width="16px">
                                                        </Image>
                                                    </DeleteButton>
                                                </SettingsCommandButton>
                                                <SettingsText ConfirmDelete="¿Esta usted seguro de eliminar el registro?"/>
                                                <Columns>
                                                    <dx:GridViewDataTextColumn ShowInCustomizationForm="True" VisibleIndex="0">
                                                    </dx:GridViewDataTextColumn>
                                                </Columns>
                                                <Styles>
                                                    <Footer BackColor="#FFFF66" HorizontalAlign="Right" />
                                                </Styles>
                                                <Border BorderStyle="Double" />
                                            </dx:ASPxGridView>
                                        </td>
                                    </tr>
                               </table>
                                <br />
                                <table style="width:100%">
                                    <tr>
                                        <td  style="width:15%">
                                            <dx:ASPxLabel ID="lblObserv" runat="server" Text="Observaciones:" ClientInstanceName="lblObserv" Font-Size="medium" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                         <td colspan="5">
                                            <dx:ASPxTextBox ID="txtObserv" Font-Size="Medium" runat="server" ClientInstanceName="txtObserv" ClientIDMode="AutoID" Width="96%" Height="16px" ForeColor="Black" TabIndex="15"></dx:ASPxTextBox>
                                        </td>                                        
                                    </tr>
                                    <tr>
                                        <td style="padding:4px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width:15%">
                                            <dx:ASPxLabel ID="lblSaldoAct" runat="server" Text="Saldo Actual Cliente:" ClientInstanceName="lblSaldoAct" Font-Size="medium" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                         <td >
                                            <dx:ASPxTextBox ID="txtSaldoAct" Font-Size="Medium" runat="server" ClientInstanceName="txtSaldoAct" ClientIDMode="AutoID" Width="85%" Height="16px" ForeColor="Black" TabIndex="16"></dx:ASPxTextBox>
                                        </td>  
                                        
                                         <td style="width:15%">
                                            <dx:ASPxLabel ID="lblLimiteC" runat="server" Text="Límite de Crédito:" ClientInstanceName="lblLimiteC" Font-Size="medium" Width="85%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                       <td>
                                            <dx:ASPxTextBox ID="txtLimiteC" Font-Size="Medium" runat="server" ClientInstanceName="txtLimiteC" ClientIDMode="AutoID" Width="85%" Height="16px" ForeColor="Black" TabIndex="17"></dx:ASPxTextBox>
                                        </td>
                                        <td style="width:15%">
                                            <dx:ASPxLabel ID="lblCapDirec" runat="server" Text="Cap. Dirección entrego:" ClientInstanceName="lblCapDirec" Font-Size="medium" Style="text-align: left"></dx:ASPxLabel>                                    
                                        </td>
                                        <td>
                                            <dx:ASPxCombobox ID="cmbCapDirec" runat="server" ClientInstanceName="cmbCapDirec" Font-Size="Medium" Width="85%" ForeColor="Black" TabIndex="18">
                                                <Items>
                                                    <dx:ListEditItem Text="SI" Value="1" />
                                                    <dx:ListEditItem Text="NO" Value="2" />
                                                </Items>
                                            </dx:ASPxCombobox>
                                        </td>
                                      
                                    </tr>
                                    <tr>
                                        <td style="padding:4px"></td>
                                    </tr>
                                     <tr>
                                        <td  style="width:15%">
                                            <dx:ASPxLabel ID="lblNotas" runat="server" Text="Notas:" ClientInstanceName="lblNotas" Font-Size="medium" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                         <td colspan="5">
                                            <dx:ASPxTextBox ID="txtNotas" Font-Size="Medium" runat="server" ClientInstanceName="txtNotas" ClientIDMode="AutoID" Width="96%" Height="16px" ForeColor="Black" TabIndex="19"></dx:ASPxTextBox>
                                        </td>                                        
                                    </tr>
                                     <tr>
                                        <td style="padding:4px"></td>
                                    </tr>
                                </table>
                                <table style="width:100%">
                                    <tr>
                                       <td>
                                       </td>   
                                        
                                            <td style="width:10%">
                                           <dx:ASPxButton ID="btnGuardar" runat="server" AutoPostBack="False" ClientInstanceName="btnGuardar" EnableClientSideAPI="True" Height="69px" TabIndex="20" Text="GUARDAR PEDIDO" ToolTip="Guardar Pedido" Width="141px">
                                               <ClientSideEvents Click="function(s, e) {
ValidaCampos
}" />
                                               <Image IconID="data_exportmodeldifferences_32x32">
                                               </Image>
                                           </dx:ASPxButton>
                                           <dx:ASPxCallback ID="cbGuardar" runat="server" ClientInstanceName="cbGuardar">
                                               <ClientSideEvents EndCallback="function(s, e) {
alert(s.cpAccion);
glBusqueda.GetGridView().Refresh();
if (txtNoPedido.GetText() == '') {
txtNoPedido.SetText(s.cpIDped);
}
}
" />
                                           </dx:ASPxCallback>

                                     </td>
                                     <td style="width:10%">
                                           <dx:ASPxButton ID="btnFacturar" runat="server" AutoPostBack="False" ClientInstanceName="btnFacturar" EnableClientSideAPI="True" Height="69px" TabIndex="21" Text="FACTURAR" ToolTip="Facturar" Width="141px">
                                               <ClientSideEvents Click="function(s, e) {
cbActualizar.PerformCallback();
                            }" />
                                               <Image IconID="businessobjects_botask_32x32">
                                               </Image>
                                           </dx:ASPxButton>
                                           <dx:ASPxCallback ID="cbFacturar" runat="server" ClientInstanceName="cbFacturar">
                                               <ClientSideEvents EndCallback="function(s, e) {
alert(s.cpAccion);
glBusqueda.GetGridView().Refresh();
if (txtNoPedido.GetText() == '') {
txtNoPedido.SetText(s.cpIDProd);
}
BloqueaAgrega();
}
" />
                                           </dx:ASPxCallback>

                                     </td>
                                </tr>
                                    </table>
                                 </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>
        <br />
    </form>
</body>
</html>
