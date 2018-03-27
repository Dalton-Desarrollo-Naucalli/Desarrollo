<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GestionClientes.aspx.cs" Inherits="Framework_GestionClientes" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../Content/bootstrap.css" rel="stylesheet" />
    <script src="../Scripts/jquery-3.1.1.js"></script>
    <script src="../Scripts/bootstrap.min.js"></script>
    <script src="../Scripts/jquery.validate.js"></script>
    <script src="../Scripts/jquery.validate.min.js"></script>
    <script src="../Scripts/jquery.mask.js"></script>
    <title></title>
    <style>
        .inputLarge {
            max-width: 100% !important;
        }

        .error {
            color: red;
            display: inline-flex;
        }
    </style>
</head>
<body>
    <div class="row">
        <div class="col-md-12">
            <div class="form-group">
                <h1 class="page-header">Clientes</h1>
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
                                <asp:BoundField DataField="cliente_id" HeaderText="Clave Cliente" />
                                <asp:BoundField DataField="nombre" HeaderText="Cliente" />
                                <asp:BoundField DataField="tipo_Persona" HeaderText="Tipo de Cliente" />
                                <asp:TemplateField HeaderText="Editar">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imgGuardar" runat="server" ImageUrl="~/imagenes/editar.png"
                                            ToolTip="Editar" CommandName="Editar" CommandArgument='<%# Eval("cliente_id") %>' />
                                        <asp:ImageButton ID="imgEliminar" runat="server" ImageUrl="~/Imagenes/eliminar.png"
                                            ToolTip="Borrar" CommandName="Borrar" CommandArgument='<%# Eval("cliente_id") %>' OnClientClick="javascript: return confirm('Seguro que desea eliminar ?');" />
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
                            <div class="col-md-2">
                                <div class="form-group">
                                    <label class="control-label">Número de Cliente</label>
                                    <asp:TextBox ReadOnly="true" runat="server" ID="NumCliente" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-8">
                                <div class="form-group">
                                    <label class="control-label">Nombre   *</label>
                                    <asp:TextBox runat="server" ID="Nombre" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="form-group">
                                    <label class="control-label">RFC   *</label>
                                    <asp:TextBox runat="server" ID="RFC" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Tipo de Cliente   *</label>
                                    <asp:DropDownList CssClass="form-control inputLarge" runat="server" ID="TipoCliente"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Tipo de Persona   *</label>
                                    <asp:DropDownList CssClass="form-control inputLarge" runat="server" ID="TipoPersona"></asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Nacionalidad</label>
                                    <asp:DropDownList ID="Nacionalidad" runat="server" CssClass="form-control inputLarge"></asp:DropDownList>
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
                        </div>
                        <div class="row">
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
                                    <label class="control-label">Desglose IVA   *</label>
                                    <asp:DropDownList runat="server" CssClass="form-control inputLarge" ID="DesgloseIva"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Dirección WEB de la Empresa</label>
                                    <asp:TextBox runat="server" ID="DireccionWeb" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Grupo Empresarial</label>
                                    <asp:DropDownList runat="server" ID="GrupoEmpresarial" CssClass="form-control inputLarge"></asp:DropDownList>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Días de Revisión</label>
                                    <asp:TextBox runat="server" CssClass="form-control inputLarge" ID="DiasRevision"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Horario</label>
                                    <asp:TextBox runat="server" CssClass="form-control inputLarge" ID="HorarioRevision"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Días de Pago</label>
                                    <asp:TextBox runat="server" CssClass="form-control inputLarge" ID="DiasPago"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Horario</label>
                                    <asp:TextBox runat="server" CssClass="form-control inputLarge" ID="HorarioPago"></asp:TextBox>
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
                                    <label class="contrsol-label">Auxiliar Contable CC   *</label>
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
                    </div>
                </div>

                <div class="panel panel-default">
                    <div class="panel-heading">
                        <div class="panel-title">Contactos</div>
                    </div>
                    <div class="panel-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Nombre</label>
                                    <asp:DropDownList runat="server" CssClass="form-control inputLarge" ID="NombreContacto"></asp:DropDownList>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Puesto</label>
                                    <asp:TextBox runat="server" ValidationGroup="ContactoGrp" ID="txtPuesto" CssClass="form-control inputLarge"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="control-label">Relación</label>
                                    <asp:DropDownList ValidationGroup="ContactoGrp" runat="server" ID="ddlRelacion" CssClass="form-control inputLarge"></asp:DropDownList>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-3">
                                <div class="form-group">
                                    <br />
                                    <asp:Button runat="server" ValidationGroup="ContactoGrp" CssClass="btn btn-default" ID="btnContacto" Text="Agregar" OnClick="btnContacto_Click" />
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-8">
                                <div class="form-group">
                                    <asp:GridView ID="gvContactos" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                        GridLines="None" CssClass="table table-hover table-responsive table-bordered" OnRowCommand="gvContactos_RowCommand">
                                        <Columns>
                                            <asp:BoundField DataField="IdContacto" HeaderText="Id Contacto" />
                                            <asp:BoundField DataField="NombreContacto" HeaderText="Nombre" />
                                            <asp:BoundField DataField="Puesto" HeaderText="Puesto" />
                                            <asp:BoundField DataField="Relacion" HeaderText="Relación" />
                                            <asp:TemplateField HeaderText="Editar">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="imgEliminarContacto" runat="server" ImageUrl="~/Imagenes/eliminar.png"
                                                        ToolTip="Borrar" CommandName="Borrar" CommandArgument='<%# Eval("IdContacto") %>' OnClientClick="javascript: return confirm('Seguro que desea eliminar ?');" />
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



        $.validator.addMethod("notNoneTipoCliente", function (value, element, param) {
            if (value == '0')
                return false;
            else
                return true;
        }, "Seleccionar Tipo de Cliente.");

        $.validator.addMethod("notNoneTipoPersona", function (value, element, param) {
            if (value == '0')
                return false;
            else
                return true;
        }, "Seleccionar Tipo de Persona.");

        $.validator.addMethod("notNoneEstado", function (value, element, param) {
            if (value == '0')
                return false;
            else
                return true;
        }, "Seleccionar Estado.");

        $.validator.addMethod("notNoneIVA", function (value, element, param) {
            if (value == '0')
                return false;
            else
                return true;
        }, "Seleccionar Desgloce de IVA.");

        $.validator.addMethod("notNoneGrupoEmpresarial", function (value, element, param) {
            if (value == '0')
                return false;
            else
                return true;
        }, "Seleccionar Grupo Empresarial.");

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
                <%=TipoCliente.UniqueID %>: {
                    notNoneTipoCliente: true
                },
                <%=TipoPersona.UniqueID %>: {
                    notNoneTipoPersona: true
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
                <%=Estado.UniqueID %>:{
                    notNoneEstado: true
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
                <%=DesgloseIva.UniqueID %>:{
                    notNoneIVA: true
                },  
                <%=GrupoEmpresarial.UniqueID%>: {
                    notNoneGrupoEmpresarial:true
                },
                <%=AuxiliarContable.UniqueID%>: {
                    notNoneAuxiliarContable: true
                },
                <%=AuxiliarContableCC.UniqueID%>: {
                    notNoneAuxiliarContableCC: true
                },
            },
            messages: {
                <%=Nombre.UniqueID %>: {
                    required: "Campo Nombre requerido"
                },
                <%=RFC.UniqueID %>: {
                    required: "Campo RFC requerido"
                },
                <%=Calle.UniqueID %>:{
                    required: "Campo Domiciio requerido"
                },
                <%=Colonia.UniqueID %>:{
                    required: "Campo Colonia requerido"
                },
                <%=Municipio.UniqueID %>:{
                    required: "Campo Municipio requerido"
                },
                <%=Estado.UniqueID %>:{
                    required: "Campo Estado requerido"
                },
                <%=CP.UniqueID %>:{
                    required: "Campo CP requerido"
                },
                <%=Telefono.UniqueID %>:{
                    required: "Campo Teléfono requerido"
                },
                <%=Correo.UniqueID %>:{
                    required: "Campo Correo requerido"
                },
            },
        });



        $(document).ready(function () {
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

            $('#CP').mask('00000');
            $('#Telefono').mask('0000000000');
            $('#Telefono2').mask('0000000000');
            $('#Fax').mask('0000000000');
            $('#DiasPago').mask('AA-AA-AA-AA-AA');
            $('#DiasRevision').mask('AA-AA-AA-AA-AA');
            $('#RFC').mask("AAAA00000AAAA");

        })



    </script>


</body>
</html>
