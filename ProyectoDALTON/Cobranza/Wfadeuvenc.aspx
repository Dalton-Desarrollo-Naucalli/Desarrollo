<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Wfadeuvenc.aspx.vb" Inherits="MiFuncionalidad_Wfadeuvenc" %>
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
                                   <dx:ASPxLabel ID="ASPxLabel121" runat="server" Text="Nombre" Font-Size="Medium" Width="100%" Style="text-align: right"></dx:ASPxLabel>
                                </td>

                                <td>
                                    <dx:ASPxComboBox ID="ASPxComboBox1" runat="server" ClientInstanceName="estatus"  Theme="Office2010Blue">
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

                                <td>&nbsp;                             
                                                   
                                </td>
                                
                                <td >
                                   <dx:ASPxLabel ID="ASPxLabel122" runat="server" Text="VIN" Font-Size="Medium"  Style="text-align: right"></dx:ASPxLabel>
                                </td>

                                <td>
                                    <dx:ASPxComboBox ID="ASPxComboBox2" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue">
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

                                <td>&nbsp;                             
                                                   
                                </td>
                                
                                <td >
                                   <dx:ASPxLabel ID="ASPxLabel123" runat="server" Text="Referencia" Font-Size="Medium" Style="text-align: right"></dx:ASPxLabel>
                                </td>

                                <td>
                                    <dx:ASPxComboBox ID="ASPxComboBox3" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue">
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

                                <td>&nbsp;                             
                                                   
                                </td>


                                <td >
                                    <dx:ASPxLabel ID="ASPxLabel120" runat="server" Text="No. de contrato" Font-Size="Medium"  Style="text-align: right"></dx:ASPxLabel>
                                </td>

                                <td>
                                    <dx:ASPxComboBox ID="ASPxComboBox21" runat="server" ClientInstanceName="estatus" Width="350px" Theme="Office2010Blue">
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

                                              
        <dx:ASPxPageControl ID="prod" runat="server" ActiveTabIndex="2" EnableTheming="True" Theme="Office2010Blue" Width="100%">
                            <TabPages>

                                <dx:TabPage Name="tabMnto" Text="Adeudos vencidos ">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">      
                                            


                                              
                                            <br /> 
                                            <table style="width:100%">
                                                <tr>
                                                <td>
                                                    <asp:RadioButton ID="RadioButton1" runat="server" Text="Seguro" Font-Size="Medium" />
                                                </td>
                                                <td>
                                                    <asp:RadioButton ID="RadioButton2" runat="server"  Font-Size="Medium" Text="Renta" />
                                                </td>
                                                    <td>
                                                    <asp:RadioButton ID="RadioButton3" runat="server" Text="Iniciales"  Font-Size="Medium" />
                                                </td>
                                                    <td>
                                                       <dx:ASPxLabel ID="ASPxLabel133" runat="server" Text="Proceso" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxComboBox ID="ASPxComboBox4" runat="server" ValueType="System.String"></dx:ASPxComboBox>
                                                    </td>
                                                    </tr>
                                            </table>



                                       <table>
                                           <tr>
                                               <td width="6%">
                                               <dx:ASPxLabel ID="ASPxLabel17" runat="server" Text="Cliente" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td width="6%">
                                               <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Tipo de cliente" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td width="6%">
                                               <dx:ASPxLabel ID="ASPxLabel124" runat="server" Text="Tipo de adeudo" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td width="9%">
                                               <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Telefono" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td width="5%">
                                               <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Contrato" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td width="5%">
                                               <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Anexo" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td width="9%">
                                               <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Referencia" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td width="5%">
                                               <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Marca" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td width="5%">
                                               <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="Modelo" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td widyh="10%">
                                               <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="Vin" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td width="10%">
                                               <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="Fecha de vencimiento" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td width="6">
                                               <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="Días vencidos" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td width="6%">
                                               <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="Saldo vencido" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td width="9%">
                                               <dx:ASPxLabel ID="ASPxLabel12" runat="server" Text="Moratorios al día de hoy" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                               <td width="9%">
                                               <dx:ASPxLabel ID="ASPxLabel168" runat="server" Text="Saldo cuenta corriente" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                               <td width="9%">
                                               <dx:ASPxLabel ID="ASPxLabel128" runat="server" Text="Saldo notas de crédito pendientes de aplicar" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td width="9%">
                                               <dx:ASPxLabel ID="ASPxLabel13" runat="server" Text="Estatus" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                               
                                               </td>

                                           </tr>
                                           <tr>
                                               <td colspan="15">

                                               </td>
                                           </tr>
                                            <tr>
                                               <td colspan="15">

                                               </td>
                                           </tr>
                                           <tr>
                                               <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel14" runat="server" Text="Setweb SA" Font-Size="medium" font-underline="true" Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel15" runat="server" Text="Corporativo" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td width="6%">
                                               <dx:ASPxLabel ID="ASPxLabel125" runat="server" Text="Seguro" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel16" runat="server" Text="55456687" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel18" runat="server" Text="3453" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel19" runat="server" Text="9897" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel20" runat="server" Text="34537338479" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel21" runat="server" Text="JETTA" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel22" runat="server" Text="2017" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel23" runat="server" Text="3564WETR" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel24" runat="server" Text="09/08/2017" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel25" runat="server" Text="2" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel26" runat="server" Text="$3,000" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel27" runat="server" Text="$120,000" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel129" runat="server" Text="$20,000.00" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>

                                               <td width="9%">
                                               <dx:ASPxLabel ID="ASPxLabel169" runat="server" Text="$23,000.00" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel28" runat="server" Text="Promesa de pago" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                              <asp:Button ID="Button3" runat="server" Text="Alta acuerdo" />
                                               </td>
                                    
                                           </tr>
                                            <tr>
                                               <td colspan="15">

                                               </td>
                                           </tr>
                                            <tr>
                                               <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel29" runat="server" Text="Setweb SA" Font-Size="medium" font-underline="true" Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel30" runat="server" Text="Selecto" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td width="6%">
                                               <dx:ASPxLabel ID="ASPxLabel126" runat="server" Text="Iniciales" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel31" runat="server" Text="52393436" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel32" runat="server" Text="6743" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel33" runat="server" Text="1098" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel34" runat="server" Text="53827149053" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel35" runat="server" Text="JETTA" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel36" runat="server" Text="2017" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel37" runat="server" Text="4394WETR" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel38" runat="server" Text="10/08/2017" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel39" runat="server" Text="3" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel40" runat="server" Text="$2,500" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel41" runat="server" Text="$80,000" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                 <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel130" runat="server" Text="$10,000.00" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td width="9%">
                                               <dx:ASPxLabel ID="ASPxLabel170" runat="server" Text="$13,000.00" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel42" runat="server" Text="Promesa de pago" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                              <asp:Button ID="Button1" runat="server" Text="Alta acuerdo" />
                                               </td>
                                    
                                           </tr>
                                            <tr>
                                               <td colspan="15">

                                               </td>
                                           </tr>
                                            <tr>
                                               <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel43" runat="server" Text="Bimbo" Font-Size="medium" font-underline="true" Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel44" runat="server" Text="Agencia" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td width="6%">
                                               <dx:ASPxLabel ID="ASPxLabel127" runat="server" Text="Renta" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel45" runat="server" Text="52790345" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel46" runat="server" Text="5386" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel47" runat="server" Text="9753" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel48" runat="server" Text="34537356989" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel49" runat="server" Text="JETTA" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel50" runat="server" Text="2017" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel51" runat="server" Text="3464WETR" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel52" runat="server" Text="06/08/2017" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel53" runat="server" Text="4" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel54" runat="server" Text="$8,000" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel55" runat="server" Text="$65,000" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel131" runat="server" Text="$15,000.00" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td width="9%">
                                               <dx:ASPxLabel ID="ASPxLabel171" runat="server" Text="$5,000.00" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                               <dx:ASPxLabel ID="ASPxLabel56" runat="server" Text="Normal" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                
                                              <asp:Button ID="Button2" runat="server" Text="Alta acuerdo" />
                                               </td>
                                    
                                           </tr>
                                            <tr>
                                               <td colspan="15">

                                               </td>
                                           </tr>
                                           <tr>
                                               <td>

                                               </td>
                                               <td>

                                               </td>
                                                <td>

                                               </td>
                                                <td>

                                               </td>
                                                <td>

                                               </td>
                                                <td>

                                               </td>
                                                <td>

                                               </td>
                                                <td>

                                               </td>
                                                <td>

                                               </td>
                                               <td>

                                               </td>
                                               <td>

                                               </td>
                                                <td>
                                                     <dx:ASPxLabel ID="ASPxLabel57" runat="server" Text="Total" Font-Size="medium"   Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                     <dx:ASPxLabel ID="ASPxLabel58" runat="server" Text="$13,500" Font-Size="medium"   Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                                <td>
                                                     <dx:ASPxLabel ID="ASPxLabel59" runat="server" Text="$265,000" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                               <td width="9%">
                                               <dx:ASPxLabel ID="ASPxLabel172" runat="server" Text="$45,000.00" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                               <td>
                                                     <dx:ASPxLabel ID="ASPxLabel132" runat="server" Text="$41,000.00" Font-Size="medium"  Width="100%"  Style="text-align: center"></dx:ASPxLabel>
                                               </td>
                                           </tr>
                                       </table>





                              

                                
                                                    
                                        
                                      </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>





                                 <dx:TabPage Name="tabMnto" Text="Alta acuerdo moratorios webset">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">    



                                            <table>
                                                 <tr >
                                            <td style="width:40%" >
                                                <dx:ASPxLabel ID="ASPxLabel60" runat="server"  Text="Cliente" font-size="Medium">
                                                                                                                                    </dx:ASPxLabel>
                                           </td>
                                               
                                           
                          <td>
                                                  <dx:ASPxLabel ID="ASPxLabel61" runat="server"  Text="SetWeb SA" font-size="Medium">
                                                                                                                                    </dx:ASPxLabel>
                          </td>

                        

                                        </tr>
                 

                 

                
                                                </tr>
                 

                 

                
                      <tr >
                          <td colspan="2">&nbsp; </td>
                          <tr>
                              <td>
                                  <dx:ASPxLabel ID="ASPxLabel62" runat="server" Font-Size="Medium" Text="Telefono">
                                  </dx:ASPxLabel>
                              </td>
                              <td>
                                  <dx:ASPxLabel ID="ASPxLabel63" runat="server" Font-Size="Medium" Text="55446887">
                                  </dx:ASPxLabel>
                              </td>
                          </tr>
                          <tr>
                              <td colspan="2">&nbsp; </td>
                          </tr>
                          </tr>

                                            <tr >
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel87" runat="server" Font-Size="Medium" Text="Correo">
                                                    </dx:ASPxLabel>
                                                </td>
                                                <td style="border-color:black; border:solid; border-width:2px">
                                                    <dx:ASPxLabel ID="ASPxLabel92" runat="server" Font-Size="Medium" Text="alessanrror@hotmail.com">
                                                    </dx:ASPxLabel>
                                                </td></tr>
                                                 <tr>
                                                    <td colspan="2" > &nbsp; </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel64" runat="server" Font-Size="Medium" Text="Contrato">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel65" runat="server" Font-Size="Medium" Text="3453">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                   
                                                </tr>
                                                  <tr>
                                                    <td colspan="2" > &nbsp; </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel66" runat="server" Font-Size="Medium" Text="Anexo">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel67" runat="server" Font-Size="Medium" Text="9897">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td colspan="2" > &nbsp; </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel68" runat="server" Font-Size="Medium" Text="Referencia">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel69" runat="server" Font-Size="Medium" Text="234567891233">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                  <tr>
                                                    <td colspan="2" > &nbsp; </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel70" runat="server" Font-Size="Medium" Text="Marca">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel71" runat="server" Font-Size="Medium" Text="JETTA">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                  <tr>
                                                    <td colspan="2" > &nbsp; </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel72" runat="server" Font-Size="Medium" Text="Modelo">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel73" runat="server" Font-Size="Medium" Text="2017">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td colspan="2" > &nbsp; </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel74" runat="server" Font-Size="Medium" Text="VIN">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel75" runat="server" Font-Size="Medium" Text="3564WETR">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td colspan="2" > &nbsp; </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel76" runat="server" Font-Size="Medium" Text="Fecha vencimiento">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel77" runat="server" Font-Size="Medium" Text="07/08/2017">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">&nbsp; </td>
                                                </tr>
                                                  <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel144" runat="server" Font-Size="Medium" Text="Mensualidades">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel145" runat="server" Font-Size="Medium" Text="23/35">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">&nbsp; </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel78" runat="server" Font-Size="Medium" Text="Saldo vencido">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel79" runat="server" Font-Size="Medium" Text="$3000.00">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">&nbsp; </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel80" runat="server" Font-Size="Medium" Text="Moratorios al dia de hoy">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel81" runat="server" Font-Size="Medium" Text="$300">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                     </tr>
                                                 <tr>
                                                    <td colspan="6" > &nbsp; </td>
                                                </tr>



                                               
                                                   <tr> <td>
                                                        <dx:ASPxLabel ID="ASPxLabel82" runat="server" Font-Size="Medium" Text="Fecha promesa de pago">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel83" runat="server" Font-Size="Medium" Text="16/08/17">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6" > &nbsp; </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel84" runat="server" Font-Size="Medium" Text="Dias vencidos">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel85" runat="server" Font-Size="Medium" Text="9">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6" > &nbsp; </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel86" runat="server" Font-Size="Medium" Text="Monto moratorios a la fecha compromiso">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel88" runat="server" Font-Size="Medium" Text="$540.00">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td colspan="2" > &nbsp; </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel89" runat="server" Font-Size="Medium" Text="Bonificacion moratorios">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td style="border-color:black; border:solid; border-width:2px">&nbsp;<dx:ASPxLabel ID="ASPxLabel90" runat="server" Font-Size="Medium" Text="$100.00">
                                                        </dx:ASPxLabel>
                                                    </td>

                                                    <td style="width:5%">

                                                    </td>
                                                 <td>

                                                        <dx:ASPxButton ID="ASPxButton5" runat="server" Font-Size="Medium" Text="Autorizar">
                                                        </dx:ASPxButton>
                                                    </td>
                                                    <td style="width:5%">

                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel98" runat="server" Font-Size="small" font-underline="true" Text="Autorizó Verónica Díaz">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td style="width:5%">

                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel99" runat="server" Font-Size="small" style="text-align:right"  font-underline="true" Text="Autorizó Alessandro del Campo">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                 <tr>
                                                    <td colspan="2" > &nbsp; </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel91" runat="server" Font-Size="Medium" Text="Monto a pagar moratorios">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel95" runat="server" Font-Size="Medium" Text="$440">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                   
                                                </tr>
                                                 <tr>
                                                    <td colspan="2" > &nbsp; </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel100" runat="server" Font-Size="Medium" Text="IVA Moratorios">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel101" runat="server" Font-Size="Medium" Text="$66.00">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel93" runat="server" Font-Size="Medium" Text="Renta">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel94" runat="server" Font-Size="Medium" Text="$3,000.00">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel96" runat="server" Font-Size="Medium" Text="$Total">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel97" runat="server" Font-Size="Medium" Text="$3,446.00">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" > &nbsp; </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel146" runat="server" Font-Size="Medium" Text="Histora comentarios:">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                       <%--<dx:ASPxMemo ID="ASPxMemo1" runat="server"  Height="90px" Width="300px" OnTextChanged="ASPxMemo1_TextChanged"></dx:ASPxMemo>--%>
                                                    </td>
                                                </tr>
                                                    <tr>
                                                    <td colspan="2" > &nbsp; </td>
                                                </tr>
                                       
                                                 <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel147" runat="server" Font-Size="Medium" Text="Nuevo comentario:">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <%--<dx:ASPxMemo ID="ASPxMemo2" runat="server"  Height="50px" Width="300px" OnTextChanged="ASPxMemo1_TextChanged"></dx:ASPxMemo>--%>
                                                    </td>

                                                     
                                                </tr>
                                                <tr>
                                                    <td colspan="2" > &nbsp; </td>
                                                </tr>
                                                <tr>
                                                    <td>

                                                    </td>
                                                    <td>
                                                        <asp:Button ID="Button6" runat="server" Text="Guardar comentario" />
                                                    </td>
                                                </tr>
                                                    <tr>
                                                    <td>
                                                        <dx:ASPxButton ID="ASPxButton1" runat="server" Font-Size="Medium" Text="Registrar acuerdo">
                                                        </dx:ASPxButton>
                                                    </td>
                                                </tr>
                                           

                                            </table>


                                                
                                      </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>

                                                 


                                            
                                 <dx:TabPage Name="tabMnto" Text="Contacto Bimbo">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">    


                                            <table  style="width:100%">



                                                 <tr>
                                                    <td style="width:40%">
                                                         <dx:ASPxLabel ID="ASPxLabel142" runat="server" Font-Size="Medium" Text="Nombre de la agencia:">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel143" runat="server" Font-Size="Medium" Text="Bimbo">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>



                                                
                                                  <tr>
                                                      <td colspan="2">&nbsp;
                                                        </td>
                                                  </tr>


                                                 <tr>
                                                    <td style="width:40%">
                                                         <dx:ASPxLabel ID="ASPxLabel134" runat="server" Font-Size="Medium" Text="No. de identificación:">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel135" runat="server" Font-Size="Medium" Text="9653876309">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>



                                                
                                                  <tr>
                                                      <td colspan="2">&nbsp;
                                                        </td>
                                                  </tr>

                                                   <tr>
                                                    <td style="width:40%">
                                                         <dx:ASPxLabel ID="ASPxLabel136" runat="server" Font-Size="Medium" Text="Domicilio:">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel137" runat="server" Font-Size="Medium" Text="Paseo de los gigantes #77, Mayorazgoz de los gigantes, Atizapan de zaragoza ">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>



                                                
                                                  <tr>
                                                      <td colspan="2">&nbsp;
                                                        </td>
                                                  </tr>

                                                  <tr>
                                                    <td style="width:40%">
                                                         <dx:ASPxLabel ID="ASPxLabel138" runat="server" Font-Size="Medium" Text="Domicilio aval:">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel139" runat="server" Font-Size="Medium" Text="Colima #76, Colonia roma, Miguel hidalgo, CDMX ">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>



                                                
                                                  <tr>
                                                      <td colspan="2">&nbsp;
                                                        </td>
                                                  </tr>
                                                  <tr>
                                                    <td style="width:40%">
                                                         <dx:ASPxLabel ID="ASPxLabel140" runat="server" Font-Size="Medium" Text="VIN:">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel141" runat="server" Font-Size="Medium" Text="645387923465">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>



                                                
                                                  <tr>
                                                      <td colspan="2">&nbsp;
                                                        </td>
                                                  </tr>

                                                <tr>
                                                    <td style="width:40%">
                                                         <dx:ASPxLabel ID="ASPxLabel102" runat="server" Font-Size="Medium" Text="Telefono 1:">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel103" runat="server" Font-Size="Medium" Text="0445514658099">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>


                                                 <tr >
                          <td colspan="2">&nbsp; </td>
                                                  </tr>





                                                 <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel104" runat="server" Font-Size="Medium" Text="Telefono 2:">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel105" runat="server" Font-Size="Medium" Text="52159911">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>

                                                

                                                 <tr >
                          <td colspan="2">&nbsp; </td>
                                                  </tr>


                                                 <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel106" runat="server" Font-Size="Medium" Text="Correo:">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel107" runat="server" Font-Size="Medium" Text="carlosv.bimbo@gmail.com">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>


                                                

                                                 <tr >
                          <td colspan="2">&nbsp; </td>
                                                  </tr>


                                                 <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel108" runat="server" Font-Size="Medium" Text="Aval:">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel109" runat="server" Font-Size="Medium" Text="Carlos Perez  66725598">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>

                                                

                                                 <tr >
                          <td colspan="2">&nbsp; </td>
                                                  </tr>


                                                 <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel110" runat="server" Font-Size="Medium" Text="Referencia 1:">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel111" runat="server" Font-Size="Medium" Text="Maria Díaz Ramirez  55221166">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>

                                                

                                                 <tr >
                          <td colspan="2">&nbsp; </td>
                                                  </tr>


                                                 <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel112" runat="server" Font-Size="Medium" Text="Referencia 2:">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel113" runat="server" Font-Size="Medium" Text="Juan Lopez Posos  55352760">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                 <tr >
                          <td colspan="2">&nbsp; </td>
                                                  </tr>
                                                <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel114" runat="server" Font-Size="Medium" Text="Datos del apoderado:">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel115" runat="server" Font-Size="Medium" Text="Manuel Lopéz  55352760">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                 <tr >
                          <td colspan="2">&nbsp; </td>
                                                  </tr>
                                                <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel116" runat="server" Font-Size="Medium" Text="Línea de fondeo asignada:">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel117" runat="server" Font-Size="Medium" Text="BURSA">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                 <tr >
                          <td colspan="2">&nbsp; </td>
                                                  </tr>
                                                <tr>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel118" runat="server" Font-Size="Medium" Text="Tipo de cliente:">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                         <dx:ASPxLabel ID="ASPxLabel119" runat="server" Font-Size="Medium" Text="Agencia">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">
                                                        &nbsp;

                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="Button4" runat="server" Text="Aviso de bloqueo" />
                                                    </td>
                                                    <td>
                                                        <asp:Button ID="Button5" runat="server" Text="Aviso de desbloqueo" />
                                                    </td>
                                                </tr>
                                            </table>





                                                </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>



                                 <dx:TabPage Name="tabMnto" Text="Historial cobranza">
                                    <ContentCollection>
                                        <dx:ContentControl runat="server">    


                                            <table  style="width:100%">

                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel148" runat="server" Font-Size="Medium" Text="No. de pago">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel149" runat="server" Font-Size="Medium" Text="Vencimiento">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                    <dx:ASPxLabel ID="ASPxLabel150" runat="server" Font-Size="Medium" Text="Rentas">
                                                        </dx:ASPxLabel>
                                                        </td>
                                                     <td>
                                                    <dx:ASPxLabel ID="ASPxLabel151" runat="server" Font-Size="Medium" Text="IVA de interes">
                                                        </dx:ASPxLabel>
                                                        </td>
                                                     <td>
                                                    <dx:ASPxLabel ID="ASPxLabel152" runat="server" Font-Size="Medium" Text="Pago mensual">
                                                        </dx:ASPxLabel>
                                                        </td>
                                                     <td>
                                                    <dx:ASPxLabel ID="ASPxLabel173" runat="server" Font-Size="Medium" Text="Saldo">
                                                        </dx:ASPxLabel>
                                                        </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel153" runat="server" Font-Size="Medium" Text="1">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel154" runat="server" Font-Size="Medium" Text="01/05/17">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                    <dx:ASPxLabel ID="ASPxLabel155" runat="server" Font-Size="Medium" Text="$6,000.00">
                                                        </dx:ASPxLabel>
                                                        </td>
                                                     <td>
                                                    <dx:ASPxLabel ID="ASPxLabel156" runat="server" Font-Size="Medium" Text="$960.00">
                                                        </dx:ASPxLabel>
                                                        </td>
                                                     <td>
                                                    <dx:ASPxLabel ID="ASPxLabel157" runat="server" Font-Size="Medium" Text="$6,960.00">
                                                        </dx:ASPxLabel>
                                                        </td>
                                                    <td>
                                                    <dx:ASPxLabel ID="ASPxLabel174" runat="server" Font-Size="Medium" Text="$76,560.00">
                                                        </dx:ASPxLabel>
                                                        </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel158" runat="server" Font-Size="Medium" Text="2">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel159" runat="server" Font-Size="Medium" Text="01/06/17">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                    <dx:ASPxLabel ID="ASPxLabel160" runat="server" Font-Size="Medium" Text="$6,000.00">
                                                        </dx:ASPxLabel>
                                                        </td>
                                                     <td>
                                                    <dx:ASPxLabel ID="ASPxLabel161" runat="server" Font-Size="Medium" Text="$960.00">
                                                        </dx:ASPxLabel>
                                                        </td>
                                                     <td>
                                                    <dx:ASPxLabel ID="ASPxLabel162" runat="server" Font-Size="Medium" Text="$6,960.00">
                                                        </dx:ASPxLabel>
                                                        </td>
                                                     <td>
                                                    <dx:ASPxLabel ID="ASPxLabel175" runat="server" Font-Size="Medium" Text="$69,600.00">
                                                        </dx:ASPxLabel>
                                                        </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>

                                                <tr>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel163" runat="server" Font-Size="Medium" Text="3">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                        <dx:ASPxLabel ID="ASPxLabel164" runat="server" Font-Size="Medium" Text="01/07/17">
                                                        </dx:ASPxLabel>
                                                    </td>
                                                    <td>
                                                    <dx:ASPxLabel ID="ASPxLabel165" runat="server" Font-Size="Medium" Text="$6,000.00">
                                                        </dx:ASPxLabel>
                                                        </td>
                                                     <td>
                                                    <dx:ASPxLabel ID="ASPxLabel166" runat="server" Font-Size="Medium" Text="$960.00">
                                                        </dx:ASPxLabel>
                                                        </td>
                                                     <td>
                                                    <dx:ASPxLabel ID="ASPxLabel167" runat="server" Font-Size="Medium" Text="$6,960.00">
                                                        </dx:ASPxLabel>
                                                        </td>
                                                     <td>
                                                    <dx:ASPxLabel ID="ASPxLabel176" runat="server" Font-Size="Medium" Text="$62,640.00">
                                                        </dx:ASPxLabel>
                                                        </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2">&nbsp;
                                                        </td>
                                                </tr>



                                               
                                            </table>





                                                </dx:ContentControl>
                                    </ContentCollection>
                                </dx:TabPage>







                                <%--pagos clientes--%>
                            </TabPages>
                        </dx:ASPxPageControl>




                                  <br />
                 <br />
                 <br />
                 &nbsp;+<br />




                                  </dx:PanelContent>
          </PanelCollection>
         </dx:ASPxRoundPanel>







                            



               





        <div>
        </div>
    </form>
</body>
</html>
