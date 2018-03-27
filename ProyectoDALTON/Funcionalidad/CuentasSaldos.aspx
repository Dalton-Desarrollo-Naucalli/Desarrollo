<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CuentasSaldos.aspx.vb" Inherits="Funcionalidad_CuentasSaldos" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>
<script runat="server">
</script>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/CuentasSaldos.js"></script>
    <title>Cuentas Bancarias</title>
</head>
<body  onkeypress="return pulsar(event)">
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
HabilitaCuentasSaldos();
           }
else	{
DehabilitaCuentasSaldos();
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
HabilitaCuentasSaldos();
           }
else	{
DehabilitaCuentasSaldos();
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
if (txtIdCuenta.GetText() == '') {
txtIdCuenta.SetText(s.cpIdCuenta); 
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


                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="idcuenta" AutoGenerateColumns="False" TextFormatString="{0} | {1}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraCuentasSaldos();
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

        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Cuentas bancarias" Font-Size="Large" Font-Bold="true"  Width="100%" >
            <PanelCollection>
                <dx:PanelContent runat="server">

                    <dx:ASPxRoundPanel ID="ASPxRoundPanel7" runat="server" HeaderText="Datos generales" Font-Size="medium"  Width="100%">
                        <PanelCollection>
                            <dx:PanelContent runat="server">

                                <table style="width: 100%">


                                    <tr>
                                        <td style="width:15%">
                                            <dx:ASPxLabel ID="lblIdCuenta" ClientEnabled="false" ClientInstanceName="lblIdCuenta" ForeColor="Black"  runat="server" Text="ID Cuenta:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td style="width:35%">
                                            <dx:ASPxTextBox ID="txtIdCuenta" ForeColor="Black"  ClientInstanceName="txtIdCuenta" ClientEnabled="false" Font-Size="Medium" runat="server" Width="25%" MaxLength="15" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td style="width:15%">
                                            <dx:ASPxLabel ID="lblNumeroDeCuenta" ClientInstanceName="lblNumeroDeCuenta" ClientEnabled="false" ForeColor="Black" runat="server" Text="Número de cuenta:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td style="width:35%">
                                            <dx:ASPxTextBox ID="txtNumeroDeCuenta" ClientEnabled="false" ClientInstanceName="txtNumeroDeCuenta" ForeColor="Black" Font-Size="Medium" runat="server" Width="50%" MaxLength="18" Height="16px">
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
                                            <dx:ASPxLabel ID="lblIdBanco" ClientInstanceName="lblIdBanco" ClientEnabled="false" ForeColor="Black" runat="server" Text="ID Banco:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxCombobox ID="cmbBanco" ClientEnabled="false" ClientInstanceName="cmbBanco" ForeColor="Black" Font-Size="Medium" runat="server" Width="50%" MaxLength="15" Height="16px">
                                            </dx:ASPxCombobox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblNumeroCuentaClave" ClientEnabled="false" ClientInstanceName="lblNumeroCuentaClave" ForeColor="Black" runat="server" Text="Número de cuenta clave:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtNumeroCuentaClave" ClientEnabled="false" ClientInstanceName="txtNumeroCuentaClave" ForeColor="Black" Font-Size="Medium" runat="server" Width="50%" MaxLength="18" Height="16px">
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
                                            <dx:ASPxLabel ID="lblSucursal" ClientEnabled="false" ClientInstanceName="lblSucursal" ForeColor="Black" runat="server" Text="Sucursal:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtSucursal" ClientEnabled="false" ClientInstanceName="txtSucursal" ForeColor="Black" Font-Size="Medium" runat="server" Width="50%" MaxLength="18" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblInicioOperacion" ClientEnabled="false" ClientInstanceName="lblInicioOperacion" ForeColor="Black" runat="server" Text="Inicio de operación:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxDateEdit ID="dateInicioOperacion"  ClientEnabled="false" UseMaskBehavior="true" ClientInstanceName="dateInicioOperacion" ForeColor="Black"  Font-Size="Medium" Width="50%" runat="server">
                                                                    
                                            </dx:ASPxDateEdit>
                                           

                                        </td>
                                    </tr>

                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblNoSucursal" ClientEnabled="false" ClientInstanceName="lblNoSucursal" ForeColor="Black"  runat="server" Text="No. de sucursal:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtNoSucursal" ClientInstanceName="txtNoSucursal" ForeColor="Black"  Font-Size="Medium" runat="server" Width="25%" MaxLength="15" Height="16px">
                                             <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblNumerocteBanco" ClientInstanceName="lblNumerocteBanco" ClientEnabled="false" ForeColor="Black" runat="server" Text="Número cte. Banco:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtNumeroCteBanco" ClientEnabled="false" ClientInstanceName="txtNumeroCteBanco" ForeColor="Black" Font-Size="Medium" runat="server" MaxLength="10" Width="50%" Height="16px">
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
                                            <dx:ASPxLabel ID="lblMoneda" ClientEnabled="false" ClientInstanceName="lblMoneda" ForeColor="Black" runat="server" Text="Moneda:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbMoneda" ClientInstanceName="cmbMoneda" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" MaxLength="25" Width="50%">                                          
                                               
                                            </dx:ASPxComboBox>
                                        </td>
                                         <td>
                                            <dx:ASPxLabel ID="lblCveFondoRelacionado" ClientEnabled="false" ClientInstanceName="lblCveFondoRelacionado" ForeColor="Black" runat="server" Text="Cve. de fondo relacionado:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                         <td>
                                            <dx:ASPxTextBox ID="txtCveFondoRelacionado" ClientEnabled="false" ClientInstanceName="txtCveFondoRelacionado" ForeColor="Black" Font-Size="Medium" runat="server" Width="50%" MaxLength="1" Height="16px">
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
                                            <dx:ASPxLabel ID="lblCuentaTransferencia" ClientEnabled="false" ClientInstanceName="lblCuentaTransferencia" ForeColor="Black" runat="server" Text="Cuenta de transferencia:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbCuentaTransferencia" ClientInstanceName="cmbCuentaTransferencia" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" Width="50%" MaxLength="30" runat="server" ValueType="System.String">
                                               
                                            </dx:ASPxComboBox>
                                           
                                        </td>                                   
                                        <td>
                                            <dx:ASPxLabel ID="lblSaldo" ClientEnabled="false" ClientInstanceName="lblSaldo" ForeColor="Black" runat="server" Text="Saldo:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtSaldo" ClientEnabled="false" ClientInstanceName="txtSaldo" DisplayFormatString="C" ForeColor="Black" Font-Size="Medium" runat="server" Width="50%" MaxLength="15" Height="16px">
                        
                                                <ClientSideEvents KeyPress="function(s, e) {
ValidaDecimales(txtSaldo);	
}" />  
                                            </dx:ASPxTextBox>
                                        </td>
                                              </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblSaldoEnBlanco" ClientEnabled="false" ClientInstanceName="lblSaldoEnBlanco" ForeColor="Black" runat="server" Text="Saldo en banco:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtSaldoEnBanco" ClientEnabled="false" ClientInstanceName="txtSaldoEnBanco" DisplayFormatString="C" ForeColor="Black" Font-Size="Medium" runat="server" Width="50%" MaxLength="15" Height="16px">
                                          <ClientSideEvents KeyPress="function(s, e) {
ValidaDecimales(txtSaldoEnBanco);	
}" />  
                                                </dx:ASPxTextBox>
                                        </td>
                                         <td>
                                            <dx:ASPxLabel ID="lblTipoPol" ClientEnabled="false" ClientInstanceName="lblTipoPol" ForeColor="Black" runat="server" Text="Tipo pol:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbTipoPol" ClientInstanceName="cmbTipoPol" Font-Size="Medium" ForeColor="Black" Width="50%" MaxLength="30" runat="server" ValueType="System.String">

                                                <Items>
                                                    <dx:ListEditItem Text="Poliza de diario(PDI)" Value="0" />
                                                    <dx:ListEditItem Text="Poliza de egresos(PEG" Value="1" />
                                                    <dx:ListEditItem Text="Poliza de ingresos(PIN)" Value="2" />
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
                                            <dx:ASPxComboBox ID="cmbAuxiliar" ClientInstanceName="cmbAuxiliar" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Width="75%" TextFormatString="{0}" ValueType="System.String">
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
                                            <dx:ASPxComboBox ID="cmbDescAuxiliar" ClientEnabled="false" ClientInstanceName="cmbDescAuxiliar" Font-Size="Medium" ForeColor="Black" Width="75%" TextFormatString="{1}"  runat="server" ValueType="System.String">
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
                                            <dx:ASPxLabel ID="lblFormatoCheques" ClientEnabled="false" ClientInstanceName="lblFormatoCheques" ForeColor="Black" runat="server" Text="Formato de cheques:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbFormatoCheques" ClientInstanceName="cmbFormatoCheques" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" MaxLength="30" Width="50%" runat="server" >

                                           </dx:ASPxComboBox>
                                            
                                        </td>
                                 
                                        <td>
                                            <dx:ASPxLabel ID="lblmoduloid" ClientInstanceName="lblmoduloid" runat="server" Text="Sucursal:" ForeColor="Black" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="cmbModuloid" ClientInstanceName="cmbModuloid" ClientEnabled="false" Font-Size="Medium" ForeColor="Black" MaxLength="25" Width="50%" runat="server" >

                                            </dx:ASPxComboBox>
                                         
                                        </td>
                                        </tr>

                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblConsecutivoDeChequera" ClientEnabled="false" ClientInstanceName="lblConsecutivoDeChequera" ForeColor="Black" runat="server" Text="Consecutivo de chequera:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtConsecutivoDeChequera" ClientInstanceName="txtConsecutivoDeChequera" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" Width="50%" MaxLength="15" Height="16px">
                                           <ClientSideEvents KeyPress="function(s, e) {
ValidaSoloNumeros();	
}" />
                                                </dx:ASPxTextBox>
                                        </td>
                                        <td></td>
                                           <td>
                                            <dx:ASPxButton ID="btnSucursales" runat="server" ClientInstanceName="btnSucursales" ForeColor="Black" ToolTip="Ir al catálogo de sucursales" ClientEnabled="false" Font-Size="Medium" OnClick="btnSucursales_Click" Text="Sucursales" ></dx:ASPxButton>
                                        </td>
                                       <%-- <td>
                                            <dx:ASPxLabel ID="lblEmpresa" ClientEnabled="false" ClientVisible="false" ClientInstanceName="lblEmpresa" ForeColor="Black" runat="server" Text="Empresa:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>

                                        <td>
                                            <dx:ASPxTextBox ID="txtEmpresa" ClientEnabled="false" ClientVisible="false" ClientInstanceName="txtEmpresa" ForeColor="Black" Font-Size="Medium" runat="server" MaxLength="18" Width="50%" Height="16px">
                                            </dx:ASPxTextBox>
                                        </td>--%>
                                        </tr>

                                     <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblCuentaActiva" ClientEnabled="false" ClientInstanceName="lblCuentaActiva" ForeColor="Black" runat="server" Text="Cuenta activa:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxRadioButtonList ID="rbtnCuentaActiva" ClientEnabled="false" RepeatDirection="Horizontal" ClientInstanceName="rbtnCuentaActiva" ForeColor="Black" runat="server" Border-BorderStyle="None" ValueType="System.String" Font-Size="Medium">
                                                
                                                <Items>
                                                    <dx:ListEditItem Value="0" Text="No" />
                                                    <dx:ListEditItem Value="1" Text="Si" />
                                                </Items>
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

