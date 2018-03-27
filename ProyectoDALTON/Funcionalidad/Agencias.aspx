<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Agencias.aspx.vb" Inherits="Funcionalidad_Agencias" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/Agencias.js"></script>
    <title>Agencias</title>
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
HabilitaAgencias();
           }
else	{
DeshabilitaAgencias();
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
HabilitaAgencias();
           }
else	{
DeshabilitaAgencias();
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
MuestraAgencias();
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
                                             if (txtIdAgencia.GetText() == '') {
txtIdAgencia.SetText(s.cpIdAgencia); 
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




                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="idAgencia" AutoGenerateColumns="False" TextFormatString="{0} | {1}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraAgencias();
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

        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Agencias" Font-Size="Large" Font-Bold="true" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">


                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" HeaderText="Datos generales" Font-Size="medium" Font-Bold="true" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">

                                <table style="width: 100%">

                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblIdAgencia" ClientInstanceName="lblIdAgencia" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Text="ID Agencia:"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtIdAgencia" ClientInstanceName="txtIdAgencia" ClientEnabled="false" ForeColor="Black" MaxLength="5" Font-Size="Medium" runat="server" Width="25%"></dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblNombre" ClientInstanceName="lblNombre" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Text="Nombre:"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtNombre" ClientInstanceName="txtNombre" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" MaxLength="50" runat="server" Width="95%"></dx:ASPxTextBox>
                                        </td>
                                       
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblRFC" ClientInstanceName="lblRFC" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Text="R.F.C:"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtRFC" ClientInstanceName="txtRFC" ClientEnabled="false" ForeColor="Black" Font-Size="medium" MaxLength="15" runat="server" Width="50%">
                                            
                                            </dx:ASPxTextBox>
                                            </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblIdProveedor" ClientInstanceName="lblIdProveedor" clen="false" ForeColor="Black" Font-Size="Medium" runat="server" Text="ID Proveedor:"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbIdProveedor" ClientInstanceName="cmbIdProveedor" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" Width="95%" runat="server" TextFormatString="{0}" ValueType="System.String">
                                                <Columns>
                                                    <dx:ListBoxColumn Caption="Nombre" FieldName="NombreP" Visible="true"  Width="200px"/>
                                                    <dx:ListBoxColumn Caption="ID" FieldName="ID" Visible="false" Width="50px"  />
                                                    
                                                </Columns>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblIdStatus" ClientInstanceName="lblIdStatus" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Text="Id Status:">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbIdStatus" ClientInstanceName="cmbIdStatus" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" Width="25%" runat="server" ValueType="System.String">
                                                <Items>
                                                    <dx:ListEditItem Text="1" Value="1" />
                                                    <dx:ListEditItem Text="2" Value="2" />

                                                </Items>
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
