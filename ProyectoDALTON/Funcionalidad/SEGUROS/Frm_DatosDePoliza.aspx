<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Frm_DatosDePoliza.aspx.cs" Inherits="Funcionalidad_Frm_DatosDePoliza" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript">
        function OnCallbackComplete(s, e) {
            if (s.cpError !== "") {
                alert(s.cpError);
                window.history.back();
            }
        }
        function getUrlNuevaPoliza() {
            return ('PopUpRenovacionSeguros.aspx?id=' + document.getElementById('param').value);
        }
        function getUrlEndoso() {
            return ('PopUpEndosoSeguro.aspx?id=' + document.getElementById('param').value);
        }
        function getUrlCancelacion() {
            return ('PopUpCancelacionSeguro.aspx?id=' + document.getElementById('param').value);
        }
        function getUrlComentarios() {
            return ('PopUpComentario.aspx?id=' + document.getElementById('param').value + '&con=' + document.getElementById('consecutivo').value);
        }
        function getUrlBitacora() {
            return ('PopUpBitacora.aspx?id=' + document.getElementById('param').value + '&con=' + document.getElementById('consecutivo').value);
        }
        function hideModal() {
            ASPxPopupControl1.Hide();
        }
        function disableControls() {
            var elementos = ASPxClientControl.GetControlCollection();
            for (var k in elementos) {
                var control = elementos.elements[k];
                if (control != null && ASPxIdent.IsASPxClientEdit(control)) {
                    control.SetEnabled(false);
                }
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="modalArea" runat="server"></div>
        <div>
            <dx:ASPxRoundPanel ID="ASPxRoundPanel1" ClientInstanceName="ASPxRoundPanel1" runat="server" ShowCollapseButton="true" Width="100%" HeaderText="INFORMACIÓN DEL SEGURO" HeaderStyle-HorizontalAlign="Center">
                <HeaderStyle HorizontalAlign="Center" Font-Bold="True"></HeaderStyle>
                <PanelCollection>
                    <dx:PanelContent runat="server">
                        <table style="width: 100%">
                            <tr>
                                <td>
                                    <asp:HiddenField ID="param" runat="server" ClientIDMode="Static" />
                                    <asp:HiddenField ID="consecutivo" runat="server" ClientIDMode="Static" />
                                </td>
                                <td>
                                    <%--<dx:ASPxLabel ID="lblAccesos" runat="server" ClientIDMode="AutoID" ClientInstanceName="lblAccesos">
                                    </dx:ASPxLabel>--%>
                                </td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="padding: 4px"></td>
                            </tr>
                            <tr>
                                <td style="width: 20%">
                                    <dx:ASPxLabel ID="lblCliente" Font-Size="Medium" ClientInstanceName="lblCliente" ForeColor="Black" runat="server" Text="Cliente:"></dx:ASPxLabel>
                                </td>
                                <td style="width: 30%">
                                    <dx:ASPxTextBox ID="txtCliente" Font-Size="Medium" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtCliente" Width="75%" MaxLength="30" AutoPostBack="true">
                                    </dx:ASPxTextBox>
                                </td>
                                <td style="width: 20%">
                                    <dx:ASPxLabel ID="lblEstatus" Font-Size="Medium" ClientInstanceName="lblEstatus" ForeColor="Black" runat="server" Text="Estatus:"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtEstatus" Font-Size="Medium" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtEstatus" Width="75%" MaxLength="30">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding: 4px"></td>
                            </tr>
                            <tr>
                                <td style="width: 20%">
                                    <dx:ASPxLabel ID="lblNoDeContrato" Font-Size="Medium" ClientInstanceName="lblNoDeContrato" ForeColor="Black" runat="server" Text="Número de contrato:"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtNoContrato" Font-Size="Medium" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtNoContrato" Width="25%" MaxLength="15">
                                    </dx:ASPxTextBox>
                                </td>
                                <td style="width: 20%">
                                    <dx:ASPxLabel ID="lblFondeardora" Font-Size="Medium" ClientInstanceName="lblFondeardora" ForeColor="Black" runat="server" Text="Fondeadora:"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <strong>
                                        <dx:ASPxTextBox ID="txtFondeadora" Font-Size="Medium" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtFondeadora" Width="75%" MaxLength="50">
                                        </dx:ASPxTextBox>
                                    </strong>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding: 4px"></td>
                            </tr>
                            <tr>
                                <td style="width: 20%">
                                    <dx:ASPxLabel ID="lblAnexo" ClientInstanceName="lblAnexo" Font-Size="Medium" ForeColor="Black" runat="server" Text="Anexo:"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtAnexo" runat="server" Font-Size="Medium" ClientIDMode="AutoID" ClientInstanceName="txtAnexo" Width="25%" MaxLength="15">
                                    </dx:ASPxTextBox>
                                </td>
                                <td style="width: 20%">
                                    <dx:ASPxLabel ID="lblEndoso" Font-Size="Medium" ClientInstanceName="lblEndoso" ForeColor="Black" runat="server" Text="Endoso:"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtEndoso" Font-Size="Medium" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtEndoso" Width="25%" MaxLength="15">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding: 2px"></td>
                            </tr>
                            <tr>
                                <td style="width: 20%">
                                    <dx:ASPxLabel ID="lblVIN" Font-Size="Medium" ClientInstanceName="lblVIN" ForeColor="Black" runat="server" Text="VIN:"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtVIN" Font-Size="Medium" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtVIN" Width="75%" MaxLength="16">
                                    </dx:ASPxTextBox>
                                </td>
                                <td style="width: 20%">
                                    <dx:ASPxLabel ID="lblSiniestro" Font-Size="Medium" ClientInstanceName="lblSiniestro" ForeColor="Black" runat="server" Text="Siniestro:"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxRadioButtonList ID="rblSiniestro" runat="server" Border-BorderStyle="None" Font-Size="Medium" ClientIDMode="AutoID" ClientInstanceName="rblSiniestro" CssClass="auto-style36" RepeatDirection="Horizontal">
                                        <Items>
                                            <dx:ListEditItem Text="No" Value="0" />
                                            <dx:ListEditItem Text="Si" Value="1" />
                                        </Items>
                                    </dx:ASPxRadioButtonList>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding: 2px"></td>
                            </tr>
                            <tr>
                                <td style="width: 20%">
                                    <dx:ASPxLabel ID="lblAgencia" ClientInstanceName="lblAgencia" Font-Size="Medium" ForeColor="Black" runat="server" Text="Agencia:"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtAgencia" runat="server" ClientIDMode="AutoID" Font-Size="Medium" ClientInstanceName="txtAgencia" Width="50%" MaxLength="30">
                                    </dx:ASPxTextBox>
                                </td>
                                <td>
                                    <dx:ASPxLabel ID="lblComprara" runat="server" Font-Size="Medium" Text="¿Quién compra seguro?:" ClientIDMode="AutoID" ClientInstanceName="lblComprara">
                                    </dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtComprara" runat="server" ClientIDMode="AutoID" Font-Size="Medium" ClientInstanceName="txtComprara" Width="50%" MaxLength="30">
                                    </dx:ASPxTextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="padding: 4px"></td>
                            </tr>
                            <tr>
                                <td style="width: 20%">
                                    <dx:ASPxLabel ID="lblPromotor" ClientInstanceName="lblPromotor" Font-Size="Medium" ForeColor="Black" runat="server" Text="Promotor:"></dx:ASPxLabel>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="txtPromotor" Font-Size="Medium" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtPromotor" Width="50%" MaxLength="30">
                                    </dx:ASPxTextBox>
                                </td>
                                <td></td>
                                <td></td>
                            </tr>
                        </table>
                        <br />
                        <br />
                        <dx:ASPxRoundPanel ID="ASPxRoundPanel2" ClientInstanceName="ASPxRoundPanel2" runat="server" ShowCollapseButton="True" Width="100%" HeaderText="DATOS DE LA PÓLIZA" HeaderStyle-HorizontalAlign="Center">
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True"></HeaderStyle>
                            <PanelCollection>
                                <dx:PanelContent runat="server">
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 20%">
                                                <dx:ASPxLabel ID="lblNoDePoliza" ClientInstanceName="lblNoDePoliza" Font-Size="Medium" ForeColor="Black" runat="server" Text="Número de póliza:"></dx:ASPxLabel>
                                            </td>
                                            <td style="width: 30%">
                                                <dx:ASPxTextBox ID="txtNoPoliza" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtNoPoliza" Width="50%" Font-Size="Medium">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 4px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 20%">
                                                <dx:ASPxLabel ID="lblFechaDeEmision" ClientInstanceName="lblFechaDeEmision" Font-Size="Medium" ForeColor="Black" runat="server" Text="Fecha de emisión:"></dx:ASPxLabel>
                                            </td>
                                            <td style="width: 30%">
                                                <dx:ASPxTextBox ID="txtFechaEmision" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtFechaEmision" Width="50%" Font-Size="Medium">
                                                    <%--<MaskSettings Mask="yyyy-MM-dd" />--%>
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td style="width: 20%">
                                                <dx:ASPxLabel ID="lblNoDeEndoso" ClientInstanceName="lblNoDeEndoso" Font-Size="Medium" ForeColor="Black" runat="server" Text="Número de endoso:"></dx:ASPxLabel>
                                            </td>
                                            <td style="width: 30%">
                                                <dx:ASPxTextBox ID="txtNoEndoso" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtNoEndoso" Width="50%" Font-Size="Medium">
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 4px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 20%">
                                                <dx:ASPxLabel ID="lblFechaVencimiento" ClientInstanceName="lblFechaVencimiento" Font-Size="Medium" ForeColor="Black" runat="server" Text="Fecha de vencimiento:"></dx:ASPxLabel>
                                            </td>
                                            <td>
                                                <dx:ASPxTextBox ID="txtFechaVencimiento" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtFechaVencimiento" Width="50%" Font-Size="Medium">
                                                    
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td style="width: 20%">
                                                <dx:ASPxLabel ID="lblCuentaClabe" ClientInstanceName="lblCuentaClabe" Font-Size="Medium" ForeColor="Black" runat="server" Text="Cuenta Clabe:"></dx:ASPxLabel>
                                            </td>
                                            <td style="width: 30%">
                                                <dx:ASPxTextBox ID="txtCuentaContable" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtCuentaContable" Width="75%" MaxLength="30" Font-Size="Medium">
                                                </dx:ASPxTextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 4px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 20%">
                                                <dx:ASPxLabel ID="lblCostoPolizaSinIVA" ClientInstanceName="lblCostoPolizaSinIVA" Font-Size="Medium" ForeColor="Black" runat="server" Text="Costo de póliza sin IVA:"></dx:ASPxLabel>
                                            </td>
                                            <td>
                                                <dx:ASPxTextBox ID="txtCostoPolizaSinIVA" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtCostoPolizaSinIVA" Width="50%" MaxLength="15" Font-Size="Medium">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td style="width: 20%">
                                                <dx:ASPxLabel ID="lblCuenta" ClientInstanceName="lblCuenta" Font-Size="Medium" ForeColor="Black" runat="server" Text="Cuenta:"></dx:ASPxLabel>
                                            </td>
                                            <td>
                                                <dx:ASPxTextBox ID="txtCuenta" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtCuenta" Width="50%" MaxLength="30" Font-Size="Medium">
                                                </dx:ASPxTextBox>
                                            </td>                                            
                                        </tr>
                                        <tr>
                                            <td style="padding: 4px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 20%">
                                                <dx:ASPxLabel ID="lblCostoTotal" ClientInstanceName="lblCostoTotal" Font-Size="Medium" ForeColor="Black" runat="server" Text="Costo total:"></dx:ASPxLabel>
                                            </td>
                                            <td>
                                                <dx:ASPxTextBox ID="txtCostoTotal" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtCostoTotal" Width="50%" MaxLength="16" Font-Size="Medium">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td>
                                                <dx:ASPxLabel ID="lblComentario" runat="server" ClientIDMode="AutoID" ClientInstanceName="lblComentario" Font-Size="Medium" Text="Comentario:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td>
                                                <dx:ASPxButton ID="btnAgregarComentario" runat="server" AutoPostBack="False" ClientInstanceName="btnAgregarComentario" CssClass="auto-style40" Text="Agregar comentario">
                                                    <ClientSideEvents Click="function(s, e) { 
                                                        ASPxPopupControl1.SetContentUrl(getUrlComentarios()); 
                                                        ASPxPopupControl1.Show(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 4px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 20%">
                                                <dx:ASPxLabel ID="lblAseguradora" ClientInstanceName="lblAseguradora" Font-Size="Medium" ForeColor="Black" runat="server" Text="Aseguradora:"></dx:ASPxLabel>
                                            </td>
                                            <td>
                                                <dx:ASPxTextBox ID="txtAseguradora" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtAseguradora" Width="75%" MaxLength="30" Font-Size="Medium">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td style="width: 20%">
                                                <dx:ASPxLabel ID="lblBitacora" runat="server" ClientIDMode="AutoID" ClientInstanceName="lblBitacora" Font-Size="Medium" Text="Bitácora:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td>
                                                <dx:ASPxButton ID="btnVerBitacora" runat="server" AutoPostBack="False" ClientInstanceName="btnVerBitacora" CssClass="auto-style40" Text="Mostrar bitácora">
                                                    <ClientSideEvents Click="function(s, e) { 
                                                        ASPxPopupControl1.SetContentUrl(getUrlBitacora()); 
                                                        ASPxPopupControl1.Show(); }" />
                                                </dx:ASPxButton>
                                            </td>
                                        </tr>
                                    </table>

                                    <br />
                                    <table style="width: 100%">
                                        <tr>
                                            <td style="width: 20%">
                                                <dx:ASPxLabel ID="lblUDI" ClientInstanceName="lblUDI" Font-Size="Medium" ForeColor="Black" runat="server" Text="%UDI:"></dx:ASPxLabel>
                                            </td>
                                            <td style="width: 30%">
                                                <dx:ASPxTextBox ID="txtUDI" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtUDI" Width="50%" MaxLength="15" Font-Size="Medium">
                                                </dx:ASPxTextBox>
                                            </td>
                                            
                                        </tr>
                                        <tr>
                                            <td style="padding: 4px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 20%">
                                                <dx:ASPxLabel ID="lblAgente" runat="server" ClientIDMode="AutoID" ClientInstanceName="lblAgente" Font-Size="Medium" Text="Agente:">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td style="width: 30%">
                                                <dx:ASPxTextBox ID="txtAgente" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtAgente" Width="50%" MaxLength="30" Font-Size="Medium">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                        </tr>
                                    </table>
                                </dx:PanelContent>                            
                            </PanelCollection>                            
                        </dx:ASPxRoundPanel>
                        
                        <br />
                        <br />
                        <dx:ASPxRoundPanel ID="ASPxRoundPanel3" runat="server" ShowCollapseButton="True" Width="100%" HeaderText="DATOS DEL VEHICULO" HeaderStyle-HorizontalAlign="Center">
                            <HeaderStyle HorizontalAlign="Center" Font-Bold="True"></HeaderStyle>
                            <PanelCollection>
                                <dx:PanelContent runat="server">
                                    <table class="auto-style2">
                                        <tr>
                                            <td style="width: 20%">
                                                <dx:ASPxLabel ID="lblMarca" runat="server" ClientIDMode="AutoID" ClientInstanceName="lblMarca" Text="Marca:" Font-Size="Medium">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td style="width: 30%">
                                                <dx:ASPxTextBox ID="txtMarca" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtMarca" Width="75%" MaxLength="30" Font-Size="Medium">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 4px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 20%">
                                                <dx:ASPxLabel ID="lblSubMarca" runat="server" ClientIDMode="AutoID" ClientInstanceName="lblSubMarca" Text="Submarca:" Font-Size="Medium">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td style="width: 30%">
                                                <dx:ASPxTextBox ID="txtSubMarca" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtSubMarca" Width="75%" MaxLength="30" Font-Size="Medium">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td style="padding: 4px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 20%">
                                                <dx:ASPxLabel ID="lblModelo" runat="server" ClientIDMode="AutoID" ClientInstanceName="lblModelo" Text="Modelo:" Font-Size="Medium">
                                                </dx:ASPxLabel>
                                            </td>
                                            <td style="width: 30%">
                                                <dx:ASPxTextBox ID="txtModelo" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtModelo" Width="75%" MaxLength="30" Font-Size="Medium">
                                                </dx:ASPxTextBox>
                                            </td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                    </table>
                                </dx:PanelContent>
                            </PanelCollection>
                        </dx:ASPxRoundPanel>

                        <br />
                        <br />
                        <table>
                            <tr>
                                <td style="padding:5px">
                                    <dx:ASPxButton ID="btnRegresar" runat="server" AutoPostBack="False" ClientIDMode="AutoID" ClientInstanceName="btnCancelar" Text="Regresar al monitor">
                                        <ClientSideEvents Click="function(s, e){
                                            window.history.back();
                                        }" />
                                    </dx:ASPxButton>
                                </td>
                                <td style="padding:5px">
                                    <dx:ASPxButton ID="txtCancelar" runat="server" AutoPostBack="False" ClientIDMode="AutoID" ClientInstanceName="txtCancelar" Text="Cancelar póliza">
                                        <ClientSideEvents Click="function(s, e){
                                            ASPxPopupControl1.SetContentUrl(getUrlCancelacion()); 
                                            ASPxPopupControl1.Show();
                                        }" />
                                    </dx:ASPxButton>
                                </td>
                                <td style="padding:5px">
                                    <dx:ASPxButton ID="btnAgregarEndoso" runat="server" AutoPostBack="False" ClientInstanceName="btnAgregarEndoso" CssClass="auto-style40" Text="Agregar endoso">
                                        <ClientSideEvents Click="function(s, e) { 
                                            ASPxPopupControl1.SetContentUrl(getUrlEndoso()); 
                                            ASPxPopupControl1.Show(); 
                                         }" />
                                    </dx:ASPxButton>
                                </td>
                                <td style="padding:5px">
                                    <dx:ASPxButton ID="btnNuevaPoliza" runat="server" AutoPostBack="False" ClientInstanceName="btnNuevaPoliza" CssClass="auto-style40" Text="Renovar póliza">
                                        <ClientSideEvents Click="function(s, e) { 
                                            //ASPxPopupControl1.SetHeaderText('Renovación de póliza de seguro');
                                            ASPxPopupControl1.SetContentUrl(getUrlNuevaPoliza());
                                            ASPxPopupControl1.Show();  
                                        }" />
                                    </dx:ASPxButton>
                                </td>
                            </tr>
                        </table>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>

            <dx:ASPxPopupControl ID="ASPxPopupControl1" runat="server" AllowDragging="True" AllowResize="False"
                CloseAction="CloseButton" Modal="true" PopupAnimationType="Fade" 
                CloseAnimationType="Fade" ModalBackgroundStyle-BackColor="Transparent"
                EnableViewState="False" PopupElementID="modalArea" PopupHorizontalAlign="Center"
                PopupVerticalAlign="Middle" ShowFooter="True" ShowOnPageLoad="False"
                Width="700px" Height="400px" MinWidth="500px" MinHeight="200px"
                HeaderText-="" FooterText="Monitor de consulta general de seguros"
                ClientInstanceName="ASPxPopupControl1" EnableHierarchyRecreation="true" FooterStyle-Wrap="True">
                <ContentStyle Paddings-Padding="10px" />
            </dx:ASPxPopupControl>
        </div>
    </form>
</body>
</html>
