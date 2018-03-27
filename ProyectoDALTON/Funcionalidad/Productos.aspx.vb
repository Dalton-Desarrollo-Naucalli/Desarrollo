Imports WsSeguridad
Imports DevExpress.Web
Imports System.Data.SqlClient
Imports System.Data
Imports Microsoft.VisualBasic
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Windows.Forms
Imports System.Collections.Specialized

Partial Class Funcionalidad_Productos
    Inherits System.Web.UI.Page
    Private Servicio As New WsSeguridad.Seguridad
    Public vSistema As String = System.Configuration.ConfigurationManager.AppSettings.Item("sistema")
    Public vEmpresa As String = System.Configuration.ConfigurationManager.AppSettings.Item("empresa")
#Region "Variables Globales"
    Dim ColumnaGrid As New GridViewCommandColumn
    Dim ColumnaGridGL As New GridViewDataTextColumn
    Dim ColumnaCombo As New GridViewDataComboBoxColumn
    Dim ColumnaCombo2 As New GridViewDataComboBoxColumn

    Dim cadena As String = "", consulta As String = "", Resultado As String = "", cat As String = "", pseudo As String, Errpseudo As String = "", colum As String = ""
    Dim NumeroColumnas As Integer = 0, NumeroRenglones As Integer = 0
    Dim vNombreColumna As Object, vfieldName As Object

    Dim DSTipoDato As New DataSet
    Dim dtTipoDato As DataTable
    Dim dtOpciones As DataTable
    Dim drOpciones As DataRow

    Dim DS As New DataSet
    Dim fncion As New WsFuncionalidad.Funcionalidad
    Dim fnc As New WsFuncionalidad.Funcionalidad

    Dim ColumnaGridt As New GridViewDataTextColumn ' PARA EL TEXTO (ENCABEZADO) EN EL GRID
    Dim tabla As New DataSet()

    Dim campo As Boolean
    Dim BanderaInsUpd As Integer = 0
    Dim idproveedor As String
    Dim idnew_Global As String

#End Region
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'Variable de Sesión
            If Session("sCliente") Is Nothing Then
                Response.Buffer = True
                Response.Clear()
                Response.Redirect("../Framework/Acceso.aspx")
            End If
            VerificaAccesos("Productos")

            'Carga función Configura Grid Producto-Proveedor
            ConfiguraGridProdProv()

            'Habilita Botones Encabezado.
            HabBotonesPrinc()

            'Carga Función LlenarBusqueda en el Glookup
            glBusqueda.Columns.Clear()
            LlenarBusqueda()

            'Función Carga combos independientes en el Form.
            LlenaCombos()
        Else
            LlenarBusqueda()
            ConfiguraGridProdProv()

        End If
    End Sub
    Protected Sub Page_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit
        DevExpress.Web.ASPxWebControl.GlobalTheme = Session("TemaDin")
    End Sub

#Region "Botones AGREGA,EDITA,CANCELA"
    Protected Sub cbActualizar_Callback(source As Object, e As CallbackEventArgs) Handles cbActualizar.Callback
        ValidaControles()
        CargaCallback()
    End Sub
    Protected Sub cbEliminar_Callback(source As Object, e As CallbackEventArgs) Handles cbEliminar.Callback
        'Variables
        Dim id As Int32
        id = Convert.ToInt32(txtNoProducto.Text)

        'Envía parámetros a SP "Spu_UtilDelete"
        Resultado = fnc.Fun_Elimina(50, id, 1, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
        If Resultado = "0" Then
            cbEliminar.JSProperties("cpAccionE") = "Registro eliminado con éxito."
            cbEliminar.JSProperties("cpClear") = "0"
        Else
            cbEliminar.JSProperties("cpClear") = "1"
        End If

    End Sub
#End Region

#Region "Funciones"
    Private Sub HabBotonesPrinc()
        'Éste método Activa Boton Agregar y desactiva los demás botones.

        btnAgregar.ClientEnabled = True
        btnEditar.ClientEnabled = False
        btnEliminar.ClientEnabled = False
        btnCancelar.ClientEnabled = False
        btnActualizar.ClientEnabled = False

    End Sub
    Public Sub LlenarBusqueda()
        'Este método llena el Gridlookup de Búsqueda mediante WS.
        glBusqueda.Columns.Clear()
        tabla = fnc.TraeDatosConsulta("SELECT * FROM producto WHERE borradoLogico = 0", "ConexionDBS")


        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColumnas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGridt = New GridViewDataTextColumn
                    ColumnaGridt.Caption = vNombreColumna


                    If ColumnaGridt.Caption = "prod_id" Then
                        ColumnaGridt.Caption = "Id Producto"
                        ColumnaGridt.ReadOnly = True
                        ColumnaGridt.Visible = True
                        ColumnaGridt.Width = 50
                    ElseIf ColumnaGridt.Caption = "desc_corta" Then
                        ColumnaGridt.Caption = "Descripción Corta"
                        ColumnaGridt.Visible = True
                    Else
                        ColumnaGridt.Visible = False
                    End If
                    ColumnaGridt.FieldName = vfieldName
                    Me.glBusqueda.Columns.Add(ColumnaGridt)
                Next
            End If
        End If
        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                glBusqueda.DataSource = tabla
                glBusqueda.DataBind()
            End If

        End If


    End Sub
    Public Sub VerificaAccesos(ByVal txtFormulario As Object)
        'Éste método es para validar los Accesos del Módulo de Seguridad con la variable de Sesión.
        Dim DsAccesos As New DataSet
        Dim dtAccesos As DataTable
        Dim drAccesos As DataRow
        Dim vRenglon As Int32 = 0
        DsAccesos = Servicio.OpVerificaAccesosFormulario(Session("sUsuario"), Session("iIdUsuario"), txtFormulario, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
        dtAccesos = DsAccesos.Tables("Accesos")
        Dim txtAcceso As Object
        Dim txtAccesosUsuario As String = ""

        If DsAccesos.Tables.Count > 0 Then
            If DsAccesos.Tables(0).Rows.Count > 0 Then
                For Each drAccesos In dtAccesos.Rows
                    txtAcceso = DsAccesos.Tables("Accesos").Rows(vRenglon)("nombre").ToString.Trim

                    ColumnaGrid.FixedStyle = GridViewColumnFixedStyle.Left
                    If tabla.Tables.Count > 0 Then
                        If txtAcceso = "AGREGAR" Then
                            If txtAcceso <> "" Then
                                ColumnaGrid.ShowNewButtonInHeader = True
                            End If
                        End If
                        If txtAcceso = "EDITAR" Then
                            ColumnaGrid.ShowEditButton = True
                        End If

                        If txtAcceso = "ELIMINAR" Then
                            ColumnaGrid.ShowDeleteButton = True
                        End If
                    Else
                    End If

                    vRenglon = vRenglon + 1
                    txtAccesosUsuario = txtAccesosUsuario & txtAcceso & "-"

                    Me.lblAccesos.Text = txtAccesosUsuario
                Next drAccesos
            Else
                Me.lblAccesos.Text = "Su usuario no tiene acceso a este formaulario..."
                Response.Buffer = True
                Response.Clear()
                Response.Redirect("../Framework/Acceso.aspx")
                Response.Redirect("../Framework/Acceso.aspx")
            End If
        End If
    End Sub
    Private Sub LlenaCombos()
        'Éste método carga los combos de cada tabla independientes en el formulario mediante un DS.

        'Se llena el combo de Categoría
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreC union all Select cat_id as ID, nombre as NombreC from categoria where BorradoLogico = 0 order by NombreC", "ConexionDBS")
        'Combo Categoría
        Me.cmbCategoria.DataSource = DS
        Me.cmbCategoria.ValueField = "ID"
        Me.cmbCategoria.TextField = "NombreC"
        Me.cmbCategoria.DataBind()
        Me.cmbMarca.SelectedIndex = 0

        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreM union all Select marca_id as ID, nombre as NombreM from marca where BorradoLogico = 0 order by NombreM", "ConexionDBS")
        'Combo Marca
        Me.cmbMarca.DataSource = DS
        Me.cmbMarca.ValueField = "ID"
        Me.cmbMarca.TextField = "NombreM"
        Me.cmbMarca.DataBind()
        Me.cmbMarca.SelectedIndex = 0

        'Se llena el combo Modelo
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreMd union all Select mod_id as ID, descripcion_mod as NombreMd from modelos where BorradoLogico = 0 order by NombreMd", "ConexionDBS")
        'Combo Modelo
        Me.cmbModelo.DataSource = DS
        Me.cmbModelo.ValueField = "ID"
        Me.cmbModelo.TextField = "NombreMd"
        Me.cmbModelo.DataBind()
        Me.cmbMarca.SelectedIndex = 0

        'Se llena el combo Unidad de Medida
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreU union all Select unidades_cons as ID, nombre_largo as NombreU from unidades where BorradoLogico = 0 order by NombreU", "ConexionDBS")
        'Combo Unidad de Medida
        Me.cmbUnidadDeMedida.DataSource = DS
        Me.cmbUnidadDeMedida.ValueField = "ID"
        Me.cmbUnidadDeMedida.TextField = "NombreU"
        Me.cmbUnidadDeMedida.DataBind()
        Me.cmbMarca.SelectedIndex = 0

        'Se llena el combo Capa de Depreciación
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreCp union all Select ID_capas as ID, str(porcentaje) as NombreCp from capas where BorradoLogico = 0 order by NombreCp", "ConexionDBS")
        'Combo Capa de Depreciación
        Me.cmbCapaDepreciacion.DataSource = DS
        Me.cmbCapaDepreciacion.ValueField = "ID"
        Me.cmbCapaDepreciacion.TextField = "NombreCp"
        Me.cmbCapaDepreciacion.DataBind()
        Me.cmbMarca.SelectedIndex = 0

        'Se llena el combo Clases
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreCl union all Select ID_clase as ID, nombre as NombreCl from clase where BorradoLogico = 0 order by NombreCl", "ConexionDBS")
        'Combo Clases
        Me.cmbClase.DataSource = DS
        Me.cmbClase.ValueField = "ID"
        Me.cmbClase.TextField = "NombreCl"
        Me.cmbClase.DataBind()
        Me.cmbClase.SelectedIndex = 0

        'Se llena el combo Conceptos
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreCo union all Select id_tipogasto as ID, descripcion as NombreCo from conceptos_gastos where BorradoLogico = 0 order by NombreCo", "ConexionDBS")
        'Combo Conceptos
        Me.cmbConcepto.DataSource = DS
        Me.cmbConcepto.ValueField = "ID"
        Me.cmbConcepto.TextField = "NombreCo"
        Me.cmbConcepto.DataBind()
        Me.cmbConcepto.SelectedIndex = 0

        'Se llena el combo Clasific. Arancelaria
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreCA union all Select Cve_arancel as ID, Descripcion as NombreCA from Clasificacion_arancelaria where BorradoLogico = 0 order by NombreCA", "ConexionDBS")
        'Combo Clasific. Arancelaria
        Me.cmbClasificacionArancelaria.DataSource = DS
        Me.cmbClasificacionArancelaria.ValueField = "ID"
        Me.cmbClasificacionArancelaria.TextField = "NombreCA"
        Me.cmbClasificacionArancelaria.DataBind()
        Me.cmbClasificacionArancelaria.SelectedIndex = 0

        'Se llena el combo Moneda Precio Venta
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreMn union all Select moneda_id as ID, nombre as NombreMn from moneda where BorradoLogico = 0 order by NombreMn", "ConexionDBS")
        'Combo Moneda Precio Venta
        Me.cmbMonedaPrecioVenta.DataSource = DS
        Me.cmbMonedaPrecioVenta.ValueField = "ID"
        Me.cmbMonedaPrecioVenta.TextField = "NombreMn"
        Me.cmbMonedaPrecioVenta.DataBind()
        Me.cmbMonedaPrecioVenta.SelectedIndex = 0

    End Sub
    Private Sub CargaCallback()
        'Variables
        Dim dato As String = ""
        Dim id As Int32
        'Declara la variable FVIg para el uso en la cadena de la fecha. Si el control trae vacío el texto, pone la variable como NULL,
        'De lo contrario le agrega el valor y Formato correcto para formar correctamente la cadena.
        Dim FVig As String
        If txtVigenciaPrecio.Text = "" Then
            FVig = "NULL"
        Else
            Dim FechaVigencia As DateTime = Convert.ToDateTime(txtVigenciaPrecio.Text)
            FVig = FechaVigencia.ToString("yyyy/MM/dd")
        End If

        cat = Convert.ToString(glBusqueda.Value())
        Dim R() As String
        Dim R2() As String
        'Dim ValidaCadena() As String
        dato = Convert.ToString(txtDescripcionCorta.Text.Trim())

        'CONCATENA LOS CONTROLES DEL FORMULARIO 
        cadena =
            cmbClase.Value + "|" +
            cmbConcepto.Value + "|" +
            cmbMarca.Value + "|" +
            cmbCategoria.Value + "|" +
            cmbModelo.Value + "|" +
            txtDescripcionCorta.Text + "|" +
            txtDescripcionsintetica.Text + "|" +
            txtDescripcionCompleta.Text + "|" +
            "0" + "|" +
            "2017/01/01" + "|" +
            "0" + "|" +
            "2017/01/01" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "1" + "|" +
            cmbTipoDeProducto.Value + "|" +
            rbtnIndividualizable.Value + "|" +
            "NULL" + "|" +
            cmbCapaDepreciacion.Value + "|" +
            cmbTipoManejoInventario.Value + "|" +
            cmbUnidadDeMedida.Value + "|" +
            cmbValuacionInventario.Value + "|" +
            cmbTipoDeComision.Value + "|" +
            txtValor.Text + "|" +
            cmbClasificacionArancelaria.Value + "|" +
            rbtnOrigen.Value + "|" +
            txtMaxCostoIndirecto.Text + "|" +
            txtMaxPrecioCompra.Text + "|" +
            txtExistenciaMin.Text + "|" +
            txtExistenciaMax.Text + "|" +
            txtNumeroDeParte.Text + "|" +
            cmbMonedaPrecioVenta.Value + "|" +
            txtPrecioMinVenta.Text + "|" +
            FVig + "|" +
            txtCodigoFabricante.Text + "|" +
            txtPrecioPubico.Text + "|" +
                "NULL" + "|" +
                "2017/01/01" + "|" +
                "NULL" + "|" +
                "NULL" + "|" +
                "0" + "|" +
                "NULL"

        'Validación ACTUALIZA DATOS
        If (btnAgregar.Checked = False) And (btnEditar.Checked = True) Then
            id = Convert.ToInt32(txtNoProducto.Text)
            Resultado = fnc.Fun_Edita(50, cadena, id, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            R = Resultado.Split("|")

            If R(0) = "50000" Then 'Valida número parte de otro producto.
                cbActualizar.JSProperties("cpAccion") = "El número de parte que estás intentando actualizar ya está asignado a otro Producto."
            Else
                cbActualizar.JSProperties("cpAccion") = "Registro actualizado con éxito."
            End If

            'Validación INSERTA DATOS
        ElseIf (btnAgregar.Checked = True) And (btnEditar.Checked = False) Then
            Resultado = fnc.Fun_Nuevo(50, cadena, 7, dato, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")

            If R2(0) = "50000" Then 'Valida Número de Parte.
                cbActualizar.JSProperties("cpAccion") = "El número de parte que estás intentando insertar ya está asignado a otro Producto."
            ElseIf R2(0) = "2627" Then 'Valida Error 2627 | Descripción Corta del Producto.
                cbActualizar.JSProperties("cpAccion") = "La descripción corta ya existe."
            ElseIf R2(0) <> "0" Then 'Valida cualquier error distinto a cero.
                cbActualizar.JSProperties("cpAccion") = Resultado
            Else
                cbActualizar.JSProperties("cpAccion") = "Registro insertado correctamente" 'Inserta correctamente.
                cbActualizar.JSProperties("cpIDProd") = R2(1) 'Pasa el nuevo ID a la caja de Texto del Producto.
                idnew_Global = R2(1) 'Iguala el nuevo ID a la Variable Global.
            End If
        End If
    End Sub
    Public Sub ValidaControles()
        'Valida todos los controles del RoundPanel, lo que viene vacío lo iguala a NULL.
        Dim Control As UI.Control
        For Each Control In ASPxRoundPanel2.Controls
            If Control.[GetType]() = GetType(ASPxTextBox) Then
                Dim txt As ASPxTextBox = CType(Control, ASPxTextBox)
                If txt.Text = "" Then
                    txt.Text = "NULL"
                End If
            ElseIf Control.[GetType]() = GetType(ASPxComboBox) Then
                Dim cmb As ASPxComboBox = CType(Control, ASPxComboBox)
                If cmb.Text = "" Then
                    cmb.Value = "NULL"
                End If
            ElseIf Control.[GetType]() = GetType(ASPxRadioButtonList) Then
                Dim rbtl As ASPxRadioButtonList = CType(Control, ASPxRadioButtonList)
                If rbtl.Value = "" Then
                    rbtl.Value = "NULL"
                End If
            ElseIf Control.[GetType]() = GetType(ASPxDateEdit) Then
                    Dim dateedit As ASPxDateEdit = CType(Control, ASPxDateEdit)
                If dateedit.Text = "" Then
                    dateedit.Text = "NULL"
                End If
            End If
        Next Control

    End Sub
#End Region

#Region "Grid, Otros Controles"
    Private Sub ConfiguraGridProdProv()
        'Este método configura el Grid Producto-Proveedor (pasa ID de producto a otra tabla).
        Dim prod_id As String = ""
        GVProdProv.Columns.Clear()
        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim DS As DataSet
        DS = New DataSet
        'Si la variable global viene Vacía, entonces se da valor a la variable prod_id de lo que traiga el Gridlookup de Búsqueda,
        'De lo contrario le asigna lo que trae la variable Global a la variable prod_id y le pone el ID nuevo a la caja de Texto txtNoProducto.
        If idnew_Global = Nothing Then
            prod_id = Convert.ToString(glBusqueda.Value())
        Else
            prod_id = idnew_Global
            GVProdProv.JSProperties("cpIDProd") = idnew_Global
        End If


        If prod_id = "" Then
            consulta = "SELECT prod_id,prov_id,moneda_id,p1,precio_compra FROM prov_prod WHERE prod_id = -1 "
            tabla = fnc.TraeDatosConsulta(consulta, "ConexionDBS")
            dtOpciones = tabla.Tables("Table")
        Else
            consulta = "SELECT prod_id,prov_id,moneda_id,p1,precio_compra FROM prov_prod WHERE prod_id = " + prod_id
            tabla = fnc.TraeDatosConsulta(consulta, "ConexionDBS")
            dtOpciones = tabla.Tables("Table")
        End If

        VerificaAccesos("Productos")

        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColumnas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1
                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGridGL = New GridViewDataTextColumn
                    ColumnaGridGL.Caption = vNombreColumna
                    If ColumnaGridGL.Caption = "prod_id" Then
                        ColumnaGridGL.Visible = False
                    Else
                        ColumnaGridGL.Caption = fnc.ObtenEtiquetaCatCampos(vNombreColumna, 52, "ConexionDBS")
                    End If

                    If vNombreColumna = "prov_id" Then
                        ColumnaGridGL.Visible = False
                        DS = fnc.TraeDatosConsulta("SELECT [prov_id], [nombre] FROM [proveedor] WHERE [BorradoLogico] = 0", "ConexionDBS")
                        ColumnaCombo.FieldName = "prov_id"
                        ColumnaCombo.Caption = "PROVEEDOR"
                        ColumnaCombo.ShowInCustomizationForm = True
                        ColumnaCombo.VisibleIndex = "0"
                        ColumnaCombo.PropertiesComboBox.DataSource = DS
                        ColumnaCombo.PropertiesComboBox.TextField = "nombre"
                        ColumnaCombo.PropertiesComboBox.ValueField = "prov_id"
                        GVProdProv.Columns.Add(ColumnaCombo)
                    End If

                    If ColumnaGridGL.Caption = "prod_id" Then
                        ColumnaGridGL.ReadOnly = True
                        ColumnaGridGL.VisibleIndex = "1"
                        ColumnaGridGL.Visible = False
                    End If

                    If vNombreColumna = "moneda_id" Then
                        ColumnaGridGL.Visible = False
                        DS = fnc.TraeDatosConsulta("SELECT [moneda_id], [nombre] FROM [moneda] WHERE [BorradoLogico] = 0", "ConexionDBS")
                        ColumnaCombo2.FieldName = "moneda_id"
                        ColumnaCombo2.Caption = "MONEDA"
                        ColumnaCombo2.ShowInCustomizationForm = True
                        ColumnaCombo2.VisibleIndex = "2"
                        ColumnaCombo2.PropertiesComboBox.DataSource = DS
                        ColumnaCombo2.PropertiesComboBox.TextField = "nombre"
                        ColumnaCombo2.PropertiesComboBox.ValueField = "moneda_id"
                        GVProdProv.Columns.Add(ColumnaCombo2)
                    End If

                    If ColumnaGridGL.Caption = "moneda_id" Then
                        ColumnaGridGL.ReadOnly = True
                        ColumnaGridGL.VisibleIndex = "3"
                        ColumnaGridGL.Visible = False
                    End If
                    ColumnaGridGL.FieldName = vfieldName
                    GVProdProv.Columns.Add(ColumnaGridGL)
                Next
            Else
                If tabla.Tables.Count > 0 Then
                    If (tabla.Tables(0).Rows.Count > 0) Or (tabla.Tables(0).Rows.Count = 0) Then
                        NumeroColumnas = tabla.Tables(0).Columns.Count - 1
                        NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                        For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

                            vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                            vfieldName = tabla.Tables(0).Columns(j).ColumnName
                            ColumnaGridGL = New GridViewDataTextColumn
                            ColumnaGridGL.Caption = vNombreColumna
                            If ColumnaGridGL.Caption = "prod_id" Then
                                ColumnaGridGL.Visible = False
                            Else
                                ColumnaGridGL.Caption = fnc.ObtenEtiquetaCatCampos(vNombreColumna, 52, "ConexionDBS")
                            End If

                            If vNombreColumna = "prov_id" Then
                                ColumnaGridGL.Visible = False
                                DS = fnc.TraeDatosConsulta("SELECT [prov_id], [nombre] FROM [proveedor] WHERE [BorradoLogico] = 0", "ConexionDBS")
                                ColumnaCombo.FieldName = "prov_id"
                                ColumnaCombo.Caption = "PROVEEDOR"
                                ColumnaCombo.ShowInCustomizationForm = True
                                ColumnaCombo.VisibleIndex = "0"
                                ColumnaCombo.PropertiesComboBox.DataSource = DS
                                ColumnaCombo.PropertiesComboBox.TextField = "nombre"
                                ColumnaCombo.PropertiesComboBox.ValueField = "prov_id"
                                GVProdProv.Columns.Add(ColumnaCombo)
                            End If

                            If ColumnaGridGL.Caption = "prod_id" Then
                                ColumnaGridGL.ReadOnly = True
                                ColumnaGridGL.VisibleIndex = "1"
                                ColumnaGridGL.Visible = False
                            End If

                            If vNombreColumna = "moneda_id" Then
                                ColumnaGridGL.Visible = False
                                DS = fnc.TraeDatosConsulta("SELECT [moneda_id], [nombre] FROM [moneda] WHERE [BorradoLogico] = 0", "ConexionDBS")
                                ColumnaCombo2.FieldName = "moneda_id"
                                ColumnaCombo2.Caption = "MONEDA"
                                ColumnaCombo2.ShowInCustomizationForm = True
                                ColumnaCombo2.VisibleIndex = "2"
                                ColumnaCombo2.PropertiesComboBox.DataSource = DS
                                ColumnaCombo2.PropertiesComboBox.TextField = "nombre"
                                ColumnaCombo2.PropertiesComboBox.ValueField = "moneda_id"
                                GVProdProv.Columns.Add(ColumnaCombo2)
                            End If

                            If ColumnaGridGL.Caption = "moneda_id" Then
                                ColumnaGridGL.ReadOnly = True
                                ColumnaGridGL.VisibleIndex = "3"
                                ColumnaGridGL.Visible = False
                            End If
                            ColumnaGridGL.ReadOnly = False
                            ColumnaGridGL.FieldName = vfieldName
                            GVProdProv.Columns.Add(ColumnaGridGL)
                        Next
                    End If
                End If
            End If
        End If
        If tabla.Tables.Count > 0 Then
            If (tabla.Tables(0).Rows.Count > 0) Or (tabla.Tables(0).Rows.Count = 0) Then
                GVProdProv.DataSource = tabla
                GVProdProv.DataBind()
                GVProdProv.Columns.Add(ColumnaGrid)
            End If
        End If
    End Sub
    Protected Sub GVProdProv_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs) Handles GVProdProv.CustomCallback
        If e.Parameters.Equals("Actualizar") Then
            ConfiguraGridProdProv()
            'LlenaGrid() ' esta comentado
        End If
    End Sub
#End Region

#Region "BatchUpdate"

    Protected ReadOnly Property GridData As List(Of GridDataItem)
        Get
            Dim key = "34FAA454-CF92-4882-9401-93F6AAE81277"
            If Not IsPostBack OrElse Session(key) Is Nothing Then Session(key) = Enumerable.Range(0, 3000).[Select](Function(i) New GridDataItem With
                {.id = Convert.ToInt32(i),
                 .prov_id = 0,
                 .moneda_id = 0,
                 .p1 = 0,
                 .precio_compra = 0
            }).ToList()
            Return CType(Session(key), List(Of GridDataItem))
        End Get
    End Property
    Public Class GridDataItem
        Public Property id As Integer
        Public Property prov_id As Integer
        Public Property moneda_id As Integer
        Public Property p1 As Integer
        Public Property precio_compra As Integer
    End Class
    Protected Function InsertNewItem(ByVal newValues As OrderedDictionary) As GridDataItem
        BanderaInsUpd = 1
        Dim item = New GridDataItem()
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Function UpdateItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
        Dim idProv = Convert.ToInt16(keys("prov_id"))
        idproveedor = idProv
        Dim item = GridData.First(Function(i) i.id = idProv)
        BanderaInsUpd = 2
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Function DeleteItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
        Dim idProv = Convert.ToInt16(keys("prov_id"))
        idproveedor = idProv
        Dim item = GridData.First(Function(i) i.id = idProv)
        BanderaInsUpd = 3
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Sub GVProdProv_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs) Handles GVProdProv.BatchUpdate
        'Si la caja de Texto viene vacía, entonces entra a validar todos Controles del RoundPanel, y luego al Callback de Inserción/Actualización.
        If txtNoProducto.Text = Nothing Then
            ValidaControles()
            CargaCallback()
        End If
        For Each args In e.InsertValues
            InsertNewItem(args.NewValues)
        Next
        For Each args In e.UpdateValues
            UpdateItem(args.Keys, args.NewValues)
        Next
        For Each args In e.DeleteValues
            DeleteItem(args.Keys, args.Keys)
        Next
        e.Handled = True
        Me.GVProdProv.DataSource = Nothing
        Me.GVProdProv.DataBind()
        Me.GVProdProv.Selection.UnselectAll()
        Me.GVProdProv.CancelEdit()
        Me.GVProdProv.FocusedRowIndex = -1
        ConfiguraGridProdProv()

    End Sub
    Protected Sub LoadNewValues(ByVal item As GridDataItem, ByVal values As OrderedDictionary, ByVal Optional bandera As Integer = 0)

        Dim cat As String = ""
        Dim llaves As String = ""
        Dim llaves2 As String = ""
        Dim R() As String
        Dim R2() As String
        Dim IDControl As String

        'Si la variable global viene vacía, entonces iguala la variable IDControl a lo que trae la caja de Texto y lo toma como Item para el Grid, 
        'De lo contrario, le asigna el valor que trae la variable Global.
        If idnew_Global = Nothing Then
            IDControl = txtNoProducto.Text
        Else
            IDControl = idnew_Global
        End If


        item.id = IDControl
        item.prov_id = Convert.ToInt16(values("prov_id"))
        item.moneda_id = Convert.ToInt16(values("moneda_id"))
        item.p1 = Convert.ToInt16(values("p1"))
        item.precio_compra = Convert.ToInt16(values("precio_compra"))

        Dim id = item.id
        Dim prov_id = item.prov_id
        Dim moneda_id = item.moneda_id
        Dim p1 = item.p1
        Dim precio_compra = item.precio_compra
        Dim nomcon As String = "ConexionDBS"

        cadena =
                    moneda_id.ToString() + "|" +
                    "1" + "|" +
                    "2" + "|" +
                    txtPrecioMinVenta.Text + "|" +
                    precio_compra.ToString() + "|" +
                    "4" + "|" +
                    "5" + "|" +
                    "2018/01/01" + "|" +
                    txtNumeroDeParte.Text + "|" +
                    "NULL" + "|" +
                    "NULL" + "|" +
                    p1.ToString() + "|" +
                    "11" + "|" +
                    "12" + "|" +
                    "0" + "|" +
                    "NULL"

        llaves = id.ToString() + "|" + prov_id.ToString()


            'Inserta Registro.
            If bandera = 1 Then

            Resultado = fnc.Grid_Alta(52, cadena, llaves, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            R = Resultado.Split("|")
            If R(0) = 0 Then
                GVProdProv.JSProperties("cpAccion") = "Registro Insertado con éxito."
                'GVProdProv.JSProperties("cpnewId") = idnew_Global

            Else
                GVProdProv.JSProperties("cpAccion") = Resultado
            End If

            'Actualiza Registro.
        ElseIf bandera = 2 Then
                llaves2 = id.ToString() + "|" + idproveedor.ToString()
            Resultado = fnc.Grid_Alta(52, cadena, llaves, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")
                If R2(0) = 0 Then
                Resultado = fnc.Grid_Elimina(52, llaves2, 0, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
                If Resultado = "0" Then
                        GVProdProv.JSProperties("cpAccion") = "Registro actualizado con éxito."
                    Else
                        GVProdProv.JSProperties("cpAccion") = "Registro no actualizado."
                    End If

                Else
                    GVProdProv.JSProperties("cpAccion") = R2(0)
                End If
                'Elimina Registro.
            ElseIf bandera = 3 Then
                llaves2 = id.ToString() + "|" + idproveedor.ToString()
            Resultado = fnc.Grid_Elimina(52, llaves2, 0, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            If Resultado = "0" Then
                    GVProdProv.JSProperties("cpAccion") = "Registro eliminado con éxito."
                Else
                    GVProdProv.JSProperties("cpAccion") = Resultado
                End If
            End If

    End Sub

#End Region

End Class
