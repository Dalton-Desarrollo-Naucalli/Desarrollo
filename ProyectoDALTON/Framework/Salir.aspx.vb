Imports System.Data


Partial Class Framework_Salir
    Inherits System.Web.UI.Page
    Public vEmpresa As String = System.Configuration.ConfigurationManager.AppSettings.Item("empresa")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        

    End Sub
End Class
