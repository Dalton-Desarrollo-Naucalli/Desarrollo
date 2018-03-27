Public Class Funciones

    Public Shared Function ValorReal(ByVal Valor As Object, ByVal Tipo As Integer) As Object
        Select Case Tipo
            Case 1
                If Valor = 0 Then
                    Return "NULL"
                Else
                    Return Valor
                End If
            Case 2
                If Len(Trim(Valor)) = 0 Or IsDBNull(Valor) Or UCase(Valor) = "NULL" Then
                    Return "NULL"
                Else
                    Return "'" & RTrim$(Valor).Replace("'", "''") & "'"
                End If
            Case 3
                If Len(Valor) = 0 Or IsDBNull(Valor) Or UCase(Valor) = "NULL" Then
                    Return "NULL"
                Else
                    Return "'" & CStr(Valor).Replace("'", "''") & "'"
                End If
            Case 4
                If Len(Valor) = 0 Or IsDBNull(Valor) Or UCase(Valor) = "NULL" Then
                    Return "NULL"
                Else
                    Return CStr(Valor).Replace("/", "_") & "'"
                End If
            Case 5
                If Len(Trim(Valor)) = 0 Or IsDBNull(Valor) Or UCase(Valor) = "NULL" Then
                    Return "0"
                Else
                    Return CDbl(Valor).ToString.Trim
                End If
            Case Else
                Return Valor
        End Select
    End Function
End Class
