Imports WsSeguridad
Imports System.Data
Imports System.Threading
Imports System.Globalization
Imports System.Diagnostics

Partial Class Framework_Main
    Inherits System.Web.UI.Page
    Public iPagina As String
    Public tmpUsuario As String
    Private Servicio As New WsSeguridad.Seguridad
    Private IntCodBenef As Integer
    Public vSistema As String = System.Configuration.ConfigurationManager.AppSettings.Item("sistema")
    Public vEmpresa As String = System.Configuration.ConfigurationManager.AppSettings.Item("empresa")

    Protected Overrides Sub InitializeCulture()
        If Not Session("sCultura") Is Nothing Then
            UICulture = Session("sCultura").ToString
            Culture = Session("sCultura").ToString
            System.Threading.Thread.CurrentThread.CurrentCulture = System.Globalization.CultureInfo.CreateSpecificCulture(Session("sCultura").ToString)
            System.Threading.Thread.CurrentThread.CurrentUICulture = New System.Globalization.CultureInfo(Session("sCultura").ToString)
        End If
        MyBase.InitializeCulture()
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack And Not GridCallBack.IsCallback Then
            Dim a As String = ""
        End If


        'Dim vCambioDeContrasenia As Object
        'Try
        '    vCambioDeContrasenia = Request.QueryString("C")
        'Catch ex As Exception

        'End Try

        tmpUsuario = Session("sUsuario")

        If Not IsPostBack Then
            If Session("sCliente") Is Nothing Then
                Response.Buffer = True
                Response.Clear()
                Response.Redirect("Acceso.aspx")
            End If
        End If

        initTreeView()

        'Me.TreeView1.SelectedNode = TreeView1.Nodes.Item(0)
        iPagina = "Inicio.aspx"

    End Sub


    Public Sub initTreeView()
        Dim DsModulos As New DataSet
        Dim dtModulos As DataTable
        Dim drModulos As DataRow
        Dim renglonModulo As Int32 = 1
        Dim NodoMenu As ComponentArt.Web.UI.TreeViewNode
        Dim NodoSubmenu As ComponentArt.Web.UI.TreeViewNode
        Dim NodoOpcion As ComponentArt.Web.UI.TreeViewNode
        'Dim NodoHijo As ComponentArt.Web.UI.TreeViewNode

        DsModulos = Servicio.ObtenDataSet("ObtenModulosAsignadosUsuario", Session("iIdUsuario") & "/" & System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
        dtModulos = DsModulos.Tables("Resultado")

        Dim DsMenus As New DataSet
        Dim DsSubmenus As New DataSet
        Dim DsOpciones As New DataSet

        Dim renglonMenu As Integer = 0
        Dim renglonSubmenu As Integer = 0
        Dim renglonOpcion As Integer = 0
        Dim vIdMenu As Integer = 0
        Dim vIdSubmenu As Integer = 0
        Dim vIDModulo As Object = 0
        Dim dtMenus As DataTable
        Dim drMenus As DataRow

        'Funcionalidad que obtiene los menus de acuerdo al usuario
        If DsModulos.Tables.Count > 0 Then
            If DsModulos.Tables(0).Rows.Count > 0 Then
                For Each drModulos In dtModulos.Rows

                    If renglonModulo = 1 Then
                        Me.ColapseModulo01.CollapsedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.ColapseModulo01.ExpandedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.RenglonModulo01.Height = 1
                        Me.RenglonModulo01.Visible = True

                        vIDModulo = CInt(DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("ID_Modulo").ToString.Trim)
                        DsMenus = Servicio.ObtenMenusUsuario(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))

                        dtMenus = DsMenus.Tables("Menus")

                        'Funcionalidad que obtiene los menus de acuerdo al usuario
                        If DsMenus.Tables.Count > 0 Then
                            If DsMenus.Tables(0).Rows.Count > 0 Then
                                For Each drMenus In dtMenus.Rows
                                    NodoMenu = New ComponentArt.Web.UI.TreeViewNode
                                    NodoMenu.Text = DsMenus.Tables("Menus").Rows(renglonMenu)("descripcion").ToString.Trim
                                    NodoMenu.Value = IIf(DsMenus.Tables("Menus").Rows(renglonMenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsMenus.Tables("Menus").Rows(renglonOpcion)("ruta").ToString.Trim)
                                    NodoMenu.ToolTip = DsMenus.Tables("Menus").Rows(renglonMenu)("ToolTip").ToString.Trim
                                    NodoMenu.ImageUrl = DsMenus.Tables("Menus").Rows(renglonMenu)("icono_activo").ToString.Trim
                                    Me.TreeViewModulo01.Nodes.Add(NodoMenu)
                                    vIdMenu = CInt(DsMenus.Tables("Menus").Rows(renglonMenu)("id_menu").ToString.Trim)

                                    'Funcionalidad que obtiene las opciones del casa menu (SUBMENUS)
                                    DsSubmenus = Servicio.OpObtenSubmenus(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                    Dim dtSubmenus As DataTable
                                    Dim drSubmenus As DataRow
                                    dtSubmenus = DsSubmenus.Tables("Submenus")

                                    If DsSubmenus.Tables.Count > 0 Then
                                        If DsSubmenus.Tables(0).Rows.Count > 0 Then
                                            For Each drSubmenus In dtSubmenus.Rows
                                                NodoSubmenu = New ComponentArt.Web.UI.TreeViewNode
                                                NodoSubmenu.Text = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("descripcion").ToString.Trim
                                                NodoSubmenu.Value = IIf(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim)
                                                NodoSubmenu.ToolTip = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ToolTip").ToString.Trim
                                                NodoMenu.Nodes.Add(NodoSubmenu)
                                                vIdSubmenu = CInt(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("id_submenu").ToString.Trim)

                                                'Funcionalidad que obtiene las opciones (OPCIONES)
                                                DsOpciones = Servicio.OpObtenOpcionesSubenu(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, vIdSubmenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                                Dim dtOpciones As DataTable
                                                Dim drOpciones As DataRow
                                                dtOpciones = DsOpciones.Tables("Opciones")

                                                If DsOpciones.Tables.Count > 0 Then
                                                    If DsOpciones.Tables(0).Rows.Count > 0 Then
                                                        For Each drOpciones In dtOpciones.Rows
                                                            NodoOpcion = New ComponentArt.Web.UI.TreeViewNode
                                                            NodoOpcion.Text = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("descripcion").ToString.Trim
                                                            NodoOpcion.Value = IIf(DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim = "", "Inicio.aspx", DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim)
                                                            NodoOpcion.ToolTip = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ToolTip").ToString.Trim
                                                            NodoSubmenu.Nodes.Add(NodoOpcion)

                                                            renglonOpcion = renglonOpcion + 1

                                                        Next drOpciones
                                                    End If
                                                End If

                                                renglonSubmenu = renglonSubmenu + 1
                                                renglonOpcion = 0
                                            Next drSubmenus
                                        End If
                                    End If

                                    'renglonOpcion = renglonOpcion + 1
                                    renglonMenu = renglonMenu + 1
                                    renglonSubmenu = 0
                                Next drMenus
                            End If
                        End If

                    ElseIf renglonModulo = 2 Then
                        Me.ColapseModulo02.CollapsedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.ColapseModulo02.ExpandedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.RenglonModulo02.Height = 1
                        Me.RenglonModulo02.Visible = True

                        renglonMenu = 0
                        renglonSubmenu = 0
                        renglonOpcion = 0

                        vIDModulo = CInt(DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("ID_Modulo").ToString.Trim)
                        DsMenus = Servicio.ObtenMenusUsuario(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))

                        dtMenus = DsMenus.Tables("Menus")

                        'Funcionalidad que obtiene los menus de acuerdo al usuario
                        If DsMenus.Tables.Count > 0 Then
                            If DsMenus.Tables(0).Rows.Count > 0 Then
                                For Each drMenus In dtMenus.Rows
                                    NodoMenu = New ComponentArt.Web.UI.TreeViewNode
                                    NodoMenu.Text = DsMenus.Tables("Menus").Rows(renglonMenu)("descripcion").ToString.Trim
                                    NodoMenu.Value = IIf(DsMenus.Tables("Menus").Rows(renglonMenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsMenus.Tables("Menus").Rows(renglonOpcion)("ruta").ToString.Trim)
                                    NodoMenu.ToolTip = DsMenus.Tables("Menus").Rows(renglonMenu)("ToolTip").ToString.Trim
                                    NodoMenu.ImageUrl = DsMenus.Tables("Menus").Rows(renglonMenu)("icono_activo").ToString.Trim
                                    Me.TreeViewModulo02.Nodes.Add(NodoMenu)
                                    vIdMenu = CInt(DsMenus.Tables("Menus").Rows(renglonMenu)("id_menu").ToString.Trim)

                                    'Funcionalidad que obtiene las opciones del casa menu (SUBMENUS)
                                    DsSubmenus = Servicio.OpObtenSubmenus(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                    Dim dtSubmenus As DataTable
                                    Dim drSubmenus As DataRow
                                    dtSubmenus = DsSubmenus.Tables("Submenus")

                                    If DsSubmenus.Tables.Count > 0 Then
                                        If DsSubmenus.Tables(0).Rows.Count > 0 Then
                                            For Each drSubmenus In dtSubmenus.Rows
                                                NodoSubmenu = New ComponentArt.Web.UI.TreeViewNode
                                                NodoSubmenu.Text = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("descripcion").ToString.Trim
                                                NodoSubmenu.Value = IIf(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim)
                                                NodoSubmenu.ToolTip = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ToolTip").ToString.Trim
                                                NodoMenu.Nodes.Add(NodoSubmenu)
                                                vIdSubmenu = CInt(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("id_submenu").ToString.Trim)

                                                'Funcionalidad que obtiene las opciones (OPCIONES)
                                                DsOpciones = Servicio.OpObtenOpcionesSubenu(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, vIdSubmenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                                Dim dtOpciones As DataTable
                                                Dim drOpciones As DataRow
                                                dtOpciones = DsOpciones.Tables("Opciones")

                                                If DsOpciones.Tables.Count > 0 Then
                                                    If DsOpciones.Tables(0).Rows.Count > 0 Then
                                                        For Each drOpciones In dtOpciones.Rows
                                                            NodoOpcion = New ComponentArt.Web.UI.TreeViewNode
                                                            NodoOpcion.Text = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("descripcion").ToString.Trim
                                                            NodoOpcion.Value = IIf(DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim = "", "Inicio.aspx", DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim)
                                                            NodoOpcion.ToolTip = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ToolTip").ToString.Trim
                                                            NodoSubmenu.Nodes.Add(NodoOpcion)

                                                            renglonOpcion = renglonOpcion + 1

                                                        Next drOpciones
                                                    End If
                                                End If

                                                renglonSubmenu = renglonSubmenu + 1
                                                renglonOpcion = 0
                                            Next drSubmenus
                                        End If
                                    End If

                                    'renglonOpcion = renglonOpcion + 1
                                    renglonMenu = renglonMenu + 1
                                    renglonSubmenu = 0
                                Next drMenus
                            End If
                        End If



                    ElseIf renglonModulo = 3 Then
                        Me.ColapseModulo03.CollapsedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.ColapseModulo03.ExpandedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.RenglonModulo03.Height = 1
                        Me.RenglonModulo03.Visible = True

                        renglonMenu = 0
                        renglonSubmenu = 0
                        renglonOpcion = 0

                        vIDModulo = CInt(DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("ID_Modulo").ToString.Trim)
                        DsMenus = Servicio.ObtenMenusUsuario(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))

                        dtMenus = DsMenus.Tables("Menus")

                        'Funcionalidad que obtiene los menus de acuerdo al usuario
                        If DsMenus.Tables.Count > 0 Then
                            If DsMenus.Tables(0).Rows.Count > 0 Then
                                For Each drMenus In dtMenus.Rows
                                    NodoMenu = New ComponentArt.Web.UI.TreeViewNode
                                    NodoMenu.Text = DsMenus.Tables("Menus").Rows(renglonMenu)("descripcion").ToString.Trim
                                    NodoMenu.Value = IIf(DsMenus.Tables("Menus").Rows(renglonMenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsMenus.Tables("Menus").Rows(renglonOpcion)("ruta").ToString.Trim)
                                    NodoMenu.ToolTip = DsMenus.Tables("Menus").Rows(renglonMenu)("ToolTip").ToString.Trim
                                    NodoMenu.ImageUrl = DsMenus.Tables("Menus").Rows(renglonMenu)("icono_activo").ToString.Trim
                                    Me.TreeViewModulo03.Nodes.Add(NodoMenu)
                                    vIdMenu = CInt(DsMenus.Tables("Menus").Rows(renglonMenu)("id_menu").ToString.Trim)

                                    'Funcionalidad que obtiene las opciones del casa menu (SUBMENUS)
                                    DsSubmenus = Servicio.OpObtenSubmenus(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                    Dim dtSubmenus As DataTable
                                    Dim drSubmenus As DataRow
                                    dtSubmenus = DsSubmenus.Tables("Submenus")

                                    If DsSubmenus.Tables.Count > 0 Then
                                        If DsSubmenus.Tables(0).Rows.Count > 0 Then
                                            For Each drSubmenus In dtSubmenus.Rows
                                                NodoSubmenu = New ComponentArt.Web.UI.TreeViewNode
                                                NodoSubmenu.Text = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("descripcion").ToString.Trim
                                                NodoSubmenu.Value = IIf(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim)
                                                NodoSubmenu.ToolTip = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ToolTip").ToString.Trim
                                                NodoMenu.Nodes.Add(NodoSubmenu)
                                                vIdSubmenu = CInt(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("id_submenu").ToString.Trim)

                                                'Funcionalidad que obtiene las opciones (OPCIONES)
                                                DsOpciones = Servicio.OpObtenOpcionesSubenu(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, vIdSubmenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                                Dim dtOpciones As DataTable
                                                Dim drOpciones As DataRow
                                                dtOpciones = DsOpciones.Tables("Opciones")

                                                If DsOpciones.Tables.Count > 0 Then
                                                    If DsOpciones.Tables(0).Rows.Count > 0 Then
                                                        For Each drOpciones In dtOpciones.Rows
                                                            NodoOpcion = New ComponentArt.Web.UI.TreeViewNode
                                                            NodoOpcion.Text = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("descripcion").ToString.Trim
                                                            NodoOpcion.Value = IIf(DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim = "", "Inicio.aspx", DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim)
                                                            NodoOpcion.ToolTip = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ToolTip").ToString.Trim
                                                            NodoSubmenu.Nodes.Add(NodoOpcion)

                                                            renglonOpcion = renglonOpcion + 1

                                                        Next drOpciones
                                                    End If
                                                End If

                                                renglonSubmenu = renglonSubmenu + 1
                                                renglonOpcion = 0
                                            Next drSubmenus
                                        End If
                                    End If

                                    'renglonOpcion = renglonOpcion + 1
                                    renglonMenu = renglonMenu + 1
                                    renglonSubmenu = 0
                                Next drMenus
                            End If
                        End If

                    ElseIf renglonModulo = 4 Then
                        Me.ColapseModulo04.CollapsedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.ColapseModulo04.ExpandedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.RenglonModulo04.Height = 1
                        Me.RenglonModulo04.Visible = True

                        renglonMenu = 0
                        renglonSubmenu = 0
                        renglonOpcion = 0

                        vIDModulo = CInt(DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("ID_Modulo").ToString.Trim)
                        DsMenus = Servicio.ObtenMenusUsuario(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))

                        dtMenus = DsMenus.Tables("Menus")

                        'Funcionalidad que obtiene los menus de acuerdo al usuario
                        If DsMenus.Tables.Count > 0 Then
                            If DsMenus.Tables(0).Rows.Count > 0 Then
                                For Each drMenus In dtMenus.Rows
                                    NodoMenu = New ComponentArt.Web.UI.TreeViewNode
                                    NodoMenu.Text = DsMenus.Tables("Menus").Rows(renglonMenu)("descripcion").ToString.Trim
                                    NodoMenu.Value = IIf(DsMenus.Tables("Menus").Rows(renglonMenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsMenus.Tables("Menus").Rows(renglonOpcion)("ruta").ToString.Trim)
                                    NodoMenu.ToolTip = DsMenus.Tables("Menus").Rows(renglonMenu)("ToolTip").ToString.Trim
                                    NodoMenu.ImageUrl = DsMenus.Tables("Menus").Rows(renglonMenu)("icono_activo").ToString.Trim
                                    Me.TreeViewModulo04.Nodes.Add(NodoMenu)
                                    vIdMenu = CInt(DsMenus.Tables("Menus").Rows(renglonMenu)("id_menu").ToString.Trim)

                                    'Funcionalidad que obtiene las opciones del casa menu (SUBMENUS)
                                    DsSubmenus = Servicio.OpObtenSubmenus(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                    Dim dtSubmenus As DataTable
                                    Dim drSubmenus As DataRow
                                    dtSubmenus = DsSubmenus.Tables("Submenus")

                                    If DsSubmenus.Tables.Count > 0 Then
                                        If DsSubmenus.Tables(0).Rows.Count > 0 Then
                                            For Each drSubmenus In dtSubmenus.Rows
                                                NodoSubmenu = New ComponentArt.Web.UI.TreeViewNode
                                                NodoSubmenu.Text = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("descripcion").ToString.Trim
                                                NodoSubmenu.Value = IIf(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim)
                                                NodoSubmenu.ToolTip = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ToolTip").ToString.Trim
                                                NodoMenu.Nodes.Add(NodoSubmenu)
                                                vIdSubmenu = CInt(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("id_submenu").ToString.Trim)

                                                'Funcionalidad que obtiene las opciones (OPCIONES)
                                                DsOpciones = Servicio.OpObtenOpcionesSubenu(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, vIdSubmenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                                Dim dtOpciones As DataTable
                                                Dim drOpciones As DataRow
                                                dtOpciones = DsOpciones.Tables("Opciones")

                                                If DsOpciones.Tables.Count > 0 Then
                                                    If DsOpciones.Tables(0).Rows.Count > 0 Then
                                                        For Each drOpciones In dtOpciones.Rows
                                                            NodoOpcion = New ComponentArt.Web.UI.TreeViewNode
                                                            NodoOpcion.Text = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("descripcion").ToString.Trim
                                                            NodoOpcion.Value = IIf(DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim = "", "Inicio.aspx", DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim)
                                                            NodoOpcion.ToolTip = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ToolTip").ToString.Trim
                                                            NodoSubmenu.Nodes.Add(NodoOpcion)

                                                            renglonOpcion = renglonOpcion + 1

                                                        Next drOpciones
                                                    End If
                                                End If

                                                renglonSubmenu = renglonSubmenu + 1
                                                renglonOpcion = 0
                                            Next drSubmenus
                                        End If
                                    End If

                                    'renglonOpcion = renglonOpcion + 1
                                    renglonMenu = renglonMenu + 1
                                    renglonSubmenu = 0
                                Next drMenus
                            End If
                        End If

                    ElseIf renglonModulo = 5 Then
                        Me.ColapseModulo05.CollapsedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.ColapseModulo05.ExpandedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.RenglonModulo05.Height = 1
                        Me.RenglonModulo05.Visible = True

                        renglonMenu = 0
                        renglonSubmenu = 0
                        renglonOpcion = 0

                        vIDModulo = CInt(DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("ID_Modulo").ToString.Trim)
                        DsMenus = Servicio.ObtenMenusUsuario(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))

                        dtMenus = DsMenus.Tables("Menus")

                        'Funcionalidad que obtiene los menus de acuerdo al usuario
                        If DsMenus.Tables.Count > 0 Then
                            If DsMenus.Tables(0).Rows.Count > 0 Then
                                For Each drMenus In dtMenus.Rows
                                    NodoMenu = New ComponentArt.Web.UI.TreeViewNode
                                    NodoMenu.Text = DsMenus.Tables("Menus").Rows(renglonMenu)("descripcion").ToString.Trim
                                    NodoMenu.Value = IIf(DsMenus.Tables("Menus").Rows(renglonMenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsMenus.Tables("Menus").Rows(renglonOpcion)("ruta").ToString.Trim)
                                    NodoMenu.ToolTip = DsMenus.Tables("Menus").Rows(renglonMenu)("ToolTip").ToString.Trim
                                    NodoMenu.ImageUrl = DsMenus.Tables("Menus").Rows(renglonMenu)("icono_activo").ToString.Trim
                                    Me.TreeViewModulo05.Nodes.Add(NodoMenu)
                                    vIdMenu = CInt(DsMenus.Tables("Menus").Rows(renglonMenu)("id_menu").ToString.Trim)

                                    'Funcionalidad que obtiene las opciones del casa menu (SUBMENUS)
                                    DsSubmenus = Servicio.OpObtenSubmenus(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                    Dim dtSubmenus As DataTable
                                    Dim drSubmenus As DataRow
                                    dtSubmenus = DsSubmenus.Tables("Submenus")

                                    If DsSubmenus.Tables.Count > 0 Then
                                        If DsSubmenus.Tables(0).Rows.Count > 0 Then
                                            For Each drSubmenus In dtSubmenus.Rows
                                                NodoSubmenu = New ComponentArt.Web.UI.TreeViewNode
                                                NodoSubmenu.Text = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("descripcion").ToString.Trim
                                                NodoSubmenu.Value = IIf(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim)
                                                NodoSubmenu.ToolTip = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ToolTip").ToString.Trim
                                                NodoMenu.Nodes.Add(NodoSubmenu)
                                                vIdSubmenu = CInt(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("id_submenu").ToString.Trim)

                                                'Funcionalidad que obtiene las opciones (OPCIONES)
                                                DsOpciones = Servicio.OpObtenOpcionesSubenu(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, vIdSubmenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                                Dim dtOpciones As DataTable
                                                Dim drOpciones As DataRow
                                                dtOpciones = DsOpciones.Tables("Opciones")

                                                If DsOpciones.Tables.Count > 0 Then
                                                    If DsOpciones.Tables(0).Rows.Count > 0 Then
                                                        For Each drOpciones In dtOpciones.Rows
                                                            NodoOpcion = New ComponentArt.Web.UI.TreeViewNode
                                                            NodoOpcion.Text = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("descripcion").ToString.Trim
                                                            NodoOpcion.Value = IIf(DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim = "", "Inicio.aspx", DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim)
                                                            NodoOpcion.ToolTip = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ToolTip").ToString.Trim
                                                            NodoSubmenu.Nodes.Add(NodoOpcion)

                                                            renglonOpcion = renglonOpcion + 1

                                                        Next drOpciones
                                                    End If
                                                End If

                                                renglonSubmenu = renglonSubmenu + 1
                                                renglonOpcion = 0
                                            Next drSubmenus
                                        End If
                                    End If

                                    'renglonOpcion = renglonOpcion + 1
                                    renglonMenu = renglonMenu + 1
                                    renglonSubmenu = 0
                                Next drMenus
                            End If
                        End If

                    ElseIf renglonModulo = 6 Then
                        Me.ColapseModulo06.CollapsedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.ColapseModulo06.ExpandedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.RenglonModulo06.Height = 1
                        Me.RenglonModulo06.Visible = True

                        renglonMenu = 0
                        renglonSubmenu = 0
                        renglonOpcion = 0

                        vIDModulo = CInt(DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("ID_Modulo").ToString.Trim)
                        DsMenus = Servicio.ObtenMenusUsuario(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))

                        dtMenus = DsMenus.Tables("Menus")

                        'Funcionalidad que obtiene los menus de acuerdo al usuario
                        If DsMenus.Tables.Count > 0 Then
                            If DsMenus.Tables(0).Rows.Count > 0 Then
                                For Each drMenus In dtMenus.Rows
                                    NodoMenu = New ComponentArt.Web.UI.TreeViewNode
                                    NodoMenu.Text = DsMenus.Tables("Menus").Rows(renglonMenu)("descripcion").ToString.Trim
                                    NodoMenu.Value = IIf(DsMenus.Tables("Menus").Rows(renglonMenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsMenus.Tables("Menus").Rows(renglonOpcion)("ruta").ToString.Trim)
                                    NodoMenu.ToolTip = DsMenus.Tables("Menus").Rows(renglonMenu)("ToolTip").ToString.Trim
                                    NodoMenu.ImageUrl = DsMenus.Tables("Menus").Rows(renglonMenu)("icono_activo").ToString.Trim
                                    Me.TreeViewModulo06.Nodes.Add(NodoMenu)
                                    vIdMenu = CInt(DsMenus.Tables("Menus").Rows(renglonMenu)("id_menu").ToString.Trim)

                                    'Funcionalidad que obtiene las opciones del casa menu (SUBMENUS)
                                    DsSubmenus = Servicio.OpObtenSubmenus(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                    Dim dtSubmenus As DataTable
                                    Dim drSubmenus As DataRow
                                    dtSubmenus = DsSubmenus.Tables("Submenus")

                                    If DsSubmenus.Tables.Count > 0 Then
                                        If DsSubmenus.Tables(0).Rows.Count > 0 Then
                                            For Each drSubmenus In dtSubmenus.Rows
                                                NodoSubmenu = New ComponentArt.Web.UI.TreeViewNode
                                                NodoSubmenu.Text = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("descripcion").ToString.Trim
                                                NodoSubmenu.Value = IIf(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim)
                                                NodoSubmenu.ToolTip = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ToolTip").ToString.Trim
                                                NodoMenu.Nodes.Add(NodoSubmenu)
                                                vIdSubmenu = CInt(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("id_submenu").ToString.Trim)

                                                'Funcionalidad que obtiene las opciones (OPCIONES)
                                                DsOpciones = Servicio.OpObtenOpcionesSubenu(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, vIdSubmenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                                Dim dtOpciones As DataTable
                                                Dim drOpciones As DataRow
                                                dtOpciones = DsOpciones.Tables("Opciones")

                                                If DsOpciones.Tables.Count > 0 Then
                                                    If DsOpciones.Tables(0).Rows.Count > 0 Then
                                                        For Each drOpciones In dtOpciones.Rows
                                                            NodoOpcion = New ComponentArt.Web.UI.TreeViewNode
                                                            NodoOpcion.Text = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("descripcion").ToString.Trim
                                                            NodoOpcion.Value = IIf(DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim = "", "Inicio.aspx", DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim)
                                                            NodoOpcion.ToolTip = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ToolTip").ToString.Trim
                                                            NodoSubmenu.Nodes.Add(NodoOpcion)

                                                            renglonOpcion = renglonOpcion + 1

                                                        Next drOpciones
                                                    End If
                                                End If

                                                renglonSubmenu = renglonSubmenu + 1
                                                renglonOpcion = 0
                                            Next drSubmenus
                                        End If
                                    End If

                                    'renglonOpcion = renglonOpcion + 1
                                    renglonMenu = renglonMenu + 1
                                    renglonSubmenu = 0
                                Next drMenus
                            End If
                        End If

                    ElseIf renglonModulo = 7 Then
                        Me.ColapseModulo07.CollapsedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.ColapseModulo07.ExpandedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.RenglonModulo07.Height = 1
                        Me.RenglonModulo07.Visible = True

                        renglonMenu = 0
                        renglonSubmenu = 0
                        renglonOpcion = 0

                        vIDModulo = CInt(DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("ID_Modulo").ToString.Trim)
                        DsMenus = Servicio.ObtenMenusUsuario(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))

                        dtMenus = DsMenus.Tables("Menus")

                        'Funcionalidad que obtiene los menus de acuerdo al usuario
                        If DsMenus.Tables.Count > 0 Then
                            If DsMenus.Tables(0).Rows.Count > 0 Then
                                For Each drMenus In dtMenus.Rows
                                    NodoMenu = New ComponentArt.Web.UI.TreeViewNode
                                    NodoMenu.Text = DsMenus.Tables("Menus").Rows(renglonMenu)("descripcion").ToString.Trim
                                    NodoMenu.Value = IIf(DsMenus.Tables("Menus").Rows(renglonMenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsMenus.Tables("Menus").Rows(renglonOpcion)("ruta").ToString.Trim)
                                    NodoMenu.ToolTip = DsMenus.Tables("Menus").Rows(renglonMenu)("ToolTip").ToString.Trim
                                    NodoMenu.ImageUrl = DsMenus.Tables("Menus").Rows(renglonMenu)("icono_activo").ToString.Trim
                                    Me.TreeViewModulo07.Nodes.Add(NodoMenu)
                                    vIdMenu = CInt(DsMenus.Tables("Menus").Rows(renglonMenu)("id_menu").ToString.Trim)

                                    'Funcionalidad que obtiene las opciones del casa menu (SUBMENUS)
                                    DsSubmenus = Servicio.OpObtenSubmenus(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                    Dim dtSubmenus As DataTable
                                    Dim drSubmenus As DataRow
                                    dtSubmenus = DsSubmenus.Tables("Submenus")

                                    If DsSubmenus.Tables.Count > 0 Then
                                        If DsSubmenus.Tables(0).Rows.Count > 0 Then
                                            For Each drSubmenus In dtSubmenus.Rows
                                                NodoSubmenu = New ComponentArt.Web.UI.TreeViewNode
                                                NodoSubmenu.Text = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("descripcion").ToString.Trim
                                                NodoSubmenu.Value = IIf(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim)
                                                NodoSubmenu.ToolTip = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ToolTip").ToString.Trim
                                                NodoMenu.Nodes.Add(NodoSubmenu)
                                                vIdSubmenu = CInt(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("id_submenu").ToString.Trim)

                                                'Funcionalidad que obtiene las opciones (OPCIONES)
                                                DsOpciones = Servicio.OpObtenOpcionesSubenu(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, vIdSubmenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                                Dim dtOpciones As DataTable
                                                Dim drOpciones As DataRow
                                                dtOpciones = DsOpciones.Tables("Opciones")

                                                If DsOpciones.Tables.Count > 0 Then
                                                    If DsOpciones.Tables(0).Rows.Count > 0 Then
                                                        For Each drOpciones In dtOpciones.Rows
                                                            NodoOpcion = New ComponentArt.Web.UI.TreeViewNode
                                                            NodoOpcion.Text = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("descripcion").ToString.Trim
                                                            NodoOpcion.Value = IIf(DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim = "", "Inicio.aspx", DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim)
                                                            NodoOpcion.ToolTip = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ToolTip").ToString.Trim
                                                            NodoSubmenu.Nodes.Add(NodoOpcion)

                                                            renglonOpcion = renglonOpcion + 1

                                                        Next drOpciones
                                                    End If
                                                End If

                                                renglonSubmenu = renglonSubmenu + 1
                                                renglonOpcion = 0
                                            Next drSubmenus
                                        End If
                                    End If

                                    'renglonOpcion = renglonOpcion + 1
                                    renglonMenu = renglonMenu + 1
                                    renglonSubmenu = 0
                                Next drMenus
                            End If
                        End If

                    ElseIf renglonModulo = 8 Then
                        Me.ColapseModulo08.CollapsedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.ColapseModulo08.ExpandedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.RenglonModulo08.Height = 1
                        Me.RenglonModulo08.Visible = True

                        renglonMenu = 0
                        renglonSubmenu = 0
                        renglonOpcion = 0

                        vIDModulo = CInt(DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("ID_Modulo").ToString.Trim)
                        DsMenus = Servicio.ObtenMenusUsuario(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))

                        dtMenus = DsMenus.Tables("Menus")

                        'Funcionalidad que obtiene los menus de acuerdo al usuario
                        If DsMenus.Tables.Count > 0 Then
                            If DsMenus.Tables(0).Rows.Count > 0 Then
                                For Each drMenus In dtMenus.Rows
                                    NodoMenu = New ComponentArt.Web.UI.TreeViewNode
                                    NodoMenu.Text = DsMenus.Tables("Menus").Rows(renglonMenu)("descripcion").ToString.Trim
                                    NodoMenu.Value = IIf(DsMenus.Tables("Menus").Rows(renglonMenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsMenus.Tables("Menus").Rows(renglonOpcion)("ruta").ToString.Trim)
                                    NodoMenu.ToolTip = DsMenus.Tables("Menus").Rows(renglonMenu)("ToolTip").ToString.Trim
                                    NodoMenu.ImageUrl = DsMenus.Tables("Menus").Rows(renglonMenu)("icono_activo").ToString.Trim
                                    Me.TreeViewModulo08.Nodes.Add(NodoMenu)
                                    vIdMenu = CInt(DsMenus.Tables("Menus").Rows(renglonMenu)("id_menu").ToString.Trim)

                                    'Funcionalidad que obtiene las opciones del casa menu (SUBMENUS)
                                    DsSubmenus = Servicio.OpObtenSubmenus(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                    Dim dtSubmenus As DataTable
                                    Dim drSubmenus As DataRow
                                    dtSubmenus = DsSubmenus.Tables("Submenus")

                                    If DsSubmenus.Tables.Count > 0 Then
                                        If DsSubmenus.Tables(0).Rows.Count > 0 Then
                                            For Each drSubmenus In dtSubmenus.Rows
                                                NodoSubmenu = New ComponentArt.Web.UI.TreeViewNode
                                                NodoSubmenu.Text = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("descripcion").ToString.Trim
                                                NodoSubmenu.Value = IIf(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim)
                                                NodoSubmenu.ToolTip = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ToolTip").ToString.Trim
                                                NodoMenu.Nodes.Add(NodoSubmenu)
                                                vIdSubmenu = CInt(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("id_submenu").ToString.Trim)

                                                'Funcionalidad que obtiene las opciones (OPCIONES)
                                                DsOpciones = Servicio.OpObtenOpcionesSubenu(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, vIdSubmenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                                Dim dtOpciones As DataTable
                                                Dim drOpciones As DataRow
                                                dtOpciones = DsOpciones.Tables("Opciones")

                                                If DsOpciones.Tables.Count > 0 Then
                                                    If DsOpciones.Tables(0).Rows.Count > 0 Then
                                                        For Each drOpciones In dtOpciones.Rows
                                                            NodoOpcion = New ComponentArt.Web.UI.TreeViewNode
                                                            NodoOpcion.Text = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("descripcion").ToString.Trim
                                                            NodoOpcion.Value = IIf(DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim = "", "Inicio.aspx", DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim)
                                                            NodoOpcion.ToolTip = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ToolTip").ToString.Trim
                                                            NodoSubmenu.Nodes.Add(NodoOpcion)

                                                            renglonOpcion = renglonOpcion + 1

                                                        Next drOpciones
                                                    End If
                                                End If

                                                renglonSubmenu = renglonSubmenu + 1
                                                renglonOpcion = 0
                                            Next drSubmenus
                                        End If
                                    End If

                                    'renglonOpcion = renglonOpcion + 1
                                    renglonMenu = renglonMenu + 1
                                    renglonSubmenu = 0
                                Next drMenus
                            End If
                        End If

                    ElseIf renglonModulo = 9 Then
                        Me.ColapseModulo09.CollapsedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.ColapseModulo09.ExpandedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.RenglonModulo09.Height = 1
                        Me.RenglonModulo09.Visible = True

                        renglonMenu = 0
                        renglonSubmenu = 0
                        renglonOpcion = 0

                        vIDModulo = CInt(DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("ID_Modulo").ToString.Trim)
                        DsMenus = Servicio.ObtenMenusUsuario(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))

                        dtMenus = DsMenus.Tables("Menus")

                        'Funcionalidad que obtiene los menus de acuerdo al usuario
                        If DsMenus.Tables.Count > 0 Then
                            If DsMenus.Tables(0).Rows.Count > 0 Then
                                For Each drMenus In dtMenus.Rows
                                    NodoMenu = New ComponentArt.Web.UI.TreeViewNode
                                    NodoMenu.Text = DsMenus.Tables("Menus").Rows(renglonMenu)("descripcion").ToString.Trim
                                    NodoMenu.Value = IIf(DsMenus.Tables("Menus").Rows(renglonMenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsMenus.Tables("Menus").Rows(renglonOpcion)("ruta").ToString.Trim)
                                    NodoMenu.ToolTip = DsMenus.Tables("Menus").Rows(renglonMenu)("ToolTip").ToString.Trim
                                    NodoMenu.ImageUrl = DsMenus.Tables("Menus").Rows(renglonMenu)("icono_activo").ToString.Trim
                                    Me.TreeViewModulo09.Nodes.Add(NodoMenu)
                                    vIdMenu = CInt(DsMenus.Tables("Menus").Rows(renglonMenu)("id_menu").ToString.Trim)

                                    'Funcionalidad que obtiene las opciones del casa menu (SUBMENUS)
                                    DsSubmenus = Servicio.OpObtenSubmenus(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                    Dim dtSubmenus As DataTable
                                    Dim drSubmenus As DataRow
                                    dtSubmenus = DsSubmenus.Tables("Submenus")

                                    If DsSubmenus.Tables.Count > 0 Then
                                        If DsSubmenus.Tables(0).Rows.Count > 0 Then
                                            For Each drSubmenus In dtSubmenus.Rows
                                                NodoSubmenu = New ComponentArt.Web.UI.TreeViewNode
                                                NodoSubmenu.Text = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("descripcion").ToString.Trim
                                                NodoSubmenu.Value = IIf(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim)
                                                NodoSubmenu.ToolTip = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ToolTip").ToString.Trim
                                                NodoMenu.Nodes.Add(NodoSubmenu)
                                                vIdSubmenu = CInt(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("id_submenu").ToString.Trim)

                                                'Funcionalidad que obtiene las opciones (OPCIONES)
                                                DsOpciones = Servicio.OpObtenOpcionesSubenu(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, vIdSubmenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                                Dim dtOpciones As DataTable
                                                Dim drOpciones As DataRow
                                                dtOpciones = DsOpciones.Tables("Opciones")

                                                If DsOpciones.Tables.Count > 0 Then
                                                    If DsOpciones.Tables(0).Rows.Count > 0 Then
                                                        For Each drOpciones In dtOpciones.Rows
                                                            NodoOpcion = New ComponentArt.Web.UI.TreeViewNode
                                                            NodoOpcion.Text = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("descripcion").ToString.Trim
                                                            NodoOpcion.Value = IIf(DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim = "", "Inicio.aspx", DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim)
                                                            NodoOpcion.ToolTip = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ToolTip").ToString.Trim
                                                            NodoSubmenu.Nodes.Add(NodoOpcion)

                                                            renglonOpcion = renglonOpcion + 1

                                                        Next drOpciones
                                                    End If
                                                End If

                                                renglonSubmenu = renglonSubmenu + 1
                                                renglonOpcion = 0
                                            Next drSubmenus
                                        End If
                                    End If

                                    'renglonOpcion = renglonOpcion + 1
                                    renglonMenu = renglonMenu + 1
                                    renglonSubmenu = 0
                                Next drMenus
                            End If
                        End If

                    ElseIf renglonModulo = 10 Then
                        Me.ColapseModulo10.CollapsedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.ColapseModulo10.ExpandedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.RenglonModulo10.Height = 1
                        Me.RenglonModulo10.Visible = True

                        renglonMenu = 0
                        renglonSubmenu = 0
                        renglonOpcion = 0

                        vIDModulo = CInt(DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("ID_Modulo").ToString.Trim)
                        DsMenus = Servicio.ObtenMenusUsuario(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))

                        dtMenus = DsMenus.Tables("Menus")

                        'Funcionalidad que obtiene los menus de acuerdo al usuario
                        If DsMenus.Tables.Count > 0 Then
                            If DsMenus.Tables(0).Rows.Count > 0 Then
                                For Each drMenus In dtMenus.Rows
                                    NodoMenu = New ComponentArt.Web.UI.TreeViewNode
                                    NodoMenu.Text = DsMenus.Tables("Menus").Rows(renglonMenu)("descripcion").ToString.Trim
                                    NodoMenu.Value = IIf(DsMenus.Tables("Menus").Rows(renglonMenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsMenus.Tables("Menus").Rows(renglonOpcion)("ruta").ToString.Trim)
                                    NodoMenu.ToolTip = DsMenus.Tables("Menus").Rows(renglonMenu)("ToolTip").ToString.Trim
                                    NodoMenu.ImageUrl = DsMenus.Tables("Menus").Rows(renglonMenu)("icono_activo").ToString.Trim
                                    Me.TreeViewModulo10.Nodes.Add(NodoMenu)
                                    vIdMenu = CInt(DsMenus.Tables("Menus").Rows(renglonMenu)("id_menu").ToString.Trim)

                                    'Funcionalidad que obtiene las opciones del casa menu (SUBMENUS)
                                    DsSubmenus = Servicio.OpObtenSubmenus(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                    Dim dtSubmenus As DataTable
                                    Dim drSubmenus As DataRow
                                    dtSubmenus = DsSubmenus.Tables("Submenus")

                                    If DsSubmenus.Tables.Count > 0 Then
                                        If DsSubmenus.Tables(0).Rows.Count > 0 Then
                                            For Each drSubmenus In dtSubmenus.Rows
                                                NodoSubmenu = New ComponentArt.Web.UI.TreeViewNode
                                                NodoSubmenu.Text = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("descripcion").ToString.Trim
                                                NodoSubmenu.Value = IIf(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim)
                                                NodoSubmenu.ToolTip = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ToolTip").ToString.Trim
                                                NodoMenu.Nodes.Add(NodoSubmenu)
                                                vIdSubmenu = CInt(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("id_submenu").ToString.Trim)

                                                'Funcionalidad que obtiene las opciones (OPCIONES)
                                                DsOpciones = Servicio.OpObtenOpcionesSubenu(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, vIdSubmenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                                Dim dtOpciones As DataTable
                                                Dim drOpciones As DataRow
                                                dtOpciones = DsOpciones.Tables("Opciones")

                                                If DsOpciones.Tables.Count > 0 Then
                                                    If DsOpciones.Tables(0).Rows.Count > 0 Then
                                                        For Each drOpciones In dtOpciones.Rows
                                                            NodoOpcion = New ComponentArt.Web.UI.TreeViewNode
                                                            NodoOpcion.Text = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("descripcion").ToString.Trim
                                                            NodoOpcion.Value = IIf(DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim = "", "Inicio.aspx", DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim)
                                                            NodoOpcion.ToolTip = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ToolTip").ToString.Trim
                                                            NodoSubmenu.Nodes.Add(NodoOpcion)

                                                            renglonOpcion = renglonOpcion + 1

                                                        Next drOpciones
                                                    End If
                                                End If

                                                renglonSubmenu = renglonSubmenu + 1
                                                renglonOpcion = 0
                                            Next drSubmenus
                                        End If
                                    End If

                                    'renglonOpcion = renglonOpcion + 1
                                    renglonMenu = renglonMenu + 1
                                    renglonSubmenu = 0
                                Next drMenus
                            End If
                        End If

                    ElseIf renglonModulo = 11 Then
                        Me.ColapseModulo11.CollapsedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.ColapseModulo11.ExpandedText = DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("Nombre").ToString.Trim()
                        Me.RenglonModulo11.Height = 1
                        Me.RenglonModulo11.Visible = True

                        renglonMenu = 0
                        renglonSubmenu = 0
                        renglonOpcion = 0

                        vIDModulo = CInt(DsModulos.Tables("Resultado").Rows(renglonModulo - 1)("ID_Modulo").ToString.Trim)
                        DsMenus = Servicio.ObtenMenusUsuario(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))

                        dtMenus = DsMenus.Tables("Menus")

                        'Funcionalidad que obtiene los menus de acuerdo al usuario
                        If DsMenus.Tables.Count > 0 Then
                            If DsMenus.Tables(0).Rows.Count > 0 Then
                                For Each drMenus In dtMenus.Rows
                                    NodoMenu = New ComponentArt.Web.UI.TreeViewNode
                                    NodoMenu.Text = DsMenus.Tables("Menus").Rows(renglonMenu)("descripcion").ToString.Trim
                                    NodoMenu.Value = IIf(DsMenus.Tables("Menus").Rows(renglonMenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsMenus.Tables("Menus").Rows(renglonOpcion)("ruta").ToString.Trim)
                                    NodoMenu.ToolTip = DsMenus.Tables("Menus").Rows(renglonMenu)("ToolTip").ToString.Trim
                                    NodoMenu.ImageUrl = DsMenus.Tables("Menus").Rows(renglonMenu)("icono_activo").ToString.Trim
                                    Me.TreeViewModulo11.Nodes.Add(NodoMenu)
                                    vIdMenu = CInt(DsMenus.Tables("Menus").Rows(renglonMenu)("id_menu").ToString.Trim)

                                    'Funcionalidad que obtiene las opciones del casa menu (SUBMENUS)
                                    DsSubmenus = Servicio.OpObtenSubmenus(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                    Dim dtSubmenus As DataTable
                                    Dim drSubmenus As DataRow
                                    dtSubmenus = DsSubmenus.Tables("Submenus")

                                    If DsSubmenus.Tables.Count > 0 Then
                                        If DsSubmenus.Tables(0).Rows.Count > 0 Then
                                            For Each drSubmenus In dtSubmenus.Rows
                                                NodoSubmenu = New ComponentArt.Web.UI.TreeViewNode
                                                NodoSubmenu.Text = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("descripcion").ToString.Trim
                                                NodoSubmenu.Value = IIf(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim = "", "Inicio.aspx", DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ruta").ToString.Trim)
                                                NodoSubmenu.ToolTip = DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("ToolTip").ToString.Trim
                                                NodoMenu.Nodes.Add(NodoSubmenu)
                                                vIdSubmenu = CInt(DsSubmenus.Tables("Submenus").Rows(renglonSubmenu)("id_submenu").ToString.Trim)

                                                'Funcionalidad que obtiene las opciones (OPCIONES)
                                                DsOpciones = Servicio.OpObtenOpcionesSubenu(Session("sUsuario"), Session("iIdUsuario"), System.Configuration.ConfigurationManager.AppSettings.Item("ID_Sistema"), vIDModulo, vIdMenu, vIdSubmenu, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
                                                Dim dtOpciones As DataTable
                                                Dim drOpciones As DataRow
                                                dtOpciones = DsOpciones.Tables("Opciones")

                                                If DsOpciones.Tables.Count > 0 Then
                                                    If DsOpciones.Tables(0).Rows.Count > 0 Then
                                                        For Each drOpciones In dtOpciones.Rows
                                                            NodoOpcion = New ComponentArt.Web.UI.TreeViewNode
                                                            NodoOpcion.Text = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("descripcion").ToString.Trim
                                                            NodoOpcion.Value = IIf(DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim = "", "Inicio.aspx", DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ruta").ToString.Trim)
                                                            NodoOpcion.ToolTip = DsOpciones.Tables("Opciones").Rows(renglonOpcion)("ToolTip").ToString.Trim
                                                            NodoSubmenu.Nodes.Add(NodoOpcion)

                                                            renglonOpcion = renglonOpcion + 1

                                                        Next drOpciones
                                                    End If
                                                End If

                                                renglonSubmenu = renglonSubmenu + 1
                                                renglonOpcion = 0
                                            Next drSubmenus
                                        End If
                                    End If

                                    'renglonOpcion = renglonOpcion + 1
                                    renglonMenu = renglonMenu + 1
                                    renglonSubmenu = 0
                                Next drMenus
                            End If
                        End If

                    End If

                    renglonModulo = renglonModulo + 1

                Next drModulos
            End If
        End If


        'NodoMenu = New ComponentArt.Web.UI.TreeViewNode
        'NodoMenu.Text = "Cambio de Contraseña"
        'NodoMenu.Value = "CambiaContrasenia.aspx"
        'NodoMenu.ToolTip = "Cambio de Contraseña"
        'Me.TreeViewModulo11.Nodes.Add(NodoMenu)

        'NodoMenu = New ComponentArt.Web.UI.TreeViewNode
        'NodoMenu.Text = "Salir"
        'NodoMenu.Value = "Salir.aspx"
        'NodoMenu.ToolTip = "Cerrar Sesión"
        'NodoMenu.ImageUrl = "../Imagenes/cerrar_sesion.png"
        'Me.TreeViewModulo11.Nodes.Add(NodoMenu)

    End Sub

    Protected Sub GridCallBack_Callback(ByVal sender As Object, ByVal e As ComponentArt.Web.UI.CallBackEventArgs) Handles GridCallBack.Callback
        iPagina = e.Parameter
        Dim vPagina As String = e.Parameters(0)

        If vPagina = "Salir.aspx" Then
            Session("sCliente") = Nothing
            Me.hidDir.Value = System.Configuration.ConfigurationManager.AppSettings.Item("redirecciona")
        Else
            Me.hidDir.Value = ""
        End If

        Me.PHContenido.RenderControl(e.Output)
    End Sub

End Class
