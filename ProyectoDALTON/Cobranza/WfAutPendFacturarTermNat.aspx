<%@ Page Language="VB" AutoEventWireup="true" CodeFile="WfAutPendFacturarTermNat.aspx.vb" Inherits="Cobranza_WfAutPendFacturarTermNat" %>
<%@ Register Assembly="DevExpress.Data.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Autos pendientes por facturar terminación natural</title>
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

                            <dx:TabPage Name="tabMnto" Text="Autos pendientes por facturar" Enabled="true">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                        <table style="width:100%" border="0" >
                                            <tr>
                                                <td style="text-align:left">
                                                    <table style="width:100%" border="0">
                                                        <tr>
                                                            <td style="text-align:center; width:25%">
                                                                <asp:RadioButton ID="radioSeguro" Text="Seguro" runat="server" GroupName="radioAdeudosVencidos" />
                                                            </td>
                                                            <td style="text-align:center; width:25%">
                                                                <asp:RadioButton ID="radioRenta" Text="Renta" runat="server" GroupName="radioAdeudosVencidos" />
                                                            </td>
                                                            <td style="text-align:center; width:25%">
                                                                <asp:RadioButton ID="radioIniciales" Text="Iniciales" runat="server" GroupName="radioAdeudosVencidos" />
                                                            </td>
                                                            <td style="text-align:center; width:25%">
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
                       
                            <dx:TabPage Name="tabMnto" Text="Facturación de activo fijo terminación natural">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                        <table style="width:100%" border="0" >
                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblCliente" runat="server" Text="Cliente"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="txtCliente" runat="server" Text="WEBSET SA de CV"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblAnexoDomiciliario" runat="server" Text="Anexo Domiciliario"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="txtAnexoDomiciliario" runat="server" Text="01 Cuenta Inexistente"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblTelefono" runat="server" Text="Teléfono"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="txtTelefono" runat="server" Text="55446887"></dx:ASPxLabel>
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblCorreo" runat="server" Text="Correo"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="txtCorreo" runat="server" Text="alesanrror@hotmail.com"></dx:ASPxLabel>
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblContrato" runat="server" Text="Contrato"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="txtContrato" runat="server" Text="3453"></dx:ASPxLabel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="text-align:center; width:50%">
                                                    <table style="width:100%" border="1">
                                                        <tr>
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblEstatus1" runat="server" Text="Estatus"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblAnexo1" runat="server" Text="Anexo"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="txtAnexo1" runat="server" Text="9897"></dx:ASPxLabel>
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblReferencia2" runat="server" Text="Referencia"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="txtReferencia2" runat="server" Text="234567891233"></dx:ASPxLabel>
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblMarca" runat="server" Text="Marca"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="txtMarca" runat="server" Text="JETTA"></dx:ASPxLabel>
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblModelo" runat="server" Text="Modelo"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="txtModelo" runat="server" Text="2017"></dx:ASPxLabel>
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblVIN1" runat="server" Text="VIN"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="txtVIN1" runat="server" Text="3564WETR"></dx:ASPxLabel>
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblFechaVencimiento" runat="server" Text="Fecha Vencimiento"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="txtFechaVencimiento" runat="server" Text="07/08/2017"></dx:ASPxLabel>
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblMensualidades" runat="server" Text="Mensualidades"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="txtMensualidades" runat="server" Text="23/35"></dx:ASPxLabel>
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblSaldoVencido" runat="server" Text="Saldo Vencido"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="txtSaldoVencido" runat="server" Text="$ 3,000.00"></dx:ASPxLabel>
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblMoratoriosHoy" runat="server" Text="Moratorios al dia de hoy"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="txtMoratoriosHoy" runat="server" Text="$ 300.00"></dx:ASPxLabel>
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblFechaPromesaDePago" runat="server" Text="Fecha Promesa de Pago"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="txtFechaPromesaDePago" runat="server" Text="16/08/2017"></dx:ASPxLabel>
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblDiasVencidos" runat="server" Text="Días vencidos"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="txtDiasVencidos" runat="server" Text="9"></dx:ASPxLabel>
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblMontoMoratoriosFechaCompromiso" runat="server" Text="Monto moratorios a la<br/>fecha compromiso"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="txtMontoMoratoriosFechaCompromiso" runat="server" Text="$ 540.00"></dx:ASPxLabel>
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="ASPxLabel36" runat="server" Text="Contrato:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="ASPxLabel38" runat="server" Text="Contrato:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="ASPxLabel40" runat="server" Text="Contrato:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="ASPxLabel42" runat="server" Text="Contrato:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblAnexo" runat="server" Text="Anexo:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="lblReferencia1" runat="server" Text="Referencia:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
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
                                                            <td style="width:25%; text-align:left">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="ASPxLabel48" runat="server" Text="Contrato:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:75%; text-align:left">&nbsp;&nbsp;&nbsp;
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
                            
                        </TabPages>
                    </dx:ASPxPageControl>
                </dx:PanelContent>
          </PanelCollection>
        </dx:ASPxRoundPanel>
    </form>



</body>
</html>




