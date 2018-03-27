<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PopUpBitacora.aspx.cs" Inherits="Funcionalidad_PopUpBitacora" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width: 100%">
            <tr>
                <td>
                    <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="true" Width="100%" HeaderText="BITÁCORA DE USUARIO" HeaderStyle-HorizontalAlign="Center" Font-Size="Medium" ForeColor="Black">
                        <HeaderStyle HorizontalAlign="Center" />
                        <PanelCollection>
                            <dx:PanelContent runat="server">
                                <table class="dx-justification">
                                    <tr>
                                        <td style="width: 100%">
                                            <dx:ASPxGridView ID="gvBitacora" runat="server" ClientInstanceName="gvBitacora" Width="100%">
                                            </dx:ASPxGridView>
                                        </td>
                                    </tr>
                                </table>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
