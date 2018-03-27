<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Bancos.aspx.vb" Inherits="Framework_Bancos" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/Bancos.js"></script>
    <title> Bancos </title>
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
HabilitaBancos();
           }
else	{
DeshabilitaBancos();
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
HabilitaBancos();
           }
else	{
DeshabilitaBancos();
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
MuestraBancos();
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
 if (txtIdBanco.GetText() == '') {
txtIdBanco.SetText(s.cpIdBanco);}
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




                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="idbanco" AutoGenerateColumns="False" TextFormatString="{0} | {1}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraBancos();
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

        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Bancos" Font-Size="Large" Font-Bold="true" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">                    

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" HeaderText="Datos generales" Font-Size="medium" Font-Bold="true" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">  

                                        <table style="width: 100%">
                                       
                                            <tr>
                                                <td>
                                                     <dx:ASPxLabel ID="lblIdBanco" ClientEnabled="false" ClientInstanceName="lblIdBanco" Font-Size="Medium" ForeColor="Black" runat="server" Text="ID Banco:"></dx:ASPxLabel>
                                                </td>
                                               
                                                <td>
                                                    <dx:ASPxTextBox ID="txtIdBanco" ClientEnabled="false" ClientInstanceName="txtIdBanco" Font-Size="Medium" ForeColor="Black" runat="server" Width="25%" MaxLength="15"></dx:ASPxTextBox>
                                                </td>
                                                <td></td>
                                                <td></td>
                                            </tr>
                                             <tr>
                                                <td style="padding:4px"></td>
                                            </tr>
                                           <tr>
                                              <td style="width:15%">
                                                  <dx:ASPxLabel ID="lblNombreCorto" ClientEnabled="false" ForeColor="Black" ClientInstanceName="lblNombreCorto" Font-Size="Medium" runat="server" Text="Nombre corto:"></dx:ASPxLabel>
                                              </td>
                                               <td style="width:35%">
                                                   <dx:ASPxTextBox ID="txtNombreCorto" ClientEnabled="false" ClientInstanceName="txtNombreCorto"  ForeColor="Black" Font-Size="Medium" runat="server" Width="50%" MaxLength="15"></dx:ASPxTextBox>
                                               </td>
                                                <td style="width:15%">
                                                  <dx:ASPxLabel ID="lblNombre" ClientEnabled="false" ClientInstanceName="lblNombre" ForeColor="Black" Font-Size="Medium" runat="server" Text="Nombre:"></dx:ASPxLabel>
                                              </td>
                                               <td style="width:35%">
                                                   <dx:ASPxTextBox ID="txtNombre" ClientEnabled="false" ClientInstanceName="txtNombre"  ForeColor="Black" Font-Size="Medium" runat="server" Width="75%" MaxLength="40"></dx:ASPxTextBox>
                                               </td>
                                           </tr>
                                            <tr>
                                                <td style="padding:4px"></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="lblNoDigCtas" ClientEnabled="false" ClientInstanceName="lblNoDigCtas" ForeColor="Black" Font-Size="Medium" runat="server" Text="No. Díg. Ctas:"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="txtNoDigCtas" ClientInstanceName="txtNoDigCtas" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Width="50%" MaxLength="15">
                                                        <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />

                                                    </dx:ASPxTextBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="lblLiquidDefaultTR" ClientEnabled="false"  ClientInstanceName="lblLiquidDefaultTR" ForeColor="Black" Font-Size="Medium" runat="server" Text="F. Liquid. Defaul TR:"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxComboBox ID="cmbLiquidDefaultTR" ClientEnabled="false" ClientInstanceName="cmbLiquidDefaultTR" ForeColor="Black" Width="50%" MaxLength="15" Font-Size="Medium" runat="server" ValueType="System.String"></dx:ASPxComboBox>
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
