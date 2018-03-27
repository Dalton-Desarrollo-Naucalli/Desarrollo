Imports System.Data
Imports System.Configuration


Namespace SqlServer

    Public Class ClienteSqlServerServicioDatos
        Inherits MarshalByRefObject
        Implements IClienteServicioDatos

        Private _conexionBackend As ConexionBackendSqlServer
        Private Const SQLSERVER_ERRORNUMBER_LOGIN As Integer = 18456
        Private Const SQLSERVER_ERRORNUMBER_SERVER As Integer = 17


        Public Sub New(ByVal conexion As ConexionBackendSqlServer)
            _conexionBackend = conexion
        End Sub



        Function EjecutarComando(ByVal comando As String) As Integer Implements IClienteServicioDatos.EjecutarComando
            Dim parametros(-1) As IDataParameter
            Return EjecutarComando(comando, CommandType.Text, parametros)
        End Function
        Function EjecutarComando(ByVal comando As String, ByVal tipo As CommandType) As Integer Implements IClienteServicioDatos.EjecutarComando
            Dim parametros(-1) As IDataParameter
            Return EjecutarComando(comando, tipo, parametros)
        End Function
        Function EjecutarComando(ByVal comando As String, ByVal parametros As IDataParameter()) As Integer Implements IClienteServicioDatos.EjecutarComando
            Return EjecutarComando(comando, CommandType.Text, parametros)
        End Function
        Function EjecutarComando(ByVal comando As String, ByVal tipo As CommandType, ByVal parametros As IDataParameter(), Optional ByVal page As System.Web.UI.Page = Nothing) As Integer Implements IClienteServicioDatos.EjecutarComando

            Dim conexion As New SqlClient.SqlConnection(GetConnectionString())

            Dim cmd As New SqlClient.SqlCommand(comando) With {
                .CommandText = comando,
                .CommandType = tipo,
                .Connection = conexion,
                .CommandTimeout = 0
            }

            AnexarParametros(cmd, parametros)

            'Inicializo la variable global de errores
            'seleccionDatos.datosSeleccionados.setMensajeError(Nothing)

            Dim registrosAfectados As Integer
            Dim errMessage As String = ""
            Try
                conexion.Open()
                registrosAfectados = cmd.ExecuteNonQuery()
            Catch ex As Exception
                Dim Aleatorio As Integer = GeneraAleatorio()
                MensajesError.MensajeError(Aleatorio) = ex.Message
                registrosAfectados = Aleatorio
            Finally
                If (Not conexion Is Nothing) Then
                    conexion.Close()
                End If
            End Try

            Return registrosAfectados

        End Function


        Public Function EjecutarEscalar(ByVal comando As String) As Object Implements IClienteServicioDatos.EjecutarEscalar
            Dim parametros(-1) As IDataParameter
            Return EjecutarEscalar(comando, CommandType.Text, parametros)
        End Function
        Public Function EjecutarEscalar(ByVal comando As String, ByVal tipoComando As CommandType) As Object Implements IClienteServicioDatos.EjecutarEscalar
            Dim parametros(-1) As IDataParameter
            Return EjecutarEscalar(comando, tipoComando, parametros)
        End Function
        Public Function EjecutarEscalar(ByVal comando As String, ByVal parametros() As IDataParameter) As Object Implements IClienteServicioDatos.EjecutarEscalar
            Return EjecutarEscalar(comando, CommandType.Text, parametros)
        End Function
        Public Function EjecutarEscalar(ByVal comando As String, ByVal tipoComando As CommandType, ByVal parametros() As IDataParameter) As Object Implements IClienteServicioDatos.EjecutarEscalar

            Dim conexion As New SqlClient.SqlConnection(GetConnectionString())
            Dim cmd As New SqlClient.SqlCommand With {
                .CommandText = comando,
                .Connection = conexion,
                .CommandType = tipoComando
            }

            AnexarParametros(cmd, parametros)

            Dim resultado As Object = Nothing
            Try
                conexion.Open()
                resultado = cmd.ExecuteScalar()
            Catch ex As Exception
                Dim Aleatorio As Integer = GeneraAleatorio()
                MensajesError.MensajeError(Aleatorio) = ex.Message
                resultado = Aleatorio
            Finally

                If (Not conexion Is Nothing) Then
                    conexion.Close()
                End If
            End Try

            Return resultado

        End Function

        Public Function EjecutarReader(ByVal comando As String) As IDataReader Implements IClienteServicioDatos.EjecutarReader


            Dim conexion As New SqlClient.SqlConnection(GetConnectionString())
            Dim cmd As New SqlClient.SqlCommand With {
                .CommandText = comando,
                .Connection = conexion
            }


            Dim resultado As IDataReader = Nothing
            Try
                conexion.Open()
                resultado = cmd.ExecuteReader()
            Catch ex As Exception

                conexion.Dispose()
            Finally
                If (Not conexion Is Nothing) Then
                    conexion.Close()
                End If
            End Try

            Return resultado

        End Function

        Public Sub LlenarDataSet(ByVal comando As String, ByRef ds As DataSet) Implements IClienteServicioDatos.LlenarDataSet
            Dim parametros(-1) As IDataParameter
            LlenarDataSet(comando, ds, String.Empty, CommandType.Text, parametros)
        End Sub
        Public Sub LlenarDataSet(ByVal comando As String, ByRef ds As DataSet, ByVal nombreTabla As String) Implements IClienteServicioDatos.LlenarDataSet
            Dim parametros(-1) As IDataParameter
            LlenarDataSet(comando, ds, nombreTabla, CommandType.Text, parametros)
        End Sub
        Public Sub LlenarDataSet(ByVal comando As String, ByRef ds As DataSet, ByVal tipoComando As CommandType) Implements IClienteServicioDatos.LlenarDataSet
            Dim parametros(-1) As IDataParameter
            LlenarDataSet(comando, ds, String.Empty, tipoComando, parametros)
        End Sub
        Public Sub LlenarDataSet(ByVal comando As String, ByRef ds As DataSet, ByVal nombreTabla As String, ByVal tipoComando As CommandType) Implements IClienteServicioDatos.LlenarDataSet
            Dim parametros(-1) As IDataParameter
            LlenarDataSet(comando, ds, nombreTabla, CommandType.Text, parametros)
        End Sub
        Public Sub LlenarDataSet(ByVal comando As String, ByRef ds As DataSet, ByVal parametros As IDataParameter()) Implements IClienteServicioDatos.LlenarDataSet
            LlenarDataSet(comando, ds, String.Empty, CommandType.Text, parametros)
        End Sub
        Public Sub LlenarDataSet(ByVal comando As String, ByRef ds As DataSet, ByVal nombreTabla As String, ByVal parametros As IDataParameter()) Implements IClienteServicioDatos.LlenarDataSet
            LlenarDataSet(comando, ds, nombreTabla, CommandType.Text, parametros)
        End Sub
        Public Sub LlenarDataSet(ByVal comando As String, ByRef ds As DataSet, ByVal tipoComando As CommandType, ByVal parametros As IDataParameter()) Implements IClienteServicioDatos.LlenarDataSet
            LlenarDataSet(comando, ds, String.Empty, tipoComando, parametros)
        End Sub
        Public Sub LlenarDataSet(ByVal comando As String, ByRef ds As DataSet, ByVal nombreTabla As String, ByVal tipoComando As CommandType, ByVal parametros As IDataParameter()) Implements IClienteServicioDatos.LlenarDataSet

            Dim conexion As New SqlClient.SqlConnection(GetConnectionString())

            Dim cmd As New SqlClient.SqlCommand(comando) With {
                .CommandText = comando,
                .CommandType = tipoComando,
                .Connection = conexion,
                .CommandTimeout = 0
            }

            AnexarParametros(cmd, parametros)

            Dim adapter As New SqlClient.SqlDataAdapter(cmd)

            If nombreTabla Is Nothing Or nombreTabla = String.Empty Then
                Try
                    adapter.Fill(ds)
                Catch ex As Exception
                    Dim Aleatorio As Integer = GeneraAleatorio()
                    MensajesError.MensajeError(Aleatorio) = ex.Message

                End Try

            Else
                Try
                    adapter.Fill(ds, nombreTabla)
                Catch ex As Exception
                    Dim Aleatorio As Integer = GeneraAleatorio()
                    MensajesError.MensajeError(Aleatorio) = ex.Message

                End Try
            End If

            If (Not conexion Is Nothing) Then
                conexion.Close()
            End If

        End Sub
        Public Function ValidarUsuario(ByVal usuario As String, ByVal password As String) As Boolean Implements IClienteServicioDatos.ValidarUsuario

            Dim conexion As SqlClient.SqlConnection = Nothing
            Try
                ' Intentar conectar a la base de datos con las credenciales especificadas
                conexion = New SqlClient.SqlConnection(GetConnectionString(usuario, password))
                conexion.Open()
                Return True
            Catch ex As SqlClient.SqlException

                Dim Mensaje As String = ""

                Select Case ex.Number
                    Case SQLSERVER_ERRORNUMBER_LOGIN
                        Mensaje = "Usuario o Contraseña incorrectos, favor de verificar"
                    Case SQLSERVER_ERRORNUMBER_SERVER
                        Mensaje = "No es posible encontrar el servidor o el acceso esta denegado"
                    Case Else
                        Mensaje = ex.Message
                End Select

                Throw New Exception(Mensaje)


            Catch ex As Exception

                Dim Mensaje As String = "La conexión genero el siguiente error:" & vbCrLf
                Throw New Exception(Mensaje & ex.Message)
                ' Si no se pudo conectar por otra razón, no significa que las credenciales
                ' sean incorrectas. Se debe tirar una excepción.
            Finally
                If (Not conexion Is Nothing) Then
                    conexion.Close()
                End If
            End Try

            Return False

        End Function
        Public Function ConstruirParametro(ByVal nombre As String, ByVal tipo As DbType, ByVal valor As Object) As IDataParameter Implements IClienteServicioDatos.ConstruirParametro

            Return ConstruirParametro(nombre, tipo, valor, 0)

        End Function
        Public Function ConstruirParametro(ByVal nombre As String, ByVal tipo As DbType, ByVal valor As Object, ByVal longitud As Integer) As IDataParameter Implements IClienteServicioDatos.ConstruirParametro

            Return ConstruirParametro(nombre, tipo, valor, 0, ParameterDirection.Input)

        End Function
        Function ConstruirParametro(ByVal nombre As String, ByVal tipo As DbType, ByVal valor As Object, ByVal longitud As Integer, ByVal direction As ParameterDirection) As IDataParameter Implements IClienteServicioDatos.ConstruirParametro
            Dim param As New SqlClient.SqlParameter(nombre, valor) With {
                .DbType = tipo,
                .Direction = direction
            }
            If (longitud <> 0) Then param.Size = longitud
            Return param
        End Function
        Private Sub AnexarParametros(ByVal comando As SqlClient.SqlCommand, ByVal parametros() As IDataParameter)

            If parametros Is Nothing Then Exit Sub

            For Each param As IDataParameter In parametros
                Trace.Assert(Not param Is Nothing, "No se puede usar un parámetro nulo para la ejecución")
                comando.Parameters.Add(param)
            Next

        End Sub

        Private Function GetConnectionString(ByVal usuario As String, ByVal password As String)

            ' Cargar cadena de conexón y sustituir el nombre de usuario y password
            _conexionBackend.Usuario = usuario
            _conexionBackend.Password = password
            Return String.Format("Server={0};Database={1};User Id={2};Password={3};", _conexionBackend.Servidor, _conexionBackend.BaseDatos, _conexionBackend.Usuario, _conexionBackend.Password)

        End Function

        Private Function GetConnectionString()

            Return String.Format("Server={0};Database={1};User Id={2};Password={3};", _conexionBackend.Servidor, _conexionBackend.BaseDatos, _conexionBackend.Usuario, _conexionBackend.Password)

        End Function




        Public Function getCadenaConexion() As String Implements IClienteServicioDatos.getCadenaConexion
            Return GetConnectionString()
        End Function

        Public Overrides Function InitializeLifetimeService() As Object
            Return Nothing
        End Function

        Private Function GeneraAleatorio() As Integer
            Dim Resultado As Integer
            Randomize()
            Resultado = CInt((2000 * Rnd()) + 1000) * -1

            Return Resultado

        End Function
    End Class

End Namespace

