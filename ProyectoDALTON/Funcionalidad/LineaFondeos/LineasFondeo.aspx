<%@ Page Language="VB" AutoEventWireup="false" CodeFile="LineasFondeo.aspx.vb" Inherits="Funcionalidad_LineaFondeos_LineasFondeo" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register TagPrefix="uc" TagName="HerramientasDalton"  Src="~/UserControl/HerramientasDalton.ascx"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="EN">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script type ="text/javascript" >
    var bandera = 0;

    function load()
    {
        
    }

    function CambiaTab(s, e) {
        
        var tab = e.tab.GetText()
       
        if (tab == "Lineas de Fondeo")
        {
         
            tsFondeadoras.SetActiveTabIndex(0)
            
        }
        else if (tab == "Detalle de Fondeo")
        {
        
            tsFondeadoras.SetActiveTabIndex(1)
        }
    }

    function HabilitarBotonesDefault() {
       
        btnAgregar.SetEnabled(true);
        btnEditar.SetEnabled(false);
        btnEliminar.SetEnabled(false);
        btnCancelar.SetEnabled(false);
        btnAplicar.SetEnabled(false);
      
        tsFondeadoras.SetActiveTabIndex(0);
    }


   


        function GetDetalleFondeo_gv_LineasFondeoCallback(values) {
     
       
        if (values != " ") {

            btnAgregar.SetEnabled(false);
            btnEditar.SetEnabled(false);
            btnEliminar.SetEnabled(false);
            btnCancelar.SetEnabled(true);
            btnAplicar.SetEnabled(true);
            bandera = 1;

            
          
            if (String(values[1]) == "0") {
                gv_DetalleFondeo.PerformCallback("CargaDetalleFondeo|" + values[0]);
                tsFondeadoras.GetTabByName("tabDetalleFondeo").SetEnabled(true);
                tsFondeadoras.SetActiveTabIndex(1);
            }
            else {
                alert('El aforo esta próximo a vencer, No se puede seleccionar');
            }
        }
    }
       
    function callDetalleFondeo(s,e)
    {
           
           
        rowIndex = e.visibleIndex;              
        gv_LineasFondeo.GetRowValues(rowIndex, 'cvefonbco;AlertVence', GetDetalleFondeo_gv_LineasFondeoCallback);
    }
    function GetInfoLF(values)
    {
        txtIdParamLF.SetValue(String(values[0]));
        AforoActual.SetValue(String(values[1]));
        gv_EnGarantia.PerformCallback("CargaContratos|" + values);
        gv_EnReemplazo.PerformCallback("CargaContratos|" + values);

        
        tsFondeadoras.GetTabByName("tabCreditos").SetEnabled(true);

        tsFondeadoras.SetActiveTabIndex(2);

    }

    function callfmrParametros(s,e)
    {
        row = e.visibleIndex;
        gv_AnexosGarantia.GetRowValues(row, 'MesVence', GetInfoAnexo);


    }
    function GetInfoAnexo(values)
    {
        GridAnexoDetalle.PerformCallback("DetalleAnexos|" + values);
        tsFondeadoras.GetTabByName("AnexosDetalle").SetEnabled(true);

        tsFondeadoras.SetActiveTabIndex(3);
    }

        function callControlAforo(s,e)
        {
           
            row = e.visibleIndex;
            gv_DetalleFondeo.GetRowValues(row, 'cvefonbco;aforoactual', GetInfoLF);
           
        }

        function ClosepnlCtrolAforo(s)
        {
            pnlCtrolAforo.Modal = false;
          
            this.pnlCtrolAforo.CloseAction = "CloseButton";
        }

        function CallContratosbyLF()
        {


        }
        function getgridvalue(s,e)
        {
           
            row = e.visibleIndex;
            gv_EnGarantia.GetRowValues(row, 'cred_id;contrato;aforocalc', Getfieldchecked);
        }

        function Getfieldchecked(selectedValues) {

            var a = 0;
            var SumaAforo = 0;
            if (ListGarantiaSel.GetItemCount() > 0) {
                for (i = 0; i <= ListGarantiaSel.GetItemCount() - 1; i++) {
                    var itemver = ListGarantiaSel.GetItem(i);
                    if (itemver.text == String(selectedValues[0])) {
                        a = a + 1;
                        ListGarantiaSel.BeginUpdate();
                        ListGarantiaSel.RemoveItem(i);
                        ListGarantiaSel.EndUpdate();


                        if (isNaN(parseFloat(AforoCalculado.GetValue()))) {
                            SumaAforo = 0;
                        }
                        else {
                            SumaAforo = parseFloat(AforoCalculado.GetValue());
                        }

                        SumaAforo = parseFloat(SumaAforo) - parseFloat(selectedValues[2]);
                    }
                }
            }
            if (a == 0) {

                ListGarantiaSel.BeginUpdate();
                ListGarantiaSel.AddItem(String(selectedValues[0]), selectedValues[1]);
                ListGarantiaSel.EndUpdate();

                
                if (isNaN(parseFloat(AforoCalculado.GetValue()))) {
                    SumaAforo = 0;
                }
                else {
                    SumaAforo = parseFloat(AforoCalculado.GetValue());
                }

                SumaAforo = parseFloat(SumaAforo) + parseFloat(selectedValues[2]);
               
            }

            AforoCalculado.SetText(String(SumaAforo.toFixed(2)));

        }

        function getgridcontract(s, e) {

            row = e.visibleIndex;
            gv_ContratosxCeder.GetRowValues(row, 'cred_id;contrato', Getcontractchecked);
        }

        function Getcontractchecked(selectedValues) {
            ListContGar.BeginUpdate();
            ListContGar.AddItem(String(selectedValues[0]), selectedValues[1]);
            ListContGar.EndUpdate();
        }


        function getgridReemplazo(s,e) {

            row = e.visibleIndex;
            gv_EnReemplazo.GetRowValues(row, 'cred_id;contrato', GetReemplazochecked);
        }

        function GetReemplazochecked(selectedValues) {
            ListReemplazoSel.BeginUpdate();
            ListReemplazoSel.AddItem(String(selectedValues[0]), selectedValues[1]);
            ListReemplazoSel.EndUpdate();

        }

        function getcontractsLF(s,e)
        {
            rowIndex = e.visibleIndex;
            gv_LineasFondeo.GetRowValues(rowIndex, 'cvefonbco', GetContracts_LF);
        }
        function GetContracts_LF(values)
        {
            gv_AnexosGarantia.PerformCallback("CargaAnexosG|" + values);
            gv_ContratosxCeder.PerformCallback("CargaAnexosC|" + values);
            txt_ParamLFid.SetValue(values);
            txt_ParamLFid.SetText(values);
        }



</script>
    <style type="text/css">
        .auto-style5 {
            width: 21px;
        }
        .auto-style6 {
            width: 55px;
        }
        .dxgvControl_Aqua,
.dxgvDisabled_Aqua
{
	border: 1px Solid #A3C0E8;
	font: 12px Tahoma, Geneva, sans-serif;
	background-color: #FFFFFF;
	color: #4F4F4F;
	cursor: default;
}

.dxgvSearchPanel_Aqua
{
    border-bottom: 1px solid #A3C0E8;
	background: #ECF4FE;
	padding: 10px 4px 10px 6px;
}
.dxgvTable_Aqua
{
	-webkit-tap-highlight-color: rgba(0,0,0,0);
}

.dxgvTable_Aqua
{
	background-color: #FFFFFF;
	border-width: 0;
	border-collapse: separate!important;
	overflow: hidden;
}
.dxgvHeader_Aqua
{
	cursor: pointer;
	white-space: nowrap;
	padding: 5px;
	border: 1px Solid #A3C0E8;
	background: #E2F0FF repeat-x top;
	overflow: hidden;
	font-weight: normal;
	text-align: left;
}

.dxgvTable_Aqua .dxgvHEC
{
	background-color: #FFFFFF;
	border-width: 0;
	overflow: hidden;
}
.dxgvCommandColumn_Aqua
{
	padding: 2px 0px 2px 2px;
    white-space: nowrap;
}
.dxgvFooter_Aqua
{
	background-color: #EEF3FF;
	white-space: nowrap;
}
        </style>
    </head>
<body>
    <form id="form1" runat="server">
      <div>
            <uc:HerramientasDalton id="HerramientasDalton" runat="server"/>
        </div>
        <div>
        <table style="height: 100%; width: 100%;">
                <tr>
                    <td style="vertical-align: top; height: 100%;" width="1024px">
                        <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" Height="425px" ShowCollapseButton="True" ShowHeader="False" Theme="Office2003Blue" Width="1024px" ClientInstanceName="ASPxRoundPanel2" style="margin-bottom: 5px">
                         <PanelCollection>
                                <dx:PanelContent runat="server">
                                    <dx:ASPxPageControl ID="tsFondeadoras" runat="server" ActiveTabIndex="0" AutoPostBack ="false"  EnableCallBacks ="false" EnableClientSideAPI ="true" EnableTheming="True" Theme="Office2010Blue" Height="100%" Width="1024px" ClientInstanceName="tsFondeadoras" >
                                        <TabPages>
                                            <dx:TabPage Name="tabParam" Text="Lineas de Fondeo">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                          <table width="1024px">
                                                              <tr>
                                                                  <td>
                                                        <dx:ASPxGridView ID="gv_LineasFondeo" ClientInstanceName="gv_LineasFondeo" EnableCallBacks="true" ViewStateMode="Enabled" runat="server" KeyFieldName="cvefonbco" AutoGenerateColumns="False" EnableTheming="True" Theme="Aqua" Width="100%" OnCustomCallback="gv_LineasFondeo_CustomCallback" >
                                                               <ClientSideEvents RowDblClick ="function(s, e) { callDetalleFondeo(s,e); }" RowClick="function(s, e) {
getcontractsLF(s,e);
}" />  
                                                                                <Settings ShowFilterRowMenu="false" HorizontalScrollBarMode="Auto" VerticalScrollBarMode="Visible" ShowFooter="true" VerticalScrollableHeight="200" GridLines="Horizontal" VerticalScrollBarStyle="Standard" />
                                                                                <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true"></SettingsAdaptivity>
                                                                                <SettingsCommandButton>
                                                                                    <ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>
                                                                                    <HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
                                                                                </SettingsCommandButton>
                                                                                <SettingsSearchPanel Visible="True" />
                                                                                   <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" AutoExpandAllGroups="true" />
                                                                                <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                                                                                <Columns>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn  Caption="Clave Fondo/Banco" Name="cvefonbco" FixedStyle="Left" ShowInCustomizationForm="True" VisibleIndex="0" FieldName="cvefonbco"></dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="Nombre Fondo" Visible="true" Name="nombre" ShowInCustomizationForm="True" VisibleIndex="1" FieldName="nombre"></dx:GridViewDataTextColumn>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn Caption="Monto Autorizado" Name="MontoAutorizado" Width="120" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" Visible="true" VisibleIndex="2" FieldName="MontoAutorizado">
                                                                                        <PropertiesTextEdit DisplayFormatString="N2">
                                                                                        </PropertiesTextEdit>
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle></dx:GridViewDataTextColumn>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn Caption="Aforo Requerido" Name="AforoContractual" Width="120" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" Visible="true" VisibleIndex="3" FieldName="AforoContractual">
                                                                                        <PropertiesTextEdit DisplayFormatString="N2">
                                                                                        </PropertiesTextEdit>
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle></dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="Fecha Vencimiento" Width="120" Name="FechaVencimiento" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" VisibleIndex="6" FieldName="FechaVencimiento">
                                                                                        <PropertiesTextEdit DisplayFormatString="MM/dd/yyyy">
                                                                                        </PropertiesTextEdit>
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle></dx:GridViewDataTextColumn>
                                                                                    
                                                                                    
                                                                                     <dx:GridViewDataTextColumn Caption="Tasa %" Name="Tasa" Width="120" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" VisibleIndex="7" FieldName="Tasa">
                                                                                       <%--  <PropertiesTextEdit DisplayFormatString="C2"></PropertiesTextEdit>--%>
                                                                                         <PropertiesTextEdit DisplayFormatString="N">
                                                                                         </PropertiesTextEdit>
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle>
                                                                                    </dx:GridViewDataTextColumn>

                                                                                     
                                                                                    
                                                                                    <dx:GridViewDataTextColumn Caption="Saldo Actual" FieldName="SaldoActual" Name="SaldoActual" ShowInCustomizationForm="True" VisibleIndex="4">
                                                                                        <PropertiesTextEdit DisplayFormatString="N2">
                                                                                        </PropertiesTextEdit>
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    <dx:GridViewDataTextColumn Caption="Disponible" FieldName="Disponible" Name="Disponible" ShowInCustomizationForm="True" VisibleIndex="5">
                                                                                        <PropertiesTextEdit DisplayFormatString="N2">
                                                                                        </PropertiesTextEdit>
                                                                                    </dx:GridViewDataTextColumn>

                                                                                     
                                                                                    
                                                                                    <dx:GridViewDataTextColumn Caption="Alerta" FieldName="AlertVence" Name="AlertVence" ShowInCustomizationForm="True" Visible="False" VisibleIndex="8">
                                                                                    </dx:GridViewDataTextColumn>

                                                                                     
                                                                                    
                                                                                </Columns>
                                                                          
                                                                            </dx:ASPxGridView>     
                                                        </td>
                                                        </tr>
                                                               <tr>       
                                                                   <td>                                
                                                 <%--   ++++++++++++++++++++--%>
                                                        <dx:ASPxGridView ID="gv_AnexosGarantia" ClientInstanceName="gv_AnexosGarantia" EnableCallBacks="true" ViewStateMode="Enabled" runat="server" KeyFieldName="MesVence" AutoGenerateColumns="False" EnableTheming="True" Theme="Aqua" Width="1024px" AccessibilityCompliant="True" Caption="Anexos en Garantia"  >   <%--OnCustomCallback="gv_AnexosGarantia_CustomCallback"  OnHtmlDataCellPrepared="gv_LineaFondeo_HtmlDataCellPrepared"--%>
                                                            <%--callfmrParametros--%>
                                                                                <SettingsCommandButton>
                                                                                    <ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>
                                                                                    <HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
                                                                                </SettingsCommandButton>
                                                                                <%--<SettingsBehavior AllowSelectByRowClick="false"  AllowFocusedRow="True" AllowSort="false"/>--%>
                                                               <ClientSideEvents RowDblClick ="function(s, e) { callfmrParametros(s,e); }" />   
                                                                                <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true"></SettingsAdaptivity>
                                                                                <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                                                                                <Settings ShowFilterRowMenu="false" HorizontalScrollBarMode="Auto" VerticalScrollBarMode="Visible" ShowFooter="true" VerticalScrollableHeight="200" GridLines="Horizontal" VerticalScrollBarStyle="Standard" />
                                                                                <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" AutoExpandAllGroups="true" />
                                                                                <SettingsSearchPanel Visible="True" />
                                                                                <Columns>
                                                                                    <dx:GridViewDataTextColumn  Caption="Mes Vencimiento" Visible="true" Name="MesVence" FixedStyle="Left" ShowInCustomizationForm="True" VisibleIndex="0" FieldName="MesVence" Width="20%">
                                                                                        <Settings AllowSort="False" />
                                                                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                                        <CellStyle HorizontalAlign="Center" VerticalAlign="Middle">
                                                                                        </CellStyle>
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn  Caption="no. anexos" Visible="true" Name="NoCreditos" FixedStyle="Left" ShowInCustomizationForm="True" VisibleIndex="1" FieldName="NoCreditos" Width="20%">
                                                                                        <Settings AllowSort="False" />
                                                                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                                        <CellStyle HorizontalAlign="Center" VerticalAlign="Middle">
                                                                                        </CellStyle>
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="Valor Fondeo Original" Visible="true" Name="AforoO" ShowInCustomizationForm="True" VisibleIndex="3" FieldName="AforoO" Width="20%">
                                                                                        <PropertiesTextEdit DisplayFormatString="N2">
                                                                                        </PropertiesTextEdit>
                                                                                        <Settings AllowSort="False" />
                                                                                        <FilterCellStyle HorizontalAlign="Center" VerticalAlign="Middle">
                                                                                        </FilterCellStyle>
                                                                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                                        <CellStyle HorizontalAlign="Center" VerticalAlign="Middle">
                                                                                        </CellStyle>
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn Caption="Residual" Name="Residual" Width="20%" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" Visible="true" VisibleIndex="5" FieldName="Residual">
                                                                                        <PropertiesTextEdit DisplayFormatString="N2">
                                                                                        </PropertiesTextEdit>
                                                                                        <Settings AllowSort="False" />
                                                                                        <FilterCellStyle HorizontalAlign="Center" VerticalAlign="Middle">
                                                                                        </FilterCellStyle>
                                                                                        <HeaderStyle Wrap="True" HorizontalAlign="Center" VerticalAlign="Middle"></HeaderStyle>
                                                                                        <CellStyle HorizontalAlign="Center" VerticalAlign="Middle">
                                                                                        </CellStyle>
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn Caption="Valor Fondeo  Actual" Name="AforoA" Width="20%" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" Visible="true" VisibleIndex="4" FieldName="AforoA">
                                                                                        <PropertiesTextEdit DisplayFormatString="N2">
                                                                                        </PropertiesTextEdit>
                                                                                        <Settings AllowSort="False" />
                                                                                        <FilterCellStyle HorizontalAlign="Center" VerticalAlign="Middle">
                                                                                        </FilterCellStyle>
                                                                                        <HeaderStyle Wrap="True" HorizontalAlign="Center" VerticalAlign="Middle"></HeaderStyle>
                                                                                        <CellStyle HorizontalAlign="Center" VerticalAlign="Middle">
                                                                                        </CellStyle>
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    
                                                                                    
                                                                                </Columns>
                                                                          
                                                                            <TotalSummary>
                                                                                <dx:ASPxSummaryItem DisplayFormat="Total: {0:c2}" FieldName="AforoO" ShowInColumn="AforoO" SummaryType="Sum" Tag="Total" ValueDisplayFormat="N2" />
                                                                                <dx:ASPxSummaryItem DisplayFormat="Total: {0:c2}" FieldName="Residual" ShowInColumn="Residual" SummaryType="Sum" Tag="Total" ValueDisplayFormat="N2" />
                                                                                <dx:ASPxSummaryItem DisplayFormat="Total: {0:c2}" FieldName="AforoA" ShowInColumn="AforoA" SummaryType="Sum" Tag="Total" ValueDisplayFormat="N2" />
                                                            </TotalSummary>
                                                            <Styles>
                                                                <Cell HorizontalAlign="Center" VerticalAlign="Middle">
                                                                </Cell>
                                                            </Styles>
                                                                          
                                                                            </dx:ASPxGridView>
                                                  <%--  ++++++++++++++++++++--%>
                                                                       </td>
                                                                   </tr>
                                                              <tr>
                                                                  <td>
                                                                      <br />
                                                                  </td>
                                                              </tr>
                                                        <tr>
                                                            <td>

                                                                <dx:ASPxButton ID="ButtonRemesa" runat="server" Text="Generar Remesa" Theme="Aqua" ClientInstanceName="ButtonRemesa">
                                                                    <ClientSideEvents Click="function(s, e) {
	e.processOnServer = true;
}" />
                                                                    <Image IconID="reports_addgroupheader_16x16">
                                                                    </Image>
                                                                </dx:ASPxButton>

                                                                 <dx:ASPxTextBox ID="txt_ParamLFid" runat="server" Width="170px" ClientInstanceName="txt_ParamLFid" ClientVisible="False">
                                                                </dx:ASPxTextBox>

                                                            </td>
                                                       
                                                        </tr>

                                                              <tr>
                                                                  <td>
                                                        <dx:ASPxGridView ID="gv_ContratosxCeder" ClientInstanceName="gv_ContratosxCeder" EnableCallBacks="true" ViewStateMode="Enabled" runat="server" KeyFieldName="cred_id" AutoGenerateColumns="False" EnableTheming="True" Theme="Aqua" Width="100%" Caption="Contratos por Ceder" >   <%-- OnCustomCallback="gv_ContratosxCeder_CustomCallback"        OnHtmlDataCellPrepared="gv_LineaFondeo_HtmlDataCellPrepared"--%>
                                                               <ClientSideEvents RowDblClick ="function(s, e) { callfmrParametros(s,e); }" />   <%--callfmrParametros--%>
                                                                                <Settings ShowFilterRowMenu="false" HorizontalScrollBarMode="Auto" VerticalScrollBarMode="Visible" VerticalScrollableHeight="200" GridLines="Horizontal" VerticalScrollBarStyle="Standard" ShowTitlePanel="True" ShowFilterRow="True" />
                                                                                <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true"></SettingsAdaptivity>
                                                                                <SettingsCommandButton>
                                                                                    <ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>
                                                                                    <HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
                                                                                </SettingsCommandButton>
                                                                                <SettingsSearchPanel Visible="True" />
                                                                                <%--<SettingsBehavior AllowSelectByRowClick="false"  AllowFocusedRow="True" AllowSort="false"/>--%>
                                                                                <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" AutoExpandAllGroups="true" />
                                                                                <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                                                                                <Columns>
                                                                                                  <dx:GridViewDataTextColumn  Caption="No. Contrato" Visible="true" Name="contrato" ShowInCustomizationForm="True" VisibleIndex="2" FieldName="contrato">
                                                                                                      <Settings AllowFilterBySearchPanel="True" />
                                                                                                  </dx:GridViewDataTextColumn>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn  Caption="Anexo" Visible="true" Name="anexo" ShowInCustomizationForm="True" VisibleIndex="3" FieldName="anexo">
                                                                                        <Settings AllowFilterBySearchPanel="True" />
                                                                                                  </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="Fecha Solicitud" Visible="true" Name="fechasolicitud" ShowInCustomizationForm="True" VisibleIndex="4" FieldName="fechasolicitud">
                                                                                        <PropertiesTextEdit DisplayFormatString="MM/dd/yyyy">
                                                                                        </PropertiesTextEdit>
                                                                                                  <Settings AllowFilterBySearchPanel="True" />
                                                                                                  </dx:GridViewDataTextColumn>
                                                                                    
                                                                                                                                                                     
                                                                                    <dx:GridViewDataTextColumn Caption="Unidad" Width="120" Name="descripcionUnidad" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" VisibleIndex="5" FieldName="descripcionUnidad">
                                                                                        <Settings AllowFilterBySearchPanel="True" />
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle></dx:GridViewDataTextColumn>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn Caption="Modelo" Width="120" HeaderStyle-Wrap="True" CellStyle-HorizontalAlign="Right" Name="modelo" ShowInCustomizationForm="True" VisibleIndex="6" FieldName="modelo">
                                                                                        <Settings AllowFilterBySearchPanel="True" />
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle><CellStyle HorizontalAlign="Right"></CellStyle>
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn Caption="Residual" Name="Residual" Width="120" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" Visible="true" VisibleIndex="8" FieldName="Residual">
                                                                                        <PropertiesTextEdit DisplayFormatString="N2">
                                                                                        </PropertiesTextEdit>
                                                                                        <Settings AllowFilterBySearchPanel="True" />
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle>
                                                                                        <CellStyle HorizontalAlign="Right">
                                                                                        </CellStyle>
                                                                                                  </dx:GridViewDataTextColumn>
                                                                                    
                                                                                     <dx:GridViewDataTextColumn Caption="VIN"  Width="120px" Name="VIN"  CellStyle-HorizontalAlign="Right" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" VisibleIndex="9" FieldName="VIN">
                                                                                         <CellStyle HorizontalAlign="Right">
                                                                                         </CellStyle>
                                                                                         <Settings AllowFilterBySearchPanel="True" />
                                                                                         <HeaderStyle Wrap="True"></HeaderStyle><CellStyle HorizontalAlign="Right"></CellStyle>
                                                                                    </dx:GridViewDataTextColumn>

                                                                                     <dx:GridViewDataTextColumn Caption="Rentas Corrientes" Visible="true"  Width="120px" Name="RentasPagadas" CellStyle-HorizontalAlign="Right" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" VisibleIndex="10" FieldName="RentasPagadas">
                                                                                         <PropertiesTextEdit DisplayFormatString="N2">
                                                                                         </PropertiesTextEdit>
                                                                                         <Settings AllowFilterBySearchPanel="True" />
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle>

<CellStyle HorizontalAlign="Right"></CellStyle>
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn Caption="Renta s/iva" Width="120px" Name="Rentas" CellStyle-HorizontalAlign="Right" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" VisibleIndex="12" FieldName="Rentas">
                                                                                        <PropertiesTextEdit DisplayFormatString="N2">
                                                                                        </PropertiesTextEdit>
                                                                                        <Settings AllowFilterBySearchPanel="True" />
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle><CellStyle HorizontalAlign="Right"></CellStyle>
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="% Valor de Renta" Name="ValorRenta" Width="120" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" VisibleIndex="13" FieldName="ValorRenta">
                                                                                        <PropertiesTextEdit DisplayFormatString="N2">
                                                                                        </PropertiesTextEdit>
                                                                                        <Settings AllowFilterBySearchPanel="True" />
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle></dx:GridViewDataTextColumn>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn Caption="Fecha Vencimiento"  Width="120px" Name="fechvencim" CellStyle-HorizontalAlign="Right" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" VisibleIndex="15" FieldName="fechvencim">
                                                                                        <PropertiesTextEdit DisplayFormatString="MM/dd/yyyy">
                                                                                        </PropertiesTextEdit>
                                                                                        <Settings AllowFilterBySearchPanel="True" />
<HeaderStyle Wrap="True"></HeaderStyle>

<CellStyle HorizontalAlign="Right"></CellStyle>
                                                                                                  </dx:GridViewDataTextColumn>

                                                                                                                                                                     
                                                                                    <dx:GridViewDataTextColumn Caption="No. Credito" Name="cred_id" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1" FieldName="cred_id"><HeaderStyle Wrap="True"></HeaderStyle></dx:GridViewDataTextColumn>
                                                                                    
                                                                                                  <dx:GridViewCommandColumn Caption="Seleccionar" Name="chkContract" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                                                                                  </dx:GridViewCommandColumn>
                                                                                    
                                                                                                  <dx:GridViewDataTextColumn Caption="Tipo Transacción" FieldName="TipTransact" Name="TipTransact" ShowInCustomizationForm="True" VisibleIndex="7">
                                                                                                  </dx:GridViewDataTextColumn>
                                                                                                  <dx:GridViewDataTextColumn Caption="Valor Aforo Actual" FieldName="AforoAct" Name="AforoAct" ShowInCustomizationForm="True" VisibleIndex="11">
                                                                                                      <PropertiesTextEdit DisplayFormatString="N2">
                                                                                                      </PropertiesTextEdit>
                                                                                                  </dx:GridViewDataTextColumn>
                                                                                    
                                                                                </Columns>
                                                                          
                                                                            </dx:ASPxGridView>
                                                                      </td>
                                                                  </tr>
                                                              <tr>
                                                                  <td>

                                                                      <dx:ASPxListBox ID="ListContGar" runat="server" ClientInstanceName="ListContGar" ClientVisible="False">
                                                                      </dx:ASPxListBox>

                                                                  </td>
                                                              </tr>
                                                              </table>
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>
                                        
                                            <dx:TabPage Name="tabDetalleFondeo" Text="Detalle de Fondeo" Enabled ="true" >
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <table width ="100%" >
                                                            <tr>
                                                                <td>
                                                                    <dx:ASPxGridView ID="gv_DetalleFondeo" ClientInstanceName="gv_DetalleFondeo" EnableCallBacks="true" ViewStateMode="Enabled" runat="server" KeyFieldName="cvefonbco" AutoGenerateColumns="False" EnableTheming="True" Theme="Aqua" Width="100%" OnCustomCallback="gv_DetalleFondeo_CustomCallback"  >  
                                                               <ClientSideEvents RowDblClick ="function(s, e) { callControlAforo(s,e); }" />  
                                                                                <Settings ShowFilterRowMenu="false" HorizontalScrollBarMode="Auto" VerticalScrollBarMode="Visible" ShowFooter="true" VerticalScrollableHeight="200" GridLines="Horizontal" VerticalScrollBarStyle="Standard" ShowGroupFooter="VisibleAlways" />
                                                                                <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true"></SettingsAdaptivity>
                                                                                <SettingsCommandButton>
                                                                                    <ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>
                                                                                    <HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
                                                                                </SettingsCommandButton>
                                                                                <SettingsSearchPanel Visible="True" />
                                                                                <SettingsBehavior AllowSort="true" ColumnResizeMode="Control" AutoExpandAllGroups="true" />
                                                                                <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                                                                                <Columns >
                                                                                    
                                                                                  <%--  <dx:GridViewDataTextColumn  Caption="Disposicion" Visible="true" Name="NoDisposicion" FixedStyle="Left" ShowInCustomizationForm="True" VisibleIndex="1" FieldName="NoDisposicion"></dx:GridViewDataTextColumn>.--%>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn Caption="Identificador" Name="cvefonbco" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" Visible="False" VisibleIndex="0" FieldName="cvefonbco" FixedStyle="Left">
                                                                                        <PropertiesTextEdit DisplayFormatString="N2">
                                                                                        </PropertiesTextEdit>
<HeaderStyle Wrap="True"></HeaderStyle>
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn Caption="Num Disposicion" Visible="true" Name="NumDisposicion" ShowInCustomizationForm="True" VisibleIndex="1" FieldName="NumDisposicion"></dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="Fecha Disposicion" Visible="true" Name="FechaDisposicion" ShowInCustomizationForm="True" VisibleIndex="2" FieldName="FechaDisposicion">
                                                                                        <PropertiesTextEdit DisplayFormatString="MM/dd/yyyy">
                                                                                        </PropertiesTextEdit>
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn  Caption="Monto Dispuesto" Name="MontoDispuesto" ShowInCustomizationForm="True" VisibleIndex="3" FieldName="MontoDispuesto" Width="120px">
                                                                                        <PropertiesTextEdit DisplayFormatString="N2">
                                                                                        </PropertiesTextEdit>
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn Caption="Saldo Actual" Width="120" Name="SaldoActual" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" VisibleIndex="4" FieldName="SaldoActual">
                                                                                        <PropertiesTextEdit DisplayFormatString="N2">
                                                                                        </PropertiesTextEdit>
<HeaderStyle Wrap="True"></HeaderStyle>
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn Caption="Fecha Renovacion" Name="FechaRenovacion" Width="120" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" Visible="true" VisibleIndex="5" FieldName="FechaRenovacion">
                                                                                        <PropertiesTextEdit DisplayFormatString="MM/dd/yyyy">
                                                                                        </PropertiesTextEdit>
<HeaderStyle Wrap="True"></HeaderStyle>
                                                                                    </dx:GridViewDataTextColumn>

                                                                                     <dx:GridViewDataTextColumn Caption="Fecha Vencimiento" Name="FechaVencimiento" Width="120" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" VisibleIndex="6" FieldName="FechaVencimiento">
                                                                                         <PropertiesTextEdit DisplayFormatString="MM/dd/yyyy">
                                                                                         </PropertiesTextEdit>
<HeaderStyle Wrap="True"></HeaderStyle>
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    
                                                                                     <dx:GridViewDataTextColumn Caption="Tasa" Width="120" Name="Tasa" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" VisibleIndex="7" FieldName="Tasa">
                                                                                         <PropertiesTextEdit DisplayFormatString="N2">
                                                                                         </PropertiesTextEdit>
<HeaderStyle Wrap="True"></HeaderStyle>
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="Aforo Actual" FieldName="aforoactual" Name="aforoactual" ShowInCustomizationForm="True" Visible="False" VisibleIndex="8">
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    
                                                                                </Columns>
                                                                          
                                                                            <TotalSummary>
                                                                                <dx:ASPxSummaryItem DisplayFormat="Total: {0:c2}" FieldName="MontoDispuesto" ShowInColumn="MontoDispuesto" SummaryType="Sum" Tag="Total" />
                                                                                <dx:ASPxSummaryItem DisplayFormat="Total: {0:c2}" FieldName="SaldoActual" ShowInColumn="SaldoActual" SummaryType="Sum" />
                                                                        </TotalSummary>
                                                                          
                                                                            </dx:ASPxGridView>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="height: 100%; width: 100%;">
                                                                    &nbsp;</td>
                                                            </tr>
                                                        </table>
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>

                                            <dx:TabPage Name="tabCreditos" Text="Reemplazo de Garantias por Aforo">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <table>
                                                            <tr>
                                                                <td align="right">

                                                                    <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="Saldo Actual:">
                                                                    </dx:ASPxLabel>

                                                                </td>
                                                                <td>

                                                                    <dx:ASPxTextBox ID="ASPxTextBox8" runat="server" Width="170px">
                                                                    </dx:ASPxTextBox>

                                                                </td>
                                                                <td align="right">

                                                                    <dx:ASPxLabel ID="ASPxLabel15" runat="server" Text="Fecha Disposición">
                                                                    </dx:ASPxLabel>

                                                                </td>
                                                                <td>

                                                                    <dx:ASPxTextBox ID="ASPxTextBox13" runat="server" Width="170px">
                                                                    </dx:ASPxTextBox>

                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right">

                                                                    <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="Valor de Aforo">
                                                                    </dx:ASPxLabel>

                                                                </td>
                                                                <td>

                                                                    <dx:ASPxTextBox ID="ASPxTextBox9" runat="server" Width="170px">
                                                                    </dx:ASPxTextBox>

                                                                </td>
                                                                <td align="right">

                                                                    <dx:ASPxLabel ID="ASPxLabel16" runat="server" Text="Fecha Renovación anterior">
                                                                    </dx:ASPxLabel>

                                                                </td>
                                                                <td>

                                                                    <dx:ASPxTextBox ID="ASPxTextBox14" runat="server" Width="170px">
                                                                    </dx:ASPxTextBox>

                                                                </td>

                                                            </tr>
                                                            <tr>
                                                                <td align="right">

                                                                    <dx:ASPxLabel ID="ASPxLabel12" runat="server" Text="Aforo Contractual">
                                                                    </dx:ASPxLabel>

                                                                </td>
                                                                <td>

                                                                    <dx:ASPxTextBox ID="ASPxTextBox10" runat="server" Width="170px">
                                                                    </dx:ASPxTextBox>

                                                                </td>
                                                                <td align="right">

                                                                    <dx:ASPxLabel ID="ASPxLabel17" runat="server" Text="Días par prox. renovación">
                                                                    </dx:ASPxLabel>

                                                                </td>
                                                                <td>

                                                                    <dx:ASPxTextBox ID="ASPxTextBox15" runat="server" Width="170px">
                                                                    </dx:ASPxTextBox>

                                                                </td>

                                                            </tr>
                                                            <tr>
                                                                <td align="right">

                                                                    <dx:ASPxLabel ID="ASPxLabel13" runat="server" Text="AforoActual">
                                                                    </dx:ASPxLabel>

                                                                </td>
                                                                <td>

                                                                    <dx:ASPxTextBox ID="AforoActual" runat="server" Width="170px" ClientInstanceName="AforoActual">
                                                                    </dx:ASPxTextBox>

                                                                </td>
                                                                <td align="right">

                                                                    <dx:ASPxLabel ID="ASPxLabel18" runat="server" Text="Número de Renovaciones">
                                                                    </dx:ASPxLabel>

                                                                </td>
                                                                <td>

                                                                    <dx:ASPxTextBox ID="ASPxTextBox16" runat="server" Width="170px">
                                                                    </dx:ASPxTextBox>

                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right">

                                                                    <dx:ASPxLabel ID="ASPxLabel14" runat="server" Text="Aforo Calculado">
                                                                    </dx:ASPxLabel>

                                                                </td>
                                                                <td>

                                                                    <dx:ASPxTextBox ID="AforoCalculado" runat="server" Width="170px" ClientInstanceName="AforoCalculado">
                                                                    </dx:ASPxTextBox>

                                                                </td>
                                                                <td>

                                                                </td>
                                                                <td>

                                                                    <dx:ASPxTextBox ID="txtIdParamLF" runat="server" Width="170px" ClientInstanceName="txtIdParamLF" ClientVisible="False">
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

                                                                    <dx:ASPxButton ID="generaremesab" runat="server" ClientInstanceName="generaremesab" Text="Generar Remesa" Theme="Aqua">
                                                                        <ClientSideEvents Click="function(s, e) {
	e.processOnServer = true;
}" />
                                                                        <Image IconID="actions_add_16x16">
                                                                        </Image>
                                                                    </dx:ASPxButton>

                                                                </td>
                                                                <td colspan="2" align="right">

                                                                    <dx:ASPxButton ID="ASPxButton2" runat="server" EnableTheming="True" Text="Liberar Contratos" Theme="Aqua">
                                                                        <Image IconID="people_assignto_16x16">
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

                                                                    <dx:ASPxGridView ID="gv_EnGarantia" runat="server" AutoGenerateColumns="False" ClientInstanceName="gv_EnGarantia" EnableTheming="True" KeyFieldName="IdParamElegibilidadLF" Theme="Aqua" ViewStateMode="Enabled" Width="1000px" Caption="Creditos en Garantia">
                                                                        <ClientSideEvents SelectionChanged="function(s, e) {getgridvalue(s,e);}" />
                                                                        <SettingsPager Mode="ShowAllRecords">
                                                                        </SettingsPager>
                                                                        <Settings GridLines="Horizontal" HorizontalScrollBarMode="Auto" ShowFooter="True" VerticalScrollBarMode="Visible" ShowTitlePanel="True" />
                                                                        <SettingsBehavior AutoExpandAllGroups="True" ColumnResizeMode="Control" />
                                                                        <SettingsSearchPanel Visible="True" />
                                                                        <Columns>
                                                                            <dx:GridViewDataTextColumn Caption="num contrato" FieldName="contrato" Name="contrato" ShowInCustomizationForm="True" VisibleIndex="3" Width="80px">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Fecha Solicitud" FieldName="fechasolicitud" Name="fechasolicitud" ShowInCustomizationForm="True" VisibleIndex="5" Width="100px">
                                                                                <PropertiesTextEdit DisplayFormatString="MM/dd/yyyy">
                                                                                </PropertiesTextEdit>
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Unidad" FieldName="descripcionUnidad" Name="Unidad" ShowInCustomizationForm="True" VisibleIndex="6" Width="100px">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Modelo" FieldName="modelo" Name="Modelo" ShowInCustomizationForm="True" VisibleIndex="7" Width="100px">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Residual" FieldName="Residual" Name="Residual" ShowInCustomizationForm="True" VisibleIndex="8" Width="100px">
                                                                                <PropertiesTextEdit DisplayFormatString="N2">
                                                                                </PropertiesTextEdit>
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="VIN" FieldName="VIN" Name="VIN" ShowInCustomizationForm="True" VisibleIndex="10" Width="100px">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Rentas Corrientes" FieldName="RentasPagadas" Name="rentpagadas" ShowInCustomizationForm="True" VisibleIndex="11" Width="100px">
                                                                                <PropertiesTextEdit DisplayFormatString="N2">
                                                                                </PropertiesTextEdit>
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Renta" FieldName="Rentas" Name="renta" ShowInCustomizationForm="True" VisibleIndex="12" Width="100px">
                                                                                <PropertiesTextEdit DisplayFormatString="N2">
                                                                                </PropertiesTextEdit>
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Fecha Activacion" FieldName="fechotorg" Name="fecActivacion" ShowInCustomizationForm="True" VisibleIndex="13" Width="100px">
                                                                                <PropertiesTextEdit DisplayFormatString="MM/dd/yyyy">
                                                                                </PropertiesTextEdit>
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Fecha Vencimiento" FieldName="fechvencim" Name="fecvencimiento" ShowInCustomizationForm="True" VisibleIndex="15" Width="100px">
                                                                                <PropertiesTextEdit DisplayFormatString="MM/dd/yyyy">
                                                                                </PropertiesTextEdit>
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="num credito" FieldName="cred_id" Name="cred_id" ShowInCustomizationForm="True" VisibleIndex="2">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Anexo" FieldName="anexo" Name="Anexo" ShowInCustomizationForm="True" VisibleIndex="4">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewCommandColumn Caption="Seleccionar" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
                                                                            </dx:GridViewCommandColumn>
                                                                            <dx:GridViewCommandColumn Caption="Liberar" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="1">
                                                                            </dx:GridViewCommandColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Aforo Calculado" FieldName="aforocalc" Name="aforocalc" ShowInCustomizationForm="True" VisibleIndex="9">
                                                                                <PropertiesTextEdit DisplayFormatString="N2">
                                                                                </PropertiesTextEdit>
                                                                            </dx:GridViewDataTextColumn>
                                                                        </Columns>
                                                                        <TotalSummary>
                                                                            <dx:ASPxSummaryItem FieldName="nombre" SummaryType="Count" />
                                                                        </TotalSummary>
                                                                    </dx:ASPxGridView>

                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4">
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4" >

                                                                    <dx:ASPxGridView ID="gv_EnReemplazo" runat="server" AutoGenerateColumns="False" ClientInstanceName="gv_EnReemplazo" EnableTheming="True" KeyFieldName="idRelLab" Theme="Aqua" ViewStateMode="Enabled" Width="1000px" Caption="Créditos en Reemplazo">
                                                                        <ClientSideEvents SelectionChanged="function(s, e) {
	getgridReemplazo(s,e);
}" />
                                                                        <SettingsPager Mode="ShowAllRecords">
                                                                        </SettingsPager>
                                                                        <Settings GridLines="Horizontal" HorizontalScrollBarMode="Auto" ShowFooter="True" VerticalScrollBarMode="Visible" ShowTitlePanel="True" />
                                                                        <SettingsBehavior AutoExpandAllGroups="True" ColumnResizeMode="Control" />
                                                                        <SettingsSearchPanel Visible="True" />
                                                                        <Columns>
                                                                            <dx:GridViewCommandColumn SelectAllCheckboxMode="Page" ShowClearFilterButton="True" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0" Width="25px">
                                                                            </dx:GridViewCommandColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Num Credito" FieldName="cred_id" Name="cred_id" ShowInCustomizationForm="True" VisibleIndex="1" Width="20px" Visible="False">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="num contrato" FieldName="contrato" Name="contrato" ShowInCustomizationForm="True" VisibleIndex="2" Width="80px">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Anexo" FieldName="anexo" Name="Anexo" ShowInCustomizationForm="True" VisibleIndex="3" Width="80px">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Fecha Factura Unidad" FieldName="fechasolicitud" Name="fecFactura" ShowInCustomizationForm="True" VisibleIndex="4" Width="100px">
                                                                                <PropertiesTextEdit DisplayFormatString="MM/dd/yyyy">
                                                                                </PropertiesTextEdit>
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Unidad" FieldName="descripcionUnidad" Name="Unidad" ShowInCustomizationForm="True" VisibleIndex="5" Width="100px">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Modelo" FieldName="modelo" Name="Modelo" ShowInCustomizationForm="True" VisibleIndex="6" Width="100px">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Residual" FieldName="Residual" Name="Residual" ShowInCustomizationForm="True" VisibleIndex="7" Width="100px">
                                                                                <PropertiesTextEdit DisplayFormatString="N2">
                                                                                </PropertiesTextEdit>
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="VIN" FieldName="VIN" Name="VIN" ShowInCustomizationForm="True" VisibleIndex="9" Width="100px">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Rentas  Pagadas" FieldName="RentasPagadas" Name="rentpagadas" ShowInCustomizationForm="True" VisibleIndex="10" Width="100px">
                                                                                <PropertiesTextEdit DisplayFormatString="N2">
                                                                                </PropertiesTextEdit>
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Renta" FieldName="Rentas" Name="renta" ShowInCustomizationForm="True" VisibleIndex="12" Width="100px">
                                                                                <PropertiesTextEdit DisplayFormatString="N2">
                                                                                </PropertiesTextEdit>
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Fecha Activacion" FieldName="fechotorg" Name="fecActivacion" ShowInCustomizationForm="True" VisibleIndex="13" Width="100px">
                                                                                <PropertiesTextEdit DisplayFormatString="MM/dd/yyyy">
                                                                                </PropertiesTextEdit>
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Fecha Vencimiento" FieldName="fechvencim" Name="fecvencimiento" ShowInCustomizationForm="True" VisibleIndex="15" Width="100px">
                                                                                <PropertiesTextEdit DisplayFormatString="MM/dd/yyyy">
                                                                                </PropertiesTextEdit>
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Aforo Calculado" FieldName="aforocalc" Name="aforocalc" ShowInCustomizationForm="True" VisibleIndex="8">
                                                                                <PropertiesTextEdit DisplayFormatString="N2">
                                                                                </PropertiesTextEdit>
                                                                            </dx:GridViewDataTextColumn>
                                                                        </Columns>
                                                                        <TotalSummary>
                                                                            <dx:ASPxSummaryItem FieldName="nombre" SummaryType="Count" />
                                                                        </TotalSummary>
                                                                    </dx:ASPxGridView>

                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>

                                                                    <dx:ASPxListBox ID="ListGarantiaSel" runat="server" ClientInstanceName="ListGarantiaSel" ClientVisible="False">
                                                                    </dx:ASPxListBox>

                                                                </td>
                                                                <td>

                                                                    <dx:ASPxListBox ID="ListGarantiaLib" runat="server" ClientInstanceName="ListGarantiaLib" ClientVisible="False">
                                                                    </dx:ASPxListBox>

                                                                </td>
                                                                <td>

                                                                    <dx:ASPxListBox ID="ListReemplazoSel" runat="server" ClientInstanceName="ListReemplazoSel" ClientVisible="False">
                                                                    </dx:ASPxListBox>

                                                                </td>
                                                                <td>

                                                                    <dx:ASPxListBox ID="ListReemplazoLib" runat="server" ClientInstanceName="ListReemplazoLib" ClientVisible="False">
                                                                    </dx:ASPxListBox>

                                                                </td>
                                                            </tr>
                                                            
                                                        </table>
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>

                                            <dx:TabPage Name="AnexosDetalle" Text="Detalle Anexos en Garantía">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <table>
                                                            <tr>
                                                                <td>

                                                                    <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Liberar Anexos" Theme="Office2003Blue">
                                                                        <Image IconID="reports_deletegroupfooter_16x16">
                                                                        </Image>
                                                                    </dx:ASPxButton>

                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <br />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <dx:ASPxGridView ID="GridAnexoDetalle" runat="server" AutoGenerateColumns="False" ClientInstanceName="GridAnexoDetalle" EnableTheming="True" Theme="Aqua">
                                                                        <SettingsPager Visible="False">
                                                                        </SettingsPager>
                                                                        <Settings GridLines="Horizontal" />
                                                                        <SettingsDataSecurity AllowDelete="False" AllowEdit="False" AllowInsert="False" />
                                                                        <Columns>
                                                                            <dx:GridViewDataTextColumn Caption="id credito" FieldName="cred_id" Name="id credito" ShowInCustomizationForm="True" Visible="False" VisibleIndex="1">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="No. Contrato" FieldName="contrato" Name="NoContrato" ShowInCustomizationForm="True" VisibleIndex="2">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Fecha Compra" FieldName="fechotorg" Name="Fecha Compra" ShowInCustomizationForm="True" VisibleIndex="3">
                                                                                <PropertiesTextEdit DisplayFormatString="MM/dd/yyyy">
                                                                                </PropertiesTextEdit>
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Fecha Vencimiento" FieldName="fechvencim" Name="Fecha Vencimiento" ShowInCustomizationForm="True" VisibleIndex="4">
                                                                                <PropertiesTextEdit DisplayFormatString="MM/dd/yyyy">
                                                                                </PropertiesTextEdit>
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Plazo Contrato en Meses" FieldName="plazocredito" Name="PlazoContrato" ShowInCustomizationForm="True" VisibleIndex="5">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Unidad" FieldName="unidad" Name="unidad" ShowInCustomizationForm="True" VisibleIndex="6">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Modelo" FieldName="modelo" Name="modelo" ShowInCustomizationForm="True" VisibleIndex="7">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="VIN" FieldName="VIN" Name="vin" ShowInCustomizationForm="True" VisibleIndex="8">
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Valor Original" FieldName="montootrogrp" Name="montootrogrp" ShowInCustomizationForm="True" VisibleIndex="9">
                                                                                <PropertiesTextEdit DisplayFormatString="N2">
                                                                                </PropertiesTextEdit>
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewDataTextColumn Caption="Valor Actual" FieldName="capitaactualpropio" Name="capitaactualpropio" ShowInCustomizationForm="True" VisibleIndex="10">
                                                                                <PropertiesTextEdit DisplayFormatString="N2">
                                                                                </PropertiesTextEdit>
                                                                            </dx:GridViewDataTextColumn>
                                                                            <dx:GridViewCommandColumn Caption="Liberar" Name="LibAnexo" ShowInCustomizationForm="True" ShowSelectCheckbox="True" VisibleIndex="0">
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
                                        <ClientSideEvents TabClick="function(s, e) { CambiaTab(s,e); }" />
                                    </dx:ASPxPageControl>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxRoundPanel>
                    </td>
                </tr>
            </table>
    </div>
        </form>
</body>
</html>
