Imports System.Data


Partial Class Framework_Inicio
    Inherits System.Web.UI.Page
    Public vRutaLogotipos As String
    Public NombreAplicacion As String
    'Public vEmpresa As String = System.Configuration.ConfigurationManager.AppSettings.Item("empresa")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        vRutaLogotipos = System.Configuration.ConfigurationManager.AppSettings.Item("carpetaLogotipos")
        NombreAplicacion = System.Configuration.ConfigurationManager.AppSettings.Item("nombreSolucion")
    End Sub



End Class
