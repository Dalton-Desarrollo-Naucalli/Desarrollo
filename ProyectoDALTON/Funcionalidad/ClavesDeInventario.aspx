<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ClavesDeInventario.aspx.vb" Inherits="Funcionalidad_ClavesDeInventario" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/ClavesDeInventario.js"></script>
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <title>Claves de inventario</title>
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
HabilitaCveInventario();
           }
else	{
DeshabilitaCveInventario();
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
HabilitaCveInventario();
           }
else	{
DeshabilitaCveInventario();
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
MuestraCveInventario();
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
 if (txtClave.GetText() == '') {
txtClave.SetText(s.cpcveInventario);
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




                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="ID_inventario" AutoGenerateColumns="False" TextFormatString="{0} | {2}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraCveInventario();
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

        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Claves de inventario" Font-Size="Large" Font-Bold="true" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">


                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" HeaderText="Datos generales" Font-Size="medium"  Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">

                                <table style="width: 100%">

                                    <tr>
                                        <td style="width:15%">
                                            <dx:ASPxLabel ID="lblClave" ClientInstanceName="lblClave"  ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Text="Clave:"></dx:ASPxLabel>
                                        </td>
                                        <td style="width:35%">
                                            <dx:ASPxTextBox ID="txtClave" ClientInstanceName="txtClave" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Width="25%">
                                             
                                                <MaskSettings Mask="000" ErrorText="La clave debe tener 3 digitos" PromptChar="-"   />
                                                <ValidationSettings ErrorDisplayMode="ImageWithText"  Display="Dynamic" ErrorTextPosition="Bottom"> </ValidationSettings>
                                            </dx:ASPxTextBox>
                                        </td>                                   
                                        <td style="width:15%">
                                            <dx:ASPxLabel ID="lblConsecutivo" ClientInstanceName="lblConsecutivo" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Text="Consecutivo:"></dx:ASPxLabel>
                                        </td>
                                        <td style="width:35%">
                                            <dx:ASPxTextBox ID="txtConsecutivo" ClientInstanceName="txtConsecutivo" ClientEnabled="false" ForeColor="Black" Font-Size="medium" MaxLength="15" runat="server" Width="25%">
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
                                            <dx:ASPxLabel ID="lblDescripcion" ClientInstanceName="lblDescripcion" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Text="Descripción:"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtDescripcion" ClientInstanceName="txtDescripcion" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" MaxLength="80" runat="server" Width="95%"></dx:ASPxTextBox>
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
