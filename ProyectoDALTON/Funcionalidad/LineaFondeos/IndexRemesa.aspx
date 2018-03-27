<%@ Page Language="VB" AutoEventWireup="false" CodeFile="IndexRemesa.aspx.vb" Inherits="Funcionalidad_LineaFondeos_IndexRemesa" %>

<%@ Register assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script  type="text/javascript">

        function selectRemesa(s,e)
        {
            row = e.visibleIndex;
            remesasgrid.GetRowValues(row, 'idRemesa', cargaDetalleremesaCB);
        }

        function cargaDetalleremesaCB(values)
        {

           
            remesasdetailgrid.PerformCallback("cargaremesadetail|" + values);

            PageRemesas.GetTabByName("tabDetalleRemesa").SetEnabled(true);
            PageRemesas.SetActiveTabIndex(1);
            txt_NoRemesa.SetText(String(values));
        }

     

    </script>
    <style type="text/css">
        .auto-style1 {
            height: 26px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowHeader="False" Theme="Office2003Blue" Width="200px">
            <PanelCollection>
<dx:PanelContent runat="server">
    <dx:ASPxPageControl ID="PageRemesas" runat="server" ActiveTabIndex="0" ClientInstanceName="PageRemesas" Theme="Aqua" Width="1024px">
        <TabPages>
            <dx:TabPage Name="tabListRemesas" Text="Listado de Remesas">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <dx:ASPxGridView ID="remesasgrid" runat="server" AutoGenerateColumns="False" ClientInstanceName="remesasgrid" EnableTheming="True" KeyFieldName="idRemesa" Theme="Aqua" Width="1024px">
                            <ClientSideEvents RowDblClick="function(s, e) { selectRemesa(s,e);
}" EndCallback="function(s, e) {}" />
                            <SettingsPager Visible="False">
                            </SettingsPager>
                            <Settings GridLines="Horizontal" HorizontalScrollBarMode="Auto" ShowHeaderFilterBlankItems="False" />
                            <SettingsBehavior AllowSelectByRowClick="True" />
                            <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                            <Columns>
                                <dx:GridViewDataTextColumn Caption="No Remesa" FieldName="idRemesa" ShowInCustomizationForm="True" VisibleIndex="0">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Id Fondo Banco" FieldName="cvefonbco" ShowInCustomizationForm="True" VisibleIndex="1">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Contratos en Remesa" FieldName="cantidadContratos" ShowInCustomizationForm="True" VisibleIndex="2">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Importe Aforo" FieldName="importeAforo" ShowInCustomizationForm="True" VisibleIndex="3">
                                    <PropertiesTextEdit DisplayFormatString="N2">
                                    </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Contratos Autorizados" FieldName="autorizados" ShowInCustomizationForm="True" VisibleIndex="4">
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Importe Autorizado" FieldName="importeAutorizado" ShowInCustomizationForm="True" VisibleIndex="5">
                                    <PropertiesTextEdit DisplayFormatString="N2">
                                    </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                                <dx:GridViewDataTextColumn Caption="Fecha Envio Remesa" FieldName="fechaEnvioRemesa" ShowInCustomizationForm="True" VisibleIndex="6">
                                    <PropertiesTextEdit DisplayFormatString="MM/dd/yyyy">
                                    </PropertiesTextEdit>
                                </dx:GridViewDataTextColumn>
                            </Columns>
                            <BorderLeft BorderStyle="None" />
                            <BorderRight BorderStyle="None" />
                        </dx:ASPxGridView>
                    </dx:ContentControl>
                </ContentCollection>
            </dx:TabPage>
            <dx:TabPage Name="tabDetalleRemesa" Text="Detalle Remesas">
                <ContentCollection>
                    <dx:ContentControl runat="server">
                        <table style="width: auto">
                            <tr>
                                <td style="text-align: right">
                                    <dx:ASPxLabel ID="ASPxLabel3" runat="server" EnableTheming="True" Text="No. Remesa" Theme="Aqua">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txt_NoRemesa" runat="server" Theme="Aqua" Width="170px" ClientInstanceName="txt_NoRemesa" EnableClientSideAPI="True">
                                    </dx:ASPxTextBox>
                                </td>
                                <td style="text-align: right">
                                    <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Fondeo" Theme="Aqua">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextBox4" runat="server" ReadOnly="True" Theme="Aqua" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Contratos en Remesa" Theme="Aqua">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txt_qtyContracts" runat="server" Theme="Aqua" Width="170px" ClientInstanceName="txt_qtyContracts">
                                    </dx:ASPxTextBox>
                                </td>
                                <td style="text-align: right">
                                    <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Importe Aforo">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextBox6" runat="server" ReadOnly="True" Theme="Aqua" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right">
                                    <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="Fecha Envío Remesa">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextBox7" runat="server" ReadOnly="True" Theme="Aqua" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                                <td style="text-align: right">
                                    <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="Importe Autorizado">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextBox8" runat="server" ReadOnly="True" Theme="Aqua" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td class="auto-style1" style="text-align: right">
                                    <dx:ASPxLabel ID="ASPxLabel1" runat="server" ClientInstanceName="txtAutorizedAmount" Text="Monto Autorizado:" Theme="Aqua">
                                        <BackgroundImage HorizontalPosition="right" Repeat="NoRepeat" />
                                    </dx:ASPxLabel>
                                </td>
                                <td class="auto-style1">
                                    <dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                                <td class="auto-style1">
                                    <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Fecha Autorización:">
                                    </dx:ASPxLabel>
                                </td>
                                <td class="auto-style1">
                                    <dx:ASPxTextBox ID="ASPxTextBox2" runat="server" Width="170px">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Descartar Contratos" Theme="Aqua">
                                        <Image IconID="reports_deletegroupheader_16x16">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                                <td colspan="2">
                                    <dx:ASPxButton ID="ASPxButton1" runat="server" HorizontalAlign="Right" ImagePosition="Right" Text="Generar Archivos" Theme="Aqua">
                                        <Image IconID="actions_sortbyinvoice_16x16devav">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="4">
                                    <dx:ASPxGridView ID="remesasdetailgrid" runat="server" AutoGenerateColumns="False" ClientInstanceName="remesasdetailgrid" Theme="Aqua" Width="1024px">
                                        <SettingsPager Visible="False">
                                        </SettingsPager>
                                        <Settings GridLines="Horizontal" />
                                        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                        <Columns>
                                            <dx:GridViewDataTextColumn Caption="No. credito" FieldName="cred_id" Name="cred_id" ShowInCustomizationForm="True" VisibleIndex="1">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="contrato" FieldName="contrato" Name="contrato" ShowInCustomizationForm="True" VisibleIndex="2">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Anexo" FieldName="anexo" Name="anexo" ShowInCustomizationForm="True" VisibleIndex="3">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Fecha Solicitud" FieldName="fechasolicitud" Name="fechasolicitud" ShowInCustomizationForm="True" VisibleIndex="4">
                                                <PropertiesTextEdit DisplayFormatString="MM/dd/yyyy">
                                                </PropertiesTextEdit>
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Unidad" FieldName="descripcionUnidad" Name="descripcionunidad" ShowInCustomizationForm="True" VisibleIndex="5">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="Modelo" FieldName="modelo" Name="modelo" ShowInCustomizationForm="True" VisibleIndex="6">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewDataTextColumn Caption="VIN" FieldName="VIN" Name="vin" ShowInCustomizationForm="True" VisibleIndex="7">
                                            </dx:GridViewDataTextColumn>
                                            <dx:GridViewCommandColumn Caption="Seleccionar" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                            </dx:GridViewCommandColumn>
                                        </Columns>
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
    </form>
</body>
</html>
