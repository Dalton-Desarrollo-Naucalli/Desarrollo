Imports WsSeguridad
Imports DevExpress.Web
Imports System.Data.SqlClient
Imports System.Data
Imports Microsoft.VisualBasic
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Windows.Forms
Partial Class Funcionalidad_TiposDeCambio
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
            VerificaAccesos("TiposDeCambio")

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
        Dim cat As String = ""
        Dim id As Int32

        'dato = Convert.ToString(.Text.Trim())
        Dim R() As String
        Dim R2() As String
        Dim FechaMovimiento As DateTime = Convert.ToDateTime(dateFechaMovimiento.Text)
        Dim FMov As String = FechaMovimiento.ToString("yyyy/MM/dd")


        'CONCATENA LOS CONTROLES DEL FORMULARIO 
        cadena =
cmbNoMoneda.Value + "|" +
FMov + "|" +
txtTipoCambioOficial.Text + "|" +
txtTipoCambioComercial.Text + "|" +
"0" + "|" +
"NULL" + "|" +
"NULL" + "|" +
"NULL"

        If (btnAgregar.Checked = False) And (btnEditar.Checked = True) Then
            id = Convert.ToInt32(txtNoMovimiento.Text)
            Resultado = fnc.Fun_Edita(cat, cadena, id, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R = Resultado.Split("|")
            If R(0) = "0" Then
                cbActualizar.JSProperties("cpAccion") = "Registro actualizado con éxito."
            Else
                cbActualizar.JSProperties("cpAccion") = Resultado
            End If
            'Validación INSERTA DATOS
        ElseIf (btnAgregar.Checked = True) And (btnEditar.Checked = False) Then
            Resultado = fnc.Fun_Nuevo(cat, cadena, 3, dato, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")
            If R2(0) = "0" Then
                cbActualizar.JSProperties("cpAccion") = "Registro agregado con éxito."
            Else
                cbActualizar.JSProperties("cpAccion") = Resultado
            End If
        End If
    End Sub

    Protected Sub cbEliminar_Callback(source As Object, e As CallbackEventArgs) Handles cbEliminar.Callback
        Dim cat As String = ""
        Dim id As Int32
        If glBusqueda.Value <> Nothing Then
            id = Convert.ToInt32(txtNoMovimiento.Text)
        End If

        'Envía parámetros a SP "Spu_UtilDelete"

        Resultado = fnc.Fun_Elimina(cat, id, 1, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
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
        tabla = fnc.TraeDatosConsulta("select tc.fechamov,tc.tipodecambio,m.nombre,tc.moneda_id,tc.tc_id,tc.tipodecambio_comercial from tipodecambio tc inner join moneda m on m.moneda_id=tc.moneda_id AND tc.borradoLogico = 0", "ConexionDBS")


        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColumnas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGridt = New GridViewDataTextColumn
                    ColumnaGridt.Caption = vNombreColumna

                    If ColumnaGridt.Caption = "tc_id" Then
                        ColumnaGridt.Caption = "ID Tipo de cambio"
                        ColumnaGridt.Visible = False
                    ElseIf ColumnaGridt.Caption = "moneda_id" Then
                        ColumnaGridt.Caption = "Id moneda"
                        ColumnaGridt.Visible = False
                    ElseIf ColumnaGridt.Caption = "fechamov" Then
                        ColumnaGridt.Caption = "Fecha de movimiento"
                        ColumnaGridt.Visible = True
                    ElseIf ColumnaGridt.Caption = "tipodecambio" Then
                        ColumnaGridt.Caption = "Tipo de cambio"
                        ColumnaGridt.Visible = True
                    ElseIf ColumnaGridt.Caption = "nombre" Then
                        ColumnaGridt.Caption = "Nombre"
                        ColumnaGridt.Visible = True
                    ElseIf ColumnaGridt.Caption = "tipodecambio_comercial" Then
                        ColumnaGridt.Caption = "Tipo de cambio comercial"
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

        'Se llena el combo MonedA
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreM union all Select moneda_id as ID, nombre as NombreM from moneda where borradoLogico = 0 order by NombreM", "ConexionDBS")
        'Combo
        'Me.cmbCategoria.ClientEnabled = False
        Me.cmbNoMoneda.DataSource = DS
        Me.cmbNoMoneda.ValueField = "ID"
        Me.cmbNoMoneda.TextField = "NombreM"
        Me.cmbNoMoneda.DataBind()
        Me.cmbNoMoneda.SelectedIndex = 0

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

    Protected Sub btnCatMonedas_Click(sender As Object, e As EventArgs) Handles btnCatMonedas.Click
        If cmbNoMoneda.Value = 0 Then
            Response.Redirect("Monedas.aspx")

        Else
            Dim AbreCat As String
            AbreCat = cmbNoMoneda.Value
            Response.Redirect("Monedas.aspx?MonedaID=" + AbreCat)
        End If
    End Sub


End Class



