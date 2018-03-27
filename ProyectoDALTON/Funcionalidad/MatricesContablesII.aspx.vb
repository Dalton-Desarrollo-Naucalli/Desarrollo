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
Partial Class Funcionalidad_MatricesContablesII
    Inherits System.Web.UI.Page
    Private Servicio As New WsSeguridad.Seguridad
    Public vSistema As String = System.Configuration.ConfigurationManager.AppSettings.Item("sistema")
    Public vEmpresa As String = System.Configuration.ConfigurationManager.AppSettings.Item("empresa")
#Region "Variables Globales"
    Dim ColumnaGrid As New GridViewCommandColumn
    Dim ColumnaGridGL As New GridViewDataTextColumn
    Dim ColumnaCombo As New GridViewDataComboBoxColumn
    Dim ColumnaCombo1 As New GridViewDataComboBoxColumn
    Dim ColumnaCombo2 As New GridViewDataComboBoxColumn
    Dim ColumnaCombo3 As New GridViewDataComboBoxColumn
    Dim ColumnaCombo4 As New GridViewDataComboBoxColumn

    Dim cadena As String = "", consulta As String = "", Resultado As String = "", colum As String = ""
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
    Dim CentroCosto As String
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
            VerificaAccesos("MatricesContablesII")
            ConfiguraGridMatriz2()

            'Habilita Botones Encabezado JS.
            'HabBotonesPrinc()
            'Carga Función LlenarBusqueda en el Glookup
            'glBusqueda.Columns.Clear()
            'LlenarBusqueda()
            ' LlenaCombos()

            'VALIDACIÓN PARA LOS PARAMETROS      
        Else
            'LlenarBusqueda()
            ConfiguraGridMatriz2()

        End If
    End Sub
    Protected Sub Page_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit
        DevExpress.Web.ASPxWebControl.GlobalTheme = Session("TemaDin")
    End Sub
    'Private Sub HabBotonesPrinc()
    '    'Éste método Activa Botones
    '    btnAgregar.ClientEnabled = True
    '    btnEditar.ClientEnabled = False
    '    btnEliminar.ClientEnabled = False
    '    btnCancelar.ClientEnabled = False
    '    btnActualizar.ClientEnabled = False
    'End Sub
    'Protected Sub cbActualizar_Callback(source As Object, e As CallbackEventArgs) Handles cbActualizar.Callback
    '    ValidaControles()

    'End Sub

    '    Private Sub CargaCallback()
    '        'Variables
    '        Dim dato As String = ""
    '        Dim id As Int32
    '        dato = Convert.ToString(cmbTipoDeGasto.Value.Trim())
    '        Dim R() As String
    '        Dim R2() As String


    '        cadena =
    '"NULL" + "|" +
    '"NULL" + "|" +
    '"0" + "|" +
    '"NULL" + "|" +
    '"NULL" + "|" +
    '"NULL"

    '        If (btnAgregar.Checked = False) And (btnEditar.Checked = True) Then
    '            id = Convert.ToInt32(cmbTipoDeGasto.Value)
    '            Resultado = fnc.Fun_Edita(39, cadena, id, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
    '            R = Resultado.Split("|")
    '            If R(0) = "0" Then
    '                cbActualizar.JSProperties("cpAccion") = "Registro actualizado con éxito."
    '            Else
    '                cbActualizar.JSProperties("cpAccion") = Resultado
    '            End If
    '            'Validación INSERTA DATOS
    '        ElseIf (btnAgregar.Checked = True) And (btnEditar.Checked = False) Then
    '            Resultado = fnc.Fun_Nuevo(39, cadena, 1, dato, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
    '            R2 = Resultado.Split("|")
    '            If R2(0) = "0" Then
    '                cbActualizar.JSProperties("cpAccion") = "Registro agregado con éxito."
    '                cbActualizar.JSProperties("cpMC2") = R2(1)
    '                idnew_Global = R2(1)
    '            Else
    '                cbActualizar.JSProperties("cpAccion") = Resultado
    '            End If
    '        End If

    '    End Sub
    'Protected Sub cbEliminar_Callback(source As Object, e As CallbackEventArgs) Handles cbEliminar.Callback
    '    'Variables

    '    Dim id As Int32
    '    id = Convert.ToInt32(cmbTipoDeGasto.Value)

    '    'Envía parámetros a SP "Spu_UtilDelete"

    '    Resultado = fnc.Fun_Elimina(39, id, 1, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
    '    If Resultado = "0" Then
    '        cbEliminar.JSProperties("cpAccionE") = "Registro eliminado con éxito."
    '        cbEliminar.JSProperties("cpClear") = "0"
    '    Else
    '        cbEliminar.JSProperties("cpClear") = "1"
    '        cbEliminar.JSProperties("cpAccionE") = "No hay registros que eliminar."
    '    End If

    'End Sub
    'Public Sub ValidaControles()

    '    Dim Control As UI.Control
    '    For Each Control In ASPxRoundPanel2.Controls
    '        If Control.[GetType]() = GetType(ASPxTextBox) Then
    '            Dim txt As ASPxTextBox = CType(Control, ASPxTextBox)
    '            If txt.Text = "" Then
    '                txt.Text = "NULL"
    '            End If
    '        ElseIf Control.[GetType]() = GetType(ASPxComboBox) Then
    '            Dim cmb As ASPxComboBox = CType(Control, ASPxComboBox)
    '            If cmb.Text = "" Then
    '                cmb.Value = "NULL"
    '            End If
    '        ElseIf Control.[GetType]() = GetType(ASPxRadioButtonList) Then
    '            Dim rbtl As ASPxRadioButtonList = CType(Control, ASPxRadioButtonList)
    '            If rbtl.Value = "" Then
    '                rbtl.Value = "NULL"
    '            End If
    '        End If
    '    Next Control

    ''End Sub
    'Public Sub LlenarBusqueda()
    '    'Este método llena el Gridlookup de Búsqueda mediante WS.
    '    glBusqueda.Columns.Clear()
    '    tabla = fnc.TraeDatosConsulta("Select id_tipogasto,descripcion from matriz_contable_2 where borradoLogico=0", "ConexionDBS")


    '    If tabla.Tables.Count > 0 Then
    '        If tabla.Tables(0).Rows.Count > 0 Then
    '            NumeroColumnas = tabla.Tables(0).Columns.Count - 1
    '            NumeroRenglones = tabla.Tables(0).Rows.Count - 1

    '            For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

    '                vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
    '                vfieldName = tabla.Tables(0).Columns(j).ColumnName
    '                ColumnaGridt = New GridViewDataTextColumn
    '                ColumnaGridt.Caption = vNombreColumna

    '                If ColumnaGridt.Caption = "id_tipogasto" Then
    '                    ColumnaGridt.Caption = "ID TIPO GASTO"
    '                    ColumnaGridt.ReadOnly = True
    '                    ColumnaGridt.Visible = True
    '                    ColumnaGridt.Width = 50
    '                ElseIf ColumnaGridt.Caption = "descripcion" Then
    '                    ColumnaGridt.Caption = "DESCRIPCIÓN"
    '                    ColumnaGridt.Visible = True

    '                Else
    '                    ColumnaGridt.Visible = False
    '                End If

    '                ColumnaGridt.FieldName = vfieldName
    '                Me.glBusqueda.Columns.Add(ColumnaGridt)
    '            Next
    '        End If
    '    End If
    '    If tabla.Tables.Count > 0 Then
    '        If tabla.Tables(0).Rows.Count > 0 Then
    '            glBusqueda.DataSource = tabla
    '            glBusqueda.DataBind()
    '        End If

    '    End If


    'End Sub
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
    Private Sub ConfiguraGridMatriz2()
        GVMatriz2.Columns.Clear()
        GVMatriz2.Settings.ShowHeaderFilterButton = False
        GVMatriz2.Settings.ShowHeaderFilterBlankItems = False
        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim DS As DataSet
        DS = New DataSet

        consulta = "SELECT id_tipogasto,ID_centro_costo, cuenta_interna_debito,cuenta_interna_credito, ID_clase,descripcion from matriz_contable_2 "
        tabla = fnc.TraeDatosConsulta(consulta, "ConexionDBS")
            dtOpciones = tabla.Tables("Table")

        VerificaAccesos("MatricesContablesII")


        NumeroColumnas = tabla.Tables(0).Columns.Count - 1
        NumeroRenglones = tabla.Tables(0).Rows.Count - 1

        For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

            vfieldName = tabla.Tables(0).Columns(j).ColumnName
            vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
            ColumnaGridGL = New GridViewDataTextColumn
            ColumnaGridGL.Caption = vNombreColumna
            Dim parametro As String = fnc.Parametro(46, "ConexionDBS")

            If vNombreColumna = "id_tipogasto" Then
                ColumnaGridGL.Visible = False
                DS = fnc.TraeDatosConsulta("SELECT DISTINCT id_tipogasto, descripcion,id_tipoconcepto FROM conceptos_gastos WHERE id_tipoconcepto=5", "ConexionDBS")
                ColumnaCombo.FieldName = "id_tipogasto"
                ColumnaCombo.Caption = "TIPO GASTO"
                ColumnaCombo.ShowInCustomizationForm = True
                ColumnaCombo.VisibleIndex = "0"
                ColumnaCombo.PropertiesComboBox.DataSource = DS
                ColumnaCombo.PropertiesComboBox.Columns.Add("id_tipogasto").Caption = "ID GASTO"
                ColumnaCombo.PropertiesComboBox.Columns.Add("descripcion").Caption = "DESCRIPCIÓN"
                ColumnaCombo.PropertiesComboBox.TextFormatString = "{1}"
                ColumnaCombo.PropertiesComboBox.ValueField = "id_tipogasto"
                GVMatriz2.Columns.Add(ColumnaCombo)
            End If

            If vNombreColumna = "ID_centro_costo" Then
                ColumnaGridGL.Visible = False
                DS = fnc.TraeDatosConsulta("SELECT  ID_centro_costo, Descripcion from Centro_de_costos where borradoLogico = 0 ", "ConexionDBS")
                ColumnaCombo1.FieldName = "ID_centro_costo"
                ColumnaCombo1.Caption = "CENTRO DE COSTOS"
                ColumnaCombo1.ShowInCustomizationForm = True
                ColumnaCombo1.VisibleIndex = "1"
                ColumnaCombo1.PropertiesComboBox.DataSource = DS
                ColumnaCombo1.PropertiesComboBox.Columns.Add("ID_centro_costo").Caption = "ID"
                ColumnaCombo1.PropertiesComboBox.Columns.Add("Descripcion").Caption = "DESCRIPCIÓN"
                ColumnaCombo1.PropertiesComboBox.TextFormatString = "{1}"
                ColumnaCombo1.PropertiesComboBox.ValueField = "ID_centro_costo"
                GVMatriz2.Columns.Add(ColumnaCombo1)
            End If

            If vNombreColumna = "cuenta_interna_debito" Then
                ColumnaGridGL.Visible = False
                DS = fnc.TraeDatosConsulta("SELECT DISTINCT numerodecuenta,descripcion from catcon WHERE numerodecuenta Not Like '*000000' AND moneda_mex = " + parametro + " ORDER BY numerodecuenta", "ConexionGENDES")
                Me.ColumnaCombo2.PropertiesComboBox.Columns.Clear()
                ColumnaCombo2.FieldName = "cuenta_interna_debito"
                ColumnaCombo2.Caption = "CUENTA DÉBITO"
                ColumnaCombo2.ShowInCustomizationForm = True
                ColumnaCombo2.VisibleIndex = "2"
                ColumnaCombo2.PropertiesComboBox.DataSource = DS
                ColumnaCombo2.PropertiesComboBox.Columns.Add("numerodecuenta").Caption = "NO. CUENTA"
                ColumnaCombo2.PropertiesComboBox.Columns.Add("descripcion").Caption = "DESCRIPCIÓN"
                ColumnaCombo2.PropertiesComboBox.TextFormatString = "{0}"
                ColumnaCombo2.PropertiesComboBox.ValueField = "numerodecuenta"
                GVMatriz2.Columns.Add(ColumnaCombo2)
            End If

            If vNombreColumna = "cuenta_interna_credito" Then
                ColumnaGridGL.Visible = False
                DS = fnc.TraeDatosConsulta("SELECT DISTINCT numerodecuenta,descripcion from catcon WHERE numerodecuenta Not Like '*000000' AND moneda_mex = " + parametro + " ORDER BY numerodecuenta", "ConexionGENDES")
                Me.ColumnaCombo3.PropertiesComboBox.Columns.Clear()
                ColumnaCombo3.FieldName = "cuenta_interna_credito"
                ColumnaCombo3.Caption = "CUENTA CRÉDITO"
                ColumnaCombo3.ShowInCustomizationForm = True
                ColumnaCombo3.VisibleIndex = "2"
                ColumnaCombo3.PropertiesComboBox.DataSource = DS
                ColumnaCombo3.PropertiesComboBox.Columns.Add("numerodecuenta").Caption = "NO. CUENTA"
                ColumnaCombo3.PropertiesComboBox.Columns.Add("descripcion").Caption = "DESCRIPCIÓN"
                ColumnaCombo3.PropertiesComboBox.TextFormatString = "{0}"
                ColumnaCombo3.PropertiesComboBox.ValueField = "numerodecuenta"
                GVMatriz2.Columns.Add(ColumnaCombo3)
            End If

            If vNombreColumna = "ID_clase" Then
                ColumnaGridGL.Visible = False
                DS = fnc.TraeDatosConsulta("SELECT DISTINCT ID_clase,nombre FROM clase", "ConexionDBS")
                Me.ColumnaCombo4.PropertiesComboBox.Columns.Clear()
                ColumnaCombo4.FieldName = "ID_clase"
                ColumnaCombo4.Caption = "CLASE"
                ColumnaCombo4.ShowInCustomizationForm = True
                ColumnaCombo4.VisibleIndex = "3"
                ColumnaCombo4.PropertiesComboBox.DataSource = DS
                ColumnaCombo4.PropertiesComboBox.Columns.Add("ID_clase").Caption = "ID"
                ColumnaCombo4.PropertiesComboBox.Columns.Add("nombre").Caption = "DESCRIPCIÓN"
                ColumnaCombo4.PropertiesComboBox.TextFormatString = "{1}"
                ColumnaCombo4.PropertiesComboBox.ValueField = "ID_clase"
                GVMatriz2.Columns.Add(ColumnaCombo4)
            End If

            If ColumnaGridGL.Caption = "descripcion" Then
                ColumnaGridGL.Caption = "DESCRIPCIÓN"
                ColumnaCombo1.VisibleIndex = "4"
            End If

            ColumnaGridGL.FieldName = vfieldName
            GVMatriz2.Columns.Add(ColumnaGridGL)
        Next
        GVMatriz2.DataSource = tabla
        GVMatriz2.DataBind()
        GVMatriz2.Columns.Add(ColumnaGrid)
        GVMatriz2.Settings.ShowHeaderFilterButton = True
        GVMatriz2.Settings.ShowFilterRowMenuLikeItem = True
        GVMatriz2.Settings.ShowHeaderFilterBlankItems = True
        GVMatriz2.SettingsPager.PageSize = 15
    End Sub
    'Private Sub LlenaCombos()
    '    Dim DS As DataSet
    '    DS = New DataSet
    '    Dim fncion = New WsFuncionalidad.Funcionalidad
    '    DS = fncion.TraeDatosConsulta("Select DISTINCT 0 as ID, ' SELECCIONAR...' as NombreC union all Select id_tipogasto As ID,descripcion As NombreC FROM conceptos_gastos WHERE id_tipoconcepto = 5  and borradoLogico=0 ORDER BY NombreC", "ConexionDBS")
    '    'Combo Sucursal
    '    Me.cmbTipoDeGasto.DataSource = DS
    '    Me.cmbTipoDeGasto.ValueField = "ID"
    '    Me.cmbTipoDeGasto.TextField = "NombreC"
    '    Me.cmbTipoDeGasto.DataBind()
    '    Me.cmbTipoDeGasto.SelectedIndex = 0


    'End Sub
    'Protected Sub GVMatriz2_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs) Handles GVMatriz2.CustomCallback
    '    If e.Parameters.Equals("Actualizar") Then
    '        ConfiguraGridMatriz2()
    '        'LlenaGrid() ' esta comentado
    '    End If
    'End Sub
    Protected ReadOnly Property GridData As List(Of GridDataItem)
        Get
            Dim key = "34FAA454-CF92-4882-9401-93F6AAE81269"
            If Not IsPostBack OrElse Session(key) Is Nothing Then Session(key) = Enumerable.Range(0, 3000).[Select](Function(i) New GridDataItem With
                {.Id = Convert.ToInt32(i),
                .IDGasto = 0,
                .CtaDeb = "NULL",
                .CtaCred = "NULL",
                .Clase = 0,
                .Descrp = "NULL"
                 }).ToList()
            Return CType(Session(key), List(Of GridDataItem))
        End Get
    End Property

    Public Class GridDataItem
        Public Property Id As Integer
        Public Property IDGasto As Integer
        Public Property CtaDeb As String
        Public Property CtaCred As String
        Public Property Clase As Integer
        Public Property Descrp As String

    End Class

    Protected Function InsertNewItem(ByVal newValues As OrderedDictionary) As GridDataItem
        BanderaInsUpd = 1
        Dim item = New GridDataItem()
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Function UpdateItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
        Dim IdCC = Convert.ToInt16(keys("ID_centro_costo"))
        CentroCosto = IdCC
        Dim item = GridData.First(Function(i) i.Id = IdCC)
        BanderaInsUpd = 2
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Function DeleteItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
        Dim IdCC = Convert.ToInt16(keys("ID_centro_costo"))
        CentroCosto = IdCC
        Dim item = GridData.First(Function(i) i.Id = IdCC)
        BanderaInsUpd = 3
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Sub GVMatriz2_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs) Handles GVMatriz2.BatchUpdate
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
        Me.GVMatriz2.DataSource = Nothing
        Me.GVMatriz2.DataBind()
        Me.GVMatriz2.Selection.UnselectAll()
        Me.GVMatriz2.CancelEdit()
        Me.GVMatriz2.FocusedRowIndex = -1
        ConfiguraGridMatriz2()

    End Sub
    Protected Sub LoadNewValues(ByVal item As GridDataItem, ByVal values As OrderedDictionary, ByVal Optional bandera As Integer = 0)


        Dim llaves As String = ""
        Dim llaves2 As String = ""
        Dim R() As String
        Dim R2() As String

        item.Id = Convert.ToInt16(values("ID_centro_costo"))
        item.IDGasto = Convert.ToInt16(values("id_tipogasto"))
        item.CtaDeb = Convert.ToString(values("cuenta_interna_debito"))
        item.CtaCred = Convert.ToString(values("cuenta_interna_credito"))
        item.Clase = Convert.ToInt16(values("ID_clase"))
        item.Descrp = Convert.ToString(values("descripcion"))

        Dim id = item.Id
        Dim IDGasto = item.IDGasto
        Dim CtaDeb = item.CtaDeb
        Dim CtaCred = item.CtaCred
        Dim Clase = item.Clase
        Dim Descrp = item.Descrp


        cadena =
            "NULL" + "|" +
            Clase.ToString() + "|" +
            CtaDeb.ToString() + "|" +
            CtaCred.ToString() + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            Descrp.ToString() + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "0" + "|" +
            "NULL"

        llaves = id.ToString() + "|" + IDGasto.ToString()

        'Inserta Registro.
        If bandera = 1 Then

            Resultado = fnc.Grid_Alta(66, cadena, llaves, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R = Resultado.Split("|")
            If R(0) = 0 Then
                GVMatriz2.JSProperties("cpAccion") = "Registro Insertado con éxito."
            ElseIf R(0) = 2627 Then
                GVMatriz2.JSProperties("cpAccion") = "El registro a incluir ya existe"
            Else
                GVMatriz2.JSProperties("cpAccion") = Resultado
            End If


            'Actualiza Registro.
        ElseIf bandera = 2 Then
            llaves2 = CentroCosto.ToString() + "|" + IDGasto.ToString()
            Resultado = fnc.Grid_Alta(66, cadena, llaves, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")
            If R2(0) = 0 Then
                Resultado = fnc.Grid_Elimina(66, llaves2, 0, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
                If Resultado = "0" Then
                    GVMatriz2.JSProperties("cpAccion") = "Registro actualizado con éxito."
                Else
                    GVMatriz2.JSProperties("cpAccion") = "Registro no actualizado."
                End If
            Else
                GVMatriz2.JSProperties("cpAccion") = R2(0)
            End If

            'Elimina Registro.
        ElseIf bandera = 3 Then
            llaves2 = CentroCosto.ToString() + "|" + IDGasto.ToString()
            Resultado = fnc.Grid_Elimina(66, llaves2, 0, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            If Resultado = "0" Then
                GVMatriz2.JSProperties("cpAccion") = "Registro eliminado con éxito."
            Else
                GVMatriz2.JSProperties("cpAccion") = Resultado
            End If
        End If

    End Sub

End Class
