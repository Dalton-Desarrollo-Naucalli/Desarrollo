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
Imports DevExpress.Data

Partial Class Funcionalidad_Frm_Pedido
    Inherits System.Web.UI.Page
    Private Servicio As New WsSeguridad.Seguridad
    Public vSistema As String = System.Configuration.ConfigurationManager.AppSettings.Item("sistema")
    Public vEmpresa As String = System.Configuration.ConfigurationManager.AppSettings.Item("empresa")
#Region "Variables Globales"
    Dim ColumnaGrid As New GridViewCommandColumn
    Dim ColumnaGridGL As New GridViewDataTextColumn
    Dim ColumnaGrid2 As New GridViewDataTextColumn
    Dim ColumnaCombo As New GridViewDataComboBoxColumn
    Dim ColumnaCombo2 As New GridViewDataComboBoxColumn


    Dim cadena As String = "", consulta As String = "", Resultado As String = "", cat As String = ""
    Dim NumeroColumnas As Integer = 0, NumeroRenglones As Integer = 0
    Dim vNombreColumna As Object, vfieldName As Object

    Dim DSTipoDato As New DataSet
    Dim dtTipoDato As DataTable
    Dim dtOpciones As DataTable
    Dim drOpciones As DataRow

    Dim DS As New DataSet
    Dim fncion As New WsFuncionalidad.Funcionalidad
    Dim fnc As New WsFuncionalidad.Funcionalidad

    Dim ColumnaGridt As New GridViewDataTextColumn ' PARA EL TEXTO (ENCABEZADO) EN EL GRID
    Dim tabla As New DataSet()

    Dim campo As Boolean
    Dim BanderaInsUpd As Integer = 0
    Dim idproducto As String
    Dim idnew_Global As String
    Dim TotalNeto As Integer

#End Region
    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'Variable de Sesión
            If Session("sCliente") Is Nothing Then
                Response.Buffer = True
                Response.Clear()
                Response.Redirect("../Framework/Acceso.aspx")
            End If
            VerificaAccesos("Frm_Pedido")

            'Carga función Configura Grid
            ConfiguraGridMovPedido()

            'Carga Función LlenarBusqueda en el Glookup
            LlenarBusqueda()

            'Función Carga combos independientes en el Form.
            LlenaCombos()
        Else
            LlenarBusqueda()
            ConfiguraGridMovPedido()

        End If
    End Sub
    Protected Sub Page_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit
        DevExpress.Web.ASPxWebControl.GlobalTheme = Session("TemaDin")
    End Sub

#Region "Funciones"

    Public Sub LlenarBusqueda()
        'Este método llena el Gridlookup de Búsqueda mediante WS.
        glBusqueda.Columns.Clear()
        tabla = fnc.TraeDatosConsulta("SELECT * FROM pedido WHERE ped_id > 0 AND estatus = 0 ORDER BY fecha ASC", "ConexionDBS")
        'tabla = fnc.TraeDatosConsulta("SELECT C.nombre as ClienteNombre, * FROM pedido P INNER JOIN cliente C on P.cliente_id = C.cliente_id" &
        '"WHERE P.ped_id > 0 AND estatus = 0 ORDER BY fecha DESC", "ConexionDBS")

        NumeroColumnas = tabla.Tables(0).Columns.Count - 1
        NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGridt = New GridViewDataTextColumn
                    ColumnaGridt.Caption = vNombreColumna


                    If ColumnaGridt.Caption = "ped_id" Then
                        ColumnaGridt.Caption = "ID PEDIDO"
                        ColumnaGridt.ReadOnly = True
                        ColumnaGridt.Visible = True
                    ElseIf ColumnaGridt.Caption = "cliente_id" Then
                        ColumnaGridt.Caption = "CLIENTE"
                        ColumnaGridt.Visible = True
                    ElseIf ColumnaGridt.Caption = "fecha" Then
                        ColumnaGridt.Caption = "FECHA"
                        ColumnaGridt.Visible = True
                    Else
                        ColumnaGridt.Visible = False
                    End If
                    ColumnaGridt.FieldName = vfieldName
                    Me.glBusqueda.Columns.Add(ColumnaGridt)
                Next

        glBusqueda.DataSource = tabla
        glBusqueda.DataBind()

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
    Private Sub LlenaCombos()
        'Éste método carga los combos de cada tabla independientes en el formulario mediante un DS.

        'Se llena el combo Moneda 
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreMn union all Select moneda_id as ID, nombre as NombreMn from moneda where BorradoLogico = 0 order by NombreMn", "ConexionDBS")
        'Combo Moneda
        Me.cmbMoneda.DataSource = DS
        Me.cmbMoneda.ValueField = "ID"
        Me.cmbMoneda.TextField = "NombreMn"
        Me.cmbMoneda.DataBind()
        Me.cmbMoneda.SelectedIndex = 0

        'Se llena el combo Sucursal
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreSuc union all Select modulo_id as ID, nombre as NombreSuc from modulo where BorradoLogico = 0 order by NombreSuc", "ConexionDBS")
        'Combo Sucursal
        Me.cmbSucursal.DataSource = DS
        Me.cmbSucursal.ValueField = "ID"
        Me.cmbSucursal.TextField = "NombreSuc"
        Me.cmbSucursal.DataBind()
        Me.cmbSucursal.SelectedIndex = 0

        'Se llena el combo Cliente
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreC union all Select cliente_id as ID, nombre as NombreC from cliente order by NombreC", "ConexionDBS")
        'Combo Cliente
        Me.cmbCliente.DataSource = DS
        Me.cmbCliente.ValueField = "ID"
        Me.cmbCliente.TextField = "NombreC"
        Me.cmbCliente.DataBind()
        Me.cmbCliente.SelectedIndex = 0

        'Se llena el combo Personal
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombrePers union all Select person_id as ID, nombre as NombrePers from personal where BorradoLogico = 0 order by NombrePers", "ConexionDBS")
        'Combo Personal
        Me.cmbPersona.DataSource = DS
        Me.cmbPersona.ValueField = "ID"
        Me.cmbPersona.TextField = "NombrePers"
        Me.cmbPersona.DataBind()
        Me.cmbPersona.SelectedIndex = 0

        'Se llena el combo Tipo Servicio
        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as Descrip union all Select ID_TipoServicio as ID, Descripción as Descrip from tipo_servicio order by Descrip", "ConexionDBS")
        'Combo Tipo Servicio
        Me.cmbTipoServicio.DataSource = DS
        Me.cmbTipoServicio.ValueField = "ID"
        Me.cmbTipoServicio.TextField = "Descrip"
        Me.cmbTipoServicio.DataBind()
        Me.cmbTipoServicio.SelectedIndex = 0


    End Sub
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
            ElseIf Control.[GetType]() = GetType(ASPxDateEdit) Then
                Dim dateedit As ASPxDateEdit = CType(Control, ASPxDateEdit)
                If dateedit.Text = "" Then
                    dateedit.Text = "NULL"
                End If
            End If
        Next Control

    End Sub
    Private Sub CargaCallback()
        'Variables

        'Declara la variable FPed para el uso en la cadena de la fecha. Si el control trae vacío el texto, pone la variable como NULL,
        'De lo contrario le agrega el valor y Formato correcto para formar correctamente la cadena.
        Dim FPed As String
        If dtFecha.Text = "" Then
            FPed = "NULL"
            'cbGuardar.JSProperties("cpFecha") = "Debe seleccionar una fecha."
        Else
            Dim FechaPedido As DateTime = Convert.ToDateTime(dtFecha.Text)
            FPed = FechaPedido.ToString("yyyy/MM/dd")
        End If

        cat = Convert.ToString(glBusqueda.Value())
        Dim R() As String
        Dim R2() As String


        'CONCATENA LOS CONTROLES DEL FORMULARIO 
        cadena =
            cmbMoneda.Value + "," +
            cmbPersona.Value + "," +
            cmbCliente.Value + "," +
            "'" + FPed + "'" + "," +
            "NULL" + "," +
            "1" + "," +
            "1" + "," +
            "1" + "," +
            "1" + "," +
            "1" + "," +
            "1" + "," +
            txtFormaPago.Text + "," +
            "0" + "," +
            "1" + "," +
            cmbAtencion.Value + "," +
            "'" + txtObserv.Text + "'" + "," +
            "NULL" + "," +
            "NULL" + "," +
            "NULL" + "," +
            "1" + "," +
            "NULL" + "," +
            cmbCapDirec.Value + "," +
            "NULL" + "," +
            "NULL" + "," +
            "NULL" + "," +
            "NULL" + "," +
            "NULL" + "," +
            "NULL" + "," +
            "1" + "," +
            "1" + "," +
            "1" + "," +
            txtCvePedidoCte.Text + "," +
            "'" + txtNotas.Text + "'" + "," +
            "'" + txtComentarioPlazo.Text + "'" + "," +
            "1" + "," +
            "1" + "," +
            cmbSucursal.Value + "," +
            cmbSucursalCte.Value + "," +
            "1" + "," +
            cmbTipoServicio.Value + "," +
            "NULL" + "," +
            "NULL" + "," +
            "NULL" + "," +
            "NULL" + "," +
            "1" + "," +
            "NULL" + "," +
            "NULL" + "," +
            "NULL" + "," +
            "NULL" + "," +
            "NULL" + "," +
            "NULL" + "," +
            "NULL" + "," +
            "NULL"




        'Validación ACTUALIZA DATOS
        If txtNoPedido.Text <> "" Then
            ' id = Convert.ToInt32(txtNoPedido.Text)
            ' Resultado = fnc.Guarda_Pedido("ValoresPedido", cadena, id, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            ' R = Resultado.Split("|")

            'If R(0) = "50000" Then 'Valida número parte de otro producto.
            '    cbGuardar.JSProperties("cpAccion") = "El número de parte que estás intentando actualizar ya está asignado a otro Producto."
            'Else
            '    cbGuardar.JSProperties("cpAccion") = "Registro actualizado con éxito."
            'End If

            'Validación INSERTA DATOS
        ElseIf txtNoPedido.Text = "" Then
            Resultado = fnc.Guarda_Pedido(cadena, "NULL", Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            R2 = Resultado.Split("|")

            If R2(0) = "0" Or R2(0) = "109" Then
                cbGuardar.JSProperties("cpAccion") = "Se ha guardado el Pedido, puede consultarlo en Formulario Pedidos." 'Inserta correctamente.
                cbGuardar.JSProperties("cpIDped") = R2(1) 'Pasa el nuevo ID a la caja de Texto del Pedido.
                idnew_Global = R2(1) 'Iguala el nuevo ID a la Variable Global.
            ElseIf R2(0) = "102" Then 'Valida cualquier error distinto a cero.
                cbGuardar.JSProperties("cpAccion") = Resultado
            End If
        End If
    End Sub

#End Region

#Region "Callbacks"
    Protected Sub cmbAtencion_Callback(sender As Object, e As CallbackEventArgsBase) Handles cmbAtencion.Callback
        Dim IdCliente As String

        IdCliente = e.Parameter.ToString()

        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as  NombreAtn union all SELECT CTE.cliente_id as ID, CONTCTE.nombre as NombreAtn " &
                                      "FROM cliente CTE " &
                                      "INNER JOIN contacto CONT ON CTE.cliente_id = CONT.cliente_id " &
                                      "INNER JOIN contactos_clientes CONTCTE ON CONT.contacto_id = CONTCTE.contacto_id " &
                                      "WHERE CTE.cliente_id = " + IdCliente + " order by ID", "ConexionDBS")
        Me.cmbAtencion.DataSource = DS
        Me.cmbAtencion.ValueField = "ID"
        Me.cmbAtencion.TextField = "NombreAtn"
        Me.cmbAtencion.DataBind()
        Me.cmbAtencion.SelectedIndex = 0

    End Sub
    Protected Sub cmbSucursalCte_Callback(sender As Object, e As CallbackEventArgsBase) Handles cmbSucursalCte.Callback
        Dim IdSucCte As String

        IdSucCte = e.Parameter.ToString()

        DS = fncion.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreSucCte union all SELECT CTE.cliente_id as ID, SUCCTE.nombre as NombreSucCte " &
                                      "FROM sucursal_cliente SUCCTE " &
                                      "INNER JOIN cliente CTE ON SUCCTE.cliente_id = CTE.cliente_id " &
                                      "WHERE CTE.cliente_id = " + IdSucCte + " order by ID", "ConexionDBS")
        Me.cmbSucursalCte.DataSource = DS
        Me.cmbSucursalCte.ValueField = "ID"
        Me.cmbSucursalCte.TextField = "NombreSucCte"
        Me.cmbSucursalCte.DataBind()
        Me.cmbSucursalCte.SelectedIndex = 0
    End Sub
    'Callback Guarda Pedido.
    Protected Sub cbGuardar_Callback(source As Object, e As CallbackEventArgs) Handles cbGuardar.Callback
        ValidaControles()
        CargaCallback()
    End Sub
#End Region

#Region "Grid"
    Private Sub ConfiguraGridMovPedido()
        'Este método configura el Grid Pedidos ConfiguraGrid pasa ID de pedido a otra tabla).
        Dim ped_id As String = ""
        GVMovPedido.Columns.Clear()
        GVMovPedido.TotalSummary.Clear()
        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim DS As DataSet
        DS = New DataSet

        'Si la variable global viene Vacía, entonces se da valor a la variable ped_id de lo que traiga el Gridlookup de Búsqueda,
        'De lo contrario le asigna lo que trae la variable Global a la variable ped_id y le pone el ID nuevo a la caja de Texto txtNoPedido.
        If idnew_Global = Nothing Then
            ped_id = Convert.ToString(glBusqueda.Value())
        Else
            ped_id = idnew_Global
            GVMovPedido.JSProperties("cpIDProd") = idnew_Global
        End If


        If ped_id = "" Then
            consulta = "SELECT ped_id, prod_id, ID_Almacen AS IDALM, cantidad, precio_minimo, precio_venta, porc_desc, subtot_bruto, Observaciones_X_partida, iva, retencioniva, imp_especial FROM movpedido WHERE ped_id = 0 "
            tabla = fnc.TraeDatosConsulta(consulta, "ConexionDBS")
            dtOpciones = tabla.Tables("Table")
        Else
            consulta = "SELECT ped_id, prod_id, ID_Almacen AS IDALM, cantidad, precio_minimo, precio_venta, porc_desc, subtot_bruto, Observaciones_X_partida, iva, retencioniva, imp_especial FROM movpedido WHERE ped_id = " + ped_id
            tabla = fnc.TraeDatosConsulta(consulta, "ConexionDBS")
            dtOpciones = tabla.Tables("Table")
        End If

        VerificaAccesos("Frm_Pedido")

        NumeroColumnas = tabla.Tables(0).Columns.Count - 1
        NumeroRenglones = tabla.Tables(0).Rows.Count - 1

        For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

            vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
            vfieldName = tabla.Tables(0).Columns(j).ColumnName

            ColumnaGridGL = New GridViewDataTextColumn
            ColumnaGridGL.Caption = vNombreColumna
            If ColumnaGridGL.Caption = "ped_id" Then
                ColumnaGridGL.Visible = False
                ColumnaGridGL.ReadOnly = True
                ColumnaGridGL.VisibleIndex = "0"
            Else
                ColumnaGridGL.Caption = fnc.ObtenEtiquetaReporte(vNombreColumna, "ConexionDBS")
            End If

            If vNombreColumna = "prod_id" Then
                ColumnaGridGL.Visible = False
                ColumnaCombo.Width = 200
                DS = fnc.TraeDatosConsulta("SELECT PR.prod_id,PR.desc_corta, MA.nombre,CA.nombre AS cat from producto PR INNER JOIN marca MA ON PR.marca_id = MA.marca_id INNER JOIN categoria CA ON PR.cat_id = CA.cat_id", "ConexionDBS")
                ColumnaCombo.FieldName = "prod_id"
                ColumnaCombo.Caption = "PRODUCTO"
                ColumnaCombo.ShowInCustomizationForm = True
                ColumnaCombo.VisibleIndex = "1"
                ColumnaCombo.PropertiesComboBox.DataSource = DS
                ColumnaCombo.PropertiesComboBox.ValueField = "prod_id"
                ColumnaCombo.PropertiesComboBox.Columns.Add("desc_corta").Caption = "PRODUCTO"
                ColumnaCombo.PropertiesComboBox.Columns.Add("nombre").Caption = "MARCA"
                ColumnaCombo.PropertiesComboBox.Columns.Add("cat").Caption = "CATEGORIA"
                ColumnaCombo.PropertiesComboBox.TextFormatString = "{0}"
                GVMovPedido.Columns.Add(ColumnaCombo)
                ColumnaCombo.PropertiesComboBox.ValidationSettings.RequiredField.IsRequired = True
                ColumnaCombo.PropertiesComboBox.ValidationSettings.RequiredField.ErrorText = "Debe ingresar el número de Producto para grabar la partida"
            End If

            If vNombreColumna = "IDALM" Then
                ColumnaGridGL.Visible = False
                ColumnaCombo2.Width = 150
                DS = fnc.TraeDatosConsulta("SELECT ID_almacen, descripcion FROM Almacen", "ConexionDBS")
                ColumnaCombo2.FieldName = "IDALM"
                ColumnaCombo2.Caption = "ALMACÉN"
                ColumnaCombo2.ShowInCustomizationForm = True
                ColumnaCombo2.VisibleIndex = "2"
                ColumnaCombo2.PropertiesComboBox.DataSource = DS
                ColumnaCombo2.PropertiesComboBox.TextField = "descripcion"
                ColumnaCombo2.PropertiesComboBox.ValueField = "ID_almacen"
                GVMovPedido.Columns.Add(ColumnaCombo2)
                ColumnaCombo2.PropertiesComboBox.ValidationSettings.RequiredField.IsRequired = True
                ColumnaCombo2.PropertiesComboBox.ValidationSettings.RequiredField.ErrorText = "Debe seleccionar el Almacén."
            End If

            'Validación solo Números.
            If vNombreColumna = "cantidad" Then
                ColumnaGridGL.Width = 40
                ColumnaGridGL.PropertiesTextEdit.ValidationSettings.RequiredField.IsRequired = True
                ColumnaGridGL.PropertiesTextEdit.ValidationSettings.RequiredField.ErrorText = "Ingrese la cantidad de Productos."
                ColumnaGridGL.PropertiesTextEdit.ValidationSettings.RegularExpression.ValidationExpression = "\b[0-9]*\.*[0-9]+\b"
                ColumnaGridGL.PropertiesTextEdit.ValidationSettings.RegularExpression.ErrorText = "Este campo solo admite valores numéricos"
            End If
            If vNombreColumna = "precio_minimo" Then
                ColumnaGridGL.Width = 50
                ColumnaGridGL.PropertiesTextEdit.DisplayFormatString = "c"
                ColumnaGridGL.PropertiesTextEdit.ValidationSettings.RequiredField.IsRequired = True
                ColumnaGridGL.PropertiesTextEdit.ValidationSettings.RequiredField.ErrorText = "Ingrese el Precio Mínimo del Producto."
                ColumnaGridGL.PropertiesTextEdit.ValidationSettings.RegularExpression.ValidationExpression = "\b[0-9]*\.*[0-9]+\b"
                ColumnaGridGL.PropertiesTextEdit.ValidationSettings.RegularExpression.ErrorText = "Este campo solo admite valores numéricos"
            End If
            If vNombreColumna = "precio_venta" Then
                ColumnaGridGL.Width = 50
                ColumnaGridGL.PropertiesTextEdit.DisplayFormatString = "c"
                ColumnaGridGL.PropertiesTextEdit.ValidationSettings.RequiredField.IsRequired = True
                ColumnaGridGL.PropertiesTextEdit.ValidationSettings.RequiredField.ErrorText = "Ingrese el Precio de Venta del Producto."
                ColumnaGridGL.PropertiesTextEdit.ValidationSettings.RegularExpression.ValidationExpression = "\b[0-9]*\.*[0-9]+\b"
                ColumnaGridGL.PropertiesTextEdit.ValidationSettings.RegularExpression.ErrorText = "Este campo solo admite valores numéricos"
            End If
            If vNombreColumna = "porc_desc" Then
                ColumnaGridGL.Width = 30
                ColumnaGridGL.PropertiesTextEdit.DisplayFormatString = "#.##\%"
                ColumnaGridGL.PropertiesTextEdit.ValidationSettings.RegularExpression.ValidationExpression = "\b[0-9]*\.*[0-9]+\b"
                ColumnaGridGL.PropertiesTextEdit.ValidationSettings.RegularExpression.ErrorText = "Este campo solo admite valores numéricos"
            End If
            If vNombreColumna = "subtot_bruto" Then
                ColumnaGridGL.CellStyle.BackColor = System.Drawing.Color.Beige
                ColumnaGridGL.CellStyle.ForeColor = System.Drawing.Color.Black
                ColumnaGridGL.Width = 50
                ColumnaGridGL.ReadOnly = True
                ColumnaGridGL.PropertiesTextEdit.DisplayFormatString = "c"
                ColumnaGridGL.PropertiesTextEdit.ValidationSettings.RegularExpression.ValidationExpression = "\b[0-9]*\.*[0-9]+\b"
                ColumnaGridGL.PropertiesTextEdit.ValidationSettings.RegularExpression.ErrorText = "Este campo solo admite valores numéricos"
            End If

            'Columnas ocultas.
            If vNombreColumna = "iva" Then
                ColumnaGridGL.Visible = False
            End If
            If vNombreColumna = "retencioniva" Then
                ColumnaGridGL.Visible = False
            End If
            If vNombreColumna = "imp_especial" Then
                ColumnaGridGL.Visible = False
            End If
            'Agrega columnaGridGL.
            ColumnaGridGL.FieldName = vfieldName
            GVMovPedido.Columns.Add(ColumnaGridGL)


            '         SUMMARY
            'SUMMARY TOTAL BRUTO
            If vNombreColumna = "subtot_bruto" Then
                Dim totalSummary As ASPxSummaryItem = New ASPxSummaryItem()
                GVMovPedido.Settings.ShowFooter = True 'Mostrar Summary                        
                totalSummary.FieldName = ColumnaGridGL.FieldName
                totalSummary.ShowInColumn = "precio_venta"
                totalSummary.DisplayFormat = "Total Bruto: {0:c2}"
                totalSummary.SummaryType = SummaryItemType.Sum 'Importar Librería Data.
                GVMovPedido.TotalSummary.Add(totalSummary)
            End If

            'SUMMARY IVA
            If vNombreColumna = "iva" Then
                    Dim totalSummary2 As ASPxSummaryItem = New ASPxSummaryItem()
                    totalSummary2.FieldName = ColumnaGridGL.FieldName
                    totalSummary2.ShowInColumn = "porc_desc"
                    totalSummary2.DisplayFormat = "Total I.V.A: {0:c2}"
                    totalSummary2.SummaryType = SummaryItemType.Sum 'Importar Librería Data.
                    GVMovPedido.TotalSummary.Add(totalSummary2)
                End If

                'SUMMARY IMPUESTO ESPECIAL
                If vNombreColumna = "imp_especial" Then
                    Dim totalSummary3 As ASPxSummaryItem = New ASPxSummaryItem()
                    totalSummary3.FieldName = ColumnaGridGL.FieldName
                    totalSummary3.ShowInColumn = "subtot_bruto"
                    totalSummary3.DisplayFormat = "Total Imp Especial: {0:c2}"
                    totalSummary3.SummaryType = SummaryItemType.Sum 'Importar Librería Data.
                    GVMovPedido.TotalSummary.Add(totalSummary3)
                End If


                'SUMMARY TOTAL RETENCION IVA
                If vNombreColumna = "retencioniva" Then
                    Dim totalSummary5 As ASPxSummaryItem = New ASPxSummaryItem()
                    totalSummary5.FieldName = ColumnaGridGL.FieldName
                    totalSummary5.ShowInColumn = "precio_venta"
                    totalSummary5.DisplayFormat = "Retención IVA: {0:c2}"
                    totalSummary5.SummaryType = SummaryItemType.Sum 'Importar Librería Data.
                    GVMovPedido.TotalSummary.Add(totalSummary5)


                    'SUMMARY TOTAL % ANTICIPO
                    Dim totalSummary6 As ASPxSummaryItem = New ASPxSummaryItem()
                    totalSummary6.FieldName = ColumnaGridGL.FieldName
                    totalSummary6.ShowInColumn = "porc_desc"
                    totalSummary6.DisplayFormat = "% Anticipo: "
                    totalSummary6.SummaryType = SummaryItemType.Sum 'Importar Librería Data.
                    GVMovPedido.TotalSummary.Add(totalSummary6)

                    'SUMMARY TOTAL ANTICIPO
                    Dim totalSummary7 As ASPxSummaryItem = New ASPxSummaryItem()
                    totalSummary7.FieldName = ColumnaGridGL.FieldName
                    totalSummary7.ShowInColumn = "subtot_bruto"
                    totalSummary7.DisplayFormat = "Anticipo: "
                    totalSummary7.SummaryType = SummaryItemType.Sum 'Importar Librería Data.
                    GVMovPedido.TotalSummary.Add(totalSummary7)

                End If

        Next
        GVMovPedido.DataSource = tabla
        GVMovPedido.DataBind()
        GVMovPedido.Columns.Add(ColumnaGrid)

        '  COLUMNA TOTAL NETO 
        ColumnaGrid2.FieldName = "TotNeto"
        ColumnaGrid2.VisibleIndex = GVMovPedido.Columns.Count
        ColumnaGrid2.Caption = "TotNeto"
        ColumnaGrid2.Visible = False
        ColumnaGrid2.UnboundType = UnboundColumnType.Decimal
        GVMovPedido.Columns.Add(ColumnaGrid2)

        'SUMMARY TOTAL NETO      
        If ColumnaGrid2.Caption = "TotNeto" Then
            Dim totalSummary4 As ASPxSummaryItem = New ASPxSummaryItem()
            totalSummary4.FieldName = ColumnaGrid2.FieldName
            totalSummary4.ShowInColumn = "Observaciones_X_partida"
            totalSummary4.DisplayFormat = "Total Neto: {0:c2}"
            totalSummary4.SummaryType = SummaryItemType.Sum 'Importar Librería Data.  
            GVMovPedido.TotalSummary.Add(totalSummary4)

            'SUMMARY TOTAL SALDO
            Dim totalSummary8 As ASPxSummaryItem = New ASPxSummaryItem()
            totalSummary8.FieldName = ColumnaGridGL.FieldName
            totalSummary8.ShowInColumn = "Observaciones_X_partida"
            totalSummary8.DisplayFormat = "Saldo: "
            totalSummary8.SummaryType = SummaryItemType.Sum 'Importar Librería Data.              
            GVMovPedido.TotalSummary.Add(totalSummary8)
        End If
    End Sub

    'EVENTO PARA HACER CÁLCULO DE DISTINTAS COLUMNAS Y COLOCARLO EN UNA COLUMNA ESPECÍFICA
    Protected Sub GVMovPedido_CustomUnboundColumnData(sender As Object, e As ASPxGridViewColumnDataEventArgs) Handles GVMovPedido.CustomUnboundColumnData
        If e.Column.FieldName = "TotNeto" Then
            Dim subtot As Decimal = CDec(e.GetListSourceFieldValue("subtot_bruto"))
            Dim iva As Decimal = CDec(e.GetListSourceFieldValue("iva"))
            e.Value = subtot + iva
        End If
        If e.Column.FieldName = "subtot_bruto" Then
            Dim precioventa As Decimal = CDec(e.GetListSourceFieldValue("precio_venta"))
            Dim cantidad As Decimal = CDec(e.GetListSourceFieldValue("cantidad"))
            e.Value = precioventa * cantidad
        End If
    End Sub

#End Region

#Region "BatchUpdate"

    Protected ReadOnly Property GridData As List(Of GridDataItem)
        Get
            Dim key = "34FAA454-CF92-4882-9401-93F6AAE81277"
            If Not IsPostBack OrElse Session(key) Is Nothing Then Session(key) = Enumerable.Range(0, 3000).[Select](Function(i) New GridDataItem With
                {.id = Convert.ToInt32(i),
                 .prod_id = 0,
                 .IDALM = 0,
                 .cantidad = 0,
                 .precio_minimo = 0,
                 .precio_venta = 0,
                 .porc_desc = 0,
                 .subtot_bruto = 0,
                 .Observaciones_X_partida = 0
            }).ToList()
            Return CType(Session(key), List(Of GridDataItem))
        End Get
    End Property
    Public Class GridDataItem
        Public Property id As Integer
        Public Property prod_id As Integer
        Public Property IDALM As Integer
        Public Property cantidad As Integer
        Public Property precio_minimo As Integer
        Public Property precio_venta As Integer
        Public Property porc_desc As Integer
        Public Property subtot_bruto As Integer
        Public Property Observaciones_X_partida As String

    End Class
    Protected Function InsertNewItem(ByVal newValues As OrderedDictionary) As GridDataItem
        BanderaInsUpd = 1
        Dim item = New GridDataItem()
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Function UpdateItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
        Dim idPed = Convert.ToInt16(keys("prod_id"))
        idproducto = idPed
        Dim item = GridData.First(Function(i) i.id = idPed)
        BanderaInsUpd = 2
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Function DeleteItem(ByVal keys As OrderedDictionary, ByVal newValues As OrderedDictionary) As GridDataItem
        Dim idPed = Convert.ToInt16(keys("prod_id"))
        idproducto = idPed
        Dim item = GridData.First(Function(i) i.id = idPed)
        BanderaInsUpd = 3
        LoadNewValues(item, newValues, BanderaInsUpd)
        Return item
    End Function
    Protected Sub GVMovPedido_BatchUpdate(sender As Object, e As Data.ASPxDataBatchUpdateEventArgs) Handles GVMovPedido.BatchUpdate
        'Si la caja de Texto viene vacía, entonces entra a validar todos Controles del RoundPanel, y luego al Callback de Inserción/Actualización.
        If txtNoPedido.Text = Nothing Then
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
        Me.GVMovPedido.DataSource = Nothing
        Me.GVMovPedido.DataBind()
        Me.GVMovPedido.Selection.UnselectAll()
        Me.GVMovPedido.CancelEdit()
        Me.GVMovPedido.FocusedRowIndex = -1
        ConfiguraGridMovPedido()

    End Sub
    Protected Sub LoadNewValues(ByVal item As GridDataItem, ByVal values As OrderedDictionary, ByVal Optional bandera As Integer = 0)

        Dim cat As String = ""
        Dim llaves As String = ""
        Dim llaves2 As String = ""
        Dim R() As String
        Dim R2() As String
        Dim IDControl As String

        'Si la variable global viene vacía, entonces iguala la variable IDControl a lo que trae la caja de Texto y lo toma como Item para el Grid, 
        'De lo contrario, le asigna el valor que trae la variable Global.
        If idnew_Global = Nothing Then
            IDControl = txtNoPedido.Text
        Else
            IDControl = idnew_Global
        End If


        item.id = IDControl
        item.prod_id = Convert.ToInt16(values("prod_id"))
        item.IDALM = Convert.ToInt16(values("IDALM"))
        item.cantidad = Convert.ToInt16(values("cantidad"))
        item.precio_minimo = Convert.ToInt16(values("precio_minimo"))
        item.precio_venta = Convert.ToInt16(values("precio_venta"))
        item.porc_desc = Convert.ToInt16(values("porc_desc"))
        item.subtot_bruto = Convert.ToInt16(values("subtot_bruto"))
        item.Observaciones_X_partida = Convert.ToString(values("Observaciones_X_partida"))

        Dim id = item.id
        Dim prod_id = item.prod_id
        Dim IDALM = item.IDALM
        Dim cantidad = item.cantidad
        Dim precio_minimo = item.precio_minimo
        Dim precio_venta = item.precio_venta
        Dim porc_desc = item.porc_desc
        Dim subtot_bruto = item.subtot_bruto
        Dim Observaciones_X_partida = item.Observaciones_X_partida
        Dim nomcon As String = "ConexionDBS"

        cadena =
             prod_id.ToString() + "," +
             "1" + "," +
            id.ToString() + "," +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "," +
            cantidad.ToString() + "|" +
            "1" + "|" +
            "1" + "|" +
            precio_minimo.ToString() + "|" +
            "1" + "|" +
            precio_venta.ToString() + "|" +
            "1" + "|" +
            "0" + "|" +
            "1" + "|" +
            subtot_bruto.ToString() + "|" +
            "OMEDINA" + "|" +
            "2018/01/01" + "|" +
            "1" + "|" +
            IDALM.ToString() + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            cmbMoneda.Value + "|" +
            "16" + "|" +
            "20000" + "|" +
            "0.16" + "|" +
            "0" + "|" +
            "0" + "|" +
            "0" + "|" +
            "1" + "|" +
            "0" + "|" +
            "0" + "|" +
            Observaciones_X_partida.ToString() + "|" +
            "NULL" + "|" +
            porc_desc.ToString() + "|" +
            "0" + "|" +
            cmbSucursal.Value + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "0" + "|" +
            "0" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|" +
            "NULL" + "|"

        llaves = id.ToString() + "|" + prod_id.ToString()


        'Inserta Registro.
        If bandera = 1 Then

            Resultado = fnc.Guarda_Pedido(cadena, "", Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            R = Resultado.Split("|")
            If R(0) = 0 Then
                GVMovPedido.JSProperties("cpAccion") = "Registro Insertado con éxito Pedido y MovPedido."
                'GVProdProv.JSProperties("cpnewId") = idnew_Global

            Else
                GVMovPedido.JSProperties("cpAccion") = Resultado
            End If

            'Actualiza Registro.
            'ElseIf bandera = 2 Then
            '    llaves2 = id.ToString() + "|" + prod_id.ToString()
            '    Resultado = fnc.Grid_Alta(52, cadena, llaves, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            '    R2 = Resultado.Split("|")
            '    If R2(0) = 0 Then
            '        Resultado = fnc.Grid_Elimina(52, llaves2, 0, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
            '        If Resultado = "0" Then
            '            GVMovPedido.JSProperties("cpAccion") = "Registro actualizado con éxito."
            '        Else
            '            GVMovPedido.JSProperties("cpAccion") = "Registro no actualizado."
            '        End If

            '    Else
            '        GVMovPedido.JSProperties("cpAccion") = R2(0)
            '    End If
            'Elimina Registro.
            'ElseIf bandera = 3 Then
            '    llaves2 = id.ToString() + "|" + prod_id.ToString()
            '    Resultado = fnc.Grid_Elimina(52, llaves2, 0, Session("iIdUsuario"), "NULL", 0, "", "ConexionDBS")
            '    If Resultado = "0" Then
            '        GVMovPedido.JSProperties("cpAccion") = "Registro eliminado con éxito."
            '    Else
            '        GVMovPedido.JSProperties("cpAccion") = Resultado
            '    End If
        End If

    End Sub

#End Region

End Class
