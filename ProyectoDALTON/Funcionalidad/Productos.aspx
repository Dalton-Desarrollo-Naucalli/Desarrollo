<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Productos.aspx.vb" Inherits="Funcionalidad_Productos" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="../funcionesJS/Principal.js"></script>
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/Productos.js"></script>
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
        .auto-style4 {
            height: 80px;
        }
    </style>
</head>
<body onkeypress="return pulsar(event)">
    <form id="form1" runat="server">
        <div>
            <br />
      <%--  BOTONES PANEL (AGREGA, EDITA, ELIMINA, ACTUALIZA)--%>
        <dx:ASPxRoundPanel ID="ASPxRoundPanel4" runat="server" ShowCollapseButton="True" ShowHeader="False"  Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <table class="auto-style40">
                        <tr>
                            <td class="auto-style4">
                                <dx:ASPxButton ID="btnAgregar" runat="server" ToolTip="Agregar" ClientInstanceName="btnAgregar" AutoPostBack="False" EnableClientSideAPI="false" ClientEnabled="False" GroupName="A" TabIndex="100">
                                    <ClientSideEvents Click="function(s, e) {
Enc_BotonAgregar();
LimpiaControles();
GVProdProv.Refresh();
}"
                                        CheckedChanged="function(s, e) {
if (s.GetChecked()){
LimpiaControles();
HabilitaProductos();
           }
else	{
DeshabilitaProductos();
       }
}
" />
                                    <Image IconID="actions_add_32x32">
                                    </Image>
                                </dx:ASPxButton>


                                <dx:ASPxCallback ID="cbAgregar" runat="server" ClientIDMode="AutoID" ClientInstanceName="cbAgregar"> 
                                </dx:ASPxCallback>
                            </td>
                            <td class="auto-style4">
                                <dx:ASPxButton ID="btnEditar" runat="server" ToolTip="Editar" ClientInstanceName="btnEditar" AutoPostBack="False" EnableClientSideAPI="false" ClientEnabled="False" GroupName="B" TabIndex="101">
                                    <ClientSideEvents Click="function(s, e) {
Enc_BotonEditar();
}"
                                        CheckedChanged="function(s, e) {
if (s.GetChecked()) {
HabilitaProductos();
           }
else	{
DeshabilitaProductos();
       }
}
" />
                                    <Image IconID="edit_edit_32x32">
                                    </Image>
                                </dx:ASPxButton>
                                <dx:ASPxCallback ID="cbEditar" runat="server" ClientInstanceName="cbEditar">
                                    <ClientSideEvents EndCallback="function(s, e) {

}" BeginCallback="function(s, e) {

}" />
                                </dx:ASPxCallback>
                            </td>
                            <td class="auto-style4">
                                <dx:ASPxButton ID="btnEliminar" runat="server" ToolTip="Eliminar" AutoPostBack="False" ClientInstanceName="btnEliminar" EnableClientSideAPI="True" ClientEnabled="True" TabIndex="103">
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
                                <dx:ASPxButton ID="btnCancelar" runat="server" AutoPostBack="False" ClientInstanceName="btnCancelar" ToolTip="Cancelar" EnableClientSideAPI="True" ClientEnabled="False" TabIndex="104">
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
MuestraProductos();
}
}" />
                                </dx:ASPxCallback>
                            </td>
                            <td class="auto-style4">
                                <dx:ASPxButton ID="btnActualizar" runat="server" AutoPostBack="False" ClientInstanceName="btnActualizar" ToolTip="Actualizar" ValidationGroup="reqError1" EnableClientSideAPI="true" CausesValidation="False" ClientEnabled="False" TabIndex="104">
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
if (txtNoProducto.GetText() == '') {
txtNoProducto.SetText(s.cpIDProd);
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



        <br />
        <%--GRIDLOOKUP BUSQUEDA--%>
        
            <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" HeaderText="Búsqueda:" Font-Size="Medium" Font-Bold="false"  Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">


                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="prod_id" AutoGenerateColumns="False" TextFormatString="{0} | {6}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
MuestraProductos();
HabilitaBotones();
}" />
                            <ClientSideEvents TextChanged="function(s, e) {
colapsed();
	GVProdProv.Refresh();
}"  />
                        </dx:ASPxGridLookup>
                        <asp:Label ID="lblAccesos" runat="server" CssClass="GlobalTextoPanel" Visible="False"></asp:Label>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>
            <br />
            <br />
        </div>

        <%--CABECERO--%>
        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Productos" Font-Bold="true" Font-Size="Medium"  Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" HeaderText="Datos generales" Font-Size="Medium"  Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">

                                <table style="width: 100%">
                                    
                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblNoProducto" runat="server" Text="No. Producto:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 30%">

                                            <dx:ASPxTextBox ID="txtNoProducto" Font-Size="Medium" runat="server" ClientInstanceName="txtNoProducto" ClientIDMode="AutoID" Width="25%" Height="16px" ClientEnabled="False" ForeColor="Black" TabIndex="1">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblTipoDeProducto" runat="server" Text="Tipo de producto:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblTipoDeProducto"></dx:ASPxLabel>
                                        </td>
                                        <td >
                                            <dx:ASPxComboBox ID="cmbTipoDeProducto" runat="server" ClientInstanceName="cmbTipoDeProducto" Font-Size="Medium"  Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="7">
                                                <Items>
                                                    <dx:ListEditItem Text="Activo" Value="1" />
                                                    <dx:ListEditItem Text="Consumible" Value="2" />
                                                    <dx:ListEditItem Text="Mercancía" Value="3" />
                                                    <dx:ListEditItem Text="Servicios" Value="4" />
                                                </Items>
                                                <ClientSideEvents GotFocus="function(s, e) {
//if (cmbCategoria.GetText() == ''){
//alert('Selecciona la Categoría del Producto');
//}
//else if (cmbMarca.GetText() == ''){
//alert('Selecciona la Marca del Producto');
//}
//else if(cmbModelo.GetText() == ''){
//alert('Selecciona el Modelo del Producto');
//}
//else if(cmbUnidadDeMedida.GetText() == ''){
//alert('Selecciona la Unidad de medida del Producto');
//}
//else if(cmbTipoManejoInventario.GetText() == ''){
//alert('Selecciona el Tipo de manejo de Inventario del Producto');
//}
	
}" SelectedIndexChanged="function(s, e) {
TipoProducto();
}" />
                                               
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                       <tr>
                                        <td style="padding:4px">
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblCategoria" ClientInstanceName="lblCategoria" runat="server" Text="Categoría:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 30%">
                                            <dx:ASPxComboBox ID="cmbCategoria" runat="server" ClientInstanceName="cmbCategoria" Font-Size="Medium" Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="2" AutoPostBack="False">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e) {
//CargaMarca();
}" />
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblCapaDepreciacion" runat="server" Text="Capa de depreciación:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblCapaDepreciacion"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbCapaDepreciacion" runat="server" ClientInstanceName="cmbCapaDepreciacion" Font-Size="Medium" Width="75%" ClientEnabled="false" ForeColor="Black" TabIndex="8">
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                       <tr>
                                        <td style="padding:4px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblMarca" runat="server" Text="Marca:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblMarca"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 30%">
                                            <dx:ASPxComboBox ID="cmbMarca" runat="server" ClientInstanceName="cmbMarca" Font-Size="Medium" Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="3" AutoPostBack="False">
                                                  <ClientSideEvents GotFocus="function(s, e) {
//if (cmbCategoria.GetText() == ''){
//alert('Selecciona la Categoría del Producto');
//}
}	" SelectedIndexChanged="function(s, e) {
//CargaModelo();
}" />
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblClase" runat="server" Text="Clase:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblClase"></dx:ASPxLabel>
                                        </td>
                                        <td >
                                            <dx:ASPxComboBox ID="cmbClase" runat="server" ClientInstanceName="cmbClase" Font-Size="Medium"  Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="9" AutoPostBack="False">
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                       <tr>
                                        <td style="padding:4px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td >
                                            <dx:ASPxLabel ID="lblModelo" runat="server" Text="Modelo:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblModelo"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 30%">
                                            <dx:ASPxComboBox ID="cmbModelo" runat="server" ClientInstanceName="cmbModelo" Font-Size="Medium" Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="4" AutoPostBack="False">
                                                <ClientSideEvents DropDown="function(s, e) {

}
" GotFocus="function(s, e) {
//if (cmbCategoria.GetText() == ''){
//alert('Selecciona la Categoría del Producto');
//}
//else if (cmbMarca.GetText() == ''){
//alert('Selecciona la Marca del Producto');
//}	
}" SelectedIndexChanged="function(s, e) {
//CargaUnidad();	
}" />
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblConcepto" runat="server" Text="Concepto:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblConcepto"></dx:ASPxLabel>
                                        </td>
                                        <td >
                                            <dx:ASPxComboBox ID="cmbConcepto" runat="server" ClientInstanceName="cmbConcepto" Font-Size="Medium"  Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="10" AutoPostBack="False">
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                        <tr>
                                        <td style="padding:4px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblUnidadDeMedida" runat="server" Text="Unidad de medida:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblUnidadDeMedida"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 30%">
                                            <dx:ASPxComboBox ID="cmbUnidadDeMedida" runat="server" ClientInstanceName="cmbUnidadDeMedida" Font-Size="Medium" Width="75%" ClientIDMode="AutoID" ClientEnabled="False" ForeColor="Black" TabIndex="5" AutoPostBack="False">
                                                <ClientSideEvents GotFocus="function(s, e) {
//if (cmbCategoria.GetText() == ''){
//alert('Selecciona la Categoría del Producto');
//}
//else if (cmbMarca.GetText() == ''){
//alert('Selecciona la Marca del Producto');
//}
//else if(cmbModelo.GetText() == ''){
//alert('Selecciona el Modelo del Producto');
//}	
}" SelectedIndexChanged="function(s, e) {
//CargaTipoManejo();	
}" />
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblValuacionInventario" runat="server" Text="Valuación inventario:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblValuacionInventario"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbValuacionInventario" runat="server" ClientInstanceName="cmbValuacionInventario" ValueType="System.String" Font-Size="Medium" ClientEnabled="false" Width="75%" ForeColor="Black" TabIndex="11">
                                           
                                                <Items>
                                                    <dx:ListEditItem Text="PEPS" Value="PEPS" />
                                                    <dx:ListEditItem Text="UEPS" Value="UEPS" />
                                                    <dx:ListEditItem Text="PROM" Value="PROM" />
                                                    <dx:ListEditItem Text="CODE" Value="CODE" />
                                                </Items>
                                                </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                        <tr>
                                        <td style="padding:2px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblTipoManejoInventario" runat="server" Text="Tipo manejo de inventario:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblTipoManejoInventario"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 30%">
                                            <dx:ASPxComboBox ID="cmbTipoManejoInventario" runat="server" ClientInstanceName="cmbTipoManejoInventario" Font-Size="Medium"  Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="6" AutoPostBack="False">                 
                                                <Items>
                                                    <dx:ListEditItem Text="No sobrevendible" Value="0" />
                                                    <dx:ListEditItem Text="Sobrevendible" Value="1" />   
                                                </Items>
                                                <ClientSideEvents GotFocus="function(s, e) {
//if (cmbCategoria.GetText() == ''){
//alert('Selecciona la Categoría del Producto');
//}
//else if (cmbMarca.GetText() == ''){
//alert('Selecciona la Marca del Producto');
//}
//else if(cmbModelo.GetText() == ''){
//alert('Selecciona el Modelo del Producto');
//}
//else if(cmbUnidadDeMedida.GetText() == ''){
//alert('Selecciona la Unidad de medida del Producto');
//}
	
}" SelectedIndexChanged="function(s, e) {
//CargaTipoProducto();	
}" />
                                            </dx:ASPxComboBox>
                                        </td>
                                          <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblOrigen" runat="server" Text="Origen:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblOrigen"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxRadioButtonList ID="rbtnOrigen" runat="server" Border-BorderStyle="None" ClientInstanceName="rbtnOrigen" RepeatDirection="Horizontal" Font-Size="Medium" ClientEnabled="False" ForeColor="Black" TabIndex="12">
                                                <Items>
                                                    <dx:ListEditItem Text="Extranjera" Value="0" />
                                                    <dx:ListEditItem Text="Nacional" Value="1" />
                                                </Items>

<Border BorderStyle="None"></Border>
                                            </dx:ASPxRadioButtonList>
                                        </td>
                                        </tr>
                                         <tr>
                                        <td style="padding:2px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblExistenciasMinimas" runat="server" Text="Existencia Mínima:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblExistenciasMinimas"></dx:ASPxLabel>
                                        </td>
                                        <td style="width:30%">
                                            <dx:ASPxTextBox ID="txtExistenciaMin" runat="server" ClientInstanceName="txtExistenciaMin" Font-Size="Medium" Height="16px" Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="13" MaxLength="4">                                            
                                                <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblExistenciaMaxima" runat="server" Text="Existencia Máxima:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblExistenciaMaxima"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtExistenciaMax" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtExistenciaMax" Font-Size="Medium" Height="16px" Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="14" MaxLength="4">
                                                <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                        <tr>
                                        <td style="padding:2px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblIndividualizable" runat="server" Text="Individualizable:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxRadioButtonList ID="rbtnIndividualizable" runat="server" Border-BorderStyle="None" RepeatDirection="Horizontal" ClientInstanceName="rbtnIndividualizable" Font-Size="Medium" ClientEnabled="False" ForeColor="Black" TabIndex="15">
                                                <Items>
                                                    <dx:ListEditItem Text="Si" Value="S" />
                                                    <dx:ListEditItem Text="No" Value="N" />
                                                </Items>

<Border BorderStyle="None"></Border>
                                            </dx:ASPxRadioButtonList>
                                        </td>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblClasificacionArancelaria" runat="server" Text="Clasificación arancelaria:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblClasificacionArancelaria"></dx:ASPxLabel>
                                        </td>
                                        <td >
                                            <dx:ASPxComboBox ID="cmbClasificacionArancelaria" runat="server" ClientIDMode="AutoID" ClientInstanceName="cmbClasificacionArancelaria" Font-Size="Medium"  Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="16" AutoPostBack="False">
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                     <tr>
                                        <td style="padding:2px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblDescripcionCorta" runat="server" Text="Descripción corta:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblDescripcionCorta"></dx:ASPxLabel>
                                        </td>
                                        <td colspan="3" style="width:30%">
                                            <dx:ASPxTextBox ID="txtDescripcionCorta" runat="server" ClientInstanceName="txtDescripcionCorta" Font-Size="Medium" Height="16px" Width="91%" ClientEnabled="False" ForeColor="Black" TabIndex="17" MaxLength="80">                                                
                                            </dx:ASPxTextBox>
                                        </td>
                                        
                                    </tr>
                                    <tr>
                                        <td style="padding:4px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblDescrpcionSintetica" runat="server" Text="Descripción sintética:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblDescrpcionSintetica"></dx:ASPxLabel>
                                        </td>
                                        <td colspan="3" style="width:30%">
                                            <dx:ASPxTextBox ID="txtDescripcionsintetica" runat="server" ClientInstanceName="txtDescripcionsintetica" Font-Size="Medium" Height="16px" Width="91%" ClientEnabled="False" ForeColor="Black" TabIndex="18" MaxLength="250">                                             
                                            </dx:ASPxTextBox>
                                     
                                    </tr>
                                        <tr>
                                        <td style="padding:4px">
                                        </td>
                                    </tr>
                                    <tr>                                    
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblDescripcionCompleta" runat="server" Font-Size="Medium" Style="text-align: left" Text="Descripción Completa:" Width="100%" ClientInstanceName="lblDescripcionCompleta">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td colspan="3">
                                            <dx:ASPxTextBox ID="txtDescripcionCompleta" runat="server" ClientEnabled="False" ClientInstanceName="txtDescripcionCompleta" Font-Size="Medium" Height="90%" Width="91%" ForeColor="Black" TabIndex="19" MaxLength="400">
                                       
                                            </dx:ASPxTextBox>
                                        </td>

                                        
                                    </tr>
                                        <tr>
                                        <td style="padding:4px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblTipoComi" runat="server" Font-Size="Medium" Style="text-align: left" Text="Tipo de comisión:" Width="100%" ClientInstanceName="lblTipoComi">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbTipoDeComision" runat="server" ClientEnabled="False" ClientInstanceName="cmbTipoDeComision" Font-Size="Medium" Width="75%" ForeColor="Black" TabIndex="20" AutoPostBack="False">
                                                <Items>
                                                    <dx:ListEditItem Text="Margen" Value="0" />
                                                    <dx:ListEditItem Text="Monto" Value="1" />
                                                    <dx:ListEditItem Text="Porcentaje" Value="2" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblValor" runat="server" Text="Valor:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblValor"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtValor" runat="server"  ClientInstanceName="txtValor" Font-Size="Medium" Height="16px" Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="25" MaxLength="4">                                                
                                                <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                        <tr>
                                        <td style="padding:4px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblNumeroDeParte" runat="server" Text="Número de parte:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblNumeroDeParte"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtNumeroDeParte" runat="server" ClientInstanceName="txtNumeroDeParte" Font-Size="Medium" Height="16px" Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="21" MaxLength="25">                                               
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblPrecioPublico" runat="server" Text="Precio público:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblPrecioPublico"></dx:ASPxLabel>
                                        </td>
                                        <td >
                                            <dx:ASPxTextBox ID="txtPrecioPubico" runat="server"  ClientInstanceName="txtPrecioPubico" Font-Size="Medium" Height="16px" Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="26" MaxLength="8">                                                
                                                <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>&nbsp;</td>
                                    </tr>
                                        <tr>
                                        <td style="padding:4px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblCodigoFabricante" runat="server" Text="Código del fabricante:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblCodigoFabricante"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtCodigoFabricante" runat="server" ClientInstanceName="txtCodigoFabricante" Font-Size="Medium" Height="16px" Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="22" MaxLength="25">                                                
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblMaxPrecioCompra" runat="server" Text="Máx. Precio compra:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblMaxPrecioCompra"></dx:ASPxLabel>
                                        </td>
                                        <td >
                                            <dx:ASPxTextBox ID="txtMaxPrecioCompra" runat="server" ClientInstanceName="txtMaxPrecioCompra" Font-Size="Medium" Height="16px" Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="27" MaxLength="8">
                                                <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                <CaptionSettings Position="Top" />
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                        <tr>
                                        <td style="padding:4px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblMonedaPrecioVenta" runat="server" Text="Moneda precio venta:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblMonedaPrecioVenta"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbMonedaPrecioVenta" runat="server" ClientInstanceName="cmbMonedaPrecioVenta" Font-Size="Medium" Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="23" AutoPostBack="False">
                                                <CaptionSettings Position="Top" />
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblMaxCostoIndirecto" runat="server" Text="Máx. Costo indirecto:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblMaxCostoIndirecto"></dx:ASPxLabel>
                                        </td>
                                        <td >
                                            <dx:ASPxTextBox ID="txtMaxCostoIndirecto" runat="server" ClientInstanceName="txtMaxCostoIndirecto" Font-Size="Medium" Height="16px" Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="28" MaxLength="8">
                                                <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                <CaptionSettings Position="Top" />
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                        <tr>
                                        <td style="padding:4px">
                                        </td>
                                    </tr>
                                    <tr>
                                        <td >
                                            <dx:ASPxLabel ID="lblPrecioMinVenta" runat="server" Text="Precio mín. Venta:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblPrecioMinVenta"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtPrecioMinVenta" runat="server"  ClientInstanceName="txtPrecioMinVenta" Font-Size="Medium" Height="16px" Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="24" MaxLength="8">    
                                                <ClientSideEvents KeyPress="function(s, e) {
oNumero(txtPrecioMinVenta.GetText());
//ValidaSoloNumeros();	
}" />
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td >
                                            <dx:ASPxLabel ID="lblVigenciaPrecio" runat="server" Text="Vigencia Precio:" Font-Size="medium" Width="100%" Style="text-align: left" ClientInstanceName="lblVigenciaPrecio"></dx:ASPxLabel>
                                        </td>
                                        <td >
                                            <dx:ASPxDateEdit ID="txtVigenciaPrecio" runat="server" ClientInstanceName="txtVigenciaPrecio" Font-Size="Medium" Height="16px" Width="75%" ClientEnabled="False" ForeColor="Black" TabIndex="29" UseMaskBehavior="true">                                         
                                            </dx:ASPxDateEdit>
                                        </td>
                                    </tr>
                                       <tr>
                                        <td style="padding:4px">
                                        </td>
                                    </tr>
                              </table>
                                   <dx:ASPxRoundPanel ID="ASPxRoundPanel3" runat="server" HeaderText="Relación Producto - Proveedor" Font-Size="Medium"  Width="93%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">

                                <table style="width:100%">

                                    <tr>
                                        <td >                                            
                                            <dx:ASPxGridView ID="GVProdProv" runat="server" AutoGenerateColumns="False" Width="100%" ClientIDMode="AutoID" ClientInstanceName="GVProdProv" KeyFieldName="prov_id" ForeColor="Black" TabIndex="30">                               
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
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>

                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>

    </form>
</body>
</html>
