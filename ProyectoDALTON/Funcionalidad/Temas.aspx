<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Temas.aspx.vb" Inherits="Framework_Temas" %>

<%@ Register Assembly="DevExpress.Data.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Data" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    
    <title></title>

    <script type="text/javascript">
        function ColorChangedHandler(s, e) {
            CallbackPanel.PerformCallback();
        }
    </script>

    <style type="text/css">
        .auto-style1 {
            width: 96px;
        }
        .auto-style5 {
            width: 519px;
        }
        .auto-style6 {
            height: 10px;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">

        <div style="height: 232px">

        <div>
            <br />
            <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" HeaderText="Editar Tema" Font-Size="Medium" Font-Bold="True" Width="100%" Theme="Metropolis" ForeColor="Black" >
                <HeaderStyle BackColor="#F2EAFF" Border-BorderColor="White" />
                <PanelCollection>
                    <dx:PanelContent runat="server">
                        <table>
                            <tr>
                                <td>
                        <dx:ASPxComboBox ID="cmbTema" runat="server" Caption = "Selecciona Tema" AutoPostBack="True" ClientInstanceName="cmbTema" Theme="Office2003Blue" EnableTheming="True">
                        </dx:ASPxComboBox>
                                    
                                </td>
                                <td>
                                    <dx:ASPxColorEdit ID="cmbEncabezado" caption = "Color Encabezado" runat="server" ClientInstanceName="cmbEncabezado" Theme="Office2003Blue" EnableCustomColors="True" ClientVisible="False">
                                        <ClientSideEvents ColorChanged="ColorChangedHandler" />
                                    </dx:ASPxColorEdit>

                                </td>
                                <td>
                                    <dx:ASPxColorEdit ID="cmbBack" caption = "Color Fondo" runat="server" ClientInstanceName="cmbBack" Theme="Office2003Blue" EnableCustomColors="True" ClientVisible="False">
                                         <ClientSideEvents ColorChanged="ColorChangedHandler" />
                                    </dx:ASPxColorEdit>
                                </td>
                                <td>
                                    <dx:ASPxColorEdit ID="cmbFore" caption = "Color Letra" runat="server" ClientInstanceName="cmbFore" Theme="Office2003Blue" EnableCustomColors="True" ClientVisible="False">
                                        <ClientSideEvents ColorChanged="ColorChangedHandler" />
                                    </dx:ASPxColorEdit>
                                </td>
                                
                            </tr>
                            <tr>
                                        <td colspan="2" class="auto-style6">&nbsp;
                                        </td>
                                    </tr>
                            <tr>
                                <td>
                                    <dx:ASPxButton ID="btnActualiza" runat="server" ClientIDMode="AutoID" ClientInstanceName="btnActualiza" Height="18px" Text="Guardar Tema Seleccionado" Theme="PlasticBlue" Width="100%" AutoPostBack="False" EnableTheming="True">
                                        <ClientSideEvents Click="function(s, e) {
	cbGuardar.PerformCallback();
	
}" />
                                    </dx:ASPxButton>
                                    <dx:ASPxCallback ID="cbGuardar" runat="server" ClientIDMode="AutoID" ClientInstanceName="cbGuardar">
                                        <ClientSideEvents EndCallback="function(s, e) {
 alert(s.cpAccion);
}" />
                                    </dx:ASPxCallback>
                                </td>
                            </tr>
                        </table>

                    </dx:PanelContent>
                </PanelCollection>
                <Border BorderColor="#F2EAFF" />
                <BorderBottom BorderColor="#F2EAFF" />
            </dx:ASPxRoundPanel>

        
            <br />
            <br />
            <br /> 
            <br />  

<dx:ASPxCallbackPanel runat="server" ID="CallbackPanel" ClientInstanceName="CallbackPanel" Width="100%" Height="119px" OnCallback="OnCallBack" ClientIDMode="AutoID">
                <PanelCollection>
                    <dx:PanelContent ID="PanelContent1" runat="server">

                        <dx:ASPxRoundPanel ID="ASPxRoundPanel4" runat="server" ShowCollapseButton="True" ShowHeader="False" Width="100%" Height="68px">
                <PanelCollection>
                    <dx:PanelContent runat="server">
                        <table class="auto-style40">
                            <tr>
                                <td>
                                    <dx:ASPxButton ID="btnAgregar" runat="server" ToolTip="Agregar" ClientInstanceName="btnAgregar" AutoPostBack="False" EnableClientSideAPI="false">
                                        <ClientSideEvents Click="function(s, e) {
                                            cbAgregar.PerformCallback();	
                                            }" />
                                        <Image IconID="actions_add_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>

                                <td>
                                    <dx:ASPxButton ID="btnEditar" runat="server" ToolTip="Editar" ClientInstanceName="btnEditar" AutoPostBack="False" EnableClientSideAPI="false">
                                        <ClientSideEvents Click="function(s, e) {
cbEditar.PerformCallback();	
}" />
                                        <Image IconID="edit_edit_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>

                                <td>
                                    <dx:ASPxButton ID="btnEliminar" runat="server" ToolTip="Eliminar" AutoPostBack="False" ClientInstanceName="btnEliminar" EnableClientSideAPI="True">
                                        <ClientSideEvents Click="function(s, e) {
        cbEliminar.PerformCallback();	
                                        }" />
                                        <Image IconID="edit_delete_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>

                                <td>
                                    <dx:ASPxButton ID="btnCancelar" runat="server" AutoPostBack="False" ClientInstanceName="btnCancelar" ToolTip="Cancelar" EnableClientSideAPI="True">
                                        <ClientSideEvents Click="function(s, e) {
  cbCancelar.PerformCallback();	

                                        }" />
                                        <Image IconID="actions_cancel_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>

                                <td>
                                    <dx:ASPxButton ID="btnActualizar" runat="server" AutoPostBack="False" ClientInstanceName="btnActualizar" ToolTip="Actualizar" ValidationGroup="reqError1" EnableClientSideAPI="true" CausesValidation="False">
                                        <ClientSideEvents Click="function(s, e) {
                                            cbActualizarPerformCallback();	
                                            }" />
                                        <Image IconID="actions_apply_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                </td>

                            </tr>
                        </table>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>

            <br />
            <br /> 

    <dx:ASPxRoundPanel ID="ASPxRoundPanel3" runat="server" Font-Bold="True" Font-Size="Large" HeaderText="Búsqueda" Width="100%" ClientIDMode="AutoID" ClientInstanceName="ASPxRoundPanel1">
     <PanelCollection>
<dx:PanelContent runat="server">

    <table style="width: 100%">

                        

                        <tr>
                            <td class="auto-style1">
                                   <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Selecciona:" Font-Size="Medium">
                                </dx:ASPxLabel>    
                            </td>
                            <td>
                                  <dx:ASPxComboBox ID="ASPxComboBox2" runat="server" Height="20px" Width="330px">
                                </dx:ASPxComboBox> 
                            </td>

                        </tr>
                                
   </table>
            </dx:PanelContent>
</PanelCollection>
                    
    </dx:ASPxRoundPanel>
            
<br />
<br /> 

    <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" Font-Bold="True" Font-Size="Large" HeaderText="Formulario General" Width="100%" ClientIDMode="AutoID" ClientInstanceName="ASPxRoundPanel1">
        <PanelCollection>
            <dx:PanelContent runat="server">
                <dx:ASPxRoundPanel ID="ASPxRoundPanel2" runat="server" Font-Bold="True" Font-Size="Medium" HeaderText="Datos generales" Width="100%">
                    <PanelCollection>
                        <dx:PanelContent runat="server">
                            <table style="width: 100%">
                                <tr>
                                    <td style="width:15%">
                                        <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="Combo:" Font-Size="Medium">
                                        </dx:ASPxLabel>
                                    </td>   
                                    <td>
                                        <dx:ASPxComboBox ID="ASPxComboBox1" runat="server" Width = "40%">
                                        </dx:ASPxComboBox>
                                    </td>   
                                 </tr>   
                                <tr>
                                        <td colspan="2">&nbsp;
                                        </td>
                                    </tr>
                                 <tr>        
                                     <td class="auto-style5">
                                         <dx:ASPxLabel ID="ASPxLabel4" runat="server" Font-Size="Medium" Text="Caja de texto:">
                                         </dx:ASPxLabel>
                                      </td>  
                                       <td> 
                                        <dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="40%">
                                        </dx:ASPxTextBox>
                                      </td> 
                                   </tr>
                                <tr>
                                        <td colspan="2">&nbsp;
                                        </td>
                                    </tr>
                                     <tr>
                                         <td colspan="2">
                                        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" Width="100%">
                                            <Settings AutoFilterCondition="BeginsWith" />
                                            <Columns>
                                                <dx:GridViewDataTextColumn Caption="No." ShowInCustomizationForm="True" VisibleIndex="0">
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn Caption="Nombre corto" ShowInCustomizationForm="True" VisibleIndex="1">
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn Caption="Nombre" ShowInCustomizationForm="True" VisibleIndex="2">
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn Caption="#Dig. Ctas." ShowInCustomizationForm="True" VisibleIndex="3">
                                                </dx:GridViewDataTextColumn>
                                                <dx:GridViewDataTextColumn Caption="F. Liquid. Default TR" ShowInCustomizationForm="True" VisibleIndex="4">
                                                </dx:GridViewDataTextColumn>
                                            </Columns>
                                        </dx:ASPxGridView>
                                             </td>
                                     </tr>
                                
                            </table>
                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxRoundPanel>
            </dx:PanelContent>
        </PanelCollection>
    </dx:ASPxRoundPanel>
                   
    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxCallbackPanel>
            
         <br />
            <%--botones--%><%--Botón buscar--%>
        </div>
        
    </div>

    </form>
</body>
</html>
