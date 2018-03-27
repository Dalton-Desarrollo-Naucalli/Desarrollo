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
Partial Class Funcionalidad_ConceptoDeEgresos
    Inherits System.Web.UI.Page
    Private Servicio As New WsSeguridad.Seguridad
    Public vSistema As String = System.Configuration.ConfigurationManager.AppSettings.Item("sistema")
    Public vEmpresa As String = System.Configuration.ConfigurationManager.AppSettings.Item("empresa")
#Region "Variables Globales"
    Dim ColumnaGrid As New GridViewCommandColumn
    Dim ColumnaGridGL As New GridViewDataTextColumn
    Dim ColumnaCombo As New GridViewDataComboBoxColumn
    Dim ColumnaCombo2 As New GridViewDataComboBoxColumn

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
    Dim IdZona As String
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
            VerificaAccesos("ConceptoDeEgresos")
            ConfiguraGridZonaFis()

            'Habilita Botones Encabezado JS.
            HabBotonesPrinc()

            'Carga Función LlenarBusqueda en el Glookup
            glBusqueda.Columns.Clear()
            LlenarBusqueda()
            LlenaCombos()

        Else
            LlenarBusqueda()
            ConfiguraGridZonaFis()

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

    Private Sub LlenaCombos()
        'Éste método carga los combos de cada tabla independientes en el formulario mediante WS.
        Dim DS As DataSet
        'Se llena el combo de Zona Fiscal (Inicio)
        DS = New DataSet
        Dim fncion = New WsFuncionalidad.Funcionalidad

        'Llenar cmbCentroCostos
        DS = fncion.TraeDatosConsulta("Select 0 as ID, 'SELECCIONAR...' as Descripcion union all Select ID_Centro_Costo as ID, Descripcion as Descripcion from Centro_de_Costos order by 1", "ConexionDBS")
        Me.cmbCentroCostos.DataSource = DS
        Me.cmbCentroCostos.ValueField = "ID"
        Me.cmbCentroCostos.TextField = "Descripcion"
        Me.cmbCentroCostos.DataBind()
        Me.cmbCentroCostos.SelectedIndex = 0


        DS = fncion.TraeDatosConsulta("Select 0 as ID, 'SELECCIONAR...' as Descripcion union all Select id_tipogasto as ID, descripcion as Descripcion from conceptos_gastos order by 1", "ConexionDBS")
        Me.cmbTipoGastoProvision.DataSource = DS
        Me.cmbTipoGastoProvision.ValueField = "ID"
        Me.cmbTipoGastoProvision.TextField = "Descripcion"
        Me.cmbTipoGastoProvision.DataBind()
        Me.cmbTipoGastoProvision.SelectedIndex = 0

        DS = fncion.TraeDatosConsulta("Select 0 as ID, 'SELECCIONAR...' as Descripcion union all Select id_tipogasto as ID, descripcion as Descripcion from conceptos_gastos order by 1", "ConexionDBS")
        Me.cmbTipoGastoProrrateo.DataSource = DS
        Me.cmbTipoGastoProrrateo.ValueField = "ID"
        Me.cmbTipoGastoProrrateo.TextField = "Descripcion"
        Me.cmbTipoGastoProrrateo.DataBind()
        Me.cmbTipoGastoProrrateo.SelectedIndex = 0

        Dim parametro As String = fnc.Parametro(46, "ConexionDBS")
        DS = fncion.TraeDatosConsulta("Select DISTINCT numerodecuenta, descripcion FROM Catcon WHERE moneda_mex=" + parametro + " And Right(numerodecuenta,6)<>000000 ORDER BY numerodecuenta", "ConexionGENDES")
        Me.cmbEgresos.DataSource = DS
        Me.cmbEgresos.ValueField = "numerodecuenta"
        Me.cmbEgresos.TextField = "descripcion"
        Me.cmbEgresos.DataBind()
        Me.cmbEgresos.SelectedIndex = 0

        Me.cmbIngresos.DataSource = DS
        Me.cmbIngresos.ValueField = "numerodecuenta"
        Me.cmbIngresos.TextField = "descripcion"
        Me.cmbIngresos.DataBind()
        Me.cmbIngresos.SelectedIndex = 0

        Me.cmbDevoluciones.DataSource = DS
        Me.cmbDevoluciones.ValueField = "numerodecuenta"
        Me.cmbDevoluciones.TextField = "descripcion"
        Me.cmbDevoluciones.DataBind()
        Me.cmbDevoluciones.SelectedIndex = 0

        Me.cmbImpEspecial.DataSource = DS
        Me.cmbImpEspecial.ValueField = "numerodecuenta"
        Me.cmbImpEspecial.TextField = "descripcion"
        Me.cmbImpEspecial.DataBind()
        Me.cmbImpEspecial.SelectedIndex = 0

        Me.cmbIvaPend.DataSource = DS
        Me.cmbIvaPend.ValueField = "numerodecuenta"
        Me.cmbIvaPend.TextField = "descripcion"
        Me.cmbIvaPend.DataBind()
        Me.cmbIvaPend.SelectedIndex = 0

        Me.cmbIvaPagado.DataSource = DS
        Me.cmbIvaPagado.ValueField = "numerodecuenta"
        Me.cmbIvaPagado.TextField = "descripcion"
        Me.cmbIvaPagado.DataBind()
        Me.cmbIvaPagado.SelectedIndex = 0

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
            id = Convert.ToInt32(txtTipoGasto.Text)
        End If

        'Envía parámetros a SP "Spu_UtilDelete"

        Resultado = fnc.Fun_Elimina(51, id, 1, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
        If Resultado = "0" Then
            cbEliminar.JSProperties("cpAccionE") = "Registro eliminado con éxito."
            cbEliminar.JSProperties("cpClear") = "0"
        Else
            cbEliminar.JSProperties("cpClear") = "1"
            cbEliminar.JSProperties("cpAccionE") = "No hay registros que eliminar."
        End If

    End Sub
#End Region

    Public Sub LlenarBusqueda()
        'Este método llena el Gridlookup de Búsqueda mediante WS.
        glBusqueda.Columns.Clear()
        tabla = fnc.TraeDatosConsulta("SELECT * FROM conceptos_gastos WHERE borradoLogico = 0", "ConexionDBS")


        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColumnas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGridt = New GridViewDataTextColumn
                    ColumnaGridt.Caption = vNombreColumna

                    If ColumnaGridt.Caption = "id_tipogasto" Then
                        ColumnaGridt.Caption = "ID Concepto"
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

    Public Sub ValidaControles()

        Dim Control As UI.Control

        For Each Control In rpConceptoEgresos.Controls
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

        For Each Control In ASPxRoundPanel6.Controls
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

    Private Sub ConfiguraGridZonaFis()
        Dim id_tipog As String = ""
        GVZonaFis.Columns.Clear()
        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim DS As DataSet
        DS = New DataSet
        'Si la variable global viene Vacía, entonces se da valor a la variable prod_id de lo que traiga el Gridlookup de Búsqueda,
        'De lo contrario le asigna lo que trae la variable Global a la variable prod_id y le pone el ID nuevo a la caja de Texto txtNoProducto.
        If idnew_Global = Nothing Then
            id_tipog = Convert.ToString(glBusqueda.Value())
        Else
            id_tipog = idnew_Global
            GVZonaFis.JSProperties("cpConceptoE") = idnew_Global
        End If

        If id_tipog = "" Then
            consulta = "SELECT zona_fiscal_id As ZF,id_tipogasto As TIPOG,porcentaje_iva,porcentaje_imp_esp,otro_impuesto FROM zona_fiscal_concepto WHERE id_tipogasto = '-1'"
            tabla = fnc.TraeDatosConsulta(consulta, "ConexionDBS")
            dtOpciones = tabla.Tables("Table")
        Else
            consulta = "SELECT zona_fiscal_id As ZF,id_tipogasto As TIPOG,porcentaje_iva,porcentaje_imp_esp,otro_impuesto FROM zona_fiscal_concepto WHERE id_tipogasto =" + id_tipog
            tabla = fnc.TraeDatosConsulta(consulta, "ConexionDBS")
            dtOpciones = tabla.Tables("Table")
        End If

        VerificaAccesos("ConceptoDeEgresos")

        NumeroColumnas = tabla.Tables(0).Columns.Count - 1
        NumeroRenglones = tabla.Tables(0).Rows.Count - 1

        For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

            vfieldName = tabla.Tables(0).Columns(j).ColumnName
            vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
            ColumnaGridGL = New GridViewDataTextColumn
            ColumnaGridGL.Caption = vNombreColumna
            If ColumnaGridGL.Caption = "TIPOG" Then
                ColumnaGridGL.Visible = False
                ColumnaGridGL.ReadOnly = True
                ColumnaGridGL.VisibleIndex = "0"
            Else

                ColumnaGridGL.Caption = fnc.ObtenEtiquetaCatCampos(vNombreColumna, 63, "ConexionDBS")
            End If


            If vNombreColumna = "ZF" Then
                ColumnaGridGL.Visible = False
                DS = fnc.TraeDatosConsulta("SELECT zona_fiscal_id,nombre FROM zona_fiscal where borradoLogico = 0 ", "ConexionDBS")
                ColumnaCombo.FieldName = "ZF"
                ColumnaCombo.Caption = "ZONA FISCAL"
                ColumnaCombo.ShowInCustomizationForm = True
                ColumnaCombo.VisibleIndex = "1"
                ColumnaCombo.PropertiesComboBox.DataSource = DS
                ColumnaCombo.PropertiesComboBox.TextField = "nombre"
                ColumnaCombo.PropertiesComboBox.ValueField = "zona_fiscal_id"
                GVZonaFis.Columns.Add(ColumnaCombo)
            End If

            ColumnaGridGL.FieldName = vfieldName
            GVZonaFis.Columns.Add(ColumnaGridGL)
        Next



        GVZonaFis.DataSource = tabla
        GVZonaFis.DataBind()
        GVZonaFis.Columns.Add(ColumnaGrid)

    End Sub

    Protected Sub GVZonaFis_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs) Handles GVZonaFis.CustomCallback
        If e.Parameters.Equals("Actualizar") Then
            ConfiguraGridZonaFis()
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

    Private Sub CargaCallback()
        'Variables
        Dim dato As String = ""
        Dim id As Int32
        dato = Convert.ToString(txtDescripcion.Text.Trim())
        Dim R() As String
        Dim R2() As String

        'CONCATENA LOS CONTROLES DEL FORMULARIO 

        cadena =
        txtDescripcion.Text + "|" +
        cmbTipoProrrateo.Value + "|" +
        txtIVA.Text + "|" +
        rblSujetoRetencionISR.Value + "|" +
        "NULL" + "|" +
        "NULL" + "|" +
        "NULL" + "|" +
        "NULL" + "|" +
        rblSujetoRetencionIVA.Value + "|" +
        cmbTipoGastoProvision.Value + "|" +
        cmbTipoConcepto.Value + "|" +
        rblPresupuestoBaseFacturado.Value + "|" +
        cmbIvaPend.Value + "|" +
        txtRetISR.Text + "|" +
        txtRetIvaCCH.Text + "|" +
        txtRetIva.Text + "|" +
        cmbIngresos.Text + "|" +
        rblProrrateoFacturacion.Value + "|" +
        cmbTipoGastoProrrateo.Value + "|" +
        cmbCentroCostos.Value + "|" +
        cmbEgresos.Value + "|" +
        txtRetIvaCTR.Text + "|" +
        cmbIvaPagado.Value + "|" +
        txtImpEsp.Text + "|" +
        cmbImpEspecial.Value + "|" +
        cmbDevoluciones.Value + "|" +
        txtRetencionIVA.Text + "|" +
        rblAplicaPersonas.Value + "|" +
        rblAplRegContableConcepto.Value + "|" +
        "0" + "|" +
        "NULL"

        'Validación ACTUALIZA DATOS
        If (btnAgregar.Checked = False) And (btnEditar.Checked = True) Then
            id = Convert.ToInt32(txtTipoGasto.Text)
            Resultado = fnc.Fun_Edita(51, cadena, id, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R = Resultado.Split("|")
            If R(0) = "0" Then
                cbActualizar.JSProperties("cpAccion") = "Registro actualizado con éxito."
            Else
                cbActualizar.JSProperties("cpAccion") = Resultado
            End If
            'Validación INSERTA DATOS
        ElseIf (btnAgregar.Checked = True) And (btnEditar.Checked = False) Then
            Resultado = fnc.Fun_Nuevo(51, cadena, 2, dato, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")

            If R2(0) <> "0" Then 'Valida cualquier error distinto a cero.
                cbActualizar.JSProperties("cpAccion") = Resultado
            Else
                cbActualizar.JSProperties("cpAccion") = "Registro insertado correctamente" 'Inserta correctamente.
                cbActualizar.JSProperties("cpConceptoE") = R2(1)
                idnew_Global = R2(1)
            End If
        End If
    End Sub

#Region "BatchUpdate"

    Protected ReadOnly Property GridData As List(Of GridDataItem)
        Get
            Dim key = "34FAA454-CF92-4882-9401-93F6AAE81293"
            If Not IsPostBack OrElse Session(key) Is Nothing Then Session(key) = Enumerable.Range(0, 3000).[Select](Function(i) New GridDataItem With
                {.id = Convert.ToInt32(i),
                 .zona_fiscal_id = 0,
                 .porcentaje_iva = 0,
                 .porcentaje_imp_esp = 0,
                 .otro_impuesto = 0
                 }).ToList()
            Return CType(Session(key), List(Of GridDataItem))
        End Get
    End Property
    Public Class GridDataItem
        Public Property id As Integer
        Public Property zona_fiscal_id As Integer
        Public Property porcentaje_iva As Integer
        Public Property porcentaje_imp_esp As Integer
        Public Property otro_impuesto As Integer


    End Class
    Protected Function InsertNewItem(ByVal newValues As OrderedDictionary) As GridDataItem
        BanderaInsUpd = 1
        Dim item = New GridDataItem()
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Function UpdateItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
        Dim IDZo = Convert.ToInt16(keys("ZF"))
        IdZona = IDZo
        Dim item = GridData.First(Function(i) i.id = IDZo)
        BanderaInsUpd = 2
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Function DeleteItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
        Dim IDZ = Convert.ToInt16(keys("ZF"))
        IdZona = IDZ
        Dim item = GridData.First(Function(i) i.id = IDZ)
        BanderaInsUpd = 3
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Sub GVZonaFis_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs) Handles GVZonaFis.BatchUpdate
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
        Me.GVZonaFis.DataSource = Nothing
        Me.GVZonaFis.DataBind()
        Me.GVZonaFis.Selection.UnselectAll()
        Me.GVZonaFis.CancelEdit()
        Me.GVZonaFis.FocusedRowIndex = -1
        ConfiguraGridZonaFis()

    End Sub
    Protected Sub LoadNewValues(ByVal item As GridDataItem, ByVal values As OrderedDictionary, ByVal Optional bandera As Integer = 0)


        Dim llaves As String = ""
        Dim llaves2 As String = ""
        Dim R() As String
        Dim R2() As String
        Dim IDControl As String

        If idnew_Global = Nothing Then
            IDControl = txtTipoGasto.Text
        Else
            IDControl = idnew_Global
        End If

        item.id = IDControl
        item.zona_fiscal_id = Convert.ToInt16(values("ZF"))
        item.porcentaje_iva = Convert.ToInt16(values("porcentaje_iva"))
        item.porcentaje_imp_esp = Convert.ToInt16(values("porcentaje_imp_esp"))
        item.otro_impuesto = Convert.ToInt16(values("otro_impuesto"))

        Dim id = item.id
        Dim Zona_fiscal = item.zona_fiscal_id
        Dim Iva = item.porcentaje_iva
        Dim Imp = item.porcentaje_imp_esp
        Dim Otro = item.otro_impuesto

        cadena =
            Iva.ToString() + "|" +
            Imp.ToString() + "|" +
            Otro.ToString() + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "0" + "|" +
            "NULL"

        llaves = Zona_fiscal.ToString() + "|" + id.ToString()
        'Inserta Registro.
        If bandera = 1 Then
            Resultado = fnc.Grid_Alta(63, cadena, llaves, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            R = Resultado.Split("|")
            If R(0) = 0 Then
                GVZonaFis.JSProperties("cpAccion") = "Registro Insertado con éxito."
                GVZonaFis.JSProperties("cpnewId") = idnew_Global
            Else
                GVZonaFis.JSProperties("cpAccion") = Resultado
            End If

            'Actualiza Registro.
        ElseIf bandera = 2 Then
            llaves2 = IdZona.ToString() + "|" + id.ToString()
            Resultado = fnc.Grid_Alta(63, cadena, llaves, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")
            If R2(0) = 0 Then
                Resultado = fnc.Grid_Elimina(63, llaves2, 0, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
                If Resultado = "0" Then
                    GVZonaFis.JSProperties("cpAccion") = "Registro actualizado con éxito."
                Else
                    GVZonaFis.JSProperties("cpAccion") = "Registro no actualizado."
                End If

            Else
                GVZonaFis.JSProperties("cpAccion") = R2(0)
            End If


            'Elimina Registro.
        ElseIf bandera = 3 Then
            llaves2 = IdZona.ToString() + "|" + id.ToString()
            Resultado = fnc.Grid_Elimina(63, llaves2, 0, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            If Resultado = "0" Then
                GVZonaFis.JSProperties("cpAccion") = "Registro eliminado con éxito."
            Else
                GVZonaFis.JSProperties("cpAccion") = Resultado
            End If
        End If

    End Sub

#End Region


End Class