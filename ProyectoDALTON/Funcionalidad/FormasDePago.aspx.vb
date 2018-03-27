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
Partial Class Funcionalidad_FormasDePago
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


    Dim ColumnaGridt As New GridViewDataTextColumn ' PARA EL TEXTO (ENCABEZADO) EN EL GRID

    Dim fnc As New WsFuncionalidad.Funcionalidad
    Dim tabla As New DataSet()

    Dim campo As Boolean
    Dim BanderaInsUpd As Integer = 0
    Dim IdModulo As String
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
            VerificaAccesos("FormasDePago")
            ConfiguraGridFormasDePago()

            'Habilita Botones Encabezado JS.
            HabBotonesPrinc()


            'Carga Función LlenarBusqueda en el Glookup
            glBusqueda.Columns.Clear()
            LlenarBusqueda()

        Else
            LlenarBusqueda()
            ConfiguraGridFormasDePago()

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
            id = Convert.ToInt32(txtFormaDePago.Text)
        End If

        'Envía parámetros a SP "Spu_UtilDelete"

        Resultado = fnc.Fun_Elimina(20, id, 1, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
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
        Dim R() As String
        Dim R2() As String

        dato = Convert.ToString(txtSiglas.Text.Trim())

        'CONCATENA LOS CONTROLES DEL FORMULARIO 
        cadena =
txtSiglas.Text + "|" +
txtDescripcion.Text + "|" +
rblFormaDePagoActiva.Value + "|" +
cmbTipoDePago.Value + "|" +
"NULL" + "|" +
"0" + "|" +
"NULL" + "|" +
"NULL" + "|" +
"NULL"

        'Validación ACTUALIZA DATOS
        If (btnAgregar.Checked = False) And (btnEditar.Checked = True) Then
            id = Convert.ToInt32(txtFormaDePago.Text)
            Resultado = fnc.Fun_Edita(20, cadena, id, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R = Resultado.Split("|")
            If R(0) = "0" Then
                cbActualizar.JSProperties("cpAccion") = "Registro actualizado con éxito."
            Else
                cbActualizar.JSProperties("cpAccion") = Resultado
            End If

            'Validación INSERTA DATOS
        ElseIf (btnAgregar.Checked = True) And (btnEditar.Checked = False) Then
            Resultado = fnc.Fun_Nuevo(20, cadena, 2, dato, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")

            If R2(0) <> "0" Then 'Valida cualquier error distinto a cero.
                cbActualizar.JSProperties("cpAccion") = Resultado
            Else
                cbActualizar.JSProperties("cpAccion") = "Registro insertado correctamente" 'Inserta correctamente.
                cbActualizar.JSProperties("cpIDForma") = R2(1)
                idnew_Global = R2(1)
            End If
        End If
    End Sub
   
    Public Sub LlenarBusqueda()
        'Este método llena el Gridlookup de Búsqueda mediante WS.
        glBusqueda.Columns.Clear()
        tabla = fnc.TraeDatosConsulta("SELECT * FROM formas_pago WHERE borradoLogico = 0", "ConexionDBS")


        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColumnas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGridt = New GridViewDataTextColumn
                    ColumnaGridt.Caption = vNombreColumna

                    If ColumnaGridt.Caption = "id_formapago" Then
                        ColumnaGridt.Caption = "ID Forma de  pago"
                        ColumnaGridt.ReadOnly = True
                        ColumnaGridt.Visible = True
                        ColumnaGridt.Width = 50
                    ElseIf ColumnaGridt.Caption = "descripcion" Then
                        ColumnaGridt.Caption = "Descripción "
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

    Private Sub ConfiguraGridFormasDePago()
        Dim id_formapago As String = ""
        GVFormasDePago.Columns.Clear()
        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim DS As DataSet
        DS = New DataSet
        id_formapago = Convert.ToString(glBusqueda.Value())

        If id_formapago = "" Then
            consulta = "SELECT Id_Opcion, modulo_id, Valor as idcuenta FROM opciones_x_sucursal WHERE Id_Opcion = '-1'"
            tabla = fnc.TraeDatosConsulta(consulta, "ConexionDBS")
            dtOpciones = tabla.Tables("Table")
        Else
            consulta = "SELECT Id_Opcion, modulo_id, Valor as idcuenta FROM opciones_x_sucursal WHERE Id_Opcion =" + id_formapago
            tabla = fnc.TraeDatosConsulta(consulta, "ConexionDBS")
            dtOpciones = tabla.Tables("Table")
        End If

        VerificaAccesos("FormasDePago")

        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColumnas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGridGL = New GridViewDataTextColumn
                    ColumnaGridGL.Caption = vNombreColumna
                    If ColumnaGridGL.Caption = "Id_Opcion" Then
                        ColumnaGridGL.Visible = False
                        ColumnaGridGL.ReadOnly = True
                        ColumnaGridGL.VisibleIndex = "0"
                    End If

                    If vNombreColumna = "modulo_id" Then
                        ColumnaGridGL.Visible = False
                        DS = fnc.TraeDatosConsulta("SELECT modulo_id, nombre FROM modulo where borradoLogico = 0", "ConexionDBS")
                        ColumnaCombo.FieldName = "modulo_id"
                        ColumnaCombo.Caption = "Sucursal"
                        ColumnaCombo.ShowInCustomizationForm = True
                        ColumnaCombo.VisibleIndex = "1"
                        ColumnaCombo.PropertiesComboBox.DataSource = DS
                        ColumnaCombo.PropertiesComboBox.TextField = "nombre"
                        ColumnaCombo.PropertiesComboBox.ValueField = "modulo_id"
                        GVFormasDePago.Columns.Add(ColumnaCombo)
                    End If

                    If vNombreColumna = "idcuenta" Then
                        ColumnaGridGL.Visible = False
                        DS = fnc.TraeDatosConsulta("SELECT idcuenta,numerodecuenta from cuentas_bancarias where borradoLogico = 0", "ConexionDBS")
                        ColumnaCombo2.FieldName = "idcuenta"
                        ColumnaCombo2.Caption = "Número de cuenta"
                        ColumnaCombo2.ShowInCustomizationForm = True
                        ColumnaCombo2.VisibleIndex = "2"
                        ColumnaCombo2.PropertiesComboBox.DataSource = DS
                        ColumnaCombo2.PropertiesComboBox.TextField = "numerodecuenta"
                        ColumnaCombo2.PropertiesComboBox.ValueField = "idcuenta"
                        GVFormasDePago.Columns.Add(ColumnaCombo2)
                    End If
                    If ColumnaGridGL.Caption = "idcuenta" Then
                        ColumnaGridGL.ReadOnly = False
                        ColumnaGridGL.VisibleIndex = "3"
                        ColumnaGridGL.Visible = False
                    End If

                    ColumnaGridGL.FieldName = vfieldName
                    GVFormasDePago.Columns.Add(ColumnaGridGL)
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
                            If ColumnaGridGL.Caption = "Id_Opcion" Then
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
                                GVFormasDePago.Columns.Add(ColumnaCombo)
                            End If
                            If ColumnaGridGL.Caption = "Id_Opcion" Then
                                ColumnaGridGL.ReadOnly = True
                                ColumnaGridGL.VisibleIndex = "1"
                                ColumnaGridGL.Visible = False
                            End If

                            If vNombreColumna = "idcuenta" Then
                                ColumnaGridGL.Visible = False
                                DS = fnc.TraeDatosConsulta("SELECT idcuenta, numerodecuenta from cuentas_bancarias where borradoLogico = 0", "ConexionDBS")
                                ColumnaCombo2.FieldName = "idcuenta"
                                ColumnaCombo2.Caption = "Número de cuenta"
                                ColumnaCombo2.ShowInCustomizationForm = True
                                ColumnaCombo2.VisibleIndex = "2"
                                ColumnaCombo2.PropertiesComboBox.DataSource = DS
                                ColumnaCombo2.PropertiesComboBox.TextField = "numerodecuenta"
                                ColumnaCombo2.PropertiesComboBox.ValueField = "idcuenta"
                                GVFormasDePago.Columns.Add(ColumnaCombo2)
                            End If
                            If ColumnaGridGL.Caption = "idcuenta" Then
                                ColumnaGridGL.ReadOnly = False
                                ColumnaGridGL.VisibleIndex = "3"
                                ColumnaGridGL.Visible = False
                            End If

                            ColumnaGridGL.ReadOnly = False
                            ColumnaGridGL.FieldName = vfieldName
                            GVFormasDePago.Columns.Add(ColumnaGridGL)
                        Next
                    End If
                End If
            End If
        End If
        If tabla.Tables.Count > 0 Then
            If (tabla.Tables(0).Rows.Count > 0) Or (tabla.Tables(0).Rows.Count = 0) Then
                GVFormasDePago.DataSource = tabla
                GVFormasDePago.DataBind()
                GVFormasDePago.Columns.Add(ColumnaGrid)
            End If
        End If
    End Sub

    Protected Sub GVFormasDePago_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs) Handles GVFormasDePago.CustomCallback
        If e.Parameters.Equals("Actualizar") Then
            ConfiguraGridFormasDePago()
            'LlenaGrid() ' esta comentado
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
            Dim key = "34FAA454-CF92-4882-9401-93F6AAE81289"
            If Not IsPostBack OrElse Session(key) Is Nothing Then Session(key) = Enumerable.Range(0, 3000).[Select](Function(i) New GridDataItem With
                {.id = Convert.ToInt32(i),
                 .modulo_id = 0,
                 .idcuenta = 0
                 }).ToList()
            Return CType(Session(key), List(Of GridDataItem))
        End Get
    End Property
    Public Class GridDataItem
        Public Property id As Integer
        Public Property modulo_id As Integer
        Public Property idcuenta As Integer

    End Class
    Protected Function InsertNewItem(ByVal newValues As OrderedDictionary) As GridDataItem
        BanderaInsUpd = 1
        Dim item = New GridDataItem()
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Function UpdateItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
        Dim idmod = Convert.ToInt16(keys("modulo_id"))
        IdModulo = idmod
        Dim item = GridData.First(Function(i) i.id = idmod)
        BanderaInsUpd = 2
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Function DeleteItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
        Dim idmod = Convert.ToInt16(keys("modulo_id"))
        IdModulo = idmod
        Dim item = GridData.First(Function(i) i.id = idmod)
        BanderaInsUpd = 3
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Sub GVFormasDePago_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs) Handles GVFormasDePago.BatchUpdate
        If txtFormaDePago.Text = Nothing Then
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
        Me.GVFormasDePago.DataSource = Nothing
        Me.GVFormasDePago.DataBind()
        Me.GVFormasDePago.Selection.UnselectAll()
        Me.GVFormasDePago.CancelEdit()
        Me.GVFormasDePago.FocusedRowIndex = -1
        ConfiguraGridFormasDePago()

    End Sub
    Protected Sub LoadNewValues(ByVal item As GridDataItem, ByVal values As OrderedDictionary, ByVal Optional bandera As Integer = 0)

        Dim llaves As String = ""
        Dim llaves2 As String = ""
        Dim R() As String
        Dim R2() As String
        Dim IDControl As String

        If idnew_Global = Nothing Then
            IDControl = txtFormaDePago.Text
        Else
            IDControl = idnew_Global
        End If

        item.id = IDControl
        item.modulo_id = Convert.ToInt16(values("modulo_id"))
        item.idcuenta = Convert.ToInt16(values("idcuenta"))

        Dim id = item.id
        Dim modulo_id = item.modulo_id
        Dim idcuenta = item.idcuenta
        cadena =
            idcuenta.ToString() + "|" +
            "NULL" + "|" +
            "0" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL"

        llaves = modulo_id.ToString() + "|" + id.ToString() + "|" + "CtaFormaPago"


        'Inserta Registro.
        If bandera = 1 Then

            Resultado = fnc.Grid_Alta(55, cadena, llaves, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            R = Resultado.Split("|")
            If R(0) = 0 Then
                GVFormasDePago.JSProperties("cpAccion") = "Registro Insertado con éxito."
                GVFormasDePago.JSProperties("cpnewId") = idnew_Global
            Else
                GVFormasDePago.JSProperties("cpAccion") = Resultado
            End If


            'Actualiza Registro.
        ElseIf bandera = 2 Then
            llaves2 = IdModulo.ToString() + "|" + id.ToString() + "|" + "CtaFormaPago"
            Resultado = fnc.Grid_Alta(55, cadena, llaves, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")
            If R2(0) = 0 Then
                Resultado = fnc.Grid_Elimina(55, llaves2, 0, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
                If Resultado = "0" Then
                    GVFormasDePago.JSProperties("cpAccion") = "Registro actualizado con éxito."
                Else
                    GVFormasDePago.JSProperties("cpAccion") = "Registro no actualizado."
                End If

            Else
                GVFormasDePago.JSProperties("cpAccion") = R2(0)
            End If
            'Elimina Registro.
        ElseIf bandera = 3 Then
            llaves2 = IdModulo.ToString() + "|" + id.ToString() + "|" + "CtaFormaPago"
            Resultado = fnc.Grid_Elimina(55, llaves2, 0, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            If Resultado = "0" Then
                GVFormasDePago.JSProperties("cpAccion") = "Registro eliminado con éxito."
            Else
                GVFormasDePago.JSProperties("cpAccion") = Resultado
            End If
        End If

    End Sub

#End Region

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
            End If
        Next Control

    End Sub


End Class
