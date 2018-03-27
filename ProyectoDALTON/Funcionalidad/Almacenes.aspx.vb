Imports WsSeguridad
Imports DevExpress.Web
Imports System.Data.SqlClient
Imports System.Data
Imports Microsoft.VisualBasic
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Windows.Forms
Partial Class Funcionalidad_Almacenes
    Inherits System.Web.UI.Page
    Private Servicio As New WsSeguridad.Seguridad
    Public vSistema As String = System.Configuration.ConfigurationManager.AppSettings.Item("sistema")
    Public vEmpresa As String = System.Configuration.ConfigurationManager.AppSettings.Item("empresa")
#Region "Variables Globales"
    Dim ColumnaGrid As New GridViewCommandColumn
    Dim ColumnaGridGL As New GridViewDataTextColumn
    Dim ColumnaCombo As New GridViewDataComboBoxColumn

    Dim cadena As String = "", consulta As String = "", Resultado As String = "", cat As String = "", pseudo As String, Errpseudo As String = "", colum As String = ""
    Dim NumeroColumnas As Integer = 0, NumeroRenglones As Integer = 0
    Dim vNombreColumna As Object, vfieldName As Object

    Dim DSTipoDato As New DataSet
    Dim dtTipoDato As DataTable
    Dim dtOpciones As DataTable
    Dim drOpciones As DataRow


    Dim ColumnaGridt As New GridViewDataTextColumn ' PARA EL TEXTO (ENCABEZADO) EN EL GRID

    Dim fnc As New WsFuncionalidad.Funcionalidad
    Dim tabla As New DataSet()


    Dim campo As Boolean
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
            VerificaAccesos("Almacenes")
            'Habilita Botones Encabezado JS.
            HabBotonesPrinc()
            'Carga Función LlenarBusqueda en el Glookup
            glBusqueda.Columns.Clear()
            LlenarBusqueda()
            LlenaCombos()

            'VALIDACIÓN PARA LOS PARAMETROS
        Else
            LlenarBusqueda()

        End If
    End Sub

    Protected Sub Page_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit
        DevExpress.Web.ASPxWebControl.GlobalTheme = Session("TemaDin")
    End Sub
    Private Sub HabBotonesPrinc()
        'Éste método Activa Botones
        btnAgregar.ClientEnabled = True
        btnEditar.ClientEnabled = False
        btnEliminar.ClientEnabled = False
        btnCancelar.ClientEnabled = False
        btnActualizar.ClientEnabled = False
    End Sub


#Region "Botones AGREGA,EDITA,CANCELA"
    Protected Sub cbActualizar_Callback(source As Object, e As CallbackEventArgs) Handles cbActualizar.Callback
        ValidaControles()
        CargaCallback()
    End Sub

    Protected Sub cbEliminar_Callback(source As Object, e As CallbackEventArgs) Handles cbEliminar.Callback
        'Variables

        Dim id As Int32
        If glBusqueda.Value <> Nothing Then
            id = Convert.ToInt32(txtNoAlmacen.Text)
        End If
        'Envía parámetros a SP "Spu_UtilDelete"

        Resultado = fnc.Fun_Elimina(13, id, 3, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
        If Resultado = "0" Then
            cbEliminar.JSProperties("cpAccionE") = "Registro eliminado con éxito."
            cbEliminar.JSProperties("cpClear") = "0"
        Else
            cbEliminar.JSProperties("cpClear") = "1"
            cbEliminar.JSProperties("cpAccionE") = "No hay registros que eliminar."
        End If

    End Sub
#End Region
    Private Sub CargaCallback()
        'Variables
        Dim dato As String = ""

        Dim id As Int32

        dato = Convert.ToString(txtDescripcion.Text.Trim())
        Dim R() As String
        Dim R2() As String

        'CONCATENA LOS CONTROLES DEL FORMULARIO 
        cadena =
cmbEncargado.Value + "|" +
txtDescripcion.Text + "|" +
txtDireccion.Text + "|" +
        txtTelefono.Text + "|" +
        txtColonia.Text + "|" +
        txtCP.Text + "|" +
        cmbMunicipio.Value.ToString() + "|" +
        cmbEstado.Value + "|" +
        cmbCentroCostos.Value + "|" +
        rblHabilitado.Value + "|" +
        cmbSucursal.Value + "|" +
        "0" + "|" +
        "NULL" + "|" +
        "NULL" + "|" +
        "NULL"

        If (btnAgregar.Checked = False) And (btnEditar.Checked = True) Then
            id = Convert.ToInt32(txtNoAlmacen.Text)
            Resultado = fnc.Fun_Edita(13, cadena, id, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R = Resultado.Split("|")
            If R(0) = "0" Then
                cbActualizar.JSProperties("cpAccion") = "Registro actualizado con éxito."
            Else
                cbActualizar.JSProperties("cpAccion") = Resultado
            End If
            'Validación INSERTA DATOS
        ElseIf (btnAgregar.Checked = True) And (btnEditar.Checked = False) Then
            Resultado = fnc.Fun_Nuevo(13, cadena, 3, dato, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")
            If R2(0) = "0" Then
                cbActualizar.JSProperties("cpAccion") = "Registro agregado con éxito."
                cbActualizar.JSProperties("cpNoAlmacen") = R2(1)
                idnew_Global = R2(1)
            Else
                cbActualizar.JSProperties("cpAccion") = Resultado

            End If
        End If

    End Sub

    Public Sub LlenarBusqueda()
        'Este método llena el Gridlookup de Búsqueda mediante WS.
        glBusqueda.Columns.Clear()
        tabla = fnc.TraeDatosConsulta("SELECT * FROM almacen where borradoLogico = 0", "ConexionDBS")


        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColumnas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGridt = New GridViewDataTextColumn
                    ColumnaGridt.Caption = vNombreColumna

                    If ColumnaGridt.Caption = "ID_almacen" Then
                        ColumnaGridt.Caption = "ID Almacen"
                        ColumnaGridt.ReadOnly = True
                        ColumnaGridt.Visible = True
                        ColumnaGridt.Width = 50
                    ElseIf ColumnaGridt.Caption = "descripcion" Then
                        ColumnaGridt.Caption = "Descripción"
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

    Private Sub LlenaCombos()
        'Éste método carga los combos de cada tabla independientes en el formulario mediante WS.
        Dim DS As DataSet
        DS = New DataSet
        Dim fncion = New WsFuncionalidad.Funcionalidad

        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as  NombreE union all Select person_id as ID, nombre as NombreE from personal where borradoLogico = 0 order by NombreE ", "ConexionDBS")

        Me.cmbEncargado.DataSource = DS
        Me.cmbEncargado.ValueField = "ID"
        Me.cmbEncargado.TextField = "NombreE"
        Me.cmbEncargado.DataBind()
        Me.cmbEncargado.SelectedIndex = 0

        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as  NombreS union all Select modulo_id as ID, nombre as NombreS from modulo where borradoLogico = 0 order by NombreS ", "ConexionDBS")

        Me.cmbSucursal.DataSource = DS
        Me.cmbSucursal.ValueField = "ID"
        Me.cmbSucursal.TextField = "NombreS"
        Me.cmbSucursal.DataBind()
        Me.cmbSucursal.SelectedIndex = 0

        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as  NombreCC union all Select ID_centro_costo as ID, Descripcion as NombreCC from Centro_de_costos where borradoLogico = 0 order by NombreCC ", "ConexionDBS")

        Me.cmbCentroCostos.DataSource = DS
        Me.cmbCentroCostos.ValueField = "ID"
        Me.cmbCentroCostos.TextField = "NombreCC"
        Me.cmbCentroCostos.DataBind()
        Me.cmbCentroCostos.SelectedIndex = 0

        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as  NombreEf union all Select EntidadFed_ID as ID, Nombre  as NombreEf from Entidad_Federativa where borradoLogico = 0 order by NombreEf ", "ConexionDBS")

        Me.cmbEstado.DataSource = DS
        Me.cmbEstado.ValueField = "ID"
        Me.cmbEstado.TextField = "NombreEf"
        Me.cmbEstado.DataBind()
        Me.cmbEstado.SelectedIndex = 0



    End Sub
    Public Sub ValidaControles()

        Dim Control As UI.Control
        For Each Control In ASPxRoundPanel3.Controls
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
            End If
        Next Control

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
                Me.lblAccesos.Text = "El usuario no tiene acceso a este formaulario..."
                Response.Buffer = True
                Response.Clear()
                Response.Redirect("../Framework/Acceso.aspx")
                Response.Redirect("../Framework/Acceso.aspx")
            End If
        End If
    End Sub

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

