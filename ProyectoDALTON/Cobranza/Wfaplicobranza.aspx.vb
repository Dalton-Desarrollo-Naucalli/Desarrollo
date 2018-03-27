Imports Microsoft.VisualBasic
Imports System
Imports System.Web.UI
Imports DevExpress.Web
Imports System.Diagnostics
Imports WsSeguridad
Imports Modulos.WB.Clases
Imports System.Data
Imports System.IO
Imports System.IO.StreamWriter
Imports System.Threading
Imports System.Globalization
Imports System.Data.SqlClient
Imports DevExpress.Web.ASPxGridView
Imports DevExpress.Web.ASPxGridView.GridViewCommandColumn

Partial Class MiFuncionalidad_Wfaplicobranza
    Inherits System.Web.UI.Page
    Private Servicio As New WsFuncionalidad.Funcionalidad


#Region "VARIABLES"

    Dim dtOpciones As DataTable
    Dim drOpciones As DataRow

    Dim renglon As Integer = 0,
    columna As Integer = 0,
    NumeroColunas As Integer = 0,
    NumeroRenglones As Integer = 0

    Dim vDetalle As String = "",
     colum As String,
    pseudo As String,
    Errpseudo As String = "",
    Resultado As String = "",
    idcatSeg As String = "",
    usrSeg As String = "",
    idAccion As String,
    idA As String = "",
    desA As String = ""

    Dim datoReporte As Object,
    vNombreColumna As Object,
    vfieldName As Object

    Dim tabla As New DataSet()

    Dim ColumnaGrid0 As New GridViewCommandColumn
    Dim ColumnaGrid1 As New GridViewCommandColumn
    Dim ColumnaGrid As New GridViewDataTextColumn

    Dim DSTipoDato As New DataSet
    Dim dtTipoDato As DataTable
    Dim DSTipoDatoA As New DataSet
    Dim dtTipoDatoA As DataTable
    Dim campo As Boolean
    Dim valorCatalogo As String
    Dim DsAccesos As New DataSet


#End Region


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If IsPostBack Then
            LlenaGridRentas()
            LlenaGriCreditos()
            'LlenaControlesIniciales()
            'LlenaGridLookup()
        Else
            LlenaGridRentas()
            LlenaGriCreditos()
            'LlenaControlesIniciales()
            'LlenaGridLookup()
        End If

    End Sub


    Private Sub LlenaControlesIniciales()
        Dim dsDatosRFC As New DataSet
        dsDatosRFC = Servicio.TraeDatosConsulta("Select Cliente_id, RFC from cliente Where RFC <> '' Order by RFC", "Dalton_Pruebas")

        Me.comboRFC.DataSource = dsDatosRFC
        Me.comboRFC.TextField = "RFC"
        Me.comboRFC.ValueField = "Cliente_id"
        Me.comboRFC.DataBind()
        'Me.comboRFC.Value = "Cliente_id"
        'Me.comboRFC.Text = "RFC"

    End Sub


    Private Sub LlenaGridRentas()
        Dim fnc = New WsFuncionalidad.Funcionalidad
        tabla = New DataSet
        ASPxGridRenta.Columns.Clear()

        tabla = fnc.DatosFuncionalidaCobranza("MonitorCobranzaRenta", "MonitorCobranzaRenta|||", "ConexionDBS")

        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColunas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

                    Dim vTipoDato As Object = tabla.Tables(0).Columns(j).DataType
                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGrid = New GridViewDataTextColumn
                    ColumnaGrid.Caption = fnc.ObtenEtiquetaReporte(vNombreColumna, "ConexionDBS")
                    '.DisplayFormat.FormatType = FormatType.Numeric

                    If ColumnaGrid.Caption = "ID" Then
                        ColumnaGrid.ReadOnly = True
                        ColumnaGrid.Width = 60
                    End If
                    ColumnaGrid.FieldName = vfieldName
                    Me.ASPxGridRenta.Columns.Add(ColumnaGrid)
                Next
            End If
        End If
        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                'glCatalogos.JSProperties("cpSinDatos") = ""
                ASPxGridRenta.DataSource = tabla
                ASPxGridRenta.DataBind()
            End If
        Else
            'GridFinammico.JSProperties("cpSinDatos") = "no"
        End If
    End Sub

    Private Sub LlenaGriCreditos()
        Dim fnc = New WsFuncionalidad.Funcionalidad
        tabla = New DataSet
        ASPxGridCredito.Columns.Clear()

        tabla = fnc.DatosFuncionalidaCobranza("MonitorCobranzaCredito", "MonitorCobranzaCredito|||", "ConexionDBS")

        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColunas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

                    Dim vTipoDato As Object = tabla.Tables(0).Columns(j).DataType
                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGrid = New GridViewDataTextColumn
                    ColumnaGrid.Caption = fnc.ObtenEtiquetaReporte(vNombreColumna, "ConexionDBS")

                    If ColumnaGrid.Caption = "ID" Then
                        ColumnaGrid.ReadOnly = True
                        ColumnaGrid.Width = 60
                    End If
                    ColumnaGrid.FieldName = vfieldName
                    Me.ASPxGridCredito.Columns.Add(ColumnaGrid)
                Next
            End If
        End If
        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                'glCatalogos.JSProperties("cpSinDatos") = ""
                ASPxGridCredito.DataSource = tabla
                ASPxGridCredito.DataBind()
            End If
        Else
            'GridFinammico.JSProperties("cpSinDatos") = "no"
        End If
    End Sub





    Private Sub ConfiguraGrids()
        'Primero se configura el Grid de Renta
        Dim columRentaFactura As New GridViewDataColumn With {.FieldName = "Factura", .Caption = "Factura", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        Me.ASPxGridRenta.Columns.Add(columRentaFactura)

        Dim columRentaTipoDeFactura As New GridViewDataColumn With {.FieldName = "Tipo", .Caption = "Tipo de Factura", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        Me.ASPxGridRenta.Columns.Add(columRentaTipoDeFactura)

        Dim columRentaContrato As New GridViewDataColumn With {.FieldName = "Contrato", .Caption = "Contrato", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        Me.ASPxGridRenta.Columns.Add(columRentaContrato)

        Dim columRentaAnexo As New GridViewDataColumn With {.FieldName = "Anexo", .Caption = "Anexo", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        Me.ASPxGridRenta.Columns.Add(columRentaAnexo)

        Dim columRentaRentasPagadas As New GridViewDataColumn With {.FieldName = "RentasPagadas", .Caption = "Rentas Pagadas", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        Me.ASPxGridRenta.Columns.Add(columRentaRentasPagadas)

        Dim columRentaFechaDeVencimiento As New GridViewDataColumn With {.FieldName = "FechaDeVencimiento", .Caption = "Fecha de Vencimiento", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        Me.ASPxGridRenta.Columns.Add(columRentaFechaDeVencimiento)

        Dim columRentaFechaDeCorte As New GridViewDataColumn With {.FieldName = "FechaDeCorte", .Caption = "Fecha de Corte", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        Me.ASPxGridRenta.Columns.Add(columRentaFechaDeCorte)

        Dim columRentaImporte As New GridViewDataColumn With {.FieldName = "Importe", .Caption = "Importe", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        Me.ASPxGridRenta.Columns.Add(columRentaImporte)

        Dim columRentaSaldoFechaCorte As New GridViewDataColumn With {.FieldName = "SaldoFechaCorte", .Caption = "Saldo Fecha de Corte", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        Me.ASPxGridRenta.Columns.Add(columRentaSaldoFechaCorte)

        Dim columRentaEstatus As New GridViewDataColumn With {.FieldName = "Estatus", .Caption = "Estatus", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        Me.ASPxGridRenta.Columns.Add(columRentaEstatus)

        Dim columRentaTotal As New GridViewDataColumn With {.FieldName = "Total", .Caption = "Total", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        Me.ASPxGridRenta.Columns.Add(columRentaTotal)

        ''Segundo, se configura el Grid de Crédito
        'Dim columCreditoNoCredito As New GridViewDataColumn With {.FieldName = "idCatalogo", .Caption = "No. de Crédito", .UnboundType = DevExpress.Data.UnboundColumnType.String, .Visible = True}
        'Me.ASPxGridCredito.Columns.Add(columCreditoNoCredito)

        'Dim columCreditoFechaDisposicion As New GridViewDataColumn With {.FieldName = "etiqueta", .Caption = "Fecha Disposición", .UnboundType = DevExpress.Data.UnboundColumnType.String, .Visible = True}
        'Me.ASPxGridCredito.Columns.Add(columCreditoFechaDisposicion)

        'Dim columCreditoFechaDeVencimiento As New GridViewDataColumn With {.FieldName = "FormularioInd", .Caption = "Fecha de Vencimiento", .UnboundType = DevExpress.Data.UnboundColumnType.String, .Visible = True}
        'Me.ASPxGridCredito.Columns.Add(columCreditoFechaDeVencimiento)

        'Dim columCreditoFechaDeCorte As New GridViewDataColumn With {.FieldName = "FechaDeCorte", .Caption = "Fecha de Corte", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        'Me.ASPxGridCredito.Columns.Add(columCreditoFechaDeCorte)

        'Dim columCreditoImporte As New GridViewDataColumn With {.FieldName = "Importe", .Caption = "Importe", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        'Me.ASPxGridCredito.Columns.Add(columCreditoImporte)

        'Dim columCreditoSaldoFechaCorte As New GridViewDataColumn With {.FieldName = "SaldoFechaCorte", .Caption = "Saldo Fecha de Corte", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        'Me.ASPxGridCredito.Columns.Add(columCreditoSaldoFechaCorte)

        'Dim columCreditoTotal As New GridViewDataColumn With {.FieldName = "Total", .Caption = "Total", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        'Me.ASPxGridCredito.Columns.Add(columCreditoTotal)

        Dim fnc = New WsFuncionalidad.Funcionalidad
        tabla = New DataSet
        ASPxGridCredito.Columns.Clear()

        tabla = fnc.DatosFuncionalidaCobranza("MonitorCobranzaRenta", "MonitorCobranzaRenta|||", "ConexionDBS")

        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColunas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

                    Dim vTipoDato As Object = tabla.Tables(0).Columns(j).DataType
                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGrid = New GridViewDataTextColumn
                    ColumnaGrid.Caption = vNombreColumna

                    If ColumnaGrid.Caption = "ID" Then
                        ColumnaGrid.ReadOnly = True
                        ColumnaGrid.Width = 60
                    End If
                    ColumnaGrid.FieldName = vfieldName
                    Me.ASPxGridCredito.Columns.Add(ColumnaGrid)
                Next
            End If
        End If
        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                'glCatalogos.JSProperties("cpSinDatos") = ""
                ASPxGridCredito.DataSource = tabla
                ASPxGridCredito.DataBind()
            End If
        Else
            'GridFinammico.JSProperties("cpSinDatos") = "no"
        End If
    End Sub




    Private Sub LlenaGridLookup()
        Dim fnc = New WsFuncionalidad.Funcionalidad
        tabla = New DataSet
        ASPxGridCredito.Columns.Clear()

        tabla = fnc.TraeDatosConsulta("SELECT idCatalogo,etiqueta,FormularioInd FROM catCatalogosGenTbl", "ConexionDBS")

        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColunas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGrid = New GridViewDataTextColumn
                    ColumnaGrid.Caption = vNombreColumna

                    If ColumnaGrid.Caption = "ID" Then
                        ColumnaGrid.ReadOnly = True
                        'ColumnaGrid.Visible = False
                        ColumnaGrid.Width = 60
                    End If
                    ColumnaGrid.FieldName = vfieldName
                    Me.ASPxGridCredito.Columns.Add(ColumnaGrid)
                Next
            End If
        End If
        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                'glCatalogos.JSProperties("cpSinDatos") = ""
                ASPxGridCredito.DataSource = tabla
                ASPxGridCredito.DataBind()
            End If
        Else
            'GridFinammico.JSProperties("cpSinDatos") = "no"
        End If
    End Sub


End Class
