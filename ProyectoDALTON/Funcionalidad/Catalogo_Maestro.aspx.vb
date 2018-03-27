Imports WsSeguridad
Imports DevExpress.Web
Imports System.Data.SqlClient
Imports System.Data
Imports Microsoft.VisualBasic
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports DevExpress.Web.ASPxGridView

Partial Class Framework_Test

    Inherits System.Web.UI.Page
    Private Servicio As New WsSeguridad.Seguridad
    Public vSistema As String = System.Configuration.ConfigurationManager.AppSettings.Item("sistema")
    Public vEmpresa As String = System.Configuration.ConfigurationManager.AppSettings.Item("empresa")

#Region "VARIABLES"

    Dim dtOpciones As DataTable
    Dim drOpciones As DataRow

    Dim renglon As Integer = 0,
    columna As Integer = 0,
    NumeroColunas As Integer = 0,
    NumeroRenglones As Integer = 0

    Dim vDetalle As String = "",
     colum As String,
    pseudo As String,
    Errpseudo As String = "",
    Resultado As String = "",
    idcatSeg As String = "",
    usrSeg As String = "",
    idAccion As String,
    idA As String = "",
    desA As String = ""

    Dim datoReporte As Object,
    vNombreColumna As Object,
    vfieldName As Object

    Dim tabla As New DataSet()

    Dim ColumnaGrid0 As New GridViewCommandColumn
    Dim ColumnaGrid1 As New GridViewCommandColumn
    Dim ColumnaGrid As New GridViewDataTextColumn
    Dim ColumnaGridFec As New GridViewDataDateColumn
    Dim ColumnaGridCmb As New GridViewDataComboBoxColumn

    Dim DSTipoDato As New DataSet
    Dim dtTipoDato As DataTable
    Dim DSTipoDatoA As New DataSet
    Dim dtTipoDatoA As DataTable
    Dim campo As Boolean
    Dim valorCatalogo As String
    Dim DsAccesos As New DataSet
#End Region

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        GridFinammico.JSProperties("cpAccion") = ""
        GridFinammico.JSProperties("cpErrorCaptura") = ""
        GridFinammico.JSProperties("cpActualizar") = ""
        GridFinammico.JSProperties("cpSinDatos") = ""

        LlenaGridLookup()

        If Not Page.IsPostBack Then
            GridFinammico.DataBind()
            If Session("sCliente") Is Nothing Then
                Response.Buffer = True
                Response.Clear()
                Response.Redirect("../Framework/Acceso.aspx")
            End If

            ColumnaGrid = New GridViewDataTextColumn
            ColumnaGrid.Caption = " "
            ColumnaGrid.Width = 1005
            Me.GridFinammico.Columns.Add(ColumnaGrid)


            ''valorCatalogo = ValorCatalogoSeguridad(Convert.ToString(glCatalogos.Value()))
            VerificaAccesos("Catalogo_Maestro")
                'Seguridad()
                'ASPxRoundPanel1. = True
            Else
                ' LlenaGridLookup()
                '  ASPxRoundPanel1.Collapsed = False
                If glCatalogos.Text <> "" Then
                Seguridad()
                ConfiguraGrid()

                'LlenaGrid()'esta comentado
            End If

        End If
    End Sub
    Protected Sub glCatalogos_ValueChanged(sender As Object, e As EventArgs) Handles glCatalogos.ValueChanged
        'If glCatalogos.Text <> "" Then
        '    ConfiguraGrid()
        'End If

    End Sub
    Protected Sub GridFinammico_CustomCallback(sender As Object, e As ASPxGridViewCustomCallbackEventArgs) Handles GridFinammico.CustomCallback
        ' If e.Parameters.Equals("Buscar") Then
        ' Seguridad()
        ' ConfiguraGrid()
        'LlenaGrid() ' esta comentado
        '  End If

        'GridFinammico.JSProperties("cpColapse") = 1

        'ClientScript.RegisterStartupScript([GetType],, "Colapse()", False)
        'ClientScript.RegisterStartupScript(Me.GetType(), "Colapse", "PrintStuff", True)

    End Sub
    Protected Sub GridFinammico_RowUpdating(sender As Object, e As Data.ASPxDataUpdatingEventArgs) Handles GridFinammico.RowUpdating
        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim vResultado As Int32 = 0
        Dim cadena As String = ""
        Dim cat As Int32 = Convert.ToInt32(glCatalogos.Value())
        Dim idCat As String = ""
        Dim cont = 1
        Dim dato As String = "", consulta As String = ""
        Dim R() As String

        Dim DSNumeroCampos As DataSet
        Dim NumCampos As Integer
        Dim tab As DataTable
        Dim row1 As DataRow
        Dim prespan As Boolean
        Dim ValorUpdate As String
        Dim contValues As Integer
        Dim tipo As Integer

        idCat = e.NewValues(0)
        consulta = "SELECT idCatalogo,idcampo,columna,alias,esObligatorio,idTipoCampo,presentaPantalla,ValorUpdate FROM catCamposCatalogosTbl where idCatalogo = " + Convert.ToString(glCatalogos.Value())
        DSTipoDato = fnc.ObtenDataSet("obtenCampo", consulta, "ConexionDBS")
        dtTipoDato = DSTipoDato.Tables(0)

        consulta = "select count(idcampo) from catCamposCatalogosTbl where idcatalogo = " + Convert.ToString(glCatalogos.Value())
        DSNumeroCampos = fnc.TraeDatosConsulta(consulta, "ConexionDBS")
        tab = DSNumeroCampos.Tables(0)
        row1 = tab.Rows(0)
        NumCampos = row1(0)

        Dim PP(NumCampos) As String

        cont = 0
        contValues = 0

        While cont < NumCampos
            For Each row As DataRow In dtTipoDato.Rows
                pseudo = row("alias").ToString
                tipo = row("idTipoCampo").ToString
                prespan = row("presentaPantalla")
                ValorUpdate = If(IsDBNull(row("ValorUpdate")), "", row("ValorUpdate"))

                If pseudo = "ID" Then
                    contValues = contValues + 1 'Avanza el campo que se muestra en el Form
                Else
                    If prespan = True Then
                        If tipo = 4 Then 'Validación de tipo campo Fechas
                            Dim FechaNacim As DateTime = Convert.ToDateTime(e.NewValues(cont))
                            Dim FNa As String = FechaNacim.ToString("yyyy/MM/dd")
                            e.NewValues(cont) = FNa
                            cadena = cadena + Convert.ToString(e.NewValues(contValues)) + "|"
                            contValues = contValues + 1 'Avanza el campo que se muestra en el Form
                        ElseIf tipo = 6 Then 'Validacion para tipo bit (TRUE y FALSE)
                            cadena = cadena + If(e.NewValues(contValues) = "True" Or e.NewValues(contValues) = -1, "1", "0") + "|"
                            contValues = contValues + 1
                        Else 'Validación de cualquier tipo de campo
                                cadena = cadena + If(e.NewValues(contValues) = Nothing, "NULL|", Convert.ToString(e.NewValues(contValues)) + "|")
                            contValues = contValues + 1 'Avanza el campo que se muestra en el Form
                        End If
                    Else 'Si no se presenta en pantalla toma como validación los campos de ValorUpdate y ValorInsert
                        If ValorUpdate <> Nothing Then
                            cadena = cadena + ValorUpdate + "|"
                        Else ' Si no tiene validación y no esta en presenta pantalla escribe NULL 
                            cadena = cadena + "NULL|"
                        End If
                    End If
                End If
                cont = cont + 1
            Next
        End While




        'While cont < e.NewValues.Count
        '    For Each row As DataRow In dtTipoDato.Rows
        '        pseudo = row("alias").ToString
        '        colum = row("columna").ToString
        '        campo = row("esObligatorio").ToString

        '        Dim Fecha As String = row("idTipoCampo").ToString

        '        If pseudo = "ID" Then
        '            dato = e.NewValues(1)
        '        Else
        '            If Convert.ToString(e.NewValues(cont)) = Nothing Then

        '                If campo = "True" Then 'valida si el campo es obligatorio
        '                    If e.NewValues(cont) = "" Then 'valida si el valor de la columna es vacio
        '                        Errpseudo = Errpseudo & vbCr & "- " + pseudo
        '                        GridFinammico.JSProperties("cpErrorCaptura") = Errpseudo
        '                        If cont = e.NewValues.Count - 1 Then
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                        Else
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                        End If
        '                    Else
        '                        e.NewValues(cont) = Convert.ToString("NULL")
        '                        If cont = e.NewValues.Count - 1 Then
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                        Else
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                        End If
        '                    End If
        '                Else
        '                    e.NewValues(cont) = Convert.ToString("NULL")
        '                    If cont = e.NewValues.Count - 1 Then
        '                        cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                    Else
        '                        cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                    End If
        '                End If
        '            Else
        '                If cont = e.NewValues.Count - 1 Then
        '                    If campo = "True" Then 'valida si el campo es obligatorio
        '                        If e.NewValues(cont) = "" Then 'valida si el valor de la columna es vacio
        '                            Errpseudo = Errpseudo & vbCr & "- " + pseudo
        '                            GridFinammico.JSProperties("cpErrorCaptura") = Errpseudo
        '                            If Convert.ToString(e.NewValues(cont)) = "False" Then
        '                                e.NewValues(cont) = "0"
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                            ElseIf Convert.ToString(e.NewValues(cont)) = "True" Then
        '                                e.NewValues(cont) = "1"
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                            Else
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                            End If
        '                        Else
        '                            If Convert.ToString(e.NewValues(cont)) = "False" Then
        '                                e.NewValues(cont) = "0"
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                            ElseIf Convert.ToString(e.NewValues(cont)) = "True" Then
        '                                e.NewValues(cont) = "1"
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                            Else
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                            End If
        '                        End If
        '                    Else
        '                        If Convert.ToString(e.NewValues(cont)) = "False" Then
        '                            e.NewValues(cont) = "0"
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                        ElseIf Convert.ToString(e.NewValues(cont)) = "True" Then
        '                            e.NewValues(cont) = "1"
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                        Else
        '                            'ConversionFecha
        '                            If Fecha = 4 Then
        '                                'If fnc.ObtenIdTipoCampo(vNombreColumna, catID, "ConexionDBS") = 4 Then
        '                                Dim FechaNacim As DateTime = Convert.ToDateTime(e.NewValues(cont))
        '                                Dim FNa As String = FechaNacim.ToString("yyyy/MM/dd")
        '                                e.NewValues(cont) = FNa
        '                            End If
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                        End If
        '                    End If
        '                Else
        '                    If campo = "True" Then 'valida si el campo es obligatorio
        '                        If Convert.ToString(e.NewValues(cont)) = Nothing Then 'valida si el valor de la columna es vacio
        '                            Errpseudo = Errpseudo & vbCr & "- " + pseudo
        '                            GridFinammico.JSProperties("cpErrorCaptura") = Errpseudo
        '                            If Convert.ToString(e.NewValues(cont)) = "False" Then
        '                                e.NewValues(cont) = "0"
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                            ElseIf Convert.ToString(e.NewValues(cont)) = "True" Then
        '                                e.NewValues(cont) = "1"
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                            Else
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                            End If
        '                        Else
        '                            If Convert.ToString(e.NewValues(cont)) = "False" Then
        '                                e.NewValues(cont) = "0"
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                            ElseIf Convert.ToString(e.NewValues(cont)) = "True" Then
        '                                e.NewValues(cont) = "1"
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                            Else
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                            End If
        '                        End If
        '                    Else
        '                        If Convert.ToString(e.NewValues(cont)) = "False" Then
        '                            e.NewValues(cont) = "0"
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                        ElseIf Convert.ToString(e.NewValues(cont)) = "True" Then
        '                            e.NewValues(cont) = "1"
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                        Else
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                        End If
        '                    End If

        '                End If
        '            End If
        '            cont = cont + 1
        '        End If
        '    Next
        'End While


        'If Errpseudo = "" Then
        '    If cadena = "NULL" Or cadena = "" Then
        '        GridFinammico.JSProperties("cpActualizar") = "No ha capturado ningún registro"
        '    Else
        Resultado = fnc.Fun_Edita(cat, cadena, idCat, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
        R = Resultado.Split("|")
        e.Cancel = True

        If R(0) = "0" Then
            e.Cancel = True
            GridFinammico.JSProperties("cpAccion") = "Registro Actualizado con éxito"
        Else
            GridFinammico.JSProperties("cpAccion") = Resultado
        End If
        '    End If

        '        End If
        e.Cancel = True
        'Dim xc As New Negocio.Funcionalidad
        'Dim mensajeError As String = xc.ResultadoEdita


        'ClientScript.RegisterStartupScript(Me.GetType(), "CargaMasivaModelos", "<script>javascript:mensajeC('" + titulo + "','" + mensaje.Replace("'", "") + "','" + tipoMen + "');</script>")

    End Sub
    Protected Sub GridFinammico_RowInserting(sender As Object, e As Data.ASPxDataInsertingEventArgs) Handles GridFinammico.RowInserting
        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim vResultado As Int32 = 0
        Dim cat As Int32 = Convert.ToInt32(glCatalogos.Value())
        Dim cadena As String = "", dato As String = "", consulta As String = ""
        Dim cont = 1
        Dim R() As String
        'vNombreColumna = tabla.Tables(0).Columns(1).ColumnName + "= '" + dato + "'"

        Dim DSNumeroCampos As DataSet
        Dim NumCampos As Integer
        Dim tab As DataTable
        Dim row1 As DataRow
        Dim prespan As Boolean
        Dim ValorUpdate As String
        Dim contValues As Integer
        Dim tipo As Integer
        Dim validaDirecta As String

        consulta = "SELECT idCatalogo,idcampo,columna,alias,esObligatorio,idTipoCampo,presentaPantalla,ValorInsert,validaDirecta FROM catCamposCatalogosTbl where idCatalogo = " + Convert.ToString(glCatalogos.Value())
        DSTipoDato = fnc.ObtenDataSet("obtenCampo", consulta, "ConexionDBS")
        dtTipoDato = DSTipoDato.Tables(0)

        consulta = "select count(idcampo) from catCamposCatalogosTbl where idcatalogo = " + Convert.ToString(glCatalogos.Value())
        DSNumeroCampos = fnc.TraeDatosConsulta(consulta, "ConexionDBS")
        tab = DSNumeroCampos.Tables(0)
        row1 = tab.Rows(0)
        NumCampos = row1(0)

        Dim PP(NumCampos) As String

        cont = 0
        contValues = 0

        While cont < NumCampos
            For Each row As DataRow In dtTipoDato.Rows
                pseudo = row("alias").ToString
                tipo = row("idTipoCampo").ToString
                prespan = row("presentaPantalla")
                ValorUpdate = If(IsDBNull(row("ValorInsert")), "", row("ValorInsert"))
                validaDirecta = If(IsDBNull(row("validaDirecta")), "", Convert.ToString(row("validaDirecta")))

                If pseudo = "ID" Then
                    contValues = contValues + 1
                Else
                    If prespan = True Then
                        If validaDirecta = "Exist" Then
                            dato = Convert.ToString(e.NewValues(contValues))
                        End If
                        'ConversionFecha
                        If tipo = 4 Then
                            Dim FechaNacim As DateTime = Convert.ToDateTime(e.NewValues(cont))
                            Dim FNa As String = FechaNacim.ToString("yyyy/MM/dd")
                            e.NewValues(cont) = FNa
                            cadena = cadena + Convert.ToString(e.NewValues(contValues)) + "|"
                            contValues = contValues + 1
                        ElseIf tipo = 6 Then 'Validacion para tipo bit (TRUE y FALSE)
                            cadena = cadena + If(e.NewValues(contValues) = "True" Or e.NewValues(contValues) = -1, "1", "0") + "|"
                            contValues = contValues + 1
                        Else
                            cadena = cadena + If(e.NewValues(contValues) = Nothing, "NULL|", Convert.ToString(e.NewValues(contValues)) + "|")
                            contValues = contValues + 1
                        End If
                    Else
                        If ValorUpdate <> Nothing Then
                            cadena = cadena + ValorUpdate + "|"
                        Else
                            cadena = cadena + "NULL|"
                        End If
                    End If
                End If
                cont = cont + 1
            Next
        End While



        'While cont < e.NewValues.Count
        '    For Each row As DataRow In dtTipoDato.Rows
        '        pseudo = row("alias").ToString
        '        colum = row("columna").ToString
        '        campo = row("esObligatorio").ToString
        '        Dim Fecha As String = row("idTipoCampo").ToString

        '        If pseudo = "ID" Then
        '            dato = e.NewValues(1)
        '        Else
        '            If Convert.ToString(e.NewValues(cont)) = "" Then
        '                If campo = "True" Then 'valida si el campo es obligatorio
        '                    If e.NewValues(cont) = "" Then 'valida si el valor de la columna es vacio
        '                        Errpseudo = Errpseudo & vbCr & "- " + pseudo
        '                        GridFinammico.JSProperties("cpErrorCaptura") = Errpseudo
        '                        If cont = e.NewValues.Count - 1 Then
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                        Else
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                        End If
        '                    Else
        '                        e.NewValues(cont) = Convert.ToString("NULL")
        '                        If cont = e.NewValues.Count - 1 Then
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                        Else
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                        End If
        '                    End If
        '                Else
        '                    e.NewValues(cont) = Convert.ToString("NULL")
        '                    If cont = e.NewValues.Count - 1 Then
        '                        cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                    Else
        '                        cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                    End If
        '                End If
        '            Else
        '                If cont = e.NewValues.Count - 1 Then
        '                    If campo = "True" Then 'valida si el campo es obligatorio
        '                        If e.NewValues(cont) = "" Then 'valida si el valor de la columna es vacio
        '                            Errpseudo = Errpseudo & vbCr & "- " + pseudo
        '                            GridFinammico.JSProperties("cpErrorCaptura") = Errpseudo
        '                            If Convert.ToString(e.NewValues(cont)) = "False" Then
        '                                e.NewValues(cont) = "0"
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                            ElseIf Convert.ToString(e.NewValues(cont)) = "True" Then
        '                                e.NewValues(cont) = "1"
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                            Else
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                            End If
        '                        Else
        '                            If Convert.ToString(e.NewValues(cont)) = "False" Then
        '                                e.NewValues(cont) = "0"
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                            ElseIf Convert.ToString(e.NewValues(cont)) = "True" Then
        '                                e.NewValues(cont) = "1"
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                            Else
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                            End If
        '                        End If
        '                    Else
        '                        If Convert.ToString(e.NewValues(cont)) = "False" Then
        '                            e.NewValues(cont) = "0"
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                        ElseIf Convert.ToString(e.NewValues(cont)) = "True" Then
        '                            e.NewValues(cont) = "1"
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                        Else
        '                            'ConversionFecha
        '                            If Fecha = 4 Then
        '                                'If fnc.ObtenIdTipoCampo(vNombreColumna, catID, "ConexionDBS") = 4 Then
        '                                Dim FechaNacim As DateTime = Convert.ToDateTime(e.NewValues(cont))
        '                                Dim FNa As String = FechaNacim.ToString("yyyy/MM/dd")
        '                                e.NewValues(cont) = FNa
        '                            End If
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont))
        '                        End If
        '                    End If
        '                Else
        '                    If campo = "True" Then 'valida si el campo es obligatorio
        '                        If e.NewValues(cont) = "" Then 'valida si el valor de la columna es vacio
        '                            Errpseudo = Errpseudo & vbCr & "- " + pseudo
        '                            GridFinammico.JSProperties("cpErrorCaptura") = Errpseudo
        '                            If Convert.ToString(e.NewValues(cont)) = "False" Then
        '                                e.NewValues(cont) = "0"
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                            ElseIf Convert.ToString(e.NewValues(cont)) = "True" Then
        '                                e.NewValues(cont) = "1"
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                            Else
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                            End If
        '                        Else
        '                            If Convert.ToString(e.NewValues(cont)) = "False" Then
        '                                e.NewValues(cont) = "0"
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                            ElseIf Convert.ToString(e.NewValues(cont)) = "True" Then
        '                                e.NewValues(cont) = "1"
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                            Else
        '                                cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                            End If
        '                        End If
        '                    Else
        '                        If Convert.ToString(e.NewValues(cont)) = "False" Then
        '                            e.NewValues(cont) = "0"
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                        ElseIf Convert.ToString(e.NewValues(cont)) = "True" Then
        '                            e.NewValues(cont) = "1"
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                        Else
        '                            cadena = cadena + Convert.ToString(e.NewValues(cont)) + "|"
        '                        End If
        '                    End If

        '                End If
        '            End If
        '            cont = cont + 1
        '        End If
        '    Next
        'End While
        'If Errpseudo = "" Then


        '    If cadena = "NULL" Or cadena = "" Then
        '        GridFinammico.JSProperties("cpActualizar") = "No ha capturado ningún registro"
        '    Else
        Resultado = fnc.Fun_Nuevo(cat, cadena, 2, dato, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
        R = Resultado.Split("|")

        If R(0) = "0" Then
            e.Cancel = True
            GridFinammico.JSProperties("cpAccion") = "Registro Insertado con éxito"
        Else
            GridFinammico.JSProperties("cpAccion") = Resultado
        End If

        '    End If

        ' End If
        e.Cancel = True
    End Sub
    Protected Sub GridFinammico_RowDeleting(sender As Object, e As Data.ASPxDataDeletingEventArgs) Handles GridFinammico.RowDeleting
        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim vResultado As Int32 = 0
        Dim cat As Int32 = Convert.ToInt32(glCatalogos.Value())
        Dim idGrid As String = ""

        idGrid = Convert.ToInt32(e.Keys("ID").ToString().Trim())

        Resultado = fnc.Fun_Elimina(cat, idGrid, 1, Session("iIdUsuario"), "", 0, "", "ConexionDBS")
        If Resultado = "0" Then
            e.Cancel = True
            If idGrid <> "" Then
                GridFinammico.JSProperties("cpAccion") = "El registro se Elimino con éxito!!"
            End If
        Else
            GridFinammico.JSProperties("cpAccion") = Resultado
        End If
    End Sub
    Protected Sub GridFinammico_RowValidating(sender As Object, e As Data.ASPxDataValidationEventArgs) Handles GridFinammico.RowValidating

        'Dim DS As DataSet
        'Dim tab As DataTable
        'Dim fnc = New WsFuncionalidad.Funcionalidad
        'Dim campo As String
        'Dim validaDirecta As String
        'Dim cont As Integer = 0

        'DS = fnc.TraeDatosConsulta("select alias, esObligatorio, validaDirecta from catCamposCatalogosTbl where esObligatorio = 1 and idcatalogo = " + Convert.ToString(glCatalogos.Value()), "ConexionDBS")
        'tab = DS.Tables(0) 'La consulta trae todos los campos obligatorios y con validacion directa para excluir de obligacion a los ID.
        'Do While cont <= e.NewValues.Count - 1   'El proceso funciona mientras no se exceda el numero de campos que se muestran por catalogo.
        '    For Each column As GridViewColumn In GridFinammico.Columns 'Se busca el numero de columnas ya que se asigna la obligacion a la columna vacia.
        '        Dim dataColumn As GridViewDataColumn = TryCast(column, GridViewDataColumn) 'traemos la data y nombre de la columna ademas de otras propiedades.
        '        If column.Name <> "ColAcciones" Then 'Si aparece la columna de los botones de accion, la excluye de validacion ya que dentro no hay campos para validar.
        '            For Each row As DataRow In tab.Rows 'traemos la colección de la tabla CatCampos ya que aqui esta la configuración, Primero se toma un campo del Grid y luego se valida por cada uno de los campos de la colección CatCampos.
        '                campo = row("alias").ToString
        '                validaDirecta = If(IsDBNull(row("validaDirecta")), "", row("validaDirecta"))
        '                If validaDirecta <> "ID" Then 'Si se encuentra un Campo con validación ID lo excluye de marcarlo obligatorio ya que este se llena por default.
        '                    If e.NewValues(cont) Is Nothing Then 'Si el valor del campo mostrado en el Grid dependiendo el ciclo esta vacio, sigue, si no, no lo marca com obligatorio.
        '                        If (dataColumn.FieldName = campo) Then 'Si el valor mostrado en el Grid es vacio y el nombre del campo esta en la coleccion de campos obligatorios, Marca la Columna.
        '                            e.Errors(dataColumn) = "Este es un campo obligatorio."
        '                        End If
        '                    End If                    
        '                End If
        '            Next 'Avanza el ciclo de campos
        '        End If
        '        cont = cont + 1 'Avanza el ciclo de Columnas
        '    Next
        'Loop

        'If e.Errors.Count > 0 Then
        '    e.RowError = "Completar los campos obligatorios."
        'End If
    End Sub

#Region "Funciones"
    Public Sub VerificaAccesos(ByVal txtFormulario As Object)
        Dim DsAccesos As New DataSet
        Dim dtAccesos As DataTable
        Dim drAccesos As DataRow
        Dim vRenglon As Int32 = 0
        DsAccesos = Servicio.OpVerificaAccesosFormulario(Session("sUsuario"), Session("iIdUsuario"), txtFormulario, System.Configuration.ConfigurationManager.AppSettings.Item("ConexionSeguridad"))
        dtAccesos = DsAccesos.Tables("Accesos")
        Dim txtAcceso As Object
        Dim txtAccesosUsuario As String = ""
        If glCatalogos.Text <> "" Then
            If DsAccesos.Tables.Count > 0 Then
                If DsAccesos.Tables(0).Rows.Count > 0 Then
                    For Each drAccesos In dtAccesos.Rows
                        txtAcceso = DsAccesos.Tables("Accesos").Rows(vRenglon)("nombre").ToString.Trim
                        'If glCatalogos.Text <> "" Then
                        '    If txtForm.Text = "" Then
                        '        If txtAcceso = "AGREGAR" Then
                        '            ColumnaGrid0.ShowNewButtonInHeader = True
                        '        End If

                        '        If txtAcceso = "EDITAR" Then
                        '            ColumnaGrid0.ShowEditButton = True
                        '        End If

                        '        If txtAcceso = "ELIMIAR" Then
                        '            ColumnaGrid0.ShowDeleteButton = True
                        '        End If
                        '        ColumnaGrid0.FixedStyle = GridViewColumnFixedStyle.Left

                        '        'Else
                        '        '    cmdCol1.ShowDeleteButton = True
                        '        '    cmdCol1.FixedStyle = GridViewColumnFixedStyle.Left
                        '        '    GridFinammico.Columns.Add(cmdCol1)

                        '    End If
                        'End If
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
        End If

    End Sub
    Private Sub LlenaGridLookup()
        Dim fnc = New WsFuncionalidad.Funcionalidad
        tabla = New DataSet
        glCatalogos.Columns.Clear()

        tabla = fnc.TraeDatosConsulta("SELECT idCatalogo,etiqueta,FormularioInd FROM catCatalogosGenTbl Where FormularioInd is null order by etiqueta ", "ConexionDBS")

        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                NumeroColunas = tabla.Tables(0).Columns.Count - 1
                NumeroRenglones = tabla.Tables(0).Rows.Count - 1

                For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

                    vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
                    vfieldName = tabla.Tables(0).Columns(j).ColumnName
                    ColumnaGrid = New GridViewDataTextColumn
                    ColumnaGrid.Caption = vNombreColumna

                    If ColumnaGrid.Caption = "idCatalogo" Then
                        ColumnaGrid.Caption = "ID"
                        ColumnaGrid.ReadOnly = True
                        ColumnaGrid.Width = 50
                        ColumnaGrid.Visible = False

                    ElseIf ColumnaGrid.Caption = "etiqueta" Then
                        ColumnaGrid.Caption = "Catálogo"
                        ColumnaGrid.Visible = True
                    Else
                        ColumnaGrid.Visible = False
                    End If

                    ColumnaGrid.FieldName = vfieldName
                    Me.glCatalogos.Columns.Add(ColumnaGrid)
                Next
            End If
        End If
        If tabla.Tables.Count > 0 Then
            If tabla.Tables(0).Rows.Count > 0 Then
                glCatalogos.DataSource = tabla
                glCatalogos.DataBind()
            End If
        Else
        End If
    End Sub
    Private Sub ConfiguraGrid()
        '##########################
        'Se puede mejorar el Form, sustituyendo todas las llamadas a las funciones 
        'Creando solo una función que traiga todos los campos de la tabla CatCampos?
        '##########################

        Dim catID As Int32 = Convert.ToInt32(glCatalogos.Value())
        GridFinammico.Columns.Clear()

        Dim fnc = New WsFuncionalidad.Funcionalidad

        Dim cat As Int32 = Convert.ToInt32(glCatalogos.Value())
        Dim cstype As Type = Me.GetType()

        tabla = fnc.selecTabla(cat, "", "", "", Session("iIdUsuario"), 0, "", "ConexionDBS")
        dtOpciones = tabla.Tables("Table")

        'ColumnaGrid0.Caption = "Acción"
        '*****************************************BOTÓN PARA ABRIR FORMULARIO (CON PARAMETROS)*********************************************************
        Dim cmdCol = New GridViewCommandColumn
        cmdCol.ButtonType = ButtonType.Link
        'cmdCol.Width = Unit.Pixel(70)
        'cmdCol.Caption = "Editar"


        Dim cDetailBtn = New GridViewCommandColumnCustomButton()
        cDetailBtn.ID = "BTN"
        cDetailBtn.Text = "Editar"
        cDetailBtn.Visibility = GridViewCustomButtonVisibility.AllDataRows
        cDetailBtn.Image.Url = "../Imagenes/Editar.png"
        cDetailBtn.Image.Width = Unit.Pixel(16)
        ' cmdCol.CustomButtons.Add(cDetailBtn)



        '*******************************************BOTÓN NUEVO (FORMULARIO EN BLANCO)*******************************************************
        Dim cmdCol1 = New GridViewCommandColumn
        cmdCol1.ButtonType = ButtonType.Link
        cmdCol1.Width = Unit.Pixel(100)
        'cmdCol1.Caption = "Acción"
        Dim cDetailBtn1 = New GridViewCommandColumnCustomButton()
        cDetailBtn1.ID = "BTNNuevo"
        cDetailBtn1.Text = "Nuevo Registro"
        cDetailBtn1.Visibility = GridViewCustomButtonVisibility.FilterRow
        cDetailBtn1.Image.Url = "../Imagenes/New_.png"
        cDetailBtn1.Image.Width = Unit.Pixel(23)

        'DATASET ANCHO COLUMNAS

        Dim DS As DataSet
        DS = New DataSet
        Dim fncion = New WsFuncionalidad.Funcionalidad

        Dim Catcmbtipo As String = ""
        Dim Catcmb() As String
        Dim catformato As String = ""
        Dim cattipo As Integer


        '*****************************************AGREGA BOTONES A COLUMNA (JUNTOS)*********************************************************
        '************************ Editar**********Nuevo
        cmdCol1.CustomButtons.Add(cDetailBtn, cDetailBtn1)
        VerificaAccesos("Catalogo_Maestro")

        ' If tabla.Tables.Count > 0 Then
        ' If tabla.Tables(0).Rows.Count > 0 Then
        NumeroColunas = tabla.Tables(0).Columns.Count - 1
        NumeroRenglones = tabla.Tables(0).Rows.Count - 1

        For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1

            vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
            vfieldName = tabla.Tables(0).Columns(j).ColumnName

            Dim IDcat As Int32 = Convert.ToInt32(glCatalogos.Value())

            cattipo = fnc.ObtenIdTipoCampo(vNombreColumna, IDcat, "ConexionDBS")

            If cattipo = 4 Then
                ColumnaGridFec = New GridViewDataDateColumn
                ColumnaGridFec.PropertiesDateEdit.UseMaskBehavior = True
                ' ColumnaGridFec.PropertiesDateEdit.MaxLength= Convert.ToInt32(fnc.ObtenLongitud(vNombreColumna, IDcat, "ConexionDBS"))
                ColumnaGridFec.Caption = fnc.ObtenEtiquetaCatCampos(vNombreColumna, IDcat, "ConexionDBS")
                ColumnaGridFec.Width = Convert.ToInt32(fnc.ObtenWidth(vNombreColumna, glCatalogos.Value(), "ConexionDBS"))
                ColumnaGridFec.ToolTip = fnc.ObtenTooltip(vNombreColumna, IDcat, "ConexionDBS")
                ColumnaGridFec.FieldName = vfieldName
                If fnc.ObtenObligatorio(vNombreColumna, IDcat, "ConexionDBS") = "True" Then
                    ColumnaGridFec.PropertiesDateEdit.ValidationSettings.RequiredField.IsRequired = True
                    ColumnaGridFec.PropertiesDateEdit.ValidationSettings.RequiredField.ErrorText = "Este campo es obligatorio"
                End If
                Me.GridFinammico.Columns.Add(ColumnaGridFec)
            End If

            Catcmbtipo = fnc.ObtenTblRelacionGen(vNombreColumna, IDcat, "ConexionDBS")
            If Catcmbtipo <> "" Then
                Catcmb = Catcmbtipo.Split("|")
                ColumnaGridCmb = New GridViewDataComboBoxColumn
                ColumnaGridCmb.Caption = fnc.ObtenEtiquetaCatCampos(vNombreColumna, IDcat, "ConexionDBS")
                ColumnaGridCmb.Width = Convert.ToInt32(fnc.ObtenWidth(vNombreColumna, glCatalogos.Value(), "ConexionDBS"))
                ColumnaGridCmb.ToolTip = fnc.ObtenTooltip(vNombreColumna, IDcat, "ConexionDBS")
                ColumnaGridCmb.FieldName = vfieldName
                If Catcmb(0) = "GEN" Then
                    DS = fnc.CatGrals(Catcmb(1), vNombreColumna, 0, "", "", Session("iIdUsuario"), "", "", "", "0", "", "ConexionDBS")
                    ColumnaGridCmb.PropertiesComboBox.DataSource = DS
                    ColumnaGridCmb.PropertiesComboBox.TextField = "descripcion"
                    ColumnaGridCmb.PropertiesComboBox.ValueField = Catcmb(2)
                Else
                    DS = fnc.selecTabla(Catcmb(1), "", "", "", Session("iIdUsuario"), 0, "", "ConexionDBS")
                    ColumnaGridCmb.PropertiesComboBox.DataSource = DS
                    ColumnaGridCmb.PropertiesComboBox.TextField = Catcmb(3)
                    ColumnaGridCmb.PropertiesComboBox.ValueField = Catcmb(2)
                End If
                If fnc.ObtenObligatorio(vNombreColumna, IDcat, "ConexionDBS") = "True" Then
                    ColumnaGridCmb.PropertiesComboBox.ValidationSettings.RequiredField.IsRequired = True
                    ColumnaGridCmb.PropertiesComboBox.ValidationSettings.RequiredField.ErrorText = "Este campo es obligatorio"
                End If
                Me.GridFinammico.Columns.Add(ColumnaGridCmb)
            Else
                ColumnaGrid = New GridViewDataTextColumn
                ColumnaGrid.PropertiesTextEdit.MaxLength = Convert.ToInt32(fnc.ObtenLongitud(vNombreColumna, IDcat, "ConexionDBS"))
                ColumnaGrid.Caption = fnc.ObtenEtiquetaCatCampos(vNombreColumna, IDcat, "ConexionDBS")
                ColumnaGrid.Width = Convert.ToInt32(fnc.ObtenWidth(vNombreColumna, IDcat, "ConexionDBS"))
                ColumnaGrid.ToolTip = fnc.ObtenTooltip(vNombreColumna, IDcat, "ConexionDBS")
                catformato = fnc.ObtenCatFormato(vNombreColumna, IDcat, "ConexionDBS")

                If catformato <> "" Then
                    ColumnaGrid.PropertiesEdit.DisplayFormatString = catformato
                    ColumnaGrid.PropertiesTextEdit.DisplayFormatInEditMode = True
                End If
                If cattipo = 2 Or cattipo = 5 Or cattipo = 8 Then
                    ColumnaGrid.PropertiesTextEdit.ValidationSettings.RegularExpression.ValidationExpression = "\b[0-9]*\.*[0-9]+\b" '"^(?=.*\d)[\d ]+$"
                    ColumnaGrid.PropertiesTextEdit.ValidationSettings.RegularExpression.ErrorText = "Este campo solo admite valores numéricos"
                ElseIf cattipo = 3 Or cattipo = 7 Then
                    ColumnaGrid.PropertiesTextEdit.ValidationSettings.RegularExpression.ValidationExpression = "^(?=.*\d)[\d ]+$"    '"^(?=.*\d)[\d ]+$"
                    ColumnaGrid.PropertiesTextEdit.ValidationSettings.RegularExpression.ErrorText = "Este campo solo admite valores numéricos"
                Else
                    ColumnaGrid.PropertiesTextEdit.ValidationSettings.RegularExpression.ValidationExpression = ".+"
                    ColumnaGrid.PropertiesTextEdit.ValidationSettings.RegularExpression.ErrorText = "Este campo es de tipo alfanumérico"
                End If

                If fnc.ObtenValidaDirecta(vNombreColumna, IDcat, "ConexionDBS") = "ID" Then
                    ColumnaGrid.ReadOnly = True
                Else
                    If fnc.ObtenObligatorio(vNombreColumna, IDcat, "ConexionDBS") = "True" Then
                        ColumnaGrid.PropertiesTextEdit.ValidationSettings.RequiredField.IsRequired = True
                        ColumnaGrid.PropertiesTextEdit.ValidationSettings.RequiredField.ErrorText = "Este campo es obligatorio"
                        ' ColumnaGrid.PropertiesTextEdit.ValidationSettings.ErrorText = "Corregir todos los errores"
                        'ColumnaGrid.PropertiesTextEdit.ValidationSettings.ErrorDisplayMode = 1
                    End If
                End If

                ColumnaGrid.FieldName = vfieldName
                Me.GridFinammico.Columns.Add(ColumnaGrid)

            End If
        Next
        '    Else
        'VerificaAccesos("Catalogo_Maestro")
        'If tabla.Tables.Count > 0 Then
        '    If (tabla.Tables(0).Rows.Count > 0) Or (tabla.Tables(0).Rows.Count = 0) Then
        '        NumeroColunas = tabla.Tables(0).Columns.Count - 1
        '        NumeroRenglones = tabla.Tables(0).Rows.Count - 1

        '        For j As Integer = 0 To tabla.Tables(0).Columns.Count - 1
        '            vNombreColumna = tabla.Tables(0).Columns(j).ColumnName
        '            vfieldName = tabla.Tables(0).Columns(j).ColumnName

        '            Dim IDcat As Int32 = Convert.ToInt32(glCatalogos.Value())

        '            If fnc.ObtenIdTipoCampo(vNombreColumna, IDcat, "ConexionDBS") = 4 Then
        '                ColumnaGridFec = New GridViewDataDateColumn
        '                ColumnaGridFec.Caption = fnc.ObtenEtiquetaCatCampos(vNombreColumna, IDcat, "ConexionDBS")
        '                ColumnaGridFec.Width = Convert.ToInt32(fnc.ObtenWidth(vNombreColumna, glCatalogos.Value(), "ConexionDBS"))
        '                ColumnaGridFec.FieldName = vfieldName
        '                Me.GridFinammico.Columns.Add(ColumnaGridFec)
        '            Else
        '                ColumnaGrid = New GridViewDataTextColumn
        '                ColumnaGrid.Caption = fnc.ObtenEtiquetaCatCampos(vNombreColumna, IDcat, "ConexionDBS")
        '                If fnc.ObtenValidaDirecta(vNombreColumna, IDcat, "ConexionDBS") = "ID" Then
        '                    '     If ColumnaGrid.Caption = "ID" Then
        '                    ColumnaGrid.ReadOnly = True
        '                    ColumnaGrid.Width = Convert.ToInt32(fnc.ObtenWidth(vNombreColumna, IDcat, "ConexionDBS"))
        '                Else
        '                    ColumnaGrid.Width = Convert.ToInt32(fnc.ObtenWidth(vNombreColumna, IDcat, "ConexionDBS"))
        '                    End If
        '                    ColumnaGrid.FieldName = vfieldName
        '                    Me.GridFinammico.Columns.Add(ColumnaGrid)
        '                End If
        '        Next
        '    End If
        'End If
        'End If
        'End If
        '   If tabla.Tables.Count > 0 Then
        '   If tabla.Tables(0).Rows.Count > 0 Or (tabla.Tables(0).Rows.Count = 0) Then
        GridFinammico.JSProperties("cpSinDatos") = ""
        GridFinammico.DataSource = tabla
                GridFinammico.DataBind()
                ColumnaGrid0.Name = "ColAcciones"
                GridFinammico.Columns.Add(ColumnaGrid0)
        '     End If
        '  Else
        'GridFinammico.JSProperties("cpSinDatos") = "no"
        'End If

    End Sub
    Function ValorCatalogoSeguridad(ByVal ValorCat As Object) As String
        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim consulta As String = ""
        Dim cont = 1
        If ValorCat <> "" Then
            consulta = "SELECT Valor_Seguridad FROM catCatalogosGenTbl where idCatalogo = " + Convert.ToString(glCatalogos.Value())
            DSTipoDato = fnc.ObtenDataSet("obtenCampoValorSeg", consulta, "ConexionDBS")
            dtTipoDato = DSTipoDato.Tables(0)
            If dtTipoDato.Rows.Count > 0 Then
                For Each row As DataRow In dtTipoDato.Rows
                    valorCatalogo = row("Valor_Seguridad").ToString
                Next
            End If
        End If

        Return valorCatalogo
    End Function
    Public Sub Seguridad()
        Dim consulta As String = "", consultaAccion As String = ""
        Dim fnc = New WsFuncionalidad.Funcionalidad
        'CONSULTA PARA LA SEGURIDAD DEL USUARIO A QUE BOTONES TIENE ACCESO 
        consulta = "SELECT idUsuario,idCatalogo,idAccion FROM segUsuarioCatalogosTbl WHERE idUsuario = " + Convert.ToString(Session("iIdUsuario")) + " and idCatalogo = " + Convert.ToString(glCatalogos.Value())
        DSTipoDato = fnc.ObtenDataSet("SegUsr", consulta, "ConexionDBS")
        dtTipoDato = DSTipoDato.Tables(0)
        For Each row As DataRow In dtTipoDato.Rows
            idcatSeg = row("idUsuario").ToString
            usrSeg = row("idCatalogo").ToString
            idAccion = row("idAccion").ToString
            'CONULTA PARA EL LISTADO DE LOS BOTONES
            consultaAccion = "select idAccion,descripcion from segAccionesTbl where idAccion = " + idAccion
            DSTipoDatoA = fnc.ObtenDataSet("SegAcciones", consultaAccion, "ConexionDBS")
            dtTipoDatoA = DSTipoDatoA.Tables(0)
            For Each rowA As DataRow In dtTipoDatoA.Rows
                idA = rowA("idAccion").ToString
                usrSeg = rowA("descripcion").ToString
            Next
            If glCatalogos.Text <> "" Then
                If txtForm.Text = "" Then
                    'Alta-Nuevo
                    If idA = "2" Then
                        ColumnaGrid0.ShowNewButtonInHeader = True
                    End If
                    'Actualización-Editar
                    If idA = "3" Then
                        ColumnaGrid0.ShowEditButton = True
                    End If
                    'Eliminación
                    If idA = "4" Then
                        ColumnaGrid0.ShowDeleteButton = True
                    End If
                    ColumnaGrid0.FixedStyle = GridViewColumnFixedStyle.Left
                    'Else
                    '    cmdCol1.ShowDeleteButton = True
                    '    cmdCol1.FixedStyle = GridViewColumnFixedStyle.Left
                    '    GridFinammico.Columns.Add(cmdCol1)

                End If
            End If
        Next
    End Sub
#End Region

    Protected Sub GridFinammico_AfterPerformCallback(sender As Object, e As ASPxGridViewAfterPerformCallbackEventArgs) Handles GridFinammico.AfterPerformCallback
        '   GridFinammico.JSProperties("cpColapse") = 1
    End Sub

End Class
