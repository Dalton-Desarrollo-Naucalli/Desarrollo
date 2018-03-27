
Imports System.Data
Imports DevExpress.Web

Partial Class Funcionalidad_LineaFondeos_LineasFondeo
    Inherits System.Web.UI.Page

    Public Shared Garantia() As Integer
    Public Shared contGarant As Integer


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If IsPostBack Then
            cargadetalle()
        Else
            Cargafondeadoras()
            tsFondeadoras.ActiveTabIndex = 0


        End If

    End Sub

    Private Sub Cargafondeadoras()

        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim Fondeadoras As New DataSet
        Fondeadoras = fnc.selectLineasFondeadoras("ConexionDBS")
        gv_LineasFondeo.DataSource = Fondeadoras
        gv_LineasFondeo.DataBind()


    End Sub
    Private Sub cargadetalle()

        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim Fondeadoras As New DataSet
        Fondeadoras = fnc.selectLineasFondeadoras("ConexionDBS")
        gv_LineasFondeo.DataSource = Fondeadoras
        gv_LineasFondeo.DataBind()


    End Sub

    Public Function gv_LineasFondeo_CustomCallback(sender As Object, e As DevExpress.Web.ASPxGridViewCustomCallbackEventArgs) As String

        Return ""
    End Function


    Public Function gv_DetalleFondeo_CustomCallback(sender As Object, e As DevExpress.Web.ASPxGridViewCustomCallbackEventArgs) As DataSet

        Dim callback As String() = e.Parameters.Split("|")


        If (callback(0).Equals("CargaDetalleFondeo")) Then

            Dim fnc = New WsFuncionalidad.Funcionalidad
            Dim DetalleFondeo As New DataSet
            Dim IDfondeo As Int32 = callback(1)

            DetalleFondeo = fnc.selectDetalleFondeo(IDfondeo, "ConexionDBS")

            gv_DetalleFondeo.DataSource = DetalleFondeo
            gv_DetalleFondeo.DataBind()

        End If




        Return Nothing
    End Function

    Protected Sub tsFondeadoras_ActiveTabChanged(source As Object, e As DevExpress.Web.TabControlEventArgs) Handles tsFondeadoras.ActiveTabChanged

    End Sub


    Private Sub gv_EnGarantia_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs) Handles gv_EnGarantia.CustomCallback
        Dim callback As String() = e.Parameters.Split("|")
        If (callback(0).Equals("CargaContratos")) Then

            Dim fnc = New WsFuncionalidad.Funcionalidad
            Dim EnGarantia As New DataSet
            Dim idParamEle As Int32

            idParamEle = callback(1)


            EnGarantia = fnc.selectCreditos("ConexionDBS", idParamEle)

            gv_EnGarantia.DataSource = EnGarantia
            gv_EnGarantia.DataBind()

            ReDim Garantia(EnGarantia.Tables(0).Rows.Count)
            contGarant = 0

        End If
        If (callback(0).Equals("Asignchecked")) Then


            Dim idContrato As Int32

            idContrato = callback(1)

            Garantia(contGarant) = idContrato

            contGarant = contGarant + 1

        End If



    End Sub

    Private Sub gv_EnReemplazo_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs) Handles gv_EnReemplazo.CustomCallback
        Dim callback As String() = e.Parameters.Split("|")

        If (callback(0).Equals("CargaContratos")) Then

            Dim fnc = New WsFuncionalidad.Funcionalidad
            Dim EnReemplazo As New DataSet
            Dim idParamEle As Int32

            idParamEle = callback(1)
            EnReemplazo = fnc.selectCredReemplazo("ConexionDBS", idParamEle)
            gv_EnReemplazo.DataSource = EnReemplazo
            gv_EnReemplazo.DataBind()


        End If

    End Sub

    Public Function CreaRemesa(ByRef PLF As Integer, ByRef ContratosQty As Integer, ByRef Contracts() As String) As Integer

        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim Resultado As Int32 = 0
        Resultado = fnc.InsertaRemesa(PLF, ContratosQty, Contracts, "ConexionDBS")

        Return Resultado

    End Function

    Private Sub generaremesab_Click(sender As Object, e As EventArgs) Handles generaremesab.Click
        Dim Contratos() As String
        Dim IdParamLF As Integer
        Dim QtyContracts As Integer
        Dim RemesaNo As Integer


        If ListGarantiaSel.Items.Count > 0 Then

            ReDim Contratos(ListGarantiaSel.Items.Count - 1)

            For j As Integer = 0 To ListGarantiaSel.Items.Count - 1
                If Not String.IsNullOrEmpty(ListGarantiaSel.Items(j).Text) Then

                    Contratos(j) = ListGarantiaSel.Items(j).Text
                End If


            Next j

            IdParamLF = txtIdParamLF.Text
            QtyContracts = Contratos.Count

            RemesaNo = CreaRemesa(IdParamLF, QtyContracts, Contratos)

            ListGarantiaSel.Items.Clear()
        End If

        If ListReemplazoSel.Items.Count > 0 Then

            ReDim Contratos(ListReemplazoSel.Items.Count - 1)

            For j As Integer = 0 To ListReemplazoSel.Items.Count - 1
                If Not String.IsNullOrEmpty(ListReemplazoSel.Items(j).Text) Then

                    Contratos(j) = ListReemplazoSel.Items(j).Text
                End If


            Next j

            IdParamLF = txtIdParamLF.Text
            QtyContracts = Contratos.Count

            RemesaNo = CreaRemesa(IdParamLF, QtyContracts, Contratos)

            ListReemplazoSel.Items.Clear()
        End If
        Context.Items("idRemesa") = RemesaNo
        Server.Transfer("IndexRemesa.aspx")


    End Sub

    Private Sub gv_ContratosxCeder_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs) Handles gv_ContratosxCeder.CustomCallback

        Dim callback As String() = e.Parameters.Split("|")

        If (callback(0).Equals("CargaAnexosC")) Then

            Dim fnc = New WsFuncionalidad.Funcionalidad
            Dim Anexos As New DataSet
            Dim idParamEle As Int32

            idParamEle = callback(1)
            Anexos = fnc.selectCreditos("ConexionDBS", idParamEle)
            gv_ContratosxCeder.DataSource = Anexos
            gv_ContratosxCeder.DataBind()


        End If

    End Sub

    Private Sub gv_AnexosGarantia_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs) Handles gv_AnexosGarantia.CustomCallback
        Dim callback As String() = e.Parameters.Split("|")

        If (callback(0).Equals("CargaAnexosG")) Then

            Dim fnc = New WsFuncionalidad.Funcionalidad
            Dim AnexosG As New DataSet
            Dim idParamEle As Int32

            idParamEle = callback(1)
            AnexosG = fnc.selectCreditosGarantia("ConexionDBS", idParamEle)
            gv_AnexosGarantia.DataSource = AnexosG
            gv_AnexosGarantia.DataBind()


        End If



    End Sub

    Private Sub ButtonRemesa_Click(sender As Object, e As EventArgs) Handles ButtonRemesa.Click
        Dim Contratos() As String
        Dim IdParamLF As Integer
        Dim QtyContracts As Integer
        Dim RemesaNo As Integer


        If ListContGar.Items.Count > 0 Then

            ReDim Contratos(ListContGar.Items.Count - 1)

            For j As Integer = 0 To ListContGar.Items.Count - 1
                If Not String.IsNullOrEmpty(ListContGar.Items(j).Text) Then

                    Contratos(j) = ListContGar.Items(j).Text
                End If


            Next j

            IdParamLF = txt_ParamLFid.Text
            QtyContracts = Contratos.Count

            RemesaNo = CreaRemesa(IdParamLF, QtyContracts, Contratos)

            ListContGar.Items.Clear()
        End If

        Context.Items("idRemesa") = RemesaNo
        Server.Transfer("IndexRemesa.aspx")
    End Sub

    Private Sub GridAnexoDetalle_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs) Handles GridAnexoDetalle.CustomCallback
        Dim callback As String() = e.Parameters.Split("|")

        If (callback(0).Equals("DetalleAnexos")) Then

            Dim fnc = New WsFuncionalidad.Funcionalidad
            Dim AnexosGarantia As New DataSet
            Dim MesVence As Int32

            MesVence = callback(1)
            AnexosGarantia = fnc.AnexosReemplazoDet("ConexionDBS", MesVence)
            GridAnexoDetalle.DataSource = AnexosGarantia
            GridAnexoDetalle.DataBind()


        End If
    End Sub
End Class
