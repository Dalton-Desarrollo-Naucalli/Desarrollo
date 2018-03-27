Imports System
Imports System.Web
Imports System.Collections
Imports Framework.Datos
Imports System.Data
Imports System.Configuration
Imports System.Data.SqlClient

Public Class Seguridad

#Region "Variables y propiedades"
    Private Obtendatos As IClienteServicioDatos
    Private parametros() As IDbDataParameter
    Private gUsuario As String = ""
    Private gCompania As String = ""
    Private Utilerias As New UtileriasNegocio.Utilerias

    Public Property usuarioServicio() As String
        Get
            usuarioServicio = gUsuario
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


    ''' <summary>
    ''' El presente metodo valida un usuario
    ''' </summary>
    ''' <param name="sCliente">El servicio o cliente hacia el cual se desea entrar</param>
    ''' <param name="sUsuario">El usuario</param>
    ''' <param name="sClave">La clave encriptada del usuario mediante el algoritmo SHA1</param>
    ''' <returns></returns>

    Public Function ValidaUsuario(ByVal sCliente As String, ByVal sUsuario As String, ByVal sClave As String, ByVal sSistema As Integer) As DataSet
        Obtendatos = ServicioDeDatos
        ReDim parametros(3)
        Dim Resultado As New DataSet

        Try
            parametros(0) = Obtendatos.ConstruirParametro("@cliente", DbType.String, sCliente)
            parametros(1) = Obtendatos.ConstruirParametro("@usuario", DbType.String, sUsuario)
            parametros(2) = Obtendatos.ConstruirParametro("@clave", DbType.String, sClave)
            parametros(3) = Obtendatos.ConstruirParametro("@id_sistema", DbType.Int16, sSistema)

            Obtendatos.LlenarDataSet("MS_ValidacionUsuario", Resultado, CommandType.StoredProcedure, parametros)
        Catch err As Exception
            Throw New Exception(err.Message)
        End Try
        Return Resultado

    End Function


    Public Function ObtenDatosCatalogo(ByVal Funcionalidad As String, ByVal Parametros As Object) As DataSet
        Obtendatos = ServicioDeDatos
        Dim sql As String = ""

        '===================================================================================================================================================================================
        '======= FUNCIONALIDAD NUEVA (INICIO)===============================================================================================================================================
        '===================================================================================================================================================================================
        If Funcionalidad = "MS_CatSistemas" Then
            sql += " Select ms_sis.ID_Sistema as ID,"
            sql += "        ms_sis.Orden,"
            sql += "        upper(ms_sis.Nombre) as Nombre,"
            sql += "        upper(ms_sis.Descripcion) as Descripcion,"
            sql += "        ms_sis.Estatus,"
            sql += "        upper(ms_status.Nombre) as NombreEstatus,"
            sql += "        isnull(ms_sis.BorradoLogico,0) as BorradoLogico"
            sql += "   From MS_Sistemas ms_sis inner join MS_Status ms_status"
            sql += "     on ms_sis.Estatus = ms_status.ID_Status"
            sql += "  Where isnull(ms_sis.BorradoLogico,0) = 0"
            sql += "  order by ms_sis.Orden"

        ElseIf Funcionalidad = "MS_CatEntornosDB" Then
            sql += " Select ms_edb.ID_EntornoDB as ID,"
            sql += "        ms_edb.Orden,"
            sql += "        upper(ms_edb.Nombre) as Nombre,"
            sql += "        upper(ms_edb.Descripcion) as Descripcion,"
            sql += "        ms_edb.Estatus,"
            sql += "        upper(ms_status.Nombre) as NombreEstatus,"
            sql += "        isnull(ms_edb.BorradoLogico,0) as BorradoLogico"
            sql += "   From MS_EntornosDB ms_edb inner join MS_Status ms_status"
            sql += "     on ms_edb.Estatus = ms_status.ID_Status"
            sql += "  Where isnull(ms_edb.BorradoLogico,0) = 0"
            sql += "  order by ms_edb.Orden"

        ElseIf Funcionalidad = "MS_CatModulos" Then
            sql += " Select ms_men.ID_Modulo as ID, "
            sql += " ms_men.Orden, "
            sql += " upper(ms_men.Nombre) as Nombre, "
            sql += " upper(ms_men.Descripcion) as Descripcion, "
            sql += " ms_men.Estatus, "
            sql += " upper(ms_status.Nombre) as NombreEstatus, "
            sql += " isnull(ms_men.BorradoLogico,0) as BorradoLogico "
            sql += " From MS_Modulos ms_men inner join MS_Status ms_status "
            sql += " on ms_men.Estatus = ms_status.ID_Status "
            sql += " Where isnull(ms_men.BorradoLogico,0) = 0 "
            sql += " order by ms_men.Orden "

        ElseIf Funcionalidad = "MS_CatMenus" Then
            sql += " Select ms_men.ID_Menu as ID,"
            sql += "        ms_men.Orden,"
            sql += "        upper(ms_men.Nombre) as Nombre,"
            sql += "        upper(ms_men.Descripcion) as Descripcion,"
            sql += "        upper(ms_men.Icono_Activo) as Icono_Activo,"
            sql += "        upper(ms_men.Icono_Inactivo) as Icono_Inactivo,"
            sql += "        upper(ms_men.Text) as Text,"
            sql += "        upper(ms_men.Value) as Value,"
            sql += "        upper(ms_men.ToolTip) as ToolTip,"
            sql += "        ms_men.Ruta,"
            sql += "        ms_men.Estatus,"
            sql += "        upper(ms_status.Nombre) as NombreEstatus,"
            sql += "        isnull(ms_men.BorradoLogico,0) as BorradoLogico"
            sql += "   From MS_Menus ms_men inner join MS_Status ms_status"
            sql += "     on ms_men.Estatus = ms_status.ID_Status"
            sql += "  Where isnull(ms_men.BorradoLogico,0) = 0"
            sql += "  order by ms_men.Orden"

        ElseIf Funcionalidad = "MS_CatSubmenus" Then
            sql += " Select ms_submen.ID_Submenu as ID,"
            sql += "         ms_submen.Orden,"
            sql += "         upper(ms_submen.Nombre) as Nombre,"
            sql += "         upper(ms_submen.Descripcion) as Descripcion,"
            sql += "         upper(ms_submen.Icono_Activo) as Icono_Activo,"
            sql += "         upper(ms_submen.Icono_Inactivo) as Icono_Inactivo,"
            sql += "         upper(ms_submen.Text) as Text,"
            sql += "         upper(ms_submen.Value) as Value,"
            sql += "         upper(ms_submen.ToolTip) as ToolTip,"
            sql += "         ms_submen.Ruta,"
            sql += "         ms_submen.Estatus,"
            sql += "         upper(ms_status.Nombre) as NombreEstatus,"
            sql += "         isnull(ms_submen.BorradoLogico,0) as BorradoLogico"
            sql += "    From MS_Submenus ms_submen inner join MS_Status ms_status"
            sql += "      on ms_submen.Estatus = ms_status.ID_Status"
            sql += "   Where isnull(ms_submen.BorradoLogico,0) = 0"
            sql += "   order by ms_submen.Orden"

        ElseIf Funcionalidad = "ObtenCatalogoMenus" Then
            sql += " Select ID_Menu as Llave,"
            sql += "        upper(Descripcion) as Descripcion"
            sql += "   from MS_Menus"
            sql += "  Where Status = 1"
            sql += "    and isnull(BorradoLogico,0) = 0"
            sql += "  order by orden"

        ElseIf Funcionalidad = "ObtenCatalogoModulos" Then
            sql += " Select ID_Modulo as Llave,"
            sql += "        upper(Descripcion) as Descripcion"
            sql += "   from MS_Modulos"
            sql += "  Where Status = 1"
            sql += "    and isnull(BorradoLogico,0) = 0"
            sql += "  order by orden"

        ElseIf Funcionalidad = "ObtenMenusSinAsignarSistemas" Then
            sql += " select ID_Menu as Llave, "
            sql += "        ltrim(rtrim(upper(Descripcion))) as Nombre, "
            sql += "        0 As Seleccionar "
            sql += "   from MS_Menus"
            sql += "  where ID_Menu not in (Select ID_Menu from MS_RelSistemaMenu Where ID_Sistema = " & Parametros & ")"
            sql += "  order by 1"

        ElseIf Funcionalidad = "ObtenMenusAsignadosSistemas" Then
            sql += " select ID_Menu as Llave, "
            sql += "        ltrim(rtrim(upper(Descripcion))) as Nombre, "
            sql += "        0 As Seleccionar "
            sql += "   from MS_Menus"
            sql += "  where ID_Menu in (Select ID_Menu from MS_RelSistemaMenu Where ID_Sistema = " & Parametros & ")"
            sql += "  order by 1"

        ElseIf Funcionalidad = "ObtenMenusSinAsignarModulos" Then
            sql += " select ID_Menu as Llave, "
            sql += "        ltrim(rtrim(upper(Descripcion))) as Nombre, "
            sql += "        0 As Seleccionar "
            sql += "   from MS_Menus"
            sql += "  where ID_Menu not in (Select ID_Menu from MS_RelModuloMenu Where ID_Modulo = " & Parametros & ")"
            sql += "  order by 1"

        ElseIf Funcionalidad = "ObtenMenusAsignadosModulos" Then
            sql += " select ID_Menu as Llave, "
            sql += "        ltrim(rtrim(upper(Descripcion))) as Nombre, "
            sql += "        0 As Seleccionar "
            sql += "   from MS_Menus"
            sql += "  where ID_Menu in (Select ID_Menu from MS_RelModuloMenu Where ID_Modulo = " & Parametros & ")"
            sql += "  order by 1"

        ElseIf Funcionalidad = "ObtenCatalogoMenusSistema" Then
            sql += "Select relMenu.ID_Sistema,"
            sql += "       relMenu.ID_Menu,"
            sql += "	   ltrim(rtrim(relMenu.ID_Menu)) + '/' + ltrim(rtrim(relMenu.ID_Sistema)) as Llave,"
            sql += "	   menu.Descripcion"
            sql += "  From MS_RelSistemaMenu relMenu inner join MS_Menus menu"
            sql += "    on relMenu.ID_Menu = menu.ID_Menu "
            sql += "  Where relMenu.ID_Menu in (Select ID_Menu from MS_RelSistemaMenu Where ID_Sistema = " & Parametros & ")"

        ElseIf Funcionalidad = "ObtenCatalogoMenusModulo" Then
            sql += "Select relMenu.ID_Sistema,"
            sql += "       relMenu.ID_Menu,"
            sql += "	   ltrim(rtrim(relMenu.ID_Menu)) + '/' + ltrim(rtrim(relMenu.ID_Sistema)) as Llave,"
            sql += "	   menu.Descripcion"
            sql += "  From MS_RelSistemaMenu relMenu inner join MS_Menus menu"
            sql += "    on relMenu.ID_Menu = menu.ID_Menu "
            sql += "  Where relMenu.ID_Menu in (Select ID_Menu from MS_RelSistemaMenu Where ID_Sistema = " & Parametros & ")"

        ElseIf Funcionalidad = "ObtenSubmenusAsignadosMenus" Then
            'sql += " select ID_Submenu as Llave, ltrim(rtrim(upper(Descripcion))) as Nombre, 0 As Seleccionar from MS_Submenus where ID_Submenu in (Select ID_Submenu from MS_RelMenuSubmenu Where ID_Menu = " & Parametros & "); "
            sql += "select ID_Submenu as Llave, ltrim(rtrim(upper(Descripcion))) as Nombre, 0 As Seleccionar from MS_Submenus where ID_Submenu in (Select ID_Submenu from MS_RelMenuSubmenu Where ID_Sistema = 1 and ID_Modulo = 1 and ID_Menu = 1) order by Orden"

        ElseIf Funcionalidad = "MS_CatOpciones" Then
            sql += " Select ms_op.ID_Opcion as ID,"
            sql += "        ms_op.Orden,"
            sql += "        upper(ms_op.Nombre) as Nombre,"
            sql += "        upper(ms_op.Descripcion) as Descripcion,"
            sql += "        upper(ms_op.Icono_Activo) as Icono_Activo,"
            sql += "        upper(ms_op.Icono_Inactivo) as Icono_Inactivo,"
            sql += "        upper(ms_op.Text) as Text,"
            sql += "        upper(ms_op.Value) as Value,"
            sql += "        upper(ms_op.ToolTip) as ToolTip,"
            sql += "        ms_op.Ruta,"
            sql += "        ms_op.Estatus,"
            sql += "        upper(ms_status.Nombre) as NombreEstatus,"
            sql += " 			upper(ms_op.Parametros) as Parametros,"
            sql += "        isnull(ms_op.BorradoLogico,0) as BorradoLogico"
            sql += "   From MS_Opciones ms_op inner join MS_Status ms_status"
            sql += "     on ms_op.Estatus = ms_status.ID_Status"
            sql += "  Where isnull(ms_op.BorradoLogico,0) = 0"
            sql += "  order by ms_op.Orden"

        ElseIf Funcionalidad = "MS_CatAccesos" Then
            sql += " Select ms_acc.ID_Acceso as ID,"
            sql += "        ms_acc.Orden,"
            sql += "        upper(ms_acc.Nombre) as Nombre,"
            sql += "        upper(ms_acc.Descripcion) as Descripcion,"
            sql += "        ms_acc.Estatus,"
            sql += "        upper(ms_status.Nombre) as NombreEstatus,"
            sql += "        isnull(ms_acc.BorradoLogico,0) as BorradoLogico"
            sql += "   From MS_Accesos ms_acc inner join MS_Status ms_status"
            sql += "     on ms_acc.Estatus = ms_status.ID_Status"
            sql += "  Where isnull(ms_acc.BorradoLogico,0) = 0"
            sql += "  order by ms_acc.Orden"

        ElseIf Funcionalidad = "MS_CatPerfiles" Then
            sql += " Select ms_per.ID_Perfil as ID,"
            sql += "         ms_per.Orden,"
            sql += "         upper(ms_per.Nombre) as Nombre,"
            sql += "         upper(ms_per.Descripcion) as Descripcion,"
            sql += "         ms_per.Estatus,"
            sql += "         upper(ms_status.Nombre) as NombreEstatus,"
            sql += "         isnull(ms_per.BorradoLogico,0) as BorradoLogico"
            sql += "    From MS_Perfiles ms_per inner join MS_Status ms_status"
            sql += "      on ms_per.Estatus = ms_status.ID_Status"
            sql += "   Where isnull(ms_per.BorradoLogico,0) = 0"

            If Parametros = "Activos" Then
                sql += "   and isnull(ms_per.Estatus,0) = 1"
            End If

            sql += "   order by ms_per.Orden"

        ElseIf Funcionalidad = "MS_CatUsuarios" Then
            sql = "Select usu.ID_Usuario, usu.Usuario, usu.ID_Perfil, catPer.Nombre as NombrePerfil, usu.Usuario_Registro, usu.Fecha_Registro, usu.Fecha_Modificacion, usu.Password, usu.Fecha_Caducidad_Clave, usu.Nombre, usu.Email, usu.Fecha_Inicio, usu.Fecha_Termino, usu.Estatus, upper(ms_status.Nombre) as NombreEstatus, usu.fecha_ultimo_Acceso, usu.Pass01, usu.Pass02, usu.Pass03, Case When isnull(usu.DebeCambiarPassword,0) = 0 Then 'NO' else 'SI' End As DebeCambiarPassword From MS_Usuarios usu inner join MS_Status ms_status on usu.Estatus = ms_status.ID_Status inner join MS_Perfiles catPer on usu.ID_Perfil = catPer.ID_Perfil Where isnull(usu.BorradoLogico,0) = 0 order by 1"
            sql += " Select usu.ID_Usuario,"
            sql += "         usu.Usuario,"
            sql += "         usu.ID_Perfil,"
            sql += " 		 catPer.NombrePerfil,"
            sql += "         usu.Usuario_Registro,"
            sql += "         usu.Fecha_Registro,"
            sql += "         usu.Fecha_Modificacion,"
            sql += "         usu.Password,"
            sql += "         usu.Fecha_Caducidad_Clave,"
            sql += "         usu.Nombre,"
            sql += "         usu.Email,"
            sql += "         usu.Fecha_Inicio,"
            sql += "         usu.Fecha_Termino,"
            sql += "         usu.Estatus,"
            sql += "  	      upper(ms_status.Nombre) as NombreEstatus,"
            sql += "         usu.fecha_ultimo_Acceso,"
            sql += "         usu.Pass01,"
            sql += "         usu.Pass02,"
            sql += "         usu.Pass03,"
            sql += "         usu.DebeCambiarPassword"
            sql += "    From MS_Usuarios usu inner join MS_Status ms_status on usu.Estatus = ms_status.ID_Status inner join MS_Perfiles catPer on usu.ID_Perfil = catPer.ID_Perfil Where isnull(usu.BorradoLogico,0) = 0 order by 1"
            sql = "Select usu.ID_Usuario, usu.Usuario, usu.ID_Perfil, catPer.Nombre as NombrePerfil, usu.Usuario_Registro, usu.Fecha_Registro, usu.Fecha_Modificacion, usu.Password, usu.Fecha_Caducidad_Clave, usu.Nombre, usu.Email, usu.Fecha_Inicio, usu.Fecha_Termino, usu.Estatus, upper(ms_status.Nombre) as NombreEstatus, usu.fecha_ultimo_Acceso, usu.Pass01, usu.Pass02, usu.Pass03, Case When isnull(usu.DebeCambiarPassword,0) = 0 Then 'NO' else 'SI' End As DebeCambiarPassword From MS_Usuarios usu inner join MS_Status ms_status on usu.Estatus = ms_status.ID_Status inner join MS_Perfiles catPer on usu.ID_Perfil = catPer.ID_Perfil Where isnull(usu.BorradoLogico,0) = 0 order by 1"

        ElseIf Funcionalidad = "MS_UsuariosDeSianAsignados" Then
            sql += " Select Distinct isnull(ID_Usuario_SIAN,0) as ID_Usuario_SIAN from MS_Usuarios "

        ElseIf Funcionalidad = "MS_UsuariosDeSianParaAsignar" Then
            sql += " Select ltrim(rtrim(Person_ID)) + '/' + ltrim(rtrim(Nombre_Corto)) + '/' + ltrim(rtrim(Nombre)) + '/' + isnull(ltrim(rtrim(nombrecorreoelectronico)),'SIN CORREO') as ID, Nombre from personal Where person_id not in (" & Parametros & ") order by Nombre "

            '===================================================================================================================================================================================
            '======= FUNCIONALIDAD NUEVA (TERMINO)==============================================================================================================================================
            '===================================================================================================================================================================================

        End If

        Dim dsSrc As New DataSet()
        Obtendatos.LlenarDataSet(sql, dsSrc, "Resultado")

        Return dsSrc

    End Function

    Public Function ActualizaCatalogo(ByVal Catalogo As Object, ByVal Llave As Object, ByVal Parametros As Object) As Integer
        Obtendatos = ServicioDeDatos
        Dim sql As String = ""
        Dim vResultado As Integer
        Dim vParametros As String()

        vParametros = Parametros.Split(Llave)

        If Catalogo = "MS_CatSistemas" Then
            Dim Parametro01 As Object = vParametros(0) 'Nombre
            Dim Parametro02 As Object = vParametros(1) 'Descripcion
            Dim Parametro03 As Object = vParametros(2) 'Orden
            Dim Parametro04 As Object = vParametros(3) 'Estatus
            Dim Parametro05 As Object = vParametros(4) 'ID_Sistema

            sql = "Update ms_sistemas set nombre = '" & Parametro01.ToString.ToUpper & "', descripcion= '" & Parametro02.ToString.ToUpper & "', orden = " & Parametro03.ToString.Trim & ", Estatus = " & Parametro04.ToString.Trim & " where id_sistema = " & Parametro05.ToString.Trim & ";"

        ElseIf Catalogo = "MS_CatEntornosDB" Then
            Dim Parametro01 As Object = vParametros(0) 'Nombre
            Dim Parametro02 As Object = vParametros(1) 'Descripcion
            Dim Parametro03 As Object = vParametros(2) 'Orden
            Dim Parametro04 As Object = vParametros(3) 'Estatus
            Dim Parametro05 As Object = vParametros(4) 'ID_Sistema

            sql = "Update ms_entornosdb set nombre = '" & Parametro01.ToString.ToUpper & "', descripcion= '" & Parametro02.ToString.ToUpper & "', orden = " & Parametro03.ToString.Trim & ", Estatus = " & Parametro04.ToString.Trim & " where id_entornodb = " & Parametro05.ToString.Trim & ";"

        ElseIf Catalogo = "MS_CatMenus" Then
            Dim Parametro01 As Object = vParametros(0) 'Orden
            Dim Parametro02 As Object = vParametros(1) 'Nombre
            Dim Parametro03 As Object = vParametros(2) 'Descripcion
            Dim Parametro04 As Object = vParametros(3) 'Icono_Activo
            Dim Parametro05 As Object = vParametros(4) 'Icono_Inactivo
            Dim Parametro06 As Object = vParametros(5) 'Ruta
            Dim Parametro07 As Object = vParametros(6) 'Text
            Dim Parametro08 As Object = vParametros(7) 'Value
            Dim Parametro09 As Object = vParametros(8) 'ToolTip
            Dim Parametro10 As Object = vParametros(9) 'Estatus
            Dim Parametro11 As Object = vParametros(10) 'ID_Menu

            sql = "Update MS_Menus Set Orden = " & Parametro01.ToString.ToUpper & ", Nombre = '" & Parametro02.ToString.ToUpper & "', Descripcion = '" & Parametro03.ToString.ToUpper & "', Icono_Activo = '" & Parametro04.ToString.ToUpper & "', Icono_Inactivo = '" & Parametro05.ToString.ToUpper & "', Text = '" & Parametro06.ToString.ToUpper & "', Value = '" & Parametro07.ToString.ToUpper & "',ToolTip = '" & Parametro08.ToString.ToUpper & "', Ruta = '" & Parametro09.ToString.ToUpper & "', Estatus = " & Parametro10.ToString.ToUpper & " Where ID_Menu = " & Parametro11.ToString.ToUpper & ";"

        ElseIf Catalogo = "MS_CatModulos" Then
            Dim Parametro01 As Object = vParametros(0) 'Orden
            Dim Parametro02 As Object = vParametros(1) 'Nombre
            Dim Parametro03 As Object = vParametros(2) 'Descripcion
            Dim Parametro04 As Object = vParametros(3) 'Estatus
            Dim Parametro05 As Object = vParametros(4) 'ID_Menu

            sql = "Update MS_Modulos Set Orden = " & Parametro01.ToString.ToUpper & ", Nombre = '" & Parametro02.ToString.ToUpper & "', Descripcion = '" & Parametro03.ToString.ToUpper & "', Estatus = " & Parametro04.ToString.ToUpper & " Where ID_Menu = " & Parametro05.ToString.ToUpper & ";"

        ElseIf Catalogo = "MS_CatSubmenus" Then
            Dim Parametro01 As Object = vParametros(0) 'Orden
            Dim Parametro02 As Object = vParametros(1) 'Nombre
            Dim Parametro03 As Object = vParametros(2) 'Descripcion
            Dim Parametro04 As Object = vParametros(3) 'Icono_Activo
            Dim Parametro05 As Object = vParametros(4) 'Icono_Inactivo
            Dim Parametro06 As Object = vParametros(5) 'Ruta
            Dim Parametro07 As Object = vParametros(6) 'Text
            Dim Parametro08 As Object = vParametros(7) 'Value
            Dim Parametro09 As Object = vParametros(8) 'ToolTip
            Dim Parametro10 As Object = vParametros(9) 'Estatus
            Dim Parametro11 As Object = vParametros(10) 'ID_Menu

            sql = "Update MS_Submenus Set Orden = " & Parametro01.ToString.ToUpper & ", Nombre = '" & Parametro02.ToString.ToUpper & "', Descripcion = '" & Parametro03.ToString.ToUpper & "', Icono_Activo = '" & Parametro04.ToString.ToUpper & "', Icono_Inactivo = '" & Parametro05.ToString.ToUpper & "', Text = '" & Parametro06.ToString.ToUpper & "', Value = '" & Parametro07.ToString.ToUpper & "',ToolTip = '" & Parametro08.ToString.ToUpper & "', Ruta = '" & Parametro09.ToString.ToUpper & "', Estatus = " & Parametro10.ToString.ToUpper & " Where ID_Submenu = " & Parametro11.ToString.ToUpper & ";"

        ElseIf Catalogo = "MS_CatOpciones" Then
            Dim Parametro01 As Object = vParametros(0) 'Orden
            Dim Parametro02 As Object = vParametros(1) 'Nombre
            Dim Parametro03 As Object = vParametros(2) 'Descripcion
            Dim Parametro04 As Object = vParametros(3) 'Icono_Activo
            Dim Parametro05 As Object = vParametros(4) 'Icono_Inactivo
            Dim Parametro06 As Object = vParametros(5) 'Ruta
            Dim Parametro07 As Object = vParametros(6) 'Text
            Dim Parametro08 As Object = vParametros(7) 'Value
            Dim Parametro09 As Object = vParametros(8) 'ToolTip
            Dim Parametro10 As Object = vParametros(9) 'Estatus
            Dim Parametro11 As Object = vParametros(10) 'Parametros
            Dim Parametro12 As Object = vParametros(11) 'ID_Opcion

            sql = "Update MS_Opciones Set Orden = " & Parametro01.ToString.ToUpper & ", Nombre = '" & Parametro02.ToString.ToUpper & "', Descripcion = '" & Parametro03.ToString.ToUpper & "', Icono_Activo = '" & Parametro04.ToString.ToUpper & "', Icono_Inactivo = '" & Parametro05.ToString.ToUpper & "', Text = '" & Parametro06.ToString.ToUpper & "', Value = '" & Parametro07.ToString.ToUpper & "',ToolTip = '" & Parametro08.ToString.ToUpper & "', Ruta = '" & Parametro09.ToString.ToUpper & "', Estatus = " & Parametro11.ToString.ToUpper & ", Parametros = '" & Parametro10.ToString.ToUpper & "' Where ID_Opcion = " & Parametro12.ToString.ToUpper & ";"

        ElseIf Catalogo = "MS_CatAccesos" Then
            Dim Parametro01 As Object = vParametros(0) 'Nombre
            Dim Parametro02 As Object = vParametros(1) 'Descripcion
            Dim Parametro03 As Object = vParametros(2) 'Orden
            Dim Parametro04 As Object = vParametros(3) 'Estatus
            Dim Parametro05 As Object = vParametros(4) 'ID_Sistema

            sql = "Update ms_accesos set nombre = '" & Parametro01.ToString.ToUpper & "', descripcion= '" & Parametro02.ToString.ToUpper & "', orden = " & Parametro03.ToString.Trim & ", Estatus = " & Parametro04.ToString.Trim & " where id_acceso = " & Parametro05.ToString.Trim & ";"

        ElseIf Catalogo = "MS_CatPerfiles" Then
            Dim Parametro01 As Object = vParametros(0) 'Nombre
            Dim Parametro02 As Object = vParametros(1) 'Descripcion
            Dim Parametro03 As Object = vParametros(2) 'Orden
            Dim Parametro04 As Object = vParametros(3) 'Estatus
            Dim Parametro05 As Object = vParametros(4) 'ID_Sistema

            sql = "Update ms_perfiles set nombre = '" & Parametro01.ToString.ToUpper & "', descripcion= '" & Parametro02.ToString.ToUpper & "', orden = " & Parametro03.ToString.Trim & ", Estatus = " & Parametro04.ToString.Trim & " where id_perfil = " & Parametro05.ToString.Trim & ";"

        End If

        vResultado = Obtendatos.EjecutarEscalar(sql)

        Return vResultado

    End Function

    Public Function InsertaCatalogo(ByVal Catalogo As String, ByVal Llave As Object, ByVal Parametros As String) As Integer
        Obtendatos = ServicioDeDatos
        Dim sql As String = ""
        Dim vResultado As Integer
        Dim vParametros As String()

        vParametros = Parametros.Split(Llave)

        If Catalogo = "MS_CatSistemas" Then
            Dim Parametro01 As Object = vParametros(0) 'Nombre
            Dim Parametro02 As Object = vParametros(1) 'Descripcion
            Dim Parametro03 As Object = vParametros(2) 'Orden
            Dim Parametro04 As Object = vParametros(3) 'Status

            sql = "Insert ms_sistemas(Nombre, Descripcion, Orden, Estatus) values('" & Parametro01.ToString.Trim.ToUpper & "', '" & Parametro02.ToString.Trim.ToUpper & "', " & Parametro03 & ", " & Parametro04 & ");"

        ElseIf Catalogo = "MS_RelFuncionalidaUsuario" Then
            Dim Parametro01 As Object = vParametros(0) 'ID_USUARIO
            Dim Parametro02 As Object = vParametros(1) 'ID_SISTEMA
            Dim Parametro03 As Object = vParametros(2) 'ID_MENU
            Dim Parametro04 As Object = vParametros(3) 'ID_SUBMENU
            Dim Parametro05 As Object = vParametros(4) 'ID_OPCION
            Dim Parametro06 As Object = vParametros(5) 'ID_ACCESO

            sql = "Insert MS_RelFuncionalidadUsuario(ID_USUARIO, ID_SISTEMA, ID_MENU, ID_SUBMENU, ID_OPCION, ID_ACCESO) values(" & Parametro01.ToString.Trim.ToUpper & ", " & Parametro02.ToString.Trim.ToUpper & ", " & Parametro03.ToString.Trim.ToUpper & "," & Parametro04.ToString.Trim.ToUpper & "," & Parametro05.ToString.Trim.ToUpper & Parametro06.ToString.Trim.ToUpper & ");"

        ElseIf Catalogo = "MS_RelFuncionalidaPerfil" Then
            Dim Parametro01 As Object = vParametros(0) 'ID_PERFIL
            Dim Parametro02 As Object = vParametros(1) 'ID_SISTEMA
            Dim Parametro03 As Object = vParametros(2) 'ID_MENU
            Dim Parametro04 As Object = vParametros(3) 'ID_SUBMENU
            Dim Parametro05 As Object = vParametros(4) 'ID_OPCION
            Dim Parametro06 As Object = vParametros(5) 'ID_ACCESO

            sql = "Insert MS_RelFuncionalidadPerfil(ID_PERFIL, ID_SISTEMA, ID_MENU, ID_SUBMENU, ID_OPCION, ID_ACCESO) values(" & Parametro01.ToString.Trim.ToUpper & ", " & Parametro02.ToString.Trim.ToUpper & ", " & Parametro03.ToString.Trim.ToUpper & "," & Parametro04.ToString.Trim.ToUpper & "," & Parametro05.ToString.Trim.ToUpper & Parametro06.ToString.Trim.ToUpper & ");"


        ElseIf Catalogo = "MS_CatEntornosDB" Then
            Dim Parametro01 As Object = vParametros(0) 'Nombre
            Dim Parametro02 As Object = vParametros(1) 'Descripcion
            Dim Parametro03 As Object = vParametros(2) 'Orden
            Dim Parametro04 As Object = vParametros(3) 'Status

            sql = "Insert ms_entornosdb(Nombre, Descripcion, Orden, Estatus) values('" & Parametro01.ToString.Trim.ToUpper & "', '" & Parametro02.ToString.Trim.ToUpper & "', " & Parametro03 & ", " & Parametro04 & ");"

        ElseIf Catalogo = "MS_CatMenus" Then
            Dim Parametro01 As Object = vParametros(0) 'Orden
            Dim Parametro02 As Object = vParametros(1) 'Nombre
            Dim Parametro03 As Object = vParametros(2) 'Descripcion
            Dim Parametro04 As Object = vParametros(3) 'Icono_Activo
            Dim Parametro05 As Object = vParametros(4) 'Icono_Inactivo
            Dim Parametro06 As Object = vParametros(5) 'Text 
            Dim Parametro07 As Object = vParametros(6) 'Value
            Dim Parametro08 As Object = vParametros(7) 'ToolTip
            Dim Parametro09 As Object = vParametros(8) 'Ruta
            Dim Parametro10 As Object = vParametros(9) 'Estatus

            sql = "Insert Into MS_Menus(Orden,Nombre,Descripcion,Icono_Activo,Icono_Inactivo,Text,Value,ToolTip,Ruta,Estatus) Values(" & Parametro01.ToString.Trim.ToUpper & ",'" & Parametro02.ToString.Trim.ToUpper & "','" & Parametro03.ToString.Trim.ToUpper & "','" & Parametro04.ToString.Trim.ToUpper & "','" & Parametro05.ToString.Trim.ToUpper & "','" & Parametro06.ToString.Trim.ToUpper & "','" & Parametro07.ToString.Trim.ToUpper & "','" & Parametro08.ToString.Trim.ToUpper & "','" & Parametro09.ToString.Trim.ToUpper & "'," & Parametro10.ToString.Trim.ToUpper & ");"

        ElseIf Catalogo = "MS_CatModulos" Then
            Dim Parametro01 As Object = vParametros(0) 'Orden
            Dim Parametro02 As Object = vParametros(1) 'Nombre
            Dim Parametro03 As Object = vParametros(2) 'Descripcion
            Dim Parametro04 As Object = vParametros(3) 'Estatus

            sql = "Insert Into MS_Modulos(Orden,Nombre,Descripcion,Estatus) Values(" & Parametro01.ToString.Trim.ToUpper & ",'" & Parametro02.ToString.Trim.ToUpper & "','" & Parametro03.ToString.Trim.ToUpper & "','" & Parametro04.ToString.Trim.ToUpper & "');"

        ElseIf Catalogo = "MS_CatSubmenus" Then
            Dim Parametro01 As Object = vParametros(0) 'Orden
            Dim Parametro02 As Object = vParametros(1) 'Nombre
            Dim Parametro03 As Object = vParametros(2) 'Descripcion
            Dim Parametro04 As Object = vParametros(3) 'Icono_Activo
            Dim Parametro05 As Object = vParametros(4) 'Icono_Inactivo
            Dim Parametro06 As Object = vParametros(5) 'Text 
            Dim Parametro07 As Object = vParametros(6) 'Value
            Dim Parametro08 As Object = vParametros(7) 'ToolTip
            Dim Parametro09 As Object = vParametros(8) 'Ruta
            Dim Parametro10 As Object = vParametros(9) 'Estatus

            sql = "Insert Into MS_Submenus(Orden,Nombre,Descripcion,Icono_Activo,Icono_Inactivo,Text,Value,ToolTip,Ruta,Estatus) Values(" & Parametro01.ToString.Trim.ToUpper & ",'" & Parametro02.ToString.Trim.ToUpper & "','" & Parametro03.ToString.Trim.ToUpper & "','" & Parametro04.ToString.Trim.ToUpper & "','" & Parametro05.ToString.Trim.ToUpper & "','" & Parametro06.ToString.Trim.ToUpper & "','" & Parametro07.ToString.Trim.ToUpper & "','" & Parametro08.ToString.Trim.ToUpper & "','" & Parametro09.ToString.Trim.ToUpper & "'," & Parametro10.ToString.Trim.ToUpper & ");"

        ElseIf Catalogo = "MS_CatOpciones" Then
            Dim Parametro01 As Object = vParametros(0) 'Orden
            Dim Parametro02 As Object = vParametros(1) 'Nombre
            Dim Parametro03 As Object = vParametros(2) 'Descripcion
            Dim Parametro04 As Object = vParametros(3) 'Icono_Activo
            Dim Parametro05 As Object = vParametros(4) 'Icono_Inactivo
            Dim Parametro06 As Object = vParametros(5) 'Text 
            Dim Parametro07 As Object = vParametros(6) 'Value
            Dim Parametro08 As Object = vParametros(7) 'ToolTip
            Dim Parametro09 As Object = vParametros(8) 'Ruta
            Dim Parametro10 As Object = vParametros(9) 'Parametros
            Dim Parametro11 As Object = vParametros(10) 'Estatus

            sql = "Insert Into MS_Opciones(Orden,Nombre,Descripcion,Icono_Activo,Icono_Inactivo,Text,Value,ToolTip,Ruta,Parametros,Estatus) Values(" & Parametro01.ToString.Trim.ToUpper & ",'" & Parametro02.ToString.Trim.ToUpper & "','" & Parametro03.ToString.Trim.ToUpper & "','" & Parametro04.ToString.Trim.ToUpper & "','" & Parametro05.ToString.Trim.ToUpper & "','" & Parametro06.ToString.Trim.ToUpper & "','" & Parametro07.ToString.Trim.ToUpper & "','" & Parametro08.ToString.Trim.ToUpper & "','" & Parametro09.ToString.Trim.ToUpper & "','" & Parametro10.ToString.Trim.ToUpper & "'," & Parametro11.ToString.Trim.ToUpper & ");"

        ElseIf Catalogo = "MS_CatAccesos" Then
            Dim Parametro01 As Object = vParametros(0) 'Nombre
            Dim Parametro02 As Object = vParametros(1) 'Descripcion
            Dim Parametro03 As Object = vParametros(2) 'Orden
            Dim Parametro04 As Object = vParametros(3) 'Status

            sql = "Insert ms_accesos(Nombre, Descripcion, Orden, Estatus) values('" & Parametro01.ToString.Trim.ToUpper & "', '" & Parametro02.ToString.Trim.ToUpper & "', " & Parametro03 & ", " & Parametro04 & ");"

        ElseIf Catalogo = "MS_CatPerfiles" Then
            Dim Parametro01 As Object = vParametros(0) 'Nombre
            Dim Parametro02 As Object = vParametros(1) 'Descripcion
            Dim Parametro03 As Object = vParametros(2) 'Orden
            Dim Parametro04 As Object = vParametros(3) 'Status

            sql = "Insert ms_perfiles(Nombre, Descripcion, Orden, Estatus) values('" & Parametro01.ToString.Trim.ToUpper & "', '" & Parametro02.ToString.Trim.ToUpper & "', " & Parametro03 & ", " & Parametro04 & ");"


        End If

        vResultado = Obtendatos.EjecutarEscalar(sql)

        Return vResultado

    End Function

    Public Function EliminaCatalogo(ByVal Catalogo As String, ByVal Llave As Object, ByVal Parametros As String) As Integer
        Obtendatos = ServicioDeDatos
        Dim sql As String = ""
        Dim vResultado As Integer
        Dim vParametros As String()

        vParametros = Parametros.Split(Llave)

        If Catalogo = "MS_CatSistemas" Then
            Dim Parametro01 As Object = vParametros(0)

            sql = "Update ms_sistemas set BorradoLogico = 1  where id_sistema = " & Parametro01.ToString.Trim & ";"

        ElseIf Catalogo = "MS_CatEntornosDB" Then
            Dim Parametro01 As Object = vParametros(0)

            sql = "Update ms_entornosdb set BorradoLogico = 1  where id_entornodb = " & Parametro01.ToString.Trim & ";"

        ElseIf Catalogo = "MS_CatMenus" Then
            Dim Parametro01 As Object = vParametros(0)

            sql = "Update ms_menus set BorradoLogico = 1  where id_menu = " & Parametro01.ToString.Trim & ";"

        ElseIf Catalogo = "MS_CatModulos" Then
            Dim Parametro01 As Object = vParametros(0)

            sql = "Update MS_CatModulos set BorradoLogico = 1  where ID_Modulo = " & Parametro01.ToString.Trim & ";"

        ElseIf Catalogo = "MS_CatSubmenus" Then
            Dim Parametro01 As Object = vParametros(0)

            sql = "Update ms_submenus set BorradoLogico = 1  where id_submenu = " & Parametro01.ToString.Trim & ";"

        ElseIf Catalogo = "MS_Opciones" Then
            Dim Parametro01 As Object = vParametros(0)

            sql = "Update ms_opciones set BorradoLogico = 1  where id_opcion = " & Parametro01.ToString.Trim & ";"

        ElseIf Catalogo = "MS_Accesos" Then
            Dim Parametro01 As Object = vParametros(0)

            sql = "Update ms_accesos set BorradoLogico = 1  where id_acceso = " & Parametro01.ToString.Trim & ";"

        ElseIf Catalogo = "MS_CatPerfiles" Then
            Dim Parametro01 As Object = vParametros(0)

            sql = "Update ms_perfiles set BorradoLogico = 1  where id_perfil = " & Parametro01.ToString.Trim & ";"

        End If

        vResultado = Obtendatos.EjecutarEscalar(sql)

        Return vResultado

    End Function


    Public Function ObtenDataSet(ByVal Funcionalidad As String, ByVal Parametros As Object) As DataSet
        Obtendatos = ServicioDeDatos

        Dim sql As String = ""

        If Funcionalidad = "ObtenCatalogoMenus" Then
            sql += " Select ID_Sistema as Llave,"
            sql += "        upper(Descripcion) as Descripcion"
            sql += "   from MS_Sistemas"
            sql += "  Where isnull(Estatus,0) = 1"
            sql += "    and isnull(BorradoLogico,0) = 0"
            sql += "  order by orden"

        ElseIf Funcionalidad = "ObtenCatalogoModulos" Then
            sql += " Select ID_Modulo as Llave,"
            sql += "        upper(Descripcion) as Descripcion"
            sql += "   from MS_Modulos"
            sql += "  Where isnull(Estatus,0) = 1"
            sql += "    and isnull(BorradoLogico,0) = 0"
            sql += "  order by orden"

        ElseIf Funcionalidad = "ObtenCatalogoSistemas" Then
            sql += " Select ID_Sistema as Llave,"
            sql += "        upper(Descripcion) as Descripcion"
            sql += "   from MS_Sistemas"
            sql += "  Where isnull(Estatus,0) = 1"
            sql += "    and isnull(BorradoLogico,0) = 0"
            sql += "  order by orden"

        ElseIf Funcionalidad = "ObtenMenusSinAsignarSistemas" Then
            sql += " select ID_Menu as Llave, "
            sql += "        ltrim(rtrim(upper(Descripcion))) as Nombre, "
            sql += "        0 As Seleccionar "
            sql += "   from MS_Menus"
            sql += "  where ID_Menu not in (Select ID_Menu from MS_RelSistemaMenu Where ID_Sistema = " & Parametros & ")"
            sql += "  order by 1"

        ElseIf Funcionalidad = "ObtenModulosSinAsignarSistemas" Then
            sql += " select ID_Modulo as Llave, "
            sql += "        ltrim(rtrim(upper(Descripcion))) as Nombre, "
            sql += "        0 As Seleccionar "
            sql += "   from MS_Modulos"
            sql += "  where ID_Modulo not in (Select ID_Modulo from MS_RelModuloSistema Where ID_Sistema = " & Parametros & ")"
            sql += "  order by 1"

        ElseIf Funcionalidad = "ObtenMenusSinAsignarModulos" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += " select ID_Menu as Llave, "
            sql += "        ltrim(rtrim(upper(Descripcion))) as Nombre, "
            sql += "        0 As Seleccionar "
            sql += "   from MS_Menus"
            sql += "  where ID_Menu not in (Select ID_Menu from MS_RelModuloMenu Where ID_Sistema = " & vParametros(0) & " and ID_Modulo = " & vParametros(1) & ")"
            sql += "  order by 1"

        ElseIf Funcionalidad = "ObtenMenusAsignadosModulos" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += " select ID_Menu as Llave, "
            sql += "        ltrim(rtrim(upper(Descripcion))) as Nombre, "
            sql += "        0 As Seleccionar "
            sql += "   from MS_Menus"
            sql += "  where ID_Menu in (Select ID_Menu from MS_RelModuloMenu Where ID_Sistema = " & vParametros(0) & " and ID_Modulo = " & vParametros(1) & ")"
            sql += "  order by 1"

        ElseIf Funcionalidad = "ObtenMenusAsignadosSistemas" Then
            sql += " select ID_Menu as Llave, "
            sql += "        ltrim(rtrim(upper(Descripcion))) as Nombre, "
            sql += "        0 As Seleccionar "
            sql += "   from MS_Menus"
            sql += "  where ID_Menu in (Select ID_Menu from MS_RelSistemaMenu Where ID_Sistema = " & Parametros & ")"
            sql += "  order by 1"

        ElseIf Funcionalidad = "ObtenModulosAsignadosSistemas" Then
            sql += " select ID_Modulo as Llave, "
            sql += "        ltrim(rtrim(upper(Descripcion))) as Nombre, "
            sql += "        0 As Seleccionar "
            sql += "   from MS_Modulos"
            sql += "  where ID_Modulo in (Select ID_Modulo from MS_RelModuloSistema Where ID_Sistema = " & Parametros & ")"
            sql += "  order by 1"

        ElseIf Funcionalidad = "ObtenCatalogoMenusSistema" Then
            sql += "Select relMenu.ID_Sistema, relMenu.ID_Menu, ltrim(rtrim(relMenu.ID_Menu)) + '/' + ltrim(rtrim(relMenu.ID_Sistema)) as Llave, menu.Descripcion  From MS_RelSistemaMenu relMenu inner join MS_Menus menu on relMenu.ID_Menu = menu.ID_Menu Where relMenu.ID_Sistema = " & Parametros & ";"

        ElseIf Funcionalidad = "ObtenCatalogoModulosSistema" Then
            sql += "Select relModulo.ID_Sistema, relModulo.ID_Modulo, ltrim(rtrim(relModulo.ID_Sistema)) + '/' +  ltrim(rtrim(relModulo.ID_Modulo)) as Llave, menu.Descripcion From MS_RelModuloSistema relModulo inner join MS_Modulos menu on relModulo.ID_Modulo = menu.ID_Modulo Where relModulo.ID_Sistema = " & Parametros & ";"

        ElseIf Funcionalidad = "ObtenCatalogoMenusModulo" Then
            sql += "Select relModuloMenu.ID_Sistema, relModuloMenu.ID_Modulo, relModuloMenu.ID_Menu, ltrim(rtrim(relModuloMenu.ID_Sistema)) + '/' + ltrim(rtrim(relModuloMenu.ID_Modulo)) + '/' + ltrim(rtrim(relModuloMenu.ID_Menu)) as Llave, menu.Descripcion From MS_RelModuloMenu relModuloMenu inner join MS_Menus menu on relModuloMenu.ID_Menu = menu.ID_Menu Where relModuloMenu.ID_Modulo = " & Parametros & ";"

        ElseIf Funcionalidad = "ObtenCatalogoSubmenuMenusAFF" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += "Select relModuloMenu.ID_Sistema, "
            sql += " relModuloMenu.ID_Modulo, "
            sql += " relModuloMenu.ID_Menu, "
            sql += " relModuloMenu.ID_Submenu, "
            sql += " ltrim(rtrim(relModuloMenu.ID_Submenu)) as Llave, "
            sql += " menu.Descripcion "
            sql += " From MS_RelMenuSubmenu relModuloMenu inner join MS_Submenus menu "
            sql += " on relModuloMenu.ID_Submenu = menu.ID_Submenu "
            sql += " Where relModuloMenu.ID_Sistema = " & vParametros(0)
            sql += " and relModuloMenu.ID_Modulo = " & vParametros(1)
            sql += " and relModuloMenu.ID_Menu = " & vParametros(2)

        ElseIf Funcionalidad = "ObtenCatalogoSubmenuMenus" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += "Select relModuloMenu.ID_Sistema, "
            sql += " relModuloMenu.ID_Modulo, "
            sql += " relModuloMenu.ID_Menu, "
            sql += " relModuloMenu.ID_Submenu, "
            sql += " ltrim(rtrim(relModuloMenu.ID_Sistema)) + '/' + "
            sql += " ltrim(rtrim(relModuloMenu.ID_Modulo)) + '/' + "
            sql += " ltrim(rtrim(relModuloMenu.ID_Menu)) + '/' + "
            sql += " ltrim(rtrim(relModuloMenu.ID_Submenu)) as Llave, "
            sql += " menu.Descripcion "
            sql += " From MS_RelMenuSubmenu relModuloMenu inner join MS_Submenus menu "
            sql += " on relModuloMenu.ID_Submenu = menu.ID_Submenu "
            sql += " Where relModuloMenu.ID_Sistema = " & vParametros(0)
            sql += " and relModuloMenu.ID_Modulo = " & vParametros(1)
            sql += " and relModuloMenu.ID_Menu = " & vParametros(2)


        ElseIf Funcionalidad = "ObtenCatalogoOpcionesSubmenuAFF" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += " Select relSubmenuOpc.ID_Sistema, "
            sql += " relSubmenuOpc.ID_Modulo, "
            sql += " relSubmenuOpc.ID_Menu, "
            sql += " relSubmenuOpc.ID_Submenu, "
            sql += " ltrim(rtrim(relSubmenuOpc.ID_Opcion))  as Llave, "
            sql += " opc.Descripcion "
            sql += " From MS_RelSubmenuOpcion relSubmenuOpc inner join MS_Opciones opc "
            sql += " on relSubmenuOpc.ID_Opcion = opc.ID_Opcion "
            sql += " Where relSubmenuOpc.ID_Sistema = " & vParametros(0)
            sql += " and relSubmenuOpc.ID_Modulo = " & vParametros(1)
            sql += " and relSubmenuOpc.ID_Menu = " & vParametros(2)
            sql += " and relSubmenuOpc.ID_Submenu = " & vParametros(3)

        ElseIf Funcionalidad = "ObtenCatalogoOpcionesSubmenu" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += " Select relSubmenuOpc.ID_Sistema, "
            sql += " relSubmenuOpc.ID_Modulo, "
            sql += " relSubmenuOpc.ID_Menu, "
            sql += " relSubmenuOpc.ID_Submenu, "
            sql += " ltrim(rtrim(relSubmenuOpc.ID_Sistema)) + '/' + "
            sql += " ltrim(rtrim(relSubmenuOpc.ID_Modulo)) + '/' + "
            sql += " ltrim(rtrim(relSubmenuOpc.ID_Menu)) + '/' + "
            sql += " ltrim(rtrim(relSubmenuOpc.ID_Submenu)) + '/' + "
            sql += " ltrim(rtrim(relSubmenuOpc.ID_Opcion))  as Llave, "
            sql += " opc.Descripcion "
            sql += " From MS_RelSubmenuOpcion relSubmenuOpc inner join MS_Opciones opc "
            sql += " on relSubmenuOpc.ID_Opcion = opc.ID_Opcion "
            sql += " Where relSubmenuOpc.ID_Sistema = " & vParametros(0)
            sql += " and relSubmenuOpc.ID_Modulo = " & vParametros(1)
            sql += " and relSubmenuOpc.ID_Menu = " & vParametros(2)
            sql += " and relSubmenuOpc.ID_Submenu = " & vParametros(3)

        ElseIf Funcionalidad = "ObtenSubmenusSinAsignarMenus" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += " select ID_Submenu as Llave, ltrim(rtrim(upper(Descripcion))) as Nombre, 0 As Seleccionar from MS_Submenus where ID_Submenu not in (Select ID_Submenu from MS_RelMenuSubmenu Where ID_Sistema = " & vParametros(0) & " and ID_Modulo = " & vParametros(1) & " and ID_Menu = " & vParametros(2) & ") order by Orden "

        ElseIf Funcionalidad = "ObtenOpcionesAsignadasSubmenus" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += "Select ID_Opcion as Llave, ltrim(rtrim(upper(Descripcion))) as Nombre, 0 As Seleccionar from MS_Opciones where ID_Opcion in (Select ID_Opcion from MS_RelSubmenuOpcion Where ID_Sistema = " & vParametros(0) & " and ID_Modulo = " & vParametros(1) & " and ID_Menu = " & vParametros(2) & " and ID_Submenu = " & vParametros(3) & ") order by 1"

        ElseIf Funcionalidad = "ObtenOpcionesSinAsignarSubmenus" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += "Select ID_Opcion as Llave, ltrim(rtrim(upper(Descripcion))) as Nombre, 0 As Seleccionar from MS_Opciones where ID_Opcion not in (Select ID_Opcion from MS_RelSubmenuOpcion Where ID_Sistema = " & vParametros(0) & " and ID_Modulo = " & vParametros(1) & " and ID_Menu = " & vParametros(2) & " and ID_Submenu = " & vParametros(3) & ") order by 1"

        ElseIf Funcionalidad = "ObtenAccesosAsignadosOpcionesPerfil" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += "select ID_Acceso as Llave, ltrim(rtrim(upper(Nombre))) as Nombre, 0 As Seleccionar from MS_Accesos where ID_Acceso in (Select ID_Acceso from MS_RelFuncionalidadPerfil Where ID_Perfil = " & vParametros(5) & " and ID_Sistema = " & vParametros(0) & " and ID_Modulo = " & vParametros(1) & " and ID_Menu = " & vParametros(2) & " and ID_Submenu = " & vParametros(3) & " and ID_Opcion = " & vParametros(4) & ") order by 1"

        ElseIf Funcionalidad = "ObtenAccesosSinAsignarOpcionesPerfil" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += "select ID_Acceso as Llave, ltrim(rtrim(upper(Nombre))) as Nombre, 0 As Seleccionar from MS_Accesos where ID_Acceso not in (Select ID_Acceso from MS_RelFuncionalidadPerfil Where ID_Perfil = " & vParametros(5) & " and ID_Sistema = " & vParametros(0) & " and ID_Modulo = " & vParametros(1) & " and ID_Menu = " & vParametros(2) & " and ID_Submenu = " & vParametros(3) & " and ID_Opcion = " & vParametros(4) & ") order by 1"

        ElseIf Funcionalidad = "ObtenAccesosAsignadosOpcionesUsuario" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += "select ID_Acceso as Llave, ltrim(rtrim(upper(Nombre))) as Nombre, 0 As Seleccionar from MS_Accesos where ID_Acceso in (Select ID_Acceso from MS_RelFuncionalidadUsuario Where ID_Usuario = " & vParametros(5) & " and ID_Sistema = " & vParametros(0) & " and ID_Modulo = " & vParametros(1) & " and ID_Menu = " & vParametros(2) & " and ID_Submenu = " & vParametros(3) & " and ID_Opcion = " & vParametros(4) & ") order by 1"

        ElseIf Funcionalidad = "ObtenAccesosSinAsignarOpcionesUsuario" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += "select ID_Acceso as Llave, ltrim(rtrim(upper(Nombre))) as Nombre, 0 As Seleccionar from MS_Accesos where ID_Acceso not in (Select ID_Acceso from MS_RelFuncionalidadUsuario Where ID_Usuario = " & vParametros(5) & " and ID_Sistema = " & vParametros(0) & " and ID_Modulo = " & vParametros(1) & " and ID_Menu = " & vParametros(2) & " and ID_Submenu = " & vParametros(3) & " and ID_Opcion = " & vParametros(4) & ") order by 1"

        ElseIf Funcionalidad = "ObtenAccesosSinAsignarOpcionesPerfiles" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += "select ID_Acceso as Llave, ltrim(rtrim(upper(Nombre))) as Nombre, 0 As Seleccionar from MS_Accesos where ID_Acceso not in (Select ID_Acceso from MS_RelFuncionalidadPerfil Where ID_Perfil = " & vParametros(0) & " and ID_Sistema = " & vParametros(1) & " and ID_Menu = " & vParametros(2) & " and ID_Submenu = " & vParametros(3) & " and ID_Opcion = " & vParametros(4) & ") order by 1"

        ElseIf Funcionalidad = "ObtenAccesosSinAsignarOpcionesUsuarios" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += "select ID_Acceso as Llave, ltrim(rtrim(upper(Nombre))) as Nombre, 0 As Seleccionar from MS_Accesos where ID_Acceso not in (Select ID_Acceso from MS_RelFuncionalidadUsuario Where ID_Usuario = " & vParametros(0) & " and ID_Sistema = " & vParametros(1) & " and ID_Menu = " & vParametros(2) & " and ID_Submenu = " & vParametros(3) & " and ID_Opcion = " & vParametros(4) & ") order by 1"

        ElseIf Funcionalidad = "ObtenAccesosAsignadosOpcionesPerfiles_" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += "select ID_Acceso as Llave, ltrim(rtrim(upper(Nombre))) as Nombre, 0 As Seleccionar from MS_Accesos where ID_Acceso in (Select ID_Acceso from MS_RelFuncionalidadPerfil Where ID_Perfil = " & vParametros(0) & " and ID_Sistema = " & vParametros(1) & " and ID_Menu = " & vParametros(2) & " and ID_Submenu = " & vParametros(3) & " and ID_Opcion = " & vParametros(4) & ") order by 1"

        ElseIf Funcionalidad = "ObtenAccesosAsignadosOpcionesUsuarios" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += "select ID_Acceso as Llave, ltrim(rtrim(upper(Nombre))) as Nombre, 0 As Seleccionar from MS_Accesos where ID_Acceso in (Select ID_Acceso from MS_RelFuncionalidadUsuario Where ID_Usuario = " & vParametros(0) & " and ID_Sistema = " & vParametros(1) & " and ID_Menu = " & vParametros(2) & " and ID_Submenu = " & vParametros(3) & " and ID_Opcion = " & vParametros(4) & ") order by 1"

        ElseIf Funcionalidad = "ObtenSubmenusAsignadosMenus" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += " select ID_Submenu as Llave, ltrim(rtrim(upper(Descripcion))) as Nombre, 0 As Seleccionar from MS_Submenus where ID_Submenu in (Select ID_Submenu from MS_RelMenuSubmenu Where ID_Sistema = " & vParametros(0) & " and ID_Modulo = " & vParametros(1) & " and ID_Menu = " & vParametros(2) & ") order by Orden "

        ElseIf Funcionalidad = "ObtenModulosAsignadosUsuario" Then
            Dim vParametros As String()
            vParametros = Parametros.Split("/")
            sql += " Select ID_Modulo, Orden, Nombre from MS_Modulos Where ID_Modulo in (Select distinct ID_Modulo from MS_RelFuncionalidadUsuario Where ID_Usuario = " & vParametros(0) & " and ID_Sistema = " & vParametros(1) & ") and isnull(Estatus,0) = 1  and isnull(BorradoLogico,0) = 0 "

            '===================================================================================================================================================================================
            '======= FUNCIONALIDAD NUEVA (TERMINO)==============================================================================================================================================
            '===================================================================================================================================================================================

        End If

        Dim dsSrc As New DataSet()
        Obtendatos.LlenarDataSet(sql, dsSrc, "Resultado")

        Return dsSrc

    End Function



    Public Function ActualizaRelacionCatalogo(ByVal Funcionalidad As String, ByVal LlavePadre As Object, ByVal LlaveHija As Object) As Integer
        Obtendatos = ServicioDeDatos
        Dim sql As String = ""
        Dim Resultado As Integer = 0

        If Funcionalidad = "AsignaRelMenuSistema" Then
            sql = " Insert into MS_RelSistemaMenu(ID_Sistema, ID_Menu) values(" & LlavePadre & "," & LlaveHija & ");"

        ElseIf Funcionalidad = "DesasignaRelMenuSistema" Then
            sql = " Delete from MS_RelSistemaMenu where ID_Sistema = " & LlavePadre & " and ID_Menu = " & LlaveHija & ";"

        ElseIf Funcionalidad = "AsignaRelModulosSistema" Then
            sql = " Insert into MS_RelModuloSistema(ID_Sistema, ID_Modulo) values(" & LlavePadre & "," & LlaveHija & ");"

        ElseIf Funcionalidad = "DesasignaRelModulosSistema" Then
            sql = " Delete from MS_RelModuloSistema where ID_Sistema = " & LlavePadre & " and ID_Modulo = " & LlaveHija & ";"

        ElseIf Funcionalidad = "AsignaRelMenuModulo" Then
            Dim vParametros As String()
            vParametros = LlavePadre.Split("/")
            sql = " Insert into MS_RelModuloMenu(ID_Sistema, ID_Modulo, ID_Menu) values(" & vParametros(0) & "," & vParametros(1) & "," & LlaveHija & ");"

        ElseIf Funcionalidad = "DesasignaRelMenuModulo" Then
            Dim vParametros As String()
            vParametros = LlavePadre.Split("/")
            sql = " Delete from MS_RelModuloMenu where ID_Sistema = " & vParametros(0) & " and ID_Modulo = " & vParametros(1) & " and ID_Menu = " & LlaveHija & ";"

        ElseIf Funcionalidad = "AsignaRelSubmenuMenu" Then
            Dim vParametros As String()
            vParametros = LlavePadre.Split("/")
            sql = " Insert into MS_RelMenuSubmenu(ID_Sistema, ID_Modulo, ID_Menu, ID_Submenu) values(" & vParametros(0) & "," & vParametros(1) & "," & vParametros(2) & "," & LlaveHija & ");"

        ElseIf Funcionalidad = "DesasignaRelSubmenuMenu" Then
            Dim vParametros As String()
            vParametros = LlavePadre.Split("/")
            sql = " Delete from MS_RelMenuSubmenu where ID_Sistema = " & vParametros(0) & " and ID_Modulo = " & vParametros(1) & " and ID_Menu = " & vParametros(2) & " and ID_Submenu = " & LlaveHija & ";"

        ElseIf Funcionalidad = "AsignaRelSubmenuOpcion" Then
            Dim vParametros As String()
            vParametros = LlavePadre.Split("/")
            sql = " Insert into MS_RelSubmenuOpcion(ID_Sistema, ID_Modulo, ID_Menu, ID_Submenu, ID_Opcion) values(" & vParametros(0) & "," & vParametros(1) & "," & vParametros(2) & "," & vParametros(3) & "," & LlaveHija & ");"

        ElseIf Funcionalidad = "DesasignaRelSubmenuOpcion" Then
            Dim vParametros As String()
            vParametros = LlavePadre.Split("/")
            sql = " Delete from MS_RelSubmenuOpcion where ID_Sistema = " & vParametros(0) & " and ID_Modulo = " & vParametros(1) & " and ID_Menu = " & vParametros(2) & " and ID_Submenu = " & vParametros(3) & " and ID_Opcion = " & LlaveHija & ";"

        ElseIf Funcionalidad = "AsignaRelOpcionAcceso" Then
            Dim vParametros As String()
            vParametros = LlavePadre.Split("/")
            sql = " Insert into MS_RelAccesoOpcion(ID_Sistema, ID_Modulo, ID_Menu, ID_Submenu, ID_Opcion, ID_Acceso) values(" & vParametros(0) & "," & vParametros(1) & "," & vParametros(2) & "," & vParametros(3) & "," & vParametros(4) & "," & LlaveHija & ");"

        ElseIf Funcionalidad = "DesasignaRelOpcionAcceso" Then
            Dim vParametros As String()
            vParametros = LlavePadre.Split("/")
            sql = " Delete from MS_RelAccesoOpcion where ID_Sistema = " & vParametros(0) & " and ID_Modulo = " & vParametros(1) & " and ID_Menu = " & vParametros(2) & " and ID_Submenu = " & vParametros(3) & " and ID_Opcion = " & vParametros(4) & " and ID_Acceso = " & LlaveHija & ";"

        ElseIf Funcionalidad = "AsignaRelOpcionAccesoPerfil" Then
            Dim vParametros As String()
            vParametros = LlavePadre.Split("/")
            sql = " Insert into MS_RelFuncionalidadPerfil(ID_Perfil, ID_Sistema, ID_Modulo, ID_Menu, ID_Submenu, ID_Opcion, ID_Acceso) values(" & vParametros(5) & "," & vParametros(0) & "," & vParametros(1) & "," & vParametros(2) & "," & vParametros(3) & "," & vParametros(4) & "," & LlaveHija & ");"

        ElseIf Funcionalidad = "DesasignaRelOpcionAccesoPerfil" Then
            Dim vParametros As String()
            vParametros = LlavePadre.Split("/")
            sql = " Delete from MS_RelFuncionalidadPerfil where ID_Perfil = " & vParametros(5) & " and ID_Sistema = " & vParametros(0) & " and ID_Modulo = " & vParametros(1) & " and ID_Menu = " & vParametros(2) & " and ID_Submenu = " & vParametros(3) & " and ID_Opcion = " & vParametros(4) & " and ID_Acceso = " & LlaveHija & ";"

        ElseIf Funcionalidad = "AsignaRelOpcionAccesoUsuario" Then
            Dim vParametros As String()
            vParametros = LlavePadre.Split("/")
            sql = " Insert into MS_RelFuncionalidadUsuario(ID_Usuario, ID_Sistema, ID_Modulo, ID_Menu, ID_Submenu, ID_Opcion, ID_Acceso) values(" & vParametros(5) & "," & vParametros(0) & "," & vParametros(1) & "," & vParametros(2) & "," & vParametros(3) & "," & vParametros(4) & "," & LlaveHija & ");"

        ElseIf Funcionalidad = "DesasignaRelOpcionAccesoUsuario" Then
            Dim vParametros As String()
            vParametros = LlavePadre.Split("/")
            sql = " Delete from MS_RelFuncionalidadUsuario where ID_Usuario = " & vParametros(5) & " and ID_Sistema = " & vParametros(0) & " and ID_Modulo = " & vParametros(1) & " and ID_Menu = " & vParametros(2) & " and ID_Submenu = " & vParametros(3) & " and ID_Opcion = " & vParametros(4) & " and ID_Acceso = " & LlaveHija & ";"

        ElseIf Funcionalidad = "AsignaRelOpcionPerfil" Then
            Dim vParametros As String()
            vParametros = LlavePadre.Split("/")
            sql = " Insert into MS_RelFuncionalidadPerfil(ID_PERFIL, ID_SISTEMA, ID_MENU, ID_SUBMENU, ID_OPCION, ID_ACCESO) values(" & vParametros(0) & "," & vParametros(1) & "," & vParametros(2) & "," & vParametros(3) & "," & vParametros(4) & "," & vParametros(5) & ");"

        ElseIf Funcionalidad = "DesasignaRelOpcionPerfil" Then
            Dim vParametros As String()
            vParametros = LlavePadre.Split("/")
            sql = " Delete from MS_RelFuncionalidadPerfil where ID_PERFIL = " & vParametros(0) & " and ID_SISTEMA = " & vParametros(1) & "  and ID_MENU = " & vParametros(2) & " and ID_SUBMENU = " & vParametros(3) & " and ID_OPCION = " & vParametros(4) & " and  ID_ACCESO = " & vParametros(5) & " ;"

        ElseIf Funcionalidad = "AsignaRelOpcionUsuario" Then
            Dim vParametros As String()
            vParametros = LlavePadre.Split("/")
            sql = " Insert into MS_RelFuncionalidadUsuario(ID_USUARIO, ID_SISTEMA, ID_MENU, ID_SUBMENU, ID_OPCION, ID_ACCESO) values(" & vParametros(0) & "," & vParametros(1) & "," & vParametros(2) & "," & vParametros(3) & "," & vParametros(4) & "," & vParametros(5) & ");"

        ElseIf Funcionalidad = "DesasignaRelOpcionUsuario" Then
            Dim vParametros As String()
            vParametros = LlavePadre.Split("/")
            sql = " Delete from MS_RelFuncionalidadUsuario where ID_USUARIO = " & vParametros(0) & " and ID_SISTEMA = " & vParametros(1) & "  and ID_MENU = " & vParametros(2) & " and ID_SUBMENU = " & vParametros(3) & " and ID_OPCION = " & vParametros(4) & " and  ID_ACCESO = " & vParametros(5) & " ;"

        End If

        Resultado = CInt(Obtendatos.EjecutarEscalar(sql))

        Return Resultado

    End Function





    Public Function ObtenInfCatalogo(ByVal Catalogo As String, ByVal Activos As Integer) As DataSet
        Obtendatos = ServicioDeDatos

        Dim sql As String = ""

        If Catalogo = "MS_CatSistemas" Then
            sql += " select sist.id_sistema as id_sistema,  upper(sist.descripcion) as descripcion,  upper(sist.ruta) as ruta, sist.status as status, upper(nom_status.Nombre) as NombreEstatus, sist.orden as Orden from ms_sistemas sist inner join MS_STATUS nom_status on sist.status = nom_status.ID_STATUS where 1 = 1 and isnull(sist.BorradoLogico,0) = 0 order by sist.Orden "

        ElseIf Catalogo = "MS_EntornosDeDatos" Then
            sql += " 	Select base.ID_Base, "
            sql += "        base.Descripcion, "
            sql += "        base.NombreCorto, "
            sql += "        base.Usuario, "
            sql += "        base.Pass, "
            sql += "        base.status as status, "
            sql += " 	       upper(nom_status.Nombre) as NombreEstatus "
            sql += "    from MS_DB base inner join MS_STATUS nom_status "
            sql += "      on base.status = nom_status.ID_STATUS "
            sql += "   where isnull(base.BorradoLogico,0) = 0 "
            sql += "   order by base.ID_Base "

        ElseIf Catalogo = "MS_CatMenus" Then
            sql += " Select catMen.ID_Menu, "
            sql += "        catMen.Orden, "
            sql += "        catMen.Descripcion, "
            sql += "        catMen.status, "
            sql += " 	   upper(nom_status.Nombre) as NombreEstatus "
            sql += "   From MS_Menus catMen inner join MS_STATUS nom_status "
            sql += "     on catMen.status = nom_status.ID_STATUS "
            sql += "  where isnull(catMen.BorradoLogico,0) = 0 "
            sql += "  order by catMen.Orden "

        ElseIf Catalogo = "MS_CatModulos" Then
            sql += " Select catMen.ID_Modulo, "
            sql += "        catMen.Orden, "
            sql += "        catMen.Descripcion, "
            sql += "        catMen.status, "
            sql += " 	   upper(nom_status.Nombre) as NombreEstatus "
            sql += "   From MS_Modulos catMen inner join MS_STATUS nom_status "
            sql += "     on catMen.status = nom_status.ID_STATUS "
            sql += "  where isnull(catMen.BorradoLogico,0) = 0 "
            sql += "  order by catMen.Orden "

        ElseIf Catalogo = "MS_CatSubmenus" Then
            sql += " Select catMen.ID_Submenu, "
            sql += "        catMen.Orden, "
            sql += "        catMen.Descripcion, "
            sql += "        catMen.status, "
            sql += " 	   upper(nom_status.Nombre) as NombreEstatus "
            sql += "   From MS_Submenus catMen inner join MS_STATUS nom_status "
            sql += "     on catMen.status = nom_status.ID_STATUS "
            sql += "  where isnull(catMen.BorradoLogico,0) = 0 "
            sql += "  order by catMen.Orden "

        ElseIf Catalogo = "MS_CatOpciones" Then
            sql += " Select catOpt.ID_Opcion,"
            sql += "        catOpt.Orden,"
            sql += "        catOpt.Descripcion,"
            sql += "        catOpt.status,"
            sql += " 	    upper(nom_status.Nombre) as NombreEstatus"
            sql += "   From MS_Opciones catOpt inner join MS_STATUS nom_status"
            sql += "     on catOpt.status = nom_status.ID_STATUS "
            sql += "  where isnull(catOpt.BorradoLogico,0) = 0"
            sql += "  order by catOpt.Orden "

        ElseIf Catalogo = "MS_Accesos" Then
            sql += " Select catAcc.ID_Acceso, "
            sql += "        catAcc.Orden, "
            sql += "        catAcc.Descripcion, "
            sql += "        catAcc.status, "
            sql += " 	    upper(nom_status.Nombre) as NombreEstatus "
            sql += "   From MS_Accesos catAcc inner join MS_STATUS nom_status "
            sql += "     on catAcc.status = nom_status.ID_STATUS "
            sql += "  where isnull(catAcc.BorradoLogico,0) = 0 "
            sql += "  order by catAcc.Orden "

        ElseIf Catalogo = "MS_CatPerfiles" Then
            sql += " Select catPer.ID_Perfil, "
            sql += "        catPer.Orden, "
            sql += "        catPer.Descripcion, "
            sql += "        catPer.status, "
            sql += " 	   upper(nom_status.Nombre) as NombreEstatus "
            sql += "   From MS_Perfiles catPer inner join MS_STATUS nom_status "
            sql += "     on catPer.status = nom_status.ID_STATUS "
            sql += "  where isnull(catPer.BorradoLogico,0) = 0 "
            sql += "  order by catPer.Orden "

        ElseIf Catalogo = "MS_RelSistemaMenu" Then
            sql += " Select catPer.ID_Perfil, "
            sql += "        catPer.Orden, "
            sql += "        catPer.Descripcion, "
            sql += "        catPer.status, "
            sql += " 	   upper(nom_status.Nombre) as NombreEstatus "
            sql += "   From MS_Perfiles catPer inner join MS_STATUS nom_status "
            sql += "     on catPer.status = nom_status.ID_STATUS "
            sql += "  where isnull(catPer.BorradoLogico,0) = 0 "
            sql += "  order by catPer.Orden "

        ElseIf Catalogo = "MS_RelSistemaModulo" Then
            sql += " Select catPer.ID_Perfil, "
            sql += "        catPer.Orden, "
            sql += "        catPer.Descripcion, "
            sql += "        catPer.status, "
            sql += " 	    upper(nom_status.Nombre) as NombreEstatus "
            sql += "   From MS_Perfiles catPer inner join MS_STATUS nom_status "
            sql += "     on catPer.status = nom_status.ID_STATUS "
            sql += "  where isnull(catPer.BorradoLogico,0) = 0 "
            sql += "  order by catPer.Orden "

        End If

        Dim dsSrc As New DataSet()

        Obtendatos.LlenarDataSet(sql, dsSrc, "Resultado")

        Return dsSrc
    End Function



    Public Function ActualizaNoDeIntentosUsuarioSistema(ByVal varID_Usuario As Integer, ByVal varID_Sistema As Integer, ByVal Funcionalidad As String) As Integer
        Obtendatos = ServicioDeDatos
        Dim DS As New DataSet
        Dim Resultado As Integer
        Dim sql As String = ""

        If Funcionalidad = "ReseteaContador" Then
            sql += " update MS_UsuarioSistema set intentos = 0, fechaActualizacion = getdate() where id_usuario = " & varID_Usuario & " and id_sistema = " & varID_Sistema & ";"
        Else
            sql += " update MS_UsuarioSistema set intentos = isnull(intentos,0) + 1, fechaActualizacion = getdate() where id_usuario = " & varID_Usuario & " and id_sistema = " & varID_Sistema & ";"
        End If

        Resultado = CInt(Obtendatos.EjecutarEscalar(sql))

        Return Resultado

    End Function


    Public Function ActualizaStatusUsuario(ByVal varID_Usuario As Integer, ByVal varID_Sistema As Integer, ByVal varStatus As Integer, ByVal varFuncionalidad As String) As Integer
        Obtendatos = ServicioDeDatos
        Dim DS As New DataSet
        Dim Resultado As Integer
        Dim sql As String = ""

        If varFuncionalidad = "BloqueaPorIntentosFallidos" Then
            sql += " update MS_UsuarioSistema set StatusUsuarioSistema = " & varStatus & ", fechaActualizacion = getdate() where id_usuario = " & varID_Usuario & " and id_sistema = " & varID_Sistema & ";"

        ElseIf varFuncionalidad = "BloqueaPorCaducidad" Then
            sql += " update MS_Usuarios set Status = " & varStatus & ", fecha_modificacion = getdate() where id_usuario = " & varID_Usuario & ";"

        ElseIf varFuncionalidad = "AccesoCorrecto" Then
            sql += " update MS_Usuarios set fecha_ultimo_acceso = getdate() where id_usuario = " & varID_Usuario & ";"

        End If

        Resultado = CInt(Obtendatos.EjecutarEscalar(sql))

        Return Resultado

    End Function


    Public Function ActualizaPassUsuario(ByVal varID_Usuario As Integer, ByVal varPass As String) As Integer
        Obtendatos = ServicioDeDatos
        Dim DS As New DataSet
        Dim Resultado As Integer
        Dim sql As String = ""

        sql += " update MS_Usuarios set DebeCambiarPassword = 0, password = '" & varPass & "', pass01 = pass02, pass02 = pass03, pass03= '" & varPass & "',  fecha_modificacion = getdate(), fecha_caducidad_clave = dateadd(day, 90, getdate()) where id_usuario = " & varID_Usuario & ";"

        Resultado = CInt(Obtendatos.EjecutarEscalar(sql))

        Return Resultado

    End Function


    Public Function OpObtenMenusUsuario(ByVal usuario As String, ByVal perfilUsuario As Integer, ByVal Id_Sistema As Integer) As DataSet
        Obtendatos = ServicioDeDatos
        Dim DS As New DataSet()
        Dim Consulta As String = ""

        If (usuario = "admin" Or usuario = "administrador" Or usuario = "omedina") Or perfilUsuario = 1 Then
            Consulta += " select men.id_menu as id_menu, "
            Consulta += "        men.descripcion as descripcion, "
            Consulta += "        men.icono_activo as icono_activo, "
            Consulta += "        men.icono_inactivo as icono_inactivo, "
            Consulta += "        men.ToolTip as ToolTip, "
            Consulta += "        men.ruta as ruta, "
            Consulta += "        men.status as status "
            Consulta += "   from ms_menus men "
            Consulta += "  where 1 = 1 "
            Consulta += "    and men.Status = 1 "

            If Id_Sistema <> 0 Then
                Consulta += "   and  men.id_sistema = " & UtileriasNegocio.Utilerias.ValorReal(Id_Sistema, 1)
            End If

            Consulta += "  order by  men.id_menu "
        Else
            Consulta += "   select distinct men.id_menu as id_menu, "
            Consulta += "                   men.descripcion as descripcion, "
            Consulta += "                   men.icono_activo as icono_activo, "
            Consulta += "                   men.icono_inactivo as icono_inactivo, "
            Consulta += "                   men.ToolTip as ToolTip, "
            Consulta += "                   men.ruta as ruta, "
            Consulta += "                   men.status as status "
            Consulta += "              from ms_opcionesmenu om, "
            Consulta += "                   ms_submenus subm, "
            Consulta += "                   ms_menus men "
            Consulta += "             where om.id_submenu = subm.id_submenu "
            Consulta += "               and subm.id_menu = men.id_menu "

            If Id_Sistema <> 0 Then
                Consulta += "               and men.id_sistema = " & UtileriasNegocio.Utilerias.ValorReal(Id_Sistema, 1)
            End If

            Consulta += "               and om.id_opcion in (select id_opcion from MS_RelFuncionalidadUsuario where id_usuario = (select id_usuario from ms_usuarios where usuario =  " & UtileriasNegocio.Utilerias.ValorReal(usuario, 2) & "  )) "
            Consulta += "               and men.status = 1 "
            Consulta += "             order by men.id_menu "
        End If

        Obtendatos.LlenarDataSet(Consulta, DS, "Menus")

        Return DS

    End Function


    Public Function ObtenPassUsuario(ByVal ID_Usuario As Integer) As DataSet
        Obtendatos = ServicioDeDatos
        Dim DS As New DataSet()
        Dim Consulta As String = ""

        Consulta += " Select password, isnull(pass01,'') as pass01, isnull(pass02,'') as pass02, isnull(pass03,'') as pass03 from MS_Usuarios where id_Usuario = " & ID_Usuario & ";"

        Obtendatos.LlenarDataSet(Consulta, DS, "Pass")

        Return DS

    End Function

    Public Function CreaUsuario(ByVal ID_Usuario_SIAN As Object, ByVal Nombre As Object, ByVal Usuario As Object, ByVal ID_Perfil As Object, ByVal Email As Object, ByVal Password As Object, ByVal Usuario_Registro As Object, ByVal Fecha_Inicio As Object, ByVal Fecha_Termino As Object, ByVal Estatus As Object, ByVal DebeCambiarPassword As Object) As Integer
        Dim ResultadoVerifica As Integer = 0
        Dim ResultadoCreaUsuario As Integer = 0
        Dim Resultado As Integer = 0
        Dim ResultadoIDUsuario As Integer = 0
        Dim sql As String = ""

        'Se comprueba que no exista el usuario en la base de datos (Inicio)
        sql = " select count(*) from ms_usuarios where usuario = " & UtileriasNegocio.Utilerias.ValorReal(Usuario.Trim, 2) & " or id_personas = " & ID_Usuario_SIAN
        ResultadoVerifica = 0 'CInt(Obtendatos.EjecutarEscalar(sql))
        'Se comprueba que no exista el usuario en la base de datos (Termino)

        'Si no existe el usuario se inserta (Inicio)
        If ResultadoVerifica = 0 Then
            'Se inserta el nuevo usuario (Inicio)
            sql = ""
            sql += " Insert into MS_Usuarios(ID_Usuario_SIAN,Nombre,Usuario,ID_Perfil,Email,Password,Usuario_Registro,Fecha_Registro,Fecha_Caducidad_Clave,Fecha_Inicio,Fecha_Termino,Estatus,Pass01,DebeCambiarPassword) values("
            sql += "'" & ID_Usuario_SIAN & "',"
            sql += "'" & Nombre & "',"
            sql += "'" & Usuario & "',"
            sql += "" & ID_Perfil & ","
            sql += "'" & IIf(Email = "", "usuarioNuevo@datol.com", Email) & "',"
            sql += "'" & Password & "',"
            sql += "'" & Usuario_Registro & "',"
            sql += "" & "getdate()" & ","
            sql += "" & "DATEADD(month, 1, getdate())" & ","
            sql += "'" & Fecha_Inicio & "',"
            sql += "'" & Fecha_Termino & "',"
            sql += "" & Estatus & ","
            sql += "'" & Password & "',"
            sql += "" & "1" & ");"
            Resultado = CInt(Obtendatos.EjecutarEscalar(sql))
            'Se inserta el nuevo usuario (Termino)

            'Se obtiene el ID de usuario que le fue asignado (Inicio)
            sql = " select id_usuario from ms_usuarios where usuario = " & UtileriasNegocio.Utilerias.ValorReal(Usuario, 2)
            ResultadoIDUsuario = CInt(Obtendatos.EjecutarEscalar(sql))
            'Se obtiene el ID de usuario que le fue asignado (Termino)

            'Se Inserta la funcionalidad de acuerdo al perfil del usuario (Inicio)    
            sql = "insert into MS_RelFuncionalidadUsuario Select " & ResultadoIDUsuario & " As ID_Usuario, ID_Sistema, ID_Menu, ID_Submenu, ID_Opcion, ID_Acceso from MS_RelFuncionalidadPerfil Where ID_Perfil = " & ID_Perfil
            Resultado = CInt(Obtendatos.EjecutarEscalar(sql))
            'Se Inserta la funcionalidad de acuerdo al perfil del usuario (Termino)    

            'Se insertan los servicios de acuerdo al perfil del usuario (Inicio)    
            'sql = " insert into ms_usuariosDB select " & ResultadoIDUsuario & ", id_DB, 'administrador', getdate(), getdate() from sc_DBPerfil where id_perfil = " & id_perfil
            'Resultado = CInt(Obtendatos.EjecutarEscalar(sql))
            'Se Inserta la funcionalidad de acuerdo al perfil del usuario (Termino)    
        Else
            Resultado = -1
        End If
        'Si no existe el usuario se inserta (Termino)

        Return ResultadoIDUsuario

    End Function

    Public Function ActualizaUsuario(ByVal ID_Usuario_SIAN As Object, ByVal Nombre As Object, ByVal Usuario As Object, ByVal ID_Perfil As Object, ByVal Email As Object, ByVal Password As Object, ByVal Usuario_Registro As Object, ByVal Fecha_Inicio As Object, ByVal Fecha_Termino As Object, ByVal Estatus As Object, ByVal DebeCambiarPassword As Object) As Integer
        Dim ResultadoVerifica As Integer = 0
        Dim ResultadoCreaUsuario As Integer = 0
        Dim Resultado As Integer = 0
        Dim ResultadoIDUsuario As Integer = 0
        Dim sql As String = ""

        'Se comprueba que no exista el usuario en la base de datos (Inicio)
        sql = " select count(*) from ms_usuarios where usuario = " & UtileriasNegocio.Utilerias.ValorReal(Usuario.Trim, 2) & " or id_personas = " & ID_Usuario_SIAN
        ResultadoVerifica = 0 'CInt(Obtendatos.EjecutarEscalar(sql))
        'Se comprueba que no exista el usuario en la base de datos (Termino)

        'Si no existe el usuario se inserta (Inicio)
        If ResultadoVerifica = 0 Then
            'Se inserta el nuevo usuario (Inicio)
            sql = ""
            sql += " Update MS_Usuarios Nombre = '" & Nombre & "',Usuario = '" & Usuario & "', ID_Perfil = " & ID_Perfil & ", Email = '" & IIf(Email = "", "usuarioNuevo@datol.com", Email) & "' " & IIf(Password <> "", ", Password = '" & Password & "'", "") & ", Usuario_Registro = '" & Usuario_Registro & "', Fecha_Modificacion = getdate(), Fecha_Inicio = '" & Fecha_Inicio & "', Fecha_Termino = '" & Fecha_Termino & "', Estatus = " & Estatus & " Where Usuario = '" & Usuario & "';"
            Resultado = CInt(Obtendatos.EjecutarEscalar(sql))
            'Se inserta el nuevo usuario (Termino)

            'Se obtiene el ID de usuario que le fue asignado (Inicio)
            sql = " select id_usuario from ms_usuarios where usuario = " & UtileriasNegocio.Utilerias.ValorReal(Usuario, 2)
            ResultadoIDUsuario = CInt(Obtendatos.EjecutarEscalar(sql))
            'Se obtiene el ID de usuario que le fue asignado (Termino)

            'Se Inserta la funcionalidad de acuerdo al perfil del usuario (Inicio)   
            sql = "insert into MS_RelFuncionalidadUsuario Select " & ResultadoIDUsuario & " As ID_Usuario, ID_Sistema, ID_Menu, ID_Submenu, ID_Opcion, ID_Acceso from MS_RelFuncionalidadPerfil Where ID_Perfil = " & ID_Perfil
            Resultado = CInt(Obtendatos.EjecutarEscalar(sql))
            'Se Inserta la funcionalidad de acuerdo al perfil del usuario (Termino)    

            'Se insertan los servicios de acuerdo al perfil del usuario (Inicio)    
            'sql = " insert into ms_usuariosDB select " & ResultadoIDUsuario & ", id_DB, 'administrador', getdate(), getdate() from sc_DBPerfil where id_perfil = " & id_perfil
            'Resultado = CInt(Obtendatos.EjecutarEscalar(sql))
            'Se Inserta la funcionalidad de acuerdo al perfil del usuario (Termino)    
        Else
            Resultado = -1
        End If
        'Si no existe el usuario se inserta (Termino)

        Return ResultadoIDUsuario

    End Function

    Public Function ObtenMenusUsuario(ByVal Usuario As Object, ByVal ID_Usuario As Object, ByVal ID_Sistema As Object, ByVal ID_Modulo As Object) As DataSet
        Obtendatos = ServicioDeDatos
        Dim DS As New DataSet()
        Dim Consulta As String = ""

        If (Usuario = "admin" Or Usuario = "administrador" Or Usuario = "omedina") Then
            Consulta += " select " & ID_Usuario & " as ID_Usuario, "
            Consulta += " " & ID_Sistema & " as ID_Sistema, "
            Consulta += " " & ID_Modulo & " as ID_Modulo, "
            Consulta += " men.id_menu as id_menu, "
            Consulta += " men.nombre as descripcion, "
            Consulta += " men.icono_activo as icono_activo, "
            Consulta += " men.icono_inactivo as icono_inactivo, "
            Consulta += " men.ToolTip as ToolTip, "
            Consulta += " men.ruta as ruta, "
            Consulta += " men.Estatus as Estatus "
            Consulta += "  from ms_menus men "
            Consulta += " where 1 = 1  "
            Consulta += " and men.id_menu in (Select distinct id_menu from MS_RelFuncionalidadUsuario Where ID_Sistema = " & ID_Sistema & " and ID_Modulo = " & ID_Modulo & ") "
            Consulta += " and men.Estatus = 1  "
            Consulta += " and isnull(men.BorradoLogico,0) = 0 "
            Consulta += "order by men.orden "
        Else
            Consulta += " select " & ID_Usuario & " as ID_Usuario, "
            Consulta += " " & ID_Sistema & " as ID_Sistema, "
            Consulta += " " & ID_Modulo & " as ID_Modulo, "
            Consulta += " men.id_menu as id_menu, "
            Consulta += " men.nombre as descripcion, "
            Consulta += " men.icono_activo as icono_activo, "
            Consulta += " men.icono_inactivo as icono_inactivo, "
            Consulta += " men.ToolTip as ToolTip, "
            Consulta += " men.ruta as ruta, "
            Consulta += " men.Estatus as Estatus "
            Consulta += "  from ms_menus men "
            Consulta += " where 1 = 1  "
            Consulta += " and men.id_menu in (Select distinct id_menu from MS_RelFuncionalidadUsuario Where ID_Usuario = " & ID_Usuario & " and ID_Sistema = " & ID_Sistema & " and ID_Modulo = " & ID_Modulo & ") "
            Consulta += " and men.Estatus = 1  "
            Consulta += " and isnull(men.BorradoLogico,0) = 0 "
            Consulta += "order by men.orden "
        End If

        Obtendatos.LlenarDataSet(Consulta, DS, "Menus")

        Return DS

    End Function


    Public Function OpObtenSubmenus(ByVal Usuario As Object, ByVal ID_Usuario As Object, ByVal ID_Sistema As Object, ByVal ID_Modulo As Object, ByVal ID_Menu As Object) As DataSet
        Obtendatos = ServicioDeDatos
        Dim DS As New DataSet()
        Dim Consulta As String = ""

        If (Usuario = "admin" Or Usuario = "administrador" Or Usuario = "omedina") Then
            Consulta += " select " & ID_Usuario & " as ID_Usuario, "
            Consulta += " " & ID_Sistema & " as ID_Sistema, "
            Consulta += " " & ID_Modulo & " as ID_Modulo, "
            Consulta += " " & ID_Menu & " as ID_Menu, "
            Consulta += " submenu.id_submenu as id_submenu, "
            Consulta += " submenu.nombre as descripcion, "
            Consulta += " submenu.icono_activo as icono_activo, "
            Consulta += " submenu.icono_inactivo as icono_inactivo, "
            Consulta += " submenu.ToolTip as ToolTip, "
            Consulta += " submenu.ruta as ruta, "
            Consulta += " submenu.Estatus as Estatus "
            Consulta += " from ms_submenus submenu "
            Consulta += " where 1 = 1 "
            Consulta += " and submenu.id_submenu in (Select distinct id_submenu from MS_RelFuncionalidadUsuario Where ID_Sistema = " & ID_Sistema & " and ID_Modulo = " & ID_Modulo & " and ID_Menu = " & ID_Menu & ") "
            Consulta += " and submenu.Estatus = 1 "
            Consulta += " and isnull(submenu.BorradoLogico,0) = 0 "
            Consulta += " order by submenu.orden "
        Else
            Consulta += " select " & ID_Usuario & " as ID_Usuario, "
            Consulta += " " & ID_Sistema & " as ID_Sistema, "
            Consulta += " " & ID_Modulo & " as ID_Modulo, "
            Consulta += " " & ID_Menu & " as ID_Menu, "
            Consulta += " submenu.id_submenu as id_submenu, "
            Consulta += " submenu.nombre as descripcion, "
            Consulta += " submenu.icono_activo as icono_activo, "
            Consulta += " submenu.icono_inactivo as icono_inactivo, "
            Consulta += " submenu.ToolTip as ToolTip, "
            Consulta += " submenu.ruta as ruta, "
            Consulta += " submenu.Estatus as Estatus "
            Consulta += " from ms_submenus submenu "
            Consulta += " where 1 = 1 "
            Consulta += " and submenu.id_submenu in (Select distinct id_submenu from MS_RelFuncionalidadUsuario Where ID_Usuario = " & ID_Usuario & " and ID_Sistema = " & ID_Sistema & " and ID_Modulo = " & ID_Modulo & " and ID_Menu = " & ID_Menu & ") "
            Consulta += " and submenu.Estatus = 1 "
            Consulta += " and isnull(submenu.BorradoLogico,0) = 0 "
            Consulta += " order by submenu.orden "
        End If

        Obtendatos.LlenarDataSet(Consulta, DS, "Submenus")

        Return DS

    End Function


    Public Function OpObtenOpcionesSubenu(ByVal Usuario As Object, ByVal ID_Usuario As Object, ByVal ID_Sistema As Object, ByVal ID_Modulo As Object, ByVal ID_Menu As Object, ByVal ID_Submenu As Object) As DataSet
        Obtendatos = ServicioDeDatos
        Dim DS As New DataSet()
        Dim Consulta As String = ""

        If (Usuario = "admin" Or Usuario = "administrador" Or Usuario = "omedina") Then
            Consulta += " select " & ID_Usuario & " as ID_Usuario, "
            Consulta += " " & ID_Sistema & " as ID_Sistema, "
            Consulta += " " & ID_Modulo & " as Modulo, "
            Consulta += " " & ID_Menu & " as ID_Menu, "
            Consulta += " " & ID_Submenu & " as ID_Submenu, "
            Consulta += " op.id_opcion as id_opcion, "
            Consulta += " op.nombre as descripcion, "
            Consulta += " op.ToolTip as ToolTip, "
            Consulta += " op.ruta as ruta, "
            Consulta += " op.parametros as parametros "
            Consulta += " from MS_Opciones op "
            Consulta += " where op.id_opcion in (Select distinct id_opcion from MS_RelFuncionalidadUsuario Where ID_Sistema = " & ID_Sistema & " and ID_Modulo = " & ID_Modulo & " and ID_Menu = " & ID_Menu & " and  ID_Submenu = " & ID_Submenu & ")"
            Consulta += " and op.Estatus = 1 "
            Consulta += " and isnull(op.BorradoLogico,0) = 0 "
            Consulta += " order by op.orden "
        Else
            Consulta += " select " & ID_Usuario & " as ID_Usuario, "
            Consulta += " " & ID_Sistema & " as ID_Sistema, "
            Consulta += " " & ID_Modulo & " as Modulo, "
            Consulta += " " & ID_Menu & " as ID_Menu, "
            Consulta += " " & ID_Submenu & " as ID_Submenu, "
            Consulta += " op.id_opcion as id_opcion, "
            Consulta += " op.nombre as descripcion, "
            Consulta += " op.ToolTip as ToolTip, "
            Consulta += " op.ruta as ruta, "
            Consulta += " op.parametros as parametros "
            Consulta += " from MS_Opciones op "
            Consulta += " where op.id_opcion in (Select distinct id_opcion from MS_RelFuncionalidadUsuario Where ID_Usuario = " & ID_Usuario & " and ID_Sistema = " & ID_Sistema & " and ID_Modulo = " & ID_Modulo & " and ID_Menu = " & ID_Menu & " and ID_Submenu = " & ID_Submenu & ")"
            Consulta += " and op.Estatus = 1 "
            Consulta += " and isnull(op.BorradoLogico,0) = 0 "
            Consulta += " order by op.orden "
        End If

        Obtendatos.LlenarDataSet(Consulta, DS, "Opciones")

        Return DS

    End Function

    Public Function OpObtenAccesosOpcionesSubenu(ByVal ID_Usuario As Object, ByVal Usuario As Object, ByVal ID_Sistema As Object, ByVal ID_Menu As Object, ByVal ID_Submenu As Integer, ByVal ID_Opcion As Object) As DataSet
        Obtendatos = ServicioDeDatos
        Dim DS As New DataSet()
        Dim Consulta As String = ""

        If (Usuario = "admin" Or Usuario = "administrador" Or Usuario = "omedina") Then
            Consulta += " select " & ID_Sistema & " as ID_Sistema, "
            Consulta += "" & ID_Menu & " as ID_Menu, "
            Consulta += "" & ID_Submenu & " as ID_Submenu, "
            Consulta += "" & ID_Opcion & " as ID_Opcion, "
            Consulta += " op.ID_Acceso as ID_Acceso, "
            Consulta += " op.Nombre as Nombre"
            Consulta += " from MS_Accesos op "
            Consulta += " where op.ID_Acceso in (Select distinct ID_Acceso from MS_RelFuncionalidadUsuario Where ID_Sistema = " & ID_Sistema & " and ID_Menu = " & ID_Menu & " and ID_Submenu = " & ID_Submenu & " and ID_OPCION = " & ID_Opcion & ")"
            Consulta += " and op.Estatus = 1 "
            Consulta += " order by op.orden "
        Else
            Consulta += " select " & ID_Sistema & " as ID_Sistema, "
            Consulta += "" & ID_Menu & " as ID_Menu, "
            Consulta += "" & ID_Submenu & " as ID_Submenu, "
            Consulta += "" & ID_Opcion & " as ID_Opcion, "
            Consulta += " op.ID_Acceso as ID_Acceso, "
            Consulta += " op.Nombre as Nombre"
            Consulta += " from MS_Accesos op "
            Consulta += " where op.ID_Acceso in (Select distinct ID_Acceso from MS_RelFuncionalidadUsuario Where ID_Usuario = " & ID_Usuario & " and ID_Sistema = " & ID_Sistema & " and ID_Menu = " & ID_Menu & " and ID_Submenu = " & ID_Submenu & " and ID_OPCION = " & ID_Opcion & ")"
            Consulta += " and op.Estatus = 1 "
            Consulta += " order by op.orden "
        End If

        Obtendatos.LlenarDataSet(Consulta, DS, "Accesos")

        Return DS

    End Function


    Public Function OpVerificaAccesosFormulario(ByVal Usuario As Object, ByVal ID_Usuario As Object, ByVal txtFormulario As Object) As DataSet
        Obtendatos = ServicioDeDatos
        Dim DS As New DataSet()
        Dim Consulta As String = ""

        If (Usuario = "admin" Or Usuario = "administrador" Or Usuario = "omedina") Then
            Consulta += "Select rel.ID_Usuario, "
            Consulta += " rel.ID_Sistema, "
            Consulta += " rel.ID_Modulo, "
            Consulta += " rel.ID_Menu, "
            Consulta += " rel.ID_Submenu, "
            Consulta += " rel.ID_Opcion, "
            Consulta += " rel.ID_Acceso, "
            Consulta += " acc.Nombre "
            Consulta += " from MS_RelFuncionalidadUsuario rel inner join MS_Accesos acc "
            Consulta += " on rel.ID_Acceso = acc.ID_Acceso "
            Consulta += " Where rel.ID_Opcion in ( "
            Consulta += " Select ID_Opcion "
            Consulta += " from MS_Opciones "
            Consulta += " Where 1 = 1 "
            Consulta += " and Ruta like '%" & txtFormulario & "%'"
            Consulta += " ) "
        Else
            Consulta += "Select rel.ID_Usuario, "
            Consulta += " rel.ID_Sistema, "
            Consulta += " rel.ID_Modulo, "
            Consulta += " rel.ID_Menu, "
            Consulta += " rel.ID_Submenu, "
            Consulta += " rel.ID_Opcion, "
            Consulta += " rel.ID_Acceso, "
            Consulta += " acc.Nombre "
            Consulta += " from MS_RelFuncionalidadUsuario rel inner join MS_Accesos acc "
            Consulta += " on rel.ID_Acceso = acc.ID_Acceso "
            Consulta += " Where rel.ID_Opcion in ( "
            Consulta += " Select ID_Opcion "
            Consulta += " from MS_Opciones "
            Consulta += " Where 1 = 1 "
            Consulta += " and ID_Usuario = " & ID_Usuario
            Consulta += " and Ruta like '%" & txtFormulario & "%'"
            Consulta += " ) "
        End If

        Obtendatos.LlenarDataSet(Consulta, DS, "Accesos")

        Return DS

    End Function


End Class


