<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CalculoSeguros.aspx.cs" Inherits="Funcionalidad_CalculoSeguros" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript">
        function OnClienteChanged(cmbCliente) {
            cmbContrato.PerformCallback(cmbCliente.GetSelectedItem().value.toString());
        }
        function OnContratoChanged(cmbContrato) {
            cmbAnexo.PerformCallback(cmbContrato.GetSelectedItem().value.toString());
        }
        function OnBuscar(btnBuscar) {
            callbackPanel.PerformCallback(cmbCliente.GetSelectedItem().value.toString() + '|' +
                cmbContrato.GetSelectedItem().value.toString() + '|' + cmbAnexo.GetSelectedItem().value.toString());
        }
        function mydiff(date1, date2, interval) {
            var second = 1000, minute = second * 60, hour = minute * 60, day = hour * 24, week = day * 7;
            date1 = new Date(date1);
            date2 = new Date(date2);
            var timediff = date2 - date1;
            if (isNaN(timediff)) return NaN;
            switch (interval) {
                case "years": return date2.getFullYear() - date1.getFullYear();
                case "months": return (
                    (date2.getFullYear() * 12 + date2.getMonth())
                    -
                    (date1.getFullYear() * 12 + date1.getMonth())
                );
                case "weeks": return Math.floor(timediff / week);
                case "days": return Math.floor(timediff / day);
                case "hours": return Math.floor(timediff / hour);
                case "minutes": return Math.floor(timediff / minute);
                case "seconds": return Math.floor(timediff / second);
                default: return undefined;
            }
        }
        function OnCalculaMontos() {
            var montoNoDevengadas = 0;
            var montoProporcionales = 0;
            var montoPrima = parseFloat(txtPrima.GetValue());

            var fechaInicial = ASPxDateEdit1.GetValue();
            var fechaFinal = ASPxDateEdit2.GetValue();
            var fechaCalculo = ASPxDateEdit3.GetValue();

            var diasDiff = mydiff(fechaInicial, fechaCalculo, 'days');

            montoProporcionales = (montoPrima / 365) * diasDiff;
            montoNoDevengadas = montoPrima - montoProporcionales;
            
            txtMontoPrimasNoDevengadas.SetText(montoNoDevengadas);
            txtMontoDeProporcionales.SetText(montoProporcionales);
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" HeaderText="Búsqueda:" Font-Size="Medium" Font-Bold="false" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">

                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <dx:ASPxLabel runat="server" Text="Aseguradora" Font-Size="Medium"></dx:ASPxLabel>
                                    <br />
                                    <dx:ASPxComboBox ID="cmbCliente" runat="server" ClientInstanceName="cmbCliente" Font-Size="Medium" Width="75%" ClientEnabled="True" ForeColor="Black" TabIndex="3" AutoPostBack="False">
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { OnClienteChanged(s); }" />
                                    </dx:ASPxComboBox>
                                </td>
                                <td>
                                    <dx:ASPxLabel runat="server" Text="Contrato" Font-Size="Medium"></dx:ASPxLabel>
                                    <br />
                                    <dx:ASPxComboBox ID="cmbContrato" runat="server" ClientInstanceName="cmbContrato" Font-Size="Medium" Width="75%" ClientEnabled="True" ForeColor="Black" TabIndex="3" AutoPostBack="False" OnCallback="cmbContrato_Callback">
                                        <ClientSideEvents SelectedIndexChanged="function(s, e) { OnContratoChanged(s); }" />
                                    </dx:ASPxComboBox>
                                </td>
                                <td>
                                    <dx:ASPxLabel runat="server" Text="Anexo" Font-Size="Medium"></dx:ASPxLabel>
                                    <br />
                                    <dx:ASPxComboBox ID="cmbAnexo" runat="server" ClientInstanceName="cmbAnexo" Font-Size="Medium" Width="75%" ClientEnabled="True" ForeColor="Black" TabIndex="3" AutoPostBack="False" OnCallback="cmbAnexo_Callback">
                                    </dx:ASPxComboBox>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnBuscar" runat="server" Text="Buscar" Font-Size="Medium" AutoPostBack="false">
                                        <ClientSideEvents Click="function(s, e) { OnBuscar(s); }" />
                                    </dx:ASPxButton>
                                </td>
                            </tr>
                        </table>
                        <asp:Label ID="lblAccesos" runat="server" CssClass="GlobalTextoPanel" Visible="false"></asp:Label>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>
            <br />
        </div>
        <dx:ASPxCallbackPanel ID="callbackPanel" ClientInstanceName="callbackPanel" runat="server" OnCallback="callbackPanel_Callback">
            <PanelCollection>
                <dx:PanelContent>
                    <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="True" HeaderText="Cálculo de primas no devengadas:" Font-Size="Medium" Font-Bold="true" Width="100%" ClientSideEvents-EndCallback="function(s, e){alert('Done!');}">
                        <PanelCollection>
                            <dx:PanelContent runat="server">
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblEmpresa" ClientInstanceName="lblEmpresa" runat="server" Text="Cliente:" Font-Size="medium" ForeColor="Black" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <asp:TextBox ID="txtEmpresa" ClientInstanceName="txtEmpresa" runat="server" Font-Size="medium" MaxLength="100" ForeColor="Black" Style="width: 95%"></asp:TextBox>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblContrato" ClientInstanceName="lblContrato" runat="server" Text="Contrato:" Font-Size="medium" ForeColor="Black" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <asp:TextBox ID="txtContrato" ClientInstanceName="txtContrato" Font-Size="medium" MaxLength="30" ForeColor="Black" runat="server" Style="width: 50%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblAnexo" ClientInstanceName="lblAnexo"
                                                runat="server" Text="Anexo:" Font-Size="medium" ForeColor="Black" Width="100%" Style="text-align: left">
                                            </dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtAnexo" ClientInstanceName="txtAnexo" runat="server" Font-Size="medium" MaxLength="20" ForeColor="Black" Style="width: 50%"></asp:TextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblVIN" ClientInstanceName="lblVIN" runat="server" Text="VIN:" Font-Size="medium" ForeColor="Black" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtVIN" ClientInstanceName="txtVIN" runat="server" Font-Size="medium" MaxLength="16" ForeColor="Black" Style="width: 50%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                </table>
                                <br />
                                <br />
                                <table style="width: 100%">
                                    <tr>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblFechaDeInicio" ClientInstanceName="lblFechaDeInicio" runat="server" Text="Fecha de inicio:" Font-Size="medium" ForeColor="Black" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%">
                                            <dx:ASPxDateEdit ID="ASPxDateEdit1" ClientInstanceName="ASPxDateEdit1" runat="server" Font-Size="Medium"></dx:ASPxDateEdit>
                                        </td>
                                        <td style="width: 15%">
                                            <dx:ASPxLabel ID="lblFechaVencimiento" ClientInstanceName="lblFechaVencimiento" runat="server" Text="Fecha vencimiento:" Font-Size="medium" ForeColor="Black" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td style="width: 35%" colspan="2">
                                            <dx:ASPxDateEdit ID="ASPxDateEdit2" ClientInstanceName="ASPxDateEdit2" runat="server" Font-Size="Medium"></dx:ASPxDateEdit>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblPrima" ClientInstanceName="lblPrima" runat="server" Text="Prima:" Font-Size="medium" ForeColor="Black" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                             <dx:ASPxTextBox ID="txtPrima" ClientInstanceName="txtPrima" runat="server" Font-Size="medium" MaxLength="15" ForeColor="Black" Style="width: 50%"></dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblUDI" ClientInstanceName="lblUDI" runat="server" Text="UDI:" Font-Size="medium" ForeColor="Black" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td colspan="2">

                                            <dx:ASPxTextBox ID="txtUDI" ClientInstanceName="txtUDI" Font-Size="medium" MaxLength="30" ForeColor="Black" runat="server" Style="width: 50%"></dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblCompañía" ClientInstanceName="lblCompañía" runat="server" Text="Aseguradora:" Font-Size="medium" ForeColor="Black" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtCompañía" ClientInstanceName="txtCompañía" runat="server" MaxLength="100" Font-Size="medium" ForeColor="Black" Style="width: 95%"></asp:TextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblPoliza" ClientInstanceName="lblPóliza" runat="server" Text="Póliza:" Font-Size="medium" ForeColor="Black" Width="100%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td colspan="2">
                                            <asp:TextBox ID="txtPoliza" ClientInstanceName="txtPóliza" runat="server" Font-Size="medium" MaxLength="15" ForeColor="Black" Style="width: 50%"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblFechaCorte" ClientInstanceName="lblFechaCorte" runat="server" Text="Fecha corte:" Font-Size="medium" ForeColor="Black" Width="90%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxDateEdit ID="ASPxDateEdit3" ClientInstanceName="ASPxDateEdit3" runat="server" Font-Size="Medium"></dx:ASPxDateEdit>
                                        </td>
                                        <td>&nbsp;</td>
                                        <td>&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <dx:ASPxButton runat="server" ID="btnCalcular" ClientInstanceName="btnCalcular" Text="Calcular" Font-Size="Medium" AutoPostBack="false">
                                                <ClientSideEvents Click="function(s, e) { OnCalculaMontos(); }" />
                                            </dx:ASPxButton>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblMontoPrimasNoDevengadas" ClientInstanceName="lblMontoPrimasNoDevengadas" runat="server" Text="Monto primas no devengadas:" ForeColor="Black" Font-Size="medium" Width="90%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtMontoPrimasNoDevengadas" ClientInstanceName="txtMontoPrimasNoDevengadas" MaxLength="15" ForeColor="Black" Font-Size="medium" runat="server" Style="width: 50%" DisplayFormatString="c">
                                                
                                            </dx:ASPxTextBox>
                                        </td>
                                        <td>
                                            <dx:ASPxLabel ID="lblMontoDeProporcionales" ClientInstanceName="lblMontoDeProporcionales" runat="server" Text="Monto de proporcionales:" Font-Size="medium" ForeColor="Black" Width="90%" Style="text-align: left"></dx:ASPxLabel>
                                        </td>
                                        <td>
                                            <dx:ASPxTextBox ID="txtMontoDeProporcionales" ClientInstanceName="txtMontoDeProporcionales" runat="server" MaxLength="15" Font-Size="medium" ForeColor="Black" Style="width: 50%" DisplayFormatString="c">
                                            </dx:ASPxTextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="padding: 4px"></td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td>
                                            <dx:ASPxButton ID="ASPxButton2" runat="server" Text="Limpiar información" Width="20%" AutoPostBack="false">
                                                <ClientSideEvents Click="function(s, e){ window.location.reload(); }" /> 
                                            </dx:ASPxButton>
                                        </td>
                                        <td>
                                            <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Salir" Width="20%" AutoPostBack="false">
                                                <ClientSideEvents Click="function(s, e){ window.location.reload(); }" /> 
                                            </dx:ASPxButton>
                                        </td>
                                    </tr>
                                </table>
                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxCallbackPanel>
    </form>
</body>
</html>
