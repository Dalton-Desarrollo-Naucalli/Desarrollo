<%@ Page Language="VB" AutoEventWireup="false" CodeFile="MatricesContablesI.aspx.vb" Inherits="Funcionalidad_MatricesContablesI" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="../funcionesJS/FuncionesForms.js"></script>
    <script src="../funcionesJS/MatricesContablesI.js"></script>
    <title>Matrices contables I</title>
     <style>         
        .AlignButtonRigth {
             margin-left:92%                        
        }         
        .AlignButtonR {
             margin-left:40%                        
        }
     </style>
</head>
<body onkeypress="return pulsar(event)">
    <form id="form1" runat="server">

       <div>
    <%--    <dx:ASPxRoundPanel ID="ASPxRoundPanel4" runat="server" ShowCollapseButton="True" ShowHeader="False" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">
                    <table class="auto-style40">
                        <tr>
                            <td class="auto-style4">
                                <dx:ASPxButton ID="btnAgregar" runat="server" ToolTip="Agregar" ClientInstanceName="btnAgregar" AutoPostBack="False" EnableClientSideAPI="false" ClientEnabled="False" GroupName="A">
                                    <ClientSideEvents Click="function(s, e) {
Enc_BotonAgregar();
LimpiaControles();
}"
                                        CheckedChanged="function(s, e) {
if (s.GetChecked()){
LimpiaControles();
HabilitaMatriz1();
           }
else	{
DeshabilitaMatriz1();
       }
}
" />
                                    <Image IconID="actions_add_32x32">
                                    </Image>
                                </dx:ASPxButton>

                          
                            </td>


                            <td class="auto-style4">
                                <dx:ASPxButton ID="btnEditar" runat="server" ToolTip="Editar" ClientInstanceName="btnEditar" AutoPostBack="False" EnableClientSideAPI="false" ClientEnabled="False" GroupName="B">
                                    <ClientSideEvents Click="function(s, e) {
Enc_BotonEditar();
}"
                                        CheckedChanged="function(s, e) {
if (s.GetChecked()) {
HabilitaMatriz1();
           }
else	{
DeshabilitaMatriz1();
       }
}
" />
                                    <Image IconID="edit_edit_32x32">
                                    </Image>
                                </dx:ASPxButton>
                          
                            </td>


                            <td class="auto-style4">

                                <dx:ASPxButton ID="btnEliminar" runat="server" ToolTip="Eliminar" AutoPostBack="False" ClientInstanceName="btnEliminar" EnableClientSideAPI="True" ClientEnabled="True">
                                    <ClientSideEvents Click="function(s, e) {
 ConfirmarEliminar();
}" />
                                    <Image IconID="edit_delete_32x32">
                                    </Image>
                                </dx:ASPxButton>
                                <dx:ASPxCallback ID="cbEliminar" runat="server" ClientInstanceName="cbEliminar">
                                    <ClientSideEvents EndCallback="function(s, e) {
   alert(s.cpAccionE);
    limpia(s.cpClear);                                        
glBusqueda.GetGridView().Refresh();

}" />
                                </dx:ASPxCallback>
                            </td>


                            <td class="auto-style4">
                                <dx:ASPxButton ID="btnCancelar" runat="server" AutoPostBack="False" ClientInstanceName="btnCancelar" ToolTip="Cancelar" EnableClientSideAPI="True" ClientEnabled="False">
                                    <ClientSideEvents Click="function(s, e) {
cbCancelar.PerformCallback();
                  }" />
                                    <Image IconID="actions_cancel_32x32">
                                    </Image>
                                </dx:ASPxButton>
                                <dx:ASPxCallback ID="cbCancelar" runat="server" ClientInstanceName="cbCancelar">
                                    <ClientSideEvents BeginCallback="function(s, e) {
if ((btnAgregar.Checked == true) &amp;&amp; (btnEditar.ClientEnabled== false)){
LimpiaControles();
}	
else{
MuestraMatriz1();
}
}" />
                                </dx:ASPxCallback>
                            </td>


                            <td class="auto-style4">
                                <dx:ASPxButton ID="btnActualizar" runat="server" AutoPostBack="False" ClientInstanceName="btnActualizar" ToolTip="Actualizar" ValidationGroup="reqError1" EnableClientSideAPI="true" CausesValidation="False" ClientEnabled="False">
                                    <ClientSideEvents Click="function(s, e) {
            cbActualizar.PerformCallback();
                            }" />
                                    <Image IconID="actions_apply_32x32">
                                    </Image>
                                </dx:ASPxButton>
                                <dx:ASPxCallback ID="cbActualizar" runat="server" ClientInstanceName="cbActualizar">
                                    <ClientSideEvents EndCallback="function(s, e) {
alert(s.cpAccion);
glBusqueda.GetGridView().Refresh();
 if (cmbConcepto.GetValue() == '') {
cmbConcepto.SetValue(s.cpMC1);}
BloqueaAgrega();                                        
}

" />
                                </dx:ASPxCallback>
                            </td>


                        </tr>
                    </table>
                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>

        <%--  BOTONES PANEL (AGREGA, EDITA, ELIMINA, ACTUALIZA)--%>

        
        <br />
        <br />
        
            <%--<dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" HeaderText="Búsqueda:" Font-Size="Medium" Font-Bold="false" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">




                        <dx:ASPxGridLookup ID="glBusqueda" ClientInstanceName="glBusqueda" Font-Size="Medium" ClientIDMode="AutoID" runat="server" Width="30%" KeyFieldName="id_tipogasto" AutoGenerateColumns="False" TextFormatString="{0} | {2}">
                            <GridViewProperties>

                                <SettingsBehavior AllowFocusedRow="True" AllowSelectSingleRowOnly="True" />
                                <SettingsBehavior />
                                <Settings ShowFilterBar="Auto" ShowFilterRow="True" ShowFilterRowMenu="True" />
                            </GridViewProperties>

                            <GridViewClientSideEvents FocusedRowChanged="function(s, e) {
	                                                                    MuestraMatriz1();
                                                                        HabilitaBotones();
                                                                       }" />

                        </dx:ASPxGridLookup>
                      
                       
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>--%>
            <br />
            <br />
        </div>
        <%--Botones y GRIDLOOKUP BUSQUEDA--%>


        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" HeaderText="Matrices contables I" Font-Bold="true" Font-Size="large"  Width="100%" >
            <PanelCollection>
                <dx:PanelContent runat="server">
                     <asp:Label ID="lblAccesos" runat="server" CssClass="GlobalTextoPanel" Visible="false"></asp:Label>
                   
                                <table style="width: 100%">

                                    <%--<tr>
                                        <td style="width:15%">
                                            <dx:ASPxLabel ID="lblConcepto" ClientEnabled="false" ClientInstanceName="lblConcepto" ForeColor="Black" runat="server" Text="Concepto:" Font-Size="Medium"></dx:ASPxLabel>
                                        </td>
                                        <td style="width:35%" >
                                            <dx:ASPxComboBox ID="cmbConcepto" ClientEnabled="false" ForeColor="Black" Font-Size="Medium" runat="server" ClientInstanceName="cmbConcepto" TextFormatString="{0}"  Width="75%">
                                            <Columns>
                                                <dx:ListBoxColumn Caption="DESCRIPCIÓN" FieldName="NombreC" Width="300px" />
                                                 <dx:ListBoxColumn Caption="ID" FieldName="ID" Width="50px" />
                                            </Columns>
                                            </dx:ASPxComboBox>
                                        </td>
                                    <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;
                                        </td>
                                    </tr>--%>
                                   <dx:ASPxGridView ID="GVMatriz1" runat="server" AutoGenerateColumns="False" Font-Size="Medium" ClientIDMode="AutoID" ClientInstanceName="GVMatriz1" Width="100%" KeyFieldName="id_tipogasto" SettingsCommandButton-CancelButton-Text="Cancelar" SettingsCommandButton-UpdateButton-Text="Guardar" ForeColor="Black">
                                             
                                           <ClientSideEvents EndCallback="OnEndCallback
"
                                                    BeginCallback="OnBeginCallback	
" />
                                                <SettingsEditing Mode="Batch" UseFormLayout="False">
                                                </SettingsEditing>
                                                <SettingsBehavior AllowFocusedRow="True" AllowSelectByRowClick="True" AllowSelectSingleRowOnly="True" />
                                                <SettingsCommandButton>
                                                    <NewButton ButtonType="Image" RenderMode="Image" Text="Nuevo">
                                                        <Image Height="20px" Url="~/Imagenes/NEW_.png" Width="20px">
                                                        </Image>
                                                    </NewButton>
                                                    <EditButton ButtonType="Image" RenderMode="Image" Text="Editar">
                                                        <Image Height="16px" Url="~/Imagenes/editar.png" Width="16px">
                                                        </Image>
                                                    </EditButton>
                                                    <DeleteButton ButtonType="Image" RenderMode="Image" Text="Eliminar">
                                                        <Image Height="16px" Url="~/Imagenes/Delete.png" Width="16px">
                                                        </Image>
                                                    </DeleteButton>
                                                </SettingsCommandButton>
                                            </dx:ASPxGridView>
                                    <tr>
                                        <td>&nbsp;
                                        </td>
                                    </tr>
                                </table>
                                <br />
                                <br />
                                <table style="width: 100%">
                                   
                                    <tr>
                                        <td>
                                            <dx:ASPxButton ID="btnImprimir" runat="server" CssClass="AlignButtonRigth" Text="Imprimir"></dx:ASPxButton>
                                        </td>
                                       
                                    </tr>


                                </table>

                            </dx:PanelContent>
                        </PanelCollection>
                    </dx:ASPxRoundPanel>                

    </form>
</body>
</html>
