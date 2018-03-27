<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Utilerias.aspx.vb" Inherits="Framework_Utilerias" %>
<%@ Register Assembly="ComponentArt.Web.UI" Namespace="ComponentArt.Web.UI" TagPrefix="ComponentArt" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" lang="EN">
  <head>
    <title>..:: <%=vEmpresa%> ::..</title>
      <link href="../Estilos/Principal.css" rel="stylesheet" type="text/css" />
      <script language="javascript" src="../funcionesJS/Principal.js" type ="text/javascript" ></script> 
      <script language="javascript" type="text/javascript" ></script>
  </head>
    <body class="PaginaBlanca">  
        <form id="Form1" method="post" runat="server">
        <table>
            <tr style="height:50px">
                <td>&nbsp;</td>
            </tr>
        </table>
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <asp:WebPartManager ID="WebPartManager1" runat="server" ></asp:WebPartManager>
        </form>
  </body>
</html>