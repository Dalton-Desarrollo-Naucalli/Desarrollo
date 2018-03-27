<%@ Page Language="VB" AutoEventWireup="false" CodeFile="TiposDeMovsBancarios.aspx.vb" Inherits="Funcionalidad_TiposDeMovsBancarios" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/TiposDeMovsBancarios.js"></script>
    <title>Tipos de movimientos bancarios</title>
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
HabilitaTiposMovsBancarios();
           }
else	{
DeshabilitaTiposMovsBancarios();
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
HabilitaTiposMovsBancarios();
           }
else	{
DeshabilitaTiposMovsBancarios();
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
MuestraTiposMovsBancarios();
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
                                             if (txtMovimiento.GetText() == '') {
                                            txtMovimiento.SetText(s.cpMovimiento); 
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


                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="cve_movimiento" AutoGenerateColumns="False" TextFormatString="{0} | {1}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraTiposMovsBancarios();
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

        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Tipos de movimientos bancarios" Font-Size="Large" Font-Bold="true" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" HeaderText="Datos generales" Font-Size="medium" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">


                                <table style="width: 100%">

                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblMovimiento" ClientEnabled="false" ClientInstanceName="lblMovimiento" ForeColor="Black" runat="server" Text="Movimiento:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtMovimiento" ClientInstanceName="txtMovimiento" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Width="25%" MaxLength="15" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>&nbsp;
                                        </td>
                                        <td style="width: 15%">&nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblDescrpcion" ClientEnabled="false" ClientInstanceName="lblDescrpcion" ForeColor="Black" runat="server" Text="Descripción:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtDescrpcion" ClientInstanceName="txtDescrpcion" ForeColor="Black" Font-Size="Medium" ClientEnabled="false" runat="server" Width="75%" MaxLength="25" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>

                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblTipoDeMovimiento" ClientEnabled="false" ClientInstanceName="lblTipoDeMovimiento" ForeColor="Black" runat="server" Text="Tipo de movimiento:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxComboBox ID="cmbTipoDeMovimiento" ClientEnabled="false" ClientInstanceName="cmbTipoDeMovimiento" Width="50%" Font-Size="Medium" ForeColor="Black" runat="server" ValueType="System.String">
                                                <Items>
                                                    <dx:ListEditItem Text="Abono" Value="1" />
                                                    <dx:ListEditItem Text="Cargo" Value="0" />
                                                </Items>
                                            </dx:ASPxComboBox>

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
                                            <dx:ASPxComboBox ID="cmbAuxiliar" ClientInstanceName="cmbAuxiliar" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Width="75%" ValueType="System.String" TextFormatString="{0} " >
                                                <ClientSideEvents SelectedIndexChanged="function(s, e){
                                                    LlenaDescAux();
                                                    }"
                                                    />
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
                                            <dx:ASPxComboBox ID="cmbDescAuxiliar" ClientInstanceName="cmbDescAuxiliar" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Width="95%" ValueType="System.String" TextFormatString="{1}" >
                                                 <ClientSideEvents SelectedIndexChanged="function(s, e){
                                                    LlenaAuxiliar();
                                                    }"
                                                    />
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
                                            <dx:ASPxLabel ID="lblMovtoBanco" ClientEnabled="false" ClientInstanceName="lblMovtoBanco" ForeColor="Black" runat="server" Text="Movto. Banco:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtMovtoBanco" ClientInstanceName="txtMovtoBanco" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Width="25%" MaxLength="15" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>

                                        <td>
                                            <dx:ASPxLabel ID="lblOrigen" ClientEnabled="false" ClientInstanceName="lblOrigen" ForeColor="Black" runat="server" Text="Origen:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                           <dx:ASPxComboBox ID="cmbOrigen" ClientEnabled="false" ClientInstanceName="cmbOrigen" Font-Size="Medium" ForeColor="Black" Width="50%" runat="server" ValueType="System.String">
                                                <Items>
                                                    <dx:ListEditItem Text="Banco" Value="1" />
                                                    <dx:ListEditItem Text="Propio" Value="0" />
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
