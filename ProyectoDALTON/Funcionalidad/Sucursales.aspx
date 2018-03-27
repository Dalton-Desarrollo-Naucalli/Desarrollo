<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Sucursales.aspx.vb" Inherits="Funcionalidad_Sucursales" %>


<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/Sucursales.js"></script>
    <title>Sucursales</title>
</head>
<body onkeypress="return pulsar(event)">

    <form id="form1" runat="server">

    <div>
            <dx:ASPxRoundPanel ID="ASPxRoundPanel4" runat="server" ShowCollapseButton="True" ShowHeader="False" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">
                        <table class="auto-style40">
                            <tr>
                                <td class="auto-style4">
                                    <dx:ASPxButton ID="btnAgregar" runat="server" ToolTip="Agregar" ClientInstanceName="btnAgregar" AutoPostBack="False" EnableClientSideAPI="false" ClientEnabled="False" GroupName="A">
                                        <ClientSideEvents Click="function(s, e) {
Enc_BotonAgregar();
LimpiaControles();
GVCentroCostosProceso.Refresh();
}"
                                            CheckedChanged="function(s, e) {
if (s.GetChecked()){
LimpiaControles();
HabilitaSucursales();
           }
else	{
DeshabilitaSucursales();
       }
}
" />
                                        <Image IconID="actions_add_32x32">
                                        </Image>
                                    </dx:ASPxButton>

                                </td>


                                <td class="auto-style4">
                                    <dx:ASPxButton ID="btnEditar" runat="server" ToolTip="Editar" ClientInstanceName="btnEditar" AutoPostBack="False" EnableClientSideAPI="false" ClientEnabled="False" GroupName="B">
                                        <ClientSideEvents Click="function(s, e) {
Enc_BotonEditar();
}"
                                            CheckedChanged="function(s, e) {
if (s.GetChecked()) {
HabilitaSucursales();
           }
else	{
DeshabilitaSucursales();
       }
}
" />
                                        <Image IconID="edit_edit_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                 
                                </td>


                                <td class="auto-style4">

                                    <dx:ASPxButton ID="btnEliminar" runat="server" ToolTip="Eliminar" AutoPostBack="False" ClientInstanceName="btnEliminar" EnableClientSideAPI="True" ClientEnabled="True">
                                        <ClientSideEvents Click="function(s, e) {
 ConfirmarEliminar();
}" />
                                        <Image IconID="edit_delete_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                    <dx:ASPxCallback ID="cbEliminar" runat="server" ClientInstanceName="cbEliminar">
                                        <ClientSideEvents EndCallback="function(s, e) {
   alert(s.cpAccionE);
    limpia(s.cpClear);
    glBusqueda.GetGridView().Refresh();
}" />
                                    </dx:ASPxCallback>
                                </td>


                                <td class="auto-style4">
                                    <dx:ASPxButton ID="btnCancelar" runat="server" AutoPostBack="False" ClientInstanceName="btnCancelar" ToolTip="Cancelar" EnableClientSideAPI="True" ClientEnabled="False">
                                        <ClientSideEvents Click="function(s, e) {
cbCancelar.PerformCallback();
                  }" />
                                        <Image IconID="actions_cancel_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                    <dx:ASPxCallback ID="cbCancelar" runat="server" ClientInstanceName="cbCancelar">
                                        <ClientSideEvents BeginCallback="function(s, e) {
if ((btnAgregar.Checked == true) &amp;&amp; (btnEditar.ClientEnabled== false)){
LimpiaControles();
}	
else{
MuestraSucursales();
}
}" />
                                    </dx:ASPxCallback>
                                </td>


                                <td class="auto-style4">
                                    <dx:ASPxButton ID="btnActualizar" runat="server" AutoPostBack="False" ClientInstanceName="btnActualizar" ToolTip="Actualizar" ValidationGroup="reqError1" EnableClientSideAPI="true" CausesValidation="False" ClientEnabled="False">
                                        <ClientSideEvents Click="function(s, e) {
            cbActualizar.PerformCallback();
                            }" />
                                        <Image IconID="actions_apply_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                    <dx:ASPxCallback ID="cbActualizar" runat="server" ClientInstanceName="cbActualizar">
                                        <ClientSideEvents EndCallback="function(s, e) {
alert(s.cpAccion);
glBusqueda.GetGridView().Refresh();
 if (txtNumSucursal.GetText() == '') {
txtNumSucursal.SetText(s.cpNumSuc);
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

            <%--  BOTONES PANEL (AGREGA, EDITA, ELIMINA, ACTUALIZA)--%>

            <br />
            <br />

            <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" HeaderText="Búsqueda:" Font-Size="Medium" Font-Bold="false" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">


                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="modulo_id" AutoGenerateColumns="False" TextFormatString="{0} | {1}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" AutoFilterRowInputDelay="4000"  />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraSucursales();
                                                                        HabilitaBotones();
                                                                       }" />

                            <ClientSideEvents TextChanged="function(s, e) {
	GVCentroCostosProceso.Refresh();
}" />

                        </dx:ASPxGridLookup>
                        <asp:Label ID="lblAccesos" runat="server" CssClass="GlobalTextoPanel" Visible="false"></asp:Label>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>
            <br />
            <br />
        </div>
        <%--Botones y GRIDLOOKUP BUSQUEDA--%>

        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText=" Sucursales" Font-Bold="true" Font-Size="Large"  Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">


                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" HeaderText="Datos"  Font-Size="Medium"  Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">

                                <table style="width: 100%">

                                    <tr>
                                        <td style="width:20%">
                                            <dx:ASPxLabel ID="lblSucursalActiva" ClientInstanceName="lblSucursalActiva" runat="server" Text="Sucursal activa:" Font-Size="Medium" ClientEnabled="false" ForeColor="Black"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxRadioButtonList ID="rbSucursalActiva" Font-Size="Medium" Border-BorderStyle="None" ForeColor="Black" ClientInstanceName="rbSucursalActiva" ClientEnabled="false" runat="server" RepeatDirection="Horizontal">

                                                <Items>                                                    
                                                    <dx:ListEditItem Value="1" Text="Si" />
                                                    <dx:ListEditItem Value="0" Text="No" />
                                                </Items>
                                            </dx:ASPxRadioButtonList>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>

                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblNumSucursaal" ClientInstanceName="lblNumSucursaal" runat="server" Text="Núm. Sucursal:" Font-Size="Medium" ClientEnabled="false" ForeColor="Black"></dx:ASPxLabel>
                                        </td>
                                        <td style="width:30%">
                                            <dx:ASPxTextBox ID="txtNumSucursal" ClientEnabled="false" ClientInstanceName="txtNumSucursal" ForeColor="Black" Font-Size="Medium" runat="server" Width="25%">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td style="width:20%">
                                            <dx:ASPxLabel ID="lblNombre" ClientInstanceName="lblNombre" ClientEnabled="false" ForeColor="Black" runat="server" Text="Nombre:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td style="width:30%">
                                            <dx:ASPxTextBox ID="txtNombre" ClientInstanceName="txtNombre" ClientEnabled="false" ForeColor="Black" MaxLength="50" Font-Size="Medium" runat="server" Width="75%" >
                                            </dx:ASPxTextBox>

                                        </td>
                                    </tr>

                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblDireccion" ClientInstanceName="lblDireccion" ClientEnabled="false" ForeColor="Black" runat="server" Text="Dirección:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtDireccion" ClientInstanceName="txtDireccion" ClientEnabled="false" ForeColor="Black" MaxLength="50" Font-Size="Medium" runat="server" Width="95%">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblCP" ClientInstanceName="lblCP" ClientEnabled="false" ForeColor="Black" runat="server" Text="C.P:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtCP" ClientInstanceName="txtCP" ClientEnabled="false" ForeColor="Black" MaxLength="5" Font-Size="Medium" runat="server" Width="50%" Height="16px">
                                               <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>

                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblColonia" ClientInstanceName="lblColonia" ClientEnabled="false" ForeColor="Black" runat="server" Text="Colonia:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtColonia" ClientInstanceName="txtColonia" ClientEnabled="false" ForeColor="Black"  Font-Size="Medium" runat="server" Width="95%" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblEstado" ClientInstanceName="lblEstado" ClientEnabled="false" ForeColor="Black" runat="server" Text="Estado:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxComboBox ID="cmbEstado" ClientInstanceName="cmbEstado" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Width="75%" AutoPostBack="false">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e){
                                                    LlenaMunicipio();
                                                    }" />
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>

                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblMunicipio" ClientInstanceName="lblMunicipio" ClientEnabled="false" ForeColor="Black" runat="server" Text="Municipio:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxComboBox ID="cmbMunicipio" ClientInstanceName="cmbMunicipio" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                                 runat="server" Width="95%"  AutoPostBack="false" OnCallback="cmbMunicipio_Callback">
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblZonaFiscal" ClientInstanceName="lblZonaFiscal" ClientEnabled="false" ForeColor="Black" runat="server" Text="Zona Fiscal:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>

                                            <dx:ASPxComboBox ID="cmbZonaFiscal" ClientInstanceName="cmbZonaFiscal" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server"  Width="75%">
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>

                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblTelefono" ClientInstanceName="lblTelefono" ClientEnabled="false" ForeColor="Black" runat="server" Text="Teléfono:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtTelefono" ClientInstanceName="txtTelefono" DisplayFormatString="00 - 00 - 00 - 00" ClientEnabled="false" MaxLength="10" ForeColor="Black" Font-Size="Medium" runat="server" Width="75%" >
                                              <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblTelefono2" ClientInstanceName="lblTelefono2" ClientEnabled="false" ForeColor="Black" runat="server" Text="Teléfono2:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtTelefono2"  ClientInstanceName="txtTelefono2" ClientEnabled="false" DisplayFormatString="00 - 00 - 00 - 00" ForeColor="Black" MaxLength="10" Font-Size="Medium" runat="server" Width="75%" Height="16px">
                                             <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>
                                        </td>
                                    </tr>

                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblFax" ClientInstanceName="lblFax" ClientEnabled="false" ForeColor="Black" runat="server" Text="Fax:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtFax"  ClientInstanceName="txtFax" ClientEnabled="false" MaxLength="10"  ForeColor="Black" Font-Size="medium" runat="server" Width="75%" Height="16px">
                                             <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>

                                        </td>
                                        <td>&nbsp;
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>


                                </table>

                            </dx:PanelContent>
                        </PanelCollection>

                    </dx:ASPxRoundPanel>

                    <br />
                    <br />

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel3" runat="server" HeaderText=" Facturación Electrónica"  Font-Size="Medium"  Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">


                                <table style="width: 100%">
                                    

                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblCostoAdmo" ClientInstanceName="lblCostoAdmo" ClientEnabled="false" ForeColor="Black" runat="server" Text="Costo admvo:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td style="width: 30%">
                                            <dx:ASPxTextBox ID="txtCostoAdmvo"  ClientInstanceName="txtCostoAdmvo" DisplayFormatString="C" ClientEnabled="false" ForeColor="Black" MaxLength="15" Font-Size="Medium" runat="server" Width="75%" Height="16px">
                                              <ClientSideEvents KeyPress="function(s, e) {
ValidaDecimales(txtCostoAdmvo);	
}" />
                                                </dx:ASPxTextBox>
                                        </td>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblNumVendedores" ClientInstanceName="lblNumVendedores" ClientEnabled="false" ForeColor="Black" runat="server" Text="Núm. Vendedores:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 30%">
                                            <dx:ASPxTextBox ID="txtNumVendedores"  ClientInstanceName="txtNumVendedores" ForeColor="Black" ClientEnabled="false" MaxLength="10" Font-Size="Medium" runat="server" Width="75%" Height="16px">
                                               <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>

                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblCostoMinVendedor" ClientInstanceName="lblCostoMinVendedor" ClientEnabled="false" ForeColor="Black" runat="server" Text="Costo mín. Vendedor:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtCostoMinVendedor" ClientInstanceName="txtCostoMinVendedor" DisplayFormatString="C" ForeColor="Black" ClientEnabled="false" MaxLength="10" Font-Size="Medium" runat="server" Width="75%" Height="16px">
                                             <ClientSideEvents KeyPress="function(s, e) {
ValidaDecimales(txtCostoMinVendedor);	
}" />
                                                </dx:ASPxTextBox>
                                        </td>

                                        <td>&nbsp;
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>

                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblContadorFiscal" ClientInstanceName="lblContadorFiscal" ClientEnabled="false" ForeColor="Black" runat="server" Text="Contador fiscal:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtContadorFiscal"   ClientInstanceName="txtContadorFiscal" ForeColor="Black" ClientEnabled="false" MaxLength="20" Font-Size="Medium" runat="server" Width="75%" Height="16px">
                                             <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblSerieFacturas" ClientInstanceName="lblSerieFacturas" ClientEnabled="false" ForeColor="Black" runat="server" Text="Serie facturas:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtSerieFacturas"   ClientInstanceName="txtSerieFacturas" ClientEnabled="false" ForeColor="Black" MaxLength="3" Font-Size="Medium" runat="server" Width="75%" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>

                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblContadorNotaCredito" ClientInstanceName="lblContadorNotaCredito" ClientEnabled="false" ForeColor="Black" runat="server" Text="Contador nota crédito:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtContadorNotaCredito"   ClientInstanceName="txtContadorNotaCredito" ForeColor="Black" ClientEnabled="false" MaxLength="20" Font-Size="Medium" runat="server" Width="75%" Height="16px">
                                            <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>
                                        </td>

                                        <td>
                                            <dx:ASPxLabel ID="lblSerieNotaCredito" ClientInstanceName="lblSerieNotaCredito" ClientEnabled="false" ForeColor="Black" runat="server" Text="Serie nota crédito:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtSerieNotaCredito" ClientInstanceName="txtSerieNotaCredito" ForeColor="Black" ClientEnabled="false" MaxLength="3" Font-Size="Medium" runat="server" Width="75%" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>

                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblContadorRemisiones" ClientInstanceName="lblContadorRemisiones" ClientEnabled="false" ForeColor="Black" runat="server" Text="Contador remisiones:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtContadorRemisiones" ClientInstanceName="txtContadorRemisiones" ForeColor="Black" ClientEnabled="false" MaxLength="20" Font-Size="Medium" runat="server" Width="75%" Height="16px">
                                           <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblSerieRemisiones" ClientInstanceName="lblSerieRemisiones" ClientEnabled="false" ForeColor="Black" runat="server" Text="Serie remisiones:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtSerieRemisiones"   ClientInstanceName="txtSerieRemisiones" ForeColor="Black" ClientEnabled="false" MaxLength="3" Font-Size="Medium" runat="server" Width="75%" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>

                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblContadorRecibosPagos" ClientInstanceName="lblContadorRecibosPagos" ClientEnabled="false" ForeColor="Black" runat="server" Text="Contador recibos pagos:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtContadorRecibosPagos"   ClientInstanceName="txtContadorRecibosPagos" ForeColor="Black" ClientEnabled="false" MaxLength="20" Font-Size="Medium" runat="server" Width="75%" Height="16px">
                                          <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblSerieRecibosPagos" ClientInstanceName="lblSerieReciboPagos" ClientEnabled="false" ForeColor="Black" runat="server" Text="Serie recibos pagos:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtSerieRecibosPagos"   ClientInstanceName="txtSerieRecibosPagos" ForeColor="Black" ClientEnabled="false" MaxLength="3" Font-Size="Medium" runat="server" Width="75%" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>

                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblContadorReciboFiscal" ClientInstanceName="lblContadorReciboFiscal" ClientEnabled="false" ForeColor="Black" runat="server" Text="Contador recibo fiscal:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtContadorReciboFiscal"  ClientInstanceName="txtContadorReciboFiscal" ForeColor="Black" ClientEnabled="false" MaxLength="20" Font-Size="Medium" runat="server" Width="75%" Height="16px">
                                          <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblSerieReciboFiscal" ClientInstanceName="lblSerieReciboFiscal" ClientEnabled="false" ForeColor="Black" runat="server" Text="Serie recibo fiscal:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtSerieReciboFiscal" ClientInstanceName="txtSerieReciboFiscal" ForeColor="Black" ClientEnabled="false" MaxLength="3" Font-Size="Medium" runat="server" Width="75%" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>

                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblContadorContratos" ClientInstanceName="lblContadorContratos" ClientEnabled="false" ForeColor="Black" runat="server" Text="Contador contratos:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtContadorContratos"  ClientInstanceName="txtContadorContratos" ForeColor="Black" ClientEnabled="false" MaxLength="20" Font-Size="Medium" runat="server" Width="75%" Height="16px">
                                           <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblContadorCompra" ClientInstanceName="lblContadorCompra" ClientEnabled="false" ForeColor="Black" runat="server" Text="Contadoro. Compra:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtContadorCompra"  ClientInstanceName="txtContadorCompra" ForeColor="Black" ClientEnabled="false" MaxLength="20" Font-Size="Medium" runat="server" Width="75%" Height="16px">
                                           
                                                  <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />

                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>

                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblAlmacenPredeterminado" ClientInstanceName="lblAlmacenPredeterminado" ClientEnabled="false" ForeColor="Black"  runat="server" Text="Almacén predeterminado:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxComboBox ID="cmbAlmacenPredeterminado" ClientInstanceName="cmbAlmacenPredeterminado" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server"  Width="75%">
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblNoCuenta" runat="server" Text="No. Cuenta:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxComboBox ID="cmbNoCuenta" ClientInstanceName="cmbNoCuenta" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server"  Width="75%">
                                            </dx:ASPxComboBox>
                                        </td>

                                    </tr>

                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblNombreFormatoFactura" ClientInstanceName="lblNombreFormatoFactura" ClientEnabled="false" ForeColor="Black" runat="server" Text="Nombre formato factura:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtNombreFormatoFactura" ClientInstanceName="txtNombreFormatoFactura" MaxLength="100" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Width="75%" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>

                                        <td>
                                            <dx:ASPxLabel ID="lblSucursalFacturadora"  ClientInstanceName="lblSucursalFacturadora" ClientEnabled="false" ForeColor="Black" runat="server" Text="Sucursal Facturadora:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxComboBox ID="cmbSucursalFacturadora" ClientInstanceName="cmbSucursalFacturadora" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server"  Width="75%">
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblNombreFormatoNC"  ClientInstanceName="lblNombreFormatoNC" ClientEnabled="false" ForeColor="Black" runat="server" Text="Nombre formato NC:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtNombreFormatoNC" ClientInstanceName="txtNombreFormatoNC" MaxLength="100" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Width="75%" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                </table>

                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>

                    <br />
                    <br />

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel7" runat="server" HeaderText=" Auxiliares"  Font-Size="Medium" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">

                                <table style="width: 100%">
                                    <tr>                                    
                                      
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblAuxiliarVentas"  ClientInstanceName="lblAuxiliarVentas" ClientEnabled="false" ForeColor="Black" runat="server" Text="Auxiliar ventas:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                       <td style="width: 30%">
                                            <dx:ASPxComboBox ID="cmbAuxiliarVentas" ClientInstanceName="cmbAuxiliarVentas" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Width="75%" TextFormatString="{0} ">
                                                                                             
                                               <ClientSideEvents SelectedIndexChanged="function(s, e){
                                                    LlenaDescAuxVentas();
                                                    }" />
                                                <Columns>
                                                    <dx:ListBoxColumn Caption="Auxiliar" FieldName="ID" Width="200px" />
                                                    <dx:ListBoxColumn Caption="Descripción" FieldName="NombreAu" Width="400px" />
                                                </Columns>
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblDesAuxiliarVentas" ClientEnabled="false" ClientInstanceName="lblDesAuxiliarVentas" ForeColor="Black" runat="server" Text="Descripción:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 30%">
                                            <dx:ASPxComboBox ID="cmbDescAuxiliarVentas" ClientInstanceName="cmbDescAuxiliarVentas" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Width="95%" ValueType="System.String" TextFormatString="{1}">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e){
                                                    LlenaAuxiliarVentas();
                                                    }" />
                                                <Columns>
                                                    <dx:ListBoxColumn Caption="Auxiliar" FieldName="ID" Width="200px" />
                                                    <dx:ListBoxColumn Caption="Descripción" FieldName="NombreAu" Width="400px" />
                                                </Columns>
                                            </dx:ASPxComboBox>
                                            </td>
                                            </tr>
                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                        <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblAuxiliarDevoluciones"  ClientInstanceName="lblAuxiliarDevoluciones" ClientEnabled="false" ForeColor="Black" runat="server" Text="Auxiliar devoluciones:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxComboBox ID="cmbAuxiliarDevoluciones" ClientInstanceName="cmbAuxiliarDevoluciones" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Width="75%" TextFormatString="{0}">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e){
                                                    LlenaDescAuxiliarDevoluciones();
                                                    }" />
                                                <Columns>
                                                    <dx:ListBoxColumn Caption="Auxiliar" FieldName="ID" Width="200px" />
                                                    <dx:ListBoxColumn Caption="Descripción" FieldName="NombreAu" Width="400px" />
                                                </Columns>
                                            </dx:ASPxComboBox>                                          
                                        </td>
                                            <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblDescAuxiliarDevolucione" ClientEnabled="false" ClientInstanceName="lblDescAuxiliarDevolucione" ForeColor="Black" runat="server" Text="Descripción:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbDescAuxiliarDevolucione" ClientInstanceName="cmbDescAuxiliarDevolucione" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Width="95%" ValueType="System.String" TextFormatString="{1}">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e){
                                                    LlenaAuxiliarDevoluciones();
                                                    }" />
                                                <Columns>
                                                    <dx:ListBoxColumn Caption="Auxiliar" FieldName="ID" Width="200px" />
                                                    <dx:ListBoxColumn Caption="Descripción" FieldName="NombreAu" Width="400px" />
                                                </Columns>
                                            </dx:ASPxComboBox>
                                            </td>
                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblAuxiliarDecuentos"  ClientInstanceName="lblAuxiliarDecuentos" ClientEnabled="false" ForeColor="Black" runat="server" Text="Auxiliar descuentos:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>                                       

                                        <td style="width: 30%">
                                            <dx:ASPxComboBox ID="cmbAuxiliarDescuentos" ClientInstanceName="cmbAuxiliarDescuentos" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Width="75%" ValueType="System.String" TextFormatString="{0} ">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e){
                                                    LlenaDescAuxDescuentos();
                                                    }" />
                                                <Columns>
                                                    <dx:ListBoxColumn Caption="Auxiliar" FieldName="ID" Width="200px" />
                                                    <dx:ListBoxColumn Caption="Descripción" FieldName="NombreAu" Width="400px" />
                                                </Columns>
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblDesAuxiliarDecuentos" ClientEnabled="false" ClientInstanceName="lblDesAuxiliarDecuentos" ForeColor="Black" runat="server" Text="Descripción:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 30%">
                                            <dx:ASPxComboBox ID="cmbDescAuxiliarDescuentos" ClientInstanceName="cmbDescAuxiliarDescuentos" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Width="95%" ValueType="System.String" TextFormatString="{1}">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e){
                                                    LlenaAuxiliarDescuentos();
                                                    }" />
                                                <Columns>
                                                    <dx:ListBoxColumn Caption="Auxiliar" FieldName="ID" Width="200px" />
                                                    <dx:ListBoxColumn Caption="Descripción" FieldName="NombreAu" Width="400px" />
                                                </Columns>
                                            </dx:ASPxComboBox>
                                            </td>
                                       
                                            </tr>
                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                       <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblAuxIvaPendiente" ClientInstanceName="lblAuxIvaPendiente" ClientEnabled="false" ForeColor="Black" runat="server" Text="IVA pendiente:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        
                                        <td style="width: 30%">
                                            <dx:ASPxComboBox ID="cmbAuxIvaPendiente" ClientInstanceName="cmbAuxIvaPendiente" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Width="75%"  TextFormatString="{0} ">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e){
                                                    LlenaDescAuxIvaPend();
                                                    }" />
                                                <Columns>
                                                    <dx:ListBoxColumn Caption="Auxiliar" FieldName="ID" Width="200px" />
                                                    <dx:ListBoxColumn Caption="Descripción" FieldName="NombreAu" Width="400px" />
                                                </Columns>
                                            </dx:ASPxComboBox>
                                        </td>

                                         <td style="width:20%">
                                            <dx:ASPxLabel ID="lblDescAuxIvaPendiente" ClientEnabled="false" ClientInstanceName="lblDescAuxIvaPendiente" ForeColor="Black" runat="server" Text="Descripción :" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 30%">
                                            <dx:ASPxComboBox ID="cmbDescAuxIvaPendiente" ClientInstanceName="cmbDescAuxIvaPendiente" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Width="95%" ValueType="System.String" TextFormatString="{1}">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e){
                                                    LlenaAuxIvaPendiente();
                                                    }" />
                                                <Columns>
                                                    <dx:ListBoxColumn Caption="Auxiliar" FieldName="ID" Width="200px" />
                                                    <dx:ListBoxColumn Caption="Descripción" FieldName="NombreAu" Width="400px" />
                                                </Columns>
                                            </dx:ASPxComboBox>
                                            </td>
                                       
                                    </tr>
                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>                                        
                                        <td>
                                            <dx:ASPxLabel ID="lblEmpresa"   ClientInstanceName="lblEmpresa" ClientEnabled="false" ForeColor="Black" runat="server" Text="Empresa:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbEmpresa" ClientInstanceName="cmbEmpresa" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server"  Width="95%">
                                            </dx:ASPxComboBox>
                                        </td>
                                
                                        <td>
                                            <dx:ASPxLabel ID="lblAreaRegion"   ClientInstanceName="lblAreaRegion" ClientEnabled="false" ForeColor="Black" runat="server" Text="Área o región:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td >
                                            <dx:ASPxComboBox ID="cmbAreaRegion" ClientInstanceName="cmbAreaRegion" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server"  Width="75%">
                                            </dx:ASPxComboBox>
                                        </td>
                                           <td>
                                            &nbsp;
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>

                                    </tr>

                                </table>

                                <br />
                                <br />

                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>

                    <br />
                    <br />

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel6" runat="server" HeaderText="Centro de costos por proceso" Font-Size="Medium"  Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">

                                <table style="width: 100%">

                                    <tr>
                                        <td>
                                            <dx:ASPxGridView ID="GVCentroCostosProceso" ClientInstanceName="GVCentroCostosProceso" Width="100%" AutoGenerateColumns="false" runat="server" KeyFieldName="IDOPC" ClientIDMode="AutoID" Font-Size="Medium" SettingsCommandButton-CancelButton-Text="Cancelar" SettingsCommandButton-UpdateButton-Text="Guardar">
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
                                            </dx:ASPxGridView>                                          

                                        </td>
                                    </tr>
                                </table>

                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>

                    <br />
                    <br />


                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>


    </form>
</body>
</html>
