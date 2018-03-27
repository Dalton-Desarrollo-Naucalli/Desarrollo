<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Aseguradoras.aspx.vb" Inherits="Funcionalidad_Aseguradoras" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
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
HabilitaAseguradoras();
           }
else	{
DeshabilitaAseguradoras();
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
HabilitaAseguradoras();
           }
else	{
DeshabilitaAseguradoras();
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
MuestraAseguradoras();
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
txtIdAseguradora.SetText(s.cpIdAseguradora); 
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




                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="No_aseg" AutoGenerateColumns="False" TextFormatString="{0} | {1}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraAseguradoras();
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

        <dx:ASPxRoundPanel ID="ASPxRoundPanel3" runat="server" ShowCollapseButton="True" HeaderText="Aseguradoras" Font-Bold="true" Font-Size="Medium" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">

                    <table style="width: 100%">
                        <tr>
                            <td style="width: 15%">
                                <dx:ASPxLabel ID="lblIdAseguradora" ClientInstanceName="lblIdAseguradora" ClientEnabled="false" Font-Size="Medium" ForeColor="Black"
                                    runat="server" Text="ID Aseguradora :">
                                </dx:ASPxLabel>
                            </td>
                            <td style="width: 35%">
                                <dx:ASPxTextBox ID="txtIdAseguradora" ClientInstanceName="txtIdAseguradora" ClientEnabled="false" Font-Size="Medium" ForeColor="Black"
                                    MaxLength="15" runat="server" Width="25%">
                                </dx:ASPxTextBox>
                            </td>
                            <td style="width: 15%">
                                <dx:ASPxLabel ID="lblNombre" ClientInstanceName="lblNombre" ClientEnabled="false"
                                    Font-Size="Medium" ForeColor="Black" runat="server" Text="Nombre:">
                                </dx:ASPxLabel>
                            </td>
                            <td style="width: 35%">
                                <dx:ASPxTextBox ID="txtNombre" ClientInstanceName="txtNombre" ClientEnabled="false" Font-Size="Medium" ForeColor="Black"
                                    MaxLength="50" runat="server" Width="75%">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 4px;"></td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxLabel ID="lblRFC" ClientInstanceName="lblRFC" Font-Size="Medium" ClientEnabled="false" ForeColor="Black"
                                    runat="server" Text="R.F.C:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="txtRFC" ClientInstanceName="txtRFC" ClientEnabled="false" Font-Size="Medium" ForeColor="Black"
                                    MaxLength="30" runat="server" Width="25%">
                                </dx:ASPxTextBox>
                            </td>
                            <td>
                                <dx:ASPxLabel ID="lblDireccion" ClientInstanceName="lblDireccion" ClientEnabled="false" Font-Size="Medium" ForeColor="Black"
                                    runat="server" Text="Dirección:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="txtDireccion" ClientInstanceName="txtDireccion" ClientEnabled="false" Font-Size="Medium" ForeColor="Black"
                                    MaxLength="100" runat="server" Width="95%">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 4px;"></td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxLabel ID="lblCP" ClientInstanceName="lblCP" ClientEnabled="false" Font-Size="Medium" ForeColor="Black"
                                    runat="server" Text="C.P:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="txtCP" ClientInstanceName="txtCP" ClientEnabled="false" Font-Size="Medium" ForeColor="Black"
                                    MaxLength="5" runat="server" Width="25%">
                                </dx:ASPxTextBox>
                            </td>
                            <td>
                                <dx:ASPxLabel ID="lblTelefono" ClientInstanceName="lblTelefono" ClientEnabled="false" Font-Size="Medium" ForeColor="Black"
                                    runat="server" Text="Teléfono:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="txtTelefono" ClientInstanceName="txtTelefono" ClientEnabled="false" Font-Size="Medium" ForeColor="Black"
                                    MaxLength="15" runat="server" Width="50%">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 4px;"></td>
                        </tr>
                        <tr>
                            <td> 
                                
                                <dx:ASPxLabel ID="lblFax" ClientInstanceName="lblFax" ClientEnabled="false" Font-Size="Medium" ForeColor="Black"
                                    runat="server" Text="Fax:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="txtFax" ClientInstanceName="txtFax" ClientEnabled="false" Font-Size="Medium" ForeColor="Black"
                                    MaxLength="15" runat="server" Width="50%">
                                </dx:ASPxTextBox>
                            </td>
                            <td></td>
                            <td></td><td></td>
                        </tr>

                        <tr>
                            <td>
                                <dx:ASPxGridView ID="ASPxGridView1" runat="server"></dx:ASPxGridView>
                            </td>
                        </tr>



                    </table>

                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>


        <div>
        </div>
    </form>
</body>
</html>

