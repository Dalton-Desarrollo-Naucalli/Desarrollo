Imports System.Data
Imports DevExpress.Web

Partial Class Funcionalidad_LineaFondeos_IndexRemesa
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If IsPostBack Then

        Else
            If Convert.ToInt32(Context.Items("idRemesa")) > 0 Then

                Dim fnc = New WsFuncionalidad.Funcionalidad
                Dim DetalleRemesa As New DataSet
                Dim IDRemesa As Int32 = Convert.ToInt32(Context.Items("idRemesa"))

                DetalleRemesa = fnc.selectDetalleRemesa(IDRemesa, "ConexionDBS")

                remesasdetailgrid.DataSource = DetalleRemesa
                remesasdetailgrid.DataBind()
                txt_NoRemesa.Text = Convert.ToString(IDRemesa)
                txt_qtyContracts.Text = Convert.ToString(DetalleRemesa.Tables(0).Rows.Count)

                PageRemesas.ActiveTabIndex = 1

            Else

                CargaRemesas()
                PageRemesas.ActiveTabIndex = 0
            End If
        End If

    End Sub
    Public Sub CargaRemesas()
        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim Remesas As New DataSet
        Remesas = fnc.selectRemesasFondeo("ConexionDBS")
        remesasgrid.DataSource = Remesas
        remesasgrid.DataBind()
    End Sub

    Private Sub remesasdetailgrid_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs) Handles remesasdetailgrid.CustomCallback

        Dim callback As String() = e.Parameters.Split("|")

        If (callback(0).Equals("cargaremesadetail")) Then

            Dim fnc = New WsFuncionalidad.Funcionalidad
            Dim DetalleRemesa As New DataSet
            Dim IDRemesa As Int32 = callback(1)

            DetalleRemesa = fnc.selectDetalleRemesa(IDRemesa, "ConexionDBS")

            remesasdetailgrid.DataSource = DetalleRemesa
            remesasdetailgrid.DataBind()



        End If


    End Sub
    Protected Sub PageRemesas_ActiveTabChanged(source As Object, e As TabControlEventArgs) Handles PageRemesas.ActiveTabChanged

    End Sub
End Class
