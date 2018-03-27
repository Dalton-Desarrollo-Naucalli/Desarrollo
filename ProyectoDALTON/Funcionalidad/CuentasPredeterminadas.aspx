<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CuentasPredeterminadas.aspx.vb" Inherits="Funcionalidad_CuentasPredeterminadas" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/CuentasPredeterminadas.js"></script>
    <title>Cuentas predeterminadas</title>
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
HabilitaCuentasP();
           }
else	{
DehabilitaCuentasP();
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
HabilitaCuentasP();
           }
else	{
DehabilitaCuentasP();
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
MuestraCuentasP();
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
if (txtId.GetText() == '') {
txtId.SetText(s.cpId);
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
                      


                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="ID" AutoGenerateColumns="False" TextFormatString="{0} | {1}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraCuentasP();
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
        <%-- botones y GRIDLOOKUP BUSQUEDA--%>


        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Cuentas predeterminadas" Font-Bold="true" Font-Size="Large" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" HeaderText="Datos generales" Font-Size="Medium" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">

                                <table style="width: 100%">

                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblId" ClientInstanceName="lblId" runat="server" Text="ID:" Font-Size="medium" Width="100%" ForeColor="Black" ClientEnabled="false" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td style="width:30%">
                                            <dx:ASPxTextBox ID="txtId" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" ClientInstanceName="txtId" runat="server" MaxLength="15" Width="25%">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblDescripcion" ClientInstanceName="lblDescripcion" ClientEnabled="false" ForeColor="Black" runat="server" Text="Descripción:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td style="width:30%">
                                            <dx:ASPxTextBox ID="txtDescripcion" ClientEnabled="false" ClientInstanceName="txtDescripcion" ForeColor="Black" Font-Size="Medium" runat="server" Width="75%" MaxLength="50"></dx:ASPxTextBox>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblCuentaInterna" ClientInstanceName="lblCuentaInterna" ClientEnabled="false" ForeColor="Black" runat="server" Text="Cuenta Interna:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbCuentaInterna" Font-Size="Medium" ClientEnabled="false" ForeColor="Black" ClientInstanceName="cmbCuentaInterna" Width="75%" MaxLength="16" runat="server" ValueType="System.String">
                                          <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxComboBox>
                                        </td>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblCuentaExterna" ClientInstanceName="lblCuentaExterna" ClientEnabled="false" ForeColor="Black" runat="server" Text="Cuenta Externa:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbCuentaExterna" Font-Size="Medium" ForeColor="Black" ClientEnabled="false" ClientInstanceName="cmbCuentaExterna" Width="75%" MaxLength="16" runat="server" ValueType="System.String">
                                                <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblMoneda" ClientInstanceName="lblMoneda" ClientEnabled="false" ForeColor="Black" runat="server" Text="Moneda:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbNoMoneda" ClientInstanceName="cmbNoMoneda" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" Width="75%" MaxLength="15" runat="server">
                                            </dx:ASPxComboBox>
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
