Imports WsSeguridad
Imports System.Data
Imports System.Threading
Imports System.Globalization
Imports System.Diagnostics
Partial Class Funcionalidad_Clientes
    Inherits System.Web.UI.Page
    Private Servicio As New WsSeguridad.Seguridad
    Public vSistema As String = System.Configuration.ConfigurationManager.AppSettings.Item("sistema")
    Public vEmpresa As String = System.Configuration.ConfigurationManager.AppSettings.Item("empresa")

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Session("sCliente") Is Nothing Then
                Response.Buffer = True
                Response.Clear()
                Response.Redirect("../Framework/Acceso.aspx")
            End If


            VerificaAccesos("Clientes")

        Else
        End If
    End Sub


    Public Sub VerificaAccesos(ByVal txtFormulario As Object)
        Dim DsAccesos As New DataSet
        Dim dtAccesos As DataTable
        Dim drAccesos As DataRow
        Dim vRenglon As Int32 = 0
        DsAccesos = Servicio.OpVerificaAccesosFormulario(Session("sUsuario"), Session("iIdUsuario"), txtFormulario, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
        dtAccesos = DsAccesos.Tables("Accesos")
        Dim txtAcceso As Object
        Dim txtAccesosUsuario As String = ""


        If DsAccesos.Tables.Count > 0 Then
            If DsAccesos.Tables(0).Rows.Count > 0 Then
                For Each drAccesos In dtAccesos.Rows
                    txtAcceso = DsAccesos.Tables("Accesos").Rows(vRenglon)("nombre").ToString.Trim

                    If txtAcceso = "AGREGAR" Then
                        Me.PanelAgregar.Visible = True
                    End If

                    If txtAcceso = "EDITAR" Then
                        Me.PanelEditar.Visible = False
                    End If

                    If txtAcceso = "ELIMINAR" Then
                        Me.Panel1.Visible = True
                    End If

                    vRenglon = vRenglon + 1
                    txtAccesosUsuario = txtAccesosUsuario & txtAcceso & "-"

                    Me.lblAccesos.Text = txtAccesosUsuario
                Next drAccesos
            Else
                Me.lblAccesos.Text = "Su usuario no tiene acceso a este formaulario..."
                Response.Buffer = True
                Response.Clear()
                Response.Redirect("../Framework/Acceso.aspx")
                Response.Redirect("../Framework/Acceso.aspx")
            End If
        End If



    End Sub

End Class
