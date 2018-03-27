<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WfdevolucionesBURSA.aspx.cs" Inherits="Funcionalidad_BURSA_WfdevolucionesBURSA" %>

<%@ Register Assembly="DevExpress.Data.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../../funcionesJS/FuncionesForms.js"></script>
    <script src="../../funcionesJS/BursaDevoluciones.js"></script>
    <link href="../../Content/Ventanas.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery-3.1.1.min.js"></script>
    <link href="../../Content/jquery.toast.min.css" rel="stylesheet" type="text/css" />
    <script src="../../Scripts/jquery.toast.min.js"></script>
    <title>Devoluciones BURSA</title>
</head>
<body onload="load();" onkeypress="return pulsar(event)">
    <form id="form1" runat="server">
        <dx:ASPxRoundPanel ID="ASPxRoundPanel4" runat="server" ShowCollapseButton="True" ShowHeader="False" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <table class="auto-style40">
                        <tr>

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
        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Gestión de Devoluciones BURSA" Font-Size="Medium" ForeColor="Black" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 8%">
                                <dx:ASPxLabel ID="lblFechaCorte" ClientInstanceName="lblFechaCorte" Font-Size="Medium" ForeColor="Black"
                                    runat="server" Text="Fecha de corte:">
                                </dx:ASPxLabel>
                            </td>
                            <td style="width: 22%">
                                <dx:ASPxDateEdit ID="dteFechaCorte" runat="server" ClientInstanceName="dteFechaCorte" EnableClientSideAPI="true" Font-Size="Medium" ForeColor="Black" Date="2017-11-01" MaxDate="2017-11-01" MinDate="2017-05-01"></dx:ASPxDateEdit>
                            </td>

                            <td style="width: 8%">
                                <dx:ASPxLabel ID="lblCuentaBursa" ClientInstanceName="lblCuentaBursa" Font-Size="Medium" ForeColor="Black"
                                    runat="server" Text="Cuenta BURSA:">
                                </dx:ASPxLabel>
                            </td>
                            <td style="width: 22%">
                                <dx:ASPxTextBox ID="txtCuentaBursa" ClientInstanceName="txtCuentaBursa" EnableClientSideAPI="true" Font-Size="Medium" ForeColor="Black"
                                    MaxLength="15" runat="server" Width="170px">
                                </dx:ASPxTextBox>
                            </td>
                            <td style="width: 8%">
                                <dx:ASPxLabel ID="lblConsulCorAnt" ClientInstanceName="lblConsulCorAnt" Font-Size="Medium" ForeColor="Black"
                                    runat="server" Text="Consulta cortes anteriores:">
                                </dx:ASPxLabel>
                            </td>
                            <td style="width: 20%">
                                <dx:ASPxTextBox ID="txtConsulCorAnt" ClientInstanceName="txtConsulCorAnt" EnableClientSideAPI="true" Font-Size="Medium" ForeColor="Black"
                                    MaxLength="100" runat="server" Width="170px">
                                </dx:ASPxTextBox>
                            </td>
                            <td style="width: 12%">
                                <dx:ASPxButton ID="btnRechazados" runat="server" Text="Mostrar rechazados" ClientInstanceName="btnRechazados" EnableClientSideAPI="true">
                                    <Image IconID="spreadsheet_unfreezepanes_16x16">
                                    </Image>
                                </dx:ASPxButton>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="6">&nbsp;</td>
                            <td>
                                <asp:Label ID="lblAccesos" runat="server" CssClass="GlobalTextoPanel" Visible="false"></asp:Label></td>
                        </tr>
                        <tr>
                            <td colspan="7">
                                <dx:ASPxGridView ID="gv_DevolucionesBursa" runat="server" KeyFieldName="idIngreso" AutoGenerateColumns="True" EnableTheming="True"
                                    ClientInstanceName="gv_DevolucionesBursa" Width="100%" OnCustomCallback="gv_DevolucionesBursa_CustomCallback">
                                    <Settings />
                                    <SettingsCommandButton>
                                        <ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>
                                        <HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
                                    </SettingsCommandButton>

                                    <SettingsPager Mode="ShowPager" PageSize="50"></SettingsPager>
                                    <SettingsEditing Mode="Batch" BatchEditSettings-EditMode="Cell" NewItemRowPosition="Bottom">
                                        <BatchEditSettings StartEditAction="Click" ShowConfirmOnLosingChanges="false"></BatchEditSettings>
                                    </SettingsEditing>
                                    <Settings ShowVerticalScrollBar="true" VerticalScrollableHeight="0" HorizontalScrollBarMode="Auto" ShowFooter="true" />
                                    <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" AutoExpandAllGroups="true" />
                                    <SettingsSearchPanel Visible="True" />
                                    <Columns>
                                        <%--<dx:GridViewCommandColumn Width="25" SelectAllCheckboxMode="Page" ShowClearFilterButton="True" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                                                            </dx:GridViewCommandColumn>--%>
                                        <dx:GridViewDataTextColumn Width="200" Caption="Referencia" Name="referenciaIngresoCol" ShowInCustomizationForm="True" VisibleIndex="1" FieldName="idIngreso" Visible="true" ReadOnly="true">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Cuenta" Name="cuentaCol" ShowInCustomizationForm="True" VisibleIndex="2" FieldName="numeroCuenta" Width="200" ReadOnly="true">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Fecha Ingreso" Name="fechaIngresoCol" ShowInCustomizationForm="True" VisibleIndex="3" FieldName="fechaIngreso" Width="150" ReadOnly="true">
                                            <PropertiesTextEdit DisplayFormatString="dd/MM/yyy"></PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Crédito" Name="creditoCol" ShowInCustomizationForm="True" VisibleIndex="4" FieldName="cred_id" Width="150" ReadOnly="true" Visible="false">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Contrato" Name="contratoCol" ShowInCustomizationForm="True" VisibleIndex="5" FieldName="contrato" Width="150" ReadOnly="true">
                                        </dx:GridViewDataTextColumn>

                                        <dx:GridViewDataTextColumn Caption="Anexo" Name="anexoCol" ShowInCustomizationForm="True" VisibleIndex="6" FieldName="anexo" Width="150" ReadOnly="true">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Factura" Name="facturaCol" ShowInCustomizationForm="True" VisibleIndex="7" FieldName="fac_id" Width="150" ReadOnly="true">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Ingreso" Name="ingresoCol" ShowInCustomizationForm="True" VisibleIndex="8" FieldName="importeIngreso" Width="150" PropertiesTextEdit-DisplayFormatString="C2" CellStyle-HorizontalAlign="Right" HeaderStyle-Wrap="True" ReadOnly="true">
                                            <PropertiesTextEdit DisplayFormatString="C2"></PropertiesTextEdit>
                                            <HeaderStyle Wrap="True"></HeaderStyle>
                                            <CellStyle HorizontalAlign="Right"></CellStyle>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Propio de Bursa" Name="propioBursaCol" ShowInCustomizationForm="True" VisibleIndex="9" FieldName="importeBursa" Width="150" PropertiesTextEdit-DisplayFormatString="C2" CellStyle-HorizontalAlign="Right" HeaderStyle-Wrap="True" ReadOnly="true">
                                            <PropertiesTextEdit DisplayFormatString="C2"></PropertiesTextEdit>
                                            <HeaderStyle Wrap="True"></HeaderStyle>
                                            <CellStyle HorizontalAlign="Right"></CellStyle>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Devolución" Name="devolucionCol" ShowInCustomizationForm="True" VisibleIndex="10" FieldName="devolucion" Width="150" PropertiesTextEdit-DisplayFormatString="C2" CellStyle-HorizontalAlign="Right" HeaderStyle-Wrap="True" ReadOnly="true">
                                            <PropertiesTextEdit DisplayFormatString="C2"></PropertiesTextEdit>
                                            <HeaderStyle Wrap="True"></HeaderStyle>
                                            <CellStyle HorizontalAlign="Right"></CellStyle>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Concepto" Name="conceptoCol" ShowInCustomizationForm="True" VisibleIndex="11" FieldName="idConcDevolucion" Width="120" ReadOnly="true">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Clave de devolución" Name="claveDevolucionCol" ShowInCustomizationForm="True" VisibleIndex="12" FieldName="idTipoDevolucion" Width="120" ReadOnly="true">
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataTextColumn Caption="Observaciones" Name="observacionesCol" ShowInCustomizationForm="True" VisibleIndex="13" Width="120">
                                            <PropertiesTextEdit ClientInstanceName="ObservacionGrid" EnableClientSideAPI="True" MaxLength="50">
                                                
                                            </PropertiesTextEdit>
                                        </dx:GridViewDataTextColumn>
                                        <dx:GridViewDataCheckColumn Caption="No incluir" Name="noIncluirCol" ShowInCustomizationForm="True" VisibleIndex="14" Width="120">
                                        </dx:GridViewDataCheckColumn>
                                        <dx:GridViewDataCheckColumn Caption="Rechazado" Name="rechazadoCol" ShowInCustomizationForm="True" VisibleIndex="15" Width="120">
                                        </dx:GridViewDataCheckColumn>

                                    </Columns>
                                    <TotalSummary>
                                        <dx:ASPxSummaryItem DisplayFormat="Total Ingreso: {0:c2}" FieldName="importeIngreso" SummaryType="Sum" />
                                        <dx:ASPxSummaryItem DisplayFormat="Total Bursa: {0:c2}" FieldName="importeBursa" SummaryType="Sum" />
                                        <dx:ASPxSummaryItem DisplayFormat="Total Devolución: {0:c2}" FieldName="devolucion" SummaryType="Sum" />

                                    </TotalSummary>
                                </dx:ASPxGridView>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="7">&nbsp;</td>
                        </tr>
                        <%--<tr>
                            <td>
                                <dx:ASPxLabel ID="lblTotal" ClientInstanceName="lblTotal" ForeColor="Black" Font-Size="Medium"
                                    runat="server" Text="Total:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="txtTotal" ClientInstanceName="txtTotal" ForeColor="Black" Font-Size="Medium"
                                    MaxLength="15" runat="server" Width="170px">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxLabel ID="lblTotalAclara" ClientInstanceName="lblTotalAclara" ForeColor="Black" Font-Size="Medium"
                                    runat="server" Text="Total en aclaración:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="txtTotalAclara" ClientInstanceName="txtTotalAclara" ForeColor="Black" Font-Size="Medium"
                                    MaxLength="15" runat="server" Width="170px">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxLabel ID="lblTotalAceptado" ClientInstanceName="lblTotalAceptado" ForeColor="Black" Font-Size="Medium"
                                    runat="server" Text="Total aceptado:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxTextBox ID="txtTotalAceptado" ClientInstanceName="txtTotalAceptado" ForeColor="Black" Font-Size="Medium"
                                    MaxLength="15" runat="server" Width="170px">
                                </dx:ASPxTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 4px;"></td>
                        </tr>--%>

                        <tr>
                            <td style="width: 40%" colspan="2">&nbsp;</td>
                            <td style="width: 5%" align="center">
                                <dx:ASPxButton ID="btnConfirmar" runat="server" Text="Confirmar" ClientInstanceName="btnConfirmar" EnableClientSideAPI="true">
                                    <Image IconID="toolboxitems_checkbox2_32x32">
                                    </Image>
                                </dx:ASPxButton>

                            </td>
                            <td style="width: 5%" align="center">
                                <dx:ASPxButton ID="btnGenerarArch" runat="server" Text="Generar archivo" ClientInstanceName="btnGenerarArch" EnableClientSideAPI="true">
                                    <Image IconID="export_export_32x32">
                                    </Image>
                                </dx:ASPxButton>
                            </td>
                            <td style="width: 5%" align="center">

                                <dx:ASPxButton ID="btnEmitirReporte" runat="server" Text="Emitir reporte" ClientInstanceName="btnEmitirReporte" EnableClientSideAPI="true">
                                    <Image IconID="reports_groupheader_32x32">
                                    </Image>

                                </dx:ASPxButton>
                            </td>
                            <td style="width: 45%" colspan="2">&nbsp;</td>
                        </tr>

                    </table>






                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>


        <div>
        </div>
    </form>
</body>
</html>
