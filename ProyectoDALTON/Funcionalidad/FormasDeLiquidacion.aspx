<%@ Page Language="VB" AutoEventWireup="false" CodeFile="FormasDeLiquidacion.aspx.vb" Inherits="Funcionalidad_FormasDeLiquidacion" %>


<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/FormasDeLiquidacion.js"></script>
    <title>Formas de liquidación </title>
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
HabilitaFormasLiquidacion();
           }
else	{
DeshabilitaFormasLiquidacion();
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
HabilitaFormasLiquidacion();
           }
else	{
DeshabilitaFormasLiquidacion();
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
MuestraFormasLiquidacion();
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
 if (txtFormaDeLiquidacion.GetText() == '') {
txtFormaDeLiquidacion.SetText(s.cpFormasDeLiquidacion); 
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


                 


                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="ID_formaliq" AutoGenerateColumns="False" TextFormatString="{0} | {2}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraFormasLiquidacion();
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

        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Formas de liquidación:" Font-Bold="true" Font-Size="Large" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">


                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" HeaderText="Datos generales:" Font-Size="medium" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">
                                <table style="width: 100%">



                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblFormaDeLiquidacion" runat="server" Text="Forma de  liquidación:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td style="width: 35%">
                                            <dx:ASPxTextBox ID="txtFormaDeLiquidacion" MaxLength="15" ClientEnabled="false" ClientInstanceName="txtFormaDeLiquidacion" ForeColor="Black" Font-Size="Medium" runat="server" Width="25%" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblEsCuentaBancaria" runat="server" Text="Es cuenta bancaria:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td style="width: 35%">
                                            <dx:ASPxRadioButtonList ID="rbtnEsCuentaBancaria" ClientInstanceName="rbtnEsCuentaBancaria" RepeatDirection="Horizontal" ForeColor="Black" ClientEnabled="false" Border-BorderStyle="None" Font-Size="Medium" runat="server" ValueType="System.String">
                                                <ClientSideEvents SelectedIndexChanged="function(s, e) {
                                                    EsCuenta();	                                       
                                                 LimpiaCampos();
                                                    }"
                                                    />
                                                
                                                <Items>
                                                    <dx:ListEditItem Text="No" Value="0" />
                                                    <dx:ListEditItem Text="Si" Value="1" />
                                                </Items>

                                                <Border BorderStyle="None"></Border>
                                            </dx:ASPxRadioButtonList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblNoCuenta" ClientInstanceName="lblNoCuenta" ClientVisible="false" ForeColor="Black" Font-Size="Medium" ClientEnabled="false" runat="server" Text="No. Cuenta:"></dx:ASPxLabel>
                                            <dx:ASPxLabel ID="lblDesripcion" ClientInstanceName="lblDesripcion" runat="server" ForeColor="Black" Text="Descripción:" ClientEnabled="false" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>

                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbNoCuenta" ClientEnabled="true" ClientVisible="false" ClientInstanceName="cmbNoCuenta" Width="50%" MaxLength="16" Font-Size="Medium" ForeColor="Black" runat="server" ValueType="System.String" TextFormatString="{0}">
                                                <Columns>

                                                    <dx:ListBoxColumn Caption="No. Cuenta" FieldName="NombreNC" />
                                                    <dx:ListBoxColumn Caption="Nombre" FieldName="Banco" />
                                                </Columns>
                                                <ClientSideEvents EndCallback="function(s, e) {
                                                    recuperaValor();
                                                                  }" />
                                            </dx:ASPxComboBox>

                                            <dx:ASPxTextBox ID="txtDescripcion" ClientInstanceName="txtDescripcion" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Width="75%" MaxLength="30" Height="16px">
                                            </dx:ASPxTextBox>

                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblDescripcionCOrta" runat="server" Text="Descripción corta:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtDescripcionCorta" ClientInstanceName="txtDescripcionCorta" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Width="50%" MaxLength="15" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblMoneda" ClientInstanceName="lblMoneda" runat="server" Text="Moneda:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxComboBox ID="cmbMoneda" ClientEnabled="false" ClientInstanceName="cmbMoneda" ForeColor="Black" Font-Size="Medium" runat="server" Width="50%" MaxLength="15" ClientIDMode="AutoID">
                                            </dx:ASPxComboBox>
                                        </td>

                                        <td>
                                            <dx:ASPxLabel ID="lblCuentaInterna" ClientInstanceName="lblCuentaInterna" runat="server" Text="Cuenta interna:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxComboBox ID="cmbCuentaInterna" ClientEnabled="false" ClientInstanceName="cmbCuentaInterna" ForeColor="Black" Font-Size="Medium" runat="server" Width="50%" MaxLength="16">
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblCuentaExterna" ClientInstanceName="lblCuentaExterna" runat="server" Text="Cuenta externa:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxComboBox ID="cmbCuentaExterna" ClientInstanceName="cmbCuentaExterna" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Width="50%" MaxLength="16">
                                            </dx:ASPxComboBox>
                                        </td>

                                        <td>
                                            <dx:ASPxLabel ID="lblTipoDeAplicacion" runat="server" Text="Tipo de aplicación:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxComboBox ID="cmbTipoDeAplicacion" ClientInstanceName="cmbTipoDeAplicacion" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Width="50%" MaxLength="1" ValueType="System.String">
                                                <Items>
                                                    <dx:ListEditItem Text="Ambos" Value="A" />
                                                    <dx:ListEditItem Text="Anticipos" Value="P" />
                                                    <dx:ListEditItem Text="Compras" Value="C" />
                                                    <dx:ListEditItem Text="Gastos" Value="G" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 2px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblChequeCaja" runat="server" Text="Cheque o caja:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxComboBox ID="cmbChequeCajaTrans" ClientInstanceName="cmbChequeCajaTrans" ForeColor="Black" Font-Size="Medium" ClientEnabled="false" runat="server" Width="50%"  ValueType="System.String">
                                                <Items>
                                                    <dx:ListEditItem Text=" Cheque" Value="CH" />
                                                    <dx:ListEditItem Text=" Transferencia" Value="CO" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                            <dx:ASPxComboBox ID="cmbChequeCaja" ClientInstanceName="cmbChequeCaja" ForeColor="Black" ClientVisible="false" Font-Size="Medium" ClientEnabled="false" runat="server" Width="50%"  ValueType="System.String">
                                                <Items>
                                                    <dx:ListEditItem Text=" Caja" Value="CA" />
                                                    <dx:ListEditItem Text=" Contabilidad" Value="CO" />
                                                </Items>
                                            </dx:ASPxComboBox>
                                        </td>

                                        <td>
                                            <dx:ASPxLabel ID="lblFormaDeLiquidacionActiva" runat="server" Text="Forma de liquidación activa:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxRadioButtonList ID="rbtnFormaDeLiquidacionActiva" ClientInstanceName="rbtnFormaDeLiquidacionActiva" RepeatDirection="Horizontal" ForeColor="Black" ClientEnabled="false" runat="server" Border-BorderStyle="None" Font-Size="Medium" ValueType="System.String">
                                              
                                                <Items>
                                                    <dx:ListEditItem Text="No" Value="0" />
                                                    <dx:ListEditItem Text="Si" Value="1" />
                                                </Items>

                                                <Border BorderStyle="None"></Border>
                                            </dx:ASPxRadioButtonList>

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

