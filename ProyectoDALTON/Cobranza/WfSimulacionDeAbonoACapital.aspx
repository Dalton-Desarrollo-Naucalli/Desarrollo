<%@ Page Language="VB" AutoEventWireup="true" CodeFile="WfSimulacionDeAbonoACapital.aspx.vb" Inherits="Cobranza_WfSimulacionDeAbonoACapital" %>
<%@ Register Assembly="DevExpress.Web.ASPxScheduler.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxScheduler" TagPrefix="dxwschs" %>
<%@ Register Assembly="DevExpress.Data.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data" TagPrefix="dx" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Simulación de Abono a Capital</title>
    <link href="../Estilos/Principal.css" type="text/css" rel="stylesheet" />   

      <script type="text/javascript">

       function EjecutaSimulacion()
       {
           //alert("EjecutaSimulacion...");
           CallBackTablaSimulacion.Callback("vSistema");
       }

    function CompletaCallback()
      {

        //alert("CompletaCallback...");

      }      
      
    </script>

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
                                            <dx:ASPxLabel ID="lblEmpresa" runat="server" Text="Empresa:"/>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="comboEmpresa" runat="server"/>
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
                            <td style="text-align:center">
                                <table>
                                    <tr>
                                        <td>
                                            <dx:ASPxLabel ID="lblAnexo2" runat="server" Text="Anexo:"/>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <dx:ASPxComboBox ID="comboAnexo" runat="server"/>
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

                          <dx:TabPage Name="tabMnto" Text="Simulador de abono a capital" ClientEnabled="true">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                        <table style="width:100%" border="0" >
                                            <tr>    
                                                <td style="text-align:center">
                                                    <table style="width:100%" border="0" >
                                                        <tr>
                                                            <td style="text-align:center">
                                                                <table style="width:100%" border="0">
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblAcreditado" runat="server" Text="Acreditado:" ></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxTextBox ID="txtcreditado" runat="server" Width="250px" NullText="Acreditado..." />
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:10px"></tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblContrato1" runat="server" Text="Contrato:" ></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxTextBox ID="txtContrato1" runat="server" Width="250px" NullText="Contrato..." />
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:10px"></tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblAnexo3" runat="server" Text="Anexo:" ></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxTextBox ID="txtAnexo2" runat="server" Width="250px" NullText="Anexo..." />
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:10px"></tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblVIN1" runat="server" Text="VIN:" ></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxTextBox ID="txtVIN1" runat="server" Width="250px" NullText="VIN..." />
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:10px"></tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblSaldosInsolutosVencidos" runat="server" Text="Saldos insolutos actuales:" ></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxTextBox ID="txtSaldosInsolutosVencidos" runat="server" Width="250px" NullText="Saldos insolutos actuales..." />
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:10px"></tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblPlazoContratado" runat="server" Text="Plazo contratado:" ></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxTextBox ID="txtPlazoContratado" runat="server" Width="250px" NullText="Plazo contratado..." />
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:10px"></tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblMensualidadOriginal" runat="server" Text="Mensualidad original:" ></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxTextBox ID="txtMensualidadOriginal" runat="server" Width="250px" NullText="Mensualidad original..." />
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:10px"></tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblMensualidadesRestantesOriginal" runat="server" Text="Mensualidades restantes (original):" ></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxTextBox ID="txtMensualidadesRestantesOriginal" runat="server" Width="250px" NullText="Mensualidades restantes (original)..." />
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:10px"></tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblMontoAbonoACapital" runat="server" Text="Monto abono a capital:" ></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxTextBox ID="txtMontoAbonoACapital" runat="server" Width="250px" NullText="Monto abono a capital..." />
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:10px"></tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left">
                                                                            <dx:ASPxLabel ID="lblFechaEstimadaDeAbono" runat="server" Text="Fecha estimada de abono:" ></dx:ASPxLabel>
                                                                        </td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <dx:ASPxTextBox ID="txtFechaEstimadaDeAbono" runat="server" Width="250px" NullText="Fecha estimada de abono..." />
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:12px"></tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left"></td>
                                                                        <td style="width:35%; text-align:left">
                                                                           <table style="width:40%" border="0">
                                                                                <tr>
                                                                                    <td style="text-align:center; width:25%">
                                                                                        <asp:RadioButton ID="radioReducePlazo" Text="Reducir plazo" runat="server" GroupName="radioReducePlazoMensualidad" />
                                                                                    </td>
                                                                                    <td style="text-align:center; width:25%">
                                                                                        <asp:RadioButton ID="radioReduceMensualidad" Text="Reducir mensualidad" runat="server" GroupName="radioReducePlazoMensualidad" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </td>
                                                                    </tr>
                                                                    <tr style="height:12px"></tr>
                                                                    <tr>
                                                                        <td style="width:15%; text-align:left"></td>
                                                                        <td style="width:35%; text-align:left">
                                                                            <asp:Button ID="buttonSimular" runat="server" Text="Simular" OnClientClick="javascript:EjecutaSimulacion();" />
                                                                        </td>
                                                                    </tr>

                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <ComponentArt:CallBack id="CallBackTablaSimulacion" runat="server" >
                                                                                <Content>
                                                                                    <asp:PlaceHolder ID="PlaceHolderSimulacion" runat="server" />
                                                                                </Content>
                                                                                <ClientEvents>
                                                                                    <CallbackComplete EventHandler="CompletaCallback"/>
                                                                                </ClientEvents>                                    
                                                                            </ComponentArt:CallBack>

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

                            <dx:TabPage Name="tabMnto" Text="Simulacion disminución de monto de pago" Enabled="true">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                        <table style="width:100%" border="0" >
                                            <tr>
                                                <td style="text-align:left">
                                                    <table style="width:100%" border="0">
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblAcreditado1" runat="server" Text="Acreditado:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtAcreditado" runat="server" Width="250px" NullText="Acreditado..." />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblAnexo7" runat="server" Text="Anexo:" />
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtAnexo7" runat="server" Width="250px" NullText="Anexo..." />
                                                            </td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblNumeroDePagosRestantesOriginales" runat="server" Text="Número de pagos restantes originales:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtNumeroDePagosRestantesOriginales" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblMontoPagoInicial" runat="server" Text="Monto pago inicial:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtMontoPagoInicial" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblNuevoSaldoInsoluto" runat="server" Text="Nuevo saldo insoluto:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtNuevoSaldoInsoluto" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:center; width:15%"></td>
                                                            <td style="text-align:center; width:35%"></td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblNumeroDePagosRestantesNuevos" runat="server" Text="Número de pagos restantes nuevos:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtNumeroDePagosRestantesNuevos" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblMontoDePagoNuevo" runat="server" Text="Monto de pago nuevo:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtMontoDePagoNuevo" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblTasaAnual" runat="server" Text="Tasa anual:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtTasaAnual" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblPagoConstante" runat="server" Text="Pago constante:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtPagoConstante" runat="server" Width="250px" NullText="0" />
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
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:center;" colspan="2">
                                                                <asp:Button ID="Button1" runat="server" Text="Cancelar" />
                                                            </td>
                                                            <td style="text-align:center;" colspan="2">
                                                                <asp:Button ID="Button2" runat="server" Text="Aceptar" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>
                       
                            <dx:TabPage Name="tabMnto" Text="Reducción de plazo" Enabled="true">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                        <table style="width:100%" border="0" >
                                            <tr>
                                                <td style="text-align:center">
                                                    <table style="width:100%" border="0">
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblAcreditadoa" runat="server" Text="Acreditado:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtAcreditado4" runat="server" Width="250px" NullText="Acreditado..." />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblAnexo4" runat="server" Text="Anexo:" />
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtAnexo4" runat="server" Width="250px" NullText="Anexo..." />
                                                            </td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblNumeroDePagosRestantesOriginales2" runat="server" Text="Número de pagos restantes originales:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtNumeroDePagosRestantesOriginales2" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblMontoDePagoInicial2" runat="server" Text="Monto pago inicial:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtMontoDePagoInicial2" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblNuevoSaldoInsooluto2" runat="server" Text="Nuevo saldo insoluto:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtNuevoSaldoInsooluto2" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:center; width:15%"></td>
                                                            <td style="text-align:center; width:35%"></td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblNumeroDePagosRestantesNuevos2" runat="server" Text="Número de pagos restantes nuevos:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtNumeroDePagosRestantesNuevos2" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblMontoDePagoNuevo2" runat="server" Text="Monto de pago nuevo:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtMontoDePagoNuevo2" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                        </tr>
                                                        <tr style="height:20px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblActual" runat="server" Text="ACTUAL" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%"></td>
                                                            <td style="text-align:left; width:15%"></td>
                                                            <td style="text-align:right; width:35%"></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4" >
                                                                <table style="width:100%; border-width:thick ">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:PlaceHolder ID="PlaceHolderActual" runat="server"></asp:PlaceHolder>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblTasaAnual2" runat="server" Text="Tasa anual:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtTasaAnual2" runat="server" Width="150px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblPagoConstante2" runat="server" Text="Pago constante:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtPagoConstante2" runat="server" Width="150px" NullText="0" />
                                                            </td>
                                                        </tr>
                                                        <tr style="height:20px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="PROPUESTA" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%"></td>
                                                            <td style="text-align:left; width:15%"></td>
                                                            <td style="text-align:right; width:35%"></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4" >
                                                                <table style="width:100%; border-width:thick ">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:PlaceHolder ID="PlaceHolderPropuesta" runat="server"></asp:PlaceHolder>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr style="height:20px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <asp:Button ID="Button3" runat="server" Text="Aceptación" />
                                                            </td>
                                                            <td style="text-align:right; width:35%"></td>
                                                            <td style="text-align:left; width:15%"></td>
                                                            <td style="text-align:right; width:35%"></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                        </table>
                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>

                            <dx:TabPage Name="tabMnto" Text="Aplicación abono a capital" Enabled="true">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                        <table style="width:100%" border="0" >
                                            <tr>
                                                <td style="text-align:center">
                                                    <table style="width:100%" border="0">
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblAcreditadoAbonoCapital" runat="server" Text="Acreditado:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtAcreditadoAbonoCapital" runat="server" Width="250px" NullText="Acreditado..." />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblAnexoAbonoCapital" runat="server" Text="Anexo:" />
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtAnexoAbonoCapital" runat="server" Width="250px" NullText="Anexo..." />
                                                            </td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblMontoAbonoCapital" runat="server" Text="Monto:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtMontoAbonoCapital" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblFechaDePagoAbonoACapital" runat="server" Text="Fecha de pago:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtFechaDePagoAbonoACapital" runat="server" Width="250px" NullText="Fecha de pago..." />
                                                            </td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblReferenciaAbonoCapital" runat="server" Text="Referencia:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtReferenciaAbonoCapital" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:center; width:15%"></td>
                                                            <td style="text-align:center; width:35%"></td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:center; width:15%"></td>
                                                            <td style="text-align:center" colspan="3">
                                                                <table>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:RadioButton ID="radioReduccionDeNumeroDePagos" Text="Reducción de número de pagos" runat="server" GroupName="radioAplicacionAbonoACapital" />
                                                                        </td>
                                                                        <td style="width:25px"></td>
                                                                        <td style="text-align:center" colspan="2">
                                                                            <asp:RadioButton ID="radioReduccionDeMontoDePago" Text="Reducción de monto de pago" runat="server" GroupName="radioAplicacionAbonoACapital" />
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblContratoAbonoACapital" runat="server" Text="Contrato:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtContratoAbonoACapital" runat="server" Width="250px" NullText="Contrato..." />
                                                            </td>
                                                            <td style="text-align:left; width:15%"></td>
                                                            <td style="text-align:right; width:35%"></td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblAnexoAbonoACapital" runat="server" Text="Anexo:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtAnexoAbonoACapital" runat="server" Width="250px" NullText="Anexo..." />
                                                            </td>
                                                            <td style="text-align:left; width:15%"></td>
                                                            <td style="text-align:right; width:35%"></td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblSaldoALaFechaDeUltimoCorte" runat="server" Text="Saldo a la fecha de último corte:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtSaldoALaFechaDeUltimoCorte" runat="server" Width="250px" NullText="Saldo a la fecha de último corte..." />
                                                            </td>
                                                            <td style="text-align:left; width:15%"></td>
                                                            <td style="text-align:right; width:35%"></td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblInteresesALaFechaDeUltimoCorte" runat="server" Text="Intereses a la fecha de último corte:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtInteresesALaFechaDeUltimoCorte" runat="server" Width="250px" NullText="Intereses a la fecha de último corte..." />
                                                            </td>
                                                            <td style="text-align:left; width:15%"></td>
                                                            <td style="text-align:right; width:35%"></td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblIVAALaFechaDeUltimoCorte" runat="server" Text="IVA a la fecha de último corte:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtIVAALaFechaDeUltimoCorte" runat="server" Width="250px" NullText="IVA a la fecha de último corte..." />
                                                            </td>
                                                            <td style="text-align:left; width:15%"></td>
                                                            <td style="text-align:right; width:35%"></td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblDiasTranscurridosDesdeUltimoCorte" runat="server" Text="Días transcurridos desde último corte:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtDiasTranscurridosDesdeUltimoCorte" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:left; width:15%"></td>
                                                            <td style="text-align:right; width:35%"></td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblMontoPorAplicarACapital" runat="server" Text="Monto por aplicar a capital:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtMontoPorAplicarACapital" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:left; width:15%"></td>
                                                            <td style="text-align:right; width:35%"></td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblTotalAmortizacion" runat="server" Text="Total amortización:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtTotalAmortizacion" runat="server" Width="250px" NullText="Total amortización..." />
                                                            </td>
                                                            <td style="text-align:left; width:15%"></td>
                                                            <td style="text-align:right; width:35%"></td>
                                                        </tr>
                                                        <tr style="height:20px"></tr>
                                                        <tr>
                                                            <td style="text-align:center; width:15%"></td>
                                                            <td style="text-align:center" colspan="3">
                                                                <table>
                                                                    <tr>
                                                                        <td style="text-align:center">
                                                                            <dx:ASPxLabel ID="lblEnviaTablaDeAmortizacion" runat="server" Text="Envia nueva tabla de amortización a cliente:" ></dx:ASPxLabel>
                                                                            <asp:CheckBox ID="checkEnviaNuevaTablaDeAmortizacion" runat="server" />
                                                                        </td>
                                                                        <td style="width:15px"></td>
                                                                        <td style="text-align:center">
                                                                            <asp:Button ID="Button4" runat="server" Text="Ver tabla de amortización" />
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

                            <dx:TabPage Name="tabMnto" Text="Simulación disminución de monto de pago" Enabled="true">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                        <table style="width:100%" border="0" >
                                            <tr>
                                                <td style="text-align:center">
                                                    <table style="width:100%" border="0">
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblAcreditadoDisminucionDeMonto" runat="server" Text="Acreditado:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtAcreditadoDisminucionMonto" runat="server" Width="250px" NullText="Acreditado..." />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblAnexoDisminucionDeMonto" runat="server" Text="Anexo:" />
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtAnexoDisminucionDeMonto" runat="server" Width="250px" NullText="Anexo..." />
                                                            </td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblNumeroDePagoRestantesDisminucionDeMonto" runat="server" Text="Número de pagos restantes originales:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtNumeroDePagoRestantesDisminucionDeMonto" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblMontoDePagoInicialDisminucionDeMonto" runat="server" Text="Monto pago inicial:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtMontoDePagoInicialDisminucionDeMonto" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblNuevoSaldoInsolutoDisminucionDeMonto" runat="server" Text="Nuevo saldo insoluto:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtNuevoSaldoInsolutoDisminucionDeMonto" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:center; width:15%"></td>
                                                            <td style="text-align:center; width:35%"></td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblInteresesMasIVADisminucionDeMonto" runat="server" Text="Interés mas IVA a:"/>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtInteresesMasIVADisminucionDeMonto" runat="server" Width="250px" NullText="27" />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblAmortizacionADisminucionDeMonto" runat="server" Text="Amortización a:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtAmortizacionADisminucionDeMonto" runat="server" Width="250px" NullText="30" />
                                                            </td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblNumeroDePagoRestantesNuevosDisminucionDeMonto" runat="server" Text="Número de pagos restantes nuevos:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtNumeroDePagoRestantesNuevosDisminucionDeMonto" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblMontoDePagoNuevoDisminucionDeMonto" runat="server" Text="Monto de pago nuevo:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtMontoDePagoNuevoDisminucionDeMonto" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblMontoAFinanciarDisminucionDeMonto" runat="server" Text="Monto a financiar:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtMontoAFinanciarDisminucionDeMonto" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblTasaAnualDisminucionDeMonto" runat="server" Text="Tasa anual:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtTasaAnualDisminucionDeMonto" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                        </tr>                                                     
                                                        <tr style="height:20px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="ASPxLabel16" runat="server" Text="REQUERIMIENTO" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%"></td>
                                                            <td style="text-align:left; width:15%"></td>
                                                            <td style="text-align:right; width:35%"></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4" >
                                                                <table style="width:100%; border-width:thick ">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:PlaceHolder ID="PlaceHolderRequerimiento" runat="server"></asp:PlaceHolder>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr style="height:20px"></tr>
                                                        <tr>
                                                            <td style="text-align:center; width:15%"></td>
                                                            <td style="text-align:center" colspan="3">
                                                                <table>
                                                                    <tr>
                                                                        <td style="text-align:center">
                                                                            <asp:Button ID="buttonCancelar" runat="server" Text="Cancelar" />                                                                        
                                                                        </td>
                                                                        <td style="width:15px"></td>
                                                                        <td style="text-align:center">
                                                                            <asp:Button ID="buttonAplicarPago" runat="server" Text="Aplicar Pago" />
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

                            <dx:TabPage Name="tabMnto" Text="Simulación disminución de número de pagos" Enabled="true">
                                <ContentCollection>
                                    <dx:ContentControl runat="server">      
                                        <table style="width:100%" border="0" >
                                            <tr>
                                                <td style="text-align:center">
                                                    <table style="width:100%" border="0">
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblAcreditadoDisminucionDeNumeroDePagos" runat="server" Text="Acreditado:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtAcreditadoDisminucionDeNumeroDePagos" runat="server" Width="250px" NullText="Acreditado..." />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblAnexoDosminucionDeNumeroDePagos" runat="server" Text="Anexo:" />
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtAnexoDosminucionDeNumeroDePagos" runat="server" Width="250px" NullText="Anexo..." />
                                                            </td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblNumeroDePagosRestantesOriginalesDisminucionDeNumeroDePagos" runat="server" Text="Número de pagos restantes originales:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtNumeroDePagosRestantesOriginalesDisminucionDeNumeroDePagos" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblMontoPagoInicialDisminucionDeNumeroDePagos" runat="server" Text="Monto de pago inicial:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtMontoPagoInicialDisminucionDeNumeroDePagos" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblNumeroDePagosRestantesNuevosDisminucionDeNumeroDePagos" runat="server" Text="Número de pagos restantes nuevos:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtNumeroDePagosRestantesNuevosDisminucionDeNumeroDePagos" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblMontoPagoNuevoDisminucionDeNumeroDePagos" runat="server" Text="Monto de pago nuevo:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtMontoPagoNuevoDisminucionDeNumeroDePagos" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                        </tr>
                                                        <tr style="height:10px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblNuevoSaldoInsolutoDisminucionDeNumeroDePagos" runat="server" Text="Nuevo saldo insoluto:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtNuevoSaldoInsolutoDisminucionDeNumeroDePagos" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="lblTasaAnualDisminucionDeNumeroDePagos" runat="server" Text="Tasa anual:" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%">
                                                                <dx:ASPxTextBox ID="txtTasaAnualDisminucionDeNumeroDePagos" runat="server" Width="250px" NullText="0" />
                                                            </td>
                                                        </tr>                                                     
                                                        <tr style="height:20px"></tr>
                                                        <tr>
                                                            <td style="text-align:left; width:15%">
                                                                <dx:ASPxLabel ID="ASPxLabel13" runat="server" Text="REQUERIMIENTO" ></dx:ASPxLabel>
                                                            </td>
                                                            <td style="text-align:right; width:35%"></td>
                                                            <td style="text-align:left; width:15%"></td>
                                                            <td style="text-align:right; width:35%"></td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="4" >
                                                                <table style="width:100%; border-width:thick ">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:PlaceHolder ID="PlaceHolderRequerimiento2" runat="server"></asp:PlaceHolder>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </td>
                                                        </tr>
                                                        <tr style="height:20px"></tr>
                                                        <tr>
                                                            <td style="text-align:center; width:15%"></td>
                                                            <td style="text-align:center" colspan="3">
                                                                <table>
                                                                    <tr>
                                                                        <td style="text-align:center">
                                                                            <asp:Button ID="buttonCancelar1" runat="server" Text="Cancelar" />                                                                        
                                                                        </td>
                                                                        <td style="width:15px"></td>
                                                                        <td style="text-align:center">
                                                                            <asp:Button ID="buttonAplicarPago1" runat="server" Text="Aplicar Pago" />
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




