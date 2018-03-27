Imports WsSeguridad
Imports DevExpress.Web
Imports DevExpress.Data
Imports System.Data.SqlClient
Imports System.Data
Imports Microsoft.VisualBasic
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Windows.Forms
Imports System.Collections.Specialized
Partial Class Funcionalidad_MatricesContablesI
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
    Dim concepto As String
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
            VerificaAccesos("MatricesContablesI")
            ConfiguraGridMatriz1()
            'Habilita Botones Encabezado JS.
            'HabBotonesPrinc()

            'Carga Función LlenarBusqueda en el Glookup
            'glBusqueda.Columns.Clear()
            'LlenarBusqueda()
            'LlenaCombos()
        Else
            'LlenarBusqueda()
            ConfiguraGridMatriz1()
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
    '    Protected Sub cbActualizar_Callback(source As Object, e As CallbackEventArgs) Handles cbActualizar.Callback
    '        ValidaControles()
    '    End Sub
    '    Private Sub CargaCallback()
    '        'Variables
    '        Dim dato As String = ""
    '        Dim id As Int32
    '        dato = Convert.ToString(cmbConcepto.Value.Trim())
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
    '            id = Convert.ToInt32(cmbConcepto.Value)
    '            Resultado = fnc.Fun_Edita(56, cadena, id, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
    '            R = Resultado.Split("|")
    '            If R(0) = "0" Then
    '                cbActualizar.JSProperties("cpAccion") = "Registro actualizado con éxito."
    '            Else
    '                cbActualizar.JSProperties("cpAccion") = Resultado
    '            End If
    '            'Validación INSERTA DATOS
    '        ElseIf (btnAgregar.Checked = True) And (btnEditar.Checked = False) Then
    '            Resultado = fnc.Fun_Nuevo(56, cadena, 1, dato, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
    '            R2 = Resultado.Split("|")
    '            If R2(0) = "0" Then
    '                cbActualizar.JSProperties("cpAccion") = "Registro agregado con éxito."
    '                cbActualizar.JSProperties("cpIDEmpleado") = R2(1)
    '                idnew_Global = R2(1)
    '            Else
    '                cbActualizar.JSProperties("cpAccion") = Resultado
    '            End If
    '        End If

    '    End Sub
    '    Public Sub ValidaControles()

    '        Dim Control As UI.Control
    '        For Each Control In ASPxRoundPanel2.Controls
    '            If Control.[GetType]() = GetType(ASPxTextBox) Then
    '                Dim txt As ASPxTextBox = CType(Control, ASPxTextBox)
    '                If txt.Text = "" Then
    '                    txt.Text = "NULL"
    '                End If
    '            ElseIf Control.[GetType]() = GetType(ASPxComboBox) Then
    '                Dim cmb As ASPxComboBox = CType(Control, ASPxComboBox)
    '                If cmb.Text = "" Then
    '                    cmb.Value = "NULL"
    '                End If
    '            ElseIf Control.[GetType]() = GetType(ASPxRadioButtonList) Then
    '                Dim rbtl As ASPxRadioButtonList = CType(Control, ASPxRadioButtonList)
    '                If rbtl.Value = "" Then
    '                    rbtl.Value = "NULL"
    '                End If
    '            End If
    '        Next Control

    '    End Sub
    '    Public Sub LlenarBusqueda()
    '        'Este método llena el Gridlookup de Búsqueda mediante WS.
    '        glBusqueda.Columns.Clear()

    '        tabla = fnc.TraeDatosConsulta(" SELECT id_tipogasto,descripcion,case tipo_prorrateo when'A' then'Automatico' when'X' then'Automático al 100%' when'E' then'Por entrada al almacén' else'Manual' end As TipoProrrateo FROM conceptos_gastos WHERE Tipo_prorrateo <>'X'", "ConexionDBS")

    '        If tabla.Tables.Count > 0 Then
    '            If tabla.Tables(0).Rows.Count > 0 Then
    '                NumeroColumnas = tabla.Tables(0).Columns.Count - 1
    '                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

    '                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

    '                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
    '                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
    '                    ColumnaGridt = New GridViewDataTextColumn
    '                    ColumnaGridt.Caption = vNombreColumna

    '                    If ColumnaGridt.Caption = "id_tipogasto" Then
    '                        ColumnaGridt.Caption = "Concepto"
    '                        ColumnaGridt.ReadOnly = True
    '                        ColumnaGridt.Visible = True
    '                        ColumnaGridt.Width = 50
    '                    ElseIf ColumnaGridt.Caption = "descripción" Then
    '                        ColumnaGridt.Caption = "Tipo Porrateo"
    '                        ColumnaGridt.Visible = True
    '                    ElseIf ColumnaGridt.Caption = "TipoProrrateo" Then
    '                        ColumnaGridt.Caption = "Tipo Porrateo"
    '                        ColumnaGridt.Visible = True
    '                    End If
    '                    ColumnaGridt.FieldName = vfieldName
    '                    Me.glBusqueda.Columns.Add(ColumnaGridt)
    '                Next
    '            End If
    '        End If
    '        If tabla.Tables.Count > 0 Then
    '            If tabla.Tables(0).Rows.Count > 0 Then
    '                glBusqueda.DataSource = tabla
    '                glBusqueda.DataBind()
    '            End If

    '        End If


    '    End Sub
    '    Private Sub LlenaCombos()
    '        Dim DS As DataSet
    '        DS = New DataSet
    '        Dim fncion = New WsFuncionalidad.Funcionalidad

    '        DS = fncion.TraeDatosConsulta("Select DISTINCT 0 as ID, ' SELECCIONAR...' as NombreC union all Select id_tipogasto As ID,descripcion As NombreC FROM conceptos_gastos WHERE Tipo_prorrateo<>'X' and borradoLogico=0 ORDER BY NombreC", "ConexionDBS")
    '        'Combo Sucursal
    '        Me.cmbConcepto.DataSource = DS
    '        Me.cmbConcepto.ValueField = "ID"
    '        Me.cmbConcepto.TextField = "NombreC"
    '        Me.cmbConcepto.DataBind()
    '        Me.cmbConcepto.SelectedIndex = 0


    '    End Sub
    Private Sub ConfiguraGridMatriz1()

        GVMatriz1.Columns.Clear()
        GVMatriz1.TotalSummary.Clear()
        GVMatriz1.Settings.ShowHeaderFilterButton = False
        GVMatriz1.Settings.ShowHeaderFilterBlankItems = False
        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim DS As DataSet
        DS = New DataSet

        consulta = "SELECT id_tipogasto, ID_centro_costo, cuenta_interna, Porcentaje_prorrateo from matriz_contable "
        tabla = fnc.TraeDatosConsulta(consulta, "ConexionDBS")
            dtOpciones = tabla.Tables("Table")


        VerificaAccesos("MatricesContablesI")

        NumeroColumnas = tabla.Tables(0).Columns.Count - 1
        NumeroRenglones = tabla.Tables(0).Rows.Count - 1

        For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

            vfieldName = tabla.Tables(0).Columns(j).ColumnName
            vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
            ColumnaGridGL = New GridViewDataTextColumn
            ColumnaGridGL.Caption = vNombreColumna

            If vNombreColumna = "id_tipogasto" Then
                ColumnaGridGL.Visible = False
                DS = fnc.TraeDatosConsulta("SELECT id_tipogasto,descripcion,case tipo_prorrateo when'A' then'Automatico' when'X' then'Automático al 100%' when'E' then'Por entrada al almacén' else'Manual' end As TipoProrrateo FROM conceptos_gastos WHERE Tipo_prorrateo <>'X'", "ConexionDBS")
                Me.ColumnaCombo.PropertiesComboBox.Columns.Clear()
                ColumnaCombo.FieldName = "id_tipogasto"
                ColumnaCombo.Caption = "GASTO / TIPO PRORRATEO"
                ColumnaCombo.ShowInCustomizationForm = True
                ColumnaCombo.VisibleIndex = "0"
                ColumnaCombo.PropertiesComboBox.DataSource = DS
                ColumnaCombo.PropertiesComboBox.Columns.Add("id_tipogasto").Caption = "ID GASTO"
                ColumnaCombo.PropertiesComboBox.Columns.Add("descripcion").Caption = "DESCRIPCIÓN"
                ColumnaCombo.PropertiesComboBox.Columns.Add("TipoProrrateo").Caption = "TIPO PRORRATEO"
                ColumnaCombo.PropertiesComboBox.TextFormatString = "{1} / {2}"
                ColumnaCombo.PropertiesComboBox.ValueField = "id_tipogasto"
                GVMatriz1.Columns.Add(ColumnaCombo)
            End If


            If vNombreColumna = "ID_centro_costo" Then
                ColumnaGridGL.Visible = False
                DS = fnc.TraeDatosConsulta("SELECT  ID_centro_costo, Descripcion from Centro_de_costos where borradoLogico = 0 ", "ConexionDBS")
                Me.ColumnaCombo1.PropertiesComboBox.Columns.Clear()
                ColumnaCombo1.FieldName = "ID_centro_costo"
                ColumnaCombo1.Caption = "Centro de costos"
                ColumnaCombo1.ShowInCustomizationForm = True
                ColumnaCombo1.VisibleIndex = "1"
                ColumnaCombo1.PropertiesComboBox.DataSource = DS
                ColumnaCombo1.PropertiesComboBox.TextField = "Descripcion"
                ColumnaCombo1.PropertiesComboBox.ValueField = "ID_centro_costo"
                GVMatriz1.Columns.Add(ColumnaCombo1)
            End If

            If ColumnaGridGL.Caption = "Porcentaje_prorrateo" Then
                ColumnaGridGL.Caption = "% Prorrateo"
                Me.ColumnaGridGL.Columns.Clear()
                ColumnaGridGL.VisibleIndex = "2"
                ColumnaGridGL.FooterCellStyle.Font.Bold = True
            End If

            If vNombreColumna = "cuenta_interna" Then
                ColumnaGridGL.Visible = False
                DS = fnc.TraeDatosConsulta("SELECT numerodecuenta As cuenta_interna,descripcion from catcon", "ConexionGENDES")
                Me.ColumnaCombo2.PropertiesComboBox.Columns.Clear()
                ColumnaCombo2.FieldName = "cuenta_interna"
                ColumnaCombo2.Caption = "CUENTA  INTERNA / DESCRIPCIÓN"
                ColumnaCombo2.ShowInCustomizationForm = True
                ColumnaCombo2.VisibleIndex = "3"
                ColumnaCombo2.PropertiesComboBox.DataSource = DS
                ColumnaCombo2.PropertiesComboBox.Columns.Add("cuenta_interna").Caption = "NO. CUENTA"
                ColumnaCombo2.PropertiesComboBox.Columns.Add("descripcion").Caption = "DESCRIPCIÓN"
                ColumnaCombo2.PropertiesComboBox.TextFormatString = "{0} / {1}"
                    'ColumnaCombo2.PropertiesComboBox.ClientSideEvents.SelectedIndexChanged = "function(s, e) { LlenaCuenta(); }"
                    ColumnaCombo2.PropertiesComboBox.ValueField = "cuenta_interna"
                    GVMatriz1.Columns.Add(ColumnaCombo2)
                End If
                'If vNombreColumna = "cuenta_interna" Then
                '    DS = fnc.TraeDatosConsulta("SELECT numerodecuenta As cuenta_interna,descripcion from catcon", "ConexionGENDES")
                '    ColumnaCombo3.FieldName = "cuenta_interna"
                '    ColumnaCombo3.Caption = "DESCRIPCIÓN"
                '    ColumnaCombo3.ShowInCustomizationForm = True
                '    ColumnaCombo3.VisibleIndex = "3"
                '    ColumnaCombo3.PropertiesComboBox.DataSource = DS
                '    ColumnaCombo3.PropertiesComboBox.TextField = "descripcion"
                '    ColumnaCombo3.PropertiesComboBox.ClientSideEvents.SelectedIndexChanged = "function(s, e) { LlenaDescripcion(); }"
                '    ColumnaCombo3.PropertiesComboBox.ValueField = "cuenta_interna"
                '    GVMatriz1.Columns.Add(ColumnaCombo3)
                'End If

                ColumnaGridGL.FieldName = vfieldName
            GVMatriz1.Columns.Add(ColumnaGridGL)
        Next

        GVMatriz1.DataSource = tabla
        GVMatriz1.DataBind()
        GVMatriz1.Columns.Add(ColumnaGrid)
        GVMatriz1.Settings.ShowHeaderFilterButton = True
        GVMatriz1.Settings.ShowFilterRowMenuLikeItem = True
        GVMatriz1.Settings.ShowHeaderFilterBlankItems = True
        GVMatriz1.SettingsPager.PageSize = 15

        If vNombreColumna = "Porcentaje_prorrateo" Then

            Dim totalSummary As ASPxSummaryItem = New ASPxSummaryItem()

            GVMatriz1.Settings.ShowFooter = True 'Mostrar Summary                       

            totalSummary.FieldName = ColumnaGridGL.FieldName

            totalSummary.ShowInColumn = "Porcentaje_prorrateo"

            totalSummary.DisplayFormat = "Total porcentaje: {0:}"

            totalSummary.SummaryType = SummaryItemType.Sum 'Importar Librería Data.

            GVMatriz1.TotalSummary.Add(totalSummary)


        End If

    End Sub
    'Protected Sub GVMatriz1_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs) Handles GVMatriz1.CustomCallback
    '    If e.Parameters.Equals("Actualizar") Then
    '        ConfiguraGridMatriz1()
    '        'LlenaGrid() ' esta comentado
    '    End If
    'End Sub

    Protected ReadOnly Property GridData As List(Of GridDataItem)
        Get
            Dim key = "34FAA454-CF92-4882-9401-93F6AAE81239"
            If Not IsPostBack OrElse Session(key) Is Nothing Then Session(key) = Enumerable.Range(0, 3000).[Select](Function(i) New GridDataItem With
                {.Id = Convert.ToInt32(i),
                .IDCentroC = 0,
                .CuentaIn = "NULL",
                .PProrrateo = 0
                 }).ToList()
            Return CType(Session(key), List(Of GridDataItem))
        End Get
    End Property
    Public Class GridDataItem
        Public Property Id As Integer
        Public Property IDCentroC As Integer

        Public Property CuentaIn As String


        Public Property PProrrateo As Integer


    End Class

    Protected Function InsertNewItem(ByVal newValues As OrderedDictionary) As GridDataItem
        BanderaInsUpd = 1
        Dim item = New GridDataItem()
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function

    Protected Function UpdateItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
        Dim id = Convert.ToInt16(keys("id_tipogasto"))
        concepto = id
        Dim item = GridData.First(Function(i) i.id = id)
        BanderaInsUpd = 2
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function

    Protected Function DeleteItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
        Dim id = Convert.ToInt16(keys("id_tipogasto"))
        concepto = id
        Dim item = GridData.First(Function(i) i.id = id)
        BanderaInsUpd = 3
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function

    Protected Sub GVMatriz1_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs) Handles GVMatriz1.BatchUpdate
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
        Me.GVMatriz1.DataSource = Nothing
        Me.GVMatriz1.DataBind()
        Me.GVMatriz1.Selection.UnselectAll()
        Me.GVMatriz1.CancelEdit()
        Me.GVMatriz1.FocusedRowIndex = -1
        ConfiguraGridMatriz1()

    End Sub

    Protected Sub LoadNewValues(ByVal item As GridDataItem, ByVal values As OrderedDictionary, ByVal Optional bandera As Integer = 0)

        Dim llaves As String = ""
        Dim llaves2 As String = ""
        Dim R() As String
        Dim R2() As String


        item.Id = Convert.ToInt16(values("id_tipogasto"))
        item.IDCentroC = Convert.ToInt16(values("ID_centro_costo"))
        item.CuentaIn = Convert.ToString(values("cuenta_interna"))

        item.PProrrateo = Convert.ToInt16(values("Porcentaje_prorrateo"))


        Dim id = item.id
        Dim IDCentroC = item.IDCentroC
        Dim CuentaIn = item.CuentaIn

        Dim PProrrateo = item.PProrrateo


        cadena =
            CuentaIn.ToString() + "|" +
            "NULL" + "|" +
         "NULL" + "|" +
          "NULL" + "|" +
          "NULL" + "|" +
          PProrrateo.ToString() + "|" +
            "0" + "|" +
            "NULL"

        llaves = id.ToString() + "|" + IDCentroC.ToString()

        'Inserta Registro.
        If bandera = 1 Then

            Resultado = fnc.Grid_Alta(65, cadena, llaves, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R = Resultado.Split("|")
            If R(0) = 0 Then
                GVMatriz1.JSProperties("cpAccion") = "Registro Insertado con éxito."
            ElseIf R(0) = 2627 Then
                GVMatriz1.JSProperties("cpAccion") = "El registro a incluir ya existe"
            Else
                GVMatriz1.JSProperties("cpAccion") = Resultado
            End If


            'Actualiza Registro.
        ElseIf bandera = 2 Then
            llaves2 = concepto.ToString() + "|" + IDCentroC.ToString()
            Resultado = fnc.Grid_Alta(65, cadena, llaves, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")
            If R2(0) = 0 Then
                Resultado = fnc.Grid_Elimina(65, llaves2, 0, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
                If Resultado = "0" Then
                    GVMatriz1.JSProperties("cpAccion") = "Registro actualizado con éxito."
                Else
                    GVMatriz1.JSProperties("cpAccion") = "Registro no actualizado."
                End If
            Else
                GVMatriz1.JSProperties("cpAccion") = R2(0)
            End If
            'Elimina Registro.
        ElseIf bandera = 3 Then
            llaves2 = concepto.ToString() + "|" + IDCentroC.ToString()
            Resultado = fnc.Grid_Elimina(65, llaves2, 0, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            If Resultado = "0" Then
                GVMatriz1.JSProperties("cpAccion") = "Registro eliminado con éxito."
            Else
                GVMatriz1.JSProperties("cpAccion") = Resultado
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

End Class
