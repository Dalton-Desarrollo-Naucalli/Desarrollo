<%@ Page Language="VB" AutoEventWireup="true" CodeFile="WfGestionDeCobranza.aspx.vb" Inherits="Cobranza_WfGestionDeCobranza" %>
<%@ Register Assembly="DevExpress.Data.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Gestión de Cobraza con Promesa de Pago, Moratorios y Bonificación</title>
    <link href="../Estilos/Principal.css" type="text/css" rel="stylesheet" />   
  


</head>
<body>
    <form id="form1" runat="server">



        <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" ShowCollapseButton="True" ShowHeader="False" Theme="Office2003Blue" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <table class="auto-style40">
                        <tr>
                            <td>
                                <dx:ASPxButton ID="btnAgregar" runat="server" ToolTip="Agregar" ClientInstanceName="btnAgregar" AutoPostBack="False" EnableClientSideAPI="false">
                                    <ClientSideEvents Click="function(s, e) {OnNewRowClicked();}" />
                                    <Image IconID="actions_add_32x32"/>
                                </dx:ASPxButton>
                            </td>
                            <td>
                                <dx:ASPxButton ID="btnEditar" runat="server" ToolTip="Editar" ClientInstanceName="btnEditar" AutoPostBack="False" EnableClientSideAPI="false">
                                    <ClientSideEvents Click="function(s, e) {OnEditRowClicked();}" />
                                    <Image IconID="edit_edit_32x32"/>
                                </dx:ASPxButton>
                            </td>
                            <td>
                                <dx:ASPxButton ID="btnEliminar" runat="server" ToolTip="Eliminar" AutoPostBack="False" ClientInstanceName="btnEliminar" EnableClientSideAPI="True">
                                    <ClientSideEvents Click="function(s, e) {OnConfirmDeleteRowsClicked();}" />
                                    <Image IconID="edit_delete_32x32"/>
                                </dx:ASPxButton>
                            </td>
                            <td>
                                <dx:ASPxButton ID="btnCancelar" runat="server" AutoPostBack="False" ClientInstanceName="btnCancelar" ToolTip="Cancelar" EnableClientSideAPI="True">
                                    <ClientSideEvents Click="function(s, e) {OnDiscardChangesClicked();}" />
                                    <Image IconID="actions_cancel_32x32"/>
                                </dx:ASPxButton>
                            </td>
                            <td>
                                <dx:ASPxButton ID="btnAplicar" runat="server" AutoPostBack="False" ClientInstanceName="btnAplicar" ToolTip="Aplicar" ValidationGroup="reqError1" EnableClientSideAPI="true" CausesValidation="False">
                                    <ClientSideEvents Click="function(s, e) {OnSaveChangesClicked();}" />
                                    <Image IconID="actions_apply_32x32"/>
                                </dx:ASPxButton>
                            </td>
                            <td>
                                <dx:ASPxButton ID="btnFiltrar" runat="server" AutoPostBack="False" ClientInstanceName="btnFiltrar" ToolTip="Filtrar" EnableClientSideAPI="True">
                                    <ClientSideEvents Click="function(s, e) {OnFilterClicked(); }" />
                                        <Image IconID="filter_filter_32x32"/>
                                </dx:ASPxButton> 
                            </td>
                            <td> 
                                <dx:ASPxButton ID="btnBuscar" runat="server" ClientInstanceName="btnBuscar" ToolTip="Buscar"  EnableClientSideAPI="True">
                                    <Image IconID="find_find_32x32"/>
                                </dx:ASPxButton> 
                            </td>
                            <td> 
                                <dx:ASPxButton ID="btnDeshacer" runat="server" ClientInstanceName="btnDeshacer" ToolTip="Deshacer" AutoPostBack="False" EnableClientSideAPI="True">
                                    <ClientSideEvents Click="function(s, e) {OnUndoChangesClicked(); }" />
                                        <Image IconID="history_undo_32x32"/>
                                </dx:ASPxButton>
                            </td>
                            <td>
                                <dx:ASPxButton ID="btnRehacer" runat="server" ClientInstanceName="btnRehacer" ToolTip="Rehacer" AutoPostBack="False" EnableClientSideAPI="True">
                                    <ClientSideEvents Click="function(s, e) {OnRedoChangesClicked();}" />
                                    <Image IconID="history_redo_32x32" />
                                </dx:ASPxButton>
                            </td>
                        </tr>
                    </table>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>

        <br />
        
        <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" ShowCollapseButton="True" ShowHeader="False" Width="100%" Theme="Office2003Blue">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <table style="width:100%">
                        <tr>
                            <td style="text-align:center">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblNombre" runat="server" Text="Nombre:"/>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="comboNombre" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="text-align:center">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblVIN" runat="server" Text="VIN:"/>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="comboVIN" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="text-align:center">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblReferencia" runat="server" Text="Referencia:"/>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="comboReferencia" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="text-align:center">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblNoDeContrato" runat="server" Text="No. de Contrato:"/>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="comboNoDeContrato" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
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
                    <dx:ASPxPageControl ID="prod" runat="server" EnableTheming="True" Theme="Office2010Blue" Width="100%">
                        <TabPages>
                            <dx:TabPage Name="tabMnto" Text="Adeudos Vencidos" Enabled="true">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                        <table style="width:100%" border="0" >
                                            <tr>
                                                <td style="text-align:left">
                                                    <table style="width:100%" border="0">
                                                        <tr>
                                                            <td style="text-align:center; width:15%">
                                                                <asp:RadioButton ID="radioSeguro" Text="Seguro" runat="server" GroupName="radioAdeudosVencidos" />
                                                            </td>
                                                            <td style="text-align:center; width:35%">
                                                                <asp:RadioButton ID="radioRenta" Text="Renta" runat="server" GroupName="radioAdeudosVencidos" />
                                                            </td>
                                                            <td style="text-align:center; width:15%">
                                                                <asp:RadioButton ID="radioIniciales" Text="Iniciales" runat="server" GroupName="radioAdeudosVencidos" />
                                                            </td>
                                                            <td style="text-align:center; width:35%">
                                                                <table style="width:100%">
                                                                    <tr>
                                                                        <td>
                                                                            <dx:ASPxLabel ID="lblEstatus" runat="server" Text="Estatus:"/>&nbsp;&nbsp;
                                                                        </td>
                                                                        <td>
                                                                            <dx:ASPxComboBox ID="comboEstatus" runat="server"/>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr style="height:20px"></tr>
                                                        <tr>
                                                            <td colspan="4" >
                                                                <table style="width:100%; border-width:thick ">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
<%--                                            <tr>
                                                <td style="text-align:center">
                                                    <table class="dxrpControl_Office2010Blue" style="width: 100%; border-collapse: initial; background-color:#E8F4F7">
                                                        <tr>
                                                            <td style="text-align">
                                                                <dx:ASPxGridView ID="gridAdeudosVencidos" runat="server" Width="100%"></dx:ASPxGridView>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>--%>
<%--                                            <tr>
                                                <td>
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxGridView ID="grid" ClientInstanceName="grid" runat="server" AutoGenerateColumns="False" Width="100%">
                                                                    <Columns>
                                                                        <dx:GridViewCommandColumn ShowNewButton="true" ShowEditButton="true" VisibleIndex="0" ButtonRenderMode="Image">
                                                                            <CustomButtons>
                                                                                <dx:GridViewCommandColumnCustomButton ID="Clone">
                                                                                    <Image ToolTip="Clone Record" Url="Images/clone.png" />
                                                                                </dx:GridViewCommandColumnCustomButton>
                                                                            </CustomButtons>
                                                                        </dx:GridViewCommandColumn>
                                                                        <dx:GridViewDataTextColumn FieldName="FirstName" VisibleIndex="1">
                                                                            <EditFormSettings VisibleIndex="0" />
                                                                        </dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataColumn FieldName="Title" VisibleIndex="4">
                                                                            <EditFormSettings VisibleIndex="1" />
                                                                        </dx:GridViewDataColumn>
                                                                        <dx:GridViewDataMemoColumn FieldName="Notes" Visible="False">
                                                                            <EditFormSettings RowSpan="4" Visible="True" VisibleIndex="2" />
                                                                        </dx:GridViewDataMemoColumn>
                                                                        <dx:GridViewDataColumn FieldName="LastName" VisibleIndex="2">
                                                                            <EditFormSettings VisibleIndex="3" />
                                                                        </dx:GridViewDataColumn>
                                                                        <dx:GridViewDataColumn FieldName="BirthDate" VisibleIndex="3">
                                                                            <EditFormSettings VisibleIndex="4" />
                                                                        </dx:GridViewDataColumn>
                                                                        <dx:GridViewDataColumn FieldName="HireDate" VisibleIndex="5">
                                                                            <EditFormSettings VisibleIndex="5" />
                                                                        </dx:GridViewDataColumn>
                                                                    </Columns>
                                                                    <SettingsEditing EditFormColumnCount="3" />
                                                                    <SettingsPager Mode="ShowAllRecords" />
                                                                    <SettingsCommandButton>
                                                                        <NewButton>
                                                                            <Image ToolTip="New" Url="Images/new.png" />
                                                                        </NewButton>
                                                                        <EditButton>
                                                                            <Image ToolTip="Edit" Url="Images/edit.png" />
                                                                        </EditButton>
                                                                        <UpdateButton RenderMode="Image">
                                                                            <Image ToolTip="Save changes and close Edit Form" Url="Images/update.png" />
                                                                        </UpdateButton>
                                                                        <CancelButton RenderMode="Image">
                                                                            <Image ToolTip="Close Edit Form without saving changes" Url="Images/cancel.png" />
                                                                        </CancelButton>
                                                                    </SettingsCommandButton>
                                                                    <Styles>
                                                                        <CommandColumn Spacing="2px" Wrap="False" />
                                                                    </Styles>
                                                                </dx:ASPxGridView>


                                                            </td>
                                                        </tr>
                                                    </table>

                                                </td>
                                            </tr>--%>
                                        </table>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                       
                            <dx:TabPage Name="tabMnto" Text="Alta acuerdo de pago a capital y moratorios">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                        <table style="width:100%" border="0" >
                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="0">
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblCliente" runat="server" Text="Cliente:"/>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtCliente" runat="server" Width="250px" NullText="Cliente..." />
                                                            </td>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblAnexoDomiciliario" runat="server" Text="Anexo Domiciliario"/>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtAnexoDomiciliario" runat="server" Width="250px" NullText="01 Cuenta Inexistente" />
                                                            </td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblTelefono" runat="server" Text="Teléfono:"/>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtTelefono" runat="server" Width="250px" NullText="Teléfono..." />
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblCorreo" runat="server" Text="Correo"/>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtCorreo" runat="server" Width="250px" NullText="Correo..." />
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblContrato" runat="server" Text="Contrato"/>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtContrato" runat="server" Width="250px" NullText="Contrato..." />
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblAnexo1" runat="server" Text="Anexo"/>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtAnexo1" runat="server" Width="250px" NullText="Anexo..." />
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblReferencia2" runat="server" Text="Referencia"/>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtReferencia2" runat="server" Width="250px" NullText="Referencia..." />
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblMarca" runat="server" Text="Marca"/>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtMarca" runat="server" Width="250px" NullText="Marca..." />
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblModelo" runat="server" Text="Modelo"/>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtModelo" runat="server" Width="250px" NullText="Modelo..." />
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblVIN1" runat="server" Text="VIN"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtVIN1" runat="server" Width="250px" NullText="VIN..." />
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblFechaVencimiento" runat="server" Text="Fecha Vencimiento"/>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtFechaVencimiento" runat="server" Width="250px" NullText="Fecha Vencimiento..." />
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblMensualidades" runat="server" Text="Mensualidades"/>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtMensualidades" runat="server" Width="250px" NullText="Mensualidades..." />
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblSaldoVencido" runat="server" Text="Saldo vencido"/>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtSaldoVencido" runat="server" Width="250px" NullText="Saldo vencido..." />
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblMoratoriosHoy" runat="server" Text="Moratorios al dia de hoy"/>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtMoratoriosHoy" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblFechaPromesaDePago" runat="server" Text="Fecha promesa de pago"/>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtFechaPromesaDePago" runat="server" Width="250px" NullText="Fecha promesa de Pago..." />
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblDiasVencidos" runat="server" Text="Días vencidos"/>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtDiasVencidos" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblMontoMoratoriosFechaCompromiso" runat="server" Text="Monto moratorios a la fecha compromiso"/>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                <dx:ASPxTextBox ID="txtMontoMoratoriosFechaCompromiso" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                <dx:ASPxLabel ID="lblBonificacionMoratorios" runat="server" Text="Bonificación moratorios:"/>
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>
                                                        <tr style="height:7px"></tr>
                                                        <tr>
                                                            <td style="width:15%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:35%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:15%; text-align:left"></td>
                                                            <td style="width:35%; text-align:left"></td>
                                                        </tr>

                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                        <table style="width:100%" border="0" >
                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">

                                                    </table>
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                <dx:ASPxLabel ID="lblEstatus1" runat="server" Text="Estatus"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                <dx:ASPxLabel ID="txtEstatus1" runat="server" Text="Siniestrado"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                   
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                   
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                  
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                <dx:ASPxLabel ID="ASPxLabel36" runat="server" Text="Contrato:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                <dx:ASPxLabel ID="ASPxLabel37" runat="server" Text="3453"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                <dx:ASPxLabel ID="ASPxLabel38" runat="server" Text="Contrato:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                <dx:ASPxLabel ID="ASPxLabel39" runat="server" Text="3453"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                <dx:ASPxLabel ID="ASPxLabel40" runat="server" Text="Contrato:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                <dx:ASPxLabel ID="ASPxLabel41" runat="server" Text="3453"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                <dx:ASPxLabel ID="ASPxLabel42" runat="server" Text="Contrato:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                <dx:ASPxLabel ID="ASPxLabel43" runat="server" Text="3453"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                <dx:ASPxLabel ID="lblAnexo" runat="server" Text="Anexo:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                <dx:ASPxLabel ID="txtAnexo" runat="server" Text="9897"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                <dx:ASPxLabel ID="lblReferencia1" runat="server" Text="Referencia:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                <dx:ASPxLabel ID="txtReferencia1" runat="server" Text="234567891233"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>


                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                <dx:ASPxLabel ID="ASPxLabel48" runat="server" Text="Contrato:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                <dx:ASPxLabel ID="ASPxLabel49" runat="server" Text="3453"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">
                                                                
                                                            </td>
                                                            <td style="width:75%; text-align:left">
                                                                
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>




                                        </table>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>

                            <dx:TabPage Name="tabMnto" Text="Contacto" ClientEnabled="true">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                        <table style="width:100%" border="0" >
                                            <tr>
                                                <td style="text-align:center">
                                                    <table style="width:100%" border="0" >
                                                        <tr>
                                                            <td style="text-align:center">
                                                                <table style="width:100%; font-size:large" border="0">
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblNombreDeLaAgencia" runat="server" Text="Nombre de la agencia:" CssClass="GlobalSubtitulo"></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxLabel ID="txtNombreDeLaAgencia" runat="server" Text="Bimbo" CssClass="GlobalTitulo"></dx:ASPxLabel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblNumeroDeContratoGBR" runat="server" Text="Número de Contrato GBR:" CssClass="GlobalSubtitulo"></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxLabel ID="txtNumeroDeContratoGBR" runat="server" Text="9653876309" CssClass="GlobalTitulo"></dx:ASPxLabel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblDomicilio" runat="server" Text="Domicilio:" CssClass="GlobalSubtitulo"></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxLabel ID="txtDomicilio" runat="server" Text="Paseo de los gigantes #77, Mayorazgoz de los gigantes, Atizapan de Zaragoza" CssClass="GlobalTitulo"></dx:ASPxLabel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblDomicilioAval" runat="server" Text="Domicilio Aval:" CssClass="GlobalSubtitulo"></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxLabel ID="txtDomicilioAval" runat="server" Text="Colima # 76, Colonia Roma, Miguel Hidalgo, CDMX"></dx:ASPxLabel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="VIN:" CssClass="GlobalSubtitulo"></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxLabel ID="txtVIN" runat="server" Text="645387923465"></dx:ASPxLabel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblTelefono1" runat="server" Text="Teléfono1:" CssClass="GlobalSubtitulo"></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxLabel ID="txtTelefono1" runat="server" Text="0445514658099"></dx:ASPxLabel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblTelefono2" runat="server" Text="Teléfono2:" CssClass="GlobalSubtitulo"></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxLabel ID="txtTelefono2" runat="server" Text="52159911"></dx:ASPxLabel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Correo:" CssClass="GlobalSubtitulo"></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="carlosv.bimbo@gmail.com"></dx:ASPxLabel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblAval" runat="server" Text="Aval:" CssClass="GlobalSubtitulo"></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxLabel ID="txtAval" runat="server" Text="Carlos Pérez 66725598"></dx:ASPxLabel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="Referencia1:" CssClass="GlobalSubtitulo"></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="María Díaz Ramírez 55221166"></dx:ASPxLabel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Referencia2:" CssClass="GlobalSubtitulo"></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="Juan López Pasos 55352760"></dx:ASPxLabel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblDatosDelApoderado" runat="server" Text="Datos del Apoderado:" CssClass="GlobalSubtitulo"></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxLabel ID="txtDatosDelApoderado" runat="server" Text="Manuel López 55352760"></dx:ASPxLabel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblLineaDeFondeoAsignada" runat="server" Text="Linea de Fondeo Asignada:" CssClass="GlobalSubtitulo"></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxLabel ID="txtLineaDeFondeoAsignada" runat="server" Text="BURSA"></dx:ASPxLabel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblTipoDeCliente" runat="server" Text="Tipo de Cliente:" CssClass="GlobalSubtitulo"></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxLabel ID="txtTipoDeCliente" runat="server" Text="Agencia"></dx:ASPxLabel>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxButton ID="buttonBloqueo" runat="server" Text="Aviso de Bloqueo" AutoPostBack="true"  />
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxButton ID="buttonDesbloqueo" runat="server" Text="Aviso de Desbloqueo" AutoPostBack="true" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>                               
                                        </table>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>

                            <dx:TabPage Name="tabMnto" Text="Tabla de pagos">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                        <table style="width:100%; border-width:thick ">
                                            <tr>
                                                <td>
                                                    <asp:PlaceHolder ID="PlaceHolderTablaDeAmortizacion" runat="server"></asp:PlaceHolder>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align:right">
                                                    <table border="1" style="width:50%">
                                                        <tr>
                                                            <td>Descargar PDF</td>
                                                            <td style="width:30px"></td>
                                                            <td>Enviar Correo</td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>

                            <dx:TabPage Name="tabMnto" Text="Estado de cuenta">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                        <table style="width:100%" border="0" >
                                            <tr>
                                                <td style="text-align:center">
                                                    <table style="width:100%">
                                                        <tr>
                                                            <td style="width:10%; text-align:right">
                                                                <dx:ASPxLabel ID="ASPxLabel14" runat="server" Text="Cliente:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:5px"></td>
                                                            <td style="text-align:left">
                                                                <dx:ASPxLabel ID="ASPxLabel15" runat="server" Text="WEBSET SA de CV"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align:left">
                                                    <table style="width:100%">
                                                        <tr>
                                                            <td style="text-align:center">
                                                                <asp:RadioButton ID="RadioButton10" Text="Iniciales" runat="server" GroupName="radioTipoFactura" />
                                                            </td>
                                                            <td style="text-align:center">
                                                                <asp:RadioButton ID="RadioButton11" Text="Rentas" runat="server" GroupName="radioTipoFactura" />
                                                            </td>
                                                            <td style="text-align:center">
                                                                <asp:RadioButton ID="RadioButton12" Text="Otros" runat="server" GroupName="radioTipoFactura" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="dxrpHeader_Office2010Blue dx-borderBox"  style="width:100%; background-color:#E8F4F7">
                                                  <table class="dxrpControl_Office2010Blue" style="width: 100%; border-collapse: initial;">
                                                        <tr>
                                                            <td class="dxrpHeader_Office2010Blue dx-borderBox" style="text-align:left">
                                                                <dx:ASPxLabel ID="ASPxLabel16" runat="server" Text="Renta" Style="text-align:left"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <table class="dxrpControl_Office2010Blue" style="width: 100%; border-collapse: initial;">
                                                                    <tr>
                                                                        <td style="text-align">
                                                                            <dx:ASPxGridView ID="ASPxGridView7" runat="server" Width="100%" ></dx:ASPxGridView>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr style="height:25px"><td></td></tr>
                                                        <tr>
                                                            <td style="text-align:left">
                                                                <table class="dxrpControl_Office2010Blue" style="width: 100%; border-collapse: initial;background-color:#E8F4F7">
                                                                    <tr>
                                                                        <td class="dxrpHeader_Office2010Blue dx-borderBox" style="text-align:left">
                                                                            <dx:ASPxLabel ID="ASPxLabel17" runat="server" Text="Crédito" Style="text-align:left"></dx:ASPxLabel>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="text-align:center">
                                                                <table class="dxrpControl_Office2010Blue" style="width: 100%; border-collapse: initial; background-color:#E8F4F7">
                                                                    <tr>
                                                                        <td style="text-align">
                                                                            <dx:ASPxGridView ID="ASPxGridView8" runat="server" Width="100%"></dx:ASPxGridView>
                                                                        </td>
                                                                    </tr>
                                                                </table>
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
                    </dx:ASPxPageControl>
                </dx:PanelContent>
          </PanelCollection>
        </dx:ASPxRoundPanel>
    </form>



</body>
</html>




