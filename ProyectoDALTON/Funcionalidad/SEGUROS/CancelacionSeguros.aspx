<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CancelacionSeguros.aspx.cs" Inherits="Funcionalidad_CancelacionSeguros" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style type="text/css">
        .auto-style1 {
            height: 23px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <dx:ASPxRoundPanel ID="ASPxRoundPanel4" runat="server" ShowCollapseButton="True" ShowHeader="False" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">
                        <table class="auto-style40">
                            <tr>
                                <td class="auto-style4">
                                    <dx:ASPxButton ID="btnAgregar" runat="server" ToolTip="Agregar" ClientInstanceName="btnAgregar" AutoPostBack="False" EnableClientSideAPI="false" ClientEnabled="False" GroupName="A">
                                        <Image IconID="actions_add_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>


                                <td class="auto-style4">
                                    <dx:ASPxButton ID="btnEditar" runat="server" ToolTip="Editar" ClientInstanceName="btnEditar" AutoPostBack="False" EnableClientSideAPI="false" ClientEnabled="False" GroupName="B">



                                        <Image IconID="edit_edit_32x32">
                                        </Image>
                                    </dx:ASPxButton>



                                </td>


                                <td class="auto-style4">

                                    <dx:ASPxButton ID="btnEliminar" runat="server" ToolTip="Eliminar" AutoPostBack="False" ClientInstanceName="btnEliminar" EnableClientSideAPI="True" ClientEnabled="True">

                                        <Image IconID="edit_delete_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                    <dx:ASPxCallback ID="cbEliminar" runat="server" ClientInstanceName="cbEliminar">
                                    </dx:ASPxCallback>
                                </td>


                                <td class="auto-style4">
                                    <dx:ASPxButton ID="btnCancelar" runat="server" AutoPostBack="False" ClientInstanceName="btnCancelar" ToolTip="Cancelar" EnableClientSideAPI="True" ClientEnabled="False">

                                        <Image IconID="actions_cancel_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                    <dx:ASPxCallback ID="cbCancelar" runat="server" ClientInstanceName="cbCancelar">
                                    </dx:ASPxCallback>
                                </td>


                                <td class="auto-style4">
                                    <dx:ASPxButton ID="btnActualizar" runat="server" AutoPostBack="False" ClientInstanceName="btnActualizar" ToolTip="Actualizar" ValidationGroup="reqError1" EnableClientSideAPI="true" CausesValidation="False" ClientEnabled="False">

                                        <Image IconID="actions_apply_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                    <dx:ASPxCallback ID="cbActualizar" runat="server" ClientInstanceName="cbActualizar">
                                    </dx:ASPxCallback>
                                </td>


                            </tr>
                        </table>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>

            <%--  BOTONES PANEL (AGREGA, EDITA, ELIMINA, ACTUALIZA)--%>


            <br />

            <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" HeaderText="Búsqueda:" Font-Size="Medium" Font-Bold="false" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">




                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="idbanco" AutoGenerateColumns="False" TextFormatString="{0} | {1}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>



                        </dx:ASPxGridLookup>



                        <asp:Label ID="lblAccesos" runat="server" CssClass="GlobalTextoPanel" Visible="false"></asp:Label>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>
            <br />
            <br />
        </div>
        <%--Botones y GRIDLOOKUP BUSQUEDA--%>



        <dx:ASPxRoundPanel ID="ASPxRoundPanel3" runat="server" ShowCollapseButton="True" HeaderText="Consulta general de seguros" Font-Bold="true" Font-Size="Medium" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">

                    <table style="width: 100%">
                        <tr>
                            <td style="width: 15%">
                                <dx:ASPxLabel ID="lblCliente" ClientInstanceName="lblCliente" runat="server" Font-Size="Medium" ForeColor="Black" Style="text-align: right" Text="Cliente:">
                                </dx:ASPxLabel>
                            </td>
                            <td style="width: 35%">
                                <asp:TextBox ID="txtCliente" ClientInstanceName="txtCliente" runat="server" MaxLength="100" Style="width: 95%" OnTextChanged="txtCliente_TextChanged" ></asp:TextBox>
                            </td>
                            <td style="width: 15%">
                                <dx:ASPxLabel ID="lblNumeroDeContrato" ClientInstanceName="lblNumeroDeContrato" runat="server" Font-Size="Medium" ForeColor="Black" Style="text-align: right" Text="Numero de contrato:">
                                </dx:ASPxLabel>
                            </td>
                            <td style="width: 35%">
                                <asp:TextBox ID="txtNumeroDeContrato" ClientInstanceName="txtNumeroDeContrato" Font-Size="Medium" MaxLength="30" ForeColor="Black" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>

                            <td style="padding: 4px"></td>
                        </tr>

                        <tr>
                            <td>
                                <dx:ASPxLabel ID="lblAnexo" ClientInstanceName="lblAnexo" runat="server" Font-Size="Medium" ForeColor="Black" Style="text-align: right" Text="Anexo">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <asp:TextBox ID="txtAnexo" ClientInstanceName="txtAnexo" Font-Size="Medium" MaxLength="30" ForeColor="Black" runat="server"></asp:TextBox>
                            </td>

                            <td>
                                <dx:ASPxLabel ID="lblVIN" ClientInstanceName="lblVIN" runat="server" Font-Size="Medium" ForeColor="Black" Style="text-align: right" Text="VIN:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <asp:TextBox ID="txtVIN" ClientInstanceName="txtVIN" MaxLength="30" Font-Size="Medium" ForeColor="Black" runat="server"></asp:TextBox>

                            </td>
                        </tr>


                        <tr>
                            <td style="padding: 4px"></td>
                        </tr>
                        <tr>
                            <td>
                                <dx:ASPxLabel ID="lblAgencia" ClientInstanceName="lblAgencia" runat="server" Font-Size="Medium" ForeColor="Black" Style="text-align: right" Text="Agencia:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <asp:TextBox ID="txtAgencia" ClientInstanceName="txtAgencia" MaxLength="30" Font-Size="Medium" ForeColor="Black" runat="server"></asp:TextBox>

                            </td>
                            <td class="auto-style1">
                                <dx:ASPxLabel ID="lblPromotor" ClientInstanceName="lblPromotor" runat="server" Font-Size="Medium" ForeColor="Black" Style="text-align: right" Text="Promotor">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <asp:TextBox ID="txtPromotor" ClientInstanceName="txtPromotor" Font-Size="Medium" ForeColor="Black" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 4px"></td>
                        </tr>


                    </table>















                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>


        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="True" HeaderText="Datos de Poliza" Font-Bold="true" Font-Size="Medium" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">

                    <table style="width: 100%">
                        <tr>
                            <td style="width: 15%">
                                <dx:ASPxLabel ID="lblNúmeroDePoliza" ClientInstanceName="lblNúmeroDePoliza" runat="server" Font-Size="Medium" ForeColor="Black" Style="text-align: right" Text="Número de poliza:">
                                </dx:ASPxLabel>
                            </td>
                            <td style="width: 35%">
                                <asp:TextBox ID="txtNúmeroDePoliza" ClientInstanceName="txtNúmeroDePoliza" MaxLength="30" Font-Size="Medium" ForeColor="Black" runat="server"></asp:TextBox>

                            </td>
                            <td style="width: 15%">
                                <dx:ASPxLabel ID="lblFechaDeEmisión" ClientInstanceName="lblFechaDeEmisión" runat="server" Font-Size="Medium" ForeColor="Black" Style="text-align: right" Text="Fecha de emisión:">
                                </dx:ASPxLabel>
                            </td>
                            <td style="width: 35%">
                                <dx:ASPxDateEdit ID="ASPxDateEdit1" runat="server"></dx:ASPxDateEdit>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 4px"></td>
                        </tr>

                        <tr>
                            <td>
                                <dx:ASPxLabel ID="lblFechaDeVencimiento" ClientInstanceName="lblFechaDeVencimiento" runat="server" Font-Size="Medium" ForeColor="Black" Style="text-align: right" Text="Fecha de vencimiento:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <dx:ASPxDateEdit ID="ASPxDateEdit3" runat="server"></dx:ASPxDateEdit>

                            </td>
                            <td class="auto-style1">
                                <dx:ASPxLabel ID="lblCostoDePolizaSinIVA" ClientInstanceName="lblCostoDePolizaSinIVA" runat="server" Font-Size="Medium" ForeColor="Black" Style="text-align: right" Text="Costo de poliza sin IVA:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <asp:TextBox ID="txtCostoDePolizaSinIVA" ClientInstanceName="txtCostoDePolizaSinIVA" MaxLength="30" Font-Size="Medium" ForeColor="Black" runat="server"></asp:TextBox>
                            </td>
                        </tr>

                        <tr>
                            <td style="padding: 4px"></td>
                        </tr>

                        <tr>
                            <td>
                                <dx:ASPxLabel ID="lblCostoTotal" ClientInstanceName="lblCostoTotal" runat="server" Font-Size="Medium" ForeColor="Black" Style="text-align: right" Text="Costo total:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <asp:TextBox ID="txtCostoTotal" ClientInstanceName="txtCostoTotal" MaxLength="30" Font-Size="Medium" ForeColor="Black" runat="server"></asp:TextBox>

                            </td>
                            <td class="auto-style1">
                                <dx:ASPxLabel ID="lblAseguradora" ClientInstanceName="lblAseguradora" runat="server" Font-Size="Medium" ForeColor="Black" Style="text-align: right" Text="Aseguradora:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <asp:TextBox ID="txtAseguradora" ClientInstanceName="txtAseguradora" MaxLength="100" Style="width: 95%" Font-Size="Medium" ForeColor="Black" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 4px"></td>
                        </tr>

                        <tr>
                            <td>
                                <dx:ASPxLabel ID="lblAgente" ClientInstanceName="lblAgente" runat="server" Font-Size="Medium" ForeColor="Black" Style="text-align: right" Text="Agente:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <asp:TextBox ID="txtAgente" ClientInstanceName="txtAgente" MaxLength="75" Style="width: 75%" Font-Size="Medium" ForeColor="Black" runat="server" OnTextChanged="txtAgente_TextChanged"></asp:TextBox>
                            </td>
                            <td class="auto-style1">
                                <dx:ASPxLabel ID="lblUDI" ClientInstanceName="lblUDI" runat="server" Font-Size="Medium" ForeColor="Black" Style="text-align: right" Text="%UDI:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <asp:TextBox ID="txtUDI" ClientInstanceName="txtUDI" MaxLength="30" Font-Size="Medium" ForeColor="Black" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>
        <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" ShowCollapseButton="True" HeaderText="Datos del vehículo" Font-Bold="true" Font-Size="Medium" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <table style="width: 100%">
                        <tr>
                            <td style="width: 15%">
                                <dx:ASPxLabel ID="lblMarca" ClientInstanceName="lblMarca" runat="server" Font-Size="Medium" ForeColor="Black" Style="text-align: right" Text="Marca:">
                                </dx:ASPxLabel>
                            </td>
                            <td style="width: 35%">
                                <asp:TextBox ID="txtMarca" ClientInstanceName="txtMarca" MaxLength="20" Style="width: 35%" Font-Size="Medium" ForeColor="Black" runat="server"></asp:TextBox>
                            </td>
                            <td style="width: 15%">
                                <dx:ASPxLabel ID="lblSubMarca" ClientInstanceName="lblSubMarca" runat="server" Font-Size="Medium" ForeColor="Black" Style="text-align: right" Text="Sub-marca:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <asp:TextBox ID="txtSubMarca" ClientInstanceName="txtSubMarca" MaxLength="20" Style="width: 35%" Font-Size="Medium" ForeColor="Black" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 4px"></td>
                        </tr>
                        <tr>
                            <td style="width: 15%">
                                <dx:ASPxLabel ID="lblModelo" ClientInstanceName="lblModelo" runat="server" Font-Size="Medium" ForeColor="Black" Style="text-align: right" Text="Modelo:">
                                </dx:ASPxLabel>
                            </td>
                            <td>
                                <asp:TextBox ID="txtModelo" ClientInstanceName="txtModelo" MaxLength="20" Style="width: 35%" Font-Size="Medium" ForeColor="Black" runat="server"></asp:TextBox>
                            </td>

                        </tr>


                    </table>















                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>












        <br />

        <table>
            <tr>

                <td style="width: 15%"></td>
                <td>
                    <asp:Button ID="Button1" runat="server" Text="Confirmar" />
                </td>
                <td>
                    <asp:Button ID="Button2" runat="server" Text="Cancelar" />
                </td>
                <td>
                    <asp:Button ID="Button3" runat="server" Text="Confirmar renovación" />
                </td>
                <td>
                    <asp:Button ID="Button4" runat="server" Text="Confirmar cancelación" />
                </td>
                <td>
                    <asp:Button ID="Button5" runat="server" Text="Agregar dictamen" />
                </td>
                <td>
                    <asp:Button ID="Button6" runat="server" Text="Agregar endoso" />
                </td>
                <td>
                    <asp:Button ID="Button7" runat="server" Text="Agregar poliza" />
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
        




        <div>
        </div>
    </form>
</body>
</html>
