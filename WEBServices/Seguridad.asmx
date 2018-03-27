<%@ WebService Language="VB" Class="Seguridad" %>

Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Framework.Datos.ConexionBackend
Imports Framework.Datos
Imports System.Data

' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la siguiente línea.
' <System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")>
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
Public Class Seguridad
    Inherits System.Web.Services.WebService

    <WebMethod()>
    Public Function ValidaUsuario(ByVal sCliente As String, ByVal sUsuario As String, ByVal sClave As String, ByVal sSistema As Integer, ByVal wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Central As New Negocio.Seguridad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Central.ServicioDeDatos = Datos

        Try
            Resultado = Central.ValidaUsuario(sCliente, sUsuario, sClave, sSistema)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hello World"
    End Function

    <WebMethod()>
    Public Function FrmGetMensajeError(ByVal Llave As String, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Seguridad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.FrmGetMensajeError(Llave)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function ObtenDatosCatalogo(ByVal Funcionalidad As String, ByVal Parametros As String, ByVal wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Seguridad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As New DataSet
        Try
            Resultado = Negocio.ObtenDatosCatalogo(Funcionalidad, Parametros)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function



    <WebMethod()>
    Public Function ActualizaCatalogo(ByVal Catalogo As Object, ByVal Llave As Object, ByVal Parametros As Object, ByVal wsConexion As Object) As Integer
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Seguridad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As Integer = 0
        Try
            Resultado = Negocio.ActualizaCatalogo(Catalogo, Llave, Parametros)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function InsertaCatalogo(ByVal Catalogo As Object, ByVal Llave As Object, ByVal Parametros As Object, ByVal wsConexion As Object) As Integer
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Seguridad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As Integer = 0
        Try
            Resultado = Negocio.InsertaCatalogo(Catalogo, Llave, Parametros)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function EliminaCatalogo(ByVal Catalogo As Object, ByVal Llave As Object, ByVal Parametros As Object, ByVal wsConexion As Object) As Integer
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Seguridad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As Integer = 0
        Try
            Resultado = Negocio.EliminaCatalogo(Catalogo, Llave, Parametros)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function ObtenDataSet(ByVal Funcionalidad As String, ByVal Parametros As String, ByVal wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Seguridad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As New DataSet
        Try
            Resultado = Negocio.ObtenDataSet(Funcionalidad, Parametros)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function ActualizaRelacionCatalogo(ByVal Funcionalidad As String, ByVal LlavePadre As Object, ByVal LlaveHija As Object, ByVal wsConexion As String) As Integer
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Seguridad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As Integer = 0
        Try
            Resultado = Negocio.ActualizaRelacionCatalogo(Funcionalidad, LlavePadre, LlaveHija)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function ObtenInfCatalogo(ByVal Catalogo As String, ByVal Activos As Integer, ByVal wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Seguridad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As New DataSet
        Try
            Resultado = Negocio.ObtenInfCatalogo(Catalogo, Activos)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function ActualizaNoDeIntentosUsuarioSistema(ByVal varID_Usuario As Integer, ByVal varID_Sistema As Integer, ByVal Funcionalidad As String, ByVal wsConexion As String) As Integer
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Seguridad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As Integer = 0
        Try
            Resultado = Negocio.ActualizaNoDeIntentosUsuarioSistema(varID_Usuario, varID_Sistema, Funcionalidad)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function ActualizaStatusUsuario(ByVal varID_Usuario As Integer, ByVal varID_Sistema As Integer, ByVal varStatus As Integer, ByVal varFuncionalidad As String, ByVal wsConexion As String) As Integer
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Seguridad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As Integer = 0
        Try
            Resultado = Negocio.ActualizaStatusUsuario(varID_Usuario, varID_Sistema, varStatus, varFuncionalidad)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function ActualizaPassUsuario(ByVal varID_Usuario As Integer, ByVal varPass As String, ByVal wsConexion As String) As Integer
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Seguridad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As Integer = 0
        Try
            Resultado = Negocio.ActualizaPassUsuario(varID_Usuario, varPass)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function



    <WebMethod()>
    Public Function obtenPassUsuario(ByVal ID_Usuario As Integer, ByVal wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Seguridad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As New DataSet
        Try
            Resultado = Negocio.ObtenPassUsuario(ID_Usuario)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function



    <WebMethod()>
    Public Function CreaUsuario(ByVal ID_Usuario_SIAN As Object, ByVal Nombre As Object, ByVal Usuario As Object, ByVal ID_Perfil As Object, ByVal Email As Object, ByVal Password As Object, ByVal Usuario_Registro As Object, ByVal Fecha_Inicio As Object, ByVal Fecha_Termino As Object, ByVal Estatus As Object, ByVal DebeCambiarPassword As Object, ByVal wsConexion As String) As Integer
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Seguridad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As Integer = 0
        Try
            Resultado = Negocio.CreaUsuario(ID_Usuario_SIAN, Nombre, Usuario, ID_Perfil, Email, Password, Usuario_Registro, Fecha_Inicio, Fecha_Termino, Estatus, DebeCambiarPassword)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function



    <WebMethod()>
    Public Function ObtenMenusUsuario(ByVal Usuario As Object, ByVal ID_Usuario As Object, ByVal ID_Sistema As Object, ByVal ID_Modulo As Object, ByVal wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Seguridad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As New DataSet
        Try
            Resultado = Negocio.ObtenMenusUsuario(Usuario, ID_Usuario, ID_Sistema, ID_Modulo)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function OpObtenSubmenus(ByVal Usuario As Object, ByVal ID_Usuario As Object, ByVal ID_Sistema As Object, ByVal ID_Modulo As Object, ByVal ID_Menu As Object, ByVal wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Seguridad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As New DataSet
        Try
            Resultado = Negocio.OpObtenSubmenus(Usuario, ID_Usuario, ID_Sistema, ID_Modulo, ID_Menu)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function



    <WebMethod()>
    Public Function OpObtenOpcionesSubenu(ByVal Usuario As Object, ByVal ID_Usuario As Object, ByVal ID_Sistema As Object, ByVal ID_Modulo As Object, ByVal ID_Menu As Object, ByVal ID_Submenu As Object, ByVal wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Seguridad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As New DataSet
        Try
            Resultado = Negocio.OpObtenOpcionesSubenu(Usuario, ID_Usuario, ID_Sistema, ID_Modulo, ID_Menu, ID_Submenu)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function



    <WebMethod()>
    Public Function OpObtenAccesosOpcionesSubenu(ByVal ID_Usuario As Object, ByVal Usuario As Object, ByVal ID_Sistema As Object, ByVal ID_Menu As Object, ByVal ID_Submenu As Integer, ByVal ID_Opcion As Object, ByVal wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Seguridad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As New DataSet
        Try
            Resultado = Negocio.OpObtenAccesosOpcionesSubenu(ID_Usuario, Usuario, ID_Sistema, ID_Menu, ID_Submenu, ID_Opcion)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function




    <WebMethod()>
    Public Function OpVerificaAccesosFormulario(ByVal Usuario As Object, ByVal ID_Usuario As Object, ByVal txtFormulario As Object, ByVal wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Seguridad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As New DataSet
        Try
            Resultado = Negocio.OpVerificaAccesosFormulario(Usuario, ID_Usuario, txtFormulario)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


End Class
