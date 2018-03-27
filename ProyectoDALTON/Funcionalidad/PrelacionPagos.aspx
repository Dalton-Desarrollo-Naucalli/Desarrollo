<%@ Page Language="VB" AutoEventWireup="false" CodeFile="PrelacionPagos.aspx.vb" Inherits="Funcionalidad_PrelacionPagos" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/PrelacionPagos.js"></script>
    <title>Prelación de pagos</title>
</head>
<body onkeypress="return pulsar(event)">
    <form id="form1" runat="server">

        <asp:Label ID="lblAccesos" runat="server" CssClass="GlobalTextoPanel" Visible="false"></asp:Label>

        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Prelación de pagos" Font-Bold="true" Font-Size="Large" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">

                    <table style="width: 100%">
                        <tr>
                            <td>
                                <dx:ASPxGridView ID="GVPrelacion" runat="server" OnBeforeHeaderFilterFillItems="GVPrelacion_BeforeHeaderFilterFillItems" AutoGenerateColumns="False" Font-Size="Medium" ClientIDMode="AutoID" ClientInstanceName="GVPrelacion" Width="100%" KeyFieldName="idProducto;idLineaFondeo;idConcepto" SettingsCommandButton-CancelButton-Text="Cancelar" SettingsCommandButton-UpdateButton-Text="Guardar" ForeColor="Black">

                                    <ClientSideEvents EndCallback="OnEndCallback
"
                                        BeginCallback="OnBeginCallback	
" />
                                    <SettingsEditing Mode="Batch" UseFormLayout="False">
                                    </SettingsEditing>


                                    <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                                    <SettingsCommandButton>
                                        <NewButton ButtonType="Image" RenderMode="Image" Text="Nuevo">
                                            <Image Height="20px" Url="~/Imagenes/NEW_.png" Width="20px">
                                            </Image>
                                        </NewButton>

                                        <UpdateButton Text="Guardar"></UpdateButton>

                                        <CancelButton Text="Cancelar"></CancelButton>

                                        <EditButton ButtonType="Image" RenderMode="Image" Text="Editar">
                                            <Image Height="16px" Url="~/Imagenes/editar.png" Width="16px">
                                            </Image>
                                        </EditButton>
                                        <DeleteButton ButtonType="Image" RenderMode="Image" Text="Eliminar">
                                            <Image Height="16px" Url="~/Imagenes/Delete.png" Width="16px">
                                            </Image>
                                        </DeleteButton>
                                    </SettingsCommandButton>
                                    <Columns>
                                        <dx:GridViewCommandColumn ShowClearFilterButton="True" ShowInCustomizationForm="True" VisibleIndex="0">
                                        </dx:GridViewCommandColumn>
                                    </Columns>
                                </dx:ASPxGridView>
                            </td>
                        </tr>

                    </table>

                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>


    </form>
</body>
</html>

