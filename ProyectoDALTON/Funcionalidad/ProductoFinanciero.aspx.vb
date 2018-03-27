Imports WsSeguridad
Imports DevExpress.Web
Imports System.Data.SqlClient
Imports System.Data
Imports Microsoft.VisualBasic
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Windows.Forms


Partial Class Funcionalidad_ProductoFinanciero
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
            VerificaAccesos("ProductoFinanciero")
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
            'Variables
            Dim dato As String = ""
            Dim id As Int32
            dato = Convert.ToString(txtProducto.Text.Trim())
            Dim R() As String
            Dim R2() As String


            '        CONCATENA LOS CONTROLES DEL FORMULARIO 
            cadena =
            cmbTipoContrato.Value + "|" +
            cmbMoneda.Value + "|" +
            cmbCtaRecProp.Value + "|" +
            cmbTasaBase.Value + "|" +
            txtProducto.Text + "|" +
            txtDescCorta.Text + "|" +
            cmbPlazoMax.Value + "|" +
            txtPlazomaxtime.Text + "|" +
            cmbPlazoMin.Value + "|" +
            txtPlazomintime.Text + "|" +
            txtNoMaxDisp.Text + "|" +
            rblCambioDeudor.Value + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            txtPtsMaxTasa.Text + "|" +
            txtPtsMinTasa.Text + "|" +
            txtFacMaxTasa.Text + "|" +
            txtFacMinTasa.Text + "|" +
            rblAval.Value + "|" +
            txtFactorGrtias.Text + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            cmbOrigenRecursos.Value + "|" +
            cmbPerrevtasa.Value + "|" +
            txtPerrevtasatime.Text + "|" +
            cmbPercobint.Value + "|" +
            txtPercobinttime.Text + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            txtFacMor.Text + "|" +
            txtNumMaxRenova.Text + "|" +
            cmbPercobcapital.Value + "|" +
            txtPercobcaptime.Text + "|" +
            cmbComisionAper.Value + "|" +
            cmbComisionDisp.Value + "|" +
            cmbComisionCanc.Value + "|" +
            cmbComisionOt.Value + "|" +
            cmbAmortizacion.Value + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            cmbBaseAnual.Value + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            rblImpAnexoalContrato.Value + "|" +
            "NULL" + "|" +
            cmbTipoOperacion.Value + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            rblIvaInteres.Value + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            rblPrecioCredito.Value + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "0" + "|" +
            "NULL"

            If (btnAgregar.Checked = False) And (btnEditar.Checked = True) Then
                id = Convert.ToInt32(txtIdProducto.Text)
                Resultado = fnc.Fun_Edita(57, cadena, id, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
                R = Resultado.Split("|")
                If R(0) = "0" Then
                    cbActualizar.JSProperties("cpAccion") = "Registro actualizado con éxito."
                Else
                    cbActualizar.JSProperties("cpAccion") = Resultado
                End If
                'Validación INSERTA DATOS
            ElseIf (btnAgregar.Checked = True) And (btnEditar.Checked = False) Then
                Resultado = fnc.Fun_Nuevo(57, cadena, 6, dato, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
                R2 = Resultado.Split("|")
                If R2(0) = "0" Then
                    cbActualizar.JSProperties("cpAccion") = "Registro agregado con éxito."
                    cbActualizar.JSProperties("cpNoMovimiento") = R2(1)
                    idnew_Global = R2(1)
                Else
                    cbActualizar.JSProperties("cpAccion") = Resultado
                End If
            End If

        End Sub



        Protected Sub cbEliminar_Callback(source As Object, e As CallbackEventArgs) Handles cbEliminar.Callback
            'Variables

            Dim id As Int32
            If glBusqueda.Value <> Nothing Then
                id = Convert.ToInt32(txtIdProducto.Text)
            End If

            'Envía parámetros a SP "Spu_UtilDelete"

            Resultado = fnc.Fun_Elimina(57, id, 5, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
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
        For Each Control In ASPxRoundPanel3.Controls
            If Control.[GetType]() = GetType(ASPxTextBox) Then
                Dim txt As ASPxTextBox = CType(Control, ASPxTextBox)
                If txt.Text = "" Then
                    txt.Text = "NULL"
                End If
            ElseIf Control.[GetType]() = GetType(ASPxComboBox) Then
                Dim cmb As ASPxComboBox = CType(Control, ASPxComboBox)
                If cmb.Value = "" Then
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
            tabla = fnc.TraeDatosConsulta("select * from SIIFI_producto_financiero where borradoLogico = 0", "ConexionDBS")


            If tabla.Tables.Count > 0 Then
                If tabla.Tables(0).Rows.Count > 0 Then
                    NumeroColumnas = tabla.Tables(0).Columns.Count - 1
                    NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                    For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

                        vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                        vfieldName = tabla.Tables(0).Columns(j).ColumnName
                        ColumnaGridt = New GridViewDataTextColumn
                        ColumnaGridt.Caption = vNombreColumna

                        If ColumnaGridt.Caption = "Prod_fin_id" Then
                            ColumnaGridt.Caption = "ID"
                            ColumnaGridt.Visible = False
                        ElseIf ColumnaGridt.Caption = "producto" Then
                            ColumnaGridt.Caption = "Producto"
                            ColumnaGridt.Visible = True
                        ElseIf ColumnaGridt.Caption = "descripcorta" Then
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

            'Se llena el combo MonedA
            DS = fncion.TraeDatosConsulta("Select  moneda_id , nombre  from moneda where borradoLogico = 0 order by moneda_id", "ConexionDBS")
        'Combo
        'Me.cmbCategoria.ClientEnabled = False

        Me.cmbMoneda.DataSource = DS
        cmbMoneda.NullText = "SELECCIONAR..."
        Me.cmbMoneda.ValueField = "moneda_id"
            Me.cmbMoneda.TextField = "nombre"
            Me.cmbMoneda.DataBind()
        Me.cmbMoneda.SelectedIndex = -1




        DS = fncion.TraeDatosConsulta("Select numerodecuenta as ID from CatCon order by ID", "ConexionGENDES")
        'Combo
        'Me.cmbCategoria.ClientEnabled = False
        Me.cmbCtaRecProp.DataSource = DS
        Me.cmbCtaRecProp.NullText = "SELECCIONAR..."
        Me.cmbCtaRecProp.ValueField = "ID"
            Me.cmbCtaRecProp.TextField = "ID"
            Me.cmbCtaRecProp.DataBind()
        Me.cmbCtaRecProp.SelectedIndex = -1


        DS = fncion.TraeDatosConsulta("Select tasa_id, tasa  from siifi_tasa where borradoLogico = 0 order by tasa_id", "ConexionDBS")
        'Combo
        'Me.cmbCategoria.ClientEnabled = False
        Me.cmbTasaBase.DataSource = DS
        Me.cmbTasaBase.NullText = "SELECCIONAR..."
        Me.cmbTasaBase.ValueField = "tasa_id"
            Me.cmbTasaBase.TextField = "tasa"
            Me.cmbTasaBase.DataBind()
        Me.cmbTasaBase.SelectedIndex = -1


        DS = fncion.CatGrals("SIIFI_producto_financiero", "plazomax", 0, "", "", 40, "", "", "", 0, "", "ConexionDBS")
        'Combo
        Me.cmbPlazoMax.DataSource = DS
        Me.cmbPlazoMax.NullText = "SELECCIONAR..."
        Me.cmbPlazoMax.ValueField = "valorAdicional"
            Me.cmbPlazoMax.TextField = "descripcion"
            Me.cmbPlazoMax.DataBind()
        Me.cmbPlazoMax.SelectedIndex = -1


        DS = fncion.CatGrals("SIIFI_producto_financiero", "plazomin", 0, "", "", 40, "", "", "", 0, "", "ConexionDBS")
        'Combo
        Me.cmbPlazoMin.DataSource = DS
        Me.cmbPlazoMin.NullText = "SELECCIONAR..."
        Me.cmbPlazoMin.ValueField = "valorAdicional"
            Me.cmbPlazoMin.TextField = "descripcion"
            Me.cmbPlazoMin.DataBind()
        Me.cmbPlazoMin.SelectedIndex = -1

        DS = fncion.CatGrals("SIIFI_producto_financiero", "origenrec", 0, "", "", 40, "", "", "", 0, "", "ConexionDBS")
        'Combo
        'Me.cmbCategoria.ClientEnabled = False
        Me.cmbOrigenRecursos.DataSource = DS
        Me.cmbOrigenRecursos.NullText = "SELECCIONAR..."
        Me.cmbOrigenRecursos.ValueField = "valor"
            Me.cmbOrigenRecursos.TextField = "descripcion"
            Me.cmbOrigenRecursos.DataBind()
        Me.cmbOrigenRecursos.SelectedIndex = -1

        DS = fncion.CatGrals("SIIFI_producto_financiero", "perrevtasa", 0, "", "", 40, "", "", "", 0, "", "ConexionDBS")
        'Combo
        Me.cmbPerrevtasa.DataSource = DS
        Me.cmbPerrevtasa.NullText = "SELECCIONAR..."
        Me.cmbPerrevtasa.ValueField = "valorAdicional"
            Me.cmbPerrevtasa.TextField = "descripcion"
            Me.cmbPerrevtasa.DataBind()
        Me.cmbPerrevtasa.SelectedIndex = -1

        DS = fncion.CatGrals("SIIFI_producto_financiero", "percobint", 0, "", "", 40, "", "", "", 0, "", "ConexionDBS")
        'Combo
        Me.cmbPercobint.DataSource = DS
        Me.cmbPercobint.NullText = "SELECCIONAR..."
        Me.cmbPercobint.ValueField = "valorAdicional"
            Me.cmbPercobint.TextField = "descripcion"
            Me.cmbPercobint.DataBind()
        Me.cmbPercobint.SelectedIndex = -1

        DS = fncion.CatGrals("SIIFI_producto_financiero", "percobcapital", 0, "", "", 40, "", "", "", 0, "", "ConexionDBS")
        'Combo
        Me.cmbPercobcapital.DataSource = DS
        Me.cmbPlazoMax.NullText = "SELECCIONAR..."
        Me.cmbPlazoMax.ValueField = "valorAdicional"
        Me.cmbPercobcapital.TextField = "descripcion"
            Me.cmbPercobcapital.DataBind()
        Me.cmbPercobcapital.SelectedIndex = -1

        DS = fncion.CatGrals("SIIFI_producto_financiero", "comxaper", 0, "", "", 40, "", "", "", 0, "", "ConexionDBS")
        'Combo
        Me.cmbComisionAper.DataSource = DS
        Me.cmbComisionAper.NullText = "SELECCIONAR..."
        Me.cmbComisionAper.ValueField = "valor"
            Me.cmbComisionAper.TextField = "descripcion"
            Me.cmbComisionAper.DataBind()
        Me.cmbComisionAper.SelectedIndex = -1

        DS = fncion.CatGrals("SIIFI_producto_financiero", "comxdisp", 0, "", "", 40, "", "", "", 0, "", "ConexionDBS")
        Me.cmbComisionDisp.DataSource = DS
        Me.cmbComisionDisp.NullText = "SELECCIONAR..."
        Me.cmbComisionDisp.ValueField = "valor"
            Me.cmbComisionDisp.TextField = "descripcion"
            Me.cmbComisionDisp.DataBind()
        Me.cmbComisionDisp.SelectedIndex = -1

        DS = fncion.CatGrals("SIIFI_producto_financiero", "comxcancel", 0, "", "", 40, "", "", "", 0, "", "ConexionDBS")
        'Combo
        Me.cmbComisionCanc.DataSource = DS
        Me.cmbComisionCanc.NullText = "SELECCIONAR..."
        Me.cmbComisionCanc.ValueField = "valor"
            Me.cmbComisionCanc.TextField = "descripcion"
            Me.cmbComisionCanc.DataBind()
        Me.cmbComisionCanc.SelectedIndex = -1

        DS = fncion.CatGrals("SIIFI_producto_financiero", "comxvarios", 0, "", "", 40, "", "", "", 0, "", "ConexionDBS")
        'Combo
        Me.cmbComisionOt.DataSource = DS
        Me.cmbComisionOt.NullText = "SELECCIONAR..."
        Me.cmbComisionOt.ValueField = "valor"
            Me.cmbComisionOt.TextField = "descripcion"
            Me.cmbComisionOt.DataBind()
        Me.cmbComisionOt.SelectedIndex = -1

        DS = fncion.CatGrals("SIIFI_producto_financiero", "critamortcap", 0, "", "", 40, "", "", "", 0, "", "ConexionDBS")
        'Combo
        Me.cmbAmortizacion.DataSource = DS
        Me.cmbAmortizacion.NullText = "SELECCIONAR..."
        Me.cmbAmortizacion.ValueField = "valor"
            Me.cmbAmortizacion.TextField = "descripcion"
            Me.cmbAmortizacion.DataBind()
        Me.cmbAmortizacion.SelectedIndex = -1

        DS = fncion.CatGrals("SIIFI_producto_financiero", "base_anual", 0, "", "", 40, "", "", "", 0, "", "ConexionDBS")
        'Combo
        Me.cmbBaseAnual.DataSource = DS
        Me.cmbBaseAnual.NullText = "SELECCIONAR..."
        Me.cmbBaseAnual.ValueField = "valor"
            Me.cmbBaseAnual.TextField = "descripcion"
            Me.cmbBaseAnual.DataBind()
        Me.cmbBaseAnual.SelectedIndex = -1

        DS = fncion.CatGrals("SIIFI_producto_financiero", "TipoOperacion", 0, "", "", 40, "", "", "", 0, "", "ConexionDBS")
        'Combo
        Me.cmbTipoOperacion.DataSource = DS
        Me.cmbTipoOperacion.NullText = "SELECCIONAR..."
        Me.cmbTipoOperacion.ValueField = "valorAdicional"
            Me.cmbTipoOperacion.TextField = "descripcion"
            Me.cmbTipoOperacion.DataBind()
        Me.cmbTipoOperacion.SelectedIndex = -1

        DS = fncion.CatGrals("SIIFI_producto_financiero", "tipoproducto", 0, "", "", 40, "", "", "", 0, "", "ConexionDBS")
        'Comboprecio_paq_vta_credito
        Me.cmbTipoContrato.DataSource = DS
        Me.cmbTipoContrato.NullText = "SELECCIONAR..."
        Me.cmbTipoContrato.ValueField = "valor"
            Me.cmbTipoContrato.TextField = "descripcion"
            Me.cmbTipoContrato.DataBind()
        Me.cmbTipoContrato.SelectedIndex = -1

        DS = fncion.CatGrals("SIIFI_producto_financiero", "mod_imp_contrato", 0, "", "", 40, "", "", "", 0, "", "ConexionDBS")
        'Combo
        Me.cmbImprimeContPag.DataSource = DS
        Me.cmbImprimeContPag.NullText = "SELECCIONAR..."
        Me.cmbImprimeContPag.ValueField = "valor"
        Me.cmbImprimeContPag.TextField = "descripcion"
        Me.cmbImprimeContPag.DataBind()
        Me.cmbImprimeContPag.SelectedIndex = -1

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
