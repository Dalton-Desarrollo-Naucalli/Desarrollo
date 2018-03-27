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

Partial Class Cobranza_WfAutPendFacturarTermNat
    Inherits System.Web.UI.Page
    Private Servicio As New WsFuncionalidad.Funcionalidad


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
        If IsPostBack Then
            'ConfiguraGrids()

        Else
            'ConfiguraGrids()

        End If

        Dim Texto As New Literal()
        Dim Cadena As String = ""
        Cadena += ("<table border=""0"" style=""width:100%"">")
        Cadena += ("    <tr>")
        Cadena += ("        <td>")
        Cadena += ("            <table border=""1"" cellpadding=""1"" cellspacing=""1"" width=""100%"">")
        Cadena += ("                <tr>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Cliente")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Tipo de Cliente")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Tipo de Adeudo")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Telefono")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Contrato")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Anexo")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Referencia")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Marca")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Modelo")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        VIN")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Fecha de<br/>Vencimiento")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Días<br/>Vencidos")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Saldo Vencido")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Moratorios<br/>al Día de Hoy")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Saldo Notas<br/>de Crédito<br/>Pendientes<br>de Aplicar")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Estatus")
        Cadena += ("                    </td>")
        Cadena += ("                    <td style=""text-align:center; background-color:#D8D8D8"">")
        Cadena += ("                        Boton")
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



End Class
