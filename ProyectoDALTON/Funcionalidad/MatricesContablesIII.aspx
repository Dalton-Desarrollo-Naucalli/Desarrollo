<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MatricesContablesIII.aspx.vb" Inherits="Funcionalidad_MatricesContablesIII" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/MatricesContablesIII.js"></script>
    <title>Matrices contables III</title>
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
HabilitaMatriz3();
           }
else	{
DeshabilitaMatriz3();
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
HabilitaMatriz3();
           }
else	{
DeshabilitaMatriz3();
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
MuestraMatriz3();
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
 if (cmbConcepto.GetValue() == '') {
cmbConcepto.SetValue(s.cpMC3);}
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




                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="id_conceptosIngresos" AutoGenerateColumns="False" TextFormatString="{0} | {6}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraMatriz3();
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


        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Matrices contables III" Font-Bold="true" Font-Size="Large" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" HeaderText="Datos generales" Font-Size="Medium" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">

                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblConcepto" ClientEnabled="false" ClientInstanceName="lblConcepto" ForeColor="Black" runat="server" Text="Concepto:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxComboBox ID="cmbConcepto" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ClientInstanceName="cmbConcepto" TextFormatString="{0} | {1}" Width="75%">
                                                <Columns>
                                                    <dx:ListBoxColumn Caption="ID" FieldName="id_conceptosIngresos" />
                                                    <dx:ListBoxColumn Caption="DESCRIPCIÓN" FieldName="descripcion" />
                                                </Columns>
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
                                            <dx:ASPxLabel ID="lblCuentaInterna" ClientEnabled="false" ClientInstanceName="lblCuentaInterna" ForeColor="Black" runat="server" Text="Cuenta Interna:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbCuentaInterna" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ClientInstanceName="cmbCuentaInterna" TextFormatString="{0}" Width="75%">
                                               <ClientSideEvents SelectedIndexChanged="function(s, e){
                                                    LlenaDes();
                                                    }" />
                                                <Columns>
                                                    <dx:ListBoxColumn Caption="Número de cuenta" FieldName="ID" Width="150px" />
                                                    <dx:ListBoxColumn Caption="Descripción" FieldName="NombreCI" Width="400px" />
                                                </Columns>

                                            </dx:ASPxComboBox>
                                        </td>

                                        <td>
                                            <dx:ASPxLabel ID="lblCuentaInternaDes" ClientEnabled="false" ClientInstanceName="lblCuentaInternaDes" ForeColor="Black" runat="server" Text="Descripción:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxComboBox ID="cmbCuentaInternaDes" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ClientInstanceName="cmbCuentaInternaDes" TextFormatString="{1}" Width="95%">
                                               <ClientSideEvents SelectedIndexChanged="function(s, e){
                                                    LlenaCuentaI();
                                                    }" />
                                                <Columns>
                                                    <dx:ListBoxColumn Caption="Número de cuenta" FieldName="ID" Width="150px" />
                                                    <dx:ListBoxColumn Caption="Descripción" FieldName="NombreCI" Width="400px" />
                                                </Columns>

                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblCuentaExtaerna" runat="server" Text="Cuenta Externa:" ForeColor="Black" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbCuentaExterna" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" ClientInstanceName="cmbCuentaExterna" TextFormatString="{0}" Width="75%">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e){
                                                    LlenaDesc();
                                                    }" />
                                                
                                                <Columns>
                                                    <dx:ListBoxColumn Caption="Número de cuenta" FieldName="ID" Width="150px" />
                                                    <dx:ListBoxColumn Caption="Descripción" FieldName="NombreCE" Width="400px" />
                                                </Columns>
                                            </dx:ASPxComboBox>
                                        </td>
                                         <td>
                                            <dx:ASPxLabel ID="lblCuentaExtaernaDes" ClientEnabled="false" ClientInstanceName="lblCuentaExtaernaDes" ForeColor="Black" runat="server" Text="Descripción:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxComboBox ID="cmbCuentaExternaDes" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ClientInstanceName="cmbCuentaExternaDes" TextFormatString="{1}" Width="95%">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e){
                                                    LlenaCuentaE();
                                                    }" />
                                                <Columns>
                                                    <dx:ListBoxColumn Caption="Número de cuenta" FieldName="ID" Width="150px" />
                                                    <dx:ListBoxColumn Caption="Descripción" FieldName="NombreCE" Width="400px" />
                                                </Columns>

                                            </dx:ASPxComboBox>
                                        </td>

                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblDescripcion" runat="server" Text="Descripción:" ForeColor="Black" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtDescripcion" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" ClientInstanceName="txtDescripcion" MaxLength="150" Width="75%">
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

                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>


    </form>
</body>
</html>

