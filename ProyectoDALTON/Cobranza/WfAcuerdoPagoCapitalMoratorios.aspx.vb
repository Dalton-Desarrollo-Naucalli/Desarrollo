Imports Microsoft.VisualBasic
Imports System
Imports System.Web.UI
Imports DevExpress.Web
Imports System.Diagnostics
Imports WsSeguridad
Imports Modulos.WB.Clases
Imports System.Data
Imports System.IO
Imports System.IO.StreamWriter
Imports System.Threading
Imports System.Globalization


Partial Class MiFuncionalidad_WfAcuerdoPagoCapitalMoratorios
    Inherits System.Web.UI.Page
    Private Servicio As New WsFuncionalidad.Funcionalidad
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If IsPostBack Then
            'ConfiguraGrids()

        Else

            'ConfiguraGrids()
        End If
    End Sub

    Private Sub buttonBloqueo_Click(sender As Object, e As EventArgs) Handles buttonBloqueo.Click
        Dim vTemporal As Object
        vTemporal = 0

    End Sub

    Private Sub buttonDesbloqueo_Click(sender As Object, e As EventArgs) Handles buttonDesbloqueo.Click

    End Sub


End Class
