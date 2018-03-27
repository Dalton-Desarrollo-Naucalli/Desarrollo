Imports System.Xml.Serialization
Imports System.Configuration
Imports System.Data



Public MustInherit Class ConexionBackend
#Region "Métodos estáticos"
    Public Shared Function CargarConexionesConfiguradas() As ConexionBackend()
        _conexionesConfiguradas = ConfigurationManager.GetSection("conexionesBackend")
        Return _conexionesConfiguradas
    End Function

    Public Shared Sub creaConexion(ByVal cadenaConexion As String)

        Dim allConexiones As ConexionBackend()
        allConexiones = ConfigurationManager.GetSection("conexionesBackend")
        For i As Int16 = 0 To allConexiones.Length - 1
            If allConexiones(i).NombreConexion.ToUpperInvariant.Trim = cadenaConexion.ToUpperInvariant.Trim Then
                _conexionConfigurada = allConexiones(i)
                Exit For
            End If
        Next
        ConexionDefault = _conexionConfigurada

    End Sub


#End Region

#Region "Miembros de datos"
    Protected _nombreConexion As String
    Protected _usuario As String
    Protected _password As String
    Protected _compania As String
#End Region

#Region "Conexiones del ambiente"

    Private Shared _conexionDefault As ConexionBackend
    Private Shared _conexionesConfiguradas() As ConexionBackend
    Private Shared _conexionesAbiertas() As ConexionBackend
    Private Shared _conexionConfigurada As ConexionBackend

    Public Shared Property ConexionDefault() As ConexionBackend
        Get
            Return _conexionDefault
        End Get
        Set(ByVal Value As ConexionBackend)
            _conexionDefault = Value
        End Set
    End Property

    Public Shared Property ConexionesConfiguradas() As ConexionBackend()
        Get
            Return _conexionesConfiguradas
        End Get
        Set(ByVal Value() As ConexionBackend)
            _conexionesConfiguradas = Value
        End Set
    End Property

    Public Shared Property ConfiguraConexion() As ConexionBackend
        Get
            Return _conexionConfigurada
        End Get
        Set(ByVal Value As ConexionBackend)
            _conexionConfigurada = Value
        End Set
    End Property

    Public Shared Sub AgregarConexionAbierta(ByVal conexion As ConexionBackend)

        ' Agregar conexion al arreglo de conexiones abiertas
        If _conexionesAbiertas Is Nothing Then
            ReDim _conexionesAbiertas(0)
            _conexionesAbiertas(0) = conexion
        Else
            ReDim Preserve _conexionesAbiertas(_conexionesAbiertas.Length)
            _conexionesAbiertas(_conexionesAbiertas.Length - 1) = conexion
        End If

        'Ponerla como conexion default
        ConexionDefault = conexion

    End Sub

    Public Shared Property ConexionesAbiertas() As ConexionBackend()
        Get
            Return _conexionesAbiertas
        End Get
        Set(ByVal Value() As ConexionBackend)
            _conexionesAbiertas = Value
        End Set
    End Property

#End Region

#Region "Propiedades públicas"
    Public Overridable Property NombreConexion()
        Get
            Return _nombreConexion
        End Get
        Set(ByVal Value)
            _nombreConexion = Value
        End Set
    End Property
    Public Overridable Property Usuario()
        Get
            Return _usuario
        End Get
        Set(ByVal Value)
            _usuario = Value
        End Set
    End Property
    Public Overridable Property Password()
        Get
            Return _password
        End Get
        Set(ByVal Value)
            _password = Value
        End Set
    End Property
    Public Overridable Property Compania()
        Get
            Return _compania
        End Get
        Set(ByVal Value)
            _compania = Value
        End Set
    End Property
#End Region

#Region "Métodos públicos"
    Public MustOverride Function Autenticar(ByVal usuario As String, ByVal password As String) As Boolean
    Public MustOverride Function CrearClienteAccesoDatos() As IClienteServicioDatos
    Public Overrides Function ToString() As String
        Return _nombreConexion
    End Function
#End Region
End Class
