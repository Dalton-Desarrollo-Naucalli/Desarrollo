<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Personal.aspx.vb" Inherits="Funcionalidad_Personal" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/Personal.js"></script>
    <title>Personal</title>


</head>
<body onkeypress="return pulsar(event)">

    <form id="form2" runat="server">


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
GVPerSuc.Refresh();
}"
                                            CheckedChanged="function(s, e) {
if (s.GetChecked()){
LimpiaControles();
HabilitaPersonal();
           }
else	{
DeshabilitaPersonal();
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
HabilitaPersonal();
           }
else	{
DeshabilitaPersonal();
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
MuestraPersonal();
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
 if (txtIdEmpleado.GetText() == '') {
txtIdEmpleado.SetText(s.cpIDEmpleado);
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


                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="person_id" AutoGenerateColumns="False" TextFormatString="{0} | {1}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraPersonal();
                                                                        HabilitaBotones();
                                                                       }" />

                            <ClientSideEvents TextChanged="function(s, e) {
	GVPerSuc.Refresh();
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


        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Personal" Font-Bold="true" Font-Size="Large" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel3" runat="server" HeaderText="Datos personales:" Font-Size="Medium" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">

                                <table style="width: 100%">


                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblIdEmpleado" ClientEnabled="false" ClientInstanceName="lblIdEmpleado" ForeColor="Black" runat="server" Text="ID Empleado:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtIdEmpleado" ClientEnabled="false" Font-Size="Medium" runat="server" Width="25%" MaxLength="15" ClientIDMode="AutoID" ClientInstanceName="txtIdEmpleado" ForeColor="Black">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblNombre" ClientEnabled="false" ClientInstanceName="lblNombre" ForeColor="Black" runat="server" Text="Nombre:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtNombre" ClientEnabled="false" Font-Size="Medium" runat="server" Width="75%" MaxLength="50" ClientIDMode="AutoID" ClientInstanceName="txtNombre" ForeColor="Black">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblNombreCorto" ClientEnabled="false" ClientInstanceName="lblNombreCorto" ForeColor="Black" runat="server" Text="Nombre corto:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtNombreCorto" ClientEnabled="false" Font-Size="Medium" runat="server" Width="50%" MaxLength="15" ClientIDMode="AutoID" ClientInstanceName="txtNombreCorto" ForeColor="Black">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblRFC" ClientInstanceName="lblRFC" ClientEnabled="false" ForeColor="Black" runat="server" Text="R.F.C:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtRFC" Font-Size="Medium" ClientEnabled="false" runat="server" Width="50%" MaxLength="13" ClientIDMode="AutoID" ClientInstanceName="txtRFC" ForeColor="Black">
                                            </dx:ASPxTextBox>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblDireccion" ClientEnabled="false" ClientInstanceName="lblDireccion" ForeColor="Black" runat="server" Text="Dirección:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtDireccion" ClientEnabled="false" Font-Size="Medium" runat="server" Width="75%" MaxLength="50" ClientIDMode="AutoID" ClientInstanceName="txtDireccion" ForeColor="Black">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblNalDeIdentificacion" ClientEnabled="false" ClientInstanceName="lblNalDeIdentificacion" ForeColor="Black" runat="server" Text="Contexto:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtNalDeIdentificacion" ClientEnabled="false" Font-Size="Medium" runat="server" Width="50%" MaxLength="20" ClientIDMode="AutoID" ClientInstanceName="txtNalDeIdentificacion" ForeColor="Black">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblColonia" ClientEnabled="false" ClientInstanceName="lblColonia" ForeColor="Black" runat="server" Text="Colonia:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtColonia" ClientEnabled="false" Font-Size="Medium" runat="server" Width="75%" MaxLength="25" ClientIDMode="AutoID" ClientInstanceName="txtColonia" ForeColor="Black">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblCodogoPostal" ClientEnabled="false" ClientInstanceName="lblCodogoPostal" ForeColor="Black" runat="server" Text="Código Postal:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtCodigoPostal" MaxLength="6" ClientEnabled="false" Font-Size="Medium" runat="server" Width="25%" ClientIDMode="AutoID" ClientInstanceName="txtCodigoPostal" ForeColor="Black">
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
                                            <dx:ASPxLabel ID="lblEstado" ClientEnabled="false" ClientInstanceName="lblEstado" ForeColor="Black" runat="server" Text="Estado:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
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
                                            <dx:ASPxLabel ID="lblMunicipio" ClientEnabled="false" ClientInstanceName="lblMunicipio" ForeColor="Black" runat="server" Text="Municipio:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbMunicipio" ClientInstanceName="cmbMunicipio" ClientEnabled="false" ForeColor="Black" Font-Size="Medium"
                                                MaxLength="50" runat="server" Width="75%" ValueType="System.Int32" AutoPostBack="false" OnCallback="cmbMunicipio_Callback">
                                            </dx:ASPxComboBox>

                                        </td>

                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblCorreoElectronico" ClientEnabled="false" ClientInstanceName="lblCorreoElectronico" ForeColor="Black" runat="server" Text="Correo electrónico:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtCorreoElectronico" ClientEnabled="false" Font-Size="Medium" runat="server" Width="75%" MaxLength="50" ClientIDMode="AutoID" ClientInstanceName="txtCorreoElectronico" ForeColor="Black">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblFNacimiento" ClientEnabled="false" ClientInstanceName="lblFNacimiento" ForeColor="Black" runat="server" Text="Fecha de nacimiento:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxDateEdit ID="dteFNacimiento" ClientEnabled="false" Font-Size="Medium" UseMaskBehavior="true" runat="server" Width="75%" ClientIDMode="AutoID" ClientInstanceName="dteFNacimiento" ForeColor="Black">
                                            </dx:ASPxDateEdit>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblTelParticular" ClientEnabled="false" ClientInstanceName="lblTelParticular" ForeColor="Black" runat="server" Text="Teléfono particular:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtTelParticular" ClientEnabled="false" Font-Size="Medium" runat="server" Width="75%" MaxLength="15" ClientIDMode="AutoID" ClientInstanceName="txtTelParticular" ForeColor="Black">
                                            <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />

                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblTelTrabajo" ClientEnabled="false" ClientInstanceName="lblTelTrabajo" ForeColor="Black" runat="server" Text="Teléfono trabajo:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtTelTrabajo" ClientEnabled="false" Font-Size="Medium" runat="server" Width="75%" MaxLength="15" ClientIDMode="AutoID" ClientInstanceName="txtTelTrabajo" ForeColor="Black">
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
                                            <dx:ASPxLabel ID="lblFax" ClientEnabled="false" ClientInstanceName="lblFax" ForeColor="Black" runat="server" Text="Fax:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtFax" Font-Size="Medium" ClientEnabled="false" runat="server" Width="75%" MaxLength="15" ClientIDMode="AutoID" ClientInstanceName="txtFax" ForeColor="Black">
                                           <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />

                                                </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblNomEsposa" ClientEnabled="false" ClientInstanceName="lblNomEsposa" ForeColor="Black" runat="server" Text="Nombre de la esposa:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtNomEsposa" ClientEnabled="false" Font-Size="Medium" runat="server" Width="75%" MaxLength="50" ClientIDMode="AutoID" ClientInstanceName="txtNomEsposa" ForeColor="Black">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblPersonaEmergencia" ClientEnabled="false" ClientInstanceName="lblPersonaEmergencia" ForeColor="Black" runat="server" Text="Persona en caso de emergencia:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtPersonaEmergencia" ClientEnabled="false" Font-Size="Medium" runat="server" ClientInstanceName="txtPersonaEmergencia" Width="75%" MaxLength="50" ClientIDMode="AutoID" ForeColor="Black">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblTelEmergencia" ClientEnabled="false" ClientInstanceName="lblTelEmergencia" ForeColor="Black" runat="server" Text="Teléfono en caso de  emergencia:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtTelEmergencia" ClientEnabled="false" Font-Size="Medium" runat="server" ClientInstanceName="txtTelEmergencia" Width="50%" MaxLength="15" ClientIDMode="AutoID" ForeColor="Black">
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
                                            <dx:ASPxLabel ID="lblPuesto" ClientEnabled="false" ClientInstanceName="lblPuesto" ForeColor="Black" runat="server" Text="Puesto:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtPuesto" Font-Size="Medium" ClientEnabled="false" runat="server" Width="75%" MaxLength="30" ClientIDMode="AutoID" ClientInstanceName="txtPuesto" ForeColor="Black">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblDepto" ClientEnabled="false" ClientInstanceName="lblDepto" ForeColor="Black" runat="server" Text="Departamento:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtDepto" Font-Size="Medium" ClientEnabled="false" runat="server" Width="75%" MaxLength="30" ClientIDMode="AutoID" ClientInstanceName="txtDepto" ForeColor="Black">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblSucursal" ClientEnabled="false" ClientInstanceName="lblSucursal" ForeColor="Black" runat="server" Text="Sucursal:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbSucursal" ClientEnabled="false" Font-Size="Medium" runat="server" Width="50%" MaxLength="15" ClientIDMode="AutoID" ClientInstanceName="cmbSucursal" ForeColor="Black">
                                            </dx:ASPxComboBox>                                          

                                        </td>
                                
                                        <td>
                                            <dx:ASPxLabel ID="lblCentroCostos" ClientEnabled="false" ClientInstanceName="lblCentroCostos" ForeColor="Black" runat="server" Text="Centro de costos:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbCentroCostos" ClientEnabled="false" Font-Size="Medium" runat="server" ClientInstanceName="cmbCentroCostos" Width="50%" MaxLength="15" ClientIDMode="AutoID" ForeColor="Black">
                                            </dx:ASPxComboBox>
                                            
                                        </td>

                                        <td></td>
                                        <td></td>
                                        
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblFComision" ClientEnabled="false" ClientInstanceName="lblFComision" ForeColor="Black" runat="server" Text="Factor de comisión por ventas:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtFComision" ClientEnabled="false" Font-Size="Medium" runat="server" ClientInstanceName="txtFComision" Width="25%" MaxLength="15" ClientIDMode="AutoID" ForeColor="Black">
                                           <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />

                                                </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblNotas" ClientEnabled="false" ClientInstanceName="lblNotas" ForeColor="Black" runat="server" Text="Notas:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxMemo ID="mmoNotas" ClientEnabled="false" Font-Size="Medium" runat="server" Height="35px" Width="75%" MaxLength="150" ClientIDMode="AutoID" ClientInstanceName="mmoNotas" ForeColor="Black">
                                            </dx:ASPxMemo>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblAuxiliar" ClientEnabled="false" ClientInstanceName="lblAuxiliar" ForeColor="Black" runat="server" Text="Auxiliar:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbAuxiliar" ClientInstanceName="cmbAuxiliar" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Width="75%" ValueType="System.String" TextFormatString="{0} ">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e){
                                                    LlenaDescAux();
                                                    }" />
                                                <Columns>
                                                    <dx:ListBoxColumn Caption="Auxiliar" FieldName="ID" Width="200px" />
                                                    <dx:ListBoxColumn Caption="Descripción" FieldName="NombreAu" Width="400px" />
                                                </Columns>
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblDesAuxiliar" ClientEnabled="false" ClientInstanceName="lblDesAuxiliar" ForeColor="Black" runat="server" Text="Descripción auxiliar:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbDescAuxiliar" ClientInstanceName="cmbDescAuxiliar" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Width="95%" ValueType="System.String" TextFormatString="{1}">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e){
                                                    LlenaAuxiliar();
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
                                            <dx:ASPxLabel ID="lblFormularioInicial" ClientEnabled="false" ClientInstanceName="lblFormularioInicial" ForeColor="Black" runat="server" Text="Formulario inicial:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbFormularioInicial" ClientEnabled="false" Font-Size="Medium" runat="server" Width="50%" MaxLength="15" ClientIDMode="AutoID" ClientInstanceName="cmbFormularioInicial" ForeColor="Black">
                                            </dx:ASPxComboBox>
                                        </td>
                                   
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblClaveEmpleado" ClientEnabled="false" ClientInstanceName="lblClaveEmpleado" ForeColor="Black" runat="server" Text="Clave empleado:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtClaveEmpleado" ClientEnabled="false" Font-Size="Medium" runat="server" Width="25%" MaxLength="15" ClientIDMode="AutoID" ClientInstanceName="txtClaveEmpleado" ForeColor="Black">
                                            </dx:ASPxTextBox>
                                        </td>
                                            <td></td>
                                            <td></td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblNumeroSeguridadSocial" ClientEnabled="false" ClientInstanceName="lblNumeroSeguridadSocial" ForeColor="Black" runat="server" Text="Número de seguridad social:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtNumeroSeguridadSocial" ClientEnabled="false" Font-Size="Medium" runat="server" Width="50%" MaxLength="15" ClientIDMode="AutoID" ClientInstanceName="txtNumeroSeguridadSocial" ForeColor="Black">
                                          <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />

                                                </dx:ASPxTextBox>

                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblFechaContratacion" ClientEnabled="false" ClientInstanceName="lblFechaContratacion" ForeColor="Black" runat="server" Text="Fecha de contratación:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxDateEdit ID="datedFechaContratacion" ClientEnabled="false" UseMaskBehavior="true" Font-Size="Medium" runat="server" Width="50%" ClientIDMode="AutoID" ClientInstanceName="datedFechaContratacion" ForeColor="Black">
                                            </dx:ASPxDateEdit>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 2px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblBaja" ClientEnabled="false" ClientInstanceName="lblBaja" ForeColor="Black" runat="server" Text="Baja:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxRadioButtonList ID="rbtnnBaja" runat="server" ClientEnabled="false" RepeatDirection="Horizontal" ValueType="System.String" Border-BorderStyle="None" Font-Size="Medium" ClientIDMode="AutoID" ClientInstanceName="rbtnnBaja" CssClass="auto-style2" ForeColor="Black">
                                                 <ClientSideEvents SelectedIndexChanged="function(s, e) {
                                                    EsBaja();	                                       
                                                 LimpiaCampos();
                                                    }"
                                                    />
                                                <Items>
                                                    <dx:ListEditItem Value="2" Text="No" />
                                                    <dx:ListEditItem Value="1" Text="Si" />
                                                </Items>

                                                <Border BorderStyle="None"></Border>
                                            </dx:ASPxRadioButtonList>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblFechaBaja" ClientInstanceName="lblFechaBaja" ClientVisible="false" ClientEnabled="false" ForeColor="black" runat="server" Text="Fecha baja:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxDateEdit ID="datedFechaBaja" ClientEnabled="false"  UseMaskBehavior="true" ClientVisible="false" Font-Size="Medium" runat="server" Width="50%" ClientIDMode="AutoID" ClientInstanceName="datedFechaBaja" ForeColor="Black">
                                            </dx:ASPxDateEdit>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 2px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblBancoCtaCargo" ClientEnabled="false" ClientInstanceName="lblBancoCtaCargo" ForeColor="Black" runat="server" Text="Banco cta. Cargo:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbBancoCtaCargo" ClientEnabled="false" Font-Size="Medium" runat="server" Width="50%" MaxLength="15" ClientIDMode="AutoID" ClientInstanceName="cmbBancoCtaCargo" ForeColor="Black">
                                            </dx:ASPxComboBox>

                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblNumcuentaCargo" ClientEnabled="false" ClientInstanceName="lblNumcuentaCargo" ForeColor="Black" Text="Número cta. Cargo:" runat="server" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbNumCuentaCargo" ClientEnabled="false" Font-Size="Medium" runat="server" Width="50%" MaxLength="20" ClientIDMode="AutoID" ClientInstanceName="cmbNumCuentaCargo" ForeColor="Black">
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblBancoCtaAbono" ClientEnabled="false" ClientInstanceName="lblBancoCtaAbono" ForeColor="Black" runat="server" Text="Banco cta. Abono:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbBancoCtaAbono" ClientEnabled="false" Font-Size="Medium" runat="server" Width="50%" MaxLength="20" ClientIDMode="AutoID" ClientInstanceName="cmbBancoCtaAbono" ForeColor="Black">
                                            </dx:ASPxComboBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblNumCuentaAbono" ClientEnabled="false" ClientInstanceName="lblNumCuentaAbono" ForeColor="Black" runat="server" Text="Número cta. Abono:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbNumCuentaAbono" ClientEnabled="false" Font-Size="Medium" runat="server" Width="50%" MaxLength="20" ClientIDMode="AutoID" ClientInstanceName="cmbNumCuentaAbono" ForeColor="Black">
                                            </dx:ASPxComboBox>
                                        </td>

                                    </tr>
                                    </table>
                          <br />
                                <br />

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" HeaderText="Modulos de ventas permitidos por vendedor:" Font-Size="Medium" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">

                                <table style="width: 100%">



                                    <tr>

                                        <td colspan="4">

                                            <dx:ASPxGridView ID="GVPerSuc" runat="server" AutoGenerateColumns="False" Font-Size="Medium" ClientIDMode="AutoID" ClientInstanceName="GVPerSuc" Width="100%" KeyFieldName="modulo_id" SettingsCommandButton-CancelButton-Text="Cancelar" SettingsCommandButton-UpdateButton-Text="Guardar" ForeColor="Black">
                                                <ClientSideEvents EndCallback="OnEndCallback
"
                                                    BeginCallback="OnBeginCallback	
" />
                                                <SettingsEditing Mode="Batch" UseFormLayout="False">
                                                </SettingsEditing>
                                                <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
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
                                            </dx:ASPxGridView>
                                        </td>
                                        </tr>
                                    </table>
                                     </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>

                                <table style="width:100%">
                                    <tr>
                                        <td style="width:35%"></td><td style="width:35%"></td>
                                        <td style="width:15%">
                                             <dx:ASPxButton ID="btnCatCostos" OnClick="btnCatCostos_Click" runat="server" Text="Catálogo centro de costos" ClientIDMode="AutoID" ClientInstanceName="btnCatCostos"></dx:ASPxButton>
                                             
                                        </td>
                                        <td style="width:15%">
                                            <dx:ASPxButton ID="btnSucursales" OnClick="btnSucursales_Click" ClientEnabled="false" runat="server" Text="Sucursales" ClientIDMode="AutoID" ClientInstanceName="btnSucursales">
                                            </dx:ASPxButton>
                                        </td>
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

