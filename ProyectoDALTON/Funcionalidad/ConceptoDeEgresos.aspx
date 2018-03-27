<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ConceptoDeEgresos.aspx.vb" Inherits="Funcionalidad_ConceptoDeEgresos" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/ConceptoDeEgresos.js"></script>
    <title>Concepto de egresos</title>
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
GVZonaFis.Refresh();
}"
                                            CheckedChanged="function(s, e) {
if (s.GetChecked()){
LimpiaControles();
HabilitaConceptoEgresos();
           }
else	{
DeshabilitaConceptoEgresos();
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
HabilitaConceptoEgresos();
           }
else	{
DeshabilitaConceptoEgresos();
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
MuestraConceptoEgresos();
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
 if (txtTipoGasto.GetText() == '') {
txtTipoGasto.SetText(s.cpConceptoE);
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


                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="id_tipogasto" AutoGenerateColumns="False" TextFormatString="{0} | {1}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraConceptoEgresos();
                                                                        HabilitaBotones();
                                                                       }" />
                             <ClientSideEvents TextChanged="function(s, e) {
	GVZonaFis.Refresh();
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

        <dx:ASPxRoundPanel ID="rpConceptoEgresos" runat="server" HeaderText="Concepto de Egresos" Font-Size="Medium" Font-Bold="true" Width="100%" ClientIDMode="AutoID" ClientInstanceName="rpConceptoEgresos">
            <PanelCollection>
                <dx:PanelContent runat="server">


                    <table style="width: 100%">


                        <tr>
                            <td style="width: 20%">
                                <dx:ASPxLabel ID="lblTipoGasto" ClientEnabled="false" ForeColor="Black" ClientInstanceName="lblTipoGasto" runat="server" Text="Tipo de gasto:" Font-Size="Medium"></dx:ASPxLabel>
                            </td>
                            <td style="width: 30%">
                                <dx:ASPxTextBox ID="txtTipoGasto" runat="server" ClientEnabled="false" ForeColor="Black" ClientInstanceName="txtTipoGasto" Font-Size="Medium" Width="25%" MaxLength="15" Height="16px" >
                                </dx:ASPxTextBox>
                            </td>

                            <td style="width: 20%">
                                <dx:ASPxLabel ID="lblDescripcion" ClientEnabled="false" ForeColor="Black" ClientInstanceName="lblDescripcion" runat="server" Text="Descripción:" Font-Size="Medium"></dx:ASPxLabel>
                            </td>
                            <td style="width: 30%">
                                <dx:ASPxTextBox ID="txtDescripcion" runat="server" ClientInstanceName="txtDescripcion" ForeColor="Black" Font-Size="Medium" Width="75%" MaxLength="40" Height="16px" ClientIDMode="AutoID" ClientEnabled="false">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 4px"></td>
                        </tr>
                        <tr>
                            <td style="width: 15%">
                                <dx:ASPxLabel ID="lblTipoConcepto" ForeColor="Black" runat="server" Font-Size="Medium" Text="Tipo de concepto:" ClientEnabled="false" ClientInstanceName="lblTipoConcepto"></dx:ASPxLabel>
                            </td>

                            <td>
                                <dx:ASPxComboBox ID="cmbTipoConcepto" runat="server" Font-Size="Medium" ClientInstanceName="cmbTipoConcepto" Width="75%" ClientIDMode="AutoID" ClientEnabled="False" ForeColor="Black">

                                    <Items>

                                        <dx:ListEditItem Text="Proveedores" Value="1" />
                                        <dx:ListEditItem Text="Gastos" Value="2" />
                                        <dx:ListEditItem Text="Anticipo a proveedores" Value="7" />
                                        <dx:ListEditItem Text="Consumibles" Value="3" />
                                        <dx:ListEditItem Text="Amortizaciones" Value="4" />
                                        <dx:ListEditItem Text="Depreciaciones" Value="5" />
                                        <dx:ListEditItem Text="Proviciones" Value="6" />
                                    </Items>

                                </dx:ASPxComboBox>
                            </td>
                            <td>
                                <dx:ASPxLabel ID="lblTipoProrrateo" runat="server" Text="Tipo de prorrateo:" Font-Size="Medium" ClientEnabled="false" ClientInstanceName="lblTipoProrrateo" ForeColor="Black"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxComboBox ID="cmbTipoProrrateo" runat="server" Font-Size="Medium" ClientInstanceName="cmbTipoProrrateo" Width="75%" ClientIDMode="AutoID" ClientEnabled="False" ForeColor="Black">

                                    <Items>
                                        <dx:ListEditItem Text="Automático" Value="A" />
                                        <dx:ListEditItem Text="Automático al 100%" Value="X" />
                                        <dx:ListEditItem Text="Por entrada al almacén o CC de empleado" Value="E" />
                                        <dx:ListEditItem Text="Manual" Value="M" />
                                    </Items>

                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 2px"></td>
                        </tr>

                        <tr>
                            <td>
                                <dx:ASPxLabel ID="lblCentroCostos" ClientEnabled="false" ClientInstanceName="lblCentroCostos" Font-Size="Medium" ForeColor="Black" runat="server" Text="Centro de costos"></dx:ASPxLabel>
                            </td>
                            <td style="width: 30%">
                                <dx:ASPxComboBox ID="cmbCentroCostos" runat="server" Font-Size="Medium" ClientInstanceName="cmbCentroCostos" Width="75%" ClientIDMode="AutoID" ClientEnabled="False" ForeColor="Black">
                                </dx:ASPxComboBox>
                            </td>
                            <td>
                                <dx:ASPxLabel ID="lblSujetoRetencionIVA" ClientEnabled="false" ClientInstanceName="lblSujetoRetencionIVA" runat="server" Text="Sujeto a retención IVA" Font-Size="Medium" ForeColor="Black"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxRadioButtonList ID="rblSujetoRetencionIVA" Border-BorderStyle="None" Font-Size="Medium" RepeatDirection="Horizontal" runat="server" ClientIDMode="AutoID" ClientInstanceName="rblSujetoRetencionIVA" ClientEnabled="False" ForeColor="Black" Height="5px">
                                     <ClientSideEvents SelectedIndexChanged="function(s, e) {
                                                    SujetoRetencionIVA();	                                       
                                                 LimpiaCampos();
                                                    }"
                                                    />
                                    <Items>
                                        <dx:ListEditItem Value="1" Text="Sí" />
                                        <dx:ListEditItem Value="0" Text="No" />                                        
                                    </Items>

                                    <Border BorderStyle="None"></Border>

                                </dx:ASPxRadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 2px"></td>
                        </tr>

                        <tr style="padding: 4px">
                            <td>
                                <dx:ASPxLabel ID="lblSujetoRetencionISR" ClientEnabled="false" ClientInstanceName="lblSujetoRetencionISR" Font-Size="Medium" ForeColor="Black" runat="server" Text="Sujeto retención ISR"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxRadioButtonList ID="rblSujetoRetencionISR" Border-BorderStyle="None" RepeatDirection="Horizontal" ForeColor="Black" Font-Size="Medium" runat="server" ClientIDMode="AutoID" ClientInstanceName="rblSujetoRetencionISR" ClientEnabled="False">
                                    <ClientSideEvents SelectedIndexChanged="function(s, e) {
                                                    SujetoRetencionISR();	                                       
                                                 LimpiaCampos();
                                                    }"
                                                    />
                                    <Items>
                                        <dx:ListEditItem Value="1" Text="Sí" />
                                        <dx:ListEditItem Value="0" Text="No" />                                        
                                    </Items>

                                    <Border BorderStyle="None"></Border>
                                </dx:ASPxRadioButtonList>
                            </td>
                            <td>
                                <dx:ASPxLabel ID="lblRetencionIva" ClientInstanceName="lblRetencionIva" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Text="Retención IVA"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="txtRetencionIVA" ForeColor="Black" Font-Size="Medium" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtRetencionIVA" Width="25%" MaxLength="15" ClientEnabled="false">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>

                    </table>
                    <br />
                    <br />
                    <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" HeaderText="% Impuestos" Font-Size="Medium" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblIVA" ClientEnabled="false" ClientInstanceName="lblIVA" ForeColor="Black" Font-Size="Medium" runat="server" Text="%IVA"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 30%">
                                            <dx:ASPxTextBox ID="txtIVA" runat="server" ClientInstanceName="txtIVA" Font-Size="Medium" Width="25%" MaxLength="15" ForeColor="Black" ClientIDMode="AutoID" ClientEnabled="false">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblImpEsp" ClientInstanceName="lblImpEsp" ForeColor="Black" ClientEnabled="false" Font-Size="Medium" runat="server" Text="% Imp. Esp."></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 30%">
                                            <dx:ASPxTextBox ID="txtImpEsp" runat="server" ForeColor="Black" Font-Size="Medium" ClientInstanceName="txtImpEsp" Width="25%" MaxLength="15" ClientIDMode="AutoID" ClientEnabled="false">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>

                                </table>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>
                    <br />
                    <br />

                    <table style="width: 100%">
                        <tr>
                            <td style="width: 20%">
                                <dx:ASPxLabel ID="lblAplicaPersonas" ClientEnabled="false" ClientInstanceName="lblAplicaPersonas" ClientVisible="false" Font-Size="Medium" ForeColor="Black" runat="server" Text="Aplica personas"></dx:ASPxLabel>
                            </td>
                            <td style="width: 30%">
                                <dx:ASPxRadioButtonList ID="rblAplicaPersonas" runat="server" ForeColor="Black" ClientVisible="false" Border-BorderStyle="None" Font-Size="Medium" ClientIDMode="AutoID" ClientInstanceName="rblAplicaPersonas" ClientEnabled="False">
                                    <Items>
                                        <dx:ListEditItem Value="1" Text="Físicas" />
                                        <dx:ListEditItem Value="2" Text="Morales" />
                                        <dx:ListEditItem Value="3" Text="Ambos" />
                                    </Items>

                                    <Border BorderStyle="None"></Border>
                                </dx:ASPxRadioButtonList>
                            </td>
                            <td style="width: 20%">
                                <dx:ASPxLabel ID="lblPresupuestoBaseFacturado" ClientEnabled="false" ClientInstanceName="lblPresupuestoBaseFacturado" Font-Size="Medium" ForeColor="Black" runat="server" Text="Presupuesto con base a lo facturado:"></dx:ASPxLabel>
                            </td>
                            <td style="width: 30%">
                                <dx:ASPxRadioButtonList ID="rblPresupuestoBaseFacturado" Border-BorderStyle="None" RepeatDirection="Horizontal" ForeColor="Black" Font-Size="Medium" runat="server" ClientIDMode="AutoID" ClientInstanceName="rblPresupuestoBaseFacturado" ClientEnabled="False">

                                    <Items>
                                        <dx:ListEditItem Value="N" Text="No" />
                                        <dx:ListEditItem Value="S" Text="Sí" />
                                    </Items>


                                    <Border BorderStyle="None"></Border>


                                </dx:ASPxRadioButtonList>

                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 4px"></td>
                        </tr>

                        <tr>
                            <td>
                                <dx:ASPxLabel ID="lblTipoGastoProvision" ClientEnabled="false" ClientInstanceName="lblTipoGastoProvision" ForeColor="Black" Font-Size="Medium" runat="server" Text="Tipo de gasto para la provisión"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxComboBox ID="cmbTipoGastoProvision" TextFormatString="{0}" runat="server" Font-Size="Medium" ClientInstanceName="cmbTipoGastoProvision" Width="50%"  ClientIDMode="AutoID"  ClientEnabled="False" ForeColor="Black">
                                <Columns>
                                    <dx:ListBoxColumn Caption="No. Cuenta" FieldName="ID" Width="100px" />
                                    <dx:ListBoxColumn Caption="Descripción" FieldName="Descripcion" Width="400px" /> 
                                </Columns>
                                </dx:ASPxComboBox>
                            </td>
                            <td>
                                <dx:ASPxLabel ID="lblProrrateoFacturacion" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Text="Prorrateo por facturación:"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxRadioButtonList ID="rblProrrateoFacturacion" Border-BorderStyle="None" RepeatDirection="Horizontal" ForeColor="Black" Font-Size="Medium" runat="server" ClientIDMode="AutoID" ClientInstanceName="rblProrrateoFacturacion" ClientEnabled="False">
                                    <ClientSideEvents SelectedIndexChanged="function(s, e) {
                                                    ProrrateoFactuaracionN();	                                       
                                                 LimpiaCampos();
                                                    }"
                                                    />
                                    <Items>
                                        <dx:ListEditItem Value="0" Text="No" />
                                        <dx:ListEditItem Value="1" Text="Sí" />
                                    </Items>
                                    <Border BorderStyle="None"></Border>
                                </dx:ASPxRadioButtonList>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 4px"></td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxLabel ID="lblTipoGastoProrrateo" ClientEnabled="false" ClientVisible="false" ClientInstanceName="lblTipoGastoProrrateo" ForeColor="black" Font-Size="Medium" runat="server" Text="Tipo de gasto para prorrateo"></dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxComboBox ID="cmbTipoGastoProrrateo" runat="server" ClientVisible="false" TextFormatString="{0}" Font-Size="Medium" Width="50%" ClientIDMode="AutoID" ClientInstanceName="cmbTipoGastoProrrateo" TextField="descripcion" ValueField="id_tipogasto" ForeColor="Black" ClientEnabled="False">
                                <Columns>
                                    <dx:ListBoxColumn Caption="No. Cuenta" FieldName="ID" Width="100px" />
                                    <dx:ListBoxColumn Caption="Descripción" FieldName="Descripcion" Width="400px" /> 
                                </Columns>
                                    </dx:ASPxComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 4px"></td>
                        </tr>

                        <tr>
                            <td colspan="4">
                                <dx:ASPxRoundPanel ID="ASPxRoundPanel3" runat="server" Font-Size="Medium" HeaderText="Impuestos por zona fiscal" Width="100%" Style="text-align: center">
                                    <PanelCollection>
                                        <dx:PanelContent runat="server">
                                            <dx:ASPxGridView ID="GVZonaFis" runat="server" AutoGenerateColumns="False" Font-Size="Medium"  ClientIDMode="AutoID" ClientInstanceName="GVZonaFis" Width="100%" KeyFieldName="ZF" SettingsCommandButton-CancelButton-Text="Cancelar" SettingsCommandButton-UpdateButton-Text="Guardar" ForeColor="Black">
                                                <ClientSideEvents EndCallback="OnEndCallback
                                                   "
                                                    BeginCallback="OnBeginCallback	
                                                   " />
                                                <SettingsEditing Mode="Batch" UseFormLayout="False">
                                                </SettingsEditing>
                                                <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                                                <SettingsCommandButton>
                                                    <NewButton ButtonType="Image" RenderMode="Image" Text="Nuevo">
                                                        <Image Height="20px" Url="~/Imagenes/NEW_.png" Width="20px">
                                                        </Image>
                                                    </NewButton>

<UpdateButton Text="Guardar"></UpdateButton>

<CancelButton Text="Cancelar"></CancelButton>

                                                    <EditButton ButtonType="Image" RenderMode="Image" Text="Editar">
                                                        <Image Height="16px" Url="~/Imagenes/editar.png" Width="16px">
                                                        </Image>
                                                    </EditButton>
                                                    <DeleteButton ButtonType="Image" RenderMode="Image" Text="Eliminar">
                                                        <Image Height="16px" Url="~/Imagenes/Delete.png" Width="16px">
                                                        </Image>
                                                    </DeleteButton>
                                                </SettingsCommandButton>
                                            </dx:ASPxGridView>
                                        </dx:PanelContent>
                                    </PanelCollection>
                                </dx:ASPxRoundPanel>
                            </td>
                        </tr>

                    </table>
                    <br />
                    <br />

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel6" runat="server" HeaderText="Configuración de cuentas contables" Font-Size="Medium" Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblEgresos" ClientInstanceName="lblEgresos" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Text="Egresos:"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 30%">
                                            <dx:ASPxComboBox ID="cmbEgresos" runat="server" Font-Size="Medium" TextFormatString="{0}" ClientInstanceName="cmbEgresos" Width="75%" ClientIDMode="AutoID" ClientEnabled="False" ForeColor="Black">
                                        <Columns>
                                    <dx:ListBoxColumn Caption="No. Cuenta" FieldName="numerodecuenta" Width="100px" />
                                    <dx:ListBoxColumn Caption="Descripción" FieldName="descripcion" Width="400px" /> 
                                </Columns>
                                                </dx:ASPxComboBox>
                                        </td>
                                        <td style="width: 20%">
                                            <dx:ASPxLabel ID="lblDevoluciones" ForeColor="Black" Font-Size="Medium" ClientEnabled="false" ClientInstanceName="lblDevoluciones" runat="server" Text="Devoluciones:"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 30%">
                                            <dx:ASPxComboBox ID="cmbDevoluciones" runat="server" Font-Size="Medium" TextFormatString="{0}" ClientInstanceName="cmbDevoluciones" Width="75%" ClientEnabled="False" ClientIDMode="AutoID" ForeColor="Black">
                                           <Columns>
                                    <dx:ListBoxColumn Caption="No. Cuenta" FieldName="numerodecuenta" Width="100px" />
                                    <dx:ListBoxColumn Caption="Descripción" FieldName="descripcion" Width="400px" /> 
                                </Columns>
                                                </dx:ASPxComboBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblIngresos" ClientEnabled="false" ClientInstanceName="lblIngresos" ForeColor="Black" Font-Size="Medium" runat="server" Text="Ingresos"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbIngresos" Font-Size="Medium" TextFormatString="{0}" runat="server" ClientInstanceName="cmbIngresos" Width="75%" ClientIDMode="AutoID" ClientEnabled="False" ForeColor="Black">
                                            <Columns>
                                    <dx:ListBoxColumn Caption="No. Cuenta" FieldName="numerodecuenta" Width="100px" />
                                    <dx:ListBoxColumn Caption="Descripción" FieldName="descripcion" Width="400px" /> 
                                </Columns>
                                                </dx:ASPxComboBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblImpEspecial" ClientEnabled="false" ClientInstanceName="lblImpEspecial" Font-Size="Medium" ForeColor="Black" runat="server" Text="Imp. Especial"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbImpEspecial" TextFormatString="{0}" Font-Size="Medium" runat="server" ClientInstanceName="cmbImpEspecial" Width="75%" ClientEnabled="False" ClientIDMode="AutoID" ForeColor="Black">
                                            <Columns>
                                    <dx:ListBoxColumn Caption="No. Cuenta" FieldName="numerodecuenta" Width="100px" />
                                    <dx:ListBoxColumn Caption="Descripción" FieldName="descripcion" Width="400px" /> 
                                </Columns>
                                                </dx:ASPxComboBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblIvaPend" ClientEnabled="false" ClientInstanceName="lblIvaPend" ForeColor="Black" Font-Size="Medium" runat="server" Text="IVA Pend:"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbIvaPend" TextFormatString="{0}" runat="server" Font-Size="Medium" ClientInstanceName="cmbIvaPend" Width="75%" ClientIDMode="AutoID" ClientEnabled="False" ForeColor="Black">
                                           <Columns>
                                    <dx:ListBoxColumn Caption="No. Cuenta" FieldName="numerodecuenta" Width="100px" />
                                    <dx:ListBoxColumn Caption="Descripción" FieldName="descripcion" Width="400px" /> 
                                </Columns>
                                                </dx:ASPxComboBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblIvaPagado" ClientInstanceName="lblIvaPagado" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Text="IVA Pagado:"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbIvaPagado" TextFormatString="{0}" runat="server" Font-Size="Medium" ClientInstanceName="cmbIvaPagado" Width="75%" ClientEnabled="False" ClientIDMode="AutoID" ForeColor="Black">
                                          <Columns>
                                    <dx:ListBoxColumn Caption="No. Cuenta" FieldName="numerodecuenta" Width="100px" />
                                    <dx:ListBoxColumn Caption="Descripción" FieldName="descripcion" Width="400px" /> 
                                </Columns> 
                                                </dx:ASPxComboBox>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblRetISR" ClientInstanceName="lblRetISR"  ClientVisible="false" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" runat="server" Text="Ret. ISR:"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtRetISR" Font-Size="Medium" ClientVisible="false" ForeColor="Black" runat="server" Width="50%" ClientIDMode="AutoID" ClientInstanceName="txtRetISR" ClientEnabled="false">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblRetIva" ClientInstanceName="lblRetIva" ClientVisible="false" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Text="Ret. IVA:"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtRetIva" Font-Size="Medium" ForeColor="Black" ClientVisible="false" runat="server" Width="50%" ClientIDMode="AutoID" ClientInstanceName="txtRetIva" ClientEnabled="false">
                                            </dx:ASPxTextBox>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblRetIvaCCH" ClientVisible="false" ClientEnabled="false" ClientInstanceName="lblRetIvaCCH" ForeColor="Black" Font-Size="Medium" runat="server" Text="Ret. IVA C/CH"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtRetIvaCCH" ClientVisible="false" Font-Size="Medium" ForeColor_="black" runat="server" Width="50%" ClientIDMode="AutoID" ClientInstanceName="txtRetIvaCCH" ClientEnabled="false">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblRetIvaCTR" ClientVisible="false" ClientEnabled="false" ClientInstanceName="lblRetIvaCTR" ForeColor="Black" Font-Size="Medium" runat="server" Text="Ret. IVA C/TR"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtRetIvaCTR" ClientVisible="false" Font-Size="Medium" ForeColor="Black" runat="server" Width="50%" ClientIDMode="AutoID" ClientInstanceName="txtRetIvaCTR" ClientEnabled="false">
                                            </dx:ASPxTextBox>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblAplRegContableConcepto" ClientEnabled="false" ClientInstanceName="lblAplRegContableConcepto" ForeColor="Black" Font-Size="Medium" runat="server" Text="Apl. Registro contable al concepto:"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxRadioButtonList ID="rblAplRegContableConcepto" Border-BorderStyle="None" RepeatDirection="Horizontal" ForeColor="Black" Font-Size="Medium" runat="server" ValueType="System.String" ClientIDMode="AutoID" ClientInstanceName="rblAplRegContableConcepto" ClientEnabled="False">
                                                <Items>
                                                    <dx:ListEditItem Text="No" Value="0" />
                                                    <dx:ListEditItem Text="Si" Value="1" />
                                                </Items>

                                                <Border BorderStyle="None"></Border>

                                            </dx:ASPxRadioButtonList>
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
