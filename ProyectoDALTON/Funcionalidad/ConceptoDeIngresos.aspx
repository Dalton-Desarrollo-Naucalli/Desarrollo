<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ConceptoDeIngresos.aspx.vb" Inherits="Funcionalidad_ConceptoDeIngresos" %>


<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/ConceptoDeIngresos.js"></script>
    <title></title>
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
HabilitaConceptoIngresos();
           }
else	{
DeshabilitaConceptoIngresos();
       }
}
" />
                                        <Image IconID="actions_add_32x32">
                                        </Image>
                                    </dx:ASPxButton>

                                    <%--<dx:ASPxCallback ID="cbAgregar" runat="server" ClientIDMode="AutoID" ClientInstanceName="cbAgregar">
                                    <ClientSideEvents EndCallback="function(s, e) {

}"
                                        BeginCallback="function(s, e) {

}" />
                                </dx:ASPxCallback>--%>
                                </td>


                                <td class="auto-style4">
                                    <dx:ASPxButton ID="btnEditar" runat="server" ToolTip="Editar" ClientInstanceName="btnEditar" AutoPostBack="False" EnableClientSideAPI="false" ClientEnabled="False" GroupName="B">
                                        <ClientSideEvents Click="function(s, e) {
Enc_BotonEditar();
}"
                                            CheckedChanged="function(s, e) {
if (s.GetChecked()) {
HabilitaConceptoIngresos();
           }
else	{
DeshabilitaConceptoIngresos();
       }
}
" />
                                        <Image IconID="edit_edit_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                    <%--<dx:ASPxCallback ID="cbEditar" runat="server" ClientInstanceName="cbEditar">
                                    <ClientSideEvents EndCallback="function(s, e) {

}"
                                        BeginCallback="function(s, e) {

}" />
                                </dx:ASPxCallback>--%>
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
MuestraConceptoIngresos();
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

            <dx:ASPxTextBox runat="server" Width="170px" Visible="False" ClientInstanceName="txtBandera" ID="txtBandera" ClientVisible="False"></dx:ASPxTextBox>
            <br />
            <br />

            <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" HeaderText="Búsqueda:" Font-Size="Medium" Font-Bold="false" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">


                        <dx:ASPxTextBox ID="txtIdPar" runat="server" ClientInstanceName="txtIdPar" Width="170px" Visible="False">
                            <ClientSideEvents GotFocus="function(s, e) {
glBusquedaPar.GetGridView().Refresh();	
}" />
                        </dx:ASPxTextBox>


                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="id_conceptosIngresos" AutoGenerateColumns="False" TextFormatString="{0} | {1}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraConceptoIngresos();
                                                                        HabilitaBotones();
                                                                       }" />

                        </dx:ASPxGridLookup>
                        <dx:ASPxGridLookup ID="glBusquedaPar" runat="server" AutoGenerateColumns="False" ClientIDMode="AutoID" ClientInstanceName="glBusquedaPar" Font-Size="Medium" KeyFieldName="id_conceptosIngresos" Width="30%" Visible="False">
                            <GridViewProperties>
                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>
                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraConceptoIngresos();
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


        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Conceptos de ingresos" Font-Bold="true" Font-Size="Large" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">


                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" HeaderText="Datos generales" Font-Size="medium" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">

                                <table style="width: 100%">



                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblNoConcepto" ClientEnabled="false" ClientInstanceName="lblNoConcepto" ForeColor="Black" runat="server" Text="No. Concepto:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td style="width: 30%">
                                            <dx:ASPxTextBox ID="txtNoConcepto" runat="server" Width="25%" MaxLength="15" ClientInstanceName="txtNoConcepto" Font-Size="Medium" Height="16px" ClientEnabled="false" ForeColor="Black">
                                            </dx:ASPxTextBox>
                                        </td>

                                        <td>
                                            <dx:ASPxLabel ID="lblDescripcion" ClientEnabled="false" ClientInstanceName="lblDescripcion" ForeColor="Black" runat="server" Text="Descripción:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtDescripcion" runat="server" ClientInstanceName="txtDescripcion" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" MaxLength="40" Width="75%" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>

                                    
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblContexto" ClientEnabled="false" ClientInstanceName="lblContexto" ForeColor="Black" runat="server" Text="Contexto:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxComboBox ID="cmbContexto" runat="server" ClientInstanceName="cmbContexto" Width="75%" MaxLength="50" ClientEnabled="false" ForeColor="Black" Font-Size="Medium">
                                                <Items>
                                                    <dx:ListEditItem Text="Comprobación de gastos" Value="2" />
                                                    <dx:ListEditItem Text="Otros" Value="1" />
                                                </Items>
                                            </dx:ASPxComboBox>
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
