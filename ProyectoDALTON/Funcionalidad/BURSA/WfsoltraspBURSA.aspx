<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WfsoltraspBURSA.aspx.cs" Inherits="Funcionalidad_BURSA_WfsoltraspBURSA" %>
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


        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Solicitud de traspaso"  Font-Size="Medium" ForeColor="Black"  Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">

                        <table style="width:100%">
                            <tr>
                                <td style="width:15%">
                        <dx:ASPxLabel ID="lblCliente" ClientInstanceName="lblCliente" ForeColor="Black" Font-Size="Medium"
                            runat="server" Text="Cliente"></dx:ASPxLabel>
                                    </td>
                                <td style="width:35%">
                                    <dx:ASPxTextBox ID="txtCliente" ClientInstanceName="txtCliente" ForeColor="Black" Font-Size="Medium"
                                        MaxLength="100" runat="server" Width="80%"></dx:ASPxTextBox>
                                </td>
                                <td style="width:15%">
                                    <dx:ASPxLabel ID="lblAnexo" ClientInstanceName="lblAnexo"  ForeColor="Black" Font-Size="Medium"
                                        runat="server" Text="Anexo"></dx:ASPxLabel>
                                </td>
                                <td style="width:35%">
                                    <dx:ASPxTextBox ID="txtAnexo" ClientInstanceName="txtAnexo" ForeColor="Black" Font-Size="Medium"
                                        MaxLength="15" runat="server" Width="170px"></dx:ASPxTextBox>
                                </td>
                                </tr>
                            <tr>
                                                            <td style="padding: 4px;">
                                                            </td>
                                                            </tr>
                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="lblContrato" ClientInstanceName="lblContrato" ForeColor="Black" Font-Size="Medium"
                                        runat="server" Text="Contrato"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtContrato" ClientInstanceName="txtContrato" ForeColor="Black" Font-Size="Medium"
                                        MaxLength="20" runat="server" Width="170px"></dx:ASPxTextBox>
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="lblNumObligación" ClientInstanceName="lblNumObligación" ForeColor="Black" Font-Size="Medium"
                                        runat="server" Text="Num. Obligación"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtNumObligación" ClientInstanceName="txtNumObligación" ForeColor="Black" Font-Size="Medium"
                                        MaxLength="25" runat="server" Width="170px"></dx:ASPxTextBox>
                                </td>
                            </tr>
                             <tr>
                                                            <td style="padding: 4px;">
                                                            </td>
                                                            </tr>
                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="lblFechaVencimiento" ClientInstanceName="lblFechaVencimiento" ForeColor="Black" Font-Size="Medium"
                                        runat="server" Text="Fecha vencimiento"></dx:ASPxLabel>

                                </td>
                                <td>
                                    <dx:ASPxDateEdit ID="ASPxDateEdit1" runat="server"></dx:ASPxDateEdit>
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="lblFechaTraspaso" ClientInstanceName="lblFechaTraspaso" ForeColor="Black" Font-Size="Medium"
                                        runat="server" Text="Fecha traspaso"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxDateEdit ID="ASPxDateEdit2" runat="server"></dx:ASPxDateEdit>
                                </td>
                            </tr>
                             <tr>
                                                            <td style="padding: 4px;">
                                                            </td>
                                                            </tr>
                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="lbldiasvencimiento" ClientInstanceName="lbldiasvencimiento" ForeColor="Black" Font-Size="Medium"
                                        runat="server" Text="Días vencimiento"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtdiasvencimiento" ClientInstanceName="txtdiasvencimiento"  ForeColor="Black" Font-Size="Medium"
                                        MaxLength="5"  runat="server" Width="20%"></dx:ASPxTextBox>
                                </td>
                            </tr>
                             <tr>
                                                            <td style="padding: 4px;">
                                                            </td>
                                                            </tr>

                            
                            <dx:ASPxGridView ID="ASPxGridView1" runat="server">
                            </dx:ASPxGridView>
                             <tr>
                                                            <td style="padding: 4px;">
                                                            </td>
                                                            </tr>
                           
                            <tr>
                                <td>
                                    <dx:ASPxButton ID="ASPxButton4"  runat="server" Text="Autorizar"></dx:ASPxButton>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Cancelar"></dx:ASPxButton>
                                     
                                </td>
                                <td>
                                     
                                    <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Solicitud"></dx:ASPxButton>
                                </td>
                                <td>
                                   
                                    <dx:ASPxButton ID="ASPxButton3" runat="server" Text="Baja de fondeo"></dx:ASPxButton>
                                </td>
                            </tr>

                            </table>


                      

                      
                       
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>


        <div>
        </div>
    </form>
</body>
</html>