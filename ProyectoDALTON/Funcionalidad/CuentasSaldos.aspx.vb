Imports WsSeguridad
Imports DevExpress.Web
Imports System.Data.SqlClient
Imports System.Data
Imports Microsoft.VisualBasic
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Windows.Forms
Partial Class Funcionalidad_CuentasSaldos
    Inherits System.Web.UI.Page
    Private Servicio As New WsSeguridad.Seguridad
    Public vSistema As String = System.Configuration.ConfigurationManager.AppSettings.Item("sistema")
    Public vEmpresa As String = System.Configuration.ConfigurationManager.AppSettings.Item("empresa")
#Region "Variables Globales"
    Dim ColumnaGrid As New GridViewCommandColumn
    Dim ColumnaGridGL As New GridViewDataTextColumn
    Dim ColumnaCombo As New GridViewDataComboBoxColumn

    Dim cadena As String = "", consulta As String = "", Resultado As String = "", pseudo As String, Errpseudo As String = "", colum As String = ""
    Dim NumeroColumnas As Integer = 0, NumeroRenglones As Integer = 0
    Dim vNombreColumna As Object, vfieldName As Object

    Dim DSTipoDato As New DataSet
    Dim dtTipoDato As DataTable
    Dim dtOpciones As DataTable
    Dim drOpciones As DataRow


    Dim ColumnaGridt As New GridViewDataTextColumn ' PARA EL TEXTO (ENCABEZADO) EN EL GRID

    Dim fnc As New WsFuncionalidad.Funcionalidad
    Dim tabla As New DataSet()
    Dim tabla1 As New DataSet()

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
            VerificaAccesos("CuentasSaldos")
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
        'Variables
        Dim dato As String = ""
        Dim id As Int32
        dato = Convert.ToString(txtNumeroDeCuenta.Text.Trim())
        Dim R() As String
        Dim R2() As String
        Dim id2 As Int32
        Dim llaves As String = ""

        Dim FIn As String
        If dateInicioOperacion.Text = "" Then
            FIn = "NULL"
        Else
            Dim FechaInicio As DateTime = Convert.ToDateTime(dateInicioOperacion.Text)
            FIn = FechaInicio.ToString("yyyy/MM/dd")
        End If

        'CONCATENA LOS CONTROLES DEL FORMULARIO 
        cadena =
txtNumeroDeCuenta.Text + "|" +
cmbBanco.Value + "|" +
txtSucursal.Text + "|" +
txtNoSucursal.Text + "|" +
FIn + "|" +
txtSaldo.Text + "|" +
cmbAuxiliar.Value + "|" +
cmbFormatoCheques.Value + "|" +
cmbMoneda.Value + "|" +
txtSaldoEnBanco.Text + "|" +
cmbCuentaTransferencia.Value + "|" +
cmbTipoPol.Value + "|" +
cmbModuloid.Value + "|" +
txtConsecutivoDeChequera.Text + "|" +
rbtnCuentaActiva.Value + "|" +
txtNumeroCuentaClave.Text + "|" +
txtNumeroCteBanco.Text + "|" +
txtCveFondoRelacionado.Text + "|" +
"0" + "|" +
"NULL" + "|" +
"NULL" + "|" +
"NULL"



        id = Convert.ToInt32(txtIdCuenta.Text)
        If (btnAgregar.Checked = False) And (btnEditar.Checked = True) Then
            Resultado = fnc.Fun_Edita(40, cadena, id, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            R = Resultado.Split("|")
                If R(0) = "0" Then
                id2 = Convert.ToInt32(txtIdCuenta.Text)
                Resultado = fnc.Grid_Elimina(14, id2, 0, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
                    cbActualizar.JSProperties("cpAccion") = "Registro actualizado con éxito."
                Else
                    cbActualizar.JSProperties("cpAccion") = Resultado
                End If

                'Validación INSERTA DATOS
            ElseIf (btnAgregar.Checked = True) And (btnEditar.Checked = False) Then
            Resultado = fnc.Grid_Alta(40, cadena, llaves, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")
                If R2(0) = "0" Then
                    cbActualizar.JSProperties("cpAccion") = "Registro agregado con éxito."
                cbActualizar.JSProperties("cpIdCuenta") = R2(1)
                idnew_Global = R2(1)
                Else
                    cbActualizar.JSProperties("cpAccion") = Resultado
                End If
            End If

    End Sub
    Protected Sub cbEliminar_Callback(source As Object, e As CallbackEventArgs) Handles cbEliminar.Callback
        'Variables
        Dim id As String = ""
        If glBusqueda.Value <> Nothing Then
            id = txtIdCuenta.Text
        End If
        'Envía parámetros a SP "Spu_UtilDelete"
        id = txtIdCuenta.Text
        Resultado = fnc.Fun_Elimina(40, id, 1, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
        If Resultado = "0" Then
            cbEliminar.JSProperties("cpAccionE") = "Registro eliminado con éxito."
            cbEliminar.JSProperties("cpClear") = "0"
        Else
            cbEliminar.JSProperties("cpClear") = "1"
            cbEliminar.JSProperties("cpAccionE") = "No hay registros que eliminar."
        End If

    End Sub


    Public Sub ValidaControles()

        Dim Control As UI.Control
        For Each Control In ASPxRoundPanel7.Controls
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

#End Region
    Public Sub LlenarBusqueda()
        'Este método llena el Gridlookup de Búsqueda mediante WS.
        glBusqueda.Columns.Clear()
        tabla = fnc.TraeDatosConsulta("SELECT * FROM cuentas_bancarias where borradoLogico = 0", "ConexionDBS")


        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColumnas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGridt = New GridViewDataTextColumn
                    ColumnaGridt.Caption = vNombreColumna

                    If ColumnaGridt.Caption = "idcuenta" Then
                        ColumnaGridt.Caption = "Id Cuenta"
                        ColumnaGridt.ReadOnly = True
                        ColumnaGridt.Visible = True
                        ColumnaGridt.Width = 50
                    ElseIf ColumnaGridt.Caption = "numerodecuenta" Then
                        ColumnaGridt.Caption = "Número de cuenta"
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

        'Se llena el combo Auxiliar
        DS = fncion.TraeDatosConsulta("Select '  SELECCIONAR...' as ID, '  SELECCIONAR...' as NombreAu union all Select numerodecuenta as ID, descripcion as NombreAu from CatCon order by NombreAu ", "ConexionGENDES")
        ' DS = fncion.TraeDatosConsulta("Select ' SELECCIONAR...' as ID union all Select numerodecuenta as ID from CatCon order by ID", "ConexionGENDES")
        'Combo 

        Me.cmbAuxiliar.DataSource = DS
        Me.cmbAuxiliar.ValueField = "ID"
        Me.cmbAuxiliar.TextField = "ID"
        Me.cmbAuxiliar.DataBind()
        Me.cmbAuxiliar.SelectedIndex = 0

        DS = fncion.TraeDatosConsulta("Select '  SELECCIONAR...' as ID, '  SELECCIONAR...' as NombreAu union all Select numerodecuenta as ID, descripcion as NombreAu from CatCon order by NombreAu ", "ConexionGENDES")

        Me.cmbDescAuxiliar.DataSource = DS
        Me.cmbDescAuxiliar.ValueField = "ID"
        Me.cmbDescAuxiliar.TextField = "NombreAu"
        Me.cmbDescAuxiliar.DataBind()
        Me.cmbDescAuxiliar.SelectedIndex = 0

        'Se llena el combo Moneda
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreM union all Select moneda_id as ID, nombre as NombreM from moneda where borradoLogico = 0  order by NombreM", "ConexionDBS")
        'Combo 

        Me.cmbMoneda.DataSource = DS
        Me.cmbMoneda.ValueField = "ID"
        Me.cmbMoneda.TextField = "NombreM"
        Me.cmbMoneda.DataBind()
        Me.cmbMoneda.SelectedIndex = 0

        'combo Sucursales
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreM union all Select modulo_id as ID, nombre as NombreM from modulo where borradoLogico = 0 order by NombreM", "ConexionDBS")
        'Combo 

        Me.cmbModuloid.DataSource = DS
        Me.cmbModuloid.ValueField = "ID"
        Me.cmbModuloid.TextField = "NombreM"
        Me.cmbModuloid.DataBind()
        Me.cmbModuloid.SelectedIndex = 0

        'combo Formato cheques
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreFC union all Select formato_id as ID, descripcion as NombreFC from formatos_cheques order by NombreFC", "ConexionDBS")
        'Combo 

        Me.cmbFormatoCheques.DataSource = DS
        Me.cmbFormatoCheques.ValueField = "ID"
        Me.cmbFormatoCheques.TextField = "NombreFC"
        Me.cmbFormatoCheques.DataBind()
        Me.cmbFormatoCheques.SelectedIndex = 0

        DS = fncion.TraeDatosConsulta("Select 0 as ID, '  SELECCIONAR...' as NombreB union all Select idbanco as ID, nombre_corto as NombreB from bancos order by NombreB ", "ConexionDBS")
        ' DS = fncion.TraeDatosConsulta("Select ' SELECCIONAR...' as ID union all Select numerodecuenta as ID from CatCon order by ID", "ConexionGENDES")
        'Combo 

        Me.cmbBanco.DataSource = DS
        Me.cmbBanco.ValueField = "ID"
        Me.cmbBanco.TextField = "NombreB"
        Me.cmbBanco.DataBind()
        Me.cmbBanco.SelectedIndex = 0

        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreNCC union all Select idcuenta as ID, numerodecuenta as NombreNCC from cuentas_bancarias  order by NombreNCC", "ConexionDBS")
        ' DS = fncion.TraeDatosConsulta("Select ' SELECCIONAR...' as ID union all Select numerodecuenta as ID from CatCon order by ID", "ConexionGENDES")
        'Combo 

        Me.cmbCuentaTransferencia.DataSource = DS
        Me.cmbCuentaTransferencia.ValueField = "ID"
        Me.cmbCuentaTransferencia.TextField = "NombreNCC"
        Me.cmbCuentaTransferencia.DataBind()
        Me.cmbCuentaTransferencia.SelectedIndex = 0

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



    Protected Sub btnSucursales_Click(sender As Object, e As EventArgs) Handles btnSucursales.Click
        If cmbModuloid.Value = 0 Then
            Response.Redirect("Sucursales.aspx")

        Else
            Dim AbreCat As String
            AbreCat = cmbModuloid.Value
            Response.Redirect("Sucursales.aspx?IdSucursalCS=" + AbreCat)
        End If
    End Sub
End Class
