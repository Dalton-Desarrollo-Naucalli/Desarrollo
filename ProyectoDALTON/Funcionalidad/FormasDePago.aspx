<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FormasDePago.aspx.vb" Inherits="Funcionalidad_FormasDePago" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/FormasDePago.js"></script>
    <title>Formas de pago</title>
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
HabilitaFormasDePago();
           }
else	{
DehabilitaFormasDePago();
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
HabilitaFormasDePago();
           }
else	{
DehabilitaFormasDePago();
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
MuestraFormasDePago();
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
  if (txtFormaDePago.GetText() == '') {
 txtFormaDePago.SetText(s.cpIDForma);
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
            <dx:ASPxTextBox runat="server" Width="170px" Visible="False" ClientInstanceName="txtBandera" ID="txtBandera" ClientVisible="False"></dx:ASPxTextBox>
            <br />
            <br />

            <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" HeaderText="Búsqueda:" Font-Size="Medium" Font-Bold="false" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">


                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="id_formapago" AutoGenerateColumns="False" TextFormatString="{0} | {2}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraFormasDePago();
                                                                        HabilitaBotones();
                                                                       }" />

                            <ClientSideEvents Init="function(s, e) {

}"
                                TextChanged="function(s, e) {
	GVFormasDePago.Refresh();
}" />

                        </dx:ASPxGridLookup>

                        <asp:Label ID="lblAccesos" runat="server" CssClass="GlobalTextoPanel" Visible="false"></asp:Label>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>
            <br />
            <br />
        </div>
        <%-- Botones y GRIDLOOKUP BUSQUEDA--%>

        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Formas de pago" Font-Size="Large" Font-Bold="true" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" HeaderText="Datos generales" Font-Size="medium" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">

                                <table style="width: 100%">


                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblIdFormaDePago" runat="server" Text="ID Forma de pago:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td style="width: 30%">
                                            <dx:ASPxTextBox ID="txtFormaDePago" MaxLength="15" ClientInstanceName="txtFormaDePago" ClientEnabled="false" ForeColor="Black" Font-Size="medium" runat="server" Width="25%" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>

                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblSiglas" runat="server" Text="Siglas:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td style="width: 30%">
                                            <dx:ASPxTextBox ID="txtSiglas" ClientInstanceName="txtSiglas" Font-Size="Medium" ForeColor="Black" ClientEnabled="false" runat="server" MaxLength="3" Width="25%" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblDescripcion" runat="server" Text="Descripción:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td style="width: 30%">
                                            <dx:ASPxTextBox ID="txtDescripcion" ClientInstanceName="txtDescripcion" ForeColor="Black" Font-Size="Medium" ClientEnabled="false" runat="server" MaxLength="50" Width="75%" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblTipoDePago" runat="server" Text="Tipo de pago:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxComboBox ID="cmbTipoDePago" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ClientInstanceName="cmbTipoDePago" MaxLength="2" Width="75%">
                                                <Items>
                                                    <dx:ListEditItem Text="Cheque" Value="CH" />
                                                    <dx:ListEditItem Text="Cuenta corriente" Value="CC" />
                                                    <dx:ListEditItem Text="Crédito" Value="CR" />
                                                    <dx:ListEditItem Text="Depósito" Value="DE" />
                                                    <dx:ListEditItem Text="Efectivo" Value="EF" />
                                                    <dx:ListEditItem Text="Nota de crédito" Value="NC" />
                                                    <dx:ListEditItem Text="Tarjeta" Value="TA" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblFormaDePagoActiva" runat="server" Text="Forma de pago activa:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxRadioButtonList ID="rblFormaDePagoActiva" ClientEnabled="false" RepeatDirection="Horizontal" ClientInstanceName="rblFormaDePagoActiva" ForeColor="Black" Font-Size="Medium" runat="server" Border-BorderStyle="None" ValueType="System.String">
                                                <Items>
                                                    <dx:ListEditItem Text="No" Value="0" />
                                                    <dx:ListEditItem Text="Si" Value="1" />
                                                </Items>

                                            </dx:ASPxRadioButtonList>
                                        </td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                </table>

                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>
                    <br />
                    <br />

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel3" runat="server" HeaderText="Número de cuenta por sucursal" Font-Size="medium" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">

                                <table style="width: 100%">

                                    <tr>
                                        <td>
                                            <dx:ASPxGridView ID="GVFormasDePago" runat="server" AutoGenerateColumns="False" Font-Size="Medium" ClientIDMode="AutoID" ClientInstanceName="GVFormasDePago" Width="100%" KeyFieldName="modulo_id" SettingsCommandButton-CancelButton-Text="Cancelar" SettingsCommandButton-UpdateButton-Text="Guardar" ForeColor="Black">
                                                <ClientSideEvents EndCallback="OnEndCallback
"
                                                    BeginCallback="OnBeginCallback	
" />
                                                <SettingsEditing Mode="Batch" UseFormLayout="False" BatchEditSettings-EditMode="Row">
                                                    <BatchEditSettings ShowConfirmOnLosingChanges="false" />
                                                </SettingsEditing>
                                                <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" ConfirmDelete="True" />
                                                <SettingsCommandButton>
                                                    <NewButton ButtonType="Image" RenderMode="Image" Text="Nuevo">
                                                        <Image Height="20px" Url="~/Imagenes/NEW_.png" Width="20px">
                                                        </Image>
                                                    </NewButton>
                                                    <EditButton ButtonType="Image" RenderMode="Image" Text="Editar">
                                                        <Image Height="16px" Url="~/Imagenes/editar.png" Width="16px">
                                                        </Image>
                                                    </EditButton>
                                                    <DeleteButton ButtonType="Image" RenderMode="Image" Text="Eliminar">
                                                        <Image Height="16px" Url="~/Imagenes/Delete.png" Width="16px">
                                                        </Image>
                                                    </DeleteButton>
                                                </SettingsCommandButton>
                                                <SettingsText ConfirmDelete="¿Esta usted seguro de eliminar el registro?" />
                                            </dx:ASPxGridView>
                                        </td>
                                    </tr>
                                </table>

                                <br />
                                <br />

                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>

                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>



    </form>
</body>
</html>

