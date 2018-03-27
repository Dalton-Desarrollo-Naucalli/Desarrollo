<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WfgenearchmovBURSA.aspx.cs" Inherits="Funcionalidad_BURSA_WfgenearchmovBURSA" %>
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
        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Generación de archivo movimientos"  Font-Size="Medium" ForeColor="Black"  Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">

                        <table style="width:100%">
                            <tr>
                               <td style="width:15%">
                                   <dx:ASPxLabel ID="lblFechaCorteAnt" ClientInstanceName="lblFechaCorteAnt"  Font-Size="Medium" ForeColor="Black"
                                       runat="server" Text="Fecha de corte anterior:"></dx:ASPxLabel>
                               </td>
                                <td style="width:35%">
                                    <dx:ASPxDateEdit ID="ASPxDateEdit1" runat="server"></dx:ASPxDateEdit>
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="lblFechaCorte" ClientInstanceName="lblFechaCorte" Font-Size="Medium" ForeColor="Black"
                                        runat="server" Text="Fecha de corte:"></dx:ASPxLabel>
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
                                    <dx:ASPxLabel ID="lblTRM" ClientInstanceName="lblTRM" Font-Size="Medium" ForeColor="Black"
                                        runat="server" Text="Totales registros en M:"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtTRM" ClientInstanceName="txtTRM" Font-Size="Medium" ForeColor="Black"
                                        MaxLength="4" runat="server" Width="170px"></dx:ASPxTextBox>
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="lblMontoTotalM" ClientInstanceName="lblMontoTotalM" Font-Size="Medium" ForeColor="Black"
                                        runat="server" Text="Monto total M:"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtMontoTotalM" ClientInstanceName="txtMontoTotalM" Font-Size="Medium" ForeColor="Black"
                                        MaxLength="15" runat="server" Width="170px"></dx:ASPxTextBox>
                                </td>
                            </tr>
                             <tr>
                                                            <td style="padding: 4px;">
                                                            </td>
                                                            </tr>
                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="lblTotalaneM" ClientInstanceName="lblTotalaneM" Font-Size="Medium" ForeColor="Black"
                                        runat="server" Text="Totales anexos en M:"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtTotalaneM" ClientInstanceName="txtTotalaneM" Font-Size="Medium" ForeColor="Black"
                                        MaxLength="15" runat="server" Width="170px"></dx:ASPxTextBox>
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="lblTotRegI" ClientInstanceName="lblTotRegI" Font-Size="Medium" ForeColor="Black"
                                        runat="server" Text="Toltales registros en I:"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtTotRegI" ClientInstanceName="txtTotRegI" Font-Size="Medium" ForeColor="Black"
                                        MaxLength="15" runat="server" Width="170px"></dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                                            <td style="padding: 4px;">
                                                            </td>
                                                            </tr>
                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="lblMontoTI" ClientInstanceName="lblMontoTI" Font-Size="Medium" ForeColor="Black"
                                        runat="server" Text="Monto total I:"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtMontoTI" ClientInstanceName="txtMontoTI" Font-Size="Medium" ForeColor="Black"
                                        MaxLength="15" runat="server" Width="170px"></dx:ASPxTextBox>
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="lblTotalesaneI" ClientInstanceName="lblTotalesaneI"  Font-Size="Medium" ForeColor="Black"
                                        runat="server" Text="Totales anexos en I:"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtTotalesaneI" ClientInstanceName="txtTotalesaneI"  Font-Size="Medium" ForeColor="Black"
                                        MaxLength="15" runat="server" Width="170px"></dx:ASPxTextBox>
                                </td>
                            </tr>
                             <tr>
                                                            <td style="padding: 4px;">
                                                            </td>
                                                            </tr>
                           <tr>
                               <td>
                                   <dx:ASPxLabel ID="lblTotalesRegSLD" ClientInstanceName="lblTotalesRegSLD"  Font-Size="Medium" ForeColor="Black"
                                       runat="server" Text="Totales registros en SLD:"></dx:ASPxLabel>
                               </td>
                               <td>
                                   <dx:ASPxTextBox ID="txtTotalesRegSLD" ClientInstanceName="txtTotalesRegSLD"  Font-Size="Medium" ForeColor="Black"
                                       MaxLength="15" runat="server" Width="170px"></dx:ASPxTextBox>
                               </td>
                               <td>
                                   <dx:ASPxLabel ID="lblMontoTotalSLD" ClientInstanceName="lblMontoTotalSLD" Font-Size="Medium" ForeColor="Black"
                                        runat="server" Text="Monto total SLD"></dx:ASPxLabel>
                               </td>
                               <td>
                                   <dx:ASPxTextBox ID="txtMontoTotalSLD" ClientInstanceName="txtMontoTotalSLD" Font-Size="Medium" ForeColor="Black"
                                       MaxLength="15" runat="server" Width="170px"></dx:ASPxTextBox>
                               </td>
                           </tr>  
                             <tr>
                                                            <td style="padding: 4px;">
                                                            </td>
                                                            </tr>
                            <tr>
                                <td>
                                    <dx:ASPxLabel ID="lblMontoTotSLD" ClientInstanceName="lblMontoTotSLD" Font-Size="Medium" ForeColor="Black"
                                        runat="server" Text="Monto total SLD"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtMontoTotSLD" ClientInstanceName="txtMontoTotSLD" Font-Size="Medium" ForeColor="Black"
                                        MaxLength="15" runat="server" Width="170px"></dx:ASPxTextBox>
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="lblTotalesAnexosSLD" ClientInstanceName="lblTotalesAnexosSLD" Font-Size="Medium" ForeColor="Black"
                                        runat="server" Text="Totales anexos SLD"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtTotalesAnexosSLD" ClientInstanceName="txtTotalesAnexosSLD"  Font-Size="Medium" ForeColor="Black"
                                        MaxLength="15" runat="server" Width="170px"></dx:ASPxTextBox>
                                </td>
                            </tr>
                             <tr>
                                                            <td style="padding: 4px;">
                                                            </td>
                                                            </tr>
                           <tr>
                              <td>

                              </td>
                               <td>

                               </td>
                               <td>
                                   <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Cargar archivos CxC/CxCI"></dx:ASPxButton>
                               </td>
                               <td>
                                   <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Generar archivos SLD"></dx:ASPxButton>
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
