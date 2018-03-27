<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Almacenes.aspx.vb" Inherits="Funcionalidad_Almacenes" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/Almacenes.js"></script>
    <title>Almacén</title>
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
HabilitaAlmacenes();
           }
else	{
DeshabilitaAlmacenes();
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
HabilitaAlmacenes();
           }
else	{
DeshabilitaAlmacenes();
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
MuestraAlmacenes();
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
 if (txtNoAlmacen.GetText() == '') {
txtNoAlmacen.SetText(s.cpNoAlmacen);
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


                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="ID_almacen" AutoGenerateColumns="False" TextFormatString="{0} | {2}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraAlmacenes();
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
        <br />
        <dx:ASPxRoundPanel ID="ASPxRoundPanel3" runat="server" ShowCollapseButton="True" HeaderText="Almacenes" Font-Bold="true" Font-Size="Medium" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">

                    <table style="width: 100%">
                        <tr>
                            <td style="width: 15%">
                                <dx:ASPxLabel ID="lblNoAlmacen" ClientInstanceName="lblNoAlmacen" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    runat="server" Text="No. Almacén:">
                                </dx:ASPxLabel>
                            </td>
                            <td style="width: 35%">
                                <dx:ASPxTextBox ID="txtNoAlmacen" ClientInstanceName="txtNoAlmacen" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    MaxLength="15" runat="server" Width="25%">
                                </dx:ASPxTextBox>
                            </td>
                            <td>
                                <dx:ASPxLabel ID="lblDescripcion" ClientInstanceName="lblDescripcion" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    runat="server" Text="Descripción:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="txtDescripcion" ClientInstanceName="txtDescripcion" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    MaxLength="100" runat="server" Width="75%">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 4px;"></td>
                        </tr>
                        <tr>
                            <td>

                                <dx:ASPxLabel ID="lblEncargado" ClientInstanceName="lblEncargado" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    runat="server" Text="Encargado:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxComboBox ID="cmbEncargado" ClientInstanceName="cmbEncargado" ClientEnabled="false" ForeColor="Black" Width="75%" Font-Size="Medium" runat="server" ValueType="System.String"></dx:ASPxComboBox>
                            </td>
                            <td>
                                <dx:ASPxLabel ID="lblDireccion" ClientInstanceName="lblDireccion" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    runat="server" Text="Dirección:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="txtDireccion" ClientInstanceName="txtDireccion" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    MaxLength="100" runat="server" Width="95%">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 4px;"></td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxLabel ID="lblColonia" ClientInstanceName="lblColonia" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    runat="server" Text="Colonia:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="txtColonia" ClientInstanceName="txtColonia" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    MaxLength="100" runat="server" Width="75%">
                                </dx:ASPxTextBox>
                            </td>
                            <td>
                                <dx:ASPxLabel ID="lblCP" ClientInstanceName="lblCP" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    runat="server" Text="C.P:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="txtCP" ClientInstanceName="txtCP" ClientEnabled="False" ForeColor="Black" Font-Size="Medium"
                                    MaxLength="5" runat="server" Width="50%">
                                    <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 4px;"></td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxLabel ID="lblEstado" ClientInstanceName="lblEstado" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    runat="server" Text="Estado:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxComboBox ID="cmbEstado" ClientInstanceName="cmbEstado" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    MaxLength="50" runat="server" Width="75%" AutoPostBack="false">
                                    <ClientSideEvents SelectedIndexChanged="function(s, e){
                                                    LlenaMunicipio();
                                                    }" />
                                </dx:ASPxComboBox>

                            </td>
                            <td>
                                <dx:ASPxLabel ID="lblMunicipio" ClientInstanceName="lblMunicipio" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    runat="server" Text="Municipio:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxComboBox ID="cmbMunicipio" ClientInstanceName="cmbMunicipio" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    MaxLength="50" runat="server" Width="75%" ValueType="System.Int32" AutoPostBack="false" OnCallback="cmbMunicipio_Callback">
                                </dx:ASPxComboBox>
                            </td>


                        </tr>
                        <tr>
                            <td style="padding: 2px"></td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxLabel ID="lblTelefono" ClientInstanceName="lblTelefono" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    runat="server" Text="Teléfono:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="txtTelefono" ClientInstanceName="txtTelefono" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    MaxLength="20" runat="server" Width="75%">
                                    <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                </dx:ASPxTextBox>
                            </td>
                            <td>
                                <dx:ASPxLabel ID="lblHabilitado" ClientInstanceName="lblHabilitado" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    runat="server" Text="Habilitado:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxRadioButtonList ID="rblHabilitado" ClientInstanceName="rblHabilitado" RepeatDirection="Horizontal" Border-BorderStyle="None" Font-Size="Medium" ForeColor="Black" runat="server" ValueType="System.String">
                                    <Items>
                                        <dx:ListEditItem Text="Si" Value="1" />
                                        <dx:ListEditItem Text="No" Value="0" />
                                    </Items>
                                </dx:ASPxRadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 2px"></td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxLabel ID="lblSucursal" ClientInstanceName="lblSucursal" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    runat="server" Text="Sucursal:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxComboBox ID="cmbSucursal" ClientInstanceName="cmbSucursal" Width="75%" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" ValueType="System.String"></dx:ASPxComboBox>
                            </td>
                            <td>

                                <dx:ASPxLabel ID="lblCentroCostos" ClientInstanceName="lblCentroCostos" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                    runat="server" Text="Centro de costos:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxComboBox ID="cmbCentroCostos" ClientInstanceName="cmbCentroCostos" Width="75%" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String"></dx:ASPxComboBox>
                            </td>
                        </tr>
                    </table>




                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>



    </form>
</body>
</html>
