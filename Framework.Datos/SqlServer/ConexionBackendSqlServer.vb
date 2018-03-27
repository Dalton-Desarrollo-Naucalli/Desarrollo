Imports System.Diagnostics
Imports System.Xml


Namespace SqlServer
    Public Class ConexionBackendSqlServer
        Inherits ConexionBackend

        Public Servidor As String
        Public BaseDatos As String
        Private encripta As New Encriptador

        Public Sub New(ByVal nodoConexion As XmlNode)
            Trace.Assert(nodoConexion.Name = "conexion")
            MyBase._nombreConexion = nodoConexion.Attributes("nombre").Value
            Me.Servidor = nodoConexion.Attributes("servidor").Value
            Me.BaseDatos = (nodoConexion.Attributes("baseDatos").Value)
            Me.Usuario = (nodoConexion.Attributes("userId").Value)
            Me.Password = (nodoConexion.Attributes("pass").Value)

        End Sub

        Public Sub New(ByVal nombreConexion As String, ByVal parametros As Hashtable)

            MyBase._nombreConexion = nombreConexion
            Me.Servidor = parametros("Servidor")
            Me.BaseDatos = parametros("BaseDatos")
            Me.Usuario = parametros("Usuario")
            Me.Password = parametros("Password")

        End Sub

        Public Overrides Function Autenticar(ByVal usuario As String, ByVal password As String) As Boolean
            Dim datos As IClienteServicioDatos
            datos = New ClienteSqlServerServicioDatos(Me)
            Me.Usuario = usuario
            Me.Password = password
            Return datos.ValidarUsuario(Me.Usuario, Me.Password)
        End Function

        Public Overrides Function CrearClienteAccesoDatos() As IClienteServicioDatos
            Return New ClienteSqlServerServicioDatos(Me)
        End Function

    End Class
End Namespace