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


Partial Class MiFuncionalidad_AbonoCapitalArrendamientoPuro
    Inherits System.Web.UI.Page
    Private Servicio As New WsFuncionalidad.Funcionalidad
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        If IsPostBack Then

        Else


        End If
    End Sub



End Class
