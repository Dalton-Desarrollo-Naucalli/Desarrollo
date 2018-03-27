Public Class MensajesError
    Public Shared StrMensaje As New Hashtable
    Public Shared Usuarios As String
    Private Shared MessagesLock As New Object

    Public Shared Sub addAnotherMessage(ByVal newMessage As String)
        SyncLock MessagesLock

            StrMensaje(Usuarios) = newMessage
        End SyncLock

    End Sub


    Public Shared Property MensajeError(ByVal LLaveMem As String) As String

        Get
            ' Usuarios = Usuario
            Return StrMensaje(LLaveMem)

        End Get
        Set(ByVal value As String)

            ' Usuarios = Usuario
            StrMensaje(LLaveMem) = value





        End Set
    End Property
    Public Shared Function AsignaMensajeUsuario(ByVal LLave As String, ByVal Usuario As String) As String
        Dim Msg As String = MensajeError(LLave)
        MensajeError(Usuario) = Msg
        StrMensaje.Remove(LLave)
        Return Msg
    End Function

End Class
