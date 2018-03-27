Imports System.Diagnostics
Imports WsSeguridad
Imports Modulos.WB.Clases
Imports System
Imports System.Data
Imports System.Threading
Imports System.IO
Imports System.IO.StreamWriter
Imports System.Globalization

Partial Class Framework_CambiaContrasenia
    Inherits System.Web.UI.Page
    Dim Servicio As New WsSeguridad.Seguridad
    Public strMensaje As String
    Public intNumeroDeColumnas As Integer
    Public intNumeroDeRenglones As Integer
    Public tmpGrupo As Integer
    Public tmpDescribe As String = ""
    Public tmpPeriodo As Object

    Dim Utilerias As New Modulos.WB.Clases.Utilerias

    Protected Overrides Sub InitializeCulture()
        If Not Session("sCultura") Is Nothing Then
            UICulture = Session("sCultura").ToString
            Culture = Session("sCultura").ToString
            System.Threading.Thread.CurrentThread.CurrentCulture = System.Globalization.CultureInfo.CreateSpecificCulture(Session("sCultura").ToString)
            System.Threading.Thread.CurrentThread.CurrentUICulture = New System.Globalization.CultureInfo(Session("sCultura").ToString)
        End If
        MyBase.InitializeCulture()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
      
        Else
            'Grid1.DataBind()
        End If

    End Sub

    Public Function ultimoDiaDeMes(ByVal mi_mes As Integer, ByVal mi_anio As Integer) As Date
        Dim sig_mes As Date
        Dim ult_dia As Date
        sig_mes = DateAdd("m", 1, DateSerial(mi_anio, mi_mes, "01"))
        'ult_dia = Day(DateAdd("d", -1, sig_mes))
        ult_dia = DateAdd("d", -1, sig_mes)
        Return ult_dia
    End Function

    Private Sub MensajeAccion(ByVal vTipoMensaje As Integer, ByVal VTextoMensaje As String)
        Dim Script As New StringBuilder
        Script.Append("<script type=text/javascript>")
        Script.Append("Alerta(" & VTextoMensaje & ",{tipo:" & vTipoMensaje & "});")
        Script.Append("</script>")

        ClientScript.RegisterStartupScript(Me.GetType, "MensajeAccion", Script.ToString)

    End Sub

    <ComponentArt.Web.UI.ComponentArtCallbackMethod()> _
       Public Function ServerSideFormatoNumero(ByVal Dato As Decimal, ByVal Decimales As Integer) As String
        UICulture = Session("sCultura").ToString
        Culture = Session("sCultura").ToString
        Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture(Session("sCultura").ToString)
        Thread.CurrentThread.CurrentUICulture = New CultureInfo(Session("sCultura").ToString)

        Dim Resultado As String = FormatNumber(Dato, Decimales)

        Return Resultado
    End Function



End Class
