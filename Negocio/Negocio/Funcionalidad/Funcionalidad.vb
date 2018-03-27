Imports System
Imports System.Web
Imports System.Collections
Imports Framework.Datos
Imports System.Data
Imports System.Configuration
Imports System.Data.SqlClient
Imports System.Globalization

Public Class Funcionalidad

#Region "Variables y propiedades"
    Private Obtendatos As Framework.Datos.IClienteServicioDatos
    Private parametros() As IDbDataParameter
    Private gUsuario As String = ""
    Private gCompania As String = ""
    Private Utilerias As New UtileriasNegocio.Utilerias
    Public _Estatus As String = ""


    Public Property UsuarioServicio() As String
        Get
            UsuarioServicio = gUsuario
        End Get
        Set(ByVal value As String)
            gUsuario = value
        End Set
    End Property
    Public Property ServicioDeDatos() As IClienteServicioDatos
        Get
            ServicioDeDatos = ServicioDatosFactory.GetServicioDatos()
        End Get
        Set(ByVal value As IClienteServicioDatos)
            Obtendatos = value
        End Set
    End Property
#End Region
    Public Function FrmGetMensajeError(ByVal Llave As String) As String
        Obtendatos = ServicioDeDatos
        Dim Mensaje As String

        Mensaje = MensajesError.AsignaMensajeUsuario(Llave, gUsuario)

        Return Mensaje

    End Function

    '================================================================================================================================================================================================
    '================================================================================================================================================================================================
    '================================================================================================================================================================================================
    '================================================================================================================================================================================================
    '================================================================================================================================================================================================

    Public Function ObtenDataSet(ByVal Funcionalidad As String, ByVal Parametros As String) As DataSet
        Obtendatos = ServicioDeDatos

        Dim sql As String = ""

        If Funcionalidad = "ObtenCatalogoDeSociosClientes" Then
            sql += "Select Clave, ltrim(rtrim(Clave)) +  ' - ' + ltrim(rtrim(Nombre)) as Socio from CLIE03 where Status = 'A' order by 1;"

        ElseIf Funcionalidad = "ObtenCatalogoRanchos" Then
            sql += " select distinct clientes.CALLE_ENVIO as Rancho from CLIE03 clientes where CALLE_ENVIO is not null and CALLE_ENVIO <> '' ORDER BY 1 "

        ElseIf Funcionalidad = "SegUsr" Then
            sql = Parametros
        ElseIf Funcionalidad = "SegAcciones" Then
            sql = Parametros
        ElseIf Funcionalidad = "obtenCampo" Then
            sql = Parametros
        ElseIf Funcionalidad = "obtenCampoDatVehiculo" Then
            sql = Parametros
        End If

        Dim dsSrc As New DataSet()
        Obtendatos.LlenarDataSet(sql, dsSrc, "Resultado")

        Return dsSrc

    End Function
    Public Function TraeDatosConsulta(ByVal strQuery As String) As DataSet
        Obtendatos = ServicioDeDatos
        Dim sql As String = ""

        sql = strQuery

        Dim Resultado As New DataSet()
        Obtendatos.LlenarDataSet(sql, Resultado, "Resultado")

        Return Resultado
    End Function
    Public Function ObteneTipoDeCambio(ByVal Fecha As Object) As Decimal
        Obtendatos = ServicioDeDatos
        Dim sql As String = ""
        Dim vTipoDeCambio As Decimal

        Dim vParametros As String()
        vParametros = Fecha.Split("/")
        Dim vAnio As Integer
        Dim vMes As Integer
        Dim vDia As Integer

        vAnio = vParametros(2)
        vMes = vParametros(1)
        vDia = vParametros(0)

        sql += " select Top 1 isnull(TipoCambio,1) as TipoCambio"
        sql += "   from TiposCambio1"
        sql += "  where Moneda_ID = 2"
        sql += "    and year(Fecha) = " & UtileriasNegocio.Utilerias.ValorReal(vAnio, 1)
        sql += "    and month(Fecha) = " & UtileriasNegocio.Utilerias.ValorReal(vMes, 1)
        sql += "    and day(Fecha) = " & UtileriasNegocio.Utilerias.ValorReal(vDia, 1)
        sql += "  order by Fecha desc"

        Dim depura As String = "insert into UCA_DepuraWEB(strSQL) values('" & sql & "');"
        Obtendatos.EjecutarEscalar(depura)

        Try
            vTipoDeCambio = CDec(Obtendatos.EjecutarEscalar(sql))
        Catch ex As Exception
            vTipoDeCambio = 0
        End Try

        Return vTipoDeCambio

    End Function

    Public Function ObtenEtiquetaCatCampos(ByVal nombreColumna As String, ByVal catalogo As Integer) As String
        Obtendatos = ServicioDeDatos
        Dim sql As String = ""
        Dim ECampos As String = ""

        sql = " select etiqueta from catcamposcatalogostbl where alias = " + UtileriasNegocio.Utilerias.ValorReal(nombreColumna, 2) + "and idCatalogo= " & UtileriasNegocio.Utilerias.ValorReal(catalogo, 2)
        ECampos = UCase(Obtendatos.EjecutarEscalar(sql))
        If ECampos.Length = 1 Then
            ECampos = "--"
        End If
        Return ECampos
    End Function

    Public Function ObtenEtiquetaReporte(ByVal nombreCampo As String) As String
        Obtendatos = ServicioDeDatos
        Dim sql As String = ""
        Dim vEtiqueta As String = ""

        sql = " select etiqueta from SAC_CC_NombreColumnasReporte where nombreCampo = " & UtileriasNegocio.Utilerias.ValorReal(nombreCampo, 2)

        vEtiqueta = UCase(Obtendatos.EjecutarEscalar(sql))

        If vEtiqueta.Length = 1 Then
            vEtiqueta = "--"
        End If

        Return vEtiqueta

    End Function
    Public Function ObtenWidth(ByVal nombreCampo As String, ByVal catalogo As Integer) As String
        Obtendatos = ServicioDeDatos
        Dim sql As String = ""
        Dim vEtiqueta As Integer

        sql = " select (isnull(widthColumna,50)) as widthColumna from catcamposcatalogostbl where idCatalogo = " + UtileriasNegocio.Utilerias.ValorReal(catalogo, 2) + " and alias = " & UtileriasNegocio.Utilerias.ValorReal(nombreCampo, 2)

        vEtiqueta = UCase(Obtendatos.EjecutarEscalar(sql))

        If vEtiqueta.ToString().Length = 1 Then
            vEtiqueta = 0
        End If

        Return vEtiqueta

    End Function

    Public Function ObtenIdTipoCampo(ByVal nombreCampo As String, ByVal catalogo As Integer) As String
        Obtendatos = ServicioDeDatos
        Dim sql As String = ""
        Dim vEtiqueta As Integer

        sql = " select idTipoCampo from catcamposcatalogostbl where idCatalogo = " + UtileriasNegocio.Utilerias.ValorReal(catalogo, 2) + " and alias = " & UtileriasNegocio.Utilerias.ValorReal(nombreCampo, 2)

        vEtiqueta = UCase(Obtendatos.EjecutarEscalar(sql))

        Return vEtiqueta

    End Function

	 Public Function Parametro(ByVal ID As Integer) As String
        Obtendatos = ServicioDeDatos
        Dim sql As String = ""
        Dim vEtiqueta As Integer

        sql = ("Select cadena from parametros where id= 46") 

        vEtiqueta = UCase(Obtendatos.EjecutarEscalar(sql))

        Return vEtiqueta

    End Function
	
    Public Function ObtenValidaDirecta(ByVal nombreCampo As String, ByVal catalogo As Integer) As String
        Obtendatos = ServicioDeDatos
        Dim sql As String = ""
        Dim vEtiqueta As Object

        sql = " select validaDirecta from catcamposcatalogostbl where idCatalogo = " + UtileriasNegocio.Utilerias.ValorReal(catalogo, 2) + " and alias = " & UtileriasNegocio.Utilerias.ValorReal(nombreCampo, 2)

        If Obtendatos.EjecutarEscalar(sql) Is Nothing Then
            vEtiqueta = ""
        Else
            vEtiqueta = Obtendatos.EjecutarEscalar(sql)
            If vEtiqueta Is DBNull.Value Then
                vEtiqueta = 0
            End If
        End If

        Return vEtiqueta

    End Function

	 Public Function ObtenTblRelacionGen(ByVal nombreCampo As String, ByVal catalogo As Integer) As String
        Obtendatos = ServicioDeDatos
        Dim sql As String = ""
        Dim Resultado As New DataSet()
        Dim tabla As New DataTable
        Dim cat As String = ""
        Dim tab As String = ""
        Dim col As String = ""
        Dim camporel As String = ""
        Dim colrel As String = ""
        Dim vEtiqueta As Object = ""

        sql = " select tablarelacion, idCatalogoRel, campoRelacion, idCampoRel, idColumnaRel from catcamposcatalogostbl where idCatalogo = " + UtileriasNegocio.Utilerias.ValorReal(catalogo, 2) + " and alias = " & UtileriasNegocio.Utilerias.ValorReal(nombreCampo, 2)

        Obtendatos.LlenarDataSet(sql, Resultado, "Resultado")

        tabla = Resultado.Tables(0)

        For Each row As DataRow In tabla.Rows
            cat = row("idCatalogoRel").ToString
            tab = row("tablarelacion").ToString
            col = row("campoRelacion").ToString
            camporel = row("idCampoRel").ToString 'Valor
            colrel = row("idColumnaRel").ToString 'Descripcion
        Next

        If tab = "GEN" Then
            sql = " select tabla from catCatalogosGenTbl where idCatalogo = " + UtileriasNegocio.Utilerias.ValorReal(cat, 2)
            vEtiqueta = Obtendatos.EjecutarEscalar(sql)
            vEtiqueta = tab + "|" + vEtiqueta + "|" + col
        ElseIf (camporel <> "") Then
            sql = " select alias from catcamposcatalogostbl where idCatalogo = " + UtileriasNegocio.Utilerias.ValorReal(cat, 2) + "and idcampo = " + UtileriasNegocio.Utilerias.ValorReal(camporel, 2)
                camporel = Obtendatos.EjecutarEscalar(sql)
            'End If
            If (colrel <> "") Then
                sql = " select alias from catcamposcatalogostbl where idCatalogo = " + UtileriasNegocio.Utilerias.ValorReal(cat, 2) + "and idcampo = " + UtileriasNegocio.Utilerias.ValorReal(colrel, 2)
                colrel = Obtendatos.EjecutarEscalar(sql)
            End If
            vEtiqueta = tab + "|" + cat + "|" + camporel + "|" + colrel
        End If

            Return vEtiqueta

    End Function
	
	Public Function ObtenCatFormato(ByVal nombreCampo As String, ByVal catalogo As Integer) As String
        Obtendatos = ServicioDeDatos
        Dim sql As String = ""
        Dim vEtiqueta As Object = ""

        sql = " select formatofecha from catcamposcatalogostbl where idCatalogo = " + UtileriasNegocio.Utilerias.ValorReal(catalogo, 2) + " and alias = " & UtileriasNegocio.Utilerias.ValorReal(nombreCampo, 2)

        If Obtendatos.EjecutarEscalar(sql) Is Nothing Then
            vEtiqueta = ""
        Else
            vEtiqueta = Obtendatos.EjecutarEscalar(sql)
            If vEtiqueta Is DBNull.Value Then
                vEtiqueta = ""
            End If
        End If

        Return vEtiqueta

    End Function
	
	Public Function ObtenObligatorio(ByVal nombreCampo As String, ByVal catalogo As Integer) As String
        Obtendatos = ServicioDeDatos
        Dim sql As String = ""
        Dim vEtiqueta As Object

        sql = " select esObligatorio from catcamposcatalogostbl where idCatalogo = " + UtileriasNegocio.Utilerias.ValorReal(catalogo, 2) + " and alias = " & UtileriasNegocio.Utilerias.ValorReal(nombreCampo, 2)

        If Obtendatos.EjecutarEscalar(sql) Is Nothing Then
            vEtiqueta = ""
        Else
            vEtiqueta = Obtendatos.EjecutarEscalar(sql)
            If vEtiqueta Is DBNull.Value Then
                vEtiqueta = 0
            End If
        End If

        Return vEtiqueta

    End Function
	
	Public Function ObtenTooltip(ByVal nombreCampo As String, ByVal catalogo As Integer) As String
        Obtendatos = ServicioDeDatos
        Dim sql As String = ""
        Dim vEtiqueta As Object

        sql = " select descripcionTooltip from catcamposcatalogostbl where idCatalogo = " + UtileriasNegocio.Utilerias.ValorReal(catalogo, 2) + " and alias = " & UtileriasNegocio.Utilerias.ValorReal(nombreCampo, 2)

        If Obtendatos.EjecutarEscalar(sql) Is Nothing Then
            vEtiqueta = ""
        Else
            vEtiqueta = Obtendatos.EjecutarEscalar(sql)
            If vEtiqueta Is DBNull.Value Then
                vEtiqueta = ""
            End If
        End If

        Return vEtiqueta

    End Function
	
    Public Function ObtenLongitud(ByVal nombreCampo As String, ByVal catalogo As Integer) As String
        Obtendatos = ServicioDeDatos
        Dim sql As String = ""
        Dim vEtiqueta As Integer

        sql = " select longitud from catcamposcatalogostbl where idCatalogo = " + UtileriasNegocio.Utilerias.ValorReal(catalogo, 2) + " and alias = " & UtileriasNegocio.Utilerias.ValorReal(nombreCampo, 2)

        vEtiqueta = UCase(Obtendatos.EjecutarEscalar(sql))

        Return vEtiqueta

    End Function
	
    Public Function EjecutaSentenciaSelect(ByVal strSentencia As String) As Decimal
        Obtendatos = ServicioDeDatos
        Dim vResultado As Decimal

        Try
            vResultado = CDec(Obtendatos.EjecutarEscalar(strSentencia))
        Catch ex As Exception
            vResultado = -999
        End Try

        Return vResultado

    End Function
    Public Function tipo_Cliente_Elimina(ByRef id As Int32) As Integer
        Dim Resultado As Integer = 0
        Obtendatos = ServicioDeDatos
        ReDim parametros(0)

        Try
            parametros(0) = Obtendatos.ConstruirParametro("@ID", DbType.Int32, id)
            Resultado = Obtendatos.EjecutarComando("tipo_Cliente_Elimina", CommandType.StoredProcedure, parametros)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try

        Return Resultado

    End Function
    Public Function tipo_Cliente_Edita(ByRef id As Int32, ByRef descripcion As String) As Integer
        Dim Resultado As Integer = 0
        Obtendatos = ServicioDeDatos
        ReDim parametros(1)

        Try
            parametros(0) = Obtendatos.ConstruirParametro("@ID", DbType.Int32, id)
            parametros(1) = Obtendatos.ConstruirParametro("@DESCRIPCION", DbType.String, descripcion)
            Resultado = Obtendatos.EjecutarComando("tipo_Cliente_Edita", CommandType.StoredProcedure, parametros)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try

        Return Resultado

    End Function

#Region "FUNCIONES Catálogo_Maestro y Formularios Independientes"
    Public Function selecTabla(ByVal vParametro01 As Object, ByVal vParametro02 As Object, ByVal vParametro03 As Object, ByVal vParametro04 As Object, ByVal vParametro05 As Object, ByVal vParametro06 As Object, ByVal vParametro07 As Object) As DataSet

        Obtendatos = ServicioDeDatos
        ReDim parametros(6)
        Dim Resultado As New DataSet

        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdCatalogo", DbType.Int32, CInt(vParametro01))
            parametros(1) = Obtendatos.ConstruirParametro("@PsCampos", DbType.String, vParametro02)
            parametros(2) = Obtendatos.ConstruirParametro("@PsWhere", DbType.String, vParametro03)
            parametros(3) = Obtendatos.ConstruirParametro("@PsOrden", DbType.String, vParametro04)
            parametros(4) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.String, vParametro05)
            parametros(5) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, CInt(vParametro06))
            parametros(6) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, vParametro07)

            'parametros(5).Direction = ParameterDirection.Output
            'parametros(6).Direction = ParameterDirection.Output
            'parametros(6).Size = 500
            Obtendatos.LlenarDataSet("Spc_UtilConsulta", Resultado, CommandType.StoredProcedure, parametros)


        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado

    End Function

    Public Function Fun_Edita(ByRef idCat As Object, ByRef Valores As Object, ByRef valor As Object, ByRef usr As Object, ByRef ip As Object, ByRef estatus As Object, ByRef msj As Object) As String
        Dim Resultado As String = ""
        Obtendatos = ServicioDeDatos

        ReDim parametros(6)

        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdCatalogo", DbType.Int32, CInt(idCat))
            parametros(1) = Obtendatos.ConstruirParametro("@PsValores", DbType.String, Valores)
            parametros(2) = Obtendatos.ConstruirParametro("@PnValor", DbType.Int32, CInt(valor))
            parametros(3) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, CInt(usr))
            parametros(4) = Obtendatos.ConstruirParametro("@PsIpAct", DbType.String, ip)
            parametros(5) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, CInt(estatus))
            parametros(6) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, msj)

            parametros(5).Direction = ParameterDirection.Output
            parametros(6).Direction = ParameterDirection.Output
            parametros(6).Size = 500
            Resultado = Obtendatos.EjecutarComando("Spu_UtilActual", CommandType.StoredProcedure, parametros)

            Resultado = parametros(5).Value.ToString() + "|" + parametros(6).Value.ToString()

        Catch err As Exception
            Throw New Exception(err.Message)
        End Try

        Return Resultado

    End Function

    Public Function Fun_Nuevo(ByRef idCat As Object, ByRef Valores As Object, ByRef CampoValida As Object, ByRef ValoresValida As Object, ByRef usr As Object, ByRef ip As Object, ByRef estatus As Object, ByRef msj As Object) As String
        Dim Resultado As String = ""
        Obtendatos = ServicioDeDatos
        ReDim parametros(7)

        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdCatalogo", DbType.Int32, CInt(idCat))
            parametros(1) = Obtendatos.ConstruirParametro("@PsValores", DbType.String, Valores)
            parametros(2) = Obtendatos.ConstruirParametro("@PnCampoValida", DbType.Int32, CInt(CampoValida))
            parametros(3) = Obtendatos.ConstruirParametro("@PsValorValida", DbType.String, ValoresValida)
            parametros(4) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, CInt(usr))
            parametros(5) = Obtendatos.ConstruirParametro("@PsIpAct", DbType.String, ip)
            parametros(6) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, CInt(estatus))
            parametros(7) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, msj)

            parametros(6).Direction = ParameterDirection.Output
            parametros(7).Direction = ParameterDirection.Output
            parametros(7).Size = 500
            Resultado = Obtendatos.EjecutarComando("Spa_UtilAltas", CommandType.StoredProcedure, parametros)

            Resultado = parametros(6).Value.ToString() + "|" + parametros(7).Value.ToString()

        Catch err As Exception
            Throw New Exception(err.Message)
        End Try

        Return Resultado
    End Function

    Public Function Fun_Elimina(ByRef idCat As Object, ByRef valor As Object, ByRef borradoLog As Object, ByRef usr As Object, ByRef ip As Object, ByRef estatus As Object, ByRef msj As Object) As String
        Dim Resultado As String = ""
        Obtendatos = ServicioDeDatos

        ReDim parametros(6)
        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdCatalogo", DbType.Int32, CInt(idCat))
            parametros(1) = Obtendatos.ConstruirParametro("@PnValor", DbType.String, valor)
            parametros(2) = Obtendatos.ConstruirParametro("@PbBorradoLogico", DbType.Int32, CInt(borradoLog))
            parametros(3) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, CInt(usr))
            parametros(4) = Obtendatos.ConstruirParametro("@PsIpAct", DbType.String, ip)
            parametros(5) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, CInt(estatus))
            parametros(6) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, msj)

            parametros(5).Direction = ParameterDirection.Output
            parametros(6).Direction = ParameterDirection.Output
            parametros(6).Size = 500

            Resultado = Obtendatos.EjecutarComando("Spd_UtilDelete", CommandType.StoredProcedure, parametros)

            Resultado = parametros(5).Value.ToString() + parametros(6).Value.ToString()

        Catch err As Exception
            Throw New Exception(err.Message)
        End Try

        Return Resultado
    End Function
	
	Public Function CatGrals(ByRef Tabla As Object, ByRef Columna As Object, ByRef valor As Object, ByRef Descripcion As Object, ByRef ValorAdicional As Object, ByRef usr As Object, ByRef UltActual As Object, ByRef IdOpcion As Object, ByRef ip As Object, ByRef status As Object, ByRef mj As Object) As DataSet
        Dim Resultado As New DataSet
        Obtendatos = ServicioDeDatos

        ReDim parametros(10)

        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PsTabla ", DbType.String, Tabla)
            parametros(1) = Obtendatos.ConstruirParametro("@PsColumna ", DbType.String, Columna)

            If (valor <> 0) Then
                parametros(2) = Obtendatos.ConstruirParametro("@PnValor", DbType.Int32, CInt(valor))
            Else
                parametros(2) = Obtendatos.ConstruirParametro("@PnValor", DbType.Int32, DBNull.Value)
            End If

            If (Descripcion <> "") Then
                parametros(3) = Obtendatos.ConstruirParametro("@PsDescripcion ", DbType.String, Descripcion)
            Else
                parametros(3) = Obtendatos.ConstruirParametro("@PsDescripcion ", DbType.String, DBNull.Value)
            End If
            If (ValorAdicional <> "") Then
                parametros(4) = Obtendatos.ConstruirParametro("@PsValorAdicional ", DbType.String, ValorAdicional)
            Else
                parametros(4) = Obtendatos.ConstruirParametro("@PsValorAdicional ", DbType.String, DBNull.Value)
            End If
            If (usr <> 0) Then
                parametros(5) = Obtendatos.ConstruirParametro("@PnIdUsuario ", DbType.Int32, CInt(usr))
            Else
                parametros(5) = Obtendatos.ConstruirParametro("@PnValor", DbType.Int32, DBNull.Value)
            End If

            If (UltActual <> "") Then
                parametros(6) = Obtendatos.ConstruirParametro("@PdUltActual ", DbType.String, UltActual)
            Else
                parametros(6) = Obtendatos.ConstruirParametro("@PdUltActual ", DbType.String, DBNull.Value)
            End If

            If (IdOpcion <> "") Then
                parametros(7) = Obtendatos.ConstruirParametro("@PnIdOpcion  ", DbType.String, IdOpcion)
            Else
                parametros(7) = Obtendatos.ConstruirParametro("@PnIdOpcion  ", DbType.String, DBNull.Value)
            End If

            If (ip <> "") Then
                parametros(8) = Obtendatos.ConstruirParametro("@PsIpAct  ", DbType.String, ip)
            Else
                parametros(8) = Obtendatos.ConstruirParametro("@PsIpAct  ", DbType.String, DBNull.Value)
            End If

            parametros(9) = Obtendatos.ConstruirParametro("@PnEstatus  ", DbType.Int32, CInt(status))
            parametros(10) = Obtendatos.ConstruirParametro("@PsMensaje  ", DbType.String, mj)

            parametros(9).Direction = ParameterDirection.Output
            parametros(10).Direction = ParameterDirection.Output
            parametros(10).Size = 500
            Obtendatos.LlenarDataSet("Spc_catGeneralesTbl", Resultado, System.Data.CommandType.StoredProcedure, parametros)
            ' Resultado = Obtendatos.EjecutarComando("Spc_catGeneralesTbl", CommandType.StoredProcedure, parametros)

        Catch err As Exception
            Throw New Exception(err.Message)
        End Try

        Return Resultado

    End Function
#End Region
#Region "Grids en Formularios"
    Public Function Grid_Alta(ByRef idcat As Object, ByRef Valores As Object, ByRef Llaves As Object, ByRef usr As Object, ByRef ip As Object, ByRef estatus As Object, ByRef msj As Object) As String
        Dim Resultado As String = ""
        Obtendatos = ServicioDeDatos
        ReDim parametros(6)

        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdCatalogo", DbType.Int32, CInt(idcat))
            parametros(1) = Obtendatos.ConstruirParametro("@PsValores", DbType.String, Valores)
            parametros(2) = Obtendatos.ConstruirParametro("@PsValorLlave", DbType.String, Llaves)
            parametros(3) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, CInt(usr))
            parametros(4) = Obtendatos.ConstruirParametro("@PsIpAct", DbType.String, ip)
            parametros(5) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, CInt(estatus))
            parametros(6) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, msj)

            parametros(5).Direction = ParameterDirection.Output
            parametros(6).Direction = ParameterDirection.Output
            parametros(6).Size = 500
            Resultado = Obtendatos.EjecutarComando("Spa_UtilAltas2", CommandType.StoredProcedure, parametros)

            Resultado = parametros(5).Value.ToString() + "|" + parametros(6).Value.ToString()

        Catch err As Exception
            Throw New Exception(err.Message)
        End Try

        Return Resultado

    End Function
    Public Function Grid_Edita(ByRef idcat As Object, ByRef Valores As Object, ByRef Llaves As Object, ByRef usr As Object, ByRef ip As Object, ByRef estatus As Object, ByRef msj As Object) As String
        Dim Resultado As String = ""
        Obtendatos = ServicioDeDatos
        ReDim parametros(6)

        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdCatalogo", DbType.Int32, CInt(idcat))
            parametros(1) = Obtendatos.ConstruirParametro("@PsValores", DbType.String, Valores)
            parametros(2) = Obtendatos.ConstruirParametro("@PsValorLlave", DbType.String, Llaves)
            parametros(3) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, CInt(usr))
            parametros(4) = Obtendatos.ConstruirParametro("@PsIpAct", DbType.String, ip)
            parametros(5) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, CInt(estatus))
            parametros(6) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, msj)

            parametros(5).Direction = ParameterDirection.Output
            parametros(6).Direction = ParameterDirection.Output
            parametros(6).Size = 500
            Resultado = Obtendatos.EjecutarComando("Spu_UtilActual2", CommandType.StoredProcedure, parametros)

            Resultado = parametros(5).Value.ToString() + "|" + parametros(6).Value.ToString()

        Catch err As Exception
            Throw New Exception(err.Message)
        End Try

        Return Resultado

    End Function
    Public Function Grid_Elimina(ByRef idCat As Object, ByRef Llaves As Object, ByRef borradoLog As Object, ByRef usr As Object, ByRef ip As Object, ByRef estatus As Object, ByRef msj As Object) As String
        Dim Resultado As String = ""
        Obtendatos = ServicioDeDatos

        ReDim parametros(6)
        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdCatalogo", DbType.Int32, CInt(idCat))
            parametros(1) = Obtendatos.ConstruirParametro("@PsValorLlave", DbType.String, Llaves)
            parametros(2) = Obtendatos.ConstruirParametro("@PbBorradoLogico", DbType.Int32, CInt(borradoLog))
            parametros(3) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, CInt(usr))
            parametros(4) = Obtendatos.ConstruirParametro("@PsIpAct", DbType.String, ip)
            parametros(5) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, CInt(estatus))
            parametros(6) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, msj)

            parametros(5).Direction = ParameterDirection.Output
            parametros(6).Direction = ParameterDirection.Output
            parametros(6).Size = 500

            Resultado = Obtendatos.EjecutarComando("Spd_UtilDelete2", CommandType.StoredProcedure, parametros)

            Resultado = parametros(5).Value.ToString() + parametros(6).Value.ToString()

        Catch err As Exception
            Throw New Exception(err.Message)
        End Try

        Return Resultado
    End Function
#End Region
#Region "Temas Formularios"
    Public Function Fun_Tema(ByRef usuario As Object, ByRef tema As Object, ByRef output As Object) As String
        Dim Resultado As String = ""
        Obtendatos = ServicioDeDatos
        ReDim parametros(2)

        Try
            parametros(0) = Obtendatos.ConstruirParametro("@usuario", DbType.Int32, CInt(usuario))
            parametros(1) = Obtendatos.ConstruirParametro("@tema", DbType.String, CStr(tema))
            parametros(2) = Obtendatos.ConstruirParametro("@Tipo", DbType.Int32, CInt(output))

            parametros(2).Direction = ParameterDirection.Output

            Resultado = Obtendatos.EjecutarComando("spu_ConfigTema", CommandType.StoredProcedure, parametros)

            Resultado = parametros(2).Value

        Catch err As Exception
            Throw New Exception(err.Message)
        End Try

        Return Resultado

    End Function
#End Region
#Region "Módulo Factura Seguros"
    Public Function FacturasSeg_Alta(ByVal ID As Integer, ByRef Factura As String, ByRef NoPoliza As String, ByRef Aseguradora As String, ByRef F_vencimiento As String, ByRef F_emision As String, ByRef NoEndoso As Int32, ByRef CostoDePoliza As Decimal, ByRef iva As Decimal, ByRef CostoTotal As Decimal, ByRef UUID As String, ByRef CONFIRMARPAGO As Boolean) As Integer
        Dim Resultado As Integer = 0
        Obtendatos = ServicioDeDatos
        ReDim parametros(11)
        Try
            parametros(0) = Obtendatos.ConstruirParametro("@ID", DbType.Int32, ID)
            parametros(1) = Obtendatos.ConstruirParametro("@Factura", DbType.String, Factura)
            parametros(2) = Obtendatos.ConstruirParametro("@NoPoliza", DbType.String, NoPoliza)
            parametros(3) = Obtendatos.ConstruirParametro("@Aseguradora", DbType.String, Aseguradora)
            parametros(4) = Obtendatos.ConstruirParametro("@F_vencimiento", DbType.String, F_vencimiento)
            parametros(5) = Obtendatos.ConstruirParametro("@F_emision", DbType.String, F_emision)
            parametros(6) = Obtendatos.ConstruirParametro("@NoEndoso", DbType.Int32, NoEndoso)
            parametros(7) = Obtendatos.ConstruirParametro("@CostoDePoliza", DbType.Decimal, CostoDePoliza)
            parametros(8) = Obtendatos.ConstruirParametro("@iva", DbType.Decimal, iva)
            parametros(9) = Obtendatos.ConstruirParametro("@CostoTotal", DbType.Decimal, CostoTotal)
            parametros(10) = Obtendatos.ConstruirParametro("@UUID", DbType.String, UUID)
            parametros(11) = Obtendatos.ConstruirParametro("@CONFIRMARPAGO", DbType.Boolean, CONFIRMARPAGO)

            Resultado = Obtendatos.EjecutarComando("FacturasSeguros_Nuevo", CommandType.StoredProcedure, parametros)
            parametros(0).Direction = ParameterDirection.Output
            Resultado = parametros(0).Value.ToString()
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try

        Return Resultado

    End Function
    Public Function FacturasSeg_EliminaTmp() As Integer
        Dim Resultado As Integer = 0
        Obtendatos = ServicioDeDatos
        Try
            Resultado = Obtendatos.EjecutarComando("DELETE FROM tbl_FacturasSeguros DBCC CHECKIDENT (tbl_FacturasSeguros, RESEED, 0)", CommandType.Text)
            'Obtendatos.EjecutarComando("DBCC CHECKIDENT (tbl_FacturasSeguros, RESEED, 0)", CommandType.Text)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try

        Return Resultado

    End Function
    Public Function FacturasSeg_SelectG() As DataSet
        'Esta funcion no lleva parametros es directa.Si se ocupara con parametros tomar en cuenta "selecTabla"
        Obtendatos = ServicioDeDatos
        'ReDim parametros(6)
        Dim Resultado As New DataSet

        Try
            Obtendatos.LlenarDataSet("FacturasSeguros_Select", Resultado, CommandType.StoredProcedure)

        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado

    End Function

    Public Function FacturasSeg_SelectGNoM() As DataSet
        'Esta funcion no lleva parametros es directa.Si se ocupara con parametros tomar en cuenta "selecTabla"
        Obtendatos = ServicioDeDatos
        'ReDim parametros(6)
        Dim Resultado As New DataSet

        Try
            Obtendatos.LlenarDataSet("FacturasSeguros_SelectNoMatch", Resultado, CommandType.StoredProcedure)

        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado

    End Function
    Public Function FacturasSeg_SelectFacNoAuto() As DataSet
        'Esta funcion no lleva parametros es directa.Si se ocupara con parametros tomar en cuenta "selecTabla"
        Obtendatos = ServicioDeDatos
        'ReDim parametros(6)
        Dim Resultado As New DataSet

        Try
            Obtendatos.LlenarDataSet("FacturasSeguros_SelectNoAutorizada", Resultado, CommandType.StoredProcedure)

        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado

    End Function
    Public Function FacturasSeg_Editar(ByRef id As Int32, ByRef Poliza As String, ByRef CostoTotal As Decimal, ByVal PolizaTemp As String, ByVal confirmarPago As Boolean) As Integer
        Dim Resultado As Integer = 0
        Obtendatos = ServicioDeDatos
        ReDim parametros(4)

        Try
            parametros(0) = Obtendatos.ConstruirParametro("@ID", DbType.Int32, id)
            parametros(1) = Obtendatos.ConstruirParametro("@NoPoliza", DbType.String, Poliza)
            parametros(2) = Obtendatos.ConstruirParametro("@CostoTotal", DbType.Decimal, CostoTotal)
            parametros(3) = Obtendatos.ConstruirParametro("@NoPolizaTemp", DbType.String, PolizaTemp)
            parametros(4) = Obtendatos.ConstruirParametro("@ConfirmaPago", DbType.Boolean, confirmarPago)

            Resultado = Obtendatos.EjecutarComando("FacturasSeguros_Editar", CommandType.StoredProcedure, parametros)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try

        Return Resultado

    End Function
#End Region
#Region "MonitorGeneralDeSeguros"
    Public Function MonitorGeneral_Select() As DataSet
        'Esta funcion no lleva parametros es directa.Si se ocupara con parametros tomar en cuenta "selecTabla"
        Obtendatos = ServicioDeDatos
        'ReDim parametros(6)
        Dim Resultado As New DataSet

        Try
            Obtendatos.LlenarDataSet("EndosoGarantia_SelectMonitor", Resultado, CommandType.StoredProcedure)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado
    End Function

#End Region
#Region "Cobranza"
Public Function DatosFuncionalidaCobranza(ByVal Funcionalidad As String, ByVal ParametrosFuncionalidad As String) As DataSet
        Dim Resultado As New DataSet
        Obtendatos = ServicioDeDatos

        If Funcionalidad = "MonitorCobranzaRenta" Then
            ReDim parametros(3)
            Dim vParametros As String()
            vParametros = ParametrosFuncionalidad.Split("|")

            Try
                parametros(0) = Obtendatos.ConstruirParametro("@Funcionalidad", DbType.String, vParametros(0))
                parametros(1) = Obtendatos.ConstruirParametro("@RFC", DbType.String, vParametros(1))
                parametros(2) = Obtendatos.ConstruirParametro("@Contrato", DbType.String, vParametros(2))
                parametros(3) = Obtendatos.ConstruirParametro("@Anexo", DbType.String, vParametros(3))

                Obtendatos.LlenarDataSet("OMR_SAC_Spc_ObtenDatosCobranza", Resultado, CommandType.StoredProcedure, parametros)
            Catch err As Exception
                Throw New Exception(err.Message)
            End Try

        ElseIf Funcionalidad = "MonitorCobranzaCredito" Then
            ReDim parametros(3)
            Dim vParametros As String()
            vParametros = ParametrosFuncionalidad.Split("|")

            Try
                parametros(0) = Obtendatos.ConstruirParametro("@Funcionalidad", DbType.String, vParametros(0))
                parametros(1) = Obtendatos.ConstruirParametro("@RFC", DbType.String, vParametros(1))
                parametros(2) = Obtendatos.ConstruirParametro("@Contrato", DbType.String, vParametros(2))
                parametros(3) = Obtendatos.ConstruirParametro("@Anexo", DbType.String, vParametros(3))

                Obtendatos.LlenarDataSet("OMR_SAC_Spc_ObtenDatosCobranza", Resultado, CommandType.StoredProcedure, parametros)
            Catch err As Exception
                Throw New Exception(err.Message)
            End Try

        Else


        End If

        Return Resultado

    End Function
#End Region

#Region "Parametrización de Elegibilidad de Línea de fondeo"
    'DDV Catálogo de empresas para elegibilidad de fondeo
    Public Function selectEmpresasLF() As DataSet
        Obtendatos = ServicioDeDatos
        ReDim parametros(2)
        Dim Resultado As New DataSet
        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
            parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
            parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)

            Obtendatos.LlenarDataSet("SAC_Spc_EmpresasLF", Resultado, CommandType.StoredProcedure, parametros)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado
    End Function

    Public Function selectMarcas() As DataSet
        Obtendatos = ServicioDeDatos
        Dim Resultado As New DataSet
        Try
            Obtendatos.LlenarDataSet("SAC_Spc_catMarca", Resultado, CommandType.StoredProcedure)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado
    End Function


    Public Function selectMarcasLF(ByRef ID As Int32) As DataSet
        Obtendatos = ServicioDeDatos
        Dim Resultado As New DataSet
        ReDim parametros(0)

        parametros(0) = Obtendatos.ConstruirParametro("@PnIdParamElegibilidad", DbType.Int32, ID)

        Try
            Obtendatos.LlenarDataSet("SAC_Spc_MarcasParamLF", Resultado, CommandType.StoredProcedure, parametros)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado
    End Function

    Public Function selectAseguradorasLF(ByRef ID As Int32) As DataSet
        Obtendatos = ServicioDeDatos
        Dim Resultado As New DataSet
        ReDim parametros(0)

        parametros(0) = Obtendatos.ConstruirParametro("@PnIdParamElegibilidad", DbType.Int32, ID)

        Try
            Obtendatos.LlenarDataSet("SAC_Spc_AseguradorasParamLF", Resultado, CommandType.StoredProcedure, parametros)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado
    End Function

    Public Function selectAseguradoras() As DataSet
        Obtendatos = ServicioDeDatos
        Dim Resultado As New DataSet
        Try
            Obtendatos.LlenarDataSet("SAC_Spc_catAseguradoras", Resultado, CommandType.StoredProcedure)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado
    End Function

    Public Function selectValoresLF() As DataSet
        Obtendatos = ServicioDeDatos
        Dim Resultado As New DataSet
        Try
            Obtendatos.LlenarDataSet("SAC_Spc_catValoresLF", Resultado, CommandType.StoredProcedure)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado
    End Function

    Public Function selectTipoOperLF() As DataSet
        Obtendatos = ServicioDeDatos
        Dim Resultado As New DataSet
        Try
            Obtendatos.LlenarDataSet("SAC_Spc_catTipoOperacionEF", Resultado, CommandType.StoredProcedure)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado
    End Function
    ' DDV carga de catalogo de fondeadoras 
    Public Function selectFondeadoras() As DataSet
        Obtendatos = ServicioDeDatos
        ReDim parametros(2)
        Dim Resultado As New DataSet
        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
            parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
            parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)


            Obtendatos.LlenarDataSet("Spc_SAC_catFondeadoras", Resultado, CommandType.StoredProcedure, parametros)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado
    End Function

 ' DDV Funcion para insertar parametros de Elegibilidad
    Public Function InsertaParametros(ByRef Nombre As String, ByRef MontoAut As Decimal,
                                      ByRef FecVen As DateTime, ByRef AforoCtontractual As Decimal, ByRef Tasa As Decimal,
                                      ByRef PlazoD As Int32, ByRef MesRes As Int32, ByRef IdAforo As String, ByRef NotaCredito As Boolean,
                                      ByRef Garantia As Boolean, ByRef Factor As Decimal, ByRef AntigFac As Int32, ByRef FacRen As Int32,
                                      ByRef IdTipoOper As String, ByRef ValMax As Decimal, ByRef ValMin As Decimal, ByRef RenGarantia As Int32,
                                      ByRef FecRen As DateTime, ByRef RenFlujo As Boolean, ByRef IdPaga As Int32,
                                      ByRef porcentajeresid As Decimal, ByRef ListBrand() As String, ByRef ListSecur() As String) As Int32
        Dim Resultado As Int32 = 0
        Obtendatos = ServicioDeDatos
        ReDim parametros(24)

        Dim vID As Int32 = 0

        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
            parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
            parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)

            parametros(3) = Obtendatos.ConstruirParametro("@PnIdEmpFondeo", DbType.String, Nombre)
            parametros(4) = Obtendatos.ConstruirParametro("@PdMontoAut", DbType.Decimal, Decimal.Round(MontoAut, 2))
            parametros(5) = Obtendatos.ConstruirParametro("@PsFecVen", DbType.Date, CDate(FecVen))
            parametros(6) = Obtendatos.ConstruirParametro("@PdAforoCtontractual", DbType.Decimal, Decimal.Round(AforoCtontractual, 2))
            parametros(7) = Obtendatos.ConstruirParametro("@PdTasa", DbType.Decimal, Decimal.Round(Tasa, 2))
            parametros(8) = Obtendatos.ConstruirParametro("@PnPlazoD", DbType.Int32, PlazoD)
            parametros(9) = Obtendatos.ConstruirParametro("@PnMesRes", DbType.Int32, MesRes)
            parametros(10) = Obtendatos.ConstruirParametro("@PnIdAforo", DbType.String, IdAforo)
            parametros(11) = Obtendatos.ConstruirParametro("@PbNotaCredito", DbType.Boolean, NotaCredito)
            parametros(12) = Obtendatos.ConstruirParametro("@PnGarantia", DbType.Boolean, Garantia)
            parametros(13) = Obtendatos.ConstruirParametro("@PdFactor", DbType.Decimal, Decimal.Round(Factor, 4))
            parametros(14) = Obtendatos.ConstruirParametro("@PnAntigFac", DbType.Int32, AntigFac)
            parametros(15) = Obtendatos.ConstruirParametro("@PnFacRen", DbType.Int32, FacRen)
            parametros(16) = Obtendatos.ConstruirParametro("@PnIdTipoOper", DbType.String, IdTipoOper)
            parametros(17) = Obtendatos.ConstruirParametro("@PdValMax", DbType.Decimal, Decimal.Round(ValMax, 2))
            parametros(18) = Obtendatos.ConstruirParametro("@PdValMin", DbType.Decimal, Decimal.Round(ValMin, 2))
            parametros(19) = Obtendatos.ConstruirParametro("@PnRenGarantia", DbType.Int32, RenGarantia)
            parametros(20) = Obtendatos.ConstruirParametro("@PsFecRen", DbType.Date, FecRen)
            parametros(21) = Obtendatos.ConstruirParametro("@PnRenFlujo", DbType.Boolean, IIf(String.IsNullOrEmpty(RenFlujo), 0, RenFlujo))
            parametros(22) = Obtendatos.ConstruirParametro("@PnIdPaga", DbType.Int32, IdPaga)
            parametros(23) = Obtendatos.ConstruirParametro("@Pdporcentajeresid", DbType.Decimal, Decimal.Round(porcentajeresid, 2))
            parametros(24) = Obtendatos.ConstruirParametro("@PIdPE", DbType.Int32, 0, 0, ParameterDirection.Output)

            Resultado = Obtendatos.EjecutarComando("SAC_Spa_ParamElegibilidad", CommandType.StoredProcedure, parametros)
            Dim IDParamEleg As Integer = 0

            If Not IsDBNull(parametros(24).Value) Then
                IDParamEleg = parametros(24).Value
            End If


            If IDParamEleg > 0 Then

                For a As Integer = 0 To ListBrand.Count - 1
                    Dim InsBrand As Integer = 0
                    ReDim parametros(4)
                    Try
                        parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
                        parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
                        parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)
                        parametros(3) = Obtendatos.ConstruirParametro("@PnIdParam", DbType.Int32, IDParamEleg)
                        parametros(4) = Obtendatos.ConstruirParametro("@PnIdBrand", DbType.String, ListBrand(a))

                        InsBrand = Obtendatos.EjecutarComando("SAC_Spa_MarcasParamLF", CommandType.StoredProcedure, parametros)
                    Catch err As Exception
                        Throw New Exception(err.Message)
                    End Try
                Next


                For b As Integer = 0 To ListSecur.Count - 1
                    Dim InsSecure As Integer = 0
                    ReDim parametros(4)
                    Try
                        parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
                        parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
                        parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)
                        parametros(3) = Obtendatos.ConstruirParametro("@PnIdParam", DbType.Int32, IDParamEleg)
                        parametros(4) = Obtendatos.ConstruirParametro("@PnIdSecure", DbType.String, ListSecur(b))

                        InsSecure = Obtendatos.EjecutarComando("SAC_Spa_AseguraParamLF", CommandType.StoredProcedure, parametros)
                    Catch err As Exception
                        Throw New Exception(err.Message)
                    End Try

                Next
            End If
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try

        Return Resultado

    End Function

   Public Function UpdateParametros(ByRef ID As String, ByRef Nombre As String, ByRef MontoAut As String, ByRef FecVen As String, ByRef AforoCtontractual As String, ByRef Tasa As String, ByRef PlazoD As String, ByRef MesRes As String, ByRef IdAforo As String, ByRef NotaCredito As String, ByRef Garantia As String, ByRef Factor As String, ByRef AntigFac As String, ByRef FacRen As String, ByRef IdTipoOper As String, ByRef ValMax As String, ByRef ValMin As String, ByRef RenGarantia As String, ByRef FecRen As String, ByRef RenFlujo As String, ByRef IdPaga As String, ByRef porcentajeresid As String, ByRef Markas() As String, ByRef Seguras() As String) As String
        Dim Resultado As String = String.Empty
        Obtendatos = ServicioDeDatos
        ReDim parametros(24)

        Try

            parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
            parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
            parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)

            parametros(3) = Obtendatos.ConstruirParametro("@IdFondo", DbType.Int32, CInt(ID))
            parametros(4) = Obtendatos.ConstruirParametro("@PnIdEmpFondeo", DbType.String, Nombre)
            parametros(5) = Obtendatos.ConstruirParametro("@PdMontoAut", DbType.Decimal, Decimal.Round(Convert.ToDecimal(MontoAut, CultureInfo.InvariantCulture), 2))
            parametros(6) = Obtendatos.ConstruirParametro("@PsFecVen", DbType.Date, CDate(FecVen))
            parametros(7) = Obtendatos.ConstruirParametro("@PdAforoCtontractual", DbType.Decimal, Decimal.Round(Convert.ToDecimal(AforoCtontractual, CultureInfo.InvariantCulture), 2))
            parametros(8) = Obtendatos.ConstruirParametro("@PdTasa", DbType.Decimal, Decimal.Round(Convert.ToDecimal(Tasa, CultureInfo.InvariantCulture), 2))
            parametros(9) = Obtendatos.ConstruirParametro("@PnPlazoD", DbType.Int32, CInt(PlazoD))
            parametros(10) = Obtendatos.ConstruirParametro("@PnMesRes", DbType.Int32, CInt(MesRes))
            parametros(11) = Obtendatos.ConstruirParametro("@PnIdAforo", DbType.String, IdAforo)
            parametros(12) = Obtendatos.ConstruirParametro("@PbNotaCredito", DbType.Boolean, CBool(NotaCredito))
            parametros(13) = Obtendatos.ConstruirParametro("@PnGarantia", DbType.Boolean, CBool(Garantia))
            parametros(14) = Obtendatos.ConstruirParametro("@PdFactor", DbType.Decimal, Decimal.Round(Convert.ToDecimal(Factor, CultureInfo.InvariantCulture), 4))
            parametros(15) = Obtendatos.ConstruirParametro("@PnAntigFac", DbType.Int32, CInt(AntigFac))
            parametros(16) = Obtendatos.ConstruirParametro("@PnFacRen", DbType.Int32, CInt(FacRen))
            parametros(17) = Obtendatos.ConstruirParametro("@PnIdTipoOper", DbType.String, IdTipoOper)
            parametros(18) = Obtendatos.ConstruirParametro("@PdValMax", DbType.Decimal, Decimal.Round(Convert.ToDecimal(ValMax, CultureInfo.InvariantCulture), 2))
            parametros(19) = Obtendatos.ConstruirParametro("@PdValMin", DbType.Decimal, Decimal.Round(Convert.ToDecimal(ValMin, CultureInfo.InvariantCulture), 2))
            parametros(20) = Obtendatos.ConstruirParametro("@PnRenGarantia", DbType.Int32, CInt(RenGarantia))
            parametros(21) = Obtendatos.ConstruirParametro("@PsFecRen", DbType.Date, CDate(FecRen))
            parametros(22) = Obtendatos.ConstruirParametro("@PnRenFlujo", DbType.Boolean, IIf(String.IsNullOrEmpty(RenFlujo), 0, CBool(RenFlujo)))
            parametros(23) = Obtendatos.ConstruirParametro("@PnIdPaga", DbType.Int32, CInt(IdPaga))
            parametros(24) = Obtendatos.ConstruirParametro("@Pdporcentajeresid", DbType.Decimal, Decimal.Round(Convert.ToDecimal(porcentajeresid, CultureInfo.InvariantCulture), 2))


            Resultado = Obtendatos.EjecutarComando("SAC_Spu_ParamElegibilidad", CommandType.StoredProcedure, parametros)

            If Markas.Count > 0 Then


                Dim DelBrand As Integer = 0
                ReDim parametros(3)
                Try
                    parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
                    parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
                    parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)
                    parametros(3) = Obtendatos.ConstruirParametro("@PnIdParam", DbType.Int32, CInt(ID))


                    DelBrand = Obtendatos.EjecutarComando("SAC_Spd_MarcasParamLF", CommandType.StoredProcedure, parametros)
                Catch err As Exception
                    Throw New Exception(err.Message)
                End Try


                For a As Integer = 0 To Markas.Count - 1
                    Dim InsBrand As Integer = 0
                    ReDim parametros(4)
                    Try
                        parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
                        parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
                        parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)
                        parametros(3) = Obtendatos.ConstruirParametro("@PnIdParam", DbType.Int32, CInt(ID))
                        parametros(4) = Obtendatos.ConstruirParametro("@PnIdBrand", DbType.String, Markas(a))

                        InsBrand = Obtendatos.EjecutarComando("SAC_Spa_MarcasParamLF", CommandType.StoredProcedure, parametros)
                    Catch err As Exception
                        Throw New Exception(err.Message)
                    End Try
                Next

            End If

            If Seguras.Count > 0 Then


                Dim DelSecure As Integer = 0
                ReDim parametros(3)
                Try
                    parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
                    parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
                    parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)
                    parametros(3) = Obtendatos.ConstruirParametro("@PnIdParam", DbType.Int32, CInt(ID))


                    DelSecure = Obtendatos.EjecutarComando("SAC_Spd_AseguraParamLF", CommandType.StoredProcedure, parametros)
                Catch err As Exception
                    Throw New Exception(err.Message)
                End Try


                For b As Integer = 0 To Seguras.Count - 1
                    Dim InsSecure As Integer = 0
                    ReDim parametros(4)
                    Try
                        parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
                        parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
                        parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)
                        parametros(3) = Obtendatos.ConstruirParametro("@PnIdParam", DbType.Int32, CInt(ID))
                        parametros(4) = Obtendatos.ConstruirParametro("@PnIdSecure", DbType.String, Seguras(b))

                        InsSecure = Obtendatos.EjecutarComando("SAC_Spa_AseguraParamLF", CommandType.StoredProcedure, parametros)
                    Catch err As Exception
                        Throw New Exception(err.Message)
                    End Try

                Next
            End If

        Catch err As Exception
            Throw New Exception(err.Message)
        End Try

        Return Resultado

    End Function


    Public Function selectLineasFondeadoras() As DataSet
        Obtendatos = ServicioDeDatos
        ReDim parametros(2)
        Dim Resultado As New DataSet
        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
            parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
            parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)

            Obtendatos.LlenarDataSet("SAC_Spc_LineasFondeadoras", Resultado, CommandType.StoredProcedure, parametros)

        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado
    End Function
    Public Function getAllRemesas() As DataSet
        Obtendatos = ServicioDeDatos
        ReDim parametros(2)
        Dim Resultado As New DataSet
        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
            parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
            parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)

            Obtendatos.LlenarDataSet("Spc_SAC_Remesas", Resultado, CommandType.StoredProcedure, parametros)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado
    End Function

    Public Function selectDetalleFondeo(ByRef ID) As DataSet
        Obtendatos = ServicioDeDatos
        Dim Resultado As New DataSet
        ReDim parametros(3)
        ' Dim valornull As String = ID

        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
            parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
            parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)

            parametros(3) = Obtendatos.ConstruirParametro("@PnIdParamElegibilidad", DbType.Int32, CInt(ID))
            Obtendatos.LlenarDataSet("SAC_Spc_DetalleFondeadoras", Resultado, CommandType.StoredProcedure, parametros)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado
    End Function

    Public Function selectCreditos(ParamLF As Integer) As DataSet
        Obtendatos = ServicioDeDatos
        Dim Resultado As New DataSet
        ReDim parametros(3)
        ' Dim valornull As String = ID

        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
            parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
            parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)
            parametros(3) = Obtendatos.ConstruirParametro("@ParamElig", DbType.Int32, ParamLF)

            'parametros(3) = Obtendatos.ConstruirParametro("@PnIdParamElegibilidad", DbType.Int32, CInt(ID))
            Obtendatos.LlenarDataSet("SIIFI_Spc_CreditosFondeadoras", Resultado, CommandType.StoredProcedure, parametros)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado
    End Function

    Public Function selectCreditosGarantia(ParamLF As Integer) As DataSet
        Obtendatos = ServicioDeDatos
        Dim Resultado As New DataSet
        ReDim parametros(3)


        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
            parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
            parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)
            parametros(3) = Obtendatos.ConstruirParametro("@IdParamE", DbType.Int32, ParamLF)


            Obtendatos.LlenarDataSet("Spc_SAC_ContratosByParam", Resultado, CommandType.StoredProcedure, parametros)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado
    End Function

    Public Function selectCredReemplazo(ParamLF As Integer) As DataSet
        Obtendatos = ServicioDeDatos
        Dim Resultado As New DataSet
        ReDim parametros(3)
        ' Dim valornull As String = ID

        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
            parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
            parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)
            parametros(3) = Obtendatos.ConstruirParametro("@ParamElig", DbType.Int32, ParamLF)

            'parametros(3) = Obtendatos.ConstruirParametro("@PnIdParamElegibilidad", DbType.Int32, CInt(ID))
            Obtendatos.LlenarDataSet("SIIFI_Spc_CreditosFondeadorasReemplazo", Resultado, CommandType.StoredProcedure, parametros)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado
    End Function


    Public Function CreaRemesa(ParamLF As Integer, ContratosCant As Integer, contratos() As String) As Integer
        Obtendatos = ServicioDeDatos
        Dim Resultado As New DataSet
        Dim NoRemesa As New Integer
        ReDim parametros(5)


        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
            parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
            parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)
            parametros(3) = Obtendatos.ConstruirParametro("@ParamElig", DbType.Int32, ParamLF)
            parametros(4) = Obtendatos.ConstruirParametro("@ContractCant", DbType.Int32, ContratosCant)
            parametros(5) = Obtendatos.ConstruirParametro("@PnIdRemesa", DbType.Int32, 0, 0, ParameterDirection.Output)


            Obtendatos.LlenarDataSet("Spa_SAC_Remesas", Resultado, CommandType.StoredProcedure, parametros)

            NoRemesa = parametros(4).Value

            For a As Integer = 0 To contratos.Count - 1
                Dim InsContrato As Integer = 0
                ReDim parametros(5)
                Try
                    parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
                    parametros(1) = Obtendatos.ConstruirParametro("@PsIpAct", DbType.String, "127.0.0.0")
                    parametros(2) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
                    parametros(3) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)
                    parametros(4) = Obtendatos.ConstruirParametro("@PnIdRemesa", DbType.Int32, NoRemesa)
                    parametros(5) = Obtendatos.ConstruirParametro("@PnCred_id", DbType.String, contratos(a))

                    InsContrato = Obtendatos.EjecutarComando("Spa_SAC_RemesasDetalleTbl", CommandType.StoredProcedure, parametros)
                Catch err As Exception
                    Throw New Exception(err.Message)
                End Try
            Next


        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return NoRemesa
    End Function

    Public Function GetRemesaDetail(IdRemesa As Integer) As DataSet
        Obtendatos = ServicioDeDatos
        Dim Resultado As New DataSet
        ReDim parametros(3)

        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
            parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
            parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)
            parametros(3) = Obtendatos.ConstruirParametro("@IdRemesa", DbType.Int32, IdRemesa)



            Obtendatos.LlenarDataSet("Spc_SAC_RemesasDetail", Resultado, CommandType.StoredProcedure, parametros)

        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado

    End Function

    Public Function GetDetalleAnexos(MesVence As Integer) As DataSet
        Obtendatos = ServicioDeDatos
        Dim Resultado As New DataSet
        ReDim parametros(3)

        Try
            parametros(0) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, 42)
            parametros(1) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, 0, 0, ParameterDirection.Output)
            parametros(2) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, String.Empty, 250, ParameterDirection.Output)
            parametros(3) = Obtendatos.ConstruirParametro("@MesVence", DbType.Int32, MesVence)



            Obtendatos.LlenarDataSet("Spc_SAC_AnexosDetalle", Resultado, CommandType.StoredProcedure, parametros)

        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado

    End Function
#End Region
#Region "MÓDULO DE PEDIDOS (VENTAS)"
    'Pedidos FM.
    Public Function Guarda_Pedido(ByRef ValoresPedido As Object, ByRef ValoresMovPed As Object, ByRef usr As Object, ByRef ip As Object, ByRef estatus As Object, ByRef msj As Object) As String
        Dim Resultado As String = ""
        Obtendatos = ServicioDeDatos
        ReDim parametros(5)

        Try
            parametros(0) = Obtendatos.ConstruirParametro("@ValoresPedido", DbType.String, ValoresPedido)
            parametros(1) = Obtendatos.ConstruirParametro("@ValoresMovPed", DbType.String, ValoresMovPed)
            parametros(2) = Obtendatos.ConstruirParametro("@PnIdUsuarioAct", DbType.Int32, CInt(usr))
            parametros(3) = Obtendatos.ConstruirParametro("@PsIpAct", DbType.String, ip)
            parametros(4) = Obtendatos.ConstruirParametro("@PnEstatus", DbType.Int32, CInt(estatus))
            parametros(5) = Obtendatos.ConstruirParametro("@PsMensaje", DbType.String, msj)

            parametros(4).Direction = ParameterDirection.Output
            parametros(5).Direction = ParameterDirection.Output
            parametros(5).Size = 500
            Resultado = Obtendatos.EjecutarComando("Spa_AltaPedido", CommandType.StoredProcedure, parametros)

            Resultado = parametros(4).Value.ToString() + "|" + parametros(5).Value.ToString()

        Catch err As Exception
            Throw New Exception(err.Message)
        End Try

        Return Resultado

    End Function

#End Region
End Class



