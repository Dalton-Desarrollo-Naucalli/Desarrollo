<%@ Page Language="VB" AutoEventWireup="false" CodeFile="Socios.aspx.vb" Inherits="Framework_Socios" %>

<%@ Register Assembly="DevExpress.Data.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>

<%@ Register Assembly="DevExpress.Web.v16.1, Version=16.1.11.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Socios</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>

            <dx:ASPxRoundPanel ID="ASPxRoundPanel4" runat="server" ShowCollapseButton="True" ShowHeader="False" Theme="Office2003Blue" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">
                        <table class="auto-style40">
                            <tr>
                                <td>
                                    <dx:ASPxButton ID="btnAgregar" runat="server" ToolTip="Agregar" ClientInstanceName="btnAgregar" AutoPostBack="False" EnableClientSideAPI="false">
                                        <ClientSideEvents Click="function(s, e) {
	               OnNewRowClicked();
                                     }" />
                                        <Image IconID="actions_add_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                    <dx:ASPxCallback ID="cbAgregar" runat="server" ClientIDMode="AutoID" ClientInstanceName="cbAgregar">
                                    </dx:ASPxCallback>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnEditar" runat="server" ToolTip="Editar" ClientInstanceName="btnEditar" AutoPostBack="False" EnableClientSideAPI="false">
                                        <ClientSideEvents Click="function(s, e) {
                           OnEditRowClicked();	
                                              }" />
                                        <Image IconID="edit_edit_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                    <dx:ASPxCallback ID="cbEditar" runat="server" ClientIDMode="AutoID" ClientInstanceName="cbEditar">
                                    </dx:ASPxCallback>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnEliminar" runat="server" ToolTip="Eliminar" AutoPostBack="False" ClientInstanceName="btnEliminar" EnableClientSideAPI="True">
                                        <ClientSideEvents Click="function(s, e) {
	                                        OnConfirmDeleteRowsClicked();
                                        }" />
                                        <Image IconID="edit_delete_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                    <dx:ASPxCallback ID="cbEliminar" runat="server" ClientIDMode="AutoID" ClientInstanceName="cbEliminar">
                                    </dx:ASPxCallback>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnCancelar" runat="server" AutoPostBack="False" ClientInstanceName="btnCancelar" ToolTip="Cancelar" EnableClientSideAPI="True">
                                        <ClientSideEvents Click="function(s, e) {
	                                        OnDiscardChangesClicked();
                                        }" />
                                        <Image IconID="actions_cancel_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                    <dx:ASPxCallback ID="cbCancelar" runat="server" ClientIDMode="AutoID" ClientInstanceName="cbCancelar">
                                    </dx:ASPxCallback>
                                </td>
                                <td>
                                    <dx:ASPxButton ID="btnAplicar" runat="server" AutoPostBack="False" ClientInstanceName="btnAplicar" ToolTip="Aplicar" ValidationGroup="reqError1" EnableClientSideAPI="true" CausesValidation="False">
                                        <ClientSideEvents Click="function(s, e) {
                                            OnSaveChangesClicked();
                                            }" />
                                        <Image IconID="actions_apply_32x32">
                                        </Image>
                                    </dx:ASPxButton>
                                    <dx:ASPxCallback ID="cbAplicar" runat="server" ClientIDMode="AutoID" ClientInstanceName="cbAplicar">
                                    </dx:ASPxCallback>
                                </td>

                            </tr>
                        </table>
                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>
            <br />
            <br />
        </div>
        <div>
            <dx:ASPxRoundPanel ID="ASPxRoundPanel5" runat="server" ShowCollapseButton="True" ShowHeader="False" Theme="Office2003Olive" Width="100%">
                <PanelCollection>
                    <dx:PanelContent runat="server">


                        <table style="width:100%">

                            <tr>

                                <td style="width: 10%">
                                    <dx:ASPxLabel ID="ASPxLabel37" runat="server" Text="Ir a concepto" Width="95%" Style="text-align: left"></dx:ASPxLabel>
                                </td>

                                <td style="width: 10%">
                                    <dx:ASPxComboBox ID="ASPxComboBox1" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="90%">
                                        <Items>
                                            <dx:ListEditItem Text="000003" Value="1" />
                                            <dx:ListEditItem Text="000009" Value="1" />
                                            <dx:ListEditItem Text="000015" Value="1" />
                                            <dx:ListEditItem Text="000021" Value="1" />
                                        </Items>
                                    </dx:ASPxComboBox>
                                </td>

                                <td style="width: 25%">
                                    <dx:ASPxComboBox ID="ASPxComboBox2" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="70%">
                                        <Items>
                                            <dx:ListEditItem Text="000003" Value="1" />
                                            <dx:ListEditItem Text="000009" Value="1" />
                                            <dx:ListEditItem Text="000015" Value="1" />
                                            <dx:ListEditItem Text="000021" Value="1" />
                                        </Items>
                                    </dx:ASPxComboBox>
                                </td>
                                <td style="width: 15%">
                                
                                    <dx:ASPxButton ID="ASPxButton1" runat="server" Text="Buscar nombres con:" Width="80%"></dx:ASPxButton>
                                </td>
                                <td>
                                    <dx:ASPxTextBox ID="ASPxTextBox1" runat="server" Width="50%"></dx:ASPxTextBox>
                                </td>

                            </tr>


                        </table>

                    </dx:PanelContent>
                </PanelCollection>
            </dx:ASPxRoundPanel>

            <br />
            <br />
        </div>

        <dx:ASPxRoundPanel ID="ASPxRoundPanel1" runat="server" ShowCollapseButton="True" ShowHeader="False" Theme="Office2003Blue" Width="100%">
            <PanelCollection>
                <dx:PanelContent runat="server">

                    <dx:ASPxPageControl ID="prod" runat="server" ActiveTabIndex="1" EnableTheming="True" Theme="Office2010Blue" Width="100%">
                        <TabPages>

                            <dx:TabPage Name="tabMnto" Text="Socios/Productores" ActiveTabStyle-Font-Size="Medium">
                                <ActiveTabStyle Font-Size="Medium"></ActiveTabStyle>
                                <ContentCollection>
                                    <dx:ContentControl runat="server">

                                        <table style="width: 100%">

                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 15%">
                                                    <dx:ASPxLabel ID="ASPxLabel1" runat="server" Text="ID Socio"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="txtSocio" runat="server" Width="50%" ClientIDMode="AutoID" ClientInstanceName="txtSocio"></dx:ASPxTextBox>
                                                </td>
                                                <td style="width: 15%">
                                                    <dx:ASPxLabel ID="ASPxLabel2" runat="server" Text="Calidad jurídica"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="txtCalidadJuridica" runat="server" Width="50%" ClientIDMode="AutoID" ClientInstanceName="txtCalidadJuridica"></dx:ASPxTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel3" runat="server" Text="Nombre completo"></dx:ASPxLabel>
                                                    
                                                </td>
                                                <td colspan="3">
                                                    <dx:ASPxTextBox ID="txtNomombreCompleto" runat="server" Width="25%" ClientIDMode="AutoID" ClientInstanceName="txtNomombreCompleto"></dx:ASPxTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel4" runat="server" Text="País de nacimiento"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxComboBox ID="cmbPaisNacimiento" runat="server" ClientInstanceName="cmbPaisNacimiento" Theme="Office2010Blue" Width="50%" ClientIDMode="AutoID">
                                                        <Items>
                                                            <dx:ListEditItem Text="Mèxico" />
                                                            <dx:ListEditItem Text="USA" />
                                                        </Items>
                                                    </dx:ASPxComboBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel5" runat="server" Text="Estadao de nacimiento"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxComboBox ID="cmbEstadoNacimiento" runat="server" ClientInstanceName="cmbEstadoNacimiento" Theme="Office2010Blue" Width="50%" ClientIDMode="AutoID">
                                                    </dx:ASPxComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel6" runat="server" Text="Nacionalidad"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxComboBox ID="cmbNacionalidad" runat="server" ClientInstanceName="cmbNacionalidad" Theme="Office2010Blue" Width="50%" ClientIDMode="AutoID">
                                                    </dx:ASPxComboBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel7" runat="server" Text="Fecha de nacimiento"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="txtFechaNacimiento" runat="server" Width="50%" ClientIDMode="AutoID" ClientInstanceName="txtFechaNacimiento"></dx:ASPxTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel8" runat="server" Text="R.F.C"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="txtRFC" runat="server" Width="50%" ClientIDMode="AutoID" ClientInstanceName="txtRFC"></dx:ASPxTextBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel9" runat="server" Text="ID Siof"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="txtIdSiof" runat="server" Width="50%" ClientIDMode="AutoID" ClientInstanceName="txtIdSiof"></dx:ASPxTextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel10" runat="server" Text="Correo electrónico"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="txtCorreoElectronico" runat="server" Width="60%" ClientIDMode="AutoID" ClientInstanceName="txtCorreoElectronico"></dx:ASPxTextBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel11" runat="server" Text="#EscrituraPub"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="txtEscrituraPub" runat="server" Width="50%" ClientIDMode="AutoID" ClientInstanceName="txtEscrituraPub"></dx:ASPxTextBox>
                                                </td>
                                            </tr>

                                        </table>

                                        <br />
                                        <br />

                                        <dx:ASPxRoundPanel ID="xx" HeaderText="Domicilio" Theme="Office2010Blue" runat="server" Width="100%">
                                            <PanelCollection>
                                                <dx:PanelContent>

                                                    <table style="width: 100%">

                                                        <tr>
                                                            <td style="width: 15%">
                                                                <dx:ASPxLabel ID="ASPxLabel12" runat="server" Text="Domicilio"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxTextBox ID="txtDomicilio" runat="server" Width="50%" ClientIDMode="AutoID" ClientInstanceName="txtDomicilio"></dx:ASPxTextBox>
                                                            </td>
                                                            <td style="width: 15%">
                                                                <dx:ASPxLabel ID="ASPxLabel13" runat="server" Text="Colonia"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxTextBox ID="ASPxTextBox10" runat="server" Width="50%"></dx:ASPxTextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel14" runat="server" Text="Núm. Int"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxTextBox ID="ASPxTextBox11" runat="server" Width="25%"></dx:ASPxTextBox>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel15" runat="server" Text="Núm. Ext."></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxTextBox ID="ASPxTextBox12" runat="server" Width="25%"></dx:ASPxTextBox>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td colspan="2">&nbsp;
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel16" runat="server" Text="Estado"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxComboBox ID="ASPxComboBox4" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="50%">
                                                                </dx:ASPxComboBox>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel17" runat="server" Text="Municipio/Delegación"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxComboBox ID="ASPxComboBox5" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="50%">
                                                                </dx:ASPxComboBox>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td colspan="2">&nbsp;
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel18" runat="server" Text="ID Localidad"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxComboBox ID="ASPxComboBox6" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="50%">
                                                                </dx:ASPxComboBox>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel19" runat="server" Text="Código postal"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxTextBox ID="ASPxTextBox13" runat="server" Width="50%"></dx:ASPxTextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel20" runat="server" Text="Teléfono"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxTextBox ID="ASPxTextBox14" runat="server" Width="50%"></dx:ASPxTextBox>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel21" runat="server" Text="Extensión"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxTextBox ID="ASPxTextBox15" runat="server" Width="50%"></dx:ASPxTextBox>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td colspan="2">&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel22" runat="server" Text="Fax"></dx:ASPxLabel>
                                                            </td>
                                                            <td colspan="3">
                                                                <dx:ASPxTextBox ID="ASPxTextBox16" runat="server" Width="21%"></dx:ASPxTextBox>
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </dx:PanelContent>
                                            </PanelCollection>
                                        </dx:ASPxRoundPanel>

                                        <br />
                                        <br />

                                        <dx:ASPxRoundPanel ID="ASPxRoundPanel2" HeaderText="Domicilio del negocio o explotación" Theme="Office2010Blue" runat="server" Width="100%">
                                            <PanelCollection>
                                                <dx:PanelContent>

                                                    <table style="width: 100%">

                                                        <tr>
                                                            <td style="width: 15%">
                                                                <dx:ASPxLabel ID="ASPxLabel23" runat="server" Text="Domicilio"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxTextBox ID="ASPxTextBox17" runat="server" Width="50%"></dx:ASPxTextBox>
                                                            </td>
                                                            <td style="width: 15%">
                                                                <dx:ASPxLabel ID="ASPxLabel24" runat="server" Text="Colonia"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxTextBox ID="ASPxTextBox18" runat="server" Width="50%"></dx:ASPxTextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel25" runat="server" Text="Núm. Int"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxTextBox ID="ASPxTextBox19" runat="server" Width="25%"></dx:ASPxTextBox>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel26" runat="server" Text="Núm. Ext."></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxTextBox ID="ASPxTextBox20" runat="server" Width="25%"></dx:ASPxTextBox>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td colspan="2">&nbsp;
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel27" runat="server" Text="Estado"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxComboBox ID="ASPxComboBox7" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="50%">
                                                                </dx:ASPxComboBox>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel28" runat="server" Text="Municipio/Delegación"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxComboBox ID="ASPxComboBox8" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="50%">
                                                                </dx:ASPxComboBox>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td colspan="2">&nbsp;
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel29" runat="server" Text="ID Localidad"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxComboBox ID="ASPxComboBox9" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="50%">
                                                                </dx:ASPxComboBox>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel30" runat="server" Text="Código postal"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxTextBox ID="ASPxTextBox21" runat="server" Width="50%"></dx:ASPxTextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel31" runat="server" Text="Teléfono"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxTextBox ID="ASPxTextBox22" runat="server" Width="50%"></dx:ASPxTextBox>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel32" runat="server" Text="Extensión"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxTextBox ID="ASPxTextBox23" runat="server" Width="50%"></dx:ASPxTextBox>
                                                            </td>
                                                        </tr>

                                                        <tr>
                                                            <td colspan="2">&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel33" runat="server" Text="Fax"></dx:ASPxLabel>
                                                            </td>
                                                            <td colspan="3">
                                                                <dx:ASPxTextBox ID="ASPxTextBox24" runat="server" Width="21%"></dx:ASPxTextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxLabel ID="ASPxLabel34" runat="server" Text="Mercado"></dx:ASPxLabel>
                                                            </td>
                                                            <td colspan="3">
                                                                <dx:ASPxComboBox ID="ASPxComboBox10" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="21%">
                                                                </dx:ASPxComboBox>
                                                            </td>
                                                        </tr>
                                                    </table>


                                                </dx:PanelContent>
                                            </PanelCollection>
                                        </dx:ASPxRoundPanel>

                                        <br />
                                        <br />

                                        <dx:ASPxRoundPanel ID="ASPxRoundPanel3" HeaderText="Riesgo" Theme="Office2010Blue" runat="server" Width="100%">
                                            <PanelCollection>
                                                <dx:PanelContent>

                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td colspan="2">&nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 15%">
                                                                <dx:ASPxLabel ID="ASPxLabel35" runat="server" Text="Grado de riesgo"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxTextBox ID="ASPxTextBox25" runat="server" Width="50%"></dx:ASPxTextBox>
                                                            </td>
                                                            <td style="width: 15%">
                                                                <dx:ASPxLabel ID="ASPxLabel36" runat="server" Text="Fecha de riesgo"></dx:ASPxLabel>
                                                            </td>
                                                            <td>
                                                                <dx:ASPxTextBox ID="ASPxTextBox26" runat="server" Width="50%"></dx:ASPxTextBox>
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </dx:PanelContent>
                                            </PanelCollection>
                                        </dx:ASPxRoundPanel>



                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>


                        <%--    <dx:TabPage Name="tabMnto" Text="Datos complementarios" ActiveTabStyle-Font-Size="Medium">
                                <ActiveTabStyle Font-Size="Medium"></ActiveTabStyle>
                                <ContentCollection>
                                    <dx:ContentControl runat="server">

                                        <table style="width: 100%">
                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel37" runat="server" Text="Calidad migratoria"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxComboBox ID="ASPxComboBox11" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="60%">
                                                    </dx:ASPxComboBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel38" runat="server" Text="Tipo de deudor"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxComboBox ID="ASPxComboBox12" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="60%">
                                                    </dx:ASPxComboBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel39" runat="server" Text="Actividad económica"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxComboBox ID="ASPxComboBox13" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="60%">
                                                    </dx:ASPxComboBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel40" runat="server" Text="Actividad específica 1"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxComboBox ID="ASPxComboBox14" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="60%">
                                                    </dx:ASPxComboBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel41" runat="server" Text="Actividad específica 2"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxComboBox ID="ASPxComboBox15" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="60%">
                                                    </dx:ASPxComboBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel42" runat="server" Text="Actividad específica 3"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxComboBox ID="ASPxComboBox16" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="60%">
                                                    </dx:ASPxComboBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel43" runat="server" Text="Grupo económico"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxComboBox ID="ASPxComboBox17" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="60%">
                                                    </dx:ASPxComboBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel44" runat="server" Text="Sector económico"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxComboBox ID="ASPxComboBox18" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="60%">
                                                    </dx:ASPxComboBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel45" runat="server" Text="Organización"></dx:ASPxLabel>
                                                </td>
                                                <td colspan="3">
                                                    <dx:ASPxComboBox ID="ASPxComboBox19" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="23%">
                                                    </dx:ASPxComboBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel47" runat="server" Text="Superficie total"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="ASPxTextBox27" runat="server" Width="60%"></dx:ASPxTextBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel48" runat="server" Text="OCupación"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="ASPxTextBox28" runat="server" Width="60%"></dx:ASPxTextBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel49" runat="server" Text="Profesión"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="ASPxTextBox29" runat="server" Width="60%"></dx:ASPxTextBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel50" runat="server" Text="FEA"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="ASPxTextBox30" runat="server" Width="60%"></dx:ASPxTextBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>


                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel46" runat="server" Text="País"></dx:ASPxLabel>
                                                </td>
                                                <td colspan="3">
                                                    <dx:ASPxComboBox ID="ASPxComboBox20" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="10%">
                                                    </dx:ASPxComboBox>
                                                </td>

                                            </tr>
                                        </table>
                                        <br />
                                        <br />
                                        <dx:ASPxRoundPanel ID="ASPxRoundPanel5" HeaderText="Asignación de ejecutivos de crédito" Theme="Office2010Blue" runat="server" Width="100%">
                                            <PanelCollection>
                                                <dx:PanelContent>

                                                    <table style="width: 100%">
                                                        <tr>
                                                            <td>
                                                                <dx:ASPxGridView ID="ASPxGridView1" runat="server" Theme="Office2010Blue">
                                                                    <Columns>
                                                                        <dx:GridViewDataTextColumn Caption=" Ejecutivo de crédito">
                                                                        </dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn Caption=" Intermedaria financiera">
                                                                        </dx:GridViewDataTextColumn>
                                                                        <dx:GridViewDataTextColumn Caption=" Fecha">
                                                                        </dx:GridViewDataTextColumn>
                                                                    </Columns>
                                                                </dx:ASPxGridView>
                                                            </td>
                                                        </tr>
                                                    </table>

                                                </dx:PanelContent>
                                            </PanelCollection>
                                        </dx:ASPxRoundPanel>



                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>

                            <dx:TabPage Name="tabMnto" Text="Perfil transaccional PLD" ActiveTabStyle-Font-Size="Medium">
                                <ActiveTabStyle Font-Size="Medium"></ActiveTabStyle>
                                <ContentCollection>
                                    <dx:ContentControl runat="server">
                                        <table style="width: 100%">
                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel51" runat="server" Text="Entrevistador"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxComboBox ID="ASPxComboBox21" runat="server" ClientInstanceName="estatus" Theme="Office2010Blue" Width="60%">
                                                    </dx:ASPxComboBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel52" runat="server" Text="Fecha entrevista"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="ASPxTextBox31" runat="server" Width="60%"></dx:ASPxTextBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel53" runat="server" Text="Factor transaccional"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="ASPxTextBox32" runat="server" Width="60%"></dx:ASPxTextBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel54" runat="server" Text="Periódo (meses)"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="ASPxTextBox33" runat="server" Width="60%"></dx:ASPxTextBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>

                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel55" runat="server" Text="Máximo mensual"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="ASPxTextBox34" runat="server" Width="60%"></dx:ASPxTextBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel56" runat="server" Text="Pagos mesuales"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="ASPxTextBox35" runat="server" Width="60%"></dx:ASPxTextBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>


                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel57" runat="server" Text="Comentarios"></dx:ASPxLabel>
                                                </td>
                                                <td colspan="3">
                                                    <dx:ASPxMemo ID="ASPxMemo1" runat="server" Height="15px" Width="26%"></dx:ASPxMemo>
                                                </td>

                                            </tr>

                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>


                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel58" runat="server" Text="Desviación estandar"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="ASPxTextBox36" runat="server" Width="60%"></dx:ASPxTextBox>
                                                </td>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel59" runat="server" Text="Promedio"></dx:ASPxLabel>
                                                </td>
                                                <td>
                                                    <dx:ASPxTextBox ID="ASPxTextBox37" runat="server" Width="60%"></dx:ASPxTextBox>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>


                                            <tr>
                                                <td>
                                                    <dx:ASPxLabel ID="ASPxLabel60" runat="server" Text="Alerta"></dx:ASPxLabel>
                                                </td>
                                                <td colspan="3">
                                                    <dx:ASPxTextBox ID="ASPxTextBox38" runat="server" Width="26%"></dx:ASPxTextBox>
                                                </td>

                                            </tr>

                                            <tr>
                                                <td colspan="2">&nbsp;
                                                </td>
                                            </tr>


                                            <tr>
                                                <td colspan="4">
                                                    <dx:ASPxGridView ID="ASPxGridView2" runat="server" Caption="Historial de pagos" Theme="Office2010Blue"></dx:ASPxGridView>
                                                </td>
                                            </tr>

                                        </table>


                                    </dx:ContentControl>
                                </ContentCollection>
                            </dx:TabPage>--%>



                        </TabPages>
                    </dx:ASPxPageControl>



                </dx:PanelContent>
            </PanelCollection>
        </dx:ASPxRoundPanel>
    </form>
</body>
</html>

