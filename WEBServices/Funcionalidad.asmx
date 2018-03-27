<%@ WebService Language="VB" Class="Funcionalidad" %>

Imports System.Web
Imports System.Web.Services
Imports System.Web.Services.Protocols
Imports Framework.Datos.ConexionBackend
Imports Framework.Datos
Imports System.Data

' Para permitir que se llame a este servicio web desde un script, usando ASP.NET AJAX, quite la marca de comentario de la siguiente línea.
' <System.Web.Script.Services.ScriptService()> _
<WebService(Namespace:="http://tempuri.org/")>
<WebServiceBinding(ConformsTo:=WsiProfiles.BasicProfile1_1)>
Public Class Funcionalidad
    Inherits System.Web.Services.WebService

    <WebMethod()>
    Public Function HelloWorld() As String
        Return "Hola a todos"
    End Function

    <WebMethod()>
    Public Function FrmGetMensajeError(ByVal Llave As String, ByVal wsConexion As String) As String
        CreaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.FrmGetMensajeError(Llave)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function ObtenEtiquetaCatCampos(ByVal nombreColumna As String, ByVal catalogo As Integer, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.ObtenEtiquetaCatCampos(nombreColumna, catalogo)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function ObtenEtiquetaReporte(ByVal nombreCampo As String, ByVal wsConexion As String) As String
        CreaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.ObtenEtiquetaReporte(nombreCampo)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function ObtenWidth(ByVal nombreCampo As String, ByVal catalogo As Integer, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.ObtenWidth(nombreCampo, catalogo)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

	<WebMethod()>
    Public Function Parametro(ByVal ID As String, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.Parametro(46)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function
	
    <WebMethod()>
    Public Function ObtenIdTipoCampo(ByVal nombreCampo As String, ByVal catalogo As Integer, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.ObtenIdTipoCampo(nombreCampo, catalogo)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function ObtenValidaDirecta(ByVal nombreCampo As String, ByVal catalogo As Integer, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.ObtenValidaDirecta(nombreCampo, catalogo)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function ObtenTblRelacionGen(ByVal nombreCampo As String, ByVal catalogo As Integer, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.ObtenTblRelacionGen(nombreCampo, catalogo)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function ObtenCatFormato(ByVal nombreCampo As String, ByVal catalogo As Integer, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.ObtenCatFormato(nombreCampo, catalogo)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function ObtenObligatorio(ByVal nombreCampo As String, ByVal catalogo As Integer, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.ObtenObligatorio(nombreCampo, catalogo)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function ObtenTooltip(ByVal nombreCampo As String, ByVal catalogo As Integer, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.ObtenTooltip(nombreCampo, catalogo)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function ObtenLongitud(ByVal nombreCampo As String, ByVal catalogo As Integer, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.ObtenLongitud(nombreCampo, catalogo)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function ObtenDataSet(ByVal Funcionalidad As String, ByVal Parametros As String, ByVal wsConexion As String) As DataSet
        CreaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As New DataSet
        Try
            Resultado = Negocio.ObtenDataSet(Funcionalidad, Parametros)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function ObteneTipoDeCambio(ByVal Fecha As Object, ByVal wsConexion As String) As String
        CreaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.ObteneTipoDeCambio(Fecha)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function tipo_Cliente_Elimina(ByVal id As Int32, ByVal wsConexion As String) As Int32
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.tipo_Cliente_Elimina(id)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function tipo_Cliente_Edita(ByVal id As Int32, ByVal descripcion As String, ByVal wsConexion As String) As Int32
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.tipo_Cliente_Edita(id, descripcion)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function selecTabla(ByVal vParametro01 As Object, ByVal vParametro02 As Object, ByVal vParametro03 As Object, ByVal vParametro04 As Object, ByVal vParametro05 As Object, ByVal vParametro06 As Object, ByVal vParametro07 As Object, wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.selecTabla(vParametro01, vParametro02, vParametro03, vParametro04, vParametro05, vParametro06, vParametro07)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function Fun_Edita(ByRef idCat As Object, ByRef Valores As Object, ByRef valor As Object, ByRef usr As Object, ByRef ip As Object, ByRef estatus As Object, ByRef msj As Object, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.Fun_Edita(idCat, Valores, valor, usr, ip, estatus, msj)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function
    <WebMethod()>
    Public Function Fun_Nuevo(ByRef idCat As Object, ByRef Valores As Object, ByRef CampoValida As Object, ByRef ValoresValida As Object, ByRef usr As Object, ByRef ip As Object, ByRef estatus As Object, ByRef msj As Object, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String
        Try
            Resultado = Negocio.Fun_Nuevo(idCat, Valores, CampoValida, ValoresValida, usr, ip, estatus, msj)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function
    <WebMethod()>
    Public Function Fun_Elimina(ByRef idCat As Object, ByRef valor As Object, ByRef borradoLog As Object, ByRef usr As Object, ByRef ip As Object, ByRef estatus As Object, ByRef msj As Object, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.Fun_Elimina(idCat, valor, borradoLog, usr, ip, estatus, msj)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado
    End Function

    <WebMethod>
    Public Function CatGrals(ByRef Tabla As Object, ByRef Columna As Object, ByRef valor As Object, ByRef Descripcion As Object, ByRef ValorAdicional As Object, ByRef usr As Object, ByRef UltActual As Object, ByRef IdOpcion As Object, ByRef ip As Object, ByRef status As Object, ByRef mj As Object, ByVal wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As New DataSet
        Try
            Resultado = Negocio.CatGrals(Tabla, Columna, valor, Descripcion, ValorAdicional, usr, UltActual, IdOpcion, ip, status, mj)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado
    End Function


    <WebMethod()>
    Public Function TraeDatosConsulta(ByVal strConsulta As Object, wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.TraeDatosConsulta(strConsulta)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function
#Region "Grids en Formularios Independientes"

    <WebMethod()>
    Public Function Grid_Alta(ByRef idcat As Object, ByRef Valores As Object, ByRef Llaves As Object, ByRef usr As Object, ByRef ip As Object, ByRef estatus As Object, ByRef msj As Object, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.Grid_Alta(idcat, Valores, Llaves, usr, ip, estatus, msj)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function Grid_Edita(ByRef idcat As Object, ByRef Valores As Object, ByRef Llaves As Object, ByRef usr As Object, ByRef ip As Object, ByRef estatus As Object, ByRef msj As Object, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.Grid_Edita(idcat, Valores, Llaves, usr, ip, estatus, msj)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function Grid_Elimina(ByRef idCat As Object, ByRef Llaves As Object, ByRef borradoLog As Object, ByRef usr As Object, ByRef ip As Object, ByRef estatus As Object, ByRef msj As Object, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.Grid_Elimina(idCat, Llaves, borradoLog, usr, ip, estatus, msj)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado
    End Function
#End Region
    <WebMethod()>
    Public Function Fun_Tema(ByRef usuario As Object, ByRef tema As Object, ByRef output As Object, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.Fun_Tema(usuario, tema, output)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

#Region "Módulo Factura Seguros"
    <WebMethod()>
    Public Function FacturasSeg_Alta(ByVal ID As Integer, ByVal Factura As String, ByVal NoPoliza As String, ByVal Aseguradora As String, ByVal F_vencimiento As String, ByVal F_emision As String, ByVal NoEndoso As Int32, ByVal CostoDePoliza As Decimal, ByVal iva As Decimal, ByVal CostoTotal As Decimal, ByVal UUID As String, ByVal CONFIRMARPAGO As Boolean, ByVal wsConexion As Object) As Int32
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.FacturasSeg_Alta(ID, Factura, NoPoliza, Aseguradora, F_vencimiento, F_emision, NoEndoso, CostoDePoliza, iva, CostoTotal, UUID, CONFIRMARPAGO)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function FacturasSeg_EliminaTmp(ByVal wsConexion As Object) As Int32
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String = ""
        Try
            Resultado = Negocio.FacturasSeg_EliminaTmp()
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function FacturasSeg_SelectG(wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.FacturasSeg_SelectG()
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function FacturasSeg_SelectGNoM(wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.FacturasSeg_SelectGNoM()
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function
    <WebMethod()>
    Public Function FacturasSeg_SelectFacNoAuto(wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.FacturasSeg_SelectFacNoAuto()
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function
    <WebMethod()>
    Public Function FacturasSeg_Editar(ByVal ID As Integer, ByVal Poliza As String, ByVal CostoTotal As Decimal, ByVal PolizaTemp As String, ByVal confirmarPago As Boolean, wsConexion As String) As Integer
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As Integer

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.FacturasSeg_Editar(ID, Poliza, CostoTotal, PolizaTemp,confirmarPago)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function
#End Region


#Region "MonitorGeneralDeSeguros"
    <WebMethod()>
    Public Function MonitorGeneral_Select(wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.MonitorGeneral_Select()
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function
#End Region


    'WebMethod Cobranza
    <WebMethod()>
    Public Function DatosFuncionalidaCobranza(ByVal Funcionalidad As String, ByVal ParametrosFuncionalidad As String, ByVal wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As New DataSet
        Try
            Resultado = Negocio.DatosFuncionalidaCobranza(Funcionalidad, ParametrosFuncionalidad)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

#Region "Parametrización de Elegibilidad de Línea de fondeo"
    <WebMethod()>
    Public Function selectEmpresasLF(wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.selectEmpresasLF()

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function selectMarcas(wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.selectMarcas()

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function selectMarcasLF(ByRef ID As Int32, wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.selectMarcasLF(ID)

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function selectAseguradorasLF(ByRef ID As Int32, wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.selectAseguradorasLF(ID)

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function selectAseguradoras(wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.selectAseguradoras()

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function selectValoresLF(wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.selectValoresLF()

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function selectTipoOperLF(wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.selectTipoOperLF()

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function selectFondeadoras(wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.selectFondeadoras()

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function InsertaParametros(ByRef Nombre As String, ByRef MontoAut As Decimal, ByRef FecVen As DateTime,
                                       ByRef AforoCtontractual As Decimal, ByRef Tasa As Decimal, ByRef PlazoD As Int32,
                                       ByRef MesRes As Int32, ByRef IdAforo As String, ByRef NotaCredito As Boolean,
                                       ByRef Garantia As Boolean, ByRef Factor As Decimal, ByRef AntigFac As Int32,
                                       ByRef FacRen As Int32, ByRef IdTipoOper As String, ByRef ValMax As Decimal,
                                       ByRef ValMin As Decimal, ByRef RenGarantia As Int32, ByRef FecRen As DateTime,
                                       ByRef RenFlujo As Boolean, ByRef IdPaga As Int32, ByRef porcentajeresid As Decimal,
                                       ByRef MarcaList() As String, ByRef AsegList() As String, wsConexion As String) As Int32
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As Int32 = 0

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.InsertaParametros(Nombre, MontoAut, FecVen, AforoCtontractual, Tasa, PlazoD, MesRes, IdAforo, NotaCredito, Garantia, Factor, AntigFac, FacRen, IdTipoOper, ValMax, ValMin, RenGarantia, FecRen, RenFlujo, IdPaga, porcentajeresid, MarcaList, AsegList)

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function UpdateParametros(ByRef ID As String, ByRef Nombre As String, ByRef MontoAut As String, ByRef FecVen As String, ByRef AforoCtontractual As String, ByRef Tasa As String, ByRef PlazoD As String, ByRef MesRes As String, ByRef IdAforo As String, ByRef NotaCredito As String, ByRef Garantia As String, ByRef Factor As String, ByRef AntigFac As String, ByRef FacRen As String, ByRef IdTipoOper As String, ByRef ValMax As String, ByRef ValMin As String, ByRef RenGarantia As String, ByRef FecRen As String, ByRef RenFlujo As String, ByRef IdPaga As String, ByRef porcentajeresid As String, ByRef Marcas() As String, ByRef Asegura() As String, wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As String = String.Empty

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.UpdateParametros(ID, Nombre, MontoAut, FecVen, AforoCtontractual, Tasa, PlazoD, MesRes, IdAforo, NotaCredito, Garantia, Factor, AntigFac, FacRen, IdTipoOper, ValMax, ValMin, RenGarantia, FecRen, RenFlujo, IdPaga, porcentajeresid, Marcas, Asegura)

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function selectLineasFondeadoras(wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.selectLineasFondeadoras()

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function selectRemesasFondeo(wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.getAllRemesas()

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function


    <WebMethod()>
    Public Function selectDetalleFondeo(ByRef idfondeo As Int32, wsConexion As String) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.selectDetalleFondeo(idfondeo)

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function selectCreditos(wsConexion As String, idParamLF As Integer) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.selectCreditos(idParamLF)

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function selectCreditosGarantia(wsConexion As String, idParamLF As Integer) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.selectCreditosGarantia(idParamLF)

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function selectCredReemplazo(wsConexion As String, idPELF As Integer) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.selectCredReemplazo(idPELF)

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function InsertaRemesa(ParamLF As Integer, CantContartos As Integer, idContratos() As String, wsConexion As String) As Integer
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New Integer

        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.CreaRemesa(ParamLF, CantContartos, idContratos)

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function selectDetalleRemesa(RemesaId As Integer, wsConexion As String) As DataSet

        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet
        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.GetRemesaDetail(RemesaId)

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function

    <WebMethod()>
    Public Function AnexosReemplazoDet(wsConexion As String, Vmes As Integer) As DataSet
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Dim Servicio As New Negocio.Funcionalidad
        Dim Resultado As New DataSet
        Datos = ServicioDatosFactory.GetServicioDatos()
        Servicio.ServicioDeDatos = Datos

        Try
            Resultado = Servicio.GetDetalleAnexos(Vmes)

        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado
    End Function


#End Region

#Region "MÓDULO DE PEDIDOS (VENTAS)"
    <WebMethod()>
    Public Function Guarda_Pedido(ByRef ValoresPedido As Object, ByRef ValoresMovPed As Object, ByRef usr As Object, ByRef ip As Object, ByRef estatus As Object, ByRef msj As Object, ByVal wsConexion As String) As String
        creaConexion(wsConexion)

        Dim Datos As IClienteServicioDatos
        Datos = ServicioDatosFactory.GetServicioDatos()

        Dim Negocio As New Negocio.Funcionalidad
        Negocio.ServicioDeDatos = Datos

        Dim Resultado As String
        Try
            Resultado = Negocio.Guarda_Pedido(ValoresPedido, ValoresMovPed, usr, ip, estatus, msj)
        Catch ex As Exception
            Throw New Exception(ex.Message)
        End Try

        Return Resultado

    End Function
#End Region
End Class
