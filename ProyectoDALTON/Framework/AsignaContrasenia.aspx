<%@ Page Language="VB" AutoEventWireup="false" CodeFile="AsignaContrasenia.aspx.vb" Inherits="Framework_AsignaContrasenia" EnableEventValidation ="false"  %>
<%@ Register Assembly="ComponentArt.Web.UI" Namespace="ComponentArt.Web.UI" TagPrefix="ComponentArt" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="EN">
  <head>
    <title>..:: Asigne su nueva Contrase�a ::..</title> <%--Personalizable--%>
    <link href="../Estilos/Principal.css" type="text/css" rel="stylesheet" />    
    <script type="text/javascript" src="../funcionesJS/Principal.js"  language="javascript" ></script>
    <script type="text/javascript">
    
    function limpiaMensaje()
      {
       document.getElementById("lblMensajes").innerHTML = "";
      }

    function cierraVentana()
      {
       window.close();
      }

    </script>

 <%  
     HttpContext.Current.Response.Cache.SetExpires(DateTime.Now.AddYears(-10))
     HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache)
     HttpContext.Current.Response.Cache.SetNoStore()
 %> 
 
</head>
<body class ="Pagina">  
    <form id="Form1" method="post" runat="server" >
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <table border="0" cellpadding="1" cellspacing="1" width="100%">
            <tr>
                <td align="center">
                    <asp:Panel ID="Panel1" runat="server" Width="99%" Wrap ="false" ScrollBars="none" style="background-color:White">
                    <cc1:RoundedCornersExtender id="RoundedCornersExtender1" runat="server" BehaviorID="RoundCornerBehavior1" BorderColor ="#7591bc" Corners="All" Radius="10" TargetControlID="Panel1"></cc1:RoundedCornersExtender>
                        <table border="0" cellpadding="1" cellspacing="1" width="100%">
                            <tr>
                                <td align="center" class="EncabezadoForma">
                                    <table border="0" cellpadding="1" cellspacing="1" width="100%">
                                        <tr>
                                            <td align="center">
                                                <asp:Label ID="lblTitulo" runat="server" Text="Asigne su nueva Contrase�a" CssClass="GlobalSubtitulo"></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100">
                                        <tr>
                                            <td align="center" style="height:40px">
                                                <asp:Label ID="lblMensajes" Runat="server" CssClass="AccesoEtiqueta" Text="" style="color:Green"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" valign="middle">
                                                <asp:Panel ID="PanelMSJFuncionalidad" runat="server">
                                                    <table border="0" cellpadding="1" cellspacing="1" width="100%">
                                                        <tr>
                                                            <td align="right">
                                                                <b><asp:Label ID="lblContrase�aActual" Runat="server" CssClass="AccesoEtiqueta" Text="Contrase�a Actual:" ></asp:Label></b>
		                                                    </td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txtContraseniaActual" onfocus="javascript:limpiaMensaje();" Runat="server" CssClass="AccesoControl" Width="150" MaxLength="30" TextMode="Password"></asp:TextBox>			
		                                                    </td>
		                                                </tr>
		                                                <tr>
		                                                    <td></td>
		                                                    <td align="left">
		                                                        <asp:RequiredFieldValidator style="font-family:Arial; font-size:12px; font-weight:bold" ID="reqContActual" Runat="server" ControlToValidate="txtContraseniaActual" ErrorMessage="Anote su contrase�a Actual..."></asp:RequiredFieldValidator>
		                                                    </td>
		                                                </tr>
                                                        <tr>
                                                            <td align="right">
                                                                <b><asp:Label ID="lblNuevaContrase�a" Runat="server" CssClass="AccesoEtiqueta" Text="Nueva Contrase�a:" ></asp:Label></b>
		                                                    </td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txtNuevaContrasenia" Runat="server" CssClass="AccesoControl" Width="150" MaxLength="30" TextMode="Password"></asp:TextBox>			
		                                                    </td>
		                                                </tr>                
		                                                <tr>
		                                                    <td></td>
		                                                    <td align="left">
		                                                        <asp:RequiredFieldValidator style="font-family:Arial; font-size:12px; font-weight:bold" ID="reqContNueva" Runat="server" ControlToValidate="txtNuevaContrasenia" ErrorMessage="Anote su nueva contrase�a..."></asp:RequiredFieldValidator>
		                                                    </td>
		                                                </tr>
                                                        <tr>
                                                            <td align="right">
                                                                <b><asp:Label ID="lblConfirmaContrasenia" Runat="server" CssClass="AccesoEtiqueta" Text="Confirmar Contrase�a:" ></asp:Label></b>
		                                                    </td>
                                                            <td align="left">
                                                                <asp:TextBox ID="txtConfirmaContrasenia" Runat="server" CssClass="AccesoControl" Width="150" MaxLength="30" TextMode="Password"></asp:TextBox>			
		                                                    </td>
		                                                </tr>
		                                                <tr>
		                                                    <td></td>
		                                                    <td align="left">
		                                                        <asp:RequiredFieldValidator style="font-family:Arial; font-size:12px; font-weight:bold" ID="reqConfCont" Runat="server" ControlToValidate="txtConfirmaContrasenia" ErrorMessage="Confirme su nueva contrase�a..."></asp:RequiredFieldValidator>
		                                                    </td>
		                                                </tr>
		                                                <tr>
		                                                    <td></td>
		                                                    <td align="left">
		                                                        <asp:CompareValidator style="font-family:Arial; font-size:12px; font-weight:bold" ID="CompareValidator1" runat="server" ControlToCompare="txtNuevaContrasenia" ControlToValidate="txtConfirmaContrasenia" CssClass="ValidacionGlobal" ErrorMessage="La contrase�a no coincide, verifique por favor..." Display="Dynamic"></asp:CompareValidator>
		                                                    </td>
		                                                </tr>
			                                            <tr>
			                                                <td colspan="2" align="center">
			                                                    <table border="0" cellpadding="0" cellspacing="0">
			                                                        <tr>
			                                                            <td align="center">
			                                                                <asp:Panel ID="panelBotonAceptar" runat="server">
			                                                                    <asp:ImageButton ID="btnAceptar" ImageUrl="~/Imagenes/btn_aceptar.gif" runat="server"  CssClass="Boton" />
			                                                                </asp:Panel> 
			                                                            </td>
			                                                            <td>
			                                                                <asp:Panel ID="panelBotonCerrar" runat="server" Visible="false">
			                                                                    <asp:Image ID="btnCerrar" runat="server" ImageUrl="~/Imagenes/btn_aceptar.gif"  onClick="javascript:cierraVentana('');"/>
			                                                                </asp:Panel>  
			                                                            </td>
			                                                        </tr>
			                                                    </table>
			                                                </td>
			                                            </tr>
                                                    </table>
                                                </asp:Panel>  
                                            </td>
                                        </tr>                                                
                                    
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </td>
            </tr>
        </table>
   		<asp:ValidationSummary ID="msgMensaje" Runat="server" ShowMessageBox="True" ShowSummary="False"></asp:ValidationSummary>
		<asp:PlaceHolder ID="phMensaje" Runat="server"></asp:PlaceHolder>
    </form>
</body>
</html>
