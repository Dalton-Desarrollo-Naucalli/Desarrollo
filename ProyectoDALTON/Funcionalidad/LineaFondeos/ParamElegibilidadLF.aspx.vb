
Imports System.Data
Imports System.Web.Script.Services
Imports System.Web.Services
Imports DevExpress.Web
Imports System.Linq
Imports System.Globalization


Partial Class Funcionalidad_LineaFondeos_ParamElegibilidadLF
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load

        If IsPostBack Then

        Else
            cargaGridEmpresas()
            cargacombos()
            tsFondeadoras.ActiveTabIndex = 0

        End If



    End Sub
    Private Sub cargaGridEmpresas()
        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim EmpresasLF As New DataSet
        EmpresasLF = fnc.selectEmpresasLF("ConexionDBS")
        gv_LineaFondeo.DataSource = EmpresasLF
        gv_LineaFondeo.DataBind()
    End Sub
    Private Sub cargacombos()
        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim MarcasLF As New DataSet()
        MarcasLF = fnc.selectMarcas("ConexionDBS")
        txt_marca_id.DataSource = MarcasLF.Tables(0)
        txt_marca_id.DataBind()

        Dim AseguradorasLF As New DataSet()
        AseguradorasLF = fnc.selectAseguradoras("ConexionDBS")
        txt_No_aseg.DataSource = AseguradorasLF.Tables(0)
        txt_No_aseg.DataBind()


        Dim ValoresLF As New DataSet()
        ValoresLF = fnc.selectValoresLF("ConexionDBS")
        cbo_IdValorAforoxEF.DataSource = ValoresLF '.Tables(0).Rows
        cbo_IdValorAforoxEF.TextField = "Descripcion"
        cbo_IdValorAforoxEF.ValueField = "IdValorAforoxEF"
        'cbo_IdValorAforoxEF.ValueType = TypeOf Int32
        cbo_IdValorAforoxEF.DataBind()
        cbo_IdValorAforoxEF.SelectedIndex = -1
        cbo_IdValorAforoxEF.IncrementalFilteringMode = DevExpress.Web.IncrementalFilteringMode.StartsWith

        Dim TipoOperLF As New DataSet()
        TipoOperLF = fnc.selectTipoOperLF("ConexionDBS")
        cbo_TipoOperacionxEF.DataSource = TipoOperLF '.Tables(0).Rows
        cbo_TipoOperacionxEF.TextField = "Descripcion"
        cbo_TipoOperacionxEF.ValueField = "IdTipoOperacionxEF"
        'cbo_IdValorAforoxEF.ValueType = TypeOf Int32
        cbo_TipoOperacionxEF.DataBind()
        cbo_TipoOperacionxEF.SelectedIndex = -1
        cbo_TipoOperacionxEF.IncrementalFilteringMode = DevExpress.Web.IncrementalFilteringMode.StartsWith

        Dim Fondeadoras As New DataSet()
        Fondeadoras = fnc.selectFondeadoras("ConexionDBS")
        cboFdoBco.DataSource = Fondeadoras
        cboFdoBco.TextField = "nombre"
        cboFdoBco.ValueField = "cvefonbco"
        cboFdoBco.DataBind()
        cboFdoBco.SelectedIndex = -1
        cboFdoBco.IncrementalFilteringMode = DevExpress.Web.IncrementalFilteringMode.StartsWith

    End Sub



    Public Function gv_LineaFondeo_CustomCallback(sender As Object, e As DevExpress.Web.ASPxGridViewCustomCallbackEventArgs) As Object

        Dim callback As String() = e.Parameters.Split("|")


        If (callback(0).Equals("clear")) Then
            gv_LineaFondeo.DataSourceID = Nothing
            gv_LineaFondeo.DataBind()




            'DDV se asignan los parametros para registrar linea de fondeo
        ElseIf (callback(0).Equals("AltaParametrosElegibilidad")) Then



            Dim Nombre As String = txt_NombreFondo.Text
            Dim MontoAut As String = txt_MontoAutorizado.Text
            Dim FecVen As String = txt_FechaVencimiento.Text
            Dim AforoCtontractual As String = txt_AforoContractual.Text
            Dim Tasa As String = txt_Tasa.Text
            Dim PlazoD As String = txt_PlazoDias.Text
            Dim MesRes As String = txt_MesRestriccionAcceso.Text
            Dim IdAforo As String = cbo_IdValorAforoxEF.Text 'Solo se obtiene el Texto
            Dim NotaCredito As String = rdo_DescuentoNotaCredito.Value
            Dim Garantia As String = txt_PermitirSustitucionGarantia.Value
            Dim Factor As String = txt_FactorAjuste.Text
            Dim AntigFac As String = txt_AntiguedaMaxFac.Text
            Dim FacRen As String = txt_AntiguedadFacRenovacion.Text
            Dim IdTipoOper As String = cbo_TipoOperacionxEF.Text ' Solo se obtiene el texto
            Dim ValMax As String = txt_ValorMaxAforo.Text
            Dim ValMin As String = txt_ValorMinAforo.Text
            Dim RenGarantia As String = txt_PlazoRenGarantia.Text
            Dim FecRen As String = dt_FechaUltRenovacion.Text
            Dim RenFlujo As String = rdo_RenovacionFlujo.Value
            Dim IdPaga As String = rdo_IdQuienlePagan.Value
            Dim porcentajeresid As String = txt_PorcentajeResidual.Text


            Dim Aseguradoras() As String
            ReDim Aseguradoras(txt_No_asegSel.Items.Count - 1)
            For i As Integer = 0 To txt_No_asegSel.Items.Count - 1

                Aseguradoras(i) = txt_No_asegSel.Items(i).Text

            Next i

            Dim Marcas() As String
            ReDim Marcas(txt_marca_idSel.Items.Count - 1)

            For j As Integer = 0 To txt_marca_idSel.Items.Count - 1

                Marcas(j) = txt_marca_idSel.Items(j).Text

            Next j

            InsertaParametros(Nombre, MontoAut, FecVen, AforoCtontractual, Tasa,
                              PlazoD, MesRes, IdAforo, NotaCredito, Garantia,
                              Factor, AntigFac, FacRen, IdTipoOper, ValMax,
                              ValMin, RenGarantia, FecRen, RenFlujo, IdPaga, porcentajeresid, Marcas, Aseguradoras)


        ElseIf (callback(0).Equals("EditaParametrosElegibilidad")) Then




            Dim ID As String = TxtIdLF.Text
            Dim Nombre As String = cboFdoBco.Text
            Dim MontoAut As String = txt_MontoAutorizado.Text
            Dim FecVen As String = txt_FechaVencimiento.Text
            Dim AforoCtontractual As String = txt_AforoContractual.Text
            Dim Tasa As String = txt_Tasa.Text
            Dim PlazoD As String = txt_PlazoDias.Text
            Dim MesRes As String = txt_MesRestriccionAcceso.Text
            Dim IdAforo As String = cbo_IdValorAforoxEF.Text
            Dim NotaCredito As String = rdo_DescuentoNotaCredito.Value
            Dim Garantia As String = txt_PermitirSustitucionGarantia.Value
            Dim Factor As String = txt_FactorAjuste.Text
            Dim AntigFac As String = txt_AntiguedaMaxFac.Text
            Dim FacRen As String = txt_AntiguedadFacRenovacion.Text
            Dim IdTipoOper As String = cbo_TipoOperacionxEF.Text
            Dim ValMax As String = txt_ValorMaxAforo.Text
            Dim ValMin As String = txt_ValorMinAforo.Text
            Dim RenGarantia As String = txt_PlazoRenGarantia.Text
            Dim FecRen As String = dt_FechaUltRenovacion.Text
            Dim RenFlujo As String = rdo_RenovacionFlujo.Value
            Dim IdPaga As String = rdo_IdQuienlePagan.Value
            Dim porcentajeresid As String = txt_PorcentajeResidual.Text

            Dim Aseguradoras() As String
            ReDim Aseguradoras(txt_No_asegSel.Items.Count - 1)
            For i As Integer = 0 To txt_No_asegSel.Items.Count - 1

                Aseguradoras(i) = txt_No_asegSel.Items(i).Text

            Next i

            Dim Marcas() As String
            ReDim Marcas(txt_marca_idSel.Items.Count - 1)

            For j As Integer = 0 To txt_marca_idSel.Items.Count - 1

                Marcas(j) = txt_marca_idSel.Items(j).Text

            Next j

            UpdateParametros(ID, Nombre, MontoAut, FecVen, AforoCtontractual, Tasa, PlazoD, MesRes, IdAforo, NotaCredito, Garantia, Factor, AntigFac, FacRen, IdTipoOper, ValMax, ValMin, RenGarantia, FecRen, RenFlujo, IdPaga, porcentajeresid, Marcas, Aseguradoras)



        End If
        Return Nothing
    End Function

    Public Function InsertaParametros(ByRef Nombre As String, ByRef MontoAut As String,
                                      ByRef FecVen As String, ByRef AforoCtontractual As String,
                                      ByRef Tasa As String, ByRef PlazoD As String, ByRef MesRes As String,
                                      ByRef IdAforo As String, ByRef NotaCredito As String, ByRef Garantia As String,
                                      ByRef Factor As String, ByRef AntigFac As String, ByRef FacRen As String,
                                      ByRef IdTipoOper As String, ByRef ValMax As String, ByRef ValMin As String,
                                      ByRef RenGarantia As String, ByRef FecRen As String, ByRef RenFlujo As String,
                                      ByRef IdPaga As String, ByRef porcentajeresid As String,
                                      ByRef ListMarcas() As String, ByRef ListAsegu() As String) As Int32

        Dim MontoAutorizado = IIf(String.IsNullOrEmpty(MontoAut), 0, Convert.ToDecimal(MontoAut, CultureInfo.InvariantCulture))
        Dim AforoC = IIf(String.IsNullOrEmpty(AforoCtontractual), 0, Convert.ToDecimal(AforoCtontractual, CultureInfo.InvariantCulture))
        Dim Taza = IIf(String.IsNullOrEmpty(Tasa), 0, Convert.ToDecimal(Tasa, CultureInfo.InvariantCulture))
        Dim PlzDias = IIf(String.IsNullOrEmpty(PlazoD), 0, Convert.ToInt32(PlazoD))
        Dim MesRs = IIf(String.IsNullOrEmpty(MesRes), 0, Convert.ToInt32(MesRes))
        Dim FactAntigu = IIf(String.IsNullOrEmpty(AntigFac), 0, Convert.ToInt32(AntigFac))
        Dim RenovFact = IIf(String.IsNullOrEmpty(FacRen), 0, Convert.ToInt32(FacRen))
        Dim GarantRenov = IIf(String.IsNullOrEmpty(RenGarantia), 0, Convert.ToInt32(RenGarantia))
        Dim Fact = IIf(String.IsNullOrEmpty(Factor), 0, Convert.ToDecimal(Factor, CultureInfo.InvariantCulture))
        Dim MaxVal = IIf(String.IsNullOrEmpty(ValMax), 0, Convert.ToDecimal(ValMax, CultureInfo.InvariantCulture))
        Dim MinVal = IIf(String.IsNullOrEmpty(ValMin), 0, Convert.ToDecimal(ValMin, CultureInfo.InvariantCulture))
        Dim QuienPaga = IIf(String.IsNullOrEmpty(IdPaga), 0, Convert.ToInt32(IdPaga))
        Dim PorcResi = IIf(String.IsNullOrEmpty(porcentajeresid), 0, Convert.ToDecimal(porcentajeresid, CultureInfo.InvariantCulture))



        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim Resultado As Int32 = 0
        Resultado = fnc.InsertaParametros(Nombre, MontoAutorizado, Convert.ToDateTime(FecVen), AforoC,
                                          Taza, PlzDias, MesRs, IdAforo,
                                          NotaCredito, Garantia, Fact, FactAntigu, RenovFact,
                                          IdTipoOper, MaxVal, MinVal, GarantRenov,
                                          Convert.ToDateTime(FecRen), RenFlujo, QuienPaga, PorcResi,
                                          ListMarcas, ListAsegu, "ConexionDBS")
        If Resultado > 0 Then
            Dim i As Int32 = 0
            'Inserta Marcas
            For Each i In txt_marca_idSel.Items
                i = i + i

            Next
        End If
        cargaGridEmpresas()
        cargacombos()
        tsFondeadoras.ActiveTabIndex = 0
        Return Resultado
    End Function


    Public Function UpdateParametros(ByRef ID As String, ByRef Nombre As String, ByRef MontoAut As String, ByRef FecVen As String, ByRef AforoCtontractual As String, ByRef Tasa As String, ByRef PlazoD As String, ByRef MesRes As String, ByRef IdAforo As String, ByRef NotaCredito As String, ByRef Garantia As String, ByRef Factor As String, ByRef AntigFac As String, ByRef FacRen As String, ByRef IdTipoOper As String, ByRef ValMax As String, ByRef ValMin As String, ByRef RenGarantia As String, ByRef FecRen As String, ByRef RenFlujo As String, ByRef IdPaga As String, ByRef porcentajeresid As String, ByRef Mrks() As String, ByRef Sekure() As String) As String
        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim Resultado As String = String.Empty
        Resultado = fnc.UpdateParametros(ID, Nombre, MontoAut, FecVen, AforoCtontractual, Tasa, PlazoD, MesRes, IdAforo, NotaCredito, Garantia, Factor, AntigFac, FacRen, IdTipoOper, ValMax, ValMin, RenGarantia, FecRen, RenFlujo, IdPaga, porcentajeresid, Mrks, Sekure, "ConexionDBS")

        cargaGridEmpresas()
        cargacombos()
        tsFondeadoras.ActiveTabIndex = 0

        Return Resultado
    End Function

    <System.Web.Services.WebMethod()>
    <ScriptMethod(ResponseFormat:=ResponseFormat.Json)>
    Public Shared Function ObtenMarcasyAseguradorasLF(ByVal id As Int32) As String

        Dim fnc = New WsFuncionalidad.Funcionalidad

        Dim idLF As Int32 = id

        Dim MarcasLF As New DataSet()
        MarcasLF = fnc.selectMarcasLF(idLF, "ConexionDBS")
        Dim marcasempresa = From marcas In MarcasLF.Tables(0)

        Return Newtonsoft.Json.JsonConvert.SerializeObject(marcasempresa)


    End Function




End Class

