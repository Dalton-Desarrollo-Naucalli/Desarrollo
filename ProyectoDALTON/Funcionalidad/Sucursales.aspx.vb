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

Partial Class Funcionalidad_Sucursales
    Inherits System.Web.UI.Page
    Private Servicio As New WsSeguridad.Seguridad
    Public vSistema As String = System.Configuration.ConfigurationManager.AppSettings.Item("sistema")
    Public vEmpresa As String = System.Configuration.ConfigurationManager.AppSettings.Item("empresa")

#Region "Variables Globales"
    Dim ColumnaGrid As New GridViewCommandColumn
    Dim ColumnaGridGL As New GridViewDataTextColumn
    Dim ColumnaCombo As New GridViewDataComboBoxColumn
    Dim ColumnaCombo2 As New GridViewDataComboBoxColumn

    Dim cadena As String = "", consulta As String = "", Resultado As String = "", cat As String = "", IdSucursalCS As String, colum As String = ""
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
    Dim IdOpcion As String
    Dim idnew_Global As String

#End Region

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        IdSucursalCS = Request.QueryString("IdSucursalCS")
        If Not Page.IsPostBack Then
            'Variable de Sesión
            If Session("sCliente") Is Nothing Then
                Response.Buffer = True
                Response.Clear()
                Response.Redirect("../Framework/Acceso.aspx")
            End If
            VerificaAccesos("Sucursales")

            'Carga función Configura Grid CCP
            ConfiguraGridCCP()

            'Habilita Botones Encabezado.
            HabBotonesPrinc()

            'Carga Función LlenarBusqueda en el Glookup
            glBusqueda.Columns.Clear()


            'If IdSucursalCS <> "" Then
            '    LlenarBusqueda()
            'Else
            LlenarBusqueda()
            'End If
            glBusqueda.Value = IdSucursalCS

            If IdSucursalCS <> "" Then
                LlenarFormParameter()
            End If

            'Función Carga combos independientes en el Form.
            LlenaCombos()
        Else
            LlenarBusqueda()
            ConfiguraGridCCP()

        End If
    End Sub

    Protected Sub Page_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit
        DevExpress.Web.ASPxWebControl.GlobalTheme = Session("TemaDin")
    End Sub

    Protected Sub cbActualizar_Callback(source As Object, e As CallbackEventArgs) Handles cbActualizar.Callback
        ValidaControles()
        CargaCallback()
    End Sub

    Protected Sub cbEliminar_Callback(source As Object, e As CallbackEventArgs) Handles cbEliminar.Callback
        'Variables
        Dim id As Int32
        id = Convert.ToInt32(txtNumSucursal.Text)

        'Envía parámetros a SP "Spu_UtilDelete"
        Resultado = fnc.Fun_Elimina(54, id, 1, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
        If Resultado = "0" Then
            cbEliminar.JSProperties("cpAccionE") = "Registro eliminado con éxito."
            cbEliminar.JSProperties("cpClear") = "0"
        Else
            cbEliminar.JSProperties("cpClear") = "1"
        End If

    End Sub

#Region "Funciones"
    Private Sub HabilitaBotonesS()
        'Éste método Activa Botones
        btnAgregar.ClientEnabled = True
        btnEditar.ClientEnabled = True
        btnEliminar.ClientEnabled = True
        btnCancelar.ClientEnabled = True
        btnActualizar.ClientEnabled = True
    End Sub
    Public Sub LlenarFormParameter()

        Dim script As String = "MuestraSucursales();"
        ScriptManager.RegisterStartupScript(Me, GetType(Page), "alerta", script, True)
        'ConfiguraGridCCP()
        HabilitaBotonesS()
    End Sub
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
        ' If IdSucursalCS <> "" Then
        'tabla = fnc.TraeDatosConsulta("SELECT * FROM modulo WHERE borradoLogico = 0 AND modulo_id = " + IdSucursalCS + "", "ConexionDBS")

        ' Else
        tabla = fnc.TraeDatosConsulta("SELECT * FROM modulo WHERE borradoLogico = 0", "ConexionDBS")
        'End If

        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColumnas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGridt = New GridViewDataTextColumn
                    ColumnaGridt.Caption = vNombreColumna


                    If ColumnaGridt.Caption = "modulo_id" Then
                        ColumnaGridt.Caption = "ID MÓDULO"
                        ColumnaGridt.ReadOnly = True
                        ColumnaGridt.Visible = True
                        ColumnaGridt.Width = 50
                    ElseIf ColumnaGridt.Caption = "nombre" Then
                        ColumnaGridt.Caption = "NOMBRE"
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
        Dim DS As DataSet
        DS = New DataSet
        Dim fncion = New WsFuncionalidad.Funcionalidad

        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as  NombreEf union all Select EntidadFed_ID as ID, Nombre  as NombreEf from Entidad_Federativa where borradoLogico = 0 order by NombreEf ", "ConexionDBS")

        Me.cmbEstado.DataSource = DS
        Me.cmbEstado.ValueField = "ID"
        Me.cmbEstado.TextField = "NombreEf"
        Me.cmbEstado.DataBind()
        Me.cmbEstado.SelectedIndex = 0

        'Se llena el combo de Centro de costos
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreP union all Select idproyecto as ID, nombre as NombreP from proyectos order by NombreP", "ConexionDBS")
        'Combo
        Me.cmbAreaRegion.DataSource = DS
        Me.cmbAreaRegion.ValueField = "ID"
        Me.cmbAreaRegion.TextField = "NombreP"
        Me.cmbAreaRegion.DataBind()
        Me.cmbAreaRegion.SelectedIndex = 0

        DS = fncion.TraeDatosConsulta("Select '  SELECCIONAR...' as ID, '  SELECCIONAR...' as NombreAu union all Select numerodecuenta as ID, descripcion as NombreAu from catcon order by NombreAu ", "ConexionGENDES")


        Me.cmbAuxiliarVentas.DataSource = DS
        Me.cmbAuxiliarVentas.ValueField = "ID"
        Me.cmbAuxiliarVentas.TextField = "ID"
        Me.cmbAuxiliarVentas.DataBind()
        Me.cmbAuxiliarVentas.SelectedIndex = 0

        Me.cmbDescAuxiliarVentas.DataSource = DS
        Me.cmbDescAuxiliarVentas.ValueField = "ID"
        Me.cmbDescAuxiliarVentas.TextField = "NombreAu"
        Me.cmbDescAuxiliarVentas.DataBind()
        Me.cmbDescAuxiliarVentas.SelectedIndex = 0


        Me.cmbAuxiliarDevoluciones.DataSource = DS
        Me.cmbAuxiliarDevoluciones.ValueField = "ID"
        Me.cmbAuxiliarDevoluciones.TextField = "ID"
        Me.cmbAuxiliarDevoluciones.DataBind()
        Me.cmbAuxiliarDevoluciones.SelectedIndex = 0

        Me.cmbDescAuxiliarDevolucione.DataSource = DS
        Me.cmbDescAuxiliarDevolucione.ValueField = "ID"
        Me.cmbDescAuxiliarDevolucione.TextField = "NombreAu"
        Me.cmbDescAuxiliarDevolucione.DataBind()
        Me.cmbDescAuxiliarDevolucione.SelectedIndex = 0


        Me.cmbAuxiliarDescuentos.DataSource = DS
        Me.cmbAuxiliarDescuentos.ValueField = "ID"
        Me.cmbAuxiliarDescuentos.TextField = "ID"
        Me.cmbAuxiliarDescuentos.DataBind()
        Me.cmbAuxiliarDescuentos.SelectedIndex = 0

        Me.cmbDescAuxiliarDescuentos.DataSource = DS
        Me.cmbDescAuxiliarDescuentos.ValueField = "ID"
        Me.cmbDescAuxiliarDescuentos.TextField = "NombreAu"
        Me.cmbDescAuxiliarDescuentos.DataBind()
        Me.cmbDescAuxiliarDescuentos.SelectedIndex = 0


        Me.cmbAuxIvaPendiente.DataSource = DS
        Me.cmbAuxIvaPendiente.ValueField = "ID"
        Me.cmbAuxIvaPendiente.TextField = "ID"
        Me.cmbAuxIvaPendiente.DataBind()
        Me.cmbAuxIvaPendiente.SelectedIndex = 0

        Me.cmbDescAuxIvaPendiente.DataSource = DS
        Me.cmbDescAuxIvaPendiente.ValueField = "ID"
        Me.cmbDescAuxIvaPendiente.TextField = "NombreAu"
        Me.cmbDescAuxIvaPendiente.DataBind()
        Me.cmbDescAuxIvaPendiente.SelectedIndex = 0


        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as  NombreEf union all Select EntidadFed_ID as ID, Nombre  as NombreEf from Entidad_Federativa order by NombreEf ", "ConexionDBS")

        Me.cmbEstado.DataSource = DS
        Me.cmbEstado.ValueField = "ID"
        Me.cmbEstado.TextField = "NombreEf"
        Me.cmbEstado.DataBind()
        Me.cmbEstado.SelectedIndex = 0



        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as  NombreSF union all Select modulo_id as ID, nombre  as NombreSF from modulo where borradoLogico = 0 order by NombreSF ", "ConexionDBS")

        Me.cmbSucursalFacturadora.DataSource = DS
        Me.cmbSucursalFacturadora.ValueField = "ID"
        Me.cmbSucursalFacturadora.TextField = "NombreSF"
        Me.cmbSucursalFacturadora.DataBind()
        Me.cmbSucursalFacturadora.SelectedIndex = 0


        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as  NombreE union all Select ID_empresa as ID, nom_corto  as NombreE from Catalogo_empresas where borradoLogico = 0 order by NombreE ", "ConexionDBS")

        Me.cmbEmpresa.DataSource = DS
        Me.cmbEmpresa.ValueField = "ID"
        Me.cmbEmpresa.TextField = "NombreE"
        Me.cmbEmpresa.DataBind()
        Me.cmbEmpresa.SelectedIndex = 0


        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as  NombreNC union all Select idcuenta as ID, numerodecuenta  as NombreNC from cuentas_bancarias where borradoLogico = 0 order by NombreNC ", "ConexionDBS")

        Me.cmbNoCuenta.DataSource = DS
        Me.cmbNoCuenta.ValueField = "ID"
        Me.cmbNoCuenta.TextField = "NombreNC"
        Me.cmbNoCuenta.DataBind()
        Me.cmbNoCuenta.SelectedIndex = 0



        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as  NombreZF union all Select zona_fiscal_id as ID, nombre  as NombreZF from zona_fiscal where borradoLogico = 0 order by NombreZF ", "ConexionDBS")

        Me.cmbZonaFiscal.DataSource = DS
        Me.cmbZonaFiscal.ValueField = "ID"
        Me.cmbZonaFiscal.TextField = "NombreZF"
        Me.cmbZonaFiscal.DataBind()
        Me.cmbZonaFiscal.SelectedIndex = 0


        DS = fncion.TraeDatosConsulta("Select 0 as ID, 'SELECCIONAR...' as  NombreEm union all Select ID_almacen as ID, descripcion  as NombreEm from almacen  WHERE habilitado =1 Or habilitado Is Null and borradoLogico = 0 order by NombreEm ", "ConexionDBS")

        Me.cmbAlmacenPredeterminado.DataSource = DS
        Me.cmbAlmacenPredeterminado.ValueField = "ID"
        Me.cmbAlmacenPredeterminado.TextField = "NombreEm"
        Me.cmbAlmacenPredeterminado.DataBind()
        Me.cmbAlmacenPredeterminado.SelectedIndex = 0

    End Sub
    Private Sub CargaCallback()
        'Variables
        Dim dato As String = ""
        Dim id As Int32
        Dim R() As String
        Dim R2() As String
        dato = Convert.ToString(txtNombre.Text.Trim())

        'CONCATENA LOS CONTROLES DEL FORMULARIO 
        cadena =
      txtNombre.Text + "|" +
    txtDireccion.Text + "|" +
    txtColonia.Text + "|" +
    txtCP.Text + "|" +
    cmbMunicipio.Value + "|" +
    cmbEstado.Value + "|" +
    txtTelefono.Text + "|" +
    txtTelefono2.Text + "|" +
    txtFax.Text + "|" +
    txtCostoAdmvo.Text + "|" +
    txtNumVendedores.Text + "|" +
    txtCostoMinVendedor.Text + "|" +
    cmbAreaRegion.Value + "|" +
    "NULL" + "|" +
    cmbAuxiliarVentas.Value + "|" +
    txtContadorFiscal.Text + "|" +
    txtContadorRemisiones.Text + "|" +
    "0" + "|" +
    "0" + "|" +
    cmbNoCuenta.Value + "|" +
    txtSerieFacturas.Text + "|" +
    txtSerieRemisiones.Text + "|" +
    txtContadorRecibosPagos.Text + "|" +
    "0" + "|" +
    txtSerieRecibosPagos.Text + "|" +
    cmbAuxiliarDevoluciones.Value + "|" +
    txtContadorReciboFiscal.Text + "|" +
    "0" + "|" +
    txtSerieReciboFiscal.Text + "|" +
    cmbAuxiliarDescuentos.Value + "|" +
    txtContadorContratos.Text + "|" +
    cmbZonaFiscal.Value + "|" +
    txtSerieNotaCredito.Text + "|" +
    txtContadorNotaCredito.Text + "|" +
    "0" + "|" +
    "0" + "|" +
    txtContadorCompra.Text + "|" +
    "0" + "|" +
    cmbSucursalFacturadora.Value + "|" +
    cmbAlmacenPredeterminado.Value + "|" +
    "0" + "|" +
    cmbAuxIvaPendiente.Value + "|" +
    txtNombreFormatoFactura.Text + "|" +
    txtNombreFormatoNC.Text + "|" +
    rbSucursalActiva.Value + "|" +
    cmbEmpresa.Value + "|" +
    "0" + "|" +
    "NULL" + "|" +
    "NULL" + "|" +
    "NULL"

        'Validación ACTUALIZA DATOS
        If (btnAgregar.Checked = False) And (btnEditar.Checked = True) Then
            id = Convert.ToInt32(txtNumSucursal.Text)
            Resultado = fnc.Fun_Edita(54, cadena, id, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            R = Resultado.Split("|")
            If R(0) = "0" Then
                cbActualizar.JSProperties("cpAccion") = "Registro actualizado con éxito."
            Else
                cbActualizar.JSProperties("cpAccion") = Resultado
            End If


            'Validación INSERTA DATOS
        ElseIf (btnAgregar.Checked = True) And (btnEditar.Checked = False) Then
            Resultado = fnc.Fun_Nuevo(54, cadena, 2, dato, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")
            If R2(0) = "0" Then
                cbActualizar.JSProperties("cpAccion") = "Registro agregado con éxito."
                cbActualizar.JSProperties("cpNumSuc") = R2(1)
                idnew_Global = R2(1)
            Else
                cbActualizar.JSProperties("cpAccion") = Resultado
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
    Private Sub ConfiguraGridCCP()
        'Este método configura el Grid Producto-Proveedor (pasa ID de producto a otra tabla).
        Dim Sucursal_id As String = ""
        GVCentroCostosProceso.Columns.Clear()
        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim DS As DataSet
        DS = New DataSet
        'Si la variable global viene Vacía, entonces se da valor a la variable prod_id de lo que traiga el Gridlookup de Búsqueda,
        'De lo contrario le asigna lo que trae la variable Global a la variable prod_id y le pone el ID nuevo a la caja de Texto txtNoProducto.
        If idnew_Global = Nothing Then
            Sucursal_id = Convert.ToString(glBusqueda.Value())
        Else
            Sucursal_id = idnew_Global
            GVCentroCostosProceso.JSProperties("cpNumSuc") = idnew_Global
        End If


        If Sucursal_id = "" Then
            consulta = "SELECT Id_Opcion As IDOPC,modulo_id As IDMOD, Valor As VALUE FROM Opciones_x_sucursal WHERE Tipo_opcion='CentroCostos' and modulo_id = -1"
            'consulta = "SELECT modulo_id, Id_Opcion, Valor FROM opciones_x_sucursal WHERE Tipo_opcion='CentroCostos' and modulo_id = -1"
            tabla = fnc.TraeDatosConsulta(consulta, "ConexionDBS")
            dtOpciones = tabla.Tables("Table")
        Else
            consulta = "SELECT Id_Opcion As IDOPC,modulo_id As IDMOD, Valor As VALUE FROM Opciones_x_sucursal WHERE Tipo_opcion='CentroCostos' and modulo_id = " + Sucursal_id
            'consulta = "SELECT modulo_id, Id_Opcion, Valor FROM opciones_x_sucursal WHERE Tipo_opcion='CentroCostos' and modulo_id = " + Sucursal_id
            tabla = fnc.TraeDatosConsulta(consulta, "ConexionDBS")
            dtOpciones = tabla.Tables("Table")
        End If

        VerificaAccesos("Sucursales")

        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColumnas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1
                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGridGL = New GridViewDataTextColumn
                    ColumnaGridGL.Caption = vNombreColumna
                    If ColumnaGridGL.Caption = "IDMOD" Then
                        ColumnaGridGL.Visible = False
                        ColumnaGridGL.ReadOnly = True
                        ColumnaGridGL.VisibleIndex = "0"
                    End If

                    If vNombreColumna = "IDOPC" Then
                        ColumnaGridGL.Visible = False
                        DS = fnc.TraeDatosConsulta("Select valor as IDOPC, descripcion from catGeneralestbl where tabla = 'Opciones_x_Sucursal'", "ConexionDBS")
                        ColumnaCombo.FieldName = "IDOPC"
                        ColumnaCombo.Caption = "TIPO"
                        ColumnaCombo.ShowInCustomizationForm = True
                        ColumnaCombo.VisibleIndex = "1"
                        ColumnaCombo.PropertiesComboBox.DataSource = DS
                        ColumnaCombo.PropertiesComboBox.TextField = "descripcion"
                        ColumnaCombo.PropertiesComboBox.ValueField = "IDOPC"
                        GVCentroCostosProceso.Columns.Add(ColumnaCombo)
                    End If


                    If vNombreColumna = "VALUE" Then
                        ColumnaGridGL.Visible = False
                        DS = fnc.TraeDatosConsulta("SELECT Centro_de_costos.ID_centro_costo As VALUE,Centro_de_costos.Descripcion,proyectos.nombre as Proyecto,subproyectos.nombre AS Subproyecto FROM Centro_de_costos INNER JOIN proyectos ON Centro_de_costos.idproyecto = proyectos.idproyecto INNER JOIN subproyectos ON Centro_de_costos.idproyecto = subproyectos.idproyecto AND Centro_de_costos.idsubproyecto = subproyectos.idsubproyecto AND proyectos.idproyecto = subproyectos.idproyecto", "ConexionDBS")
                        Me.ColumnaCombo2.PropertiesComboBox.Columns.Clear()
                        ColumnaCombo2.FieldName = "VALUE"
                        ColumnaCombo2.Caption = "VALOR"
                        ColumnaCombo2.ShowInCustomizationForm = True
                        ColumnaCombo2.VisibleIndex = "2"
                        ColumnaCombo2.PropertiesComboBox.DataSource = DS
                        ColumnaCombo2.PropertiesComboBox.ValueField = "VALUE"
                        ColumnaCombo2.PropertiesComboBox.Columns.Add("VALUE").Caption = "ID CENTRO COSTO"
                        ColumnaCombo2.PropertiesComboBox.Columns.Add("Descripcion").Caption = "DESCRIPCIÓN"
                        ColumnaCombo2.PropertiesComboBox.Columns.Add("Proyecto").Caption = "PROYECTO"
                        ColumnaCombo2.PropertiesComboBox.Columns.Add("Subproyecto").Caption = "SUBPROYECTO"
                        ColumnaCombo2.PropertiesComboBox.TextFormatString = "{1}"
                        GVCentroCostosProceso.Columns.Add(ColumnaCombo2)
                    End If

                    ColumnaGridGL.ReadOnly = False
                    ColumnaGridGL.FieldName = vfieldName
                    GVCentroCostosProceso.Columns.Add(ColumnaGridGL)
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
                            If ColumnaGridGL.Caption = "IDMOD" Then
                                ColumnaGridGL.Visible = False
                                ColumnaGridGL.ReadOnly = True
                                ColumnaGridGL.VisibleIndex = "0"
                            End If

                            If vNombreColumna = "IDOPC" Then
                                ColumnaGridGL.Visible = False
                                DS = fnc.TraeDatosConsulta("Select valor as IDOPC, descripcion from catGeneralestbl where tabla = 'Opciones_x_Sucursal'", "ConexionDBS")
                                ColumnaCombo.FieldName = "IDOPC"
                                ColumnaCombo.Caption = "TIPO"
                                ColumnaCombo.ShowInCustomizationForm = True
                                ColumnaCombo.VisibleIndex = "1"
                                ColumnaCombo.PropertiesComboBox.DataSource = DS
                                ColumnaCombo.PropertiesComboBox.TextField = "descripcion"
                                ColumnaCombo.PropertiesComboBox.ValueField = "IDOPC"
                                GVCentroCostosProceso.Columns.Add(ColumnaCombo)
                            End If


                            If vNombreColumna = "VALUE" Then
                                ColumnaGridGL.Visible = False
                                DS = fnc.TraeDatosConsulta("SELECT Centro_de_costos.ID_centro_costo As VALUE,Centro_de_costos.Descripcion,proyectos.nombre as Proyecto,subproyectos.nombre AS Subproyecto FROM Centro_de_costos INNER JOIN proyectos ON Centro_de_costos.idproyecto = proyectos.idproyecto INNER JOIN subproyectos ON Centro_de_costos.idproyecto = subproyectos.idproyecto AND Centro_de_costos.idsubproyecto = subproyectos.idsubproyecto AND proyectos.idproyecto = subproyectos.idproyecto", "ConexionDBS")
                                Me.ColumnaCombo2.PropertiesComboBox.Columns.Clear()
                                ColumnaCombo2.FieldName = "VALUE"
                                ColumnaCombo2.Caption = "VALOR"
                                ColumnaCombo2.ShowInCustomizationForm = True
                                ColumnaCombo2.VisibleIndex = "2"
                                ColumnaCombo2.PropertiesComboBox.DataSource = DS
                                ColumnaCombo2.PropertiesComboBox.ValueField = "VALUE"
                                ColumnaCombo2.PropertiesComboBox.Columns.Add("VALUE").Caption = "ID CENTRO COSTO"
                                ColumnaCombo2.PropertiesComboBox.Columns.Add("Descripcion").Caption = "DESCRIPCIÓN"
                                ColumnaCombo2.PropertiesComboBox.Columns.Add("Proyecto").Caption = "PROYECTO"
                                ColumnaCombo2.PropertiesComboBox.Columns.Add("Subproyecto").Caption = "SUBPROYECTO"
                                ColumnaCombo2.PropertiesComboBox.TextFormatString = "{1}"
                                GVCentroCostosProceso.Columns.Add(ColumnaCombo2)
                            End If

                            ColumnaGridGL.ReadOnly = False
                            ColumnaGridGL.FieldName = vfieldName
                            GVCentroCostosProceso.Columns.Add(ColumnaGridGL)

                        Next
                    End If
                End If
            End If
        End If
        If tabla.Tables.Count > 0 Then
            If (tabla.Tables(0).Rows.Count > 0) Or (tabla.Tables(0).Rows.Count = 0) Then
                GVCentroCostosProceso.DataSource = tabla
                GVCentroCostosProceso.DataBind()
                GVCentroCostosProceso.Columns.Add(ColumnaGrid)
            End If
        End If
    End Sub

    Protected Sub GVCentroCostosProceso_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs) Handles GVCentroCostosProceso.CustomCallback
        If e.Parameters.Equals("Actualizar") Then
            ConfiguraGridCCP()
            'LlenaGrid() ' esta comentado
        End If
    End Sub

#Region "Batch"
    Public Class GridDataItem
        Public Property id As Integer
        Public Property Id_Opcion As Integer
        Public Property Valor As Integer

    End Class

    Protected ReadOnly Property GridData As List(Of GridDataItem)
        Get
            Dim key = "34FAA454-CF92-4882-9401-93F6AAE81277"
            If Not IsPostBack OrElse Session(key) Is Nothing Then Session(key) = Enumerable.Range(0, 3000).[Select](Function(i) New GridDataItem With
                {.id = Convert.ToInt32(i),
                 .Id_Opcion = 0,
                 .Valor = 0
            }).ToList()
            Return CType(Session(key), List(Of GridDataItem))
        End Get
    End Property

    Protected Function InsertNewItem(ByVal newValues As OrderedDictionary) As GridDataItem
        BanderaInsUpd = 1
        Dim item = New GridDataItem()
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function

    Protected Function UpdateItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
        Dim IdOpc = Convert.ToInt16(keys("IDOPC"))
        IdOpcion = IdOpc
        Dim item = GridData.First(Function(i) i.id = IdOpc)
        BanderaInsUpd = 2
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function

    Protected Function DeleteItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
        Dim IdOpc = Convert.ToInt16(keys("IDOPC"))
        IdOpcion = IdOpc
        Dim item = GridData.First(Function(i) i.id = IdOpc)
        BanderaInsUpd = 3
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function

    Protected Sub GVCentroCostosProceso_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs) Handles GVCentroCostosProceso.BatchUpdate
        'Si la caja de Texto viene vacía, entonces entra a validar todos Controles del RoundPanel, y luego al Callback de Inserción/Actualización.
        If txtNumSucursal.Text = Nothing Then
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
        Me.GVCentroCostosProceso.DataSource = Nothing
        Me.GVCentroCostosProceso.DataBind()
        Me.GVCentroCostosProceso.Selection.UnselectAll()
        Me.GVCentroCostosProceso.CancelEdit()
        Me.GVCentroCostosProceso.FocusedRowIndex = -1
        ConfiguraGridCCP()

    End Sub

    Protected Sub LoadNewValues(ByVal item As GridDataItem, ByVal values As OrderedDictionary, ByVal Optional bandera As Integer = 0)


        Dim llaves As String = ""
        Dim llaves2 As String = ""
        Dim R() As String
        Dim R2() As String
        Dim IDControl As String

        'Si la variable global viene vacía, entonces iguala la variable IDControl a lo que trae la caja de Texto y lo toma como Item para el Grid, 
        'De lo contrario, le asigna el valor que trae la variable Global.
        If idnew_Global = Nothing Then
            IDControl = txtNumSucursal.Text
        Else
            IDControl = idnew_Global
        End If


        item.id = IDControl
        item.Id_Opcion = Convert.ToInt16(values("IDOPC"))
        item.Valor = Convert.ToInt16(values("VALUE"))

        Dim id = item.id
        Dim Id_Opcion = item.Id_Opcion
        Dim Valor = item.Valor


        cadena =
            Valor.ToString() + "|" +
            "NULL" + "|" +
            "0" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL"

        llaves = id.ToString() + "|" + Id_Opcion.ToString() + "|" + "CentroCostos"


        'Inserta Registro.
        If bandera = 1 Then
            Resultado = fnc.Grid_Alta(55, cadena, llaves, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            R = Resultado.Split("|")
            If R(0) = 0 Then
                GVCentroCostosProceso.JSProperties("cpAccion") = "Registro Insertado con éxito."
                'GVProdProv.JSProperties("cpnewId") = idnew_Global
            Else
                GVCentroCostosProceso.JSProperties("cpAccion") = Resultado
            End If

            'Actualiza Registro.
        ElseIf bandera = 2 Then
            llaves2 = id.ToString() + "|" + IdOpcion.ToString() + "|" + "CentroCostos"
            Resultado = fnc.Grid_Alta(55, cadena, llaves, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")
            If R2(0) = 0 Then
                Resultado = fnc.Grid_Elimina(55, llaves2, 0, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
                If Resultado = "0" Then
                    GVCentroCostosProceso.JSProperties("cpAccion") = "Registro actualizado con éxito."
                Else
                    GVCentroCostosProceso.JSProperties("cpAccion") = "Registro no actualizado."
                End If

            Else
                GVCentroCostosProceso.JSProperties("cpAccion") = R2(0)
            End If
            'Elimina Registro.
        ElseIf bandera = 3 Then
            llaves2 = id.ToString() + "|" + Id_Opcion.ToString() + "|" + "CentroCostos"
            Resultado = fnc.Grid_Elimina(55, llaves2, 0, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            If Resultado = "0" Then
                GVCentroCostosProceso.JSProperties("cpAccion") = "Registro eliminado con éxito."
            Else
                GVCentroCostosProceso.JSProperties("cpAccion") = Resultado
            End If
        End If
    End Sub

#End Region
    Protected Sub cmbMunicipio_Callback(sender As Object, e As CallbackEventArgsBase)

        Dim DS As DataSet
        DS = New DataSet
        Dim fncion = New WsFuncionalidad.Funcionalidad
        Dim Estado As String

        Estado = e.Parameter.ToString()

        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as  NombreMun union all Select Municipio_ID as ID,  Nombre as NombreMun from SIIFI_Municipio where EntidadFed_ID = " + Estado + "  order by ID ", "ConexionDBS")

        Me.cmbMunicipio.DataSource = DS
        Me.cmbMunicipio.ValueField = "ID"
        Me.cmbMunicipio.TextField = "NombreMun"
        Me.cmbMunicipio.DataBind()
        Me.cmbMunicipio.SelectedIndex = 0

    End Sub

End Class