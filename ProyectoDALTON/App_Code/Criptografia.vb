Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Text

Imports System.Security.Cryptography
Imports System.IO


Namespace Modulos.WB.Clases


    Public Class Criptografia

        ''' <summary>
        ''' Este metodo encripta una cadena a traves del provider DES
        ''' </summary>
        ''' <param name="sCadena">La cadena a encriptar</param>
        ''' <returns>La cadena encriptada</returns>

        Public Shared Function EncriptaCadenaDES(ByVal sCadena As String) As String
            Return EncriptaDES(sCadena, "&%#@?,:*")

        End Function


        ''' <summary>
        ''' Este metodo privado de encriptacion es mandado llamar por el metodo publico para encriptar mediante el algoritmo DES
        ''' </summary>
        ''' <param name="strText">La cadena a encriptar</param>
        ''' <param name="strEncrKey">La cadena semilla</param>
        ''' <returns>La cadena encriptada</returns>
        ''' 
        Private Shared Function EncriptaDES(ByVal strText As String, ByVal strEncrKey As String) As String
            Dim bKey(8) As Byte
            Dim IV As Byte() = New Byte() {18, 52, 86, 120, 144, 171, 205, 239}
            bKey = System.Text.Encoding.UTF8.GetBytes(strEncrKey.Substring(0, 8))
            Dim des As New DESCryptoServiceProvider
            Dim inputByteArray As Byte() = Encoding.UTF8.GetBytes(strText)
            Dim ms As New MemoryStream()
            Dim cs As New CryptoStream(ms, des.CreateEncryptor(bKey, IV), CryptoStreamMode.Write)

            cs.Write(inputByteArray, 0, inputByteArray.Length)
            cs.FlushFinalBlock()
            Return Convert.ToBase64String(ms.ToArray())
        End Function


        ''' <summary>
        ''' Este metodo desencripta una cadena encriptada a traves del provider DES
        ''' </summary>
        ''' <param name="sCadena">Cadena a desencriptar</param>
        ''' <returns>Cadena desencriptada</returns>

        Public Shared Function DesencriptaCadenaDES(ByVal sCadena As String) As String
            Return DesencriptaDES(sCadena, "&%#@?,:*")
        End Function


        ''' <summary>
        ''' Este metodo es mandado llamar por el metodo publico para desencriptar una cadena que haya sido encriptada mediante el provider DES
        ''' </summary>
        ''' <param name="strText">La cadena a desencriptar</param>
        ''' <param name="strEncrKey">Una cadena semilla</param>
        ''' <returns>La cadena desencriptada</returns>
        Private Shared Function DesencriptaDES(ByVal strText As String, ByVal strEncrKey As String) As String
            Dim inputByteArray As Byte()
            Dim bKey As Byte() = New Byte(8 - 1) {}
            Dim IV As Byte() = New Byte() {18, 52, 86, 120, 144, 171, 205, 239}
            bKey = Encoding.UTF8.GetBytes(strEncrKey.Substring(0, 8))
            Dim des As New DESCryptoServiceProvider
            inputByteArray = Convert.FromBase64String(strText)
            Dim ms As New MemoryStream
            Dim cs As New CryptoStream(ms, des.CreateDecryptor(bKey, IV), CryptoStreamMode.Write)
            cs.Write(inputByteArray, 0, inputByteArray.Length)
            cs.FlushFinalBlock()

            Return Encoding.UTF8.GetString(ms.ToArray)
        End Function



        ''' <summary>
        ''' Este metodo encripta una cadena a traves del provider SHA1 (Hash),
        ''' este sera el metodo a usar para los password o cualquier otra cosa que
        ''' no necesita una posterior desencriptacion (los passwords se pueden resetear)
        ''' </summary>
        ''' <param name="sCadena">La cadena a encriptar</param>
        ''' <returns>La cadena encriptada</returns>
        ''' 

        Public Shared Function EncriptaCadenaSHA1(ByVal sCadena As String) As String
            Dim aCadenaBytes As Byte()
            Dim oSha1 As SHA1
            Dim aHashBytes As Byte()
            Dim sClaveEncriptada As String

            aCadenaBytes = System.Text.Encoding.UTF8.GetBytes(sCadena)
            oSha1 = New SHA1CryptoServiceProvider()
            aHashBytes = oSha1.ComputeHash(aCadenaBytes)
            sClaveEncriptada = Convert.ToBase64String(aHashBytes)

            Return sClaveEncriptada

        End Function



        Const StrClave As String = "Encripa"

        Public Shared Function EncriptarTexto(ByVal CadenaAEncriptar As String, Optional ByVal Clave As String = StrClave, Optional ByVal MantenerMayusculas As Boolean = True) As String
            Dim i As Integer, C As Integer
            Dim CadenaEncriptada As String = ""

            If MantenerMayusculas = False Then
                Clave = Clave.ToUpper()
                CadenaAEncriptar = CadenaAEncriptar.ToUpper()
            End If

            If Len(Clave) Then
                For i = 1 To Len(CadenaAEncriptar)
                    C = Asc(Mid$(CadenaAEncriptar, i, 1))
                    C = C + Asc(Mid$(Clave, (i Mod Len(Clave)) + 1, 1))
                    CadenaEncriptada = CadenaEncriptada & Chr(C And &HFF)
                Next i
            Else
                CadenaEncriptada = CadenaAEncriptar
            End If

            Return CadenaEncriptada
        End Function




        Public Shared Function DesencriptarTexto(ByVal CadenaADesencriptar As String, Optional ByVal Clave As String = StrClave, Optional ByVal MantenerMayusculas As Boolean = True) As String
            Dim i As Integer, C As Integer
            Dim CadenaDesencriptada As String = ""

            If MantenerMayusculas = False Then
                Clave = Clave.ToUpper
            End If

            If Len(Clave) Then
                For i = 1 To Len(CadenaADesencriptar)
                    C = Asc(Mid$(CadenaADesencriptar, i, 1))
                    C = C - Asc(Mid$(Clave, (i Mod Len(Clave)) + 1, 1))
                    CadenaDesencriptada += Chr(C And &HFF)
                Next i

            Else
                CadenaDesencriptada = CadenaADesencriptar
            End If

            Return CadenaDesencriptada
        End Function

    End Class

End Namespace