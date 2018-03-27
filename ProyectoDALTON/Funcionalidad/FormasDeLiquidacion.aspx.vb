Imports WsSeguridad
Imports DevExpress.Web
Imports System.Data.SqlClient
Imports System.Data
Imports Microsoft.VisualBasic
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Windows.Forms
Partial Class Funcionalidad_FormasDeLiquidacion
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
            VerificaAccesos("FormasDeLiquidacion")

            'Habilita Botones Encabezado JS. 
            HabBotonesPrinc()


            'Carga Función LlenarBusqueda en el Glookup
            glBusqueda.Columns.Clear()
            LlenarBusqueda()
            LlenaCombos()


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
            id = Convert.ToInt32(txtFormaDeLiquidacion.Text)
        End If



        'Envía parámetros a SP "Spu_UtilDelete"

        Resultado = fnc.Fun_Elimina(38, id, 1, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
        If Resultado = "0" Then
            cbEliminar.JSProperties("cpAccionE") = "Registro eliminado con éxito."
            cbEliminar.JSProperties("cpClear") = "0"
        Else
            cbEliminar.JSProperties("cpClear") = "1"
            cbEliminar.JSProperties("cpAccionE") = "No hay registros que eliminar."
        End If

    End Sub

    Protected Sub CargaCallback()
        'Variables
        Dim dato As String = ""
        Dim id As Int32
        Dim R() As String
        Dim R2() As String
        Dim ChoCa As String

        If (cmbNoCuenta.Text = "") Then
            dato = Convert.ToString(txtDescripcion.Text.Trim())
        Else dato = Convert.ToString(cmbNoCuenta.Text.Trim())

        End If

        If rbtnEsCuentaBancaria.Value = 1 Then
            ChoCa = cmbChequeCajaTrans.Value
        Else
            ChoCa = cmbChequeCaja.Value
        End If



        'CONCATENA LOS CONTROLES DEL FORMULARIO 
        cadena =
cmbMoneda.Value + "|" +
dato + "|" +
cmbCuentaInterna.Value + "|" +
cmbCuentaExterna.Value + "|" +
"NULL" + "|" +
"NULL" + "|" +
rbtnFormaDeLiquidacionActiva.Value + "|" +
txtDescripcionCorta.Text + "|" +
rbtnEsCuentaBancaria.Value + "|" +
cmbTipoDeAplicacion.Value + "|" +
ChoCa + "|" +
"0" + "|" +
"NULL"

        'Validación ACTUALIZA DATOS
        If (btnAgregar.Checked = False) And (btnEditar.Checked = True) Then
            id = Convert.ToInt32(txtFormaDeLiquidacion.Text)
            Resultado = fnc.Fun_Edita(38, cadena, id, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R = Resultado.Split("|")
            If R(0) = "0" Then
                cbActualizar.JSProperties("cpAccion") = "Registro actualizado con éxito."
            Else
                cbActualizar.JSProperties("cpAccion") = Resultado
            End If
            'Validación INSERTA DATOS
        ElseIf (btnAgregar.Checked = True) And (btnEditar.Checked = False) Then
            Resultado = fnc.Fun_Nuevo(38, cadena, 3, dato, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")
            If R2(0) = "0" Then
                cbActualizar.JSProperties("cpAccion") = "Registro agregado con éxito."
                cbActualizar.JSProperties("cpFormasDeLiquidacion") = R2(1)
                idnew_Global = R2(1)
            Else
                cbActualizar.JSProperties("cpAccion") = Resultado
            End If
        End If
    End Sub
    Public Sub ValidaControles()

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
            End If
        Next Control

    End Sub
#End Region

    Public Sub LlenarBusqueda()
        'Este método llena el Gridlookup de Búsqueda mediante WS.
        glBusqueda.Columns.Clear()
        tabla = fnc.TraeDatosConsulta("SELECT * FROM forma_liquidacion WHERE borradoLogico = 0", "ConexionDBS")


        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColumnas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGridt = New GridViewDataTextColumn
                    ColumnaGridt.Caption = vNombreColumna

                    If ColumnaGridt.Caption = "ID_formaliq" Then
                        ColumnaGridt.Caption = "Id Forma de liquidación"
                        ColumnaGridt.ReadOnly = True
                        ColumnaGridt.Visible = True
                        ColumnaGridt.Width = 50
                    ElseIf ColumnaGridt.Caption = "Descripcion" Then
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

        'Se llena el combo Moneda
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreM union all Select moneda_id as ID, nombre as NombreM from moneda where borradoLogico = 0 order by NombreM", "ConexionDBS")
        'Combo 

        Me.cmbMoneda.DataSource = DS
        Me.cmbMoneda.ValueField = "ID"
        Me.cmbMoneda.TextField = "NombreM"
        Me.cmbMoneda.DataBind()
        Me.cmbMoneda.SelectedIndex = 0

        'Se llena el combo Cuenta interna
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreCI union all Select idcuenta as ID, numerodecuenta as NombreCI from cuentas_bancarias where borradoLogico = 0 order by NombreCI", "ConexionDBS")
        'Combo 
        Me.cmbCuentaInterna.DataSource = DS
        Me.cmbCuentaInterna.ValueField = "ID"
        Me.cmbCuentaInterna.TextField = "NombreCI"
        Me.cmbCuentaInterna.DataBind()
        Me.cmbCuentaInterna.SelectedIndex = 0

        Me.cmbCuentaExterna.DataSource = DS
        Me.cmbCuentaExterna.ValueField = "ID"
        Me.cmbCuentaExterna.TextField = "NombreCI"
        Me.cmbCuentaExterna.DataBind()
        Me.cmbCuentaExterna.SelectedIndex = 0


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

    Protected Sub cmbNoCuenta_Callback(sender As Object, e As CallbackEventArgsBase) Handles cmbNoCuenta.Callback

        'ComboNoCuenta
        Dim DS As DataSet
        DS = New DataSet
        Dim fncion = New WsFuncionalidad.Funcionalidad
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreNC, '' as Banco union all Select  cuentas_bancarias.idcuenta as ID, cuentas_bancarias.numerodecuenta as NombreNC, bancos.nombre_corto as Banco FROM (cuentas_bancarias INNER JOIN bancos ON cuentas_bancarias.idbanco = bancos.idbanco) WHERE (((cuentas_bancarias.activo)=1 Or (cuentas_bancarias.activo) Is Null))", "ConexionDBS")
        'combo
        Me.cmbNoCuenta.DataSource = DS
        Me.cmbNoCuenta.ValueField = "ID"
        Me.cmbNoCuenta.TextField = "NombreNC"
        Me.cmbNoCuenta.DataBind()
        Me.cmbNoCuenta.SelectedIndex = 0

    End Sub

End Class
