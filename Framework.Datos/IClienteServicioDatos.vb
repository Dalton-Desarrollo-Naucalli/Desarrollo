Imports System.Data
Imports System.Web


Public Interface IClienteServicioDatos


    Function ValidarUsuario(ByVal usuario As String, ByVal password As String) As Boolean


    Sub LlenarDataSet(ByVal query As String, ByRef ds As DataSet)
    Sub LlenarDataSet(ByVal query As String, ByRef ds As DataSet, ByVal nombreTabla As String)
    Sub LlenarDataSet(ByVal query As String, ByRef ds As DataSet, ByVal tipoComando As CommandType)
    Sub LlenarDataSet(ByVal query As String, ByRef ds As DataSet, ByVal nombreTabla As String, ByVal tipoComando As CommandType)
    Sub LlenarDataSet(ByVal query As String, ByRef ds As DataSet, ByVal parametros As IDataParameter())
    Sub LlenarDataSet(ByVal query As String, ByRef ds As DataSet, ByVal nombreTabla As String, ByVal parametros As IDataParameter())
    Sub LlenarDataSet(ByVal query As String, ByRef ds As DataSet, ByVal tipoComando As CommandType, ByVal parametros As IDataParameter())
    Sub LlenarDataSet(ByVal query As String, ByRef ds As DataSet, ByVal nombreTabla As String, ByVal tipoComando As CommandType, ByVal parametros As IDataParameter())

    Function ConstruirParametro(ByVal nombre As String, ByVal tipo As DbType, ByVal valor As Object) As IDataParameter
    Function ConstruirParametro(ByVal nombre As String, ByVal tipo As DbType, ByVal valor As Object, ByVal longitud As Integer) As IDataParameter
    Function ConstruirParametro(ByVal nombre As String, ByVal tipo As DbType, ByVal valor As Object, ByVal longitud As Integer, ByVal direction As ParameterDirection) As IDataParameter


    Function EjecutarComando(ByVal comando As String) As Integer
    Function EjecutarComando(ByVal comando As String, ByVal tipo As CommandType) As Integer
    Function EjecutarComando(ByVal comando As String, ByVal parametros As IDataParameter()) As Integer
    Function EjecutarComando(ByVal comando As String, ByVal tipo As CommandType, ByVal parametros As IDataParameter(), Optional ByVal page As System.Web.UI.Page = Nothing) As Integer

    Function EjecutarEscalar(ByVal comando As String) As Object
    Function EjecutarEscalar(ByVal comando As String, ByVal tipoComando As CommandType) As Object
    Function EjecutarEscalar(ByVal comando As String, ByVal parametros() As IDataParameter) As Object
    Function EjecutarEscalar(ByVal comando As String, ByVal tipoComando As CommandType, ByVal parametros() As IDataParameter) As Object

    Function EjecutarReader(ByVal comando As String) As IDataReader

    Function getCadenaConexion() As String

End Interface


