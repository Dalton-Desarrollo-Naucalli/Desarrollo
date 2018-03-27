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
Partial Class Funcionalidad_PrelacionPagos
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
    Dim LFondeo As String
#End Region
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'Variable de Sesión
            If Session("sCliente") Is Nothing Then
                Response.Buffer = True
                Response.Clear()
                Response.Redirect("../Framework/Acceso.aspx")
            End If
            VerificaAccesos("PrelacionPagos")

            'Habilita Botones Encabezado.
            'HabBotonesPrinc()
            ConfiguraGridPrelacion()
            'Carga Función LlenarBusqueda en el Glookup
            'LlenarBusqueda()
        Else
            ConfiguraGridPrelacion()
        End If
    End Sub
    Protected Sub Page_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit
        DevExpress.Web.ASPxWebControl.GlobalTheme = Session("TemaDin")
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


    Private Sub ConfiguraGridPrelacion()
        GVPrelacion.Columns.Clear()
        GVPrelacion.Settings.ShowHeaderFilterButton = False
        GVPrelacion.Settings.ShowHeaderFilterBlankItems = False
        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim DS As DataSet
        DS = New DataSet

        consulta = "SELECT idProducto,idLineaFondeo,ordenPrelacion,idConcepto FROM SAC_OrdenPrelacionTbl"
        tabla = fnc.TraeDatosConsulta(consulta, "ConexionDBS")
        dtOpciones = tabla.Tables("Table")

        VerificaAccesos("PrelacionPagos")

        NumeroColumnas = tabla.Tables(0).Columns.Count - 1
        NumeroRenglones = tabla.Tables(0).Rows.Count - 1

        For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

            vfieldName = tabla.Tables(0).Columns(j).ColumnName
            vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
            ColumnaGridGL = New GridViewDataTextColumn

            ColumnaGridGL.Caption = vNombreColumna
            If vNombreColumna = "idProducto" Then
                ColumnaGridGL.Visible = False
                DS = fnc.TraeDatosConsulta("SELECT prod_fin_id As idProducto,producto FROM SIIFI_producto_financiero", "ConexionDBS")
                ColumnaCombo.FieldName = "idProducto"
                ColumnaCombo.Caption = "PRODUCTO"
                ColumnaCombo.ShowInCustomizationForm = True
                ColumnaCombo.VisibleIndex = "0"
                ColumnaCombo.PropertiesComboBox.DataSource = DS
                ColumnaCombo.PropertiesComboBox.TextField = "producto"
                ColumnaCombo.PropertiesComboBox.ValueField = "idProducto"
                GVPrelacion.Columns.Add(ColumnaCombo)
            End If

            If vNombreColumna = "idLineaFondeo" Then
                ColumnaGridGL.Visible = False
                DS = fnc.TraeDatosConsulta("SELECT cvefonbco As idLineaFondeo,nombre FROM SIIFI_fondos_y_bancos", "ConexionDBS")
                ColumnaCombo1.FieldName = "idLineaFondeo"
                ColumnaCombo1.Caption = "FUENTE DE FONDEO"
                ColumnaCombo1.ShowInCustomizationForm = True
                ColumnaCombo1.VisibleIndex = "1"
                ColumnaCombo1.PropertiesComboBox.DataSource = DS
                ColumnaCombo1.PropertiesComboBox.TextField = "nombre"
                ColumnaCombo1.PropertiesComboBox.ValueField = "idLineaFondeo"
                GVPrelacion.Columns.Add(ColumnaCombo1)
            End If
            If ColumnaGridGL.Caption = "ordenPrelacion" Then
                ColumnaGridGL.Caption = "ORDEN DE PRELACIÓN"
                ColumnaGridGL.Visible = True
                ColumnaGridGL.VisibleIndex = "3"
            End If

            If vNombreColumna = "idConcepto" Then
                ColumnaGridGL.Visible = False
                DS = fnc.TraeDatosConsulta("SELECT concepto_id As idConcepto, descripcion FROM SIIFI_conceptos_obligaciones", "ConexionDBS")
                ColumnaCombo2.FieldName = "idConcepto"
                ColumnaCombo2.Caption = " CONCEPTO"
                ColumnaCombo2.ShowInCustomizationForm = True
                ColumnaCombo2.VisibleIndex = "2"
                ColumnaCombo2.PropertiesComboBox.DataSource = DS
                ColumnaCombo2.PropertiesComboBox.TextField = "descripcion"
                ColumnaCombo2.PropertiesComboBox.ValueField = "idConcepto"
                GVPrelacion.Columns.Add(ColumnaCombo2)
            End If

            ColumnaGridGL.FieldName = vfieldName
            GVPrelacion.Columns.Add(ColumnaGridGL)
        Next

        GVPrelacion.DataSource = tabla
        GVPrelacion.DataBind()
        GVPrelacion.Columns.Add(ColumnaGrid)
        GVPrelacion.Settings.ShowHeaderFilterButton = True
        GVPrelacion.Settings.ShowFilterRowMenuLikeItem = True
        GVPrelacion.Settings.ShowHeaderFilterBlankItems = True
        GVPrelacion.SettingsPager.PageSize = 15

    End Sub

    Protected ReadOnly Property GridData As List(Of GridDataItem)
        Get
            Dim key = "34FAA454-CF92-4882-9401-93F6AAE81239"
            If Not IsPostBack OrElse Session(key) Is Nothing Then Session(key) = Enumerable.Range(0, 3000).[Select](Function(i) New GridDataItem With
                {.Id = Convert.ToInt16(i),
                 .Linea = 0,
                 .Orden = 0,
                 .Concepto = 0
                 }).ToList()
            Return CType(Session(key), List(Of GridDataItem))
        End Get
    End Property
    Public Class GridDataItem
        Public Property Id As Integer
        Public Property Linea As Integer
        Public Property Orden As Integer
        Public Property Concepto As Integer

    End Class

    Protected Function InsertNewItem(ByVal newValues As OrderedDictionary) As GridDataItem
        BanderaInsUpd = 1
        Dim item = New GridDataItem()
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Function UpdateItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
        Dim Linea = Convert.ToInt16(keys("idProducto"))
        LFondeo = Linea
        Dim item = GridData.First(Function(i) i.Id = Linea)
        BanderaInsUpd = 2
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Function DeleteItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
        Dim Linea = Convert.ToInt16(keys("idProducto"))
        LFondeo = Linea
        Dim item = GridData.First(Function(i) i.Id = Linea)
        BanderaInsUpd = 3
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function

    Protected Sub GVPrelacion_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs) Handles GVPrelacion.BatchUpdate
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
        Me.GVPrelacion.DataSource = Nothing
        Me.GVPrelacion.DataBind()
        Me.GVPrelacion.Selection.UnselectAll()
        Me.GVPrelacion.CancelEdit()
        Me.GVPrelacion.FocusedRowIndex = -1
        ConfiguraGridPrelacion()

    End Sub
    Protected Sub LoadNewValues(ByVal item As GridDataItem, ByVal values As OrderedDictionary, ByVal Optional bandera As Integer = 0)


        Dim llaves As String = ""
        Dim llaves2 As String = ""
        Dim R() As String
        Dim R2() As String


        item.Id = Convert.ToInt16(values("idProducto"))
        item.Linea = Convert.ToInt16(values("idLineaFondeo"))
        item.Orden = Convert.ToInt16(values("ordenPrelacion"))
        item.Concepto = Convert.ToInt16(values("idConcepto"))


        Dim id = item.Id
        Dim LineaFond = item.Linea
        Dim Orden = item.Orden
        Dim Concepto = item.Concepto

        cadena =
         Concepto.ToString() + "|" +
         "2018-02-12" + "|" +
          "NULL" + "|" +
            "NULL" + "|" +
            "NULL"

        llaves = id.ToString() + "|" + LineaFond.ToString() + "|" + Orden.ToString()


        'Inserta Registro.
        If bandera = 1 Then

            Resultado = fnc.Grid_Alta(76, cadena, llaves, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R = Resultado.Split("|")
            If R(0) = 0 Then
                GVPrelacion.JSProperties("cpAccion") = "Registro Insertado con éxito."
            ElseIf R(0) = 2627 Then
                GVPrelacion.JSProperties("cpAccion") = "El registro a incluir ya existe"
            Else
                GVPrelacion.JSProperties("cpAccion") = Resultado
            End If

            'Actualiza Registro.
        ElseIf bandera = 2 Then
            llaves2 = LFondeo.ToString() + "|" + LineaFond.ToString() + "|" + Orden.ToString()
            Resultado = fnc.Grid_Alta(76, cadena, llaves, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")
            If R2(0) = 0 Then
                Resultado = fnc.Grid_Elimina(76, llaves2, 0, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
                If Resultado = "0" Then
                    GVPrelacion.JSProperties("cpAccion") = "Registro actualizado con éxito."
                Else
                    GVPrelacion.JSProperties("cpAccion") = "Registro no actualizado."
                End If
            Else
                GVPrelacion.JSProperties("cpAccion") = R2(0)
            End If
            'Elimina Registro.
        ElseIf bandera = 3 Then
            llaves2 = LFondeo.ToString() + "|" + LineaFond.ToString() + "|" + Concepto.ToString()
            Resultado = fnc.Grid_Elimina(76, llaves2, 0, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            If Resultado = "0" Then
                GVPrelacion.JSProperties("cpAccion") = "Registro eliminado con éxito."
            Else
                GVPrelacion.JSProperties("cpAccion") = Resultado
            End If
        End If

    End Sub

    Protected Sub GVPrelacion_BeforeHeaderFilterFillItems(sender As Object, e As ASPxGridViewBeforeHeaderFilterFillItemsEventArgs)
        If (e.Column.FieldName <> "UnitsOnOrder") Then
            Return
        End If
        e.AddValue("nonzero", String.Empty, "[UnitsOnOrder] != 0")
        e.AddValue(String.Format("from {0} to {1}", 0, 50), String.Empty, String.Format("[UnitsOnOrder] > {0} and [UnitsOnOrder] < {1}", 0, 50))
        e.AddValue(String.Format(">= {0}", 50), String.Empty, String.Format("[UnitsOnOrder] >= {0}", 50))
    End Sub


End Class
