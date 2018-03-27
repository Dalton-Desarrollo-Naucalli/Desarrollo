<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WfcomparativoBURSA.aspx.cs" Inherits="Funcionalidad_BURSA_WfcomparativoBURSA" %>
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

         <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Comparativo BURSA vs DES"  Font-Size="Medium" ForeColor="Black"  Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">

                        <table style="width:100%">
                            <tr>
                                <td style="width:15%">
                                    <dx:ASPxLabel ID="lblCargaArchivoBURSA" ClientInstanceName="lblCargaArchivoBURSA" Font-Size="Medium" ForeColor="Black"
                                        runat="server" Text="Carga de archivo BURSA:"></dx:ASPxLabel>
                                </td>
                                <td style="width:35%">
                                    <dx:ASPxTextBox ID="txtCargaArchivoBURSA" ClientInstanceName="txtCargaArchivoBURSA" Font-Size="Medium" ForeColor="Black"
                                        MaxLength="100" runat="server" Width="85%"></dx:ASPxTextBox>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Cargar"></dx:ASPxButton>
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
                                    <dx:ASPxLabel ID="lblTotalValorBURSA" ClientInstanceName="lblTotalValorBURSA" Font-Size="Medium" ForeColor="Black"
                                        runat="server" Text="Total valor BURSA:"></dx:ASPxLabel>
                                </td>
                                <td>

                                    <dx:ASPxTextBox ID="txtTotalValorBURSA" ClientInstanceName="txtTotalValorBURSA" 
                                        MaxLength="15" Font-Size="Medium" ForeColor="Black" runat="server" Width="170px"></dx:ASPxTextBox>
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="lblTotalValorDES" ClientInstanceName="lblTotalValorDES"  Font-Size="Medium" ForeColor="Black"
                                        runat="server" Text="Total valor DES:"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtTotalValorDES" ClientInstanceName="txtTotalValorDES"  Font-Size="Medium" ForeColor="Black"
                                        MaxLength="15" runat="server" Width="170px"></dx:ASPxTextBox>
                                </td>
                            </tr>
                             <tr>
                                                            <td style="padding: 4px;">
                                                            </td>
                                                            </tr>
                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="lblTotalDiferencia" ClientInstanceName="lblTotalDiferencia"  Font-Size="Medium" ForeColor="Black"
                                        runat="server" Text="Total diferencia:"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtTotalDiferencia" ClientInstanceName="txtTotalDiferencia"  Font-Size="Medium" ForeColor="Black"
                                        MaxLength="15" runat="server" Width="170px"></dx:ASPxTextBox>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Generar archivo CxCD"></dx:ASPxButton>
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