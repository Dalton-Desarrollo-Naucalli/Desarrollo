<%@ Control Language="VB" AutoEventWireup="false" CodeFile="HerramientasDalton.ascx.vb" Inherits="UserControl_HerramientasDalton" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<dx:ASPxRoundPanel ID="rpnHerramientas" runat="server" ShowHeader="False" Width="100%" Height="40%" View="GroupBox" EnableAnimation="true" ShowCollapseButton="false" Theme="Office2003Blue">
    <PanelCollection>
        <dx:PanelContent runat="server">
            <table class="auto-style63">
                <tr>
                    <td>
                        <dx:ASPxButton ID="btnAgregar" runat="server" ToolTip="Agregar" ClientInstanceName="btnAgregar" EnableClientSideAPI="True" AutoPostBack="False">
                            <ClientSideEvents Click="function(s, e) { OnNewRowClicked(); }" />
                            <Image IconID="actions_add_32x32"></Image>
                        </dx:ASPxButton>
                    </td>
                    <td>
                        <dx:ASPxButton ID="btnEditar" runat="server" ToolTip="Editar" ClientInstanceName="btnEditar" ClientVisible="true" EnableClientSideAPI="True" EnableTheming="False" AutoPostBack="False">
                            <ClientSideEvents Click="function(s, e) { OnEditRowClicked(); }" />
                            <Image IconID="edit_edit_32x32">
                            </Image>
                        </dx:ASPxButton>
                    </td>
                    <td>
                        <dx:ASPxButton ID="btnEliminar" runat="server" ToolTip="Eliminar" ClientInstanceName="btnEliminar" ClientVisible="true" EnableClientSideAPI="True" EnableTheming="False" AutoPostBack="False">
                            <ClientSideEvents Click="function(s, e) { OnDeleteRowsClicked(); }" />
                            <Image IconID="edit_delete_32x32">
                            </Image>
                        </dx:ASPxButton>
                    </td>
                    <td>
                        <dx:ASPxButton ID="btnCancelar" runat="server" ToolTip="Cancelar" ClientInstanceName="btnCancelar" EnableClientSideAPI="True" AutoPostBack="False">
                            <ClientSideEvents Click="function(s, e) { OnDiscardChangesClicked(); }" />
                            <Image IconID="actions_cancel_32x32">
                            </Image>
                        </dx:ASPxButton>
                    </td>
                    <td>
                        <dx:ASPxButton ID="btnAplicar" runat="server" ToolTip="Aplicar" ClientInstanceName="btnAplicar" EnableClientSideAPI="True" AutoPostBack="False" ValidationGroup="reqError">
                            <ClientSideEvents Click="function(s, e) { OnSaveChangesClicked(); }" />
                            <Image IconID="actions_apply_32x32">
                            </Image>
                        </dx:ASPxButton>
                    </td>
                   <%-- <td>
                        <dx:ASPxButton ID="btnFiltrar" runat="server" ToolTip="Filtrar" ClientInstanceName="btnFiltrar" EnableClientSideAPI="True" AutoPostBack="False">
                            <ClientSideEvents CheckedChanged="function(s, e) { }" Click="function(s, e) { OnFilterClicked(); }" />
                            <Image IconID="filter_filter_32x32">
                            </Image>
                        </dx:ASPxButton>
                    </td>
                    <td>
                        <dx:ASPxButton ID="btnBuscar" runat="server" AutoPostBack="false" ToolTip="Buscar" ClientInstanceName="btnBuscar" EnableClientSideAPI="True">
                            <ClientSideEvents Click="function(s, e) { onBuscarClick(); }" />
                            <Image IconID="find_find_32x32">
                            </Image>
                        </dx:ASPxButton>
                    </td>--%>
                   <%-- <td>
                        <dx:ASPxButton ID="btnDeshacer" runat="server" ToolTip="Deshacer" ClientInstanceName="btnDeshacer" EnableClientSideAPI="True" AutoPostBack="False">
                            <Image IconID="history_undo_32x32">
                            </Image>
                        </dx:ASPxButton>
                    </td>
                    <td>
                        <dx:ASPxButton ID="btnRehacer" runat="server" ToolTip="Rehacer" ClientInstanceName="btnRehacer" EnableClientSideAPI="True" AutoPostBack="False">
                            <Image IconID="history_redo_32x32">
                            </Image>
                        </dx:ASPxButton>
                    </td>--%>
                    <td class="auto-style64">&nbsp;</td>
                </tr>
            </table>
        </dx:PanelContent>
    </PanelCollection>
</dx:ASPxRoundPanel>
