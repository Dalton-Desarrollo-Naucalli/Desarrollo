<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Acceso.aspx.vb" Inherits="Framework_Acceso" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>
<%@ Register Assembly="ComponentArt.Web.UI" Namespace="ComponentArt.Web.UI" TagPrefix="ComponentArt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>..:: <%=vEmpresa%> ::..</title>
    <link rel="shortcut icon" type="image/x-icon" href="../imagenes/Logotipos/favicon.ico" />
<script type ="text/javascript"  src ="../funcionesJS/Principal.js"></script>
<link href="../Estilos/Principal.css" type="text/css" rel="stylesheet" />
<script language="javascript" type="text/javascript" >
    function HazCallbacks(sIdCultura)
      {
       cbkServicio.Callback(sIdCultura);
       cbkUsuario.Callback(sIdCultura);
       cbkClave.Callback(sIdCultura);
       cbkAccesar.Callback(sIdCultura);
      }
</script>
</head>
<body style="margin-left:0; margin-top:0; background-color:White">
    <form id="form1" runat="server">
        <table cellspacing="0" cellpadding="0" width="100%" border="0" id="plantilla" runat="server" style="height:100%">
            <tr>
                <td style="height:100px"></td>
            </tr>
            <tr>
                <td align="center" valign="middle">
	                <table border="0" cellpadding="0" cellspacing="0" width="800">
	                    <tr>
	                        <td style="background-color:#CC0013; height:10px" colspan="2"></td>
                        </tr>
	                    <tr>
	                        <td align="left" valign="top">
	                            <table border="0" cellpadding="0" cellspacing="0" width="93%">
	                                <tr>
	                                    <td align="left">
	                                        <img alt="" src="../Imagenes/login1.gif" height="302" width="355"/>
	                                    </td>
	                                    <td style="width:40px"></td>
	                                    <td align="right" valign="middle">
	                                        <img alt="" src="../Imagenes/Logotipos/logo_reportes_chico.jpg"/>	                            
	                                    </td>
	                                </tr>
	                            </table>
                            </td>
	                        <td align="center" style="background-image:url(../Imagenes/fondo-login.jpg)">	
			                    <table>
			                        <tr>
			                            <td colspan="2">&nbsp;</td>
			                        </tr>	
			                        <tr>
			                            <td colspan="2" align="center">
			                                <b><asp:Label CssClass="AccesoEtiqueta" ID="lblIngreseSusDatos" Text="POR FAVOR INGRESE SUS DATOS" runat="server"></asp:Label></b>
			                            </td>
			                        </tr>	
			                        <tr>
			                            <td colspan="2">&nbsp;</td>
			                        </tr>
                                    <tr><td style="height:5px"></td></tr>
			                        <tr>
                                        <td align="right">
                                            <b><asp:Label ID="lblUsuario" Runat="server" CssClass="AccesoEtiqueta" Text="Usuario:" ></asp:Label></b>
			                            </td>
                                        <td align="left">
                                            <asp:TextBox ID="txtUsuario" Runat="server" CssClass="AccesoControl" Width="150" MaxLength="30"></asp:TextBox>			
			                            </td>
			                        </tr>
			                        <tr>
			                            <td></td>
			                            <td>
			                                <asp:RequiredFieldValidator style="font-family:Arial; font-size:12px; font-weight:bold" ID="reqUsuario" Runat="server" ControlToValidate="txtUsuario" ErrorMessage="El ID del Usuario es requerido..."></asp:RequiredFieldValidator>
			                            </td>
			                        </tr>
			                        <tr><td style="height:5px"></td></tr>
			                        <tr>
                                        <td align="right">
                                            <b><asp:Label ID="lblClave" Runat="server" CssClass="AccesoEtiqueta" Text="Password:"></asp:Label></b>
                                        </td>
                                        <td align="left">
			                                <asp:TextBox ID="txtClave" Runat="server" CssClass="AccesoControl" Width="150"  MaxLength="30" TextMode="Password"></asp:TextBox>
			                            </td>
			                        </tr>
			                        <tr>
			                            <td></td>
			                            <td>
			                                <asp:RequiredFieldValidator style="font-family:Arial; font-size:12px; font-weight:bold" ID="reqClave" Runat="server" ControlToValidate="txtClave" ErrorMessage="Anote del password del Usuario..."></asp:RequiredFieldValidator>
			                            </td>
			                        </tr>	
			                        <tr>
			                            <td colspan="2">&nbsp;</td>
			                        </tr>
			                        <tr>
			                            <td colspan="2" align="center">
                                            <asp:ImageButton ID="btnAccesar"  ImageUrl="~/Imagenes/btn_aceptar.gif" runat="server"  CssClass="Boton" />
			                            </td>
			                        </tr>
			                    </table>
	                        </td>
                        </tr>
	                    <tr>
	                        <td style="background-color:#CC0013; height:10px" colspan="2"></td>
                        </tr>                        
	                </table>
                </td>
            </tr>
        </table>
		<asp:ValidationSummary ID="msgMensaje" Runat="server" ShowMessageBox="True" ShowSummary="False"></asp:ValidationSummary>
		<asp:PlaceHolder ID="phMensaje" Runat="server"></asp:PlaceHolder>
    </form>
</body>
</html>
