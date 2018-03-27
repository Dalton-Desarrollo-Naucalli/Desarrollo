<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Monedas.aspx.vb" Inherits="Funcionalidad_Monedas" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/Monedas.js"></script>
    <title>Moneda</title>
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
HabilitaMoneda();
           }
else	{
DeshabilitaMoneda();
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
HabilitaMoneda();
           }
else	{
DeshabilitaMoneda();
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
MuestraMoneda();
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
 if (txtNoMoneda.GetText() == '') {
   txtNoMoneda.SetText(s.cpNoMoneda); 
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

            <%--botones--%>

          <br />
            <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" HeaderText="Búsqueda:" Font-Size="Medium" Font-Bold="false" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">




                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="moneda_id" AutoGenerateColumns="False" TextFormatString="{0} | {1}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraMoneda();
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
        <%--GRIDLOOKUP BUSQUEDA--%>
        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Monedas" Font-Bold="true" Font-Size="Large" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" HeaderText="Datos generales" Font-Size="Medium" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">


                                <table style="width: 100%">



                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblNoMoneda" ClientEnabled="false" ClientInstanceName="lblNoMoneda" ForeColor="Black" runat="server" Text="No. Moneda:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>

                                        </td>
                                        <td style="width: 30%">
                                            <dx:ASPxTextBox ID="txtNoMoneda" MaxLength="15" ClientInstanceName="txtNoMoneda" ClientEnabled="false" Font-Size="Medium" runat="server" Width="25%" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>

                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblIdContabilidad" ClientEnabled="false" ClientInstanceName="lblIdContabilidad" ForeColor="Black" runat="server" Text="ID Contabilidad:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>

                                        </td>
                                        <td style="width: 30%">
                                            <dx:ASPxTextBox ID="txtIdContabilidad" ClientEnabled="false" ClientInstanceName="txtIdContabilidad" ForeColor="Black" Font-Size="Medium" runat="server" Width="25%" MaxLength="3" Height="16px">
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
                                            <dx:ASPxLabel ID="lblNombre" ClientEnabled="false" ClientInstanceName="lblNombre" ForeColor="Black" runat="server" Text="Nombre:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>

                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtNombre" ClientInstanceName="txtNombre" ForeColor="Black" ClientEnabled="false" Font-Size="Medium" MaxLength="50" runat="server" Width="75%" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>

                                        <td>
                                            <dx:ASPxLabel ID="lblNomCorto" ClientEnabled="false" ClientInstanceName="lblNomCorto" ForeColor="Black" runat="server" Text="Nom. corto:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>

                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtNomCorto" ClientInstanceName="txtNomCorto" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Width="25%" MaxLength="5" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>

                                   <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblLeyenda1" ClientEnabled="false" ClientInstanceName="lblLeyenda1" ForeColor="Black" runat="server" Text="Leyenda cheques (moneda):" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>

                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtLeyenda1" ClientInstanceName="txtLeyenda1" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Width="75%" MaxLength="50" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>

                                        <td>
                                            <dx:ASPxLabel ID="lblLeyenda2" ClientEnabled="false" ClientInstanceName="lblLeyenda2" ForeColor="Black" runat="server" Text="Leyenda cheques abreviado:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>

                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtLeyenda2" ClientInstanceName="txtLeyenda2" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Width="25%" MaxLength="10" Height="16px">
                                            </dx:ASPxTextBox>
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


