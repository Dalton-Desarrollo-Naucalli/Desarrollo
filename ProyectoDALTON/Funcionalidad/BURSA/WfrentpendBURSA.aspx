<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WfrentpendBURSA.aspx.cs" Inherits="Funcionalidad_BURSA_WfrentpendBURSA" %>

<%@ Register Assembly="DevExpress.Data.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../../funcionesJS/FuncionesForms.js"></script>
    <script src="../../funcionesJS/BURSA.js"></script>
    <link href="../../Content/Ventanas.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery-3.1.1.min.js"></script>
    <link href="../../Content/jquery.toast.min.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.toast.min.js"></script>
    <title>Facturas de rentas pendientes con BURSA</title>
</head>
<body onload="load();" onkeypress="return pulsar(event)">
    <form id="form1" runat="server">


        <dx:ASPxRoundPanel ID="ASPxRoundPanel4" runat="server" ShowCollapseButton="True" ShowHeader="False" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <table class="auto-style40">
                        <tr>
                            <td class="auto-style4">
                                <dx:ASPxButton ID="btnAgregar" runat="server" ToolTip="Agregar" ClientInstanceName="btnAgregar" AutoPostBack="False" EnableClientSideAPI="true">
                                    <Image IconID="actions_add_32x32">
                                    </Image>
                                    <ClientSideEvents Click="function(s, e) {
	                                        OnNewRowClicked();
                                        }" />
                                </dx:ASPxButton>

                            </td>


                            <td class="auto-style4">
                                <dx:ASPxButton ID="btnEditar" runat="server" ToolTip="Editar" ClientInstanceName="btnEditar" AutoPostBack="False" EnableClientSideAPI="true">
                                    <Image IconID="edit_edit_32x32">
                                    </Image>
                                    <ClientSideEvents Click="function(s, e) {OnEditRowClicked();}" />
                                </dx:ASPxButton>

                            </td>


                            <td class="auto-style4">

                                <dx:ASPxButton ID="btnEliminar" runat="server" ToolTip="Eliminar" AutoPostBack="False" ClientInstanceName="btnEliminar" EnableClientSideAPI="True">
                                    <ClientSideEvents Click="function(s, e) {
	OnConfirmDeleteRowsClicked();
}" />
                                    <Image IconID="edit_delete_32x32">
                                    </Image>
                                </dx:ASPxButton>
                            </td>


                            <td class="auto-style4">
                                <dx:ASPxButton ID="btnCancelar" runat="server" AutoPostBack="False" ClientInstanceName="btnCancelar" ToolTip="Cancelar" EnableClientSideAPI="True">
                                    <ClientSideEvents Click="function(s, e) {OnDiscardChangesClicked();}" />
                                    <Image IconID="actions_cancel_32x32">
                                    </Image>
                                </dx:ASPxButton>

                            </td>


                            <td class="auto-style4">
                                <dx:ASPxButton ID="btnActualizar" runat="server" AutoPostBack="False" ClientInstanceName="btnActualizar" ToolTip="Actualizar" EnableClientSideAPI="true">
                                    <ClientSideEvents Click="function(s,e) {OnSaveChangesClicked();}" />
                                    <Image IconID="actions_apply_32x32">
                                    </Image>
                                </dx:ASPxButton>

                            </td>

                            <td class="auto-style4">
                                <dx:ASPxButton ID="btnFiltrar" runat="server" AutoPostBack="False" ClientInstanceName="btnFiltrar" ToolTip="Filtrar" EnableClientSideAPI="true">
                                    <ClientSideEvents Click="function(s, e) {OnFilterClicked();}" />
                                    <Image IconID="filter_filter_32x32">
                                    </Image>
                                </dx:ASPxButton>

                            </td>

                            <td class="auto-style4">
                                <dx:ASPxButton ID="btnBuscar" runat="server" AutoPostBack="False" ClientInstanceName="btnBuscar" ToolTip="Buscar" EnableClientSideAPI="true">
                                    <ClientSideEvents Click="function(s, e) {OnBuscar();}" />
                                    <Image IconID="find_find_32x32">
                                    </Image>
                                </dx:ASPxButton>

                            </td>


                        </tr>
                    </table>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>

        <br />

        <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" HeaderText="Búsqueda:" Font-Size="Medium" Font-Bold="false" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <table>
                        <tr>
                            <td style="width: 8%">
                                <dx:ASPxLabel ID="lbl_Cliente" runat="server" Text="Cliente " ForeColor="Black" Font-Size="Medium">
                                </dx:ASPxLabel>
                            </td>
                            <td style="width: 23%">
                                <dx:ASPxComboBox ID="cbxCliente" runat="server" AutoPostBack="false" ClientInstanceName="cbxCliente" EnableClientSideAPI="True" Width="100%" ForeColor="Black" Font-Size="Medium" ClientEnabled="true">
                                    <ClientSideEvents Init="function(s, e) {  OnInitClientes(); }"
                                        SelectedIndexChanged="function(s, e) {  CargaContratos(); CargaAnexos(); }" />
                                </dx:ASPxComboBox>
                            </td>
                            <td style="width: 2%">&nbsp;</td>
                            <td style="width: 10%">
                                <dx:ASPxLabel ID="lblNoContrato" runat="server" Text="Contrato " ForeColor="Black" Font-Size="Medium"></dx:ASPxLabel>
                            </td>
                            <td style="width: 25%">
                                <dx:ASPxComboBox ID="cmbNumeroContrato" runat="server" EnableClientSideAPI="True" ClientInstanceName="cmbNumeroContrato" ForeColor="Black" Font-Size="Medium" Width="100%" AutoPostBack="false" ClientEnabled="true">
                                    <%--<ClientSideEvents Init="function(s, e) {  OnInitContratos(); }"
                                        SelectedIndexChanged="function(s, e) {  CargaAnexos(); }" />--%>
                                </dx:ASPxComboBox>
                            </td>
                            <td style="width: 2%">&nbsp;</td>
                            <td style="width: 7%">
                                <dx:ASPxLabel ID="lblAnexocmb" runat="server" Text="Anexo " ForeColor="Black" Font-Size="Medium">
                                </dx:ASPxLabel>
                            </td>
                            <td style="width: 23%">
                                <dx:ASPxComboBox ID="cmbAnexo" runat="server" Width="100%" EnableClientSideAPI="True" ClientInstanceName="cmbAnexo" ForeColor="Black" Font-Size="Medium" AutoPostBack="false" ClientEnabled="true">
                                    <%--<ClientSideEvents Init="function(s, e) {  OnInitAnexos(); }"
                                        SelectedIndexChanged="function(s, e) {  CargaContratosAnex(); }" />--%>
                                </dx:ASPxComboBox>
                            </td>
                        </tr>
                    </table>



                    <%--<dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="idbanco" AutoGenerateColumns="False" TextFormatString="{0} | {1}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                          

                        </dx:ASPxGridLookup>--%>



                    <asp:Label ID="lblAccesos" runat="server" CssClass="GlobalTextoPanel" Visible="false"></asp:Label>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>

        <br />


        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Facturas de rentas pendientes con BURSA" Font-Size="Medium" ForeColor="Black" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">

                    <dx:ASPxPageControl ID="tsFacturasBURSA" runat="server" ActiveTabIndex="0" EnableTheming="True" Height="100%" Width="100%" ClientInstanceName="tsFacturasBURSA">
                        <TabPages>
                            <dx:TabPage Name="tabPendientesBursa" Text="Facturas Pendientes">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">

                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 100%">
                                                    <dx:ASPxCheckBox ID="cbxMuestraTodos" runat="server" ClientInstanceName="cbxMuestraTodos" EnableClientSideAPI="true" ValueType="System.Byte" ValueChecked="0" ValueUnchecked="1" CheckState="Unchecked" Text="Mostrar Rentas Adicionales"></dx:ASPxCheckBox>
                                                </td>
                                            </tr>
                                            <%--<tr>
                                                <td style="width: 15%">
                                                    <dx:ASPxLabel ID="lblCliente" ClientInstanceName="lblCliente" ForeColor="Black" Font-Size="Medium"
                                                        runat="server" Text="Cliente">
                                                    </dx:ASPxLabel>
                                                </td>
                                                <td style="width: 35%">
                                                    <dx:ASPxTextBox ID="txtCliente" ClientInstanceName="txtCliente" EnableClientSideAPI="true" ForeColor="Black" Font-Size="Medium"
                                                        MaxLength="100" runat="server" Width="80%" ClientEnabled="false">
                                                    </dx:ASPxTextBox>
                                                </td>
                                                <td style="width: 15%">
                                                    <dx:ASPxLabel ID="lblAnexo" ClientInstanceName="lblAnexo" ForeColor="Black" Font-Size="Medium"
                                                        runat="server" Text="Anexo">
                                                    </dx:ASPxLabel>
                                                </td>
                                                <td style="width: 35%">
                                                    <dx:ASPxTextBox ID="txtAnexo" ClientInstanceName="txtAnexo" EnableClientSideAPI="true" ForeColor="Black" Font-Size="Medium"
                                                        MaxLength="15" runat="server" Width="170px" ClientEnabled="false">
                                                    </dx:ASPxTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="width: 15%">
                                                    <dx:ASPxLabel ID="lblContrato" ClientInstanceName="lblContrato" ForeColor="Black" Font-Size="Medium"
                                                        runat="server" Text="Contrato">
                                                    </dx:ASPxLabel>
                                                </td>
                                                <td style="width: 35%">
                                                    <dx:ASPxTextBox ID="txtContrato" ClientInstanceName="txtContrato" EnableClientSideAPI="true" ForeColor="Black" Font-Size="Medium"
                                                        MaxLength="20" runat="server" Width="170px" ClientEnabled="false">
                                                    </dx:ASPxTextBox>
                                                </td>
                                                <td style="width: 15%">
                                                    <dx:ASPxLabel ID="lblNumeroContrato" ClientInstanceName="lblAnexo" ForeColor="Black" Font-Size="Medium"
                                                        runat="server" Text="Número de Contrato" ClientVisible="false">
                                                    </dx:ASPxLabel>
                                                </td>
                                                <td style="width: 35%">
                                                    <dx:ASPxTextBox ID="txtNumeroCredito" ClientInstanceName="txtNumeroCredito" EnableClientSideAPI="true" ForeColor="Black" Font-Size="Medium"
                                                        MaxLength="15" runat="server" Width="170px" ClientEnabled="false" ClientVisible="false">
                                                    </dx:ASPxTextBox>
                                                </td>

                                            </tr>--%>
                                            <tr>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dx:ASPxGridView ID="gv_FacRtasPend" runat="server" KeyFieldName="idcliente" AutoGenerateColumns="False" EnableTheming="True"
                                                        ClientInstanceName="gv_FacRtasPend" Width="100%" OnCustomCallback="gv_FacRtasPend_CustomCallback" OnCustomGroupDisplayText="gv_FacRtasPend_CustomGroupDisplayText">
                                                        <%--<SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true"></SettingsAdaptivity>--%>
                                                        <SettingsCommandButton>
                                                            <ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

                                                            <HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
                                                        </SettingsCommandButton>
                                                        <Settings ShowGroupPanel="True" />
                                                        <Settings ShowGroupFooter="Hidden" />
                                                        <ClientSideEvents
                                                            RowDblClick="function(s, e) { dobleclick(s, e); }" EndCallback="ResultadoConsulta" />
                                                        <SettingsPager Mode="ShowPager" PageSize="100"></SettingsPager>
                                                        <Settings ShowVerticalScrollBar="true" VerticalScrollableHeight="0" HorizontalScrollBarMode="Auto" ShowFooter="true" ShowGroupButtons="true" />
                                                        <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" AllowFixedGroups="true" />
                                                        <SettingsSearchPanel Visible="True" />
                                                        <Columns>
                                                            <%--<dx:GridViewCommandColumn Width="25" SelectAllCheckboxMode="Page" ShowClearFilterButton="True" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                                                            </dx:GridViewCommandColumn>--%>
                                                            <dx:GridViewDataTextColumn Width="200" Caption="idcliente" Name="idcliente" ShowInCustomizationForm="True" VisibleIndex="1" FieldName="idcliente" Visible="false">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Cliente" Name="nombreClienteCol" ShowInCustomizationForm="True" VisibleIndex="2" FieldName="nombreCliente" Width="200">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Contrato" Name="contratoCol" ShowInCustomizationForm="True" VisibleIndex="3" FieldName="contrato" Width="150">
                                                            </dx:GridViewDataTextColumn>

                                                            <dx:GridViewDataTextColumn Caption="Anexo" Name="anexoCol" ShowInCustomizationForm="True" VisibleIndex="4" FieldName="anexo" Width="150">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Credito" Name="idCreditoCol" ShowInCustomizationForm="True" VisibleIndex="5" FieldName="idCredito" Width="120" Visible="false">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Número de Obligación" Name="idObligacionCol" ShowInCustomizationForm="True" VisibleIndex="6" FieldName="idObligacion" Width="200">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Factura" Name="facturaCol" ShowInCustomizationForm="True" VisibleIndex="7" FieldName="factura" Width="150">
                                                            </dx:GridViewDataTextColumn>

                                                            <dx:GridViewDataTextColumn Caption="Fecha de Vencimiento" Name="fechaVencimientoCol" ShowInCustomizationForm="True" VisibleIndex="8" FieldName="fechaVencimiento" Width="150">
                                                                <PropertiesTextEdit DisplayFormatString="dd/MM/yyy"></PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Importe" Name="importeCol" ShowInCustomizationForm="True" VisibleIndex="9" FieldName="importe" Width="100" PropertiesTextEdit-DisplayFormatString="C2" CellStyle-HorizontalAlign="Right" HeaderStyle-Wrap="True">
                                                                <PropertiesTextEdit DisplayFormatString="C2"></PropertiesTextEdit>
                                                                <HeaderStyle Wrap="True"></HeaderStyle>
                                                                <CellStyle HorizontalAlign="Right"></CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Días de Vencimiento" Name="diasVencimientoCol" ShowInCustomizationForm="True" VisibleIndex="10" FieldName="diasVencidos" Width="120">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Total de Cuotas" Name="totalCuotasCol" ShowInCustomizationForm="True" VisibleIndex="11" FieldName="totalCuotas" Width="120">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Cuota" Name="cuotaCol" ShowInCustomizationForm="True" VisibleIndex="12" FieldName="cuota" Width="150">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataCheckColumn Caption="Facturas de " Name="sinvencerCol" ShowInCustomizationForm="True" VisibleIndex="13" FieldName="adicional" Width="150" GroupIndex="0">
                                                            </dx:GridViewDataCheckColumn>
                                                        </Columns>
                                                        <TotalSummary>
                                                            <dx:ASPxSummaryItem DisplayFormat="Total: {0:c2}" FieldName="importe" SummaryType="Sum" />

                                                        </TotalSummary>
                                                        
                                                    </dx:ASPxGridView>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&nbsp;</td>
                                            </tr>
                                            <%--<tr>
                                                <td>
                                                    <dx:ASPxLabel ID="lblTotal" ClientInstanceName="lblTotal" ForeColor="Black" Font-Size="Medium"
                                                        runat="server" Text="Total">
                                                    </dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="txtTotal" ClientInstanceName="txtTotal" EnableClientSideAPI="true" ForeColor="Black" Font-Size="Medium"
                                                        MaxLength="12" runat="server" Width="170px">
                                                    </dx:ASPxTextBox>
                                                </td>
                                                <td colspan="2">&nbsp;</td>
                                            </tr>--%>
                                        </table>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                            <dx:TabPage Name="tabSolTrasBURSA" Text="Solicitud de Traspaso BURSA" ClientEnabled="false">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 15%">
                                                    <dx:ASPxLabel ID="lblClienteTrasp" ClientInstanceName="lblClienteTrasp" ForeColor="Black" Font-Size="Medium"
                                                        runat="server" Text="Cliente">
                                                    </dx:ASPxLabel>
                                                </td>
                                                <td style="width: 35%">
                                                    <dx:ASPxTextBox ID="txtClienteTrasp" ClientInstanceName="txtClienteTrasp" EnableClientSideAPI="true" ForeColor="Black" Font-Size="Medium"
                                                        MaxLength="100" runat="server" Width="80%" ClientEnabled="false">
                                                    </dx:ASPxTextBox>
                                                </td>
                                                <td style="width: 15%">
                                                    <dx:ASPxLabel ID="lblAnexoTrasp" ClientInstanceName="lblAnexoTrasp" EnableClientSideAPI="true" ForeColor="Black" Font-Size="Medium"
                                                        runat="server" Text="Anexo">
                                                    </dx:ASPxLabel>
                                                </td>
                                                <td style="width: 35%">
                                                    <dx:ASPxTextBox ID="txtAnexoTrasp" ClientInstanceName="txtAnexoTrasp" EnableClientSideAPI="true" ForeColor="Black" Font-Size="Medium"
                                                        MaxLength="15" runat="server" Width="170px" ClientEnabled="false">
                                                    </dx:ASPxTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="lblContratoTrasp" ClientInstanceName="lblContratoTrasp" ForeColor="Black" Font-Size="Medium"
                                                        runat="server" Text="Contrato">
                                                    </dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="txtContratoTrasp" ClientInstanceName="txtContratoTrasp" EnableClientSideAPI="true" ForeColor="Black" Font-Size="Medium"
                                                        MaxLength="20" runat="server" Width="170px" ClientEnabled="false">
                                                    </dx:ASPxTextBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="lblNumObligación" ClientInstanceName="lblNumObligación" ForeColor="Black" Font-Size="Medium"
                                                        runat="server" Text="Num. Obligación">
                                                    </dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="txtNumObligación" ClientInstanceName="txtNumObligación" EnableClientSideAPI="true" ForeColor="Black" Font-Size="Medium"
                                                        MaxLength="25" runat="server" Width="170px" ClientEnabled="false">
                                                    </dx:ASPxTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="lblFechaVencimiento" ClientInstanceName="lblFechaVencimiento" ForeColor="Black" Font-Size="Medium"
                                                        runat="server" Text="Fecha vencimiento">
                                                    </dx:ASPxLabel>

                                                </td>
                                                <td>
                                                    <dx:ASPxDateEdit ID="dteFechaVencimiento" ClientInstanceName="dteFechaVencimiento" EnableClientSideAPI="true" runat="server" ForeColor="Black" Font-Size="Medium"
                                                        ClientEnabled="false">
                                                    </dx:ASPxDateEdit>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="lblFechaTraspaso" ClientInstanceName="lblFechaTraspaso" ForeColor="Black" Font-Size="Medium"
                                                        runat="server" Text="Fecha traspaso">
                                                    </dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxDateEdit ID="dteFechaTraspaso" ClientInstanceName="dteFechaTraspaso" EnableClientSideAPI="true" runat="server" ForeColor="Black" Font-Size="Medium"
                                                        ClientEnabled="false">
                                                    </dx:ASPxDateEdit>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="lbldiasvencimiento" ClientInstanceName="lbldiasvencimiento" ForeColor="Black" Font-Size="Medium"
                                                        runat="server" Text="Días vencimiento">
                                                    </dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="txtdiasvencimiento" ClientInstanceName="txtdiasvencimiento" EnableClientSideAPI="true" ForeColor="Black" Font-Size="Medium"
                                                        MaxLength="5" runat="server" Width="20%" ClientEnabled="false">
                                                    </dx:ASPxTextBox>
                                                </td>
                                                <td colspan="2">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td colspan="4">
                                                    <dx:ASPxGridView ID="gv_TraspasoBursa" runat="server" KeyFieldName="cred_id;obligacion_id" AutoGenerateColumns="False" EnableTheming="True"
                                                        ClientInstanceName="gv_TraspasoBursa" Width="100%" OnCustomCallback="gv_TraspasoBursa_CustomCallback">

                                                        <Settings />
                                                        <SettingsCommandButton>
                                                            <ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

                                                            <HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
                                                        </SettingsCommandButton>
                                                        <ClientSideEvents SelectionChanged="function(s, e) {
                                                                                                                OnSelectionChangedGvTraspasoBursa(s, e);
                                                                                                             }"
                                                            EndCallback="Mensajes" />
                                                        <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                                                        <Settings ShowVerticalScrollBar="true" VerticalScrollableHeight="0" HorizontalScrollBarMode="Auto" />
                                                        <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" AutoExpandAllGroups="true" />
                                                        <SettingsSearchPanel Visible="True" />
                                                        <Columns>
                                                            <dx:GridViewCommandColumn Width="25" SelectAllCheckboxMode="Page" ShowClearFilterButton="True" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                                            </dx:GridViewCommandColumn>
                                                            <dx:GridViewDataTextColumn Width="200" Caption="credid" Name="credidCol" ShowInCustomizationForm="True" VisibleIndex="1" FieldName="cred_id">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Fecha Crédito" Name="fechaCreditoCol" ShowInCustomizationForm="True" VisibleIndex="2" FieldName="fechaCredito" Width="150">
                                                                <PropertiesTextEdit DisplayFormatString="dd/MM/yyy"></PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="obligacionid" Name="obligacionidCol" ShowInCustomizationForm="True" VisibleIndex="3" FieldName="obligacion_id" Width="150">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Fecha Vencimiento" Name="fechaVencimientoCol" ShowInCustomizationForm="True" VisibleIndex="4" FieldName="fechaVencimiento" Width="150">
                                                                <PropertiesTextEdit DisplayFormatString="dd/MM/yyy"></PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Fecha Solicitud Traspaso" Name="fechaSolicitudTraspasoCol" ShowInCustomizationForm="True" VisibleIndex="5" FieldName="fechaSolicitudTraspaso" Width="150">
                                                                <PropertiesTextEdit DisplayFormatString="dd/MM/yyy"></PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Usuario Solicita" Name="usuarioSolicitudCol" ShowInCustomizationForm="True" VisibleIndex="6" FieldName="usuarioSolicitoTraspaso" Width="200">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Fecha Autorización Traspaso" Name="fechaAutorizacionTraspasoCol" ShowInCustomizationForm="True" VisibleIndex="7" FieldName="fechaAutorizacionTraspaso" Width="150">
                                                                <PropertiesTextEdit DisplayFormatString="dd/MM/yyy"></PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Usuario Autoriza" Name="usuarioAutorizaCol" ShowInCustomizationForm="True" VisibleIndex="8" FieldName="usuarioAutorizoTraspaso" Width="200">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Fecha Confirmación SET" Name="fechaConfirmacionSETCol" ShowInCustomizationForm="True" VisibleIndex="9" FieldName="fechaConfirmacionSET" Width="150">
                                                                <PropertiesTextEdit DisplayFormatString="dd/MM/yyy"></PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Número Movimiento SET" Name="numMovimientoSETCol" ShowInCustomizationForm="True" VisibleIndex="10" FieldName="numMovimientoSET" Width="200">
                                                            </dx:GridViewDataTextColumn>
                                                        </Columns>

                                                    </dx:ASPxGridView>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td colspan="4">&nbsp;</td>
                                            </tr>
                                        </table>
                                        <table style="width: 100%">
                                            <tr>
                                                <td style="width: 10%">
                                                    <dx:ASPxButton ID="btnSolicitud" runat="server" Text="Solicitar Autorización" ToolTip="Solicitud de Autorización" ClientEnabled="false" ClientInstanceName="btnSolicitud" EnableClientSideAPI="true" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s, e) {
	                                        cbSolicitar.PerformCallback();
                                        }" />
                                                        <Image IconID="reports_addgroupheader_32x32">
                                                        </Image>
                                                    </dx:ASPxButton>
                                                    <dx:ASPxCallback ID="cbSolicitar" runat="server" ClientInstanceName="cbSolicitar" OnCallback="cbSolicitar_Callback">
                                                        <ClientSideEvents EndCallback="MuestraMensajeAgregado" />
                                                    </dx:ASPxCallback>
                                                </td>

                                                <td style="width: 10%">
                                                    <dx:ASPxButton ID="btnAutorizar" runat="server" Text="Autorizar Traspaso" ToolTip="Autorizar Traspaso" ClientEnabled="false" ClientInstanceName="btnAutorizar" EnableClientSideAPI="true" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s, e) {
	                                        cbAutorizar.PerformCallback(arreGridTraspBursa);
                                        }" />
                                                        <Image IconID="businessobjects_botask_32x32">
                                                        </Image>
                                                    </dx:ASPxButton>
                                                    <dx:ASPxCallback ID="cbAutorizar" runat="server" ClientInstanceName="cbAutorizar" OnCallback="cbAutorizar_Callback">
                                                        <ClientSideEvents EndCallback="MuestraMensajeActualizado" />
                                                    </dx:ASPxCallback>
                                                </td>


                                                <td style="width: 10%">
                                                    <dx:ASPxButton ID="btnBajaFondeo" runat="server" Text="Baja de fondeo" ToolTip="Baja de Fondeo" ClientInstanceName="btnBajaFondeo" ClientEnabled="false" EnableClientSideAPI="true" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s, e) {
	                                        OnConfirmDeleteFondeo();
                                        }" />
                                                        <Image IconID="actions_trash_32x32">
                                                        </Image>
                                                    </dx:ASPxButton>
                                                </td>

                                                <td style="width: 70%" align="Right">
                                                    <dx:ASPxButton ID="btnRegresar" runat="server" Text="Regresar" ToolTip="Cancelar" ClientInstanceName="btnRegresar" EnableClientSideAPI="true" AutoPostBack="false">
                                                        <ClientSideEvents Click="function(s, e) {
	                                        OnRegresar();
                                        }" />
                                                        <Image IconID="actions_left_32x32">
                                                        </Image>
                                                    </dx:ASPxButton>

                                                </td>
                                            </tr>

                                        </table>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                            <dx:TabPage Name="tabRentasAdic" Text="Rentas Adicionales" ClientEnabled="false" ClientVisible="false">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <table style="width: 100%;">
                                            <tr>
                                                <td colspan="4">
                                                    <dx:ASPxGridView ID="gv_FacAdicionales" runat="server" KeyFieldName="idcliente" AutoGenerateColumns="False" EnableTheming="True"
                                                        ClientInstanceName="gv_FacAdicionales" Width="100%" OnCustomCallback="gv_FacAdicionales_CustomCallback" OnCustomColumnSort="gv_FacAdicionales_CustomColumnSort" OnCustomColumnGroup="gv_FacAdicionales_CustomColumnGroup" OnCustomGroupDisplayText="gv_FacAdicionales_CustomGroupDisplayText">
                                                        <%--<SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true"></SettingsAdaptivity>--%>
                                                        <SettingsCommandButton>
                                                            <ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>

                                                            <HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
                                                        </SettingsCommandButton>
                                                        <Settings />
                                                        <%--<GroupSummary>
                                                            <dx:ASPxSummaryItem DisplayFormat="Rentas" ValueDisplayFormat="Si" />
                                                        </GroupSummary>--%>
                                                        <ClientSideEvents
                                                            EndCallback="ResultadoConsultaAdicionales" />
                                                        <SettingsPager Mode="ShowPager" PageSize="100"></SettingsPager>
                                                        <Settings ShowVerticalScrollBar="true" VerticalScrollableHeight="0" HorizontalScrollBarMode="Auto" ShowFooter="true" />
                                                        <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" AutoExpandAllGroups="true" />
                                                        <SettingsSearchPanel Visible="True" />
                                                        <Columns>
                                                            <%--<dx:GridViewCommandColumn Width="25" SelectAllCheckboxMode="Page" ShowClearFilterButton="True" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                                                            </dx:GridViewCommandColumn>--%>
                                                            <dx:GridViewDataTextColumn Width="200" Caption="idcliente" Name="idcliente" ShowInCustomizationForm="True" VisibleIndex="1" FieldName="idcliente" Visible="false">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Cliente" Name="nombreClienteCol" ShowInCustomizationForm="True" VisibleIndex="2" FieldName="nombreCliente" Width="200">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Contrato" Name="contratoCol" ShowInCustomizationForm="True" VisibleIndex="3" FieldName="contrato" Width="150">
                                                            </dx:GridViewDataTextColumn>

                                                            <dx:GridViewDataTextColumn Caption="Anexo" Name="anexoCol" ShowInCustomizationForm="True" VisibleIndex="4" FieldName="anexo" Width="150">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Credito" Name="idCreditoCol" ShowInCustomizationForm="True" VisibleIndex="5" FieldName="idCredito" Width="120" Visible="false">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Número de Obligación" Name="idObligacionCol" ShowInCustomizationForm="True" VisibleIndex="6" FieldName="idObligacion" Width="200">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Factura" Name="facturaCol" ShowInCustomizationForm="True" VisibleIndex="7" FieldName="factura" Width="150">
                                                            </dx:GridViewDataTextColumn>

                                                            <dx:GridViewDataTextColumn Caption="Fecha de Vencimiento" Name="fechaVencimientoCol" ShowInCustomizationForm="True" VisibleIndex="8" FieldName="fechaVencimiento" Width="150">
                                                                <PropertiesTextEdit DisplayFormatString="dd/MM/yyy"></PropertiesTextEdit>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Importe" Name="importeCol" ShowInCustomizationForm="True" VisibleIndex="9" FieldName="importe" Width="100" PropertiesTextEdit-DisplayFormatString="C2" CellStyle-HorizontalAlign="Right" HeaderStyle-Wrap="True">
                                                                <PropertiesTextEdit DisplayFormatString="C2"></PropertiesTextEdit>
                                                                <HeaderStyle Wrap="True"></HeaderStyle>
                                                                <CellStyle HorizontalAlign="Right"></CellStyle>
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Días de Vencimiento" Name="diasVencimientoCol" ShowInCustomizationForm="True" VisibleIndex="10" FieldName="diasVencidos" Width="120">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Total de Cuotas" Name="totalCuotasCol" ShowInCustomizationForm="True" VisibleIndex="11" FieldName="totalCuotas" Width="120">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataTextColumn Caption="Cuota" Name="cuotaCol" ShowInCustomizationForm="True" VisibleIndex="12" FieldName="cuota" Width="150">
                                                            </dx:GridViewDataTextColumn>
                                                            <dx:GridViewDataCheckColumn Caption="Rentas Adicionales" Name="sinvencerCol" ShowInCustomizationForm="True" VisibleIndex="13" FieldName="adicional" Width="150">
                                                            </dx:GridViewDataCheckColumn>
                                                        </Columns>
                                                        <TotalSummary>
                                                            <dx:ASPxSummaryItem DisplayFormat="Total: {0:c2}" FieldName="importe" SummaryType="Sum" />

                                                        </TotalSummary>
                                                    </dx:ASPxGridView>
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


        <div>
        </div>
    </form>
</body>
</html>
