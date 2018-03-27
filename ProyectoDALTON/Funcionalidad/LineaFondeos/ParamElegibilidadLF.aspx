<%@ Page Language="VB" AutoEventWireup="false" CodeFile="ParamElegibilidadLF.aspx.vb" Inherits="Funcionalidad_LineaFondeos_ParamElegibilidadLF" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register TagPrefix="uc" TagName="HerramientasDalton"  Src="~/UserControl/HerramientasDalton.ascx"%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">    
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Parametrizacion Linea de Fondeo</title>
    <script type="text/javascript" language ="javascript" src ="~/Scripts/jquery-3.1.1.intellisense.js"></script>
    <script type="text/javascript" language ="javascript" src ="~/Scripts/jquery-3.1.1.js"></script>
    <script type="text/javascript" language ="javascript" src ="~/Scripts/jquery-3.1.1.slim.js"></script>
    <script type="text/javascript" language ="javascript" src ="~/Scripts/ jquery.toast.min.js"></script>

      <link href="../Estilos/jquery.toast.min.css" rel="stylesheet" />
     <link href="../Estilos/jquery-ui.css" rel="stylesheet" />
     <link href="../Estilos/jquery-ui.min.css" rel="stylesheet" />


<script type ="text/javascript" >
    var bandera = 0;

    function load()
    {
        
        HabilitarBotonesDefault()
    }

    function CambiaTab(s, e) {
        
        var tab = e.tab.GetText()
       
        if (tab == "Lineas de Fondeo")
        {
            tsFondeadoras.SetActiveTabIndex(0)
        }
        else if (tab == "Parametros Elegibilidad de Lineas de Fondeo")
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

        tsFondeadoras.GetTabByName("TabFrmFondeo").SetEnabled(false);
        tsFondeadoras.SetActiveTabIndex(0);
    }

    function OnNewRowClicked() {
       
        btnAgregar.SetEnabled(false);
        btnEditar.SetEnabled(false);
        btnEliminar.SetEnabled(false);
        btnCancelar.SetEnabled(true);
        btnAplicar.SetEnabled(true);
        tsFondeadoras.SetActiveTabIndex(1)
       
        bandera = 0;
    }

    function OnDiscardChangesClicked() {

       
        cboFdoBco.SetValue(-1);
        txt_NombreFondo.SetText("");
        txt_MontoAutorizado.SetText("");
        txt_FechaVencimiento.SetText("");
        txt_AforoContractual.SetText("");
        txt_Tasa.SetText("");
        txt_PlazoDias.SetText("");
        txt_MesRestriccionAcceso.SetText("");
        cbo_IdValorAforoxEF.SetSelectedIndex(-1);
        rdo_DescuentoNotaCredito.SetValue(-1);
        txt_PermitirSustitucionGarantia.SetValue(-1);
        txt_FactorAjuste.SetText("");

        txt_marca_idSel.ClearItems();
        txt_No_asegSel.ClearItems();


        txt_AntiguedaMaxFac.SetText("");
        txt_AntiguedadFacRenovacion.SetText("");
        cbo_TipoOperacionxEF.SetSelectedIndex(-1);
        txt_ValorMaxAforo.SetText("");
        txt_ValorMinAforo.SetText("");
        txt_PlazoRenGarantia.SetText("");
        dt_FechaUltRenovacion.SetText("");
        rdo_RenovacionFlujo.SetValue(-1);
        rdo_IdQuienlePagan.SetValue(0);
        
        btnAgregar.SetEnabled(true);
        btnEditar.SetEnabled(false);
        btnEliminar.SetEnabled(false);
        btnCancelar.SetEnabled(false);
        btnAplicar.SetEnabled(false);
 
        tsFondeadoras.GetTabByName("TabFrmFondeo").SetEnabled(false);
        tsFondeadoras.SetActiveTabIndex(0);

        var type = bandera;
        bandera = 0;
    }

    function OnSaveChangesClicked() {
      
        if (bandera == 0 || bandera == 1) {
            var validos = false;
            validos = true;
            if (validos == true) {
                if (bandera == 0) {
                    AgregaParametrosElegibilidad();
                }
                if (bandera == 1) {
                    EditaParametrosElegibilidad();
                }
            }
            OnDiscardChangesClicked();
        }
        else {
            BorraParametrosElegibilidad();
        }
    }

    function AgregaParametrosElegibilidad() {

        gv_LineaFondeo.PerformCallback("AltaParametrosElegibilidad");

    }

    function EditaParametrosElegibilidad()
    {
       
        gv_LineaFondeo.PerformCallback("EditaParametrosElegibilidad");
    }

    function AsignaNombre(s, e) {
        
       
        var nombreFondo = cboFdoBco.GetText();
        txt_NombreFondo.SetText(nombreFondo);
    }

  

    function GetEmpresaLF_gv_LineaFondeoCallback(values) {
        
        llenaListBox(values);
    
        if (values != " ") {
            
            btnAgregar.SetEnabled(false);
            btnEditar.SetEnabled(false);
            btnEliminar.SetEnabled(false);
            btnCancelar.SetEnabled(true);
            btnAplicar.SetEnabled(true);
          
            bandera = 1;

        
            
            TxtIdLF.SetValue(values[0]);
            cboFdoBco.SetValue(values[0]);
            cboFdoBco.SetText(values[1]);
            txt_NombreFondo.SetText(values[1]);
            txt_AforoContractual.SetValue(values[2]);
            txt_MontoAutorizado.SetValue(values[3]);
            txt_FechaVencimiento.SetValue(values[4]);
            txt_Tasa.SetValue(values[5]);
            txt_PlazoDias.SetValue(values[6]);
            txt_MesRestriccionAcceso.SetValue(values[7]);
            cbo_IdValorAforoxEF.SetText(values[8]);
            txt_PorcentajeResidual.SetValue(values[9]);
            rdo_DescuentoNotaCredito.SetValue(values[10]);
            txt_PermitirSustitucionGarantia.SetValue(values[11]);
            txt_FactorAjuste.SetValue(values[12]);
            txt_AntiguedaMaxFac.SetValue(values[13]);
            txt_AntiguedadFacRenovacion.SetValue(values[14]);
            txt_ValorMaxAforo.SetValue(values[15]);
            txt_ValorMinAforo.SetValue(values[16]);
            txt_PlazoRenGarantia.SetValue(values[17]);
            dt_FechaUltRenovacion.SetValue(values[18]);
            rdo_RenovacionFlujo.SetValue(values[19]);
            rdo_IdQuienlePagan.SetValue(values[20]);
            cbo_TipoOperacionxEF.SetText(values[21]);
            
            tsFondeadoras.GetTabByName("TabFrmFondeo").SetEnabled(true);
            tsFondeadoras.SetActiveTabIndex(1);
            pnlGenerales.SetCollapsed(false);
            pnlMarcayAseg.SetCollapsed(true);
            pnlComplementario.SetCollapsed(true);

          
           
            
            
        }
    }

    function llenaListBox(values) {

        if (values[0] == 3)
        {
            for(i = 0; i <= txt_marca_id.GetItemCount() - 1; i++)
            {
                var itemver = txt_marca_id.GetItem(i);
                if (itemver.text == "Toyota" ) {

                    txt_marca_id.BeginUpdate();
                    txt_marca_id.RemoveItem(i);
                    txt_marca_id.EndUpdate();
                }

                if (itemver.text == "VW") {

                    txt_marca_id.BeginUpdate();
                    txt_marca_id.RemoveItem(i);
                    txt_marca_id.EndUpdate();
                }

            }
        }

        
    }


    function callfmrParametros(s,e)
    {
   
        rowIndex = e.visibleIndex;              
        gv_LineaFondeo.GetRowValues(rowIndex, 'cvefonbco;nombre;AforoContractual;MontoAutorizado;' +
                                              'FechaVencimiento;Tasa;PlazoenDias;MesRestriccionAcceso;DescValor;' +
                                              'PorcentajeResidual;DescuentoNotaCredito;PermitirSustitucionGarantia;FactorAjuste;' +
                                              'AntiguedaMaxFac;AntiguedadFacRenovacion;ValorMaxAforo;ValorMinAforo;PlazoRenGarantia;FechaUltRenovacion;' +
                                              'RenovacionFlujo;IdQuienlePagan;DescTipOpr', GetEmpresaLF_gv_LineaFondeoCallback);
    }

    function cambiaPanel(s, e)
    {
        
        if (s.globalName == "pnlGenerales") {
            pnlMarcayAseg.SetCollapsed(true);
            pnlComplementario.SetCollapsed(true);
            pnlGenerales.SetCollapsed(false)
        }
        else if (s.globalName == "pnlMarcayAseg") {
            pnlGenerales.SetCollapsed(true);
            pnlComplementario.SetCollapsed(true);
            pnlMarcayAseg.SetCollapsed(false);
        }
        else if (s.globalName == "pnlComplementario")
        {
            pnlGenerales.SetCollapsed(true);
            pnlMarcayAseg.SetCollapsed(true);
            pnlComplementario.SetCollapsed(false)
        }
    }

    
    function AddSelectedItemsM() {
       
        MoveSelectedItemsM(txt_marca_id, txt_marca_idSel);
        UpdateButtonState();
    }
    function AddAllItemsM() {
        MoveAllItemsM(txt_marca_id, txt_marca_idSel);
        UpdateButtonState();
    }
    function RemoveSelectedItemsM() {
        MoveSelectedItemsM(txt_marca_idSel, txt_marca_id);
        UpdateButtonState();
    }
    function RemoveAllItemsM() {
        MoveAllItemsM(txt_marca_idSel, txt_marca_id);
        UpdateButtonState();
    }

    function MoveSelectedItemsM(srcListBox, dstListBox) {
       
        srcListBox.BeginUpdate();
        dstListBox.BeginUpdate();
        var items = srcListBox.GetSelectedItems();

        for (var i = items.length - 1; i >= 0; i = i - 1) {

            dstListBox.AddItem(items[i].text, items[i].value );
      
            srcListBox.RemoveItem(items[i].index);

        }
        srcListBox.EndUpdate();
        dstListBox.EndUpdate();
    }
    function MoveAllItemsM(srcListBox, dstListBox) {
        srcListBox.BeginUpdate();
        var count = srcListBox.GetItemCount();
        for (var i = 0; i < count; i++) {
            var item = srcListBox.GetItem(i);
            dstListBox.AddItem(item.text, item.value);
        }
        srcListBox.EndUpdate();
        srcListBox.ClearItems();
    }
    function UpdateButtonState() {
        btnMoveAllItemsToRight.SetEnabled(txt_marca_id.GetItemCount() > 0);
        btnMoveAllItemsToLeft.SetEnabled(txt_marca_idSel.GetItemCount() > 0);
        btnMoveSelectedItemsToRight.SetEnabled(txt_marca_id.GetSelectedItems().length > 0);
        btnMoveSelectedItemsToLeft.SetEnabled(txt_marca_idSel.GetSelectedItems().length > 0);
    }
    //Funciones ListBox Aseguradoras
    function AddSelectedItemsAseg() {
        MoveSelectedItems(txt_No_aseg, txt_No_asegSel);
        UpdateButtonState();
    }
    function AddAllItemsAseg() {
        MoveAllItems(txt_No_aseg, txt_No_asegSel);
        UpdateButtonState();
    }
    function RemoveSelectedItemsAseg() {
        MoveSelectedItems(txt_No_asegSel, txt_No_aseg);
        UpdateButtonState();
    }
    function RemoveAllItemsAseg() {
        MoveAllItems(txt_No_asegSel, txt_No_aseg);
        UpdateButtonState();
    }
    function MoveSelectedItems(srcListBox, dstListBox) {
        srcListBox.BeginUpdate();
        dstListBox.BeginUpdate();
        var items = srcListBox.GetSelectedItems();
        for (var i = items.length - 1; i >= 0; i = i - 1) {
            dstListBox.AddItem(items[i].text, items[i].value);
            srcListBox.RemoveItem(items[i].index);
        }
        srcListBox.EndUpdate();
        dstListBox.EndUpdate();
    }
    function MoveAllItems(srcListBox, dstListBox) {
        srcListBox.BeginUpdate();
        var count = srcListBox.GetItemCount();
        for (var i = 0; i < count; i++) {
            var item = srcListBox.GetItem(i);
            dstListBox.AddItem(item.text, item.value);
        }
        srcListBox.EndUpdate();
        srcListBox.ClearItems();
    }
    function UpdateButtonStateAseg() {
        btnMoveAllItemsToRightAseg.SetEnabled(txt_No_aseg.GetItemCount() > 0);
        btnMoveAllItemsToLeftAseg.SetEnabled(txt_No_asegSel.GetItemCount() > 0);
        btnMoveSelectedItemsToRightAseg.SetEnabled(txt_No_aseg.GetSelectedItems().length > 0);
        btnMoveSelectedItemsToLeftAseg.SetEnabled(txt_No_asegSel.GetSelectedItems().length > 0);
    }

</script>

    <style type="text/css">
        .auto-style1 {
            height: 20px;
        }
        .auto-style2 {
            height: 27px;
        }
    </style>

    </head>
<body  onload="load()" >
    <form id="form1" runat="server">
        <div>
            <uc:HerramientasDalton id="HerramientasDalton" runat="server"/>
        </div>
        <div>
        <table style="height: 100%; width: 100%;">
                <tr>
                    <td style="height: 100%;">
                        
         <dx:ASPxRoundPanel ID="ASPxRoundPanel3" runat="server" ShowCollapseButton="True"  HeaderText="" Font-Bold="True" Font-Size="Medium"  Width="100%">
          <PanelCollection>
             <dx:PanelContent runat="server">

                                    <dx:ASPxPageControl ID="tsFondeadoras" runat="server" ActiveTabIndex="1" AutoPostBack ="false"  EnableCallBacks ="false" EnableClientSideAPI ="true" EnableTheming="True" Theme="Office2010Blue" Height="100%" Width="100%" ClientInstanceName="tsFondeadoras" >
                                        <TabPages>
                                            <dx:TabPage Name="tabParam" Text="Lineas de Fondeo">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                         <dx:ASPxGridView ID="gv_LineaFondeo" ClientInstanceName="gv_LineaFondeo" EnableCallBacks="true" ViewStateMode="Enabled" runat="server" KeyFieldName="cvefonbco" AutoGenerateColumns="False" EnableTheming="True" Theme="Aqua" Width="100%" OnCustomCallback="gv_LineaFondeo_CustomCallback" >   <%--OnHtmlDataCellPrepared="gv_LineaFondeo_HtmlDataCellPrepared"--%>
                                                               <ClientSideEvents RowDblClick ="function(s, e) { callfmrParametros(s,e); }" />   
                                                                                <Settings ShowFilterRowMenu="false" ShowHeaderFilterButton="true" HorizontalScrollBarMode="Auto" VerticalScrollBarMode="Visible" ShowFooter="true" VerticalScrollableHeight="200" GridLines="Horizontal" VerticalScrollBarStyle="Standard" />
                                                                                <SettingsAdaptivity AdaptivityMode="HideDataCells" AllowOnlyOneAdaptiveDetailExpanded="true"></SettingsAdaptivity>
                                                                                <SettingsCommandButton>
                                                                                    <ShowAdaptiveDetailButton ButtonType="Image"></ShowAdaptiveDetailButton>
                                                                                    <HideAdaptiveDetailButton ButtonType="Image"></HideAdaptiveDetailButton>
                                                                                </SettingsCommandButton>
                                                                                <SettingsSearchPanel Visible="True" />
                                                                                <SettingsBehavior AllowSelectByRowClick="True" />    
                                                                                <SettingsPager Mode="ShowAllRecords"></SettingsPager>
                                                                                <Columns>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn  Caption="cvefonbco" Visible="true" Name="cvefonbco" FixedStyle="Left" ShowInCustomizationForm="True" VisibleIndex="1" FieldName="cvefonbco"></dx:GridViewDataTextColumn>

                                                                                    <dx:GridViewDataTextColumn Caption="Nombre Fondo" Visible="true" Name="nombre" ShowInCustomizationForm="True" VisibleIndex="2" FieldName="nombre"></dx:GridViewDataTextColumn>
                                                                                      
                                                                                    <dx:GridViewDataTextColumn Caption="Aforo Contractual" Name="AforoContractual" Width="120" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" Visible="true" VisibleIndex="3" FieldName="AforoContractual"><HeaderStyle Wrap="True"></HeaderStyle></dx:GridViewDataTextColumn>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn Caption="Plazo en Días" Width="120" HeaderStyle-Wrap="True" CellStyle-HorizontalAlign="Right" Name="PlazoenDias" ShowInCustomizationForm="True" VisibleIndex="7" FieldName="PlazoenDias"><HeaderStyle Wrap="True"></HeaderStyle><CellStyle HorizontalAlign="Right"></CellStyle>
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn Caption="Fecha Vencimiento" Width="120" Name="FechaVencimiento" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" VisibleIndex="5" FieldName="FechaVencimiento">
                                                                                        <PropertiesTextEdit DisplayFormatString="MM/dd/yyyy">
                                                                                        </PropertiesTextEdit>
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle></dx:GridViewDataTextColumn>
                                                                                    
                                                                                     <dx:GridViewDataTextColumn Caption="Valor de Aforo" Visible="False"  Width="120px" Name="DescValor" CellStyle-HorizontalAlign="Right" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" VisibleIndex="9" FieldName="DescValor">
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle><CellStyle HorizontalAlign="Right"></CellStyle>
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    
                                                                                    <dx:GridViewDataTextColumn Caption="Antiguedad Max Fac" Name="AntiguedaMaxFac" Width="120" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" VisibleIndex="14" FieldName="AntiguedaMaxFac" Visible="False"><HeaderStyle Wrap="True"></HeaderStyle></dx:GridViewDataTextColumn>
                                                                                    
                                                                                     <dx:GridViewDataTextColumn Caption="tipo Operacion" Name="DescTipOpr" Width="120" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" VisibleIndex="22" FieldName="DescTipOpr" Visible="False"><HeaderStyle Wrap="True"></HeaderStyle>
                                                                                    </dx:GridViewDataTextColumn>
                                                                                
                                                                               <dx:GridViewDataTextColumn Caption="Valor Max Aforo" Name="ValorMaxAforo" Width="120" HeaderStyle-Wrap="True" PropertiesTextEdit-DisplayFormatString="C2"  ShowInCustomizationForm="True" VisibleIndex="16" FieldName="ValorMaxAforo">
                                                                                    <HeaderStyle Wrap="True"></HeaderStyle>
                                                                                   <PropertiesTextEdit DisplayFormatString="C2"></PropertiesTextEdit>
                                                                               </dx:GridViewDataTextColumn>

                                                                                     <dx:GridViewDataTextColumn Caption="Valor Min Aforo" Name="ValorMinAforo" Width="120" HeaderStyle-Wrap="True" PropertiesTextEdit-DisplayFormatString="C2"  ShowInCustomizationForm="True" VisibleIndex="17" FieldName="ValorMinAforo">
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle>
                                                                                         <PropertiesTextEdit DisplayFormatString="C2"></PropertiesTextEdit>
                                                                                    </dx:GridViewDataTextColumn>

                                                                        

                                                                                     <dx:GridViewDataTextColumn Caption="Monto Autorizado" Name="MontoAutorizado" Width="120" HeaderStyle-Wrap="True" PropertiesTextEdit-DisplayFormatString="C2"  ShowInCustomizationForm="True" VisibleIndex="4" FieldName="MontoAutorizado">
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle>
                                                                                         <PropertiesTextEdit DisplayFormatString="C2"></PropertiesTextEdit>
                                                                                    </dx:GridViewDataTextColumn>

                                                                                     <dx:GridViewDataTextColumn Caption="Tasa" Name="Tasa" Width="120" HeaderStyle-Wrap="True" ShowInCustomizationForm="True" VisibleIndex="6" FieldName="Tasa">
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle>
                                                                                     
                                                                                    </dx:GridViewDataTextColumn>

                                                                                     <dx:GridViewDataTextColumn Caption="Porcentaje Residual" Name="PorcentajeResidual" Width="120" HeaderStyle-Wrap="True"  ShowInCustomizationForm="True" VisibleIndex="10" FieldName="PorcentajeResidual">
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle>
                                                                                      
                                                                                    </dx:GridViewDataTextColumn>

                                                                                     <dx:GridViewDataTextColumn Caption="Antiguedad Fac Renovacion" Name="AntiguedadFacRenovacion" Width="120" HeaderStyle-Wrap="True"  ShowInCustomizationForm="True" VisibleIndex="15" FieldName="AntiguedadFacRenovacion">
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle>
                                                                                        
                                                                                    </dx:GridViewDataTextColumn>

                                                                                     <dx:GridViewDataTextColumn Caption="Plazo Ren Garantia" Name="PlazoRenGarantia" Width="120" HeaderStyle-Wrap="True"   ShowInCustomizationForm="True" VisibleIndex="18" FieldName="PlazoRenGarantia">
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle>
                                                                                       
                                                                                    </dx:GridViewDataTextColumn>

                                                                                     <dx:GridViewDataTextColumn Caption="Fecha Ult Renovacion" Name="FechaUltRenovacion" Width="120" HeaderStyle-Wrap="True"  ShowInCustomizationForm="True" VisibleIndex="19" FieldName="FechaUltRenovacion">
                                                                                        
                                                                                         <PropertiesTextEdit DisplayFormatString="MM/dd/yyyy">
                                                                                         </PropertiesTextEdit>
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle>
                                                                                    </dx:GridViewDataTextColumn>

                                                                                     <dx:GridViewDataTextColumn Caption="Quien le Pagan" Name="IdQuienlePagan" Width="120" HeaderStyle-Wrap="True"  ShowInCustomizationForm="True" VisibleIndex="21" FieldName="IdQuienlePagan">
                                                                                        <HeaderStyle Wrap="True"></HeaderStyle>
                                                                                         
                                                                                    </dx:GridViewDataTextColumn>

                                                                                    
                                                                                    
                                                                                    <dx:GridViewDataTextColumn Caption="Restriccion Acceso" FieldName="MesRestriccionAcceso" Name="MesRestriccionAcceso" ShowInCustomizationForm="True" VisibleIndex="8">
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    <dx:GridViewDataTextColumn Caption="Descuento Nota Credito" FieldName="DescuentoNotaCredito" ShowInCustomizationForm="True" Visible="False" VisibleIndex="11">
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    <dx:GridViewDataTextColumn Caption="PermitirSustitucionGarantia" FieldName="PermitirSustitucionGarantia" ShowInCustomizationForm="True" Visible="False" VisibleIndex="12">
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    <dx:GridViewDataTextColumn Caption="FactorAjuste" FieldName="FactorAjuste" ShowInCustomizationForm="True" Visible="False" VisibleIndex="13">
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    <dx:GridViewDataTextColumn Caption="RenovacionFlujo" FieldName="RenovacionFlujo" ShowInCustomizationForm="True" Visible="False" VisibleIndex="20">
                                                                                    </dx:GridViewDataTextColumn>
                                                                                    
                                                                                </Columns>
                                                                          
                                                                            </dx:ASPxGridView>
                                                    </dx:ContentControl>
                                                </ContentCollection>
                                            </dx:TabPage>
                                            <dx:TabPage Name="TabFrmFondeo" Text="Parametros Elegibilidad de Lineas de Fondeo">
                                                <ContentCollection>
                                                    <dx:ContentControl runat="server">
                                                        <table style="height: 100%; width: 100%;">
                                                            <tr>
                                                                <td >
                                                                    <table style="height: 100%; width: 100%;">
                                                                        <tr>
                                                                            <td>
                                                                                

                                                                                
                              <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="True"  HeaderText="Parametros Eligibilidad Lineas de Fondeo" Font-Bold="true" Font-Size="Medium"  Width="100%">
                                                 <PanelCollection>
                                                    <dx:PanelContent runat="server">


                                                                                                <table style="height: 100%; width: 100%;">  
                                                                                                    <tr>
                                                                                                        <td style="width:15%">
                                                                                                         
                                                                                                         <dx:ASPxLabel runat="server" Text="Asignar Fondo:" ClientInstanceName="LabelCmbFondo" Font-Size="Medium" ForeColor="Black" ID="LabelCmbFondo"></dx:ASPxLabel>

                                                                                                        </td>
                                                                                                        <td class="auto-style2">
                                                                                                            
                                                                                                             <dx:ASPxComboBox runat="server" ClientInstanceName="cboFdoBco" EnableClientSideAPI="True" ID="cboFdoBco">
                                                                                                            <ClientSideEvents SelectedIndexChanged="function(s, e) { AsignaNombre(s,e); }"></ClientSideEvents>
                                                                                                            </dx:ASPxComboBox>
                                                                                                       
                                                                                                        </td>  
                                                                                                                                                                                                         
                                                                                                        <td>
                                                                                                             
                                                                                                            <dx:ASPxLabel runat="server" Text="Nombre Fondo:" ClientInstanceName="lbl_NombreFondo" Font-Size="Medium" ForeColor="Black" ID="lbl_NombreFondo"></dx:ASPxLabel>

                                                                                                        </td>
                                                                                                        <td>
                                                                                                            
                                                                                                       <dx:ASPxTextBox ID="txt_NombreFondo" ClientInstanceName="txt_NombreFondo" AutoPostBack="false" EnableCallbackMode="false" Font-Size="Medium" ForeColor="Black" MaxLength="100" EnableClientSideAPI="true" runat="server" Width="170px" HorizontalAlign="Center"></dx:ASPxTextBox>
                                                                                                        </td>

                                                                                                        
                                                                                                            <td style="padding: 4px;">
                                                            </td>
                                                                                                        

                                                                                                  
                                                                                                        
                                                                                                        
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td class="auto-style2" >
                                                                                                             <dx:ASPxLabel ID="lbl_MontoAutorizado" ClientInstanceName="lbl_MontoAutorizado" runat="server" Font-Size="Medium" ForeColor="Black" Text="Monto Autorizado:"></dx:ASPxLabel>
                                                                                                        </td>
                                                                                                        <td class="auto-style2">

                                                                                                            <dx:ASPxTextBox ID="txt_MontoAutorizado" runat="server" ClientInstanceName="txt_MontoAutorizado"  Font-Size="Medium"  MaxLength="18" ForeColor="Black" Width="170px" Height="23px" DisplayFormatString="N2">
                                                                                                                <MaskSettings Mask="&lt;0..99999999g&gt;.&lt;0..99g&gt;" />
                                                                                                            </dx:ASPxTextBox>

                                                                                                         </td>
                                                                                                      
                                                                                                   
                                                                                                        <td class="auto-style2">
                                                                                                             <dx:ASPxLabel ID="lbl_FechaVencimiento" ClientInstanceName="lbl_FechaVencimiento"  Font-Size="Medium" ForeColor="Black" runat="server" Text="Fecha Vencimiento:"></dx:ASPxLabel>
                                                                                                        </td>
                                                                                                        <td class="auto-style2">

                                                                                                        

                                                                                                              <dx:ASPxDateEdit ID="txt_FechaVencimiento" ClientInstanceName="txt_FechaVencimiento" AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true" runat="server"></dx:ASPxDateEdit>


                                                                                                         </td>


                                                                                                      
                                                                                                    </tr>

                                                                                                    <tr>
                                                                                                        <td style="padding: 4px;">
                                                            </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                             <dx:ASPxLabel ID="lbl_AforoContractual" ClientInstanceName="lbl_AforoContractual" Font-Size="Medium" ForeColor="Black" runat="server" Text="Aforo Contractual:"></dx:ASPxLabel>
                                                                                                        </td>
                                                                                                        <td>

                                                                                                            <dx:ASPxTextBox ID="txt_AforoContractual" runat="server" ClientInstanceName="txt_AforoContractual" AutoPostBack="false" ForeColor="Black" MaxLength="10" Font-Size="Medium" EnableCallbackMode="false" EnableClientSideAPI="true" Width="170px" DisplayFormatString="N2">
                                                                                                                <MaskSettings Mask="&lt;0..99999g&gt;.&lt;0..99g&gt;" />
                                                                                                            </dx:ASPxTextBox>

                                                                                                         </td>
                                                                                                       
                                                                                                   
                                                                                                        <td>
                                                                                                             <dx:ASPxLabel ID="lbl_Tasa" ClientInstanceName="lbl_Tasa"  Font-Size="Medium" ForeColor="Black" runat="server" Text="Tasa:"></dx:ASPxLabel>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <dx:ASPxTextBox ID="txt_Tasa" runat="server" ClientInstanceName="txt_Tasa" AutoPostBack="false" Font-Size="Medium" ForeColor="Black" MaxLength="9" EnableCallbackMode="false" EnableClientSideAPI="true" Width="170px" DisplayFormatString="N2">
                                                                                                                <MaskSettings Mask="&lt;0..100g&gt;.&lt;0..99g&gt;" />
                                                                                                            </dx:ASPxTextBox>
                                                                                                        </td>
                                                                                                       
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td style="padding: 4px;">
                                                            </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                             <dx:ASPxLabel ID="lbl_PlazoDias" ClientInstanceName="lbl_PlazoDias"  Font-Size="Medium" ForeColor="Black"  runat="server" Text="Plazo en Dias:"></dx:ASPxLabel>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <dx:ASPxTextBox ID="txt_PlazoDias" runat="server" Font-Size="Medium" ForeColor="Black" MaxLength="5" ClientInstanceName="txt_PlazoDias" AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="True" Width="170px">
                                                                                                                <MaskSettings Mask="&lt;0..9999&gt;" />
                                                                                                                <ValidationSettings>
                                                                                                                    <RegularExpression ValidationExpression="\d+" />
                                                                                                                </ValidationSettings>
                                                                                                            </dx:ASPxTextBox>
                                                                                                        </td>
                                                                                                   
                                                                                                        <td>
                                                                                                             <dx:ASPxLabel ID="lbl_MesRestriccionAcceso" ClientInstanceName="lbl_MesRestriccionAcceso" Font-Size="Medium" ForeColor="Black" runat="server" Text="Meses Restriccion de Acceso:"></dx:ASPxLabel>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <dx:ASPxTextBox ID="txt_MesRestriccionAcceso" runat="server" ClientInstanceName="txt_MesRestriccionAcceso" Font-Size="Medium" ForeColor="Black" MaxLength="3" AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true" Width="170px">
                                                                                                                <MaskSettings Mask="&lt;0..99&gt;" />
                                                                                                                <ValidationSettings>
                                                                                                                    <RegularExpression ValidationExpression="\d+" />
                                                                                                                </ValidationSettings>
                                                                                                            </dx:ASPxTextBox>
                                                                                                        </td>
                                                                                                       
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td style="padding: 4px;">
                                                            </td>
                                                                                                    </tr>

                                                                                                    <tr>
                                                                                                         <td>
                                                                                                             <dx:ASPxLabel ID="lbl_IdValorAforoxEF" ClientInstanceName="lbl_IdValorAforoxEF" Font-Size="Medium" ForeColor="Black" runat="server" Text="Valor Aforo:"></dx:ASPxLabel>
                                                                                                        </td>
                                                                                                         <td>
                                                                                                             <dx:ASPxComboBox ID="cbo_IdValorAforoxEF" runat="server"  ClientInstanceName="cbo_IdValorAforoxEF" AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true">
                                                                                                            
                                                                                                             </dx:ASPxComboBox>
                                                                                                        </td>
                                                                                                         <td>
                                                                                                              <dx:ASPxLabel ID="lbl_PorcentajeResidual" ClientInstanceName="lbl_PorcentajeResidual" runat="server" Font-Size="Medium" ForeColor="Black" Text="Porcentaje Residual:"></dx:ASPxLabel>
                                                                                                         </td>
                                                                                                         <td>
                                                                                                            <dx:ASPxTextBox ID="txt_PorcentajeResidual" ClientInstanceName="txt_PorcentajeResidual" Font-Size="Medium" ForeColor="Black" MaxLength="9" AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true" runat="server" Width="170px" DisplayFormatString="N2">
                                                                                                                <MaskSettings Mask="&lt;0..100g&gt;.&lt;0..99g&gt;" />
                                                                                                             </dx:ASPxTextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td style="padding: 4px;">
                                                            </td>
                                                                                                    </tr>

                                                                                                    <tr>
                                                                                                        <td>
                                                                                                             <dx:ASPxLabel ID="lbl_DescuentoNotaCredito" ClientInstanceName="lbl_DescuentoNotaCredito" Font-Size="Medium" ForeColor="Black"  runat="server" Text="Descuento Nota Credito:"></dx:ASPxLabel>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <dx:ASPxRadioButtonList ID="rdo_DescuentoNotaCredito" ClientInstanceName="rdo_DescuentoNotaCredito"  AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true" runat="server" ValueType="System.String">
                                                                                                                <Items>
                                                                                                                    <dx:ListEditItem Text="Si" Value="1" />
                                                                                                                    <dx:ListEditItem Text="No" Value="0" />
                                                                                                                </Items>
                                                                                                            </dx:ASPxRadioButtonList>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <dx:ASPxLabel ID="lbl_PermitirSustitucionGarantia" ClientInstanceName="lbl_PermitirSustitucionGarantia" Font-Size="Medium" ForeColor="Black"  runat="server" Text="Permitir Sustitucion Garantia:"></dx:ASPxLabel>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <dx:ASPxRadioButtonList ID="txt_PermitirSustitucionGarantia" ClientInstanceName="txt_PermitirSustitucionGarantia" AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true" runat="server" ValueType="System.String">
                                                                                                                <Items>
                                                                                                                    <dx:ListEditItem Text="Si" Value="1" />
                                                                                                                    <dx:ListEditItem Text="No" Value="0" />
                                                                                                                </Items>
                                                                                                            </dx:ASPxRadioButtonList>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td style="padding: 4px;">
                                                            </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td>
                                                                                                              <dx:ASPxLabel ID="lbl_FactorAjuste" ClientInstanceName="lbl_FactorAjuste"  Font-Size="Medium" ForeColor="Black" runat="server" Text="Factor de Ajuste:"></dx:ASPxLabel>
                                                                                                        </td>
                                                                                                        <td>
                                                                                                            <dx:ASPxTextBox ID="txt_FactorAjuste" ClientInstanceName="txt_FactorAjuste" AutoPostBack="false"  Font-Size="Medium" ForeColor="Black" MaxLength="22" EnableCallbackMode="false" EnableClientSideAPI="true" runat="server" Width="170px" DisplayFormatString="N4">
                                                                                                                <MaskSettings Mask="&lt;0..99999999&gt;.&lt;0..9999&gt;" />
                                                                                                            </dx:ASPxTextBox>
                                                                                                        </td>
                                                                                                        <td></td>
                                                                                                        <td>
                                                                                                            <dx:ASPxTextBox ID="TxtIdLF" runat="server" ClientVisible="False" Width="170px" ClientInstanceName="TxtIdLF">
                                                                                                            </dx:ASPxTextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </dx:PanelContent>
                                                                                         </PanelCollection>
                                                                                    </dx:ASPxRoundPanel>

                                                                               
                                                                                 <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" ShowCollapseButton="True"  HeaderText="Marcas y Aseguradoras Linea de Fondeo" Font-Bold="true" Font-Size="Medium"  Width="100%">
                                                                                 <PanelCollection>
                                                                                 <dx:PanelContent runat="server">



                                                                                                <table style="height: 100%; width: 100%;">
                                                                                                    <tr>
                                                                                                        <td height="100px" align="right" rowspan="1" valign="top">
                                                                                            
                                                                                            <dx:ASPxListBox ID="txt_marca_id" runat="server" ClientInstanceName="txt_marca_id" AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true" ValueField ="marca_id" TextField="nombre" Width="221px">
                                                                                            
                                                                                                <ClientSideEvents SelectedIndexChanged="function(s, e) { UpdateButtonState(); }"></ClientSideEvents>
                                                                                                
                                                                                             </dx:ASPxListBox>
                                                                                                        </td>
                                                                                                        <td height="100px" >
                                                                                                            <table style="height: 100%; width: 100%;">
                                                                                                                <tr>
                                                                                                                    <td align="right" class="auto-style1" rowspan="1">                                                                         
                                                                                                                        <dx:ASPxButton ID="btnMoveSelectedItemsToRight" runat="server" ClientInstanceName="btnMoveSelectedItemsToRight"
                                                                                                                            AutoPostBack="False" Text="Agregar >" Width="130px" ClientEnabled="true"
                                                                                                                            ToolTip="Agregar Marca Seleccionada">
                                                                                                                            <ClientSideEvents Click="function(s, e) { AddSelectedItemsM(); }"></ClientSideEvents>
                                                                                                                        </dx:ASPxButton>
                                                                                                                        </td>
                                                                                                                    <td align="left" class="auto-style1">
                                                                                                                        <dx:ASPxButton ID="btnMoveAllItemsToRight" runat="server" ClientInstanceName="btnMoveAllItemsToRight"
                                                                                                                    AutoPostBack="False" Text="Agregar Todos >>" Width="130px" ToolTip="Agrega Todas las Marcas">
                                                                                                                    <ClientSideEvents Click="function(s, e) { AddAllItemsM(); }" />
                                                                                                                </dx:ASPxButton>
                                                                                                                        </td>
                                                                                                                </tr>
                                                                                                                <tr valign="top">
                                                                                                                    <td  align="right" rowspan="1">
                                                                                                                        <dx:ASPxButton ID="btnMoveSelectedItemsToLeft" runat="server" ClientInstanceName="btnMoveSelectedItemsToLeft"
                                                                                                                    AutoPostBack="False" Text="< Remover" Width="130px" ClientEnabled="true"
                                                                                                                    ToolTip="Remueve la Marca Seleccionada">
                                                                                                                    <ClientSideEvents Click="function(s, e) { RemoveSelectedItemsM(); }" />
                                                                                                                </dx:ASPxButton>
                                                                                                                        </td>
                                                                                                                    <td align="left">
                                                                                                                        <dx:ASPxButton ID="btnMoveAllItemsToLeft" runat="server" ClientInstanceName="btnMoveAllItemsToLeft"
                                                                                                                            AutoPostBack="False" Text="<< Remover Todo" Width="130px" ClientEnabled="true"
                                                                                                                            ToolTip="Remueve Todas las Marcas">
                                                                                                                            <ClientSideEvents Click="function(s, e) { RemoveAllItemsM(); }" />
                                                                                                                        </dx:ASPxButton>
                                                                                                                    </td>
                                                                                                                </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                        <td height="100px" align="left" valign="top">
                                                                                                            
                                                                                                            <dx:ASPxListBox ID="txt_marca_idSel" runat="server" ClientInstanceName="txt_marca_idSel" AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true" ValueField ="marca_id" TextField ="nombre" Width="221px">
                                                                                                       
                                                                                                 <ClientSideEvents SelectedIndexChanged="function(s, e) { UpdateButtonState(); }"></ClientSideEvents>
                                                                                             </dx:ASPxListBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    
                                                                                                    <tr>
                                                                                                        <td height="100 px" align="right">
                                                                                                             
                                                                                                             <dx:ASPxListBox ID="txt_No_aseg" runat="server" ClientInstanceName="txt_No_aseg" AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true" ValueType="System.String" ValueField ="nombre_aseg" Width="221px">
                                                                                                                 <Columns>
                                                                                                    
                                                                                                     <dx:ListBoxColumn Caption="Aseguradora" FieldName="nombre_aseg" Width="100px" />
                                                                                                </Columns>
                                                                                                 <ClientSideEvents SelectedIndexChanged="function(s, e) { UpdateButtonStateAseg(); }"></ClientSideEvents>

                                                                                            </dx:ASPxListBox>
                                                                                                         </td>
                                                                                                        <td>
                                                                                                            <table style="height: 100%; width: 100%;" frame="box">
                                                                                                                <tr>
                                                                                                                    <td  align="right" valign="bottom">
                                                                                                                        <dx:ASPxButton ID="btnMoveSelectedItemsToRightAseg" runat="server" ClientInstanceName="btnMoveSelectedItemsToRightAseg"
                                                                                                                        AutoPostBack="False" Text="Agregar >" Width="130px" ClientEnabled="true"
                                                                                                                        ToolTip="Agregar Aseguradora Seleccionada">
                                                                                                                        <ClientSideEvents Click="function(s, e) { AddSelectedItemsAseg(); }"></ClientSideEvents>
                                                                                                                    </dx:ASPxButton>
                                                                                                                     </td>
                                                                                                                    <td  align="left" valign="bottom">
                                                                                                                         <dx:ASPxButton ID="btnMoveAllItemsToRightAseg" runat="server" ClientInstanceName="btnMoveAllItemsToRightAseg"
                                                                                                                        AutoPostBack="False" Text="Agregar Todos >>" Width="130px" ToolTip="Agrega Todas las Marcas">
                                                                                                                        <ClientSideEvents Click="function(s, e) { AddAllItemsAseg(); }" />
                                                                                                                    </dx:ASPxButton>
                                                                                                                    </td>                                                                                         
                                                                                                                </tr>
                                                                                                                <tr>
                                                                                                                    <td  align ="right" >
                                                                                                                          <dx:ASPxButton ID="btnMoveSelectedItemsToLeftAseg" runat="server" ClientInstanceName="btnMoveSelectedItemsToLeftAseg"
                                                                                                                        AutoPostBack="False" Text="< Remover" Width="130px" ClientEnabled="true" HorizontalAlign="Center"   style="margin-left:87px"                                                                                                                     ToolTip="Remueve la Aseguradora Seleccionada">
                                                                                                                        <ClientSideEvents Click="function(s, e) { RemoveSelectedItemsAseg(); }" />
                                                                                                                    </dx:ASPxButton>
                                                                                                                    </td>
                                                                                                                    <td  align="left" valign="top">
                                                                                                                        <dx:ASPxButton ID="btnMoveAllItemsToLeftAseg" runat="server" ClientInstanceName="btnMoveAllItemsToLeftAseg"
                                                                                                                        AutoPostBack="False" Text="<< Remover Todo" Width="130px" ClientEnabled="true"
                                                                                                                        ToolTip="Remueve Todas las Aseguradora">
                                                                                                                        <ClientSideEvents Click="function(s, e) { RemoveAllItemsAseg(); }" />
                                                                                                                    </dx:ASPxButton>
                                                                                                                    </td>
                                                                                                               </tr>
                                                                                                            </table>
                                                                                                        </td>
                                                                                                        <td height="100 px" align="left">
                                                                                           
                                                                                             <dx:ASPxListBox ID="txt_No_asegSel" runat="server" ClientInstanceName="txt_No_asegSel" AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true" ValueField ="No_aseg" Width="221px">
                                                                                               
                                                                                                  <ClientSideEvents SelectedIndexChanged="function(s, e) { UpdateButtonStateAseg(); }"></ClientSideEvents>
                                                                                             </dx:ASPxListBox>
                                                                                        </td>
                                                                                                    </tr>
                                                                                                </table>
                                                                                            </dx:PanelContent>
                                                                                    </PanelCollection>
                                                                                    </dx:ASPxRoundPanel>
                                                                                
                                                                               
                                                                                 <dx:ASPxRoundPanel ID="ASPxRoundPanel4" runat="server" ShowCollapseButton="True"  HeaderText="Complementarios" Font-Bold="true" Font-Size="Medium"  Width="100%">
                                                                                  <PanelCollection>
                                                                                   <dx:PanelContent runat="server">



                                                                                                <table style="height: 100%; width: 100%;">
                                                                                                    <tr>
                                                                                                        <td style="width:15%" >
                                                                                                             <dx:ASPxLabel ID="lbl_AntiguedaMaxFac" ClientInstanceName="lbl_AntiguedaMaxFac" ForeColor="Black" Font-Size="Medium"
                                                                                                                 runat="server" Text="Antiguedad Máxima de la Factura en dias:"></dx:ASPxLabel>
                                                                                                        </td>
                                                                                                        
                                                                                                        <td style="width:35%">
                                                                                                            <dx:ASPxTextBox ID="txt_AntiguedaMaxFac" ClientInstanceName="txt_AntiguedaMaxFac"  ForeColor="Black" Font-Size="Medium"
                                                                                                                AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true" runat="server" Width="170px" MaxLength="5">
                                                                                                                <MaskSettings Mask="&lt;0..9999&gt;" />
                                                                                                                <ValidationSettings>
                                                                                                                    <RegularExpression ValidationExpression="\d+" />
                                                                                                                </ValidationSettings>
                                                                                                            </dx:ASPxTextBox>
                                                                                                        </td>
                                                                                                  
                                                                                                        <td style="width:15%">
                                                                                                             <dx:ASPxLabel ID="lbl_AntiguedadFacRenovacion" ClientInstanceName="lbl_AntiguedadFacRenovacion"  ForeColor="Black" Font-Size="Medium"
                                                                                                                 runat="server" Text="Antiguedad  Renovacion Factura (Meses):"></dx:ASPxLabel>
                                                                                                        </td>
                                                                                                        
                                                                                                        <td style="width:35%">
                                                                                                            <dx:ASPxTextBox ID="txt_AntiguedadFacRenovacion" ClientInstanceName="txt_AntiguedadFacRenovacion"  ForeColor="Black" Font-Size="Medium"
                                                                                                                AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true" runat="server" Width="170px" MaxLength="5">
                                                                                                                <MaskSettings Mask="&lt;0..9999&gt;" />
                                                                                                                <ValidationSettings>
                                                                                                                    <RegularExpression ValidationExpression="\d+" />
                                                                                                                </ValidationSettings>
                                                                                                            </dx:ASPxTextBox>
                                                                                                        </td>
                                                                                                    </tr>
                                                                                                    <tr>
                                                                                                        <td style="padding: 4px;">
                                                            </td>
                                                                                                        </tr>
                                                                                                    <tr>
                                                                                                        
                                                                                                        <td>
                                                                                                             <dx:ASPxLabel ID="lbl_ValorMinAforo" ClientInstanceName="lbl_ValorMinAforo"  ForeColor="Black" Font-Size="Medium"
                                                                                                                 runat="server" Text="Valor Mínimo Aforo:"></dx:ASPxLabel>
                                                                                                        </td>
                                                                                                       
                                                                                                       
                                                                                                        <td>
                                                                                                            <dx:ASPxTextBox ID="txt_ValorMinAforo" ClientInstanceName="txt_ValorMinAforo" ForeColor="Black" Font-Size="Medium"
                                                                                                                AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true" runat="server" Width="170px" MaxLength="18" DisplayFormatString="N2">
                                                                                                                <MaskSettings Mask="&lt;0..99999999g&gt;.&lt;0..99g&gt;" />
                                                                                                            </dx:ASPxTextBox>
                                                                                                        </td>
                                                                                                     
                                                                                                  
                                                                                                        <td>
                                                                                                             <dx:ASPxLabel ID="lbl_ValorMaxAforo" ClientInstanceName="lbl_ValorMaxAforo" ForeColor="Black" Font-Size="Medium"
                                                                                                                 runat="server" Text="Valor Máximo Aforo:"></dx:ASPxLabel>
                                                                                                        </td>
                                                                                                       
                                                                                                        <td>
                                                                                                            <dx:ASPxTextBox ID="txt_ValorMaxAforo" ClientInstanceName="txt_ValorMaxAforo"  ForeColor="Black" Font-Size="Medium"
                                                                                                                AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true" runat="server" Width="170px" MaxLength="18" DisplayFormatString="N2">
                                                                                                                <MaskSettings Mask="&lt;0..99999999g&gt;.&lt;0..99g&gt;" />
                                                                                                            </dx:ASPxTextBox>
                                                                                                        </td>
                                                                                                        </tr>
                                                                                                        <tr> <td style="padding: 4px;">
                                                            </td>
                                                                                                            </tr>
                                                                                                    <tr>
                                                                                                           <td>
                                                                                                             <dx:ASPxLabel ID="lbl_TipoOperacionxEF" ClientInstanceName="lbl_TipoOperacionxEF" ForeColor="Black" Font-Size="Medium"
                                                                                                                 runat="server" Text="Tipo Operacion:"></dx:ASPxLabel>
                                                                                                        </td>
                                                                                                        
                                                                                                        <td>
                                                                                                             <dx:ASPxComboBox ID="cbo_TipoOperacionxEF" runat="server"  ClientInstanceName="cbo_TipoOperacionxEF" AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true"></dx:ASPxComboBox>
                                                                                                        </td>
                                                                                                  
                                                                                                   
                                                                                                        <td>
                                                                                                             <dx:ASPxLabel ID="lbl_PlazoRenGarantia" ClientInstanceName="lbl_PlazoRenGarantia"  ForeColor="Black" Font-Size="Medium"
                                                                                                                 runat="server" Wrap="True" Text="Plazo Renovacion Garantia a la fecha de vencimiento del contrato en dias:"></dx:ASPxLabel>
                                                                                                        </td>
                                                                                                      
                                                                                                        <td>
                                                                                                            <dx:ASPxTextBox ID="txt_PlazoRenGarantia" ClientInstanceName="txt_PlazoRenGarantia"  ForeColor="Black" Font-Size="Medium"
                                                                                                                AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true" runat="server" Width="170px" MaxLength="5">
                                                                                                                <MaskSettings Mask="&lt;0..9999&gt;" />
                                                                                                                <ValidationSettings>
                                                                                                                    <RegularExpression ValidationExpression="\d+" />
                                                                                                                </ValidationSettings>
                                                                                                            </dx:ASPxTextBox>
                                                                                                        </td>
                                                                                                            </tr>

                                                                                                        <tr>
                                                                                                            <td style="padding: 4px;">
                                                            </td>
                                                                                                            </tr>
                                                                                                    <tr>
                                                                                                   
                                                                                                        <td >
                                                                                                             <dx:ASPxLabel ID="lbl_FechaUltRenovacion" ClientInstanceName="lbl_FechaUltRenovacion"  ForeColor="Black" Font-Size="Medium"
                                                                                                                 runat="server" Wrap="True" Text="Fecha Ult. Renovacion:"></dx:ASPxLabel>
                                                                                                        </td>
                                                                                                      
                                                                                                        <td>
                                                                                                            <dx:ASPxDateEdit ID="dt_FechaUltRenovacion" ClientInstanceName="dt_FechaUltRenovacion" AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true" runat="server"></dx:ASPxDateEdit>
                                                                                                        </td>
                                                                                                   
                                                                                                        <td>
                                                                                                            <dx:ASPxRadioButtonList ID="rdo_RenovacionFlujo" ClientInstanceName="rdo_RenovacionFlujo" AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true" runat="server" ValueType="System.Int32" Caption="Condiciones de Renovación:">
                                                                                                                 <Items>
                                                                                                                    <dx:ListEditItem Text="Renovavion con flujo" Value="1" />
                                                                                                                    <dx:ListEditItem Text="Renovacin sin flujo" Value="0" />
                                                                                                                </Items>
                                                                                                            </dx:ASPxRadioButtonList>
                                                                                                        </td>
                                                                                                   
                                                                                                        <td>
                                                                                                            <dx:ASPxRadioButtonList ID="rdo_IdQuienlePagan" ClientInstanceName="rdo_IdQuienlePagan" AutoPostBack="false" EnableCallbackMode="false" EnableClientSideAPI="true" runat="server" ValueType="System.Int32" Caption="A quien le pagan:">
                                                                                                                 <Items>
                                                                                                                    <dx:ListEditItem Text="DES" Value="1" />
                                                                                                                    <dx:ListEditItem Text="Agencia" Value="2" />
                                                                                                                    <dx:ListEditItem Text="Ambos" Value="3" />
                                                                                                                </Items>
                                                                                                            </dx:ASPxRadioButtonList>
                                                                                                        </td>

                                                                                                    </tr>
                                                                                                </table>
                                                                                            </dx:PanelContent>
                                                                                    </PanelCollection>
                                                                                     </dx:ASPxRoundPanel>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
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
<%--OnHtmlDataCellPrepared="gv_LineaFondeo_HtmlDataCellPrepared"--%>