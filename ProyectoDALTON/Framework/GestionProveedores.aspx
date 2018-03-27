<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GestionProveedores.aspx.cs" Inherits="Framework_GestionProveedores" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <script src="../Scripts/jquery-3.1.1.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/jquery.validate.js"></script>
    <script src="../Scripts/jquery.mask.js"></script>
    <script src="../Scripts/jquery.validate.min.js"></script>
    <title></title>
    <style>
        .inputLarge {
            max-width: 100% !important;
        }

        .error {
            color: #ff0000;
        }
    </style>
</head>
<body>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <h1 class="page-header">Proveedor</h1>
            </div>
        </div>
    </div>
    <div class="container">
        <form id="forma" runat="server">
            <div class="row">
                <div class="col-md-12">
                    <asp:Button OnClick="btnAgregar_Click" ID="btnAgregar" runat="server" Text="Agregar" CssClass="btn btn-primary" />
                </div>
            </div>
            <div id="divCatalogo" runat="server">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="control-label">Buscar</label>
                            <asp:TextBox runat="server" ID="txtBuscar" CssClass="form-control inputLarge"></asp:TextBox>
                            <br />
                            <asp:Button runat="server" CssClass="btn btn-default" ID="btnBuscar" Text="Buscar" OnClick="btnBuscar_Click" />
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <asp:GridView ID="gv" runat="server" AutoGenerateColumns="False" CellPadding="4"
                            ForeColor="#333333" GridLines="None" CssClass="table table-hover table-responsive table-bordered" OnRowCommand="gv_RowCommand">
                            <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                            <Columns>
                                <asp:BoundField DataField="prov_id" HeaderText="Clave Proveedor" />
                                <asp:BoundField DataField="nombre" HeaderText="Proveedor" />
                                <asp:BoundField DataField="nombre_corto" HeaderText="Nombre Corto" />
                                <asp:TemplateField HeaderText="Editar">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgGuardar" runat="server" ImageUrl="~/imagenes/editar.png"
                                            ToolTip="Editar" CommandName="Editar" CommandArgument='<%# Eval("prov_id") %>' />
                                        <asp:ImageButton ID="imgEliminar" runat="server" ImageUrl="~/Imagenes/eliminar.png"
                                            ToolTip="Borrar" CommandName="Borrar" CommandArgument='<%# Eval("prov_id") %>' OnClientClick="javascript: return confirm('Seguro que desea eliminar ?');" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                            <EditRowStyle BackColor="#999999" />
                            <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        </asp:GridView>
                    </div>
                </div>
            </div>


            <div id="Editar" runat="server" visible="false">
                <asp:Label ID="lblAccesos" runat="server" Text="" CssClass="GlobalTextoPanel"></asp:Label>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="panel-title">Información General</div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <div class="col-md-2">
                                        <label class="control-label">Número de Proveedor</label>
                                        <asp:TextBox ReadOnly="true" runat="server" ID="NumProveedor" CssClass="form-control inputLarge"></asp:TextBox>
                                    </div>
                                    <div class="col-md-2">
                                        <label class="control-label">Número de Distribuidor</label>
                                        <asp:TextBox runat="server" ID="NumDistribuidor" CssClass="form-control inputLarge"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <div class="col-md-12">
                                        <label class="control-label">Nombre   *</label>
                                        <asp:TextBox runat="server" ID="Nombre" CssClass="form-control inputLarge"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <div class="col-md-6">
                                        <label class="control-label">Nombre Corto</label>
                                        <asp:TextBox runat="server" ID="NombreCorto" CssClass="form-control inputLarge"></asp:TextBox>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="control-label">RFC   *</label>
                                        <asp:TextBox runat="server" ID="RFC" CssClass="form-control inputLarge"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="panel-title">Dirección</div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Domicilio   *</label>
                                    <asp:TextBox runat="server" ID="Calle" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Colonia   *</label>
                                    <asp:TextBox runat="server" ID="Colonia" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Municipio   *</label>
                                    <asp:TextBox runat="server" ID="Municipio" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Estado   *</label>
                                    <asp:DropDownList runat="server" ID="Estado" CssClass="form-control inputLarge"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Código Postal   *</label>
                                    <asp:TextBox runat="server" ID="CP" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="panel-title">Información Adicional</div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Teléfono 1   *</label>
                                    <asp:TextBox runat="server" ID="Telefono" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Telefono 2:</label>
                                    <asp:TextBox runat="server" ID="Telefono2" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">FAX</label>
                                    <asp:TextBox runat="server" ID="Fax" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Correo Electrónico   *</label>
                                    <asp:TextBox runat="server" ID="Correo" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>

                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Días de Crédito   *</label>
                                    <asp:TextBox runat="server" ID="DiasCredito" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Banco   *</label>
                                    <asp:DropDownList ID="Banco" runat="server" CssClass="form-control inputLarge">
                                        <asp:ListItem Text="Please select" Value="0"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Cta. de Cheques   *</label>
                                    <asp:TextBox runat="server" ID="CtaCheques" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Saldo Cuenta</label>
                                    <asp:TextBox ReadOnly="true" runat="server" ID="SaldoCuenta" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label">Tipo de Proveedor   *</label>
                                    <asp:DropDownList ID="TipoProveedor" runat="server" CssClass="form-control inputLarge"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label">% Ret IVA</label>
                                    <asp:TextBox ReadOnly="true" runat="server" ID="RetIva" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label">% ISR   *</label>
                                    <asp:TextBox runat="server" ID="RetIsr" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="contrsol-label">Auxiliar Contable   *</label>
                                    <asp:DropDownList ID="AuxiliarContable" runat="server" CssClass="form-control inputLarge"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Auxiliar</label>
                                    <asp:TextBox ReadOnly="true" runat="server" ID="Auxiliar" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="contrsol-label">Auxiliar Contable CC  *</label>
                                    <asp:DropDownList ID="AuxiliarContableCC" runat="server" CssClass="form-control inputLarge"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Auxiliar CC</label>
                                    <asp:TextBox ReadOnly="true" runat="server" ID="AuxiliarCC" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="control-label">Nota</label>
                                    <asp:TextBox runat="server" ID="Nota" TextMode="MultiLine" Rows="3" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Nacionalidad   *</label>
                                    <asp:DropDownList ID="Nacionalidad" runat="server" CssClass="form-control inputLarge"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Sujeto Control IMP/EXP   *</label>
                                    <asp:DropDownList ID="SujetoImpExp" runat="server" CssClass="form-control inputLarge"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="panel-title">Zonas Fiscales</div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Zona Fiscal</label>
                                    <asp:DropDownList ValidationGroup="ZonasGrp" runat="server" ID="txtZonaFiscal" CssClass="form-control inputLarge"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Descripción</label>
                                    <asp:TextBox ValidationGroup="ZonasGrp" runat="server" ID="txtDescripcion" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" ValidationGroup="ZonasGrp" CssClass="btn btn-default" ID="btnZona" Text="Agregar" OnClick="btnZona_Click" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-8">
                                <div class="form-group">
                                    <%--<asp:GridView runat="server" ID="gvZonas" CssClass="table table-bordered" AutoGenerateColumns="true"></asp:GridView>--%>
                                    <asp:GridView ID="gvZonas" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                        GridLines="None" CssClass="table table-hover table-responsive table-bordered" OnRowCommand="gvZonas_RowCommand">
                                        <Columns>
                                            <asp:BoundField DataField="IdSucursal" HeaderText="Id Sucursal" />
                                            <asp:BoundField DataField="Descripcion" HeaderText="Descripcion" />
                                            <asp:BoundField DataField="ZonaFiscal" HeaderText="Zona Fiscal" />
                                            <asp:TemplateField HeaderText="Editar">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="imgEliminarZona" runat="server" ImageUrl="~/Imagenes/eliminar.png"
                                                        ToolTip="Borrar" CommandName="Borrar" CommandArgument='<%# Eval("IdSucursal") %>' OnClientClick="javascript: return confirm('Seguro que desea eliminar ?');" />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <asp:Button ID="cancelar" runat="server" Text="Cancelar" CssClass="btn btn-primary" CausesValidation="False" OnClick="cancelar_Click" />
                            <asp:Button runat="server" class="btn btn-primary btnGuardar" Text="Guardar" ID="btnGuardarProv" OnClick="btnGuardarProv_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <script>


        $.validator.addMethod("notNoneBanco", function (value, element, param) {
            if (value == '0')
                return false;
            else
                return true;
        }, "Seleccionar Banco.");


        $.validator.addMethod("notNoneSujetoImpExp", function (value, element, param) {
            if (value == '0')
                return false;
            else
                return true;
        }, "Seleccionar Sujeto IMP/EMP.");



        $.validator.addMethod("notNoneNacionalidad", function (value, element, param) {
            if (value == '0')
                return false;
            else
                return true;
        }, "Seleccionar Nacionalidad.");

        $.validator.addMethod("notNoneSujeto", function (value, element, param) {
            if (value == '0')
                return false;
            else
                return true;
        }, "Seleccionar Sujeto Control IMP/EXP.");

        $.validator.addMethod("notNoneEstado", function (value, element, param) {
            if (value == '0')
                return false;
            else
                return true;
        }, "Seleccionar Estado.");

        $.validator.addMethod("notNoneTipoProveedor", function (value, element, param) {
            if (value == '0')
                return false;
            else
                return true;
        }, "Seleccionar Tipo de Proveedor.");

        $.validator.addMethod("notNoneNacionalidad", function (value, element, param) {
            if (value == '0')
                return false;
            else
                return true;
        }, "Seleccionar Nacionalidad.");



        $.validator.addMethod("notNoneAuxiliarContable", function (value, element, param) {
            if (value == '0')
                return false;
            else
                return true;
        }, "Seleccionar Auxiliar Contable.");

        $.validator.addMethod("notNoneAuxiliarContableCC", function (value, element, param) {
            if (value == '0')
                return false;
            else
                return true;
        }, "Seleccionar Auxiliar Contable CC.");

        $('#forma').validate({
            rules: {

                <%=Nombre.UniqueID %>: {
                required: true
                },
                <%=RFC.UniqueID %>: {
                    required: true
                },
                <%=Banco.UniqueID %>: {
                    notNoneBanco: true
                },
                <%=Estado.UniqueID %>: {
                    notNoneEstado: true
                },
                <%=Calle.UniqueID %>:{
                    required: true
                },
                <%=Colonia.UniqueID %>:{
                    required: true
                },
                <%=Municipio.UniqueID %>:{
                    required: true
                },
                <%=CP.UniqueID %>:{
                    required: true
                },
                <%=Telefono.UniqueID %>:{
                    required: true
                },
                <%=Correo.UniqueID %>:{
                    required: true
                },
                <%=TipoProveedor.UniqueID%>: {
                    notNoneTipoProveedor: true
                },
                <%=AuxiliarContable.UniqueID%>: {
                    notNoneAuxiliarContable: true
                },
                <%=AuxiliarContableCC.UniqueID%>: {
                    notNoneAuxiliarContableCC: true
                },
                <%=Nacionalidad.UniqueID%>: {
                    notNoneNacionalidad: true
                },
                <%=SujetoImpExp.UniqueID%>: {
                    notNoneNacionalidad: true
                },
            }, 
            messages: {

                <%=Nombre.UniqueID %>: {
                    required: "Campo Nombre requerido"
                },
                <%=RFC.UniqueID %>: {
                    required: "Campo RFC requerido"
                },
                <%=Banco.UniqueID %>: {
                    required: "Campo Banco requerido"
                },
                <%=Estado.UniqueID %>: {
                    required: "Campo Estado requerido"
                },
                <%=Calle.UniqueID %>:{
                    required: "Campo Calle requerido"
                },
                <%=Colonia.UniqueID %>:{
                    required: "Campo Colonia requerido"
                },
                <%=Municipio.UniqueID %>:{
                    required: "Campo Municipio requerido"
                },
                <%=CP.UniqueID %>:{
                    required: "Campo CP requerido"
                },
                <%=Telefono.UniqueID %>:{
                    required: "Campo Teléfono requerido"
                },
                <%=Correo.UniqueID %>:{
                    required: "Campo Correo Electrónico requerido"
                },
                <%=TipoProveedor.UniqueID%>: {
                    required: "Campo Tipo de Proveedor requerido"
                },
                <%=AuxiliarContable.UniqueID%>: {
                    required: "Campo Auxiliar Contable requerido"
                },
                <%=AuxiliarContableCC.UniqueID%>: {
                    required: "Campo Auxiliar Contable CC requerido"
                },
                <%=Nacionalidad.UniqueID%>: {
                    required: "Campo Nacionalidad requerido"
                },
                <%=SujetoImpExp.UniqueID%>: {
                    required: "Campo Impuesto Exportación requerido"
                },
            }
        });




        $(document).ready(function () {

            $('#TipoProveedor').change(function () {
                var id = $('#TipoProveedor').val();
                var idusuario = '<%=Session["iIdUsuario"].ToString() %>';

                if (!id) {
                    id = 0;
                } else {
                    id = parseInt(id);
                }

                if (!idusuario) {
                    idusuario = 0;
                } else {
                    idusuario = parseInt(idusuario);
                }
                var model = {
                    'id': id,
                    'IdUsuario': idusuario
                }

                $.ajax({
                    url: 'GestionProveedores.aspx/TipoProveedorSeleccionado',
                    type: 'POST',
                    data: JSON.stringify(model),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $('#RetIva').val(response.d);
                    }
                })
            });

            $('#AuxiliarContable').change(function () {
                var id = $('#AuxiliarContable').val();
                var idusuario = '<%=Session["iIdUsuario"].ToString() %>';
                if (!idusuario) {
                    idusuario = 0;
                } else {
                    idusuario = parseInt(idusuario);
                }
                var model = {
                    'id': id,
                    'IdUsuario': idusuario
                }

                $.ajax({
                    url: 'GestionClientes.aspx/AuxiliarContableSeleccionado',
                    type: 'POST',
                    data: JSON.stringify(model),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $('#Auxiliar').val(response.d);
                    }
                })
            });

            $('#AuxiliarContableCC').change(function () {
                var id = $('#AuxiliarContableCC').val();
                var idusuario = '<%=Session["iIdUsuario"].ToString() %>';
                if (!idusuario) {
                    idusuario = 0;
                } else {
                    idusuario = parseInt(idusuario);
                }
                var model = {
                    'id': id,
                    'IdUsuario': idusuario
                }

                $.ajax({
                    url: 'GestionClientes.aspx/AuxiliarContableSeleccionado',
                    type: 'POST',
                    data: JSON.stringify(model),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        $('#AuxiliarCC').val(response.d);
                    }
                })
            });


            $('#btnAgregar, #cancelar').attr("style", "float:right");

            $("input[type=text]").keyup(function () {
                $(this).val($(this).val().toUpperCase());
            });
            $("#Correo").keyup(function () {
                $(this).val($(this).val().toLowerCase());
            });

            $('#NumDistribuidor, #Telefono, #Telefono2, #Fax').mask("0000000000");
            $('#NumDistribuidor').mask("0000");
            $('#Telefono, #Telefono2, #Fax').mask("0000000000");
            $('#CP').mask("00000");
            $('#CtaCheques').mask("000000000000000000");
            $('#RetIsr, #DiasCredito').mask("000");
            $('#SaldoCuenta').mask("#,##0.00", { reverse: true });
            $('#RFC').mask("AAAA00000AAAA");

        })

    </script>


</body>
</html>
