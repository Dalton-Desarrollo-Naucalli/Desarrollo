<%@ Page Language="VB" AutoEventWireup="false" CodeFile="CambiaContrasenia.aspx.vb" Inherits="Framework_CambiaContrasenia" EnableEventValidation ="false"  %>
<%@ Register Assembly="ComponentArt.Web.UI" Namespace="ComponentArt.Web.UI" TagPrefix="ComponentArt" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="EN">
  <head>
    <title>Detalle de Garantías</title> <%--Personalizable--%>
    <link href="../Estilos/Principal.css" type="text/css" rel="stylesheet" />    
    <script type="text/javascript" src="../funcionesJS/Principal.js"  language="javascript" ></script>
    <script type="text/javascript">

    function CambiaContrasenia()
      {
       var vAncho = screen.width
       var vAlto = screen.height       
       var vX = parseFloat(parseFloat(parseFloat(vAncho) - 800) / 2)
       var vY = parseFloat(parseFloat(parseFloat(vAlto) - 360) / 2)
       mywindow = window.open ("AsignaContrasenia.aspx","mywindow","menubar=0,resizable=1,width=800,height=360");
       mywindow.moveTo(vX,vY);
      }    
         
    </script>

 <%  
     HttpContext.Current.Response.Cache.SetExpires(DateTime.Now.AddYears(-10))
     HttpContext.Current.Response.Cache.SetCacheability(HttpCacheability.NoCache)
     HttpContext.Current.Response.Cache.SetNoStore()
 %> 
 
</head>
<body onload="CambiaContrasenia();" class ="Pagina">  
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
                                                <asp:Label ID="lblTitulo" runat="server" Text="Cambio de Contraseña" CssClass="GlobalSubtitulo"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" valign="middle">
                                                <asp:Panel ID="PanelMSJFuncionalidad" runat="server">
                                                    <table border="0" cellpadding="1" cellspacing="1" width="100%">
                                                        <tr>
                                                            <td align="center">
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
    </form>
</body>
</html>
