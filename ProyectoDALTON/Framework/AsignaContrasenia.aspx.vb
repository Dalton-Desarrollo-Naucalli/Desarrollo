Imports System.Diagnostics
Imports WsSeguridad
Imports Modulos.WB.Clases
Imports System
Imports System.Data
Imports System.Threading
Imports System.IO
Imports System.IO.StreamWriter
Imports System.Globalization

Partial Class Framework_AsignaContrasenia
    Inherits System.Web.UI.Page
    Private Servicio As New WsSeguridad.Seguridad
    Private Utilerias As New Modulos.WB.Clases.Utilerias
    Public strMensaje As String
    Public intNumeroDeColumnas As Integer
    Public intNumeroDeRenglones As Integer
    Public tmpGrupo As Integer
    Public tmpDescribe As String = ""
    Public tmpPeriodo As Object

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
            If Not Request.Cookies("Seguridad.Modulos.WB.sPassword") Is Nothing Then
                txtContraseniaActual.Text = Request.Cookies("Seguridad.Modulos.WB.sPassword").Value
            End If
        Else

        End If

    End Sub

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


    Protected Sub BtnAceptar_Click(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAceptar.Click
        Dim oGalleta As HttpCookie
        Dim vContraseniaActual As Object = txtContraseniaActual.Text
        Dim vContraseniaNueva As Object = txtNuevaContrasenia.Text
        Dim vConfirmaContrasenia As Object = txtConfirmaContrasenia.Text

        Dim vContraseniaActualEncriptada As Object = Criptografia.EncriptaCadenaSHA1(txtContraseniaActual.Text)
        Dim vContraseniaNuevaEncriptada As Object = Criptografia.EncriptaCadenaSHA1(txtNuevaContrasenia.Text)
        Dim vConfirmaContraseniaEncriptada As Object = Criptografia.EncriptaCadenaSHA1(txtConfirmaContrasenia.Text)

        If Not Response.Cookies("Seguridad.Modulos.WB.sPassword") Is Nothing Then
            Response.Cookies.Remove("Seguridad.Modulos.WB.sPassword")
        End If
        oGalleta = New HttpCookie("Seguridad.Modulos.WB.sPassword", txtContraseniaActual.Text)
        'Es necesario poner una fecha de expiracion de la cookie para que esta se genere, aqui se pone a treinta dias a la fecha actual
        oGalleta.Expires = DateTime.Now.AddDays(30)
        Response.Cookies.Add(oGalleta)

        Dim oDS As DataSet
        Servicio = New WsSeguridad.Seguridad()
        oDS = Servicio.obtenPassUsuario(Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))

        Dim vClave As Object = ""
        Dim vPassword01 As Object = ""
        Dim vPassword02 As Object = ""
        Dim vPassword03 As Object = ""

        If oDS.Tables.Count > 0 Then
            If oDS.Tables(0).Rows.Count > 0 Then
                vClave = oDS.Tables(0).Rows(0)("clave")
                vPassword01 = oDS.Tables(0).Rows(0)("pass01")
                vPassword02 = oDS.Tables(0).Rows(0)("pass02")
                vPassword03 = oDS.Tables(0).Rows(0)("pass03")
            End If
        End If

        Dim vClaveActualEncriptada As String = Criptografia.EncriptaCadenaSHA1(vContraseniaActual)
        Dim PasswordValido As Object = ValidatePassword(txtNuevaContrasenia.Text)

        If vContraseniaActualEncriptada <> vClave Then
            Me.lblMensajes.Text = "El Password actual no es correcto..."
            Me.panelBotonAceptar.Visible = True
            Me.panelBotonCerrar.Visible = False

        ElseIf PasswordValido = False Then
            Me.lblMensajes.Text = "El Password no tiene la complejidad minima requiera,<br>debe de tener al menos una longitud de 8 caracteres debe contener como minimo, <br>2 mayúsculas, 2 minúsculas y 2 números..."
            Me.panelBotonAceptar.Visible = True
            Me.panelBotonCerrar.Visible = False

        ElseIf vContraseniaNuevaEncriptada = vPassword01 Or vContraseniaNuevaEncriptada = vPassword02 Or vContraseniaNuevaEncriptada = vPassword03 Then
            Me.lblMensajes.Text = "El Password tiene que ser diferente a los tres últimos utilizados..."
            Me.panelBotonAceptar.Visible = True
            Me.panelBotonCerrar.Visible = False

        Else
            Servicio.ActualizaPassUsuario(Session("iIdUsuario"), vContraseniaNuevaEncriptada, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
            Me.lblMensajes.Text = "Se cambio el password exitosamente..."
            Me.panelBotonAceptar.Visible = False
            Me.panelBotonCerrar.Visible = True
        End If

    End Sub


    Function ValidatePassword(ByVal pwd As String, _
    Optional ByVal minLength As Integer = 8, _
    Optional ByVal numUpper As Integer = 2, _
    Optional ByVal numLower As Integer = 2, _
    Optional ByVal numNumbers As Integer = 2, _
    Optional ByVal numSpecial As Integer = 0) As Boolean

        ' Replace [A-Z] with \p{Lu}, to allow for Unicode uppercase letters.
        Dim upper As New System.Text.RegularExpressions.Regex("[A-Z]")
        Dim lower As New System.Text.RegularExpressions.Regex("[a-z]")
        Dim number As New System.Text.RegularExpressions.Regex("[0-9]")
        ' Special is "none of the above".
        Dim special As New System.Text.RegularExpressions.Regex("[^a-zA-Z0-9]")

        ' Check the length.
        If Len(pwd) < minLength Then Return False
        ' Check for minimum number of occurrences.
        If upper.Matches(pwd).Count < numUpper Then Return False
        If lower.Matches(pwd).Count < numLower Then Return False
        If number.Matches(pwd).Count < numNumbers Then Return False
        If special.Matches(pwd).Count < numSpecial Then Return False

        ' Passed all checks.
        Return True
    End Function


    Sub TestValidatePassword()
        Dim password As String = "Password"
        ' Demonstrate that "Password" is not complex.
        MsgBox(password & " is complex: " & ValidatePassword(password))

        password = "Z9f%a>2kQ"
        ' Demonstrate that "Z9f%a>2kQ" is not complex.
        MsgBox(password & " is complex: " & ValidatePassword(password))
    End Sub

End Class
