<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ProductoFinanciero.aspx.vb" Inherits="Funcionalidad_ProductoFinanciero" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/ProductoFinanciero.js"></script>
    <title>ProductoFinanciero</title>
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
}"
                                            CheckedChanged="function(s, e) {
if (s.GetChecked()){
LimpiaControles();
HabilitaProdFin();
           }
else	{
DeshabilitaProdFin();
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
HabilitaProdFin();
           }
else	{
DeshabilitaProdFin();
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
MuestraProdFin();
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
                                             if (txtIdProducto.GetText() == '') {
txtIdProducto.SetText(s.cpProdFin); 
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




                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="Prod_fin_id" AutoGenerateColumns="False" TextFormatString="{0} | {5}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraProdFin();
                                                                        HabilitaBotones();
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

        <dx:ASPxRoundPanel ID="ASPxRoundPanel3" runat="server" HeaderText="Productos Financieros" Font-Size="Large" Font-Bold="true" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Parámetros financieros" Font-Size="Large" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">

                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblIdProducto" ClientInstanceName="lblIdProducto" Text="ID Producto:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>

                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtIdProducto" ClientInstanceName="txtIdProducto" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" MaxLength="10" runat="server" Width="25%">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblTipoContrato" ClientInstanceName="lblTipoContrato" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Text="Tipo de contrato:"></dx:ASPxLabel>
                                            
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbTipoContrato" ClientInstanceName="cmbTipoContrato" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String">
                                             
                                            </dx:ASPxComboBox>                                           
                            
                       
                                        </td>
                                      
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        
                                          <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblDescCorta" ClientInstanceName="lblDescCorta" Text="Nombre corto:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>

                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtDescCorta" ClientInstanceName="txtDescCorta" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" MaxLength="10" runat="server" Width="50%">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblProducto" ClientInstanceName="lblProducto" Text="Nombre:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtProducto" ClientInstanceName="txtProducto" MaxLength="50" Width="95%" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server">
                                            </dx:ASPxTextBox>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>                                        
                                            <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblTipoOperacion" ClientInstanceName="lbl" Text="Tipo de operación:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbTipoOperacion" ClientInstanceName="cmbTipoOperacion" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" Width="50%" runat="server" ValueType="System.String">
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblMoneda" ClientInstanceName="lblMoneda" Text="Moneda:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbMoneda" ClientInstanceName="cmbMoneda" Width="50%" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String">
                                            </dx:ASPxComboBox>
                                        </td>
                                      
                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                          <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblCtaRecProp" ClientInstanceName="lblCtaRecProp" Text="Cta. Rec. Prop:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbCtaRecProp" ClientInstanceName="cmbCtaRecProp" Width="75%" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String">
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblTasaBase" ClientInstanceName="lblTasaBase" Text="Tasa base:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbTasaBase" ClientInstanceName="cmbTasaBase" Width="75%" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String">
                                            </dx:ASPxComboBox>
                                        </td>
                                        </tr>
                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblOrigenRecursos" ClientInstanceName="lblOrigenRecursos" Text="Origen Recursos:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbOrigenRecursos" ClientInstanceName="cmbOrigenRecursos" Width="75%" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String">
                                            </dx:ASPxComboBox>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblPlazoMin" ClientInstanceName="lblPlazoMin" Text="Plazo mínimo:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>

                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbPlazoMin" ClientInstanceName="cmbPlazoMin" Width="75%" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String">
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxTextBox ID="txtPlazomintime" ClientInstanceName="txtPlazomintime" MaxLength="3" Width="50%" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server">
                                           <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>
                                        </td>

                                        <td></td>


                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblPlazoMax" ClientInstanceName="lblPlazoMax" Text="Plazo máximo:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbPlazoMax" ClientInstanceName="cmbPlazoMax" Width="75%" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String">
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxTextBox ID="txtPlazomaxtime" ClientInstanceName="txtPlazomaxtime" MaxLength="3" Width="50%" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server">
                                          <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>

                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblPerrevtasa" ClientInstanceName="lblPerrevtasa" Text="Revisión tasa:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbPerrevtasa" ClientInstanceName="cmbPerrevtasa" Width="75%" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String">
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxTextBox ID="txtPerrevtasatime" ClientInstanceName="txtPerrevtasatime" MaxLength="3" Width="50%" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server">
                                            <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>
                                        </td>
                                        <td></td>
                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblPercobint" ClientInstanceName="lblPercobint" Text="Cobro interés:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbPercobint" ClientInstanceName="cmbPercobint" Width="75%" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String">
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxTextBox ID="txtPercobinttime" ClientInstanceName="txtPercobinttime" MaxLength="10" Width="50%" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server">
                                            <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>
                                        </td>
                                        <td></td>


                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblPercobcapital" ClientInstanceName="lblPercobcapital" Text="Cobro capital:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbPercobcapital" ClientInstanceName="cmbPercobcapital" Width="75%" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String">
                                            </dx:ASPxComboBox>
                                        </td>

                                        <td style="width: 15%">
                                            <dx:ASPxTextBox ID="txtPercobcaptime" ClientInstanceName="txtPercobcaptime" MaxLength="10" Width="50%" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server">
                                            <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>
                                        </td>
                                        <td></td>
                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblBaseAnual" ClientInstanceName="lblBaseAnual" Text="Base anual:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbBaseAnual" ClientInstanceName="cmbBaseAnual" Width="75%" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String">
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblAmortizacion" ClientInstanceName="lblAmortizacion" Text="Amortización:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbAmortizacion" ClientInstanceName="cmbAmortizacion" Width="75%" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String">
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblFacMinTasa" ClientInstanceName="lblFacMinTasa" Text="Factor mínimo:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtFacMinTasa" ClientInstanceName="txtFacMinTasa" MaxLength="10" Width="50%" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server">
                                            </dx:ASPxTextBox>
                                        </td>

                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblFacMaxTasa" ClientInstanceName="lblFacMaxTasa" Text="Factor máximo:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtFacMaxTasa" ClientInstanceName="txtFacMaxTasa" MaxLength="10" Width="50%" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server">
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
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblPtsMinTasa" ClientInstanceName="lblPtsMinTasa" Text="Puntos mín:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtPtsMinTasa" ClientInstanceName="txtPtsMinTasa" MaxLength="10" Width="50%" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server">
                                           <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblPtsMaxTasa" ClientInstanceName="lblPtsMaxTasa" Text="Puntos máx.:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtPtsMaxTasa" ClientInstanceName="txtPtsMaxTasa" MaxLength="10" Width="50%" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server">
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

                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblFacMor" ClientInstanceName="lblFacMor" Text="Factor moratorio:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>

                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtFacMor" ClientInstanceName="txtFacMor" MaxLength="10" Width="50%" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server">
                                            <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>
                                        </td>

                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblFactorGrtias" ClientInstanceName="lblFactorGrtias" Text="Factor de garantías:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>

                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtFactorGrtias" ClientInstanceName="txtFactorGrtias" MaxLength="10" Width="50%" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server">
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

                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblNumMaxRenova" ClientInstanceName="lblNumMaxRenova" Text="Número renovación:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>

                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtNumMaxRenova" ClientInstanceName="txtNumMaxRenova" MaxLength="10" Width="50%" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server">
                                            <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>
                                        </td>

                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblNoMaxDisp" ClientInstanceName="lblNoMaxDisp" Text="No. Máx. Disposiciones:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>

                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtNoMaxDisp" ClientInstanceName="txtNoMaxDisp" MaxLength="10" Width="50%" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server">
                                           <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>
                                        </td>
                                    </tr>

                               

                                </table>


                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>

                    <br />
                  

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" HeaderText="Parámetros operativos" Font-Size="Large" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">

                                <table style="width: 100%">

                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblComisionAper" ClientInstanceName="lblComisionAper" Text="Comisión por apertura:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>

                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbComisionAper" ClientInstanceName="cmbComisionAper" Width="50%" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String">
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblComisionDisp" ClientInstanceName="lblComisionDisp" Text="Comisión por disposición:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbComisionDisp" ClientInstanceName="cmbComisionDisp" Width="50%" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String">
                                            </dx:ASPxComboBox>
                                        </td>


                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblComisionCanc" ClientInstanceName="lblComisionCanc" Text="Comisión por cancelación:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>

                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbComisionCanc" ClientInstanceName="cmbComisionCanc" Width="50%" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String">
                                            </dx:ASPxComboBox>
                                        </td>

                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblComisionOt" ClientInstanceName="lblComisionOt" Text="Comisión otros:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>

                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbComisionOt" ClientInstanceName="cmbComisionOt" Width="50%" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String">
                                            </dx:ASPxComboBox>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblAval" ClientInstanceName="lblAval" Text="Aval:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxRadioButtonList ID="rblAval" ClientInstanceName="rblAval" ClientEnabled="false" runat="server" Border-BorderStyle="None" Font-Size="Medium" ForeColor="Black" TextAlign="Left" RepeatDirection="Horizontal" ValueType="System.String">
                                                <Items>
                                                    <dx:ListEditItem Text="Si" Value="1" />
                                                    <dx:ListEditItem Text="No" Value="0" />
                                                </Items>

                                                <Border BorderStyle="None"></Border>
                                            </dx:ASPxRadioButtonList>
                                        </td>

                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblCambioDeudor" ClientInstanceName="lblCambioDeudor" Text="Cambio deudor:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxRadioButtonList ID="rblCambioDeudor" ClientInstanceName="rblCambioDeudor" ClientEnabled="false" runat="server" Border-BorderStyle="None" Font-Size="Medium" ForeColor="Black" TextAlign="Left" RepeatDirection="Horizontal" ValueType="System.String">
                                                <Items>
                                                    <dx:ListEditItem Text="Si" Value="1" />
                                                    <dx:ListEditItem Text="No" Value="0" />
                                                </Items>

                                                <Border BorderStyle="None"></Border>
                                            </dx:ASPxRadioButtonList>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblImpAnexoalContrato" ClientInstanceName="lblImpAnexoalContrato" Text="Anexo en el contrato:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxRadioButtonList ID="rblImpAnexoalContrato" ClientInstanceName="rblImpAnexoalContrato" ClientEnabled="false" runat="server" Border-BorderStyle="None" Font-Size="Medium" ForeColor="Black" TextAlign="Left" RepeatDirection="Horizontal" ValueType="System.String">
                                                <Items>
                                                    <dx:ListEditItem Text="Si" Value="1" />
                                                    <dx:ListEditItem Text="No" Value="0" />
                                                </Items>

                                                <Border BorderStyle="None"></Border>
                                            </dx:ASPxRadioButtonList>
                                        </td>

                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblIvaInteres" ClientInstanceName="lblIvaInteres" Text="IVA Interés:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxRadioButtonList ID="rblIvaInteres" ClientInstanceName="rblIvaInteres" ClientEnabled="false" runat="server" Border-BorderStyle="None" Font-Size="Medium" ForeColor="Black" TextAlign="Left" RepeatDirection="Horizontal" ValueType="System.String">
                                                <Items>
                                                    <dx:ListEditItem Text="Si" Value="1" />
                                                    <dx:ListEditItem Text="No" Value="0" />
                                                </Items>

                                                <Border BorderStyle="None"></Border>
                                            </dx:ASPxRadioButtonList>
                                        </td>
                                        <td></td>
                                        <td></td>

                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblPrecioCredito" ClientInstanceName="lblPrecioCredito" Text="Precio a crédito:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxRadioButtonList ID="rblPrecioCredito" ClientInstanceName="rblPrecioCredito" ClientEnabled="false" runat="server" Border-BorderStyle="None" Font-Size="Medium" ForeColor="Black" TextAlign="Left" RepeatDirection="Horizontal" ValueType="System.String">
                                                <Items>
                                                    <dx:ListEditItem Text="Si" Value="1" />
                                                    <dx:ListEditItem Text="No" Value="0" />
                                                </Items>

                                                <Border BorderStyle="None"></Border>
                                            </dx:ASPxRadioButtonList>
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblImprimeContPag" ClientInstanceName="lblImprimeContPag" Text="Imprime contrato y pagaré:" ForeColor="Black" Font-Size="Medium" runat="server" ClientEnabled="false">
                                            </dx:ASPxLabel>
                                        </td>
                                        
                                            <td style="width: 35%">
                                                <dx:ASPxComboBox ID="cmbImprimeContPag" ClientInstanceName="cmbImprimeContPag" Width="95%" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String">
                                                </dx:ASPxComboBox>
                                            </td>
                                        <td></td>
                                        <td></td>
                                    </tr>                                 
                                    
                                </table>

                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>


                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>

    </form>
</body>
</html>
