<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Wfentregaanti.aspx.vb" Inherits="MiFuncionalidad_Wfentregaanti" %>
<%@ Register Assembly="DevExpress.Data.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">




        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />




 <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" ShowCollapseButton="True" ShowHeader="False" Theme="Office2003Blue" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">

                   

                        




        
                    &nbsp;<table class="auto-style40">
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
                <td> <dx:ASPxButton ID="btnBuscar" runat="server" ClientInstanceName="btnBuscar" ToolTip="Buscar"  EnableClientSideAPI="True">
                                 <Image IconID="find_find_32x32">
                                                            </Image>
                                                            </dx:ASPxButton> </td>
                <td> <dx:ASPxButton ID="btnDeshacer" runat="server" ClientInstanceName="btnDeshacer" ToolTip="Deshacer" AutoPostBack="False" EnableClientSideAPI="True">
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


                                
               </tr>
               </table>
             </dx:PanelContent>
          </PanelCollection>
         </dx:ASPxRoundPanel>


        <br />





           <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" ShowCollapseButton="True" ShowHeader="False" Theme="Office2003Olive" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">


                        <table>

                            <tr>

                                <td >
                                   <dx:ASPxLabel ID="ASPxLabel121" runat="server" Text="Linea de fondeo" Font-Size="Medium" Width="100%" Style="text-align: right"></dx:ASPxLabel>
                                </td>

                                <td>
                                    <dx:ASPxComboBox ID="ASPxComboBox10" runat="server" ClientInstanceName="estatus"  Theme="Office2010Blue">
                                        <Items>
                                            <dx:ListEditItem Text="Nombre.1" Value="1" />
                                            <dx:ListEditItem Text="Nombre.2" Value="1" />
                                            <dx:ListEditItem Text="Nombre.3" Value="1" />
                                            <dx:ListEditItem Text="Nombre.4" Value="1" />
                                            <dx:ListEditItem Text="Nombre.5" Value="1" />
                                            <dx:ListEditItem Text="Nombre.6" Value="1" />
                                        </Items>
                                    </dx:ASPxComboBox>
                                </td>

                               </tr>


                        </table>

                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>


<br />

        
         <dx:ASPxRoundPanel ID="ASPxRoundPanel3" runat="server" ShowCollapseButton="True" ShowHeader="False" Theme="Office2003Blue" Width="100%">
          <PanelCollection>
             <dx:PanelContent runat="server">



         <dx:ASPxPageControl ID="prod" runat="server" ActiveTabIndex="0" EnableTheming="True" Theme="Office2010Blue" Width="100%">
                            <TabPages>

                               <dx:TabPage Name="tabMnto" Text="Autos pendientes por facturar-entrega anticipada">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">  



                                              <table style="width:100%">
                                                  <tr>
                                                      <td style="width:30%">
                                                          <asp:RadioButton ID="RadioButton1" Text="Con compromiso de pago" style="Font-Size:medium" runat="server" />
                                                      </td>
                                                      
                                                      <td>
                                                          <asp:RadioButton ID="RadioButton2" Text="Pagados" style="Font-Size:medium" runat="server" />
                                                      </td>
                                                      <td>
                                                          <asp:RadioButton ID="RadioButton3" Text="Pendientes" style="Font-Size:medium" runat="server" />
                                                      </td>
                                                  </tr>

                                                  </table>
                                            <br />
                                            <br />


                                            <table style="width:100%">
                                                <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel48" runat="server" Font-Size="Small" Text="Contrato">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td style="text-align:center">
                                                         <dx:ASPxLabel ID="ASPxLabel49" runat="server" Font-Size="small" Text="Anexo">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td style="text-align:center">
                                                         <dx:ASPxLabel ID="ASPxLabel50" runat="server" style="text-align:center" Font-Size="Medium" Text="VIN">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td style="text-align:center">
                                                         <dx:ASPxLabel ID="ASPxLabel51" runat="server" style="text-align:center" Font-Size="Medium" Text="Arrendatario">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel52" runat="server" Font-Size="Small" Text="Cliente a facturar">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel53" runat="server" Font-Size="Small" Text="Monto de pago">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel54" runat="server" Font-Size="Small" Text="Fecha ultima renta pagada">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td >
                                                         <dx:ASPxLabel ID="ASPxLabel55" runat="server" Font-Size="Small" Text="Rentas pagadas">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td >
                                                         <dx:ASPxLabel ID="ASPxLabel56" runat="server" Font-Size="Small" Text="Rentas vencidas">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel20" runat="server" Font-Size="Small" Text="Fecha limite de pago">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel21" runat="server" Font-Size="Small" Text="Estatus de terminación">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                <td colspan="2">&nbsp;
                                                        </td>
                                                    </tr>
                                                <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel57" runat="server" Font-Size="Small" Text="7462">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td style="text-align:center">
                                                         <dx:ASPxLabel ID="ASPxLabel58" runat="server" style="text-align:center" Font-Size="Small" Text="8365">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel59" runat="server" Font-Size="Small" Text="846296583651" Width="80%">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td style="text-align:center">
                                                         <dx:ASPxLabel ID="ASPxLabel60" runat="server" Font-Size="Small" style="text-align:center" Text="Transportes sur S.A">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel61" runat="server" Font-Size="Small" Text="Pedro Juarez García">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel62" runat="server" Font-Size="Small" Text="150,000.00">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel63" runat="server" Font-Size="Small" Text="20/08/2017">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                          <dx:ASPxLabel ID="ASPxLabel64" runat="server" Font-Size="Small" Text="12/36">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel65" runat="server" Font-Size="Small" Text="2">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel120" runat="server" Font-Size="Small" Text="20/08/2017">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel122" runat="server" Font-Size="Small" Text="Pendiete">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr> <tr>
                                                <td colspan="2">&nbsp;
                                                        </td>
                                                    </tr>
                                                <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel66" runat="server" Font-Size="Small" Text="7453">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td style="text-align:center">
                                                         <dx:ASPxLabel ID="ASPxLabel67" runat="server" style="text-align:center" Font-Size="Small" Text="9864">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel68" runat="server" Font-Size="Small" Text="846286452956">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td style="text-align:center">
                                                         <dx:ASPxLabel ID="ASPxLabel69" runat="server" style="text-align:center" Font-Size="Small" Text="Maria Gonzalez Martinez">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel70" runat="server" Font-Size="Small" Text="Claudia Hernandez Silva">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel71" runat="server" Font-Size="Small" Text="230,000.00">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel72" runat="server" Font-Size="Small" Text="15/08/2017">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel73" runat="server" Font-Size="Small" Text="20/24">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel74" runat="server" Font-Size="Small" Text="2">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel123" runat="server" Font-Size="Small" Text="17/08/2017">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel124" runat="server" Font-Size="Small" Text="Promesa de pago">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                <td colspan="2">&nbsp;
                                                        </td>
                                                    </tr>
                                                <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel75" runat="server" Font-Size="Small" Text="3452">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td style="text-align:center">
                                                         <dx:ASPxLabel ID="ASPxLabel76" runat="server" style="text-align:center" Font-Size="Small" Text="9832">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel77" runat="server" Font-Size="Small" Text="846382745275">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td style="text-align:center">
                                                         <dx:ASPxLabel ID="ASPxLabel78" runat="server" Font-Size="Small" style="text-align:center" Text="Luis Rmirez Perez">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel79" runat="server" Font-Size="Small" Text="Dalton Polanco">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel80" runat="server" Font-Size="Small" Text="170,000.00">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel81" runat="server" Font-Size="Small" Text="08/08/2017">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel82" runat="server" Font-Size="Small" Text="30/36">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel83" runat="server" Font-Size="Small" Text="0">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel125" runat="server" Font-Size="Small" Text="23/08/2017">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel126" runat="server" Font-Size="Small" Text="Pagado">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                <td colspan="2">&nbsp;
                                                        </td>
                                                    </tr>
                                                <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel84" runat="server" Font-Size="Small" Text="7634">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td style="text-align:center">
                                                         <dx:ASPxLabel ID="ASPxLabel85" runat="server" style="text-align:center" Font-Size="Small" Text="7453">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel86" runat="server" Font-Size="Small" Text="927645173629">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td style="text-align:center">
                                                         <dx:ASPxLabel ID="ASPxLabel87" runat="server" style="text-align:center" Font-Size="Small" Text="Claudia Hernandez Lozano">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel88" runat="server" Font-Size="Small" Text="Andres lopez Gama">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel89" runat="server" Font-Size="Small" Text="200,000.00">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel90" runat="server" Font-Size="Small" Text="11/08/2017">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel91" runat="server" Font-Size="Small" Text="30/48">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel92" runat="server" Font-Size="Small" Text="0">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel127" runat="server" Font-Size="Small" Text="16/08/2017">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel128" runat="server" Font-Size="Small" Text="Pagado">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                <td colspan="2">&nbsp;
                                                        </td>
                                                    </tr>
                                                <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel93" runat="server" Font-Size="Small" Text="7634">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td style="text-align:center">
                                                         <dx:ASPxLabel ID="ASPxLabel94" runat="server" style="text-align:center" Font-Size="Small" Text="1293">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel95" runat="server" Font-Size="Small" Text="748394567123">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td style="text-align:center">
                                                         <dx:ASPxLabel ID="ASPxLabel96" runat="server" style="text-align:center" Font-Size="Small" Text="Berenice Robles Mancera">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel97" runat="server" Font-Size="Small" Text="Ericka Jimenez Martinez">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel98" runat="server" Font-Size="Small" Text="345,000.00">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel99" runat="server" Font-Size="Small" Text="20/08/2017">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel100" runat="server" Font-Size="Small" Text="20/24">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel101" runat="server" Font-Size="Small" Text="1">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel129" runat="server" Font-Size="Small" Text="21/08/2017">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel130" runat="server" Font-Size="Small" Text="Pendiente">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                <td colspan="2">&nbsp;
                                                        </td>
                                                    </tr>
                                                <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel102" runat="server" Font-Size="Small" Text="7534">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td style="text-align:center">
                                                         <dx:ASPxLabel ID="ASPxLabel103" runat="server" style="text-align:center" Font-Size="Small" Text="8635">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel104" runat="server" Font-Size="Small" Text="345823401243">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td style="text-align:center">
                                                         <dx:ASPxLabel ID="ASPxLabel105" runat="server" Font-Size="Small" Text="Jesus Cortez Mrtinez">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel106" runat="server" style="text-align:center" Font-Size="Small" Text="Antonio Lopez Vazquez">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel107" runat="server" Font-Size="Small" Text="143,000.00">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel108" runat="server" Font-Size="Small" Text="10/08/2017">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel109" runat="server" Font-Size="Small" Text="35/36">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel110" runat="server" Font-Size="Small" Text="1">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel131" runat="server" Font-Size="Small" Text="28/08/2017">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel132" runat="server" Font-Size="Small" Text="Promesa de pago">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                <td colspan="2">&nbsp;
                                                        </td>
                                                    </tr>
                                                <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel111" runat="server" Font-Size="Small" Text="5483">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td style="text-align:center">
                                                         <dx:ASPxLabel ID="ASPxLabel112" runat="server" style="text-align:center" Font-Size="Small" Text="9832">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel113" runat="server" Font-Size="Small" Text="746287187324">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td style="text-align:center">
                                                         <dx:ASPxLabel ID="ASPxLabel114" runat="server" style="text-align:center" Font-Size="Small" Text="Jose Garcia Hernandez">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel115" runat="server" Font-Size="Small" Text="Sandra Romero Avila">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel116" runat="server" Font-Size="Small" Text="187,000.00">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel117" runat="server" Font-Size="Small" Text="30/08/2017">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel118" runat="server" Font-Size="Small" Text="30/48">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel119" runat="server" Font-Size="Small" Text="0">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel133" runat="server" Font-Size="Small" Text="12/08/2017">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel134" runat="server" Font-Size="Small" Text="Pagado">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                            </table>

                                              </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>





                                             <dx:TabPage Name="tabMnto" Text="Solicitud de facturación activo fijo-entrega anticipada">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server"> 


                                             <table class="dxrpControl_Office2010Blue" id="pba" style="width: 100%; border-collapse: initial;background-color:#E8F4F7">

                                            <tr>
                                                <td  colspan="4"     class="dxrpHeader_Office2010Blue dx-borderBox" style="width:100%">
                                                      <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Ingresos" Font-Size="medium" Width="20%"   Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                               
                                            </tr>
                                                  <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>
                                                 <tr>
                                                     <td>
                                                          <dx:ASPxLabel ID="ASPxLabel18" runat="server" Font-Size="Medium" style="text-align:right" Text="Estatus:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                          <dx:ASPxLabel ID="ASPxLabel19" runat="server" Font-Size="Medium" style="text-align:right" Text="Pagado">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                          &nbsp;</td>
                                                 </tr>
                                                  <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>
                                                 <tr>
                                                    
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel3" runat="server" Font-Size="Medium" style="text-align:right" Text="Contrato:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel1" runat="server" Font-Size="Medium" style="text-align:right" Text="64563">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel2" runat="server" Font-Size="Medium" style="text-align:right" Text="Anexo:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel4" runat="server" Font-Size="Medium" style="text-align:right" Text="5555">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                 </tr>
                                                  <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>
                                                  <tr>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel5" runat="server" Font-Size="Medium" style="text-align:right" Text="Monto residual sin IVA:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td >
                                                         <dx:ASPxLabel ID="ASPxLabel7" runat="server" Font-Size="Medium" style="text-align:right" Text="$147,000.00">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel8" runat="server" Font-Size="Medium" style="text-align:right" Text="Monto por pagar con IVA:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td >
                                                         <dx:ASPxLabel ID="ASPxLabel9" runat="server" Font-Size="Medium" style="text-align:right" Text="$150,000.00">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                 </tr>
                                                  <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>
                                                  <tr>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel10" runat="server" Font-Size="Medium" style="text-align:right" Text="Referencia de pago:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel11" runat="server" Font-Size="Medium" style="text-align:right" Text="2345673486473879">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel12" runat="server" Font-Size="Medium" style="text-align:right" Text="Monto rentas pendientes:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel13" runat="server" Font-Size="Medium" style="text-align:right" Text="$20,000.00">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                 </tr>
                                                  <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>
                                                  <tr>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel14" runat="server" Font-Size="Medium" style="text-align:right" Text="Fecha de pago:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel15" runat="server" Font-Size="Medium" style="text-align:right" Text="25/08/2017">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel16" runat="server" Font-Size="Medium" style="text-align:right" Text="Monto recibido:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel17" runat="server" Font-Size="Medium" style="text-align:right" Text="$170,000.00">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                 </tr>
                                                  <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>
                                                 <tr>
                                                  
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel135" runat="server" Font-Size="Medium" style="text-align:right" Text="Arrendatario:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel136" runat="server" Font-Size="Medium" style="text-align:right" Text="Claudia Hernandez Paredes">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel137" runat="server" Font-Size="Medium" style="text-align:right" Text="Facturación:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel138" runat="server" Font-Size="Medium" style="text-align:right" Text="Dalton Polanco S.A">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                 </tr>
                                                  <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>
                                                 <tr>
                                                 <td>
                                                         <dx:ASPxLabel ID="ASPxLabel139" runat="server" Font-Size="Medium" style="text-align:right" Text="Fecha vencimiento contrato:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel140" runat="server" Font-Size="Medium" style="text-align:right" Text="11/08/2017">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel141" runat="server" Font-Size="Medium" style="text-align:right" Text="Dias de vencimiento:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel142" runat="server" Font-Size="Medium" style="text-align:right" Text="30/48">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                     </tr>
                                                
                                                  <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>
                                                  
                                                
                                           


                                                 </table>
                                            <br />
                                             <table class="dxrpControl_Office2010Blue" id="pba" style="width: 100%; border-collapse: initial;background-color:#E8F4F7">

                                            <tr>
                                                <td  colspan="4"     class="dxrpHeader_Office2010Blue dx-borderBox" style="width:100%">
                                                      <dx:ASPxLabel ID="ASPxLabel22" runat="server" Text="Datos del vehiculo" Font-Size="medium" Width="20%"   Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                               
                                            </tr>
                                                  <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>
                                                 <tr>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel23" runat="server" Font-Size="Medium" style="text-align:right" Text="Vin:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel24" runat="server" Font-Size="Medium" style="text-align:right" Text="123434565678">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                     
                                                 </tr>
                                                  <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>
                                                  <tr>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel27" runat="server" Font-Size="Medium" style="text-align:right" Text="Marca:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel28" runat="server" Font-Size="Medium" style="text-align:right" Text="VW">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel29" runat="server" Font-Size="Medium" style="text-align:right" Text="Sub marca:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel30" runat="server" Font-Size="Medium" style="text-align:right" Text="Jetta GL team">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                 </tr>
                                                  <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>
                                                  <tr>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel31" runat="server" Font-Size="Medium" style="text-align:right" Text="Modelo:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel32" runat="server" Font-Size="Medium" style="text-align:right" Text="2015">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel33" runat="server" Font-Size="Medium" style="text-align:right" Text="Serie:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel34" runat="server" Font-Size="Medium" style="text-align:right" Text="9876896789697">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                 </tr>
                                                  <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>
                                                  <tr>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel35" runat="server" Font-Size="Medium" style="text-align:right" Text="Otras caracteristicas:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td style="width:90%" colspan="3">
                                                         <dx:ASPxLabel ID="ASPxLabel36" runat="server" Style="width:100px; height:45px" Font-Size="Medium"  Text="Automatico, A.C, paquete de seguridad, paquete de entretenimiento, electrico">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                     
                                                 </tr>

                                           


                                                 </table>

                                             <br />
                                             <table class="dxrpControl_Office2010Blue" id="pba" style="width: 100%; border-collapse: initial;background-color:#E8F4F7">

                                            <tr>
                                                <td  colspan="2"     class="dxrpHeader_Office2010Blue dx-borderBox" style="width:100%">
                                                      <dx:ASPxLabel ID="ASPxLabel25" runat="server" Text="Datos de facturación" Font-Size="medium" Width="20%"   Style="text-align: left"></dx:ASPxLabel>
                                                </td>
                                               
                                            </tr>
                                                  <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>
                                                 <tr>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel26" runat="server" Font-Size="Medium" style="text-align:right" Text="Razón social:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel37" runat="server" Font-Size="Medium" style="text-align:right" Text="Dalton Polanco S.A">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                     
                                                 </tr>
                                                  <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>
                                                  <tr>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel38" runat="server" Font-Size="Medium" style="text-align:right" Text="R.F.C:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel39" runat="server" Font-Size="Medium" style="text-align:right" Text="DPC9001011U1">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      
                                                 </tr>
                                                  <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>
                                                  <tr>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel42" runat="server" Font-Size="Medium" style="text-align:right" Text="Dirección fiscal:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td>
                                                         <dx:ASPxLabel ID="ASPxLabel43" runat="server" Font-Size="Medium" style="text-align:right" Text="Reforma 25,col. Juarez,Del, Miguel Hidalgo, C.P, 06100, CDMX">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                     
                                                 </tr>
                                                  <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>
                                                  <tr>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel46" runat="server" Font-Size="Medium" style="text-align:right" Text="Monto sin IVA:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td style="width:90%">
                                                         <dx:ASPxLabel ID="ASPxLabel47" runat="server" Style="width:100px; height:45px" Font-Size="Medium"  Text="$126,000.00">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                     
                                                 </tr>
                                                  <tr>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel40" runat="server" Font-Size="Medium" style="text-align:right" Text="IVA:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td style="width:90%">
                                                         <dx:ASPxLabel ID="ASPxLabel41" runat="server" Style="width:100px; height:45px" Font-Size="Medium"  Text="$24,000.00">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                     
                                                 </tr>
                                                  <tr>
                                                     <td>
                                                         <dx:ASPxLabel ID="ASPxLabel44" runat="server" Font-Size="Medium" style="text-align:right" Text="Total:">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                      <td style="width:90%">
                                                         <dx:ASPxLabel ID="ASPxLabel45" runat="server" Style="width:100px; height:45px" Font-Size="Medium"  Text="$150,000.00">
                                                        </dx:ASPxLabel>
                                                     </td>
                                                     
                                                 </tr>

                                           


                                                 </table>
                                            <br />

                                            <table style="width:100%">

                                               <tr>
                                                   <td style="width:20%">
                                            <asp:Button ID="Button1" runat="server" Text="Cancelar" />
                                                       </td>
                                                   <td>
                                             <asp:Button ID="Button2" runat="server" Text="Facturar" />
                                                       </td>
                                                 </tr>
                                                </table>
                                                  
                                                  
                                              </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>




                                
                                     <%--pagos clientes--%>
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
