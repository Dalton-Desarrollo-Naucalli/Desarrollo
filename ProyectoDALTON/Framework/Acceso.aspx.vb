Imports System.Data
Imports WSsEGURIDAD
Imports System
Imports System.Configuration
Imports System.Collections
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports Modulos.WB.Clases
Imports Modulos.WB


Partial Class Framework_Acceso
    Inherits System.Web.UI.Page
    Public vEmpresa As String = System.Configuration.ConfigurationManager.AppSettings.Item("empresa")
    Private Servicio As New WsSeguridad.Seguridad
    Private Utilerias As New Modulos.WB.Clases.Utilerias

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not IsPostBack Then
        Else

        End If

    End Sub


    Private Sub FuncionInicioVersionNavegador()
        Dim Script As New StringBuilder

        Script.Append("if(navigator.appVersion.substring(0,navigator.appVersion.length).lastIndexOf('MSIE 7.0')  != -1)")
        Script.Append("{}")
        Script.Append("else")
        Script.Append("{")
        Script.Append("if(confirm('El navegegador que esta utilizando debe ser Windows Internet Explorer 7 o posterior \n ¿Desea descargalo del sitio oficial?'))")
        Script.Append("{")
        Script.Append("window.location='http://www.microsoft.com/windows/downloads/ie/'; ")
        Script.Append("}")
        Script.Append("}")
        Script.Append("")
  
        ClientScript.RegisterStartupScript(Me.GetType, "Version", Script.ToString, True)
    End Sub


    Private Sub CargaMensajesValidadores()
        Me.reqUsuario.ErrorMessage = "Anote el ID del Usuario"
        Me.reqClave.ErrorMessage = "Anote la contaseña del Usuario"
    End Sub


    Protected Sub BtnAccesar_Click1(ByVal sender As Object, ByVal e As System.Web.UI.ImageClickEventArgs) Handles btnAccesar.Click
        Dim oDS As DataSet
        Servicio = New WsSeguridad.Seguridad

        oDS = Servicio.ValidaUsuario("Cliente", txtUsuario.Text, Criptografia.EncriptaCadenaSHA1(txtClave.Text), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))

        If oDS.Tables.Count > 0 Then
            If oDS.Tables(0).Rows.Count > 0 Then
                '  // Si el codigo de resultado es 0 guarda los id's regresados por el proc de validación asi como otros parametros importantes de ser guardados para compartirlos entre todas las paginas

                Dim vId_Usuario As Object = CInt(oDS.Tables(0).Rows(0)("Id_Usuario"))
                Dim vClaveCorrecta As Object = CInt(oDS.Tables(0).Rows(0)("ClaveCorrecta"))
                Dim vEstatusUsuario As Object = CInt(oDS.Tables(0).Rows(0)("EstatusUsuario"))
                Dim vStatusUsuarioSistema As Object = CInt(oDS.Tables(0).Rows(0)("StatusUsuarioSistema"))
                Dim vNoUsuarios As Object = CInt(oDS.Tables(0).Rows(0)("NoUsuarios"))
                Dim vUsuario_Sistema As Object = CInt(oDS.Tables(0).Rows(0)("Usuario_Sistema"))
                Dim vIntentosSistema As Object = CInt(oDS.Tables(0).Rows(0)("IntentosSistema"))
                Dim vFechaUltimoAccesoUsuario As Object = oDS.Tables(0).Rows(0)("FechaUltimoAccesoUsuario")
                Dim vFechaUltimoAccesoSistema As Object = oDS.Tables(0).Rows(0)("FechaUltimoAccesoSistema")
                Dim vUltimaActualizacion As Object = oDS.Tables(0).Rows(0)("FechaUltimaActualizacion")
                Dim vFechaInicio As Object = oDS.Tables(0).Rows(0)("FechaInicio")
                Dim vFechaTermino As Object = oDS.Tables(0).Rows(0)("FechaTermino")
                Dim vFechaCaducidadClave As Object = oDS.Tables(0).Rows(0)("fecha_caducidad_clave")
                Dim vdebecambiarpassword As Object = oDS.Tables(0).Rows(0)("debecambiarpassword")
                Dim vMensajeValidacion As String = ""
                Dim vCodigoError As Integer = 0

                '===== Valida que hayan pasado 5 minutos antes de resetear el contador de intentos fallidos =====
                Dim fechaAux As Date
                Dim DiferenciaSegundos As Integer = 0
                fechaAux = Format("dd/MM/yyyy", vUltimaActualizacion)

                If fechaAux <> "01/01/1900" Then
                    DiferenciaSegundos = DateDiff(DateInterval.Second, fechaAux, Date.Now)
                End If

                If DiferenciaSegundos >= 300 And vIntentosSistema < 3 Then
                    Servicio.ActualizaNoDeIntentosUsuarioSistema(vId_Usuario, System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), "ReseteaContador", System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                End If
                '===== Valida que hayan pasado 5 minutos antes de resetear el contador de intentos fallidos =====

                If vEstatusUsuario = 0 Then
                    vMensajeValidacion = "Su usuario se encuentra bloqueado, consulte al administrador del Sistema..."
                ElseIf vFechaCaducidadClave <= Date.Today Or vdebecambiarpassword = True Then
                    vMensajeValidacion = "Su password ha caducado, es necesario actualizar su contraseña..."
                ElseIf vFechaTermino < Date.Today Then
                    If vFechaTermino <> vFechaInicio And vFechaTermino <> "01/01/1900" Then
                        vMensajeValidacion = "Su usuario ha caducado, consulte al administrador del Sistema..."
                        Servicio.ActualizaStatusUsuario(vId_Usuario, System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), System.Configuration.ConfigurationManager.AppSettings.Item("StatusPorCaducidadDeUsuario"), "BloqueaPorCaducidad", System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                    End If
                ElseIf vStatusUsuarioSistema <> 1 Then
                    vMensajeValidacion = "Su usuario se encuentra bloqueado para este sistema, consulte al administrador del Sistema..."
                    'ElseIf vStatusUsuarioSistema = System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema") Then
                    '    vMensajeValidacion = "Su usuario se encuentra bloqueado para este sistema, consulte al administrador del Sistema..."
                ElseIf vClaveCorrecta = 0 Then
                    If vIntentosSistema >= 3 Then
                        vMensajeValidacion = "Ha sobrepasado el limite de intentos permitidos, por seguridad su usuario ha sido bloqueado para este sistema, por favor consulte al administrador del Sistema..."
                        Servicio.ActualizaStatusUsuario(vId_Usuario, System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), System.Configuration.ConfigurationManager.AppSettings.Item("StatusIntentosFallidos"), "BloqueaPorIntentosFallidos", System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                    Else
                        vMensajeValidacion = "La clave de acceso no es valida, verifique..."
                        Servicio.ActualizaNoDeIntentosUsuarioSistema(vId_Usuario, System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), "", System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                    End If
                End If

                Session("sPassword") = txtClave.Text
                Session("sCliente") = "Produccion"
                Session("iIdUsuario") = vId_Usuario
                Session("sUsuario") = txtUsuario.Text

				Dim fnc = New WsFuncionalidad.Funcionalidad
                Dim DS As New DataSet
                Dim DT As New DataTable
                Dim qry As String

                qry = "Select id_tema From SAC_Temas_Usuario Where Usuario_Seguridad = " & Session("iIdUsuario")
                DS = fnc.ObtenDataSet("obtenCampo", qry, "ConexionDBS")
                DT = DS.Tables(0)
                If DT.Rows.Count > 0 Then
                    For Each row As DataRow In DT.Rows
                        Session("TemaDin") = row("id_tema").ToString
                    Next
                End If

                If vMensajeValidacion = "" Then
                    'If Membership.ValidateUser(Me.txtUsuario.Text, Me.txtClave.Text) Then
                    'FormsAuthentication.SetAuthCookie(Me.txtUsuario.Text, False)
                    'Else
                    'FormsAuthentication.SignOut()
                    'End If

                    FormsAuthentication.SetAuthCookie(Me.txtUsuario.Text, False)
                    '------------------------------------------------------
                    'Funcionalidad para el Registro de Entrada
                    Try
                        Dim Fecha As DateTime
                        Dim HoraRegistro As DateTime

                        Dim variable As String
                        Dim conta As Integer
                        Dim arreglo As New ArrayList

                        For Each variable In Request.ServerVariables
                            conta = conta + 1
                            If conta = 6 Or conta = 8 Or conta = 9 Or conta = 33 Or conta = 34 Or _
                               conta = 38 Or conta = 43 Or conta = 52 Or conta = 53 Or conta = 54 Then
                                arreglo.Add(Request.ServerVariables(variable))
                            End If
                        Next

                        Dim Par1 As String = arreglo(0)
                        Dim AUTH_USER As String = arreglo(1)
                        Dim LOGON_USER As String = arreglo(2)
                        Dim REMOTE_USER As String = arreglo(3)
                        Dim REMOTE_ADDR As String = arreglo(4)
                        Dim REMOTE_HOST As String = arreglo(5)
                        Dim HTTP_REFERER As String = arreglo(6)
                        Dim HTTP_HOST As String = arreglo(7)
                        Dim URL As String = arreglo(8)
                        Dim SERVER_NAME As String = arreglo(9)

                        Dim diff As Object = Session("iDifHorario")

                        HoraRegistro = Utilerias.ObtenFechaHoraCliente(diff)

                        Fecha = HoraRegistro

                    Catch ex As Exception

                    End Try

                    '------------------------------------------------------
                    Servicio.ActualizaNoDeIntentosUsuarioSistema(vId_Usuario, System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), "ReseteaContador", System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                    Servicio.ActualizaStatusUsuario(vId_Usuario, System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), System.Configuration.ConfigurationManager.AppSettings.Item("StatusPorCaducidadDeUsuario"), "AccesoCorrecto", System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))

                    '===== Valida que hayan pasado 5 minutos antes de resetear el contador de intentos fallidos =====
                    Dim fechaValidaPass As Date
                    Dim DiferenciaDias As Integer
                    fechaValidaPass = Format("dd/MM/yyyy", vFechaCaducidadClave)
                    DiferenciaDias = DateDiff(DateInterval.Day, Date.Now, fechaValidaPass)

                    If DiferenciaDias <= 7 Then
                        Session("sCliente") = "Produccion"
                        Response.Redirect("Main.aspx")
                    Else
                        Session("sCliente") = "Produccion"
                        Response.Redirect("Main.aspx")
                    End If
                    '===== Valida que hayan pasado 5 minutos antes de resetear el contador de intentos fallidos =====

                ElseIf vMensajeValidacion = "Su password ha caducado, es necesario actualizar su contraseña..." Then
                    Response.Redirect("AsignaContrasenia.aspx")

                ElseIf vdebecambiarpassword = True Then
                    Response.Redirect("AsignaContrasenia.aspx")
                Else
                    Utilerias.MuestraMensaje(phMensaje, vMensajeValidacion)
                End If


            Else
                Utilerias.MuestraMensaje(phMensaje, "Nombre de usuario no valido...")
            End If
        End If

    End Sub
End Class
