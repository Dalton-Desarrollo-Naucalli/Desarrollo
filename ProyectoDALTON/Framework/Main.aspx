<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Main.aspx.vb" Inherits="Framework_Main" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register TagPrefix="ComponentArt" Namespace="ComponentArt.Web.UI" Assembly="ComponentArt.Web.UI" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" language="EN">
  <head runat="server" >
    <title>..:: <%=vSistema%> (<%=vEmpresa%>) ::..</title>
    <link href="../Estilos/Principal.css" type="text/css" rel="stylesheet" />    
    <script type="text/javascript" language ="javascript" src ="../funcionesJS/Principal.js"></script>
    <script type="text/javascript" language ="javascript" >
    var isDirty = '';
    var contextMenuX = 0; 
    var contextMenuY = 0; 
    var contextItem = ""; 
    
    function ExisteModif(Modif) 
    {
     if(Modif == 1)
       {
        isDirty='yes'
       }
     else
       {
        isDirty=''
      }
    }
    
    function Grid1_onItemDoubleClick(sender, eventArgs)
      {
       var item = eventArgs.get_item();
       TreeView1.selectNodeById(item.Cells[6].get_value()); 
      }

        // Handles the TreeView node select event 
        function TreeView1_onNodeSelect(sender, eventArgs) {
            //alert(eventArgs.get_node().get_value());
            if (eventArgs.get_node().get_value() == "Salir") {
                var navegador = navigator.appName
                //alert("navegador -> " + navegador);
                //alert(" Navegador Actual ->" + navigator.userAgent);
                //document.getElementById("HiddenNavegador").value = navigator.userAgent;               

                //navigator.userAgent.toLowerCase().indexOf('chrome') > -1
                //window.close(); 
                //var ventana = window.self; 
                //ventana.opener = window.self; 
                //ventana.close();                
                window.open("", "_parent", "");
                window.close();
            }
            else if (eventArgs.get_node().get_value() == "SIAN") {
                document.getElementById("ObjectFrame").data = "Inicio.aspx";
                window.open("http://integrasatelite.cloudapp.net/siantest.html", "SISTEMA SIAN", "directories=no, location=no, menubar=no, scrollbars=yes, statusbar=no, tittlebar=no, width=1600, height=800");
            }
            else if (eventArgs.get_node().get_value() == "SIIFI") {
                document.getElementById("ObjectFrame").data = "Inicio.aspx";
                window.open("http://integrasatelite.cloudapp.net/siantest.html", "SISTEMA SIAN", "directories=no, location=no, menubar=no, scrollbars=yes, statusbar=no, tittlebar=no, width=1600, height=800");
                return false;
            }
            else if (eventArgs.get_node().get_value() == "SICORP") {
                document.getElementById("ObjectFrame").data = "Inicio.aspx";
                window.open("http://integrasatelite.cloudapp.net/siantest.html", "SISTEMA SIAN", "directories=no, location=no, menubar=no, scrollbars=yes, statusbar=no, tittlebar=no, width=1600, height=800");
                return false;
            }
            else {
                GridCallBack.callback(eventArgs.get_node().get_value());
            }

        }

    function Grid1_onSortChange(sender, eventArgs)
      {
       var grid = sender;
       var isDesc = eventArgs.get_descending();
       var column = eventArgs.get_column();
      
       grid.sortMulti([5,!isDesc,column.ColumnNumber,isDesc]);

       eventArgs.set_cancel(true);
      }

    function Grid1_onContextMenu(sender, eventArgs) 
    {
      SetupContextMenuCallbackContainer(eventArgs.get_event());
      var item = eventArgs.get_item();
      Grid1.select(item);
      contextItem = item.Cells[1].get_value(); 
      MenuCallBack.callback(item.Cells[7].get_value()); 
    }
    

    function TreeView1_onContextMenu(sender, eventArgs) 
      {
       SetupContextMenuCallbackContainer(eventArgs.get_event());
       contextItem = eventArgs.get_node().get_text();
       MenuCallBack.callback('');
      }

    function SetupContextMenuCallbackContainer(evt)
      {
       evt = (evt == null) ? window.event : evt;
       contextMenuX = evt.pageX ? evt.pageX : evt.x;
       contextMenuY = evt.pageY ? evt.pageY : evt.y;
       contextMenuX += document.body.scrollLeft; 
       contextMenuY += document.body.scrollTop; 
       var menuCallBackDomElement = MenuCallBack.element;
       menuCallBackDomElement.style.position = 'absolute'; 
       menuCallBackDomElement.style.left = contextMenuX + 'px'; 
       menuCallBackDomElement.style.top = contextMenuY + 'px' ; 
      }

    function CancelContextMenu(evt)
      {
       evt = (evt == null) ? window.event : evt;
       evt.cancelBubble = true; 
       evt.returnValue = false; 
       return false; 
      }

    function Menu1_onItemSelect(sender, eventArgs)
      {
       var itemValue = eventArgs.get_item().get_value();
        if(itemValue) 
          {
           Menu1.hide();
          }
      }


    function MenuCallBack_onCallbackComplete()
      {
       Menu1.showContextMenu(contextMenuX - document.body.scrollLeft, contextMenuY - document.body.scrollTop); 
      }    
      
    function resizeTree(sender, eventArgs)
      {
       var pane = eventArgs.get_pane();
       var newPaneWidth = pane.get_width();
       var newPaneHeight = pane.get_height();
       if(window.TreeView1 && newPaneWidth && newPaneWidth > 2 && newPaneHeight && newPaneHeight > 33)
         {
          document.getElementById("TreeContainer").style.width = (newPaneWidth - 2) + 'px';
          document.getElementById("TreeContainer").style.height = (newPaneHeight - 33) + 'px';
          TreeView1.render();
         }
      }    

    function resizeGrid(sender, eventArgs)
      {        
       var pane = eventArgs.get_pane();
       var newPaneWidth = pane.get_width();
       var newPaneHeight = pane.get_height();
          if(window.Grid1 && newPaneWidth && newPaneWidth > 2 && newPaneHeight && newPaneHeight > 26)
            {
             GridCallBack.element.style.width = (newPaneWidth - 2) + 'px';
             GridCallBack.element.style.height = (newPaneHeight - 26) + 'px';
             Grid1.render();
            }
      }  
      
    function CompletaCallback()
      {
       var vDir = document.getElementById("hidDir").value;
       if(vDir != "")
         {
          window.location = vDir;
         }
      }      
      
    </script>
    
  </head>

<body class="Pagina" style="text-align:center">  
<form id="Form1" method="post" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td align="center">
                <table border="0" cellpadding="0" cellspacing="0" width="100%" style="height:800px">
                    <tr>
                        <td align="center">
                            <div class="DemoArea">
                                <ComponentArt:Splitter runat="server" id="Splitter1" Height="799" Width="100%" BorderStyle="None" >
                                    <Layouts>
                                        <ComponentArt:SplitterLayout>
                                            <Panes Orientation="Horizontal" SplitterBarActiveCssClass="ActiveSplitterBar" SplitterBarWidth="5" >
                                                <ComponentArt:SplitterPane PaneContentId="TreeViewContent" Width="20%" MinWidth="0" >
                                                    <ClientEvents>
                                                        <PaneResize EventHandler="resizeTree" />
                                                    </ClientEvents>
                                                </ComponentArt:SplitterPane>
                                                <ComponentArt:SplitterPane PaneContentId="GridContent" Width="82%" AllowScrolling="false" >
                                                    <ClientEvents>
                                                        <PaneResize EventHandler="resizeGrid" />
                                                    </ClientEvents>
                                                </ComponentArt:SplitterPane>
                                            </Panes>
                                        </ComponentArt:SplitterLayout>
                                    </Layouts>
                                    <Content>
                                        <ComponentArt:SplitterPaneContent id="TreeViewContent">
                                            <div id="TreeContainer" class="TreeGridContainer" style="border-style:none">
                                            <%--Aqui va la funcionalidad--%>

                                             <table style="text-align:center; width:250px" border="0">
                                                <tr>
                                                    <td style="text-align:center">
                                                        <table style="text-align:center; width:250px" border="0">
                                                            <tr id="RenglonModulo01" runat="server" visible="false">
                                                                <td style="text-align:center">
                                                                    <table style="text-align:center; width:250px" border="1" cellpadding="0" cellspacing="0">
                                                                        <tr>
                                                                            <td style="text-align:center">
                                                                                <asp:Panel ID="PanelColapsadoModulo01" runat="server" style="background-color:White; width:200px" CssClass="GlobalFondoPanel">                      
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="text-align:left; width:80%">
                                                                                                <asp:Label ID="lblControlesModulo01" runat="server" Text="" CssClass="GlobalTextoPanel"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width:20px"></td>
                                                                                            <td style="text-align:right">
                                                                                                <div style="float: left; vertical-align: middle;">
                                                                                                    <asp:Image ID="imgModulo01" runat="server" ImageUrl="../imagenes/expand.jpg" style="height: 13px" />
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>                                      
                                                                                </asp:Panel>                   
                                                                                <asp:Panel ID="PanelExpandidoModulo01" runat="server" style="background-color:White; width:250px">
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="width:150px">
                                                                                                <asp:Panel ID="PanelControlesModulo01" runat="server" Width="250px">
                                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                                        <tr>
                                                                                                            <td style="text-align:center">
                                                                                                                <%--Aqui van los controles (INICIO)--%>
                                                                                                                <ComponentArt:TreeView id="TreeViewModulo01" Width="250px" Autoscroll="true" FillContainer="true" HoverPopupEnabled="true" DragAndDropEnabled="false" NodeEditingEnabled="false" KeyboardEnabled="false" CssClass="TreeView" NodeCssClass="TreeNode" SelectedNodeCssClass="SelectedTreeNode" HoverNodeCssClass="HoverTreeNode"  HoverPopupNodeCssClass="HoverPopupTreeNode" LineImageWidth="19" LineImageHeight="20" DefaultImageWidth="16" DefaultImageHeight="16" ItemSpacing="0" ImagesBaseUrl="../imagenes/" NodeLabelPadding="3" ShowLines="true" LineImagesFolderUrl="../imagenes/" CollapseNodeOnSelect="false" EnableViewState="true" runat="server" >
                                                                                                                <ClientEvents><NodeSelect EventHandler="TreeView1_onNodeSelect" /><ContextMenu EventHandler="TreeView1_onContextMenu" /></ClientEvents>
                                                                                                                </ComponentArt:TreeView>  
                                                                                                                <%--Aqui van los controles (TERMINO)--%>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
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
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align:center">
                                                        <table style="text-align:center; width:250px" border="0">
                                                            <tr id="RenglonModulo02" runat="server" visible="false">
                                                                <td style="text-align:center">
                                                                    <table style="text-align:center; width:250px" border="1" cellpadding="0" cellspacing="0">
                                                                        <tr>
                                                                            <td style="text-align:center">
                                                                                <asp:Panel ID="PanelColapsadoModulo02" runat="server" style="background-color:White; width:200px" CssClass="GlobalFondoPanel">                      
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="text-align:left; width:80%">
                                                                                                <asp:Label ID="lblControlesModulo02" runat="server" Text="" CssClass="GlobalTextoPanel"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width:20px"></td>
                                                                                            <td style="text-align:right">
                                                                                                <div style="float: left; vertical-align: middle;">
                                                                                                    <asp:Image ID="imgModulo02" runat="server" ImageUrl="../imagenes/expand.jpg" style="height: 13px" />
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>                                      
                                                                                </asp:Panel>                   
                                                                                <asp:Panel ID="PanelExpandidoModulo02" runat="server" style="background-color:White; width:250px">
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="width:150px">
                                                                                                <asp:Panel ID="PanelControlesModulo02" runat="server" Width="250px">
                                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                                        <tr>
                                                                                                            <td style="text-align:center">
                                                                                                                <%--Aqui van los controles (INICIO)--%>
                                                                                                                <ComponentArt:TreeView id="TreeViewModulo02" Width="250px" Autoscroll="true" FillContainer="true" HoverPopupEnabled="true" DragAndDropEnabled="false" NodeEditingEnabled="false" KeyboardEnabled="false" CssClass="TreeView" NodeCssClass="TreeNode" SelectedNodeCssClass="SelectedTreeNode" HoverNodeCssClass="HoverTreeNode"  HoverPopupNodeCssClass="HoverPopupTreeNode" LineImageWidth="19" LineImageHeight="20" DefaultImageWidth="16" DefaultImageHeight="16" ItemSpacing="0" ImagesBaseUrl="../imagenes/" NodeLabelPadding="3" ShowLines="true" LineImagesFolderUrl="../imagenes/" CollapseNodeOnSelect="false" EnableViewState="true" runat="server" >
                                                                                                                <ClientEvents><NodeSelect EventHandler="TreeView1_onNodeSelect" /><ContextMenu EventHandler="TreeView1_onContextMenu" /></ClientEvents>
                                                                                                                </ComponentArt:TreeView>  
                                                                                                                <%--Aqui van los controles (TERMINO)--%>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
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
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align:center">
                                                        <table style="text-align:center; width:250px" border="0">
                                                            <tr id="RenglonModulo03" runat="server" visible="false">
                                                                <td style="text-align:center">
                                                                    <table style="text-align:center; width:250px" border="1" cellpadding="0" cellspacing="0">
                                                                        <tr>
                                                                            <td style="text-align:center">
                                                                                <asp:Panel ID="PanelColapsadoModulo03" runat="server" style="background-color:White; width:200px" CssClass="GlobalFondoPanel">                      
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="text-align:left; width:80%">
                                                                                                <asp:Label ID="lblControlesModulo03" runat="server" Text="" CssClass="GlobalTextoPanel"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width:20px"></td>
                                                                                            <td style="text-align:right">
                                                                                                <div style="float: left; vertical-align: middle;">
                                                                                                    <asp:Image ID="imgModulo03" runat="server" ImageUrl="../imagenes/expand.jpg" style="height: 13px" />
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>                                      
                                                                                </asp:Panel>                   
                                                                                <asp:Panel ID="PanelExpandidoModulo03" runat="server" style="background-color:White; width:250px">
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="width:150px">
                                                                                                <asp:Panel ID="PanelControlesModulo03" runat="server" Width="250px">
                                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                                        <tr>
                                                                                                            <td style="text-align:center">
                                                                                                                <%--Aqui van los controles (INICIO)--%>
                                                                                                                <ComponentArt:TreeView id="TreeViewModulo03" Width="250px" Autoscroll="true" FillContainer="true" HoverPopupEnabled="true" DragAndDropEnabled="false" NodeEditingEnabled="false" KeyboardEnabled="false" CssClass="TreeView" NodeCssClass="TreeNode" SelectedNodeCssClass="SelectedTreeNode" HoverNodeCssClass="HoverTreeNode"  HoverPopupNodeCssClass="HoverPopupTreeNode" LineImageWidth="19" LineImageHeight="20" DefaultImageWidth="16" DefaultImageHeight="16" ItemSpacing="0" ImagesBaseUrl="../imagenes/" NodeLabelPadding="3" ShowLines="true" LineImagesFolderUrl="../imagenes/" CollapseNodeOnSelect="false" EnableViewState="true" runat="server" >
                                                                                                                <ClientEvents><NodeSelect EventHandler="TreeView1_onNodeSelect" /><ContextMenu EventHandler="TreeView1_onContextMenu" /></ClientEvents>
                                                                                                                </ComponentArt:TreeView>  
                                                                                                                <%--Aqui van los controles (TERMINO)--%>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
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
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align:center">
                                                        <table style="text-align:center; width:250px" border="0">
                                                            <tr id="RenglonModulo04" runat="server" visible="false">
                                                                <td style="text-align:center">
                                                                    <table style="text-align:center; width:250px" border="1">
                                                                        <tr>
                                                                            <td style="text-align:center">
                                                                                <asp:Panel ID="PanelColapsadoModulo04" runat="server" style="background-color:White; width:200px" CssClass="GlobalFondoPanel">                      
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="text-align:left">
                                                                                                <asp:Label ID="lblControlesModulo04" runat="server" Text="" CssClass="GlobalTextoPanel"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width:20px"></td>
                                                                                            <td style="text-align:right">
                                                                                                <div style="float: left; vertical-align: middle;">
                                                                                                    <asp:Image ID="imgModulo04" runat="server" ImageUrl="../imagenes/expand.jpg" style="height: 13px" />
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>                                      
                                                                                </asp:Panel>                   
                                                                                <asp:Panel ID="PanelExpandidoModulo04" runat="server" style="background-color:White; width:250px">
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="width:150px">
                                                                                                <asp:Panel ID="PanelControlesModulo04" runat="server" Width="250px">
                                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                                        <tr>
                                                                                                            <td style="text-align:center">
                                                                                                                <%--Aqui van los controles (INICIO)--%>
                                                                                                                <ComponentArt:TreeView id="TreeViewModulo04" Width="250px" Autoscroll="true" FillContainer="true" HoverPopupEnabled="true" DragAndDropEnabled="false" NodeEditingEnabled="false" KeyboardEnabled="false" CssClass="TreeView" NodeCssClass="TreeNode" SelectedNodeCssClass="SelectedTreeNode" HoverNodeCssClass="HoverTreeNode"  HoverPopupNodeCssClass="HoverPopupTreeNode" LineImageWidth="19" LineImageHeight="20" DefaultImageWidth="16" DefaultImageHeight="16" ItemSpacing="0" ImagesBaseUrl="../imagenes/" NodeLabelPadding="3" ShowLines="true" LineImagesFolderUrl="../imagenes/" CollapseNodeOnSelect="false" EnableViewState="true" runat="server" >
                                                                                                                <ClientEvents><NodeSelect EventHandler="TreeView1_onNodeSelect" /><ContextMenu EventHandler="TreeView1_onContextMenu" /></ClientEvents>
                                                                                                                </ComponentArt:TreeView>  
                                                                                                                <%--Aqui van los controles (TERMINO)--%>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
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
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align:center">
                                                        <table style="text-align:center; width:250px" border="0">
                                                            <tr id="RenglonModulo05" runat="server" visible="false">
                                                                <td style="text-align:center">
                                                                    <table style="text-align:center; width:250px" border="1">
                                                                        <tr>
                                                                            <td style="text-align:center">
                                                                                <asp:Panel ID="PanelColapsadoModulo05" runat="server" style="background-color:White; width:200px" CssClass="GlobalFondoPanel">                      
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="text-align:left">
                                                                                                <asp:Label ID="lblControlesModulo05" runat="server" Text="" CssClass="GlobalTextoPanel"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width:20px"></td>
                                                                                            <td style="text-align:right">
                                                                                                <div style="float: left; vertical-align: middle;">
                                                                                                    <asp:Image ID="imgModulo05" runat="server" ImageUrl="../imagenes/expand.jpg" style="height: 13px" />
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>                                      
                                                                                </asp:Panel>                   
                                                                                <asp:Panel ID="PanelExpandidoModulo05" runat="server" style="background-color:White; width:250px">
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="width:150px">
                                                                                                <asp:Panel ID="PanelControlesModulo05" runat="server" Width="250px">
                                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                                        <tr>
                                                                                                            <td style="text-align:center">
                                                                                                                <%--Aqui van los controles (INICIO)--%>
                                                                                                                <ComponentArt:TreeView id="TreeViewModulo05" Width="250px" Autoscroll="true" FillContainer="true" HoverPopupEnabled="true" DragAndDropEnabled="false" NodeEditingEnabled="false" KeyboardEnabled="false" CssClass="TreeView" NodeCssClass="TreeNode" SelectedNodeCssClass="SelectedTreeNode" HoverNodeCssClass="HoverTreeNode"  HoverPopupNodeCssClass="HoverPopupTreeNode" LineImageWidth="19" LineImageHeight="20" DefaultImageWidth="16" DefaultImageHeight="16" ItemSpacing="0" ImagesBaseUrl="../imagenes/" NodeLabelPadding="3" ShowLines="true" LineImagesFolderUrl="../imagenes/" CollapseNodeOnSelect="false" EnableViewState="true" runat="server" >
                                                                                                                <ClientEvents><NodeSelect EventHandler="TreeView1_onNodeSelect" /><ContextMenu EventHandler="TreeView1_onContextMenu" /></ClientEvents>
                                                                                                                </ComponentArt:TreeView>  
                                                                                                                <%--Aqui van los controles (TERMINO)--%>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
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
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align:center">
                                                        <table style="text-align:center; width:250px" border="0">
                                                            <tr id="RenglonModulo06" runat="server" visible="false">
                                                                <td style="text-align:center">
                                                                    <table style="text-align:center; width:250px" border="1">
                                                                        <tr>
                                                                            <td style="text-align:center">
                                                                                <asp:Panel ID="PanelColapsadoModulo06" runat="server" style="background-color:White; width:200px" CssClass="GlobalFondoPanel">                      
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="text-align:left">
                                                                                                <asp:Label ID="lblControlesModulo06" runat="server" Text="" CssClass="GlobalTextoPanel"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width:20px"></td>
                                                                                            <td style="text-align:right">
                                                                                                <div style="float: left; vertical-align: middle;">
                                                                                                    <asp:Image ID="imgModulo06" runat="server" ImageUrl="../imagenes/expand.jpg" style="height: 13px" />
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>                                      
                                                                                </asp:Panel>                   
                                                                                <asp:Panel ID="PanelExpandidoModulo06" runat="server" style="background-color:White; width:250px">
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="width:150px">
                                                                                                <asp:Panel ID="PanelControlesModulo06" runat="server" Width="250px">
                                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                                        <tr>
                                                                                                            <td style="text-align:center">
                                                                                                                <%--Aqui van los controles (INICIO)--%>
                                                                                                                <ComponentArt:TreeView id="TreeViewModulo06" Width="250px" Autoscroll="true" FillContainer="true" HoverPopupEnabled="true" DragAndDropEnabled="false" NodeEditingEnabled="false" KeyboardEnabled="false" CssClass="TreeView" NodeCssClass="TreeNode" SelectedNodeCssClass="SelectedTreeNode" HoverNodeCssClass="HoverTreeNode"  HoverPopupNodeCssClass="HoverPopupTreeNode" LineImageWidth="19" LineImageHeight="20" DefaultImageWidth="16" DefaultImageHeight="16" ItemSpacing="0" ImagesBaseUrl="../imagenes/" NodeLabelPadding="3" ShowLines="true" LineImagesFolderUrl="../imagenes/" CollapseNodeOnSelect="false" EnableViewState="true" runat="server" >
                                                                                                                <ClientEvents><NodeSelect EventHandler="TreeView1_onNodeSelect" /><ContextMenu EventHandler="TreeView1_onContextMenu" /></ClientEvents>
                                                                                                                </ComponentArt:TreeView>  
                                                                                                                <%--Aqui van los controles (TERMINO)--%>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
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
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align:center">
                                                        <table style="text-align:center; width:250px" border="0">
                                                            <tr id="RenglonModulo07" runat="server" visible="false">
                                                                <td style="text-align:center">
                                                                    <table style="text-align:center; width:250px" border="1">
                                                                        <tr>
                                                                            <td style="text-align:center">
                                                                                <asp:Panel ID="PanelColapsadoModulo07" runat="server" style="background-color:White; width:200px" CssClass="GlobalFondoPanel">                      
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="text-align:left">
                                                                                                <asp:Label ID="lblControlesModulo07" runat="server" Text="" CssClass="GlobalTextoPanel"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width:20px"></td>
                                                                                            <td style="text-align:right">
                                                                                                <div style="float: left; vertical-align: middle;">
                                                                                                    <asp:Image ID="imgModulo07" runat="server" ImageUrl="../imagenes/expand.jpg" style="height: 13px" />
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>                                      
                                                                                </asp:Panel>                   
                                                                                <asp:Panel ID="PanelExpandidoModulo07" runat="server" style="background-color:White; width:250px">
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="width:150px">
                                                                                                <asp:Panel ID="PanelControlesModulo07" runat="server" Width="250px">
                                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                                        <tr>
                                                                                                            <td style="text-align:center">
                                                                                                                <%--Aqui van los controles (INICIO)--%>
                                                                                                                <ComponentArt:TreeView id="TreeViewModulo07" Width="250px" Autoscroll="true" FillContainer="true" HoverPopupEnabled="true" DragAndDropEnabled="false" NodeEditingEnabled="false" KeyboardEnabled="false" CssClass="TreeView" NodeCssClass="TreeNode" SelectedNodeCssClass="SelectedTreeNode" HoverNodeCssClass="HoverTreeNode"  HoverPopupNodeCssClass="HoverPopupTreeNode" LineImageWidth="19" LineImageHeight="20" DefaultImageWidth="16" DefaultImageHeight="16" ItemSpacing="0" ImagesBaseUrl="../imagenes/" NodeLabelPadding="3" ShowLines="true" LineImagesFolderUrl="../imagenes/" CollapseNodeOnSelect="false" EnableViewState="true" runat="server" >
                                                                                                                <ClientEvents><NodeSelect EventHandler="TreeView1_onNodeSelect" /><ContextMenu EventHandler="TreeView1_onContextMenu" /></ClientEvents>
                                                                                                                </ComponentArt:TreeView>  
                                                                                                                <%--Aqui van los controles (TERMINO)--%>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
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
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align:center">
                                                        <table style="text-align:center; width:250px" border="0">
                                                            <tr id="RenglonModulo08" runat="server" visible="false">
                                                                <td style="text-align:center">
                                                                    <table style="text-align:center; width:250px" border="1">
                                                                        <tr>
                                                                            <td style="text-align:center">
                                                                                <asp:Panel ID="PanelColapsadoModulo08" runat="server" style="background-color:White; width:200px" CssClass="GlobalFondoPanel">                      
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="text-align:left">
                                                                                                <asp:Label ID="lblControlesModulo08" runat="server" Text="" CssClass="GlobalTextoPanel"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width:20px"></td>
                                                                                            <td style="text-align:right">
                                                                                                <div style="float: left; vertical-align: middle;">
                                                                                                    <asp:Image ID="imgModulo08" runat="server" ImageUrl="../imagenes/expand.jpg" style="height: 13px" />
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>                                      
                                                                                </asp:Panel>                   
                                                                                <asp:Panel ID="PanelExpandidoModulo08" runat="server" style="background-color:White; width:250px">
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="width:150px">
                                                                                                <asp:Panel ID="PanelControlesModulo08" runat="server" Width="250px">
                                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                                        <tr>
                                                                                                            <td style="text-align:center">
                                                                                                                <%--Aqui van los controles (INICIO)--%>
                                                                                                                <ComponentArt:TreeView id="TreeViewModulo08" Width="250px" Autoscroll="true" FillContainer="true" HoverPopupEnabled="true" DragAndDropEnabled="false" NodeEditingEnabled="false" KeyboardEnabled="false" CssClass="TreeView" NodeCssClass="TreeNode" SelectedNodeCssClass="SelectedTreeNode" HoverNodeCssClass="HoverTreeNode"  HoverPopupNodeCssClass="HoverPopupTreeNode" LineImageWidth="19" LineImageHeight="20" DefaultImageWidth="16" DefaultImageHeight="16" ItemSpacing="0" ImagesBaseUrl="../imagenes/" NodeLabelPadding="3" ShowLines="true" LineImagesFolderUrl="../imagenes/" CollapseNodeOnSelect="false" EnableViewState="true" runat="server" >
                                                                                                                <ClientEvents><NodeSelect EventHandler="TreeView1_onNodeSelect" /><ContextMenu EventHandler="TreeView1_onContextMenu" /></ClientEvents>
                                                                                                                </ComponentArt:TreeView>  
                                                                                                                <%--Aqui van los controles (TERMINO)--%>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
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
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align:center">
                                                        <table style="text-align:center; width:250px" border="0">
                                                            <tr id="RenglonModulo09" runat="server" visible="false">
                                                                <td style="text-align:center">
                                                                    <table style="text-align:center; width:250px" border="1">
                                                                        <tr>
                                                                            <td style="text-align:center">
                                                                                <asp:Panel ID="PanelColapsadoModulo09" runat="server" style="background-color:White; width:200px" CssClass="GlobalFondoPanel">                      
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="text-align:left">
                                                                                                <asp:Label ID="lblControlesModulo09" runat="server" Text="" CssClass="GlobalTextoPanel"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width:20px"></td>
                                                                                            <td style="text-align:right">
                                                                                                <div style="float: left; vertical-align: middle;">
                                                                                                    <asp:Image ID="imgModulo09" runat="server" ImageUrl="../imagenes/expand.jpg" style="height: 13px" />
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>                                      
                                                                                </asp:Panel>                   
                                                                                <asp:Panel ID="PanelExpandidoModulo09" runat="server" style="background-color:White; width:250px">
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="width:150px">
                                                                                                <asp:Panel ID="PanelControlesModulo09" runat="server" Width="250px">
                                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                                        <tr>
                                                                                                            <td style="text-align:center">
                                                                                                                <%--Aqui van los controles (INICIO)--%>
                                                                                                                <ComponentArt:TreeView id="TreeViewModulo09" Width="250px" Autoscroll="true" FillContainer="true" HoverPopupEnabled="true" DragAndDropEnabled="false" NodeEditingEnabled="false" KeyboardEnabled="false" CssClass="TreeView" NodeCssClass="TreeNode" SelectedNodeCssClass="SelectedTreeNode" HoverNodeCssClass="HoverTreeNode"  HoverPopupNodeCssClass="HoverPopupTreeNode" LineImageWidth="19" LineImageHeight="20" DefaultImageWidth="16" DefaultImageHeight="16" ItemSpacing="0" ImagesBaseUrl="../imagenes/" NodeLabelPadding="3" ShowLines="true" LineImagesFolderUrl="../imagenes/" CollapseNodeOnSelect="false" EnableViewState="true" runat="server" >
                                                                                                                <ClientEvents><NodeSelect EventHandler="TreeView1_onNodeSelect" /><ContextMenu EventHandler="TreeView1_onContextMenu" /></ClientEvents>
                                                                                                                </ComponentArt:TreeView>  
                                                                                                                <%--Aqui van los controles (TERMINO)--%>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
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
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align:center">
                                                        <table style="text-align:center; width:250px" border="0">
                                                            <tr id="RenglonModulo10" runat="server" visible="false">
                                                                <td style="text-align:center">
                                                                    <table style="text-align:center; width:250px" border="1">
                                                                        <tr>
                                                                            <td style="text-align:center">
                                                                                <asp:Panel ID="PanelColapsadoModulo10" runat="server" style="background-color:White; width:200px" CssClass="GlobalFondoPanel">                      
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="text-align:left">
                                                                                                <asp:Label ID="lblControlesModulo10" runat="server" Text="" CssClass="GlobalTextoPanel"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width:20px"></td>
                                                                                            <td style="text-align:right">
                                                                                                <div style="float: left; vertical-align: middle;">
                                                                                                    <asp:Image ID="imgModulo10" runat="server" ImageUrl="../imagenes/expand.jpg" style="height: 13px" />
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>                                      
                                                                                </asp:Panel>                   
                                                                                <asp:Panel ID="PanelExpandidoModulo10" runat="server" style="background-color:White; width:250px">
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="width:150px">
                                                                                                <asp:Panel ID="PanelControlesModulo10" runat="server" Width="250px">
                                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                                        <tr>
                                                                                                            <td style="text-align:center">
                                                                                                                <%--Aqui van los controles (INICIO)--%>
                                                                                                                <ComponentArt:TreeView id="TreeViewModulo10" Width="250px" Autoscroll="true" FillContainer="true" HoverPopupEnabled="true" DragAndDropEnabled="false" NodeEditingEnabled="false" KeyboardEnabled="false" CssClass="TreeView" NodeCssClass="TreeNode" SelectedNodeCssClass="SelectedTreeNode" HoverNodeCssClass="HoverTreeNode"  HoverPopupNodeCssClass="HoverPopupTreeNode" LineImageWidth="19" LineImageHeight="20" DefaultImageWidth="16" DefaultImageHeight="16" ItemSpacing="0" ImagesBaseUrl="../imagenes/" NodeLabelPadding="3" ShowLines="true" LineImagesFolderUrl="../imagenes/" CollapseNodeOnSelect="false" EnableViewState="true" runat="server" >
                                                                                                                <ClientEvents><NodeSelect EventHandler="TreeView1_onNodeSelect" /><ContextMenu EventHandler="TreeView1_onContextMenu" /></ClientEvents>
                                                                                                                </ComponentArt:TreeView>  
                                                                                                                <%--Aqui van los controles (TERMINO)--%>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
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
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align:center">
                                                        <table style="text-align:center; width:250px" border="0">
                                                            <tr id="RenglonModulo11" runat="server" visible="false">
                                                                <td style="text-align:center">
                                                                    <table style="text-align:center; width:250px" border="1">
                                                                        <tr>
                                                                            <td style="text-align:center">
                                                                                <asp:Panel ID="PanelColapsadoModulo11" runat="server" style="background-color:White; width:200px" CssClass="GlobalFondoPanel">                      
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="text-align:left">
                                                                                                <asp:Label ID="lblControlesModulo11" runat="server" Text="" CssClass="GlobalTextoPanel"></asp:Label>
                                                                                            </td>
                                                                                            <td style="width:20px"></td>
                                                                                            <td style="text-align:right">
                                                                                                <div style="float: left; vertical-align: middle;">
                                                                                                    <asp:Image ID="imgModulo11" runat="server" ImageUrl="../imagenes/expand.jpg" style="height: 13px" />
                                                                                                </div>
                                                                                            </td>
                                                                                        </tr>
                                                                                    </table>                                      
                                                                                </asp:Panel>                   
                                                                                <asp:Panel ID="PanelExpandidoModulo11" runat="server" style="background-color:White; width:250px">
                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                        <tr>
                                                                                            <td style="width:150px">
                                                                                                <asp:Panel ID="PanelControlesModulo11" runat="server" Width="250px">
                                                                                                    <table style="text-align:center; width:250px" border="0">
                                                                                                        <tr>
                                                                                                            <td style="text-align:center">
                                                                                                                <%--Aqui van los controles (INICIO)--%>
                                                                                                                <ComponentArt:TreeView id="TreeViewModulo11" Width="250px" Autoscroll="true" FillContainer="true" HoverPopupEnabled="true" DragAndDropEnabled="false" NodeEditingEnabled="false" KeyboardEnabled="false" CssClass="TreeView" NodeCssClass="TreeNode" SelectedNodeCssClass="SelectedTreeNode" HoverNodeCssClass="HoverTreeNode"  HoverPopupNodeCssClass="HoverPopupTreeNode" LineImageWidth="19" LineImageHeight="20" DefaultImageWidth="16" DefaultImageHeight="16" ItemSpacing="0" ImagesBaseUrl="../imagenes/" NodeLabelPadding="3" ShowLines="true" LineImagesFolderUrl="../imagenes/" CollapseNodeOnSelect="false" EnableViewState="true" runat="server" >
                                                                                                                <ClientEvents><NodeSelect EventHandler="TreeView1_onNodeSelect" /><ContextMenu EventHandler="TreeView1_onContextMenu" /></ClientEvents>
                                                                                                                </ComponentArt:TreeView>  
                                                                                                                <%--Aqui van los controles (TERMINO)--%>
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </asp:Panel>
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
                                                    </td>
                                                </tr>
                                             </table>

                                            <%--Aqui va la funcionalidad--%>
                                            </div>
                                        </ComponentArt:SplitterPaneContent>
                                        <ComponentArt:SplitterPaneContent id="GridContent" > 
                                            <ComponentArt:CallBack id="GridCallBack" CssClass="TreeGridContainer" runat="server" >
                                                <Content>
                                                    <asp:PlaceHolder ID="PHContenido" runat="server">
                                                        <%--<iframe id="iContenido" src="<%= iPagina %>" width="99%" height="799" scrolling="no" frameborder="0"></iframe>--%>
                                                        <object id="ObjectFrame" type="text/html" data="<%= iPagina %>" width="99%" height="799"></object>
                                                        <asp:HiddenField ID="hidDir" runat="server"/>
                                                    </asp:PlaceHolder>
                                                </Content>
                                                <ClientEvents>
                                                    <CallbackComplete EventHandler="CompletaCallback"/>
                                                </ClientEvents>                                    
                                            </ComponentArt:CallBack> 
                                        </ComponentArt:SplitterPaneContent>
                                    </Content>          
                                </ComponentArt:Splitter>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td align="left">
                            <div style="font-family: MS Sans Serif; font-size: 10px; height: 13px; cursor:default;">
                              Usuario Actual: <%= tmpUsuario %>
                            </div>
                        </td>
                    </tr>                    
                </table>     
            </td>
        </tr>
    </table>


    <cc1:CollapsiblePanelExtender ID="ColapseModulo01" runat="server" TargetControlID="PanelExpandidoModulo01" ExpandControlID="PanelColapsadoModulo01" CollapseControlID="PanelColapsadoModulo01" Collapsed="true" TextLabelID="lblControlesModulo01" ImageControlID="imgModulo01" ExpandedImage="../imagenes/collapse.jpg" CollapsedImage="../imagenes/expand.jpg" SuppressPostBack="true"></cc1:CollapsiblePanelExtender>
    <cc1:CollapsiblePanelExtender ID="ColapseModulo02" runat="server" TargetControlID="PanelExpandidoModulo02" ExpandControlID="PanelColapsadoModulo02" CollapseControlID="PanelColapsadoModulo02" Collapsed="true" TextLabelID="lblControlesModulo02" ImageControlID="imgModulo02" ExpandedImage="../imagenes/collapse.jpg" CollapsedImage="../imagenes/expand.jpg" SuppressPostBack="true"></cc1:CollapsiblePanelExtender>
    <cc1:CollapsiblePanelExtender ID="ColapseModulo03" runat="server" TargetControlID="PanelExpandidoModulo03" ExpandControlID="PanelColapsadoModulo03" CollapseControlID="PanelColapsadoModulo03" Collapsed="true" TextLabelID="lblControlesModulo03" ImageControlID="imgModulo03" ExpandedImage="../imagenes/collapse.jpg" CollapsedImage="../imagenes/expand.jpg" SuppressPostBack="true"></cc1:CollapsiblePanelExtender>
    <cc1:CollapsiblePanelExtender ID="ColapseModulo04" runat="server" TargetControlID="PanelExpandidoModulo04" ExpandControlID="PanelColapsadoModulo04" CollapseControlID="PanelColapsadoModulo04" Collapsed="true" TextLabelID="lblControlesModulo04" ImageControlID="imgModulo04" ExpandedImage="../imagenes/collapse.jpg" CollapsedImage="../imagenes/expand.jpg" SuppressPostBack="true"></cc1:CollapsiblePanelExtender>
    <cc1:CollapsiblePanelExtender ID="ColapseModulo05" runat="server" TargetControlID="PanelExpandidoModulo05" ExpandControlID="PanelColapsadoModulo05" CollapseControlID="PanelColapsadoModulo05" Collapsed="true" TextLabelID="lblControlesModulo05" ImageControlID="imgModulo05" ExpandedImage="../imagenes/collapse.jpg" CollapsedImage="../imagenes/expand.jpg" SuppressPostBack="true"></cc1:CollapsiblePanelExtender>
    <cc1:CollapsiblePanelExtender ID="ColapseModulo06" runat="server" TargetControlID="PanelExpandidoModulo06" ExpandControlID="PanelColapsadoModulo06" CollapseControlID="PanelColapsadoModulo06" Collapsed="true" TextLabelID="lblControlesModulo06" ImageControlID="imgModulo06" ExpandedImage="../imagenes/collapse.jpg" CollapsedImage="../imagenes/expand.jpg" SuppressPostBack="true"></cc1:CollapsiblePanelExtender>
    <cc1:CollapsiblePanelExtender ID="ColapseModulo07" runat="server" TargetControlID="PanelExpandidoModulo07" ExpandControlID="PanelColapsadoModulo07" CollapseControlID="PanelColapsadoModulo07" Collapsed="true" TextLabelID="lblControlesModulo07" ImageControlID="imgModulo07" ExpandedImage="../imagenes/collapse.jpg" CollapsedImage="../imagenes/expand.jpg" SuppressPostBack="true"></cc1:CollapsiblePanelExtender>
    <cc1:CollapsiblePanelExtender ID="ColapseModulo08" runat="server" TargetControlID="PanelExpandidoModulo08" ExpandControlID="PanelColapsadoModulo08" CollapseControlID="PanelColapsadoModulo08" Collapsed="true" TextLabelID="lblControlesModulo08" ImageControlID="imgModulo08" ExpandedImage="../imagenes/collapse.jpg" CollapsedImage="../imagenes/expand.jpg" SuppressPostBack="true"></cc1:CollapsiblePanelExtender>
    <cc1:CollapsiblePanelExtender ID="ColapseModulo09" runat="server" TargetControlID="PanelExpandidoModulo09" ExpandControlID="PanelColapsadoModulo09" CollapseControlID="PanelColapsadoModulo09" Collapsed="true" TextLabelID="lblControlesModulo09" ImageControlID="imgModulo09" ExpandedImage="../imagenes/collapse.jpg" CollapsedImage="../imagenes/expand.jpg" SuppressPostBack="true"></cc1:CollapsiblePanelExtender>
    <cc1:CollapsiblePanelExtender ID="ColapseModulo10" runat="server" TargetControlID="PanelExpandidoModulo10" ExpandControlID="PanelColapsadoModulo10" CollapseControlID="PanelColapsadoModulo10" Collapsed="true" TextLabelID="lblControlesModulo10" ImageControlID="imgModulo10" ExpandedImage="../imagenes/collapse.jpg" CollapsedImage="../imagenes/expand.jpg" SuppressPostBack="true"></cc1:CollapsiblePanelExtender>
    <cc1:CollapsiblePanelExtender ID="ColapseModulo11" runat="server" TargetControlID="PanelExpandidoModulo11" ExpandControlID="PanelColapsadoModulo11" CollapseControlID="PanelColapsadoModulo11" Collapsed="true" TextLabelID="lblControlesModulo11" ImageControlID="imgModulo11" ExpandedImage="../imagenes/collapse.jpg" CollapsedImage="../imagenes/expand.jpg" SuppressPostBack="true"></cc1:CollapsiblePanelExtender>



</form>
    <script type="text/javascript">
        var img1 = new Image();
        img1.src = '../imagenes/header_hoverBg.gif';
        var img2 = new Image();
        img2.src = '../imagenes/header_activeBg.gif';
        var img3 = new Image();
        img3.src = '../imagenes/spinner.gif';
        var img4 = new Image();
        img4.src = '../imagenes/ComponentArt_spinner.gif';
  </script>
  </body>
</html>
