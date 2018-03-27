<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Catalogo_Maestro.aspx.vb" Inherits="Framework_Test" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/CatMaestro.js"></script>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
   
</head>

<body>

    <form id="form1" runat="server">
       <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" HeaderText="Selecciona un catálogo:" Font-Size="Large"  Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">

                        <table style="width:100%">
                               
                                <tr>
                                 
                                    <td>
                                        <asp:Label ID="lblAccesos" runat="server" CssClass="GlobalTextoPanel"></asp:Label>
                                    </td>
                              
                                </tr>
                                <tr>                        
                                         <dx:ASPxGridLookup ID="glCatalogos" runat="server" AnimationType="Fade" Font-Size="Medium" AutoGenerateColumns="False" ClientIDMode="AutoID" ClientInstanceName="glCatalogos" EnableTheming="True" KeyFieldName="idCatalogo" TextFormatString="{0} | {1}"  Width="350px">
                                             
                                             <GridViewProperties>                                           
                                                <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                                                <Settings ShowFilterBar="Visible" ShowFilterRow="True" ShowFilterRowMenu="True" ShowFilterRowMenuLikeItem="True" />
                                            </GridViewProperties>
                                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
 OnGridFocusedRowChanged();
}" SelectionChanged="function(s, e) {
	 OnGridFocusedRowChanged();
}" />
                                            <ClientSideEvents Init="function(s, e) {
	  txtForm.SetText('');
txtIdPar.SetText('');
}" ValueChanged="function(s, e) {

        OnBuscar();
}" />
                                        </dx:ASPxGridLookup>
                                    </tr>
                                    </table>
                   
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>
           
        <br />
                
        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server"  Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">

                        <table style="width:100%" >
                            <tr>
                                <td>
                                        <dx:ASPxTextBox ID="txtForm" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtForm" Width="170px" ClientVisible="False">
                                        </dx:ASPxTextBox>
                                        <dx:ASPxTextBox ID="txtIdPar" runat="server" ClientIDMode="AutoID" ClientInstanceName="txtIdPar" ClientVisible="False" Width="170px">
                                            <ClientSideEvents TextChanged="function(s, e) {
	OnBuscar();

}" />
                                        </dx:ASPxTextBox>
                               
                             </td>
                                </tr>
                            <tr>
                                   
                                    <td>
                                        <dx:ASPxGridView ID="GridFinammico" runat="server" Width="100%" ClientIDMode="AutoID" ClientInstanceName="GridFinammico" KeyFieldName="ID" AutoGenerateColumns="False" SettingsCommandButton-CancelButton-Text="Cancelar" SettingsCommandButton-UpdateButton-Text="Guardar" ForeColor="Black">
                                           
                                            <ClientSideEvents CustomButtonClick="function(s, e) {
var NomFrm
NomFrm = (s.cpNomFrm);

if(e.buttonID == &quot;BTNNuevo&quot;)
{
AbreForm();
}

//Enviar el parametro con un solo clic
if (e.buttonID == 'BTN')
{
OnGridFocusedRowChangedIdPar();
}

	}" FocusedRowChanged="function(s, e) {
}" EndCallback="function(s, e) {
	if (s.cpAccion != '')
{
		GridFinammico.Refresh();
		alert(s.cpAccion );
}
if(s.cpErrorCaptura != '')
{
alert('Los campos siguientes son obligatorios: \n' + s.cpErrorCaptura);
}
if(s.cpActualizar != '')
{
alert(s.cpActualizar );
}
if(s.cpSinDatos != '')
{
alert('Este catálogo no contiene campos');

}
}" />
                                            
                            
                                            <Templates>
                                                <EditForm>
                                                    
                                                        <dx:ASPxGridViewTemplateReplacement ID="Editors" runat="server" ReplacementType="EditFormEditors" />
                                                   
                                                     <div style="text-align: right; padding: 2px 2px 2px 2px">
                                                        <dx:ASPxGridViewTemplateReplacement ID="UpdateButton" runat="server"  ReplacementType="EditFormUpdateButton" />
                                                        <dx:ASPxGridViewTemplateReplacement ID="CancelButton" runat="server" ReplacementType="EditFormCancelButton" />
                                                        <%--<%--<a href="javascript:AbreForm();">NUEVO BOTÓN...</a>--%>
                                                        <%-- <a href="javascript:AbreFormIndependiente();"><img border="0" src="~Imagenes/vincu.jpg" /></a>
                                                        --%>
                                                        <%--<dx:ASPxHyperLink ID="Abrir" runat="server" AutoPostBack="False" ClientInstanceName="Abrir" Text="Abrir Formulario">
                                                            <ClientSideEvents Click="function(s, e) {
	                                                                                            AbreFormIndependiente();
                                                                                                    }" />
                                                        </dx:ASPxHyperLink>--%>
                                                   </div>
                                                </EditForm>
                                            </Templates>

                                           
                                            <SettingsEditing Mode="PopupEditForm" UseFormLayout="False"  >
                                            </SettingsEditing>
                                            <Settings ShowVerticalScrollBar="true" VerticalScrollableHeight="300" HorizontalScrollBarMode="Auto" ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />

                                            <SettingsBehavior AllowSort="true"  ColumnResizeMode="Control" AutoExpandAllGroups="true" ConfirmDelete="True" AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                                            <SettingsCommandButton>
                                                <NewButton ButtonType="Image" RenderMode="Image" Text="Nuevo Registro">
                                                    <Image Height="20px" Url="~/Imagenes/NEW_.png" Width="20px">
                                                    </Image>
                                                </NewButton>

<UpdateButton Text="Guardar"></UpdateButton>

<CancelButton Text="Cancelar"></CancelButton>

                                                <EditButton ButtonType="Image" RenderMode="Image" Text="&quot;Editar&quot;">
                                                    <Image Height="16px" Url="~/Imagenes/editar.png" Width="16px">
                                                    </Image>
                                                </EditButton>
                                                <DeleteButton ButtonType="Image" RenderMode="Image" Text="&quot;Eliminar&quot;">
                                                    <Image Height="16px" Url="~/Imagenes/Delete.png" Width="16px">
                                                    </Image>
                                                </DeleteButton>
                                            </SettingsCommandButton>
                                            <SettingsPopup>
                                                
                                                <EditForm Width="700px" MinHeight="110px" MinWidth="300px" AllowResize="true" Modal="true">
                                                                                               </EditForm>
                                            </SettingsPopup>
                                          
                                            <SettingsText ConfirmDelete="¿Está seguro de eliminar el registro?" PopupEditFormCaption="Formulario" />
                                            <EditFormLayoutProperties>
                                                <SettingsItems Width="100%" />
                                            </EditFormLayoutProperties>
                                        </dx:ASPxGridView>
                                   </td>
                                            </tr>                              
                              </table>

                        </dx:PanelContent>
                    </PanelCollection>
                </dx:ASPxRoundPanel>
        
  
    </form>
</body>
</html>
