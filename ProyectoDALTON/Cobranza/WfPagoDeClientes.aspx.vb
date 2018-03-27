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

Partial Class Cobranza_WfPagoDeClientes
    Inherits System.Web.UI.Page
    Private Servicio As New WsFuncionalidad.Funcionalidad


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If IsPostBack Then
            'ConfiguraGrids()

        Else
            'ConfiguraGrids()

        End If

        LlenaTablaDeAmortizacion()

        Dim Texto As New Literal()
        Dim Cadena As String = ""
        Cadena += ("<table border=""0"" style=""width:100%"">")
        Cadena += ("    <tr>")
        Cadena += ("        <td>")
        Cadena += ("            <table border=""1"" cellpadding=""1"" cellspacing=""1"" width=""100%"">")
        Cadena += ("                <tr>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Factura")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Contrato - Anexo")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Vencimiento")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Moneda")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        T. C.")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Total Bruto")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Total Impuestos")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Total Neto")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Saldo")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Descuentos")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Saldo Calculado")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        P Moneda Factura")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Aplicar")
        Cadena += ("                    </td>")
        Cadena += ("                </tr>")

        'Aqui comienza a recorrer el Dataset, para dibujar la tabla con los datos
        Cadena += ("                <tr>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                </tr>")
        'Aqui termina a recorrer el Dataset, para dibujar la tabla con los datos

        Cadena += ("            </table>")
        Cadena += ("        </td>")
        Cadena += ("    </tr>")
        Cadena += ("</table>")

        Texto.Text = Cadena

        PlaceHolder1.Controls.Add(Texto)

    End Sub


    Private Sub LlenaTablaDeAmortizacion()
        Dim Texto As New Literal()
        Dim Cadena As String = ""
        Cadena += ("<table border=""0"" style=""width:100%"">")
        Cadena += ("    <tr>")
        Cadena += ("        <td>")
        Cadena += ("            <table border=""1"" cellpadding=""1"" cellspacing=""1"" width=""100%"">")
        Cadena += ("                <tr>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        No. de Pago")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Vencimiento")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Rentas")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        IVA de Interéses")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Pago Mensual")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Saldo")
        Cadena += ("                    </td>")
        Cadena += ("                </tr>")

        'Aqui comienza a recorrer el Dataset, para dibujar la tabla con los datos
        Cadena += ("                <tr>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                    <td class=""dxrpHeader_Office2010Blue dx-borderBox"" style=""text-align:center"">")
        Cadena += ("                        &nbsp;")
        Cadena += ("                    </td>")
        Cadena += ("                </tr>")
        'Aqui termina a recorrer el Dataset, para dibujar la tabla con los datos

        Cadena += ("            </table>")
        Cadena += ("        </td>")
        Cadena += ("    </tr>")
        Cadena += ("</table>")

        Texto.Text = Cadena

        'PlaceHolderTablaDeAmortizacion.Controls.Add(Texto)
    End Sub


    'Private Sub ConfiguraGrids()
    '    'gridAdeudosVencidos.ShowFilterControl()

    '    'Primero se configura el Grid de Renta
    '    Dim columRentaFactura As New GridViewDataColumn With {.FieldName = "Cliente", .Caption = "Cliente", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
    '    Me.gridAdeudosVencidos.Columns.Add(columRentaFactura)

    '    Dim columRentaTipoDeFactura As New GridViewDataColumn With {.FieldName = "TipoDeCliente", .Caption = "Tipo de Cliente", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
    '    Me.gridAdeudosVencidos.Columns.Add(columRentaTipoDeFactura)

    '    Dim columRentaContrato As New GridViewDataColumn With {.FieldName = "TipoDeAdeudo", .Caption = "Tipo de Adeudo", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
    '    Me.gridAdeudosVencidos.Columns.Add(columRentaContrato)

    '    Dim columRentaAnexo As New GridViewDataColumn With {.FieldName = "Telefono", .Caption = "Telefono", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
    '    Me.gridAdeudosVencidos.Columns.Add(columRentaAnexo)

    '    Dim columRentaRentasPagadas As New GridViewDataColumn With {.FieldName = "Contrato", .Caption = "Contrato", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
    '    Me.gridAdeudosVencidos.Columns.Add(columRentaRentasPagadas)

    '    Dim columRentaFechaDeVencimiento As New GridViewDataColumn With {.FieldName = "Anexo", .Caption = "Anexo", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
    '    Me.gridAdeudosVencidos.Columns.Add(columRentaFechaDeVencimiento)

    '    Dim columRentaFechaDeCorte As New GridViewDataColumn With {.FieldName = "Referencia", .Caption = "Referencia", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
    '    Me.gridAdeudosVencidos.Columns.Add(columRentaFechaDeCorte)

    '    Dim columRentaImporte As New GridViewDataColumn With {.FieldName = "Marca", .Caption = "Marca", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
    '    Me.gridAdeudosVencidos.Columns.Add(columRentaImporte)

    '    Dim columRentaSaldoFechaCorte As New GridViewDataColumn With {.FieldName = "Modelo", .Caption = "Modelo", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
    '    Me.gridAdeudosVencidos.Columns.Add(columRentaSaldoFechaCorte)

    '    Dim columRentaEstatus As New GridViewDataColumn With {.FieldName = "VIN", .Caption = "VIN", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
    '    Me.gridAdeudosVencidos.Columns.Add(columRentaEstatus)

    '    Dim columRentaTotal As New GridViewDataColumn With {.FieldName = "FechaDeVencimiento", .Caption = "Fecha de<br/>Vencimiento", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
    '    Me.gridAdeudosVencidos.Columns.Add(columRentaTotal)

    '    Dim columCreditoNoCredito As New GridViewDataColumn With {.FieldName = "DiasVencidos", .Caption = "Días<br/>Vencidos", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
    '    Me.gridAdeudosVencidos.Columns.Add(columCreditoNoCredito)

    '    Dim columCreditoFechaDisposicion As New GridViewDataColumn With {.FieldName = "SaldoVencido", .Caption = "Saldo Vencido", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
    '    Me.gridAdeudosVencidos.Columns.Add(columCreditoFechaDisposicion)

    '    Dim columCreditoFechaDeVencimiento As New GridViewDataColumn With {.FieldName = "MoratoriosAlDiaDeHoy", .Caption = "Moratorios<br/>al Día de Hoy", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
    '    Me.gridAdeudosVencidos.Columns.Add(columCreditoFechaDeVencimiento)

    '    Dim columCreditoFechaDeCorte As New GridViewDataColumn With {.FieldName = "SaldoNotasDeCredito", .Caption = "Saldo Notas<br/>de Crédito<br/>Pendientes de Aplicar", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}

    '    Dim columCreditoImporte As New GridViewDataColumn With {.FieldName = "Estatus", .Caption = "Estatus", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
    '    Me.gridAdeudosVencidos.Columns.Add(columCreditoImporte)

    '    Dim columCreditoSaldoFechaCorte As New GridViewDataColumn With {.FieldName = "BtonAltaAcuerdo", .Caption = "Alta Acuerdo", .UnboundType = DevExpress.Data.UnboundColumnType.Decimal, .Visible = True}
    '    Me.gridAdeudosVencidos.Columns.Add(columCreditoSaldoFechaCorte)

    '    Dim vColumnaBoton = New GridViewCommandColumn
    '    vColumnaBoton.ShowNewButton = True
    '    vColumnaBoton.ShowEditButton = "true"
    '    vColumnaBoton.VisibleIndex = "0"
    '    'vColumnaBoton.ButtonRenderMode = "Image"

    '    'vColumnaBoton.Image.Url = "../Imagenes/Editar.png"
    '    Me.gridAdeudosVencidos.Columns.Add(vColumnaBoton)




    'End Sub



End Class
