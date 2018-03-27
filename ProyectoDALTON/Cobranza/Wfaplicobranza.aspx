<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Wfaplicobranza.aspx.vb" Inherits="MiFuncionalidad_Wfaplicobranza" %>
<%@ Register Assembly="DevExpress.Data.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Pantalla Aplicación de Cobranza</title>
</head>
<body>
    <form id="form1" runat="server">       
        <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" ShowCollapseButton="True" ShowHeader="False" Width="100%" Theme="Office2003Blue">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <table style="width:100%">
                        <tr>
                            <td style="text-align:center">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="ASPxLabel66" runat="server" Text="R.F.C:"/>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="comboRFC" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="text-align:center">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="ASPxLabel65" runat="server" Text="Nombre de la compañia:"/>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="ASPxComboBox2" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="text-align:center">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="ASPxLabel67" runat="server" Text="Vin:"/>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="ASPxComboBox3" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="text-align:center">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="ASPxLabel68" runat="server" Text="Contrato:"/>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="ASPxComboBox4" runat="server"/>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="text-align:center">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="ASPxLabel69" runat="server" Text="Anexo:"/>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="ASPxComboBox5" runat="server"/>
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
                            <dx:TabPage Name="tabMnto" Text="Aplicación de cobranza">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                        <table style="width:100%" border="0" >
                                            <tr>
                                                <td style="text-align:center">
                                                    <table style="width:100%">
                                                        <tr>
                                                            <td style="width:10%; text-align:right">&nbsp;&nbsp;&nbsp;
                                                                <dx:ASPxLabel ID="ASPxLabel63" runat="server" Text="Cliente:"></dx:ASPxLabel>
                                                            </td>
                                                            <td style="width:5px"></td>
                                                            <td style="text-align:left">
                                                                <dx:ASPxLabel ID="ASPxLabel64" runat="server" Text="WEBSET SA de CV"></dx:ASPxLabel>
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
                                                                <asp:RadioButton ID="radioIniciales" Text="Iniciales" runat="server" GroupName="radioTipoFactura" />
                                                            </td>
                                                            <td style="text-align:center">
                                                                <asp:RadioButton ID="radioRentas" Text="Rentas" runat="server" GroupName="radioTipoFactura" />
                                                            </td>
                                                            <td style="text-align:center">
                                                                <asp:RadioButton ID="radioOtros" Text="Otros" runat="server" GroupName="radioTipoFactura" />
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
                                                                <dx:ASPxLabel ID="ASPxLabel85" runat="server" Text="Renta"/>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <table class="dxrpControl_Office2010Blue" style="width: 100%; border-collapse: initial;">
                                                                    <tr>
                                                                        <td style="text-align">
                                                                            <dx:ASPxGridView ID="ASPxGridRenta" runat="server" Width="100%"></dx:ASPxGridView>
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
                                                                            <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Crédito" Style="text-align:left"></dx:ASPxLabel>
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
                                                                            <dx:ASPxGridView ID="ASPxGridCredito" runat="server" Width="100%" ></dx:ASPxGridView>
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




