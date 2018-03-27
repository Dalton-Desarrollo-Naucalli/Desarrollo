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
Partial Class Funcionalidad_Personal
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

    Dim campo As Boolean
    Dim BanderaInsUpd As Integer = 0
    Dim idModulo As String
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
            VerificaAccesos("Personal")
            ConfiguraGridPersonalS()

            'Habilita Botones Encabezado JS.
            HabBotonesPrinc()
            'Carga Función LlenarBusqueda en el Glookup
            glBusqueda.Columns.Clear()
            LlenarBusqueda()
            LlenaCombos()

        Else
            LlenarBusqueda()
            ConfiguraGridPersonalS()

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
    Private Sub CargaCallback()
        'Variables
        Dim dato As String = ""
        Dim id As Int32
        dato = Convert.ToString(txtNombre.Text.Trim())
        Dim FNa As String

        If dteFNacimiento.Text = "" Then
            FNa = "NULL"
        Else
            Dim FechaNacim As DateTime = Convert.ToDateTime(dteFNacimiento.Text)
            FNa = FechaNacim.ToString("yyyy/MM/dd")
        End If

        Dim Fcon As String
        If datedFechaContratacion.Text = "" Then
            Fcon = "NULL"
        Else
            Dim FechaContra As DateTime = Convert.ToDateTime(datedFechaContratacion.Text)
            Fcon = FechaContra.ToString("yyyy/MM/dd")
        End If

        Dim FBaja As String

        If datedFechaBaja.Text = "" Then
            FBaja = "NULL"
        Else
            Dim FechaBaja As DateTime = Convert.ToDateTime(datedFechaBaja.Text)
            FBaja = FechaBaja.ToString("yyyy/MM/dd")
        End If

        Dim R() As String
        Dim R2() As String
        Dim FB As String

        If rbtnnBaja.Value = 1 Then
            FB = FBaja
        Else
            FB = FBaja
        End If

        cadena =
txtNombre.Text + "|" +
txtDireccion.Text + "|" +
txtColonia.Text + "|" +
txtCodigoPostal.Text + "|" +
cmbMunicipio.Text + "|" +
cmbEstado.Text + "|" +
txtTelParticular.Text + "|" +
txtTelTrabajo.Text + "|" +
txtFax.Text + "|" +
txtRFC.Text + "|" +
txtPuesto.Text + "|" +
txtNumeroSeguridadSocial.Text + "|" +
txtNalDeIdentificacion.Text + "|" +
txtCorreoElectronico.Text + "|" +
txtDepto.Text + "|" +
FNa + "|" +
FCon + "|" +
txtNomEsposa.Text + "|" +
txtPersonaEmergencia.Text + "|" +
txtTelEmergencia.Text + "|" +
mmoNotas.Text + "|" +
"NULL" + "|" +
"NULL" + "|" +
txtClaveEmpleado.Text + "|" +
cmbCentroCostos.Value + "|" +
txtNombreCorto.Text + "|" +
cmbSucursal.Value + "|" +
txtFComision.Text + "|" +
rbtnnBaja.Value + "|" +
FB + "|" +
"NULL" + "|" +
"NULL" + "|" +
cmbNumCuentaCargo.Value + "|" +
cmbBancoCtaCargo.Value + "|" +
cmbNumCuentaAbono.Value + "|" +
cmbBancoCtaAbono.Value + "|" +
cmbAuxiliar.Value + "|" +
cmbFormularioInicial.Value + "|" +
"NULL" + "|" +
"1" + "|" +
"1" + "|" +
"0" + "|" +
"NULL" + "|" +
"NULL" + "|" +
"NULL"

        If (btnAgregar.Checked = False) And (btnEditar.Checked = True) Then
            id = Convert.ToInt32(txtIdEmpleado.Text)
            Resultado = fnc.Fun_Edita(56, cadena, id, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R = Resultado.Split("|")
            If R(0) = "0" Then
                cbActualizar.JSProperties("cpAccion") = "Registro actualizado con éxito."
            Else
                cbActualizar.JSProperties("cpAccion") = Resultado
            End If
            'Validación INSERTA DATOS
        ElseIf (btnAgregar.Checked = True) And (btnEditar.Checked = False) Then
            Resultado = fnc.Fun_Nuevo(56, cadena, 3, dato, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")
            If R2(0) = "0" Then
                cbActualizar.JSProperties("cpAccion") = "Registro agregado con éxito."
                cbActualizar.JSProperties("cpIDEmpleado") = R2(1)
                idnew_Global = R2(1)
            Else
                cbActualizar.JSProperties("cpAccion") = Resultado
            End If
        End If

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

    Protected Sub cbEliminar_Callback(source As Object, e As CallbackEventArgs) Handles cbEliminar.Callback
        'Variables

        Dim id As Int32
        id = Convert.ToInt32(txtIdEmpleado.Text)

        'Envía parámetros a SP "Spu_UtilDelete"

        Resultado = fnc.Fun_Elimina(56, id, 1, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
        If Resultado = "0" Then
            cbEliminar.JSProperties("cpAccionE") = "Registro eliminado con éxito."
            cbEliminar.JSProperties("cpClear") = "0"
        Else
            cbEliminar.JSProperties("cpClear") = "1"
            cbEliminar.JSProperties("cpAccionE") = "No hay registros que eliminar."
        End If

    End Sub
#End Region
    Private Sub LlenaCombos()
        Dim DS As DataSet
        DS = New DataSet
        Dim fncion = New WsFuncionalidad.Funcionalidad

        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreS union all Select modulo_id as ID, nombre as NombreS from modulo order by NombreS", "ConexionDBS")
        'Combo Sucursal
        Me.cmbSucursal.DataSource = DS
        Me.cmbSucursal.ValueField = "ID"
        Me.cmbSucursal.TextField = "NombreS"
        Me.cmbSucursal.DataBind()
        Me.cmbSucursal.SelectedIndex = 0

        'Se llena el combo de Centro de costos
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreCC union all Select ID_centro_costo as ID, Descripcion as NombreCC from Centro_de_costos order by NombreCC", "ConexionDBS")
        'Combo
        Me.cmbCentroCostos.DataSource = DS
        Me.cmbCentroCostos.ValueField = "ID"
        Me.cmbCentroCostos.TextField = "NombreCC"
        Me.cmbCentroCostos.DataBind()
        Me.cmbCentroCostos.SelectedIndex = 0

        'Se llena el combo Cuenta abono
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreBCA union all Select idbanco as ID, nombre_corto as NombreBCA from bancos order by NombreBCA", "ConexionDBS")
        'Combo 
        Me.cmbBancoCtaAbono.DataSource = DS
        Me.cmbBancoCtaAbono.ValueField = "ID"
        Me.cmbBancoCtaAbono.TextField = "NombreBCA"
        Me.cmbBancoCtaAbono.DataBind()
        Me.cmbBancoCtaAbono.SelectedIndex = 0

        'combo cuenta abono
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreNCC union all Select idcuenta as ID, numerodecuenta as NombreNCC from cuentas_bancarias where borradoLogico = 0 order by NombreNCC", "ConexionDBS")
        'Combo 
        Me.cmbNumCuentaAbono.DataSource = DS
        Me.cmbNumCuentaAbono.ValueField = "ID"
        Me.cmbNumCuentaAbono.TextField = "NombreNCC"
        Me.cmbNumCuentaAbono.DataBind()
        Me.cmbNumCuentaAbono.SelectedIndex = 0


        'Se llena el combo Cuenta cargo
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreBCC union all Select  idbanco as ID, nombre_corto as NombreBCC from bancos order by NombreBCC", "ConexionDBS")
        'Combo
        Me.cmbBancoCtaCargo.DataSource = DS
        Me.cmbBancoCtaCargo.ValueField = "ID"
        Me.cmbBancoCtaCargo.TextField = "NombreBCC"
        Me.cmbBancoCtaCargo.DataBind()
        Me.cmbBancoCtaCargo.SelectedIndex = 0

        'Se llena el combo
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreNCC union all Select idcuenta as ID, numerodecuenta as NombreNCC from cuentas_bancarias order by NombreNCC", "ConexionDBS")
        'Combo 
        Me.cmbNumCuentaCargo.DataSource = DS
        Me.cmbNumCuentaCargo.ValueField = "ID"
        Me.cmbNumCuentaCargo.TextField = "NombreNCC"
        Me.cmbNumCuentaCargo.DataBind()
        Me.cmbNumCuentaCargo.SelectedIndex = 0



        'Se llena el combo 
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreFI union all Select IdFormulario as ID, Descripcion as NombreFI from formularios  order by NombreFI", "ConexionDBS")
        'Combo
        Me.cmbFormularioInicial.DataSource = DS
        Me.cmbFormularioInicial.ValueField = "ID"
        Me.cmbFormularioInicial.TextField = "NombreFI"
        Me.cmbFormularioInicial.DataBind()
        Me.cmbFormularioInicial.SelectedIndex = 0


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

        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as  NombreEf union all Select EntidadFed_ID as ID, Nombre  as NombreEf from Entidad_Federativa where borradoLogico = 0 order by NombreEf ", "ConexionDBS")

        Me.cmbEstado.DataSource = DS
        Me.cmbEstado.ValueField = "ID"
        Me.cmbEstado.TextField = "NombreEf"
        Me.cmbEstado.DataBind()
        Me.cmbEstado.SelectedIndex = 0


    End Sub


    Public Sub LlenarBusqueda()
        'Este método llena el Gridlookup de Búsqueda mediante WS.
        glBusqueda.Columns.Clear()
        tabla = fnc.TraeDatosConsulta("SELECT * FROM personal WHERE borradoLogico = 0", "ConexionDBS")


        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColumnas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGridt = New GridViewDataTextColumn
                    ColumnaGridt.Caption = vNombreColumna

                    If ColumnaGridt.Caption = "person_id" Then
                        ColumnaGridt.Caption = "ID Personal"
                        ColumnaGridt.ReadOnly = True
                        ColumnaGridt.Visible = True
                        ColumnaGridt.Width = 50
                    ElseIf ColumnaGridt.Caption = "nombre" Then
                        ColumnaGridt.Caption = "Nombre "
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
    Private Sub ConfiguraGridPersonalS()
        Dim person_id As String = ""
        GVPerSuc.Columns.Clear()
        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim DS As DataSet
        DS = New DataSet
        'Si la variable global viene Vacía, entonces se da valor a la variable prod_id de lo que traiga el Gridlookup de Búsqueda,
        'De lo contrario le asigna lo que trae la variable Global a la variable prod_id y le pone el ID nuevo a la caja de Texto txtNoProducto.
        If idnew_Global = Nothing Then
            person_id = Convert.ToString(glBusqueda.Value())
        Else
            person_id = idnew_Global
            GVPerSuc.JSProperties("cpIDProd") = idnew_Global
        End If



        If person_id = "" Then
            consulta = "SELECT person_id, modulo_id FROM Modulos_Ventas_por_Personal WHERE person_id = '-1'"
            tabla = fnc.TraeDatosConsulta(consulta, "ConexionDBS")
            dtOpciones = tabla.Tables("Table")
        Else
            consulta = "SELECT person_id, modulo_id FROM Modulos_Ventas_por_Personal WHERE person_id =" + person_id
            tabla = fnc.TraeDatosConsulta(consulta, "ConexionDBS")
            dtOpciones = tabla.Tables("Table")
        End If

        VerificaAccesos("Personal")

        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColumnas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGridGL = New GridViewDataTextColumn
                    ColumnaGridGL.Caption = vNombreColumna
                    If ColumnaGridGL.Caption = "person_id" Then
                        ColumnaGridGL.Visible = False
                        ColumnaGridGL.ReadOnly = True
                        ColumnaGridGL.VisibleIndex = "0"
                    End If

                    If vNombreColumna = "modulo_id" Then
                        ColumnaGridGL.Visible = False
                        DS = fnc.TraeDatosConsulta("SELECT modulo_id, nombre FROM modulo where borradoLogico = 0 ", "ConexionDBS")
                        ColumnaCombo.FieldName = "modulo_id"
                        ColumnaCombo.Caption = "Sucursal"
                        ColumnaCombo.ShowInCustomizationForm = True
                        ColumnaCombo.VisibleIndex = "1"
                        ColumnaCombo.PropertiesComboBox.DataSource = DS
                        ColumnaCombo.PropertiesComboBox.TextField = "nombre"
                        ColumnaCombo.PropertiesComboBox.ValueField = "modulo_id"
                        GVPerSuc.Columns.Add(ColumnaCombo)
                    End If


                    ColumnaGridGL.FieldName = vfieldName
                    GVPerSuc.Columns.Add(ColumnaGridGL)
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
                            If ColumnaGridGL.Caption = "person_id" Then
                                ColumnaGridGL.Visible = False
                            End If

                            If vNombreColumna = "modulo_id" Then
                                ColumnaGridGL.Visible = False
                                DS = fnc.TraeDatosConsulta("SELECT modulo_id, nombre FROM modulo where borradoLogico = 0 ", "ConexionDBS")
                                ColumnaCombo.FieldName = "modulo_id"
                                ColumnaCombo.Caption = "Sucursal"
                                ColumnaCombo.ShowInCustomizationForm = True
                                ColumnaCombo.VisibleIndex = "0"
                                ColumnaCombo.PropertiesComboBox.DataSource = DS
                                ColumnaCombo.PropertiesComboBox.TextField = "nombre"
                                ColumnaCombo.PropertiesComboBox.ValueField = "modulo_id"
                                GVPerSuc.Columns.Add(ColumnaCombo)
                            End If
                            If ColumnaGridGL.Caption = "Id_Opcion" Then
                                ColumnaGridGL.ReadOnly = True
                                ColumnaGridGL.VisibleIndex = "1"
                                ColumnaGridGL.Visible = False
                            End If


                            ColumnaGridGL.ReadOnly = False
                            ColumnaGridGL.FieldName = vfieldName
                            GVPerSuc.Columns.Add(ColumnaGridGL)
                        Next
                    End If
                End If
            End If
        End If
        If tabla.Tables.Count > 0 Then
            If (tabla.Tables(0).Rows.Count > 0) Or (tabla.Tables(0).Rows.Count = 0) Then
                GVPerSuc.DataSource = tabla
                GVPerSuc.DataBind()
                GVPerSuc.Columns.Add(ColumnaGrid)
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


#Region "BatchUpdate"

    Protected ReadOnly Property GridData As List(Of GridDataItem)
        Get
            Dim key = "34FAA454-CF92-4882-9401-93F6AAE81299"
            If Not IsPostBack OrElse Session(key) Is Nothing Then Session(key) = Enumerable.Range(0, 3000).[Select](Function(i) New GridDataItem With
                {.id = Convert.ToInt32(i),
                 .modulo_id = 0
                 }).ToList()
            Return CType(Session(key), List(Of GridDataItem))
        End Get
    End Property
    Public Class GridDataItem
        Public Property id As Integer
        Public Property modulo_id As Integer


    End Class
    Protected Function InsertNewItem(ByVal newValues As OrderedDictionary) As GridDataItem
        BanderaInsUpd = 1
        Dim item = New GridDataItem()
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Function UpdateItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
        Dim IDMod = Convert.ToInt16(keys("modulo_id"))
        idModulo = IDMod
        Dim item = GridData.First(Function(i) i.id = IDMod)
        BanderaInsUpd = 2
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Function DeleteItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
        Dim IDMod = Convert.ToInt16(keys("modulo_id"))
        idModulo = IDMod
        Dim item = GridData.First(Function(i) i.id = IDMod)
        BanderaInsUpd = 3
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Sub GVPerSuc_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs) Handles GVPerSuc.BatchUpdate
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
        Me.GVPerSuc.DataSource = Nothing
        Me.GVPerSuc.DataBind()
        Me.GVPerSuc.Selection.UnselectAll()
        Me.GVPerSuc.CancelEdit()
        Me.GVPerSuc.FocusedRowIndex = -1
        ConfiguraGridPersonalS()

    End Sub
    Protected Sub LoadNewValues(ByVal item As GridDataItem, ByVal values As OrderedDictionary, ByVal Optional bandera As Integer = 0)


        Dim llaves As String = ""
        Dim llaves2 As String = ""
        Dim R() As String
        Dim R2() As String
        Dim IDControl As String

        If idnew_Global = Nothing Then
            IDControl = txtIdEmpleado.Text
        Else
            IDControl = idnew_Global
        End If

        item.id = IDControl
        item.modulo_id = Convert.ToInt16(values("modulo_id"))


        Dim id = item.id
        Dim modulo_id = item.modulo_id

        cadena =
         "NULL" + "|" +
          "NULL" + "|" +
            "0" + "|" +
            "NULL"

        llaves = id.ToString() + "|" + modulo_id.ToString()


        'Inserta Registro.
        If bandera = 1 Then

            Resultado = fnc.Grid_Alta(72, cadena, llaves, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R = Resultado.Split("|")
            If R(0) = 0 Then
                GVPerSuc.JSProperties("cpAccion") = "Registro Insertado con éxito."
                GVPerSuc.JSProperties("cpnewId") = idnew_Global

            Else
                GVPerSuc.JSProperties("cpAccion") = Resultado
            End If


            'Actualiza Registro.
        ElseIf bandera = 2 Then
            llaves2 = id.ToString() + "|" + idModulo.ToString()
            Resultado = fnc.Grid_Alta(72, cadena, llaves, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")
            If R2(0) = 0 Then
                Resultado = fnc.Grid_Elimina(72, llaves2, 0, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
                If Resultado = "0" Then
                    GVPerSuc.JSProperties("cpAccion") = "Registro actualizado con éxito."
                Else
                    GVPerSuc.JSProperties("cpAccion") = "Registro no actualizado."
                End If
            Else
                GVPerSuc.JSProperties("cpAccion") = R2(0)
            End If
            'Elimina Registro.
        ElseIf bandera = 3 Then
            llaves2 = id.ToString() + "|" + idModulo.ToString()
            Resultado = fnc.Grid_Elimina(72, llaves2, 0, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            If Resultado = "0" Then
                GVPerSuc.JSProperties("cpAccion") = "Registro eliminado con éxito."
            Else
                GVPerSuc.JSProperties("cpAccion") = Resultado
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

    Protected Sub btnSucursales_Click(sender As Object, e As EventArgs) Handles btnSucursales.Click
        If cmbSucursal.Value = "" Then
            Response.Redirect("Sucursales.aspx")

        Else
            Dim AbreCat As String
            AbreCat = cmbSucursal.Value
            Response.Redirect("Sucursales.aspx?IdSucursalCS=" + AbreCat)
        End If
    End Sub

    Protected Sub btnCatCostos_Click(sender As Object, e As EventArgs) Handles btnCatCostos.Click

        If cmbCentroCostos.Value = "" Then
            Response.Redirect("Catalgo_Maestro.aspx?IdCat=34")

        Else
            Dim AbreCat As String
            AbreCat = cmbCentroCostos.Value
            Response.Redirect("Catalgo_Maestro.aspx.aspx?IdCat=34&IdCentroCostos=" + AbreCat)
        End If

    End Sub
End Class