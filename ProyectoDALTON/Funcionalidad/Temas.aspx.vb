Imports Microsoft.VisualBasic
Imports System
Imports System.Web.UI
Imports Microsoft.VisualBasic.ApplicationServices
Imports System.Data
Imports DevExpress.Web
Imports System.Drawing
Imports System.Threading
Imports System.Windows.Forms

Partial Class Framework_Temas

    Inherits System.Web.UI.Page
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs) Handles Me.Load
        Dim x As String
        x = Application("TemaDin2") 'Variable que mostrara el tema que fue seleccionado.
        'Application("TemaDin2") = Nothing ' Iguala la varbiable global a nothing para que no aparezca un tema cuando se abre por primera ves el formulario.
        If Not IsPostBack Then
            LlenaCombos() ' Llama a la funcion para llenar el combo con el nombre de los temas temas.
            Me.cmbTema.Text = IIf(x = Nothing, Session("TemaDin"), x) 'Iguala el nombre del tama al campo para saber el nombre del tema seleccionado.
            Application("TemaDin2") = Nothing
        End If

    End Sub

    Protected Sub Page_PreInit(sender As Object, e As EventArgs) Handles Me.PreInit
        If Application("TemaDin2") = Nothing Then
            DevExpress.Web.ASPxWebControl.GlobalTheme = Session("TemaDin")
        Else
            DevExpress.Web.ASPxWebControl.GlobalTheme = Application("TemaDin2")
        End If

        'If IsPostBack Then
        '    Application("TemaDin2") = cmbTema.Text 'Si se recargo la pagina iguala la variable a otra para efecto de este formulario solamente.
        '    DevExpress.Web.ASPxWebControl.GlobalTheme = Application("TemaDin2")
        'Else
        '    DevExpress.Web.ASPxWebControl.GlobalTheme = Application("TemaDin")
        'End If
        'Codigo que modifica el tema general del formulario, lo deben llevar todos los forms. 
    End Sub

    Private Sub LlenaCombos()
        Dim DS As DataSet
        DS = New DataSet
        Dim fncion = New WsFuncionalidad.Funcionalidad
        'Se llena el combo de Temas
        DS = fncion.TraeDatosConsulta("Select 0 as ID, 'SELECCIONAR...' as NombreC union all Select valor as ID, descripcion as NombreC from catGeneralesTBL Where Tabla = 'SAC_Temas_Usuario' order by ID", "ConexionDBS")
        'Combo Temas
        cmbTema.DataSource = DS
        cmbTema.ValueField = "ID"
        cmbTema.TextField = "NombreC"
        cmbTema.DataBind()
        cmbTema.SelectedIndex = 0
    End Sub
    Protected Sub cmbTema_ValueChanged(sender As Object, e As EventArgs) Handles cmbTema.ValueChanged
        If cmbTema.Value <> 0 Then
            Application("TemaDin2") = cmbTema.Text ' Se selecciona un tema del combo y se iguala a la variable
            Response.Redirect("Temas.aspx") 'Llama a la pagina completa para refrescar.
        End If                              'Creo este codigo se puede eliminar y ser ejecutado en el LOAD por el efecto del autopostback
    End Sub
    Protected Sub OnCallBack(ByVal sender As Object, ByVal e As EventArgs)
        ApplyColorOnRoundPanel()
    End Sub

    Protected Sub ApplyColorOnRoundPanel()
        Dim Encabezado As Color
        Dim Back As Color
        Dim Fore As Color

        'Dim ctrl As UI.Control ' ASPxRoundPanel 'Conteiner for another controls
        'Dim x As ASPxRoundPanel
        'Dim C As ASPxCallbackPanel
        'Dim y As String

        'For Each ctrl In form1.Controls

        '    If ctrl.[GetType]() = GetType(DevExpress.Web.ASPxRoundPanel) Then
        '        'ctrl.HeaderStyle.BackColor = Encabezado
        '        y = ctrl.ClientID
        '        '' y = "ASPxRoundPanel1"
        '        'Dim R = CType(y, ASPxRoundPanel)
        '        x = Me.Form.FindControl(y)
        '        x.HeaderStyle.BackColor = Color.Black
        '        'ctrl.ClientID.HeaderStyle.BackColor = Encabezado
        '        'x = y
        '    ElseIf ctrl.[GetType]() = GetType(ASPxCallbackPanel) Then
        '        y = ctrl.ClientID
        '        C = Me.Form.FindControl(y)
        '        If C.HasControls Then
        '            Dim childControl As UI.Control
        '            For Each childControl In ctrl.Controls
        '                If childControl.[GetType]() = GetType(ASPxRoundPanel) Then
        '                    y = childControl.ClientID
        '                    y = "ASPxRoundPanel1"
        '                    'Dim R = CType(y, ASPxRoundPanel)
        '                    x = Me.Form.FindControl(y)
        '                    x.HeaderStyle.BackColor = Encabezado
        '                End If
        '            Next childControl

        '        End If
        '    End If

        'Next

        Encabezado = cmbEncabezado.Value
        Back = cmbBack.Value
        Fore = cmbFore.Value

        ASPxRoundPanel1.HeaderStyle.BackColor = Encabezado
        ASPxRoundPanel2.HeaderStyle.BackColor = Encabezado
        ASPxRoundPanel4.HeaderStyle.BackColor = Encabezado
        ASPxRoundPanel3.HeaderStyle.BackColor = Encabezado

        ASPxRoundPanel1.BackColor = Back
        ASPxRoundPanel2.BackColor = Back
        ASPxRoundPanel4.BackColor = Back
        ASPxRoundPanel3.BackColor = Back

        ASPxRoundPanel1.ForeColor = Fore
        ASPxRoundPanel2.ForeColor = Fore
        ASPxRoundPanel3.ForeColor = Fore
        ASPxRoundPanel5.ForeColor = Fore



    End Sub
    Protected Sub cbGuardar_Callback(source As Object, e As CallbackEventArgs) Handles cbGuardar.Callback
        Dim fnc = New WsFuncionalidad.Funcionalidad
        Dim Resultado As Integer
        'Resultado = fnc.Fun_Tema(40, cmbTema.Text, 0, "ConexionDBS")
        Resultado = fnc.Fun_Tema(Session("iIdUsuario"), cmbTema.Text, 0, "ConexionDBS")
        If Resultado = 1 Then
            cbGuardar.JSProperties("cpAccion") = "Se Agrego la configuración del tema"
            Session("TemaDin") = Me.cmbTema.Text
            'MsgBox("Se Agrego la configuración del tema")
        Else
            cbGuardar.JSProperties("cpAccion") = "Se Actualizó la configuración del tema"
            Session("TemaDin") = Me.cmbTema.Text
            'MsgBox("Se Actualizó la configuración del tema")
        End If
    End Sub
End Class
