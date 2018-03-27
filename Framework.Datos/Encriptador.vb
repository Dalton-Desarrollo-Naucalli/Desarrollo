Public Class Encriptador

    Private msPassword As String


    Function CryptoEncrypt(ByVal inputBuffer As String) As String

        Dim i As Integer, C As Integer
        Dim sBuff As String = ""

        msPassword = "B98BA745FFFFF46400004DEC9CA12429D6048C4F"

        For i = 1 To Len(inputBuffer)
            C = Asc(Mid$(inputBuffer, i, 1))
            C = C + Asc(Mid$(msPassword, (i Mod Len(msPassword)) + 1, 1))
            sBuff = sBuff & Chr(C And &HFF)
        Next i
        Return sBuff
    End Function


    Function CryptoDecrypt(ByVal inputBuffer As String) As String
        Dim i As Integer, C As Integer
        Dim sBuff As String = ""

        msPassword = "B98BA745FFFFF46400004DEC9CA12429D6048C4F"

        For i = 1 To Len(inputBuffer)
            C = Asc(Mid$(inputBuffer, i, 1))
            C = C - Asc(Mid$(msPassword, (i Mod Len(msPassword)) + 1, 1))
            sBuff = sBuff & Chr(C And &HFF)
        Next i

        Return sBuff
    End Function


End Class
