Imports WsSeguridad
Imports DevExpress.Web
Imports System.Data.SqlClient
Imports System.Data
Imports Microsoft.VisualBasic
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Windows.Forms
Partial Class Funcionalidad_ConceptoDeIngresos
    Inherits System.Web.UI.Page

    Private Servicio As New WsSeguridad.Seguridad
    Public vSistema As String = System.Configuration.ConfigurationManager.AppSettings.Item("sistema")
    Public vEmpresa As String = System.Configuration.ConfigurationManager.AppSettings.Item("empresa")
#Region "Variables Globales"
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
#End Region

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'Variable de Sesión
            If Session("sCliente") Is Nothing Then
                Response.Buffer = True
                Response.Clear()
                Response.Redirect("../Framework/Acceso.aspx")
            End If
            VerificaAccesos("ConceptoDeIngresos")

            'Habilita Botones Encabezado JS.
            HabBotonesPrinc()
            txtIdPar.Text = Request.QueryString("IdTab")

            'Carga Función LlenarBusqueda en el Glookup
            glBusqueda.Columns.Clear()
            LlenarBusqueda()


            'VALIDACIÓN PARA LOS PARAMETROS
            If txtIdPar.Text <> "" Then
                glBusqueda.Visible = False
                glBusquedaPar.Visible = True
                txtIdPar.Focus()
            Else
                glBusqueda.Visible = True
                glBusquedaPar.Visible = False
            End If
        Else
            If txtBandera.Text = "Nuevo" Then
                glBusqueda.JSProperties("cpNuevo") = "ok"
            End If
            If (glBusqueda.Text <> "" Or glBusquedaPar.Text <> "") Or (glBusqueda.Text = "" Or glBusquedaPar.Text = "") Then

                LlenarBusqueda()

            End If
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

    Protected Sub cbActualizar_Callback(source As Object, e As CallbackEventArgs) Handles cbActualizar.Callback
        Dim cat As String = ""
        Dim dato As String = ""
        Dim id As Int32
        cat = Convert.ToString(glBusqueda.Value())
        cat = ConsultaCataId()
        dato = Convert.ToString(txtDescripcion.Text.Trim())
        Dim R() As String
        Dim R2() As String

        'CONCATENA LOS CONTROLES DEL FORMULARIO 
        cadena =
        txtNoConcepto.Text + "|" +
        txtDescripcion.Text + "|" +
        cmbContexto.Text + "|" +
        "0" + "|" +
        "NULL" + "|" +
        "NULL" + "|" +
        "NULL"

        If (btnAgregar.Checked = False) And (btnEditar.Checked = True) Then
            id = Convert.ToInt32(txtNoConcepto.Text)
            Resultado = fnc.Fun_Edita(cat, cadena, id, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R = Resultado.Split("|")
            If R(0) = "0" Then
                cbActualizar.JSProperties("cpAccion") = "Registro actualizado con éxito."
            Else
                cbActualizar.JSProperties("cpAccion") = Resultado
            End If
            'Validación INSERTA DATOS
        ElseIf (btnAgregar.Checked = True) And (btnEditar.Checked = False) Then
            Resultado = fnc.Fun_Nuevo(cat, cadena, 2, dato, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")
            If R2(0) = "0" Then
                cbActualizar.JSProperties("cpAccion") = "Registro agregado con éxito."
            Else
                cbActualizar.JSProperties("cpAccion") = Resultado
            End If
        End If

    End Sub

    Protected Sub cbEliminar_Callback(source As Object, e As CallbackEventArgs) Handles cbEliminar.Callback
        'Variables
        Dim cat As String = ""
        Dim id As Int32 = Convert.ToInt32(txtNoConcepto.Text)
        cat = Convert.ToString(glBusqueda.Value())
        cat = ConsultaCataId()

        'Envía parámetros a SP "Spu_UtilDelete"
        Resultado = fnc.Fun_Elimina(cat, id, 1, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
        If Resultado = "0" Then
            cbEliminar.JSProperties("cpAccionE") = "Registro eliminado con éxito."
        End If
    End Sub

    Public Function ConsultaCataId() As String
        'Ésta función le da valor a cat conforme al campo registrado en FormularioInd.
        'Variables
        Dim cat As String = ""
        consulta = "SELECT idCatalogo FROM catCatalogosGenTbl where FormularioInd = 'ConceptoDeIngresos.aspx'"

        DSTipoDato = fnc.ObtenDataSet("obtenCampo", consulta, "ConexionDBS")
        dtTipoDato = DSTipoDato.Tables(0)
        For Each row As DataRow In dtTipoDato.Rows
            cat = row("idCatalogo").ToString
        Next
        Return cat
    End Function

    Public Sub LlenarBusqueda()
        glBusqueda.Columns.Clear()

        tabla = fnc.TraeDatosConsulta("SELECT * FROM conceptos_ingresos", "ConexionDBS")


        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColumnas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGridt = New GridViewDataTextColumn
                    ColumnaGridt.Caption = vNombreColumna

                    If ColumnaGridt.Caption = "id_conceptosIngresos" Then
                        ColumnaGridt.Caption = "Id Concepto de Ingresos"
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

    Public Sub VerificaAccesos(ByVal txtFormulario As Object)
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