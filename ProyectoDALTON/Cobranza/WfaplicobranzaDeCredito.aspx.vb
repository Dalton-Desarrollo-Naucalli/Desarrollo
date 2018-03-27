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


Partial Class Cobranza_WfaplicobranzaDeCredito
    Inherits System.Web.UI.Page
    Private Servicio As New WsFuncionalidad.Funcionalidad
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If IsPostBack Then
            ConfiguraGrids()

        Else

            ConfiguraGrids()
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

        'Segundo, se configura el Grid de Crédito
        Dim columCreditoNoCredito As New GridViewDataColumn With {.FieldName = "NoCredito", .Caption = "No. de Crédito", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        Me.ASPxGridCredito.Columns.Add(columCreditoNoCredito)

        Dim columCreditoFechaDisposicion As New GridViewDataColumn With {.FieldName = "FechaDisposicion", .Caption = "Fecha Disposición", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        Me.ASPxGridCredito.Columns.Add(columCreditoFechaDisposicion)

        Dim columCreditoFechaDeVencimiento As New GridViewDataColumn With {.FieldName = "FechaDeVencimiento", .Caption = "Fecha de Vencimiento", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        Me.ASPxGridCredito.Columns.Add(columCreditoFechaDeVencimiento)

        Dim columCreditoFechaDeCorte As New GridViewDataColumn With {.FieldName = "FechaDeCorte", .Caption = "Fecha de Corte", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        Me.ASPxGridCredito.Columns.Add(columCreditoFechaDeCorte)

        Dim columCreditoImporte As New GridViewDataColumn With {.FieldName = "Importe", .Caption = "Importe", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        Me.ASPxGridCredito.Columns.Add(columCreditoImporte)

        Dim columCreditoSaldoFechaCorte As New GridViewDataColumn With {.FieldName = "SaldoFechaCorte", .Caption = "Saldo Fecha de Corte", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        Me.ASPxGridCredito.Columns.Add(columCreditoSaldoFechaCorte)

        Dim columCreditoTotal As New GridViewDataColumn With {.FieldName = "Total", .Caption = "Total", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
        Me.ASPxGridCredito.Columns.Add(columCreditoTotal)

    End Sub



End Class
