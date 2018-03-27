<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AbonoCapitalArrendamientoPuro.aspx.vb" Inherits="MiFuncionalidad_AbonoCapitalArrendamientoPuro" %>
<%@ Register Assembly="DevExpress.Data.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        <div>

            <dx:ASPxRoundPanel ID="ASPxRoundPanel4" runat="server" ShowCollapseButton="True" ShowHeader="False" Theme="Office2003Blue" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">
                        <table class="auto-style40">
                            <tr>
                                <td>
                                    <dx:ASPxButton ID="btnAgregar" runat="server" ToolTip="Agregar" ClientInstanceName="btnAgregar" AutoPostBack="False" EnableClientSideAPI="false">
                                        <ClientSideEvents Click="function(s, e) {
	               OnNewRowClicked();
                                     }" />
                                        <Image IconID="actions_add_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnEditar" runat="server" ToolTip="Editar" ClientInstanceName="btnEditar" AutoPostBack="False" EnableClientSideAPI="false">
                                        <ClientSideEvents Click="function(s, e) {
                           OnEditRowClicked();	
                                              }" />
                                        <Image IconID="edit_edit_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnEliminar" runat="server" ToolTip="Eliminar" AutoPostBack="False" ClientInstanceName="btnEliminar" EnableClientSideAPI="True">
                                        <ClientSideEvents Click="function(s, e) {
	                                        OnConfirmDeleteRowsClicked();
                                        }" />
                                        <Image IconID="edit_delete_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnCancelar" runat="server" AutoPostBack="False" ClientInstanceName="btnCancelar" ToolTip="Cancelar" EnableClientSideAPI="True">
                                        <ClientSideEvents Click="function(s, e) {
	                                        OnDiscardChangesClicked();
                                        }" />
                                        <Image IconID="actions_cancel_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnAplicar" runat="server" AutoPostBack="False" ClientInstanceName="btnAplicar" ToolTip="Aplicar" ValidationGroup="reqError1" EnableClientSideAPI="true" CausesValidation="False">
                                        <ClientSideEvents Click="function(s, e) {
                                            OnSaveChangesClicked();
                                            }" />
                                        <Image IconID="actions_apply_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnFiltrar" runat="server" AutoPostBack="False" ClientInstanceName="btnFiltrar" ToolTip="Filtrar" EnableClientSideAPI="True">
                                        <ClientSideEvents Click="function(s, e) {
	                                        OnFilterClicked();
                                               }" />
                                        <Image IconID="filter_filter_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnBuscar" runat="server" ClientInstanceName="btnBuscar" ToolTip="Buscar" EnableClientSideAPI="True">
                                        <Image IconID="find_find_32x32">
                                        </Image>
                                    </dx:ASPxButton>

                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnDeshacer" runat="server" ClientInstanceName="btnDeshacer" ToolTip="Deshacer" AutoPostBack="False" EnableClientSideAPI="True">
                                        <ClientSideEvents Click="function(s, e) {
	                                        OnUndoChangesClicked();
                                                           }" />
                                        <Image IconID="history_undo_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnRehacer" runat="server" ClientInstanceName="btnRehacer" ToolTip="Rehacer" AutoPostBack="False" EnableClientSideAPI="True">
                                        <ClientSideEvents Click="function(s, e) {
	                                        OnRedoChangesClicked();
                                                          }" />
                                        <Image IconID="history_redo_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>

                                <td>
                                    <dx:ASPxButton ID="btnNuevo" runat="server" ClientInstanceName="btnNuevo" ToolTip="Imprimir" AutoPostBack="False" EnableClientSideAPI="True">
                                        <ClientSideEvents Click="function(s, e) {
	                                        OnRedoChangesClicked();
                                                          }" />
                                        <Image IconID="businessobjects_boresume_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>

                                <td>
                                    <dx:ASPxButton ID="ASPxButton2" runat="server" ClientInstanceName="btnNuevo" ToolTip="Imprimir" AutoPostBack="False" EnableClientSideAPI="True">
                                        <ClientSideEvents Click="function(s, e) {
	                                        OnRedoChangesClicked();
                                                          }" />
                                        <Image IconID="print_printer_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>




                            </tr>
                        </table>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>
            <br />
            <br />
        </div>
        <%--botones--%>

        <div>
            <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" ShowCollapseButton="True" ShowHeader="False" Theme="Office2003Olive" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">

                        <table style="width: 100%">
                            <tr>
                                <td colspan="2">
                                    <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Buscar:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>

                                </td>
                            </tr>

                            <tr>

                                <td style="width: 7%">
                                    <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Empresa" Width="95%"></dx:ASPxButton>
                                </td>

                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="90%"></dx:ASPxTextBox>
                                </td>


                                <td style="width: 7%">
                                    <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Contrato" Width="95%"></dx:ASPxButton>
                                </td>

                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextBox3" runat="server" Width="90%"></dx:ASPxTextBox>
                                </td>

                                <td style="width: 5%">
                                    <dx:ASPxButton ID="ASPxButton4" runat="server" Text="Anexo" Width="95%"></dx:ASPxButton>
                                </td>

                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextBox4" runat="server" Width="90%"></dx:ASPxTextBox>
                                </td>
                                <td style="width: 5%">
                                    <dx:ASPxButton ID="ASPxButton5" runat="server" Text="VIN" Width="95%"></dx:ASPxButton>
                                </td>

                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextBox5" runat="server" Width="90%"></dx:ASPxTextBox>
                                </td>

                            </tr>


                        </table>

                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>

            <br />
            <br />
        </div>
        <%--Botón bucar--%>

        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="True" ShowHeader="False" Theme="Office2003Blue" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">


                    <dx:ASPxPageControl ID="prod" runat="server" ActiveTabIndex="4" EnableTheming="True" Theme="Office2010Blue" Width="100%">
                        <TabPages>


                            <dx:TabPage Name="tabMnto" Text="Abono a capital arrendaiento puro" ActiveTabStyle-Font-Size="Medium">
                                <ActiveTabStyle Font-Size="Medium"></ActiveTabStyle>
                                <ContentCollection>
                                    <dx:ContentControl runat="server">



                                        <table style="width: 100%">

                                            <tr>
                                                <td colspan="8">&nbsp;
                                                </td>
                                            </tr>

                                            <tr>

                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Empresa:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="Transportes pedidos S.A" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>


                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="Contrato:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel12" runat="server" Text="446465" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>


                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel13" runat="server" Text="Anexo:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel14" runat="server" Text="5555" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel15" runat="server" Text="VIN:" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel16" runat="server" Text="1029384756564738" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                            </tr>

                                            <tr>
                                                <td colspan="8">&nbsp;
                                                </td>
                                            </tr>
                                        </table>
                                        <br />
                                        <br />


                                        <table style="width: 80%">

                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel17" runat="server" Text="Saldo intereses actuales" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel18" runat="server" Text="$0.00" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel19" runat="server" Text="Saldos insolutos actuales" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel20" runat="server" Text="$120,000.00" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="8">&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel21" runat="server" Text="Plazo contratado" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel22" runat="server" Text="48" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel23" runat="server" Text="Residual actual" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel24" runat="server" Text="$150,000.00" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="8">&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel25" runat="server" Text="Mensualidad original" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel26" runat="server" Text="$30,000.00" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel27" runat="server" Text="Mensualidades restantes (original)" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel28" runat="server" Text="4" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="8">&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Monto abono a capital" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="$60,000.00" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Fecha estimada de abono" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="10/09/2017" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="8">&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="3">
                                                    <dx:ASPxRadioButton ID="ASPxRadioButton1" Text="Reducir plazo" runat="server"></dx:ASPxRadioButton>
                                                    <dx:ASPxRadioButton ID="ASPxRadioButton2" Text="Reducir mensualidad" runat="server"></dx:ASPxRadioButton>
                                                </td>

                                                <td>
                                                    <dx:ASPxButton ID="ASPxButton6" runat="server" Text="Simular"></dx:ASPxButton>
                                                </td>


                                            </tr>

                                        </table>

                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>

                            <dx:TabPage Name="tabMnto" Text="Reducción de plazo" ActiveTabStyle-Font-Size="Medium">
                                <ActiveTabStyle Font-Size="Medium"></ActiveTabStyle>
                                <ContentCollection>
                                    <dx:ContentControl runat="server">

                                        <table style="width: 50%">
                                             <tr>
                                                <td colspan="8">&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="Mensualidades restantes" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                                <td style="width:30%">
                                                    <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="2" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="Mensualidad nueva" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel29" runat="server" Text="$30,000.00" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                            </tr>
                                             <tr>
                                                <td colspan="8">&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel30" runat="server" Text="Nuevo residual" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                                <td colspan="2">
                                                    <dx:ASPxLabel ID="ASPxLabel31" runat="server" Text="$100,000.00" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                            </tr>
                                        </table>


                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>


                            <dx:TabPage Name="tabMnto" Text="Reducción de mensualidad" ActiveTabStyle-Font-Size="Medium">
                                <ActiveTabStyle Font-Size="Medium"></ActiveTabStyle>
                                <ContentCollection>
                                    <dx:ContentControl runat="server">

                                        <table style="width: 60%">
                                             <tr>
                                                <td colspan="8">&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td >
                                                    <dx:ASPxLabel ID="ASPxLabel32" runat="server" Text="Mensualidades restantes" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                                <td style="width:20%">
                                                    <dx:ASPxLabel ID="ASPxLabel33" runat="server" Text="4" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel34" runat="server" Text="Mensualidad nueva" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel35" runat="server" Text="$15,000.00" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                            </tr>
                                             <tr>
                                                <td colspan="8">&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel36" runat="server" Text="Nuevo residual" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                                <td colspan="2">
                                                    <dx:ASPxLabel ID="ASPxLabel37" runat="server" Text="$150,000.00" Font-Size="medium" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                                </td>

                                            </tr>
                                             <tr>
                                                <td colspan="8">&nbsp;
                                                </td>
                                            </tr>
                                           
                                                </table>
                                         <table class="dxrpControl_Office2010Blue" style="width: 100%; border-collapse: initial; background-color: #E8F4F7">

                                            <tr>
                                                <td colspan="8" class="dxrpHeader_Office2010Blue dx-borderBox" style="width: 100%">
                                                    <dx:ASPxLabel ID="ASPxLabel119" runat="server" Text=" Reducir mensualidades" Font-Size="Medium" Width="100%" Style="text-align: left" Height="19px"></dx:ASPxLabel>
                                                </td>
                                            </tr>
                                             <tr>
                                                 <td>
                                                    <dx:ASPxLabel ID="ASPxLabel120" runat="server" Text="Pago" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel121" runat="server" Text="Capital" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel122" runat="server" Text="Intereses" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel123" runat="server" Text="IVA" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel124" runat="server" Text="Pago total con IVA" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel125" runat="server" Text="Saldo" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                            </tr>
                                             <tr>
                                                <td colspan="6">&nbsp;
                                                </td>
                                            </tr>
                                              <tr>
                                                 <td>
                                                    <dx:ASPxLabel ID="ASPxLabel38" runat="server" Text="45" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel39" runat="server" Text="$13,816.89" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel40" runat="server" Text="$10,000.00" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel41" runat="server" Text="$3,810.70" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel42" runat="server" Text="$15,000.00" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel43" runat="server" Text="$45,000.00" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                            </tr>
                                             <tr>
                                                <td colspan="6">&nbsp;
                                                </td>
                                            </tr>

                                              <tr>
                                                 <td>
                                                    <dx:ASPxLabel ID="ASPxLabel44" runat="server" Text="46" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel45" runat="server" Text="16,162.31" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel46" runat="server" Text="$7,654.58" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel47" runat="server" Text="$3,810.70" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel48" runat="server" Text="$15,000.00" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel49" runat="server" Text="$30,000.00" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                            </tr>
                                             <tr>
                                                <td colspan="6">&nbsp;
                                                </td>
                                            </tr>

                                              <tr>
                                                 <td>
                                                    <dx:ASPxLabel ID="ASPxLabel50" runat="server" Text="47" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel51" runat="server" Text="16,162.31" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel52" runat="server" Text="$7,654.58" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel53" runat="server" Text="$3,810.70" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel54" runat="server" Text="$15,000.00" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel55" runat="server" Text="$15,000.00" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                            </tr>
                                             <tr>
                                                <td colspan="6">&nbsp;
                                                </td>
                                            </tr>

                                              <tr>
                                                 <td>
                                                    <dx:ASPxLabel ID="ASPxLabel56" runat="server" Text="47" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel57" runat="server" Text="16,162.31" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel58" runat="server" Text="$7,654.58" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel59" runat="server" Text="$3,810.70" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel60" runat="server" Text="$15,000.00" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel61" runat="server" Text="$0.00" Font-Size="medium" Width="90%" Style="text-align: center"></dx:ASPxLabel>

                                                </td>
                                            </tr>
                                             <tr>
                                                <td colspan="6">&nbsp;
                                                </td>
                                            </tr>


                                            <tr>
                                                <td colspan="6">
                                                    <dx:ASPxButton ID="ASPxButton7" runat="server" Text="Aceptación"></dx:ASPxButton>
                                                </td>
                                            </tr>
                                        </table>


                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>



                        </TabPages>
                    </dx:ASPxPageControl>


                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>










    </form>


</body>
</html>
