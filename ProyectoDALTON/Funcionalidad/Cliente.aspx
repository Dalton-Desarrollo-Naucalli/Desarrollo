<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Cliente.aspx.vb" Inherits="Funcionalidad_Clientes" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="ComponentArt.Web.UI" Namespace="ComponentArt.Web.UI" TagPrefix="ComponentArt" %>
<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server" >
      <script src="../funcionesJS/BusquedaGral.js"></script>
    <title>..:: <%=vSistema%> (<%=vEmpresa%>) ::..</title>
    <link href="../Estilos/Principal.css" type="text/css" rel="stylesheet" />  
    <link rel="stylesheet" type="text/css" href="../Estilos/styleNavBar.css" />
    <script type="text/javascript" language ="javascript" src ="../funcionesJS/Principal.js"></script>
    <script type="text/javascript" language ="javascript" >
    var isDirty = '';
    var contextMenuX = 0; 
    var contextMenuY = 0; 
    var contextItem = ""; 
         
    </script>
    
      <style type="text/css">
          .auto-style1 {
              width: 250px;
          }
      </style>
    
  </head>
<body>
 <form id="form1" runat="server">
     <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
     <table style="text-align:center; " border="0" class="auto-style1">
         <tr>
             <td>
                 <asp:Label ID="lblAccesos" runat="server" Text="" CssClass="GlobalTextoPanel"></asp:Label>
             </td>
             <td>
                 <asp:Panel runat="server" ID="PanelAgregar" Visible="false" Width="150px" Height="100px">
                <dx:ASPxButton ID="btnAgregar" runat="server" ToolTip="Agregar" ClientInstanceName="btnAgregar" AutoPostBack="False" EnableClientSideAPI="false" ClientEnabled="True" GroupName="A">
                                        <ClientSideEvents Click="function(s, e) {
LimpiaControles();
cbAgregar.PerformCallback();
                                     }" CheckedChanged="Valida_btnAgregar"  />
                                        <Image IconID="actions_add_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                </asp:Panel>   
             </td>
             <td>
                  <asp:Panel runat="server" ID="PanelEditar" Visible="false" Width="150px" Height="100px">
                  <dx:ASPxButton ID="btnEditar" runat="server" ToolTip="Editar" ClientInstanceName="btnEditar" AutoPostBack="False" EnableClientSideAPI="false" ClientEnabled="True" GroupName="B">
                                        <ClientSideEvents Click="function(s, e) {
      cbEditar.PerformCallback();	
                                              }" CheckedChanged="Valida_btnEditar"/>
                                        <Image IconID="edit_edit_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                </asp:Panel>
              <td>
                  <asp:Panel runat="server" ID="Panel1" Visible="false" Width="150px" Height="100px">
                    <dx:ASPxButton ID="btnEliminar" runat="server" ToolTip="Eliminar" AutoPostBack="False" ClientInstanceName="btnEliminar" EnableClientSideAPI="True" ClientEnabled="True" GroupName="C">
                                        <ClientSideEvents Click="function(s, e) {
cbEliminar.PerformCallback();
                                        }" CheckedChanged="Valida_btnEliminar"/>
                                        <Image IconID="edit_delete_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                </asp:Panel>
               </td>
             </td>
         </tr>
     </table>
   
 	</form>
</body>
</html>
