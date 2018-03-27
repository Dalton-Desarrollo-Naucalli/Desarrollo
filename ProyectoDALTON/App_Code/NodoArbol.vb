Imports Microsoft.VisualBasic

Public Class NodoArbol



    Public Datos As Hashtable
    Public arrayDatos As ArrayList
    Public Sub New()

    End Sub
    Public Sub New(ByVal Datos As ArrayList)
        Me.arrayDatos = Datos
    End Sub
    Public Sub New(ByVal Datos As Hashtable)
        Me.Datos = Datos
    End Sub
    Public Function Obtencadenadedatos() As String
        Dim cadenadedatos As String = ""
        Dim DatosHash() As Object
        ReDim DatosHash(Me.Datos.Count)
        Me.Datos.CopyTo(DatosHash, 0)

        For i As Integer = 0 To DatosHash.Length - 2
            If i = 0 Then
                cadenadedatos = DatosHash(0).value.ToString
            Else
                cadenadedatos = cadenadedatos & "|" & DatosHash(i).value.ToString
            End If
        Next i
        Return cadenadedatos
    End Function
    Public Function ObtenCadenasDatos() As String
        Dim cadenadedatos As String = ""

        For i As Integer = 0 To arrayDatos.Count - 1
            If i = 0 Then
                cadenadedatos = arrayDatos(0).ToString
            Else
                cadenadedatos = cadenadedatos & "|" & arrayDatos(i).ToString
            End If
        Next i
        Return cadenadedatos
    End Function

End Class
