<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TiposDeCambio.aspx.vb" Inherits="Funcionalidad_TiposDeCambio" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/TiposDeCambio.js"></script>
    <title> Tipos  de cambio</title>
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
HabilitaTiposCambio();
           }
else	{
DehabilitaTiposCambio();
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
HabilitaTiposCambio();
           }
else	{
DehabilitaTiposCambio();
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
 MuestraTiposCambio();
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
 if (txtNoMovimiento.GetText() == '') {
txtNoMovimiento.SetText(s.cpNoMovimiento);
                                        }
BloqueaAgrega();                                       

}
" />                                </dx:ASPxCallback>
                            </td>


                        </tr>
                    </table>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>

         <%--  BOTONES PANEL (AGREGA, EDITA, ELIMINA, ACTUALIZA)--%>

     
        <br />
        <br />              
        <div>
            <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" HeaderText="Búsqueda:" Font-Size="Medium" Font-Bold="false"  Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">




                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="tc_id" AutoGenerateColumns="False" TextFormatString="{0} | {1} | {2}">
                            <GridViewProperties>
                                
                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraTiposCambio();
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
</div>
    

        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" Font-Bold="true" Font-Size="Large" HeaderText="Tipos de cambio:" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" HeaderText="Datos generales:" Font-Size="Medium" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">


                                <table style="width: 100%">

                                  
                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblNoMovimiento" ClientEnabled="false" ClientInstanceName="lblNoMovimiento" ForeColor="Black" runat="server" Text="No. Movimiento:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>

                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtNoMovimiento" ClientInstanceName="txtNoMovimiento" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" MaxLength="15" Width="25%" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>

                                        <td style="width: 12%">
                                            <dx:ASPxLabel ID="lblNoMoneda" ClientEnabled="false" ClientInstanceName="lblNoMoneda" ForeColor="Black" runat="server" Text="No. Moneda:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>

                                        </td>
                                        <td style="width: 30%">
                                            <dx:ASPxComboBox ID="cmbNoMoneda" ClientInstanceName="cmbNoMoneda" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" Width="75%" MaxLength="15" runat="server">
                                            </dx:ASPxComboBox>
                                          </td>
                                        <td >
                                            <dx:ASPxButton ID="btnCatMonedas" ClientInstanceName="btnCatMonedas" ClientEnabled="false"  runat="server" Text="Monedas" ToolTip="Ir al catálogo de monedas"  >
                             
                                                </dx:ASPxButton>
                                        </td>    
                                        <td></td>

                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblFechaMovimiento" ClientEnabled="false" ClientInstanceName="lblFechaMovimiento" ForeColor="Black" runat="server" Text="Fecha del movimiento:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>

                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxDateEdit ID="dateFechaMovimiento" ClientInstanceName="dateFechaMovimiento" UseMaskBehavior="false" Font-Size="Medium" ForeColor="Black" ClientEnabled="false"  Width="50%" runat="server"></dx:ASPxDateEdit>
                                        </td>
                                    </tr>
                                 <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>                                   

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblTipoCambioOficial" ClientEnabled="false" ClientInstanceName="lblTipoCambioOficial" ForeColor="Black" runat="server" Text="Tipo de cambio oficial:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>

                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtTipoCambioOficial" ClientInstanceName="txtTipoCambioOficial" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Width="25%" MaxLength="15" Height="16px">
                                            <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td></td>
                                  <td></td>
                                        <td>
                                            <dx:ASPxLabel ID="lblTipoCambioComercial" ClientEnabled="false" ClientInstanceName="lblTipoCambioComercial" ForeColor="Black" runat="server" Text="Tipo de cambio comercial:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>

                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtTipoCambioComercial" ClientInstanceName="txtTipoCambioComercial" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Width="25%" MaxLength="15" Height="16px">
                                           <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
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

