Imports System
Imports System.Configuration
Imports System.Xml
Imports System.Xml.Serialization
Imports System.Xml.XPath
Imports System.Collections
Imports System.Diagnostics



Public Class ConexionesConfigurationSectionHandler
    Implements IConfigurationSectionHandler

    Public Function Create(ByVal parent As Object, ByVal configContext As Object, ByVal section As System.Xml.XmlNode) As Object Implements System.Configuration.IConfigurationSectionHandler.Create

        Dim arrConexiones As New ArrayList
        Dim constructorArgs(0) As Object
        Dim listaConexiones As XmlNodeList = section.SelectNodes("conexion")

        For Each elementoConexion As XmlNode In listaConexiones
            Dim nombreTipo As String = elementoConexion.Attributes("tipo").Value
            constructorArgs(0) = elementoConexion
            Dim conexion As ConexionBackend = Activator.CreateInstance(Type.GetType(nombreTipo), constructorArgs)
            arrConexiones.Add(conexion)

        Next
        Return arrConexiones.ToArray(GetType(ConexionBackend))
    End Function

End Class


