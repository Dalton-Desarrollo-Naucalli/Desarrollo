Imports Microsoft.VisualBasic
Imports System
Imports System.Collections.Generic
Imports System.Text
Imports System.Data

Imports System.Web.UI
Namespace UtileriasNegocio

    Public Class Utilerias


        Private consulta As String
        Private TipoNomina As Integer
        Private ParametroFolio As Integer
        Private Const iMAX_STRING_LEN As Integer = 255
        Declare Function GetProfileString Lib "kernel32" Alias "GetProfileStringA" (ByVal lpAppName As String, ByVal lpKeyName As String, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Integer) As Integer
        Private Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationName As String, ByVal lpKeyName As String, ByVal lpDefault As String, ByVal lpReturnedString As String, ByVal nSize As Integer, ByVal lpFileName As String) As Integer




        Public Shared Function ValidaNulos(ByVal Valor As Object) As Object
            Dim VariableValida As Object

            If Valor = Nothing Then
                VariableValida = DBNull.Value
            Else
                VariableValida = Valor
            End If

            Return VariableValida
        End Function
        ''' -----------------------------------------------------------------------------
        ''' <summary>
        ''' Funcion que pone las comillas simples o regresa nulos dependieno del tipo
        ''' </summary>
        ''' <param name="Valor">Valor al cula se le van a poner comillas o se convertira</param>
        ''' <param name="Tipo">
        '''1=Entero entra 0 regresa null
        '''2=Alfanumérico entra SSVR regresa ‘SSVR’
        '''3=Textos si un valor tiene ‘ entra AD’EM te regresa ‘AD’’EM’
        '''4=Trabajadores Nombre para el nombre trabajador  entra Oswaldo/Media sale Oswaldo_Medina
        '''5=double		si entra “ ” regresa 0 
        ''' </param> 
        ''' <returns></returns>
        ''' <remarks>
        ''' </remarks>
        ''' <history>
        ''' 	[Oswaldo Medina]	13/03/2007	Created
        ''' </history>
        ''' -----------------------------------------------------------------------------
        ''' 
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

        Public Function sFolioTrabajador(ByVal sTrabajador As String) As String

            ' Devuelve el folio del trabajador con las caracteristicas especificadas
            ' en los Parámetros

            iParametroFolio()

            Dim valorRegreso As String = ""

            Select Case TipoNomina
                Case 1
                    valorRegreso = Justificar(sTrabajador, 1, 2, 10)
                Case 2
                    valorRegreso = Justificar(sTrabajador, 2, 2, 10)
                Case 3
                    valorRegreso = Justificar(sTrabajador, 2, 1, 10)
            End Select

            Return valorRegreso

        End Function
        Public Function FolioCliente(ByVal CodCliente As Integer, ByVal TipoOrientacion As Integer) As String

            ' Devuelve el folio del cliente con las caracteristicas 0000000001


            Dim valorRegreso As String = ""

            Select Case TipoOrientacion
                Case 1
                    valorRegreso = Justificar(CodCliente, 2, 1, 10)
                Case 2
                    valorRegreso = Justificar(CodCliente, 2, 2, 10)
                Case 3
                    valorRegreso = Justificar(CodCliente, 1, 2, 10)
            End Select

            Return valorRegreso

        End Function

        Public Function sEncriptadorProcesos(ByVal sCadenaOriginal As String) As String
            Dim valores1 As Integer(,)    '61,3
            Dim valores2() As Byte      '61
            Dim longitud As Integer
            Dim sCadenaEncriptada As String = ""
            Dim sCadenaEncriptada2 As String = ""
            Dim sCaracterNumerico As String
            Dim i As Integer
            Dim iCadenaoNumero As Integer

            Const DESPLAZAMIENTOD As Int16 = 2
            Const DESPLAZAMIENTOI As Int16 = 6


            longitud = Len(sCadenaOriginal)

            ReDim valores1(longitud, 3)
            ReDim valores2(longitud)

            For i = 1 To longitud
                valores1(i, 0) = Int(Asc(Mid(sCadenaOriginal, i, 1)) / 2 ^ DESPLAZAMIENTOD)
                valores1(i, 1) = (Asc(Mid(sCadenaOriginal, i, 1)) * 2 ^ DESPLAZAMIENTOI) And (Not &HFF00)
                valores1(i, 2) = Asc(Mid(sCadenaOriginal, i, 1))
            Next i

            valores2(1) = valores1(1, 0) + valores1(longitud, 1)

            For i = 2 To longitud
                valores2(i) = valores1(i, 0) + valores1(i - 1, 1)
            Next i
            For i = 1 To longitud
                sCaracterNumerico = Format(valores2(i), "000")
                sCadenaEncriptada = sCadenaEncriptada & Chr(valores2(i))
                sCadenaEncriptada2 = sCadenaEncriptada2 & sCaracterNumerico
            Next i

            iCadenaoNumero = 1

            If iCadenaoNumero = 0 Then
                sEncriptadorProcesos = sCadenaEncriptada
            Else
                sEncriptadorProcesos = sCadenaEncriptada2
            End If

        End Function


        Public Function Justificar(ByVal Folio As String, ByVal Orientacion As Integer, ByVal Caracter As Integer, ByVal Longitud As Integer) As String

            Dim Caractercadena As String

            ' Determinar con que caracter va ha sustituir
            If Caracter = 1 Then
                Caractercadena = "0"
            Else
                Caractercadena = " "
            End If

            Folio = Folio.Trim

            ' Forma la cadena de Espacios o Ceros
            Dim FolioTemporal As String = ""
            Dim valorRegreso As String = ""

            If Len(Trim(Folio)) > 0 Then
                For contadorcaracter As Integer = 1 To Longitud - Folio.Trim.Length
                    FolioTemporal += Caractercadena
                Next contadorcaracter
                ' Agrega al principio o al final del folio la cadena formada de acuerdo
                ' al parámetro iOrientación
                If Orientacion = 1 Then
                    valorRegreso = Folio & FolioTemporal
                Else
                    valorRegreso = FolioTemporal & Folio
                End If
            End If

            Return valorRegreso

        End Function


        Public Function Formateafecha(ByVal fecha As Date) As String

            'Dim fechaTemp As String

            Return ValorReal(Format(fecha, "yyyy") & Format(fecha.Month, "00") & Format(fecha.Day, "00"), 2)

        End Function
        Public Shared Function LimpiaCadena(ByVal Cadena As String) As String
            'Descripcion: Extrae caracteres especiales y espacios en blanco innecesarios
            Dim Contador As Integer
            Dim CadenaAuxiliar As String
            CadenaAuxiliar = Cadena
            For Contador = 1 To Len(CadenaAuxiliar)
                If (Asc(Mid(CadenaAuxiliar, Contador, 1)) < 65 Or Asc(Mid(CadenaAuxiliar, Contador, 1)) > 90) And Asc(Mid(CadenaAuxiliar, Contador, 1)) <> 32 And Asc(Mid(CadenaAuxiliar, Contador, 1)) <> 209 Then
                    CadenaAuxiliar = (Mid(CadenaAuxiliar, Contador, 1).Replace("", CadenaAuxiliar))
                    Contador -= 1
                End If
                If Contador = Len(CadenaAuxiliar) Then Exit For
            Next Contador
            'Extrae espacios en blanco
            For Contador = 1 To Len(Trim(CadenaAuxiliar))
                If Asc(Mid(CadenaAuxiliar, Contador, 1)) = 32 Then
                    If Asc(Mid(CadenaAuxiliar, Contador + 1, 1)) = 32 Then
                        CadenaAuxiliar = Mid(CadenaAuxiliar, 1, Contador) + "" + Mid(CadenaAuxiliar, Contador + 2)
                        Contador -= 1
                    End If
                End If
                If Contador = Len(CadenaAuxiliar) Then Exit For
            Next Contador

            Return CadenaAuxiliar
        End Function

        Public Shared Function BorraAcentos(ByVal sCampo As String) As String

            Dim Borra As String

            Borra = sCampo
            If (Not IsDBNull(sCampo) Or sCampo <> "") Then
                If InStr(1, sCampo, "Á", 1) Then
                    Borra = Borra.Replace("Á", "A")
                End If
                If InStr(1, sCampo, "É", 1) Then
                    Borra = Borra.Replace("É", "E")
                End If
                If InStr(1, sCampo, "Í", 1) Then
                    Borra = Borra.Replace("Í", "I")
                End If
                If InStr(1, sCampo, "Ó", 1) Then
                    Borra = Borra.Replace("Ó", "O")
                End If
                If InStr(1, sCampo, "Ú", 1) Then
                    Borra = Borra.Replace("Ú", "U")
                End If
            End If

            Return Borra

        End Function
        ''' -----------------------------------------------------------------------------
        ''' <summary>
        ''' Calcula el dígito verificador para el número especificado en Digito
        '''  y en la base especificada por Base
        ''' Uso          : CalculaDigito(Digito, Base)
        ''' </summary>
        ''' <param name="Digito"> Número al cual se le calculará el dígito verificador</param>
        ''' <param name="Base"> Base en la cual se calculará el dígito verificador</param>
        ''' <returns> Dígito verificador para el número enviado en el parámetro Digito</returns>
        ''' <remarks>
        ''' </remarks>
        ''' <history>
        ''' </history>
        ''' -----------------------------------------------------------------------------
        Public Function CalculaDigito(ByVal Digito As Double, ByVal Base As Integer) As String

            Dim Tot As Integer         ' Acumulado de la multiplicación de cada dígito por el factor
            Dim Longitud As Integer    ' Longitud del Número al cual se le calculará el Dígito
            Dim Factor As Integer      ' Factor para realizar el Cálculo
            Dim contador As Integer            ' Contador del For
            Dim Residuo As Integer     ' Contendrá cada dígito dela función multiplicado por el Factor
            Dim Numero As String       ' Número a calcular el dígito sin espacios a la derecha e izquierda
            Dim Modulo As Integer      ' Dígito Verificador calculado y devuelto en la función
            Dim Total As Integer       ' Cálculo adicional cuando se trata de base 12
            'Dim cadenaDigito As String       ' Dígito verificador

            Numero = Digito.ToString.TrimEnd.TrimStart
            Longitud = Numero.Length
            Tot = 0
            Select Case Base
                Case 10
                    Factor = 2
                    For contador = Longitud To 1 Step -1
                        Residuo = Val(Mid(Numero, contador, 1)) * Factor
                        Residuo = (Residuo Mod 10) + Residuo \ 10
                        Tot += Residuo
                        Factor = 3 - Factor
                    Next contador
                    Modulo = (10 - (Tot Mod 10)) Mod 10
                Case 11
                    Factor = 2
                    For contador = Longitud To 1 Step -1
                        Tot += (CInt(Mid(Numero, contador, 1)) * Factor)
                        Factor += 1
                        If Factor > 7 Then Factor = 2
                    Next contador

                    Residuo = Tot Mod 11
                    Modulo = 11 - Residuo

                    Select Case Modulo
                        Case 10
                            Digito = "K"
                        Case 11
                            Digito = "0"
                        Case Else
                            Digito = CInt(Modulo)
                    End Select

                    Return Digito
                    Exit Function

                Case 12
                    Factor = 2
                    For contador = Longitud To 1 Step -1
                        Residuo = Val(Mid$(Numero, contador, 1)) * Factor
                        Residuo = (Residuo Mod 10) + Residuo \ 10
                        Tot += Residuo
                        Factor = 3 - Factor
                    Next contador
                    Total = Tot
                    Total = Total \ 5
                    If Tot Mod 5 = 0 And Total Mod 2 <> 0 Then
                        Modulo = 0
                    Else
                        Total = Total \ 2
                        Total = 5 * (Total * 2 + 1)
                        Modulo = Total - Tot
                        If Modulo < 0 Then Modulo += 10
                    End If
            End Select
            Return CStr(Modulo)

        End Function

        Public Shared Function FormatoFechaCorto() As String

            ' Dim cultura As System.Globalization.CultureInfo
            Dim FormatoCorto As String

            FormatoCorto = Globalization.CultureInfo.CurrentCulture.DateTimeFormat.ShortDatePattern().ToString()

            Return FormatoCorto

        End Function

        Public Shared Function FormatoHoraCorto() As String

            Dim FormatoTime As String

            FormatoTime = Globalization.CultureInfo.CurrentCulture.DateTimeFormat.ShortTimePattern().ToString()
            Return FormatoTime



        End Function


        Public Shared Function FormatoImportes() As String

            Dim FormatoImp As String = "#" & Globalization.CultureInfo.CurrentCulture.NumberFormat.CurrencyGroupSeparator & "##0"

            'Dim FormatoImp As String = "#" & cultura.CurrentCulture.NumberFormat.NumberGroupSeparator & "##0"

            Dim decimales As String = New String("0", Globalization.CultureInfo.CurrentCulture.NumberFormat.CurrencyDecimalDigits)

            'Dim decimales As String = New String("0", cultura.CurrentCulture.NumberFormat.NumberDecimalDigits)

            FormatoImp += Globalization.CultureInfo.CurrentCulture.NumberFormat.NumberDecimalSeparator & decimales


            Return FormatoImp

        End Function

        Public Shared Function FormatoEnteros() As String

            Dim separador As String = ""

            Dim FormatoImp As String = "#" & separador & "##0"

            Dim decimales As String = New String("0", 0)

            FormatoImp += decimales

            Return FormatoImp

        End Function

        Public Shared Function NombreMes(ByVal iMes As Integer) As String


            Dim Nombre As String

            Nombre = Globalization.CultureInfo.CurrentCulture.DateTimeFormat.MonthNames(iMes)


            Return Nombre

        End Function


        Public Function iParametroFolio() As Integer
            'Return ParametroFolio = 2

            ParametroFolio = 2
            TipoNomina = 2
        End Function

        Public Function ObtenParametro(ByVal valor As String, ByVal parametro As String, ByVal tabla As String, ByVal secuencia As String, Optional ByVal compania As String = "0", Optional ByVal where As String = "") As String


            Dim valorParametro As Object = Nothing

            Return IIf(valorParametro Is System.DBNull.Value, Nothing, valorParametro)


        End Function



        Public Function DescomprimeDatos(ByVal data() As Byte) As Byte()
            Try
                '---copy the data (compressed) into ms---
                Dim ms As New System.IO.MemoryStream(data)
                Dim zipStream As System.IO.Stream = Nothing

                '---decompressing using data stored in ms---
                zipStream = New System.IO.Compression.GZipStream(ms, IO.Compression.CompressionMode.Decompress)
                '---or---
                'zipStream = New DeflateStream(ms, _
                '                CompressionMode.Decompress, True)

                '---used to store the decompressed data---
                Dim dc_data() As Byte

                '---the decompressed data is stored in zipStream; 
                ' extract them out into a byte array---
                dc_data = ExtractBytesFromStream(zipStream, data.Length)

                Return dc_data
            Catch ex As Exception
                Return Nothing
            End Try
        End Function

        Public Function ExtractBytesFromStream(
           ByVal stream As System.IO.Stream,
           ByVal dataBlock As Integer) _
           As Byte()

            '---extract the bytes from a stream object---
            Dim data() As Byte
            Dim totalBytesRead As Integer = 0
            Try
                While True
                    '---progressively increase the size 
                    ' of the data byte array---
                    ReDim Preserve data(totalBytesRead + dataBlock)
                    Dim bytesRead As Integer =
                       stream.Read(data, totalBytesRead, dataBlock)
                    If bytesRead = 0 Then
                        Exit While
                    End If
                    totalBytesRead += bytesRead
                End While
                '---make sure the byte array contains exactly the number 
                ' of bytes extracted---
                ReDim Preserve data(totalBytesRead - 1)
                Return data
            Catch ex As Exception
                Return Nothing
            End Try
        End Function

        Public Function ConvertArrayBytesToDataSet(ByVal xmlConvertir As Byte()) As DataSet

            Dim ds As New Data.DataSet
            Dim ArregloDeBytes() As Byte
            Try
                ArregloDeBytes = DescomprimeDatos(xmlConvertir)
                ds.ReadXml(New IO.StringReader(System.Text.Encoding.UTF8.GetString(ArregloDeBytes)))
            Catch ex As Exception
                Throw New Exception(ex.Message)
            End Try
            Return ds
        End Function

        Public Function ComprimeDatos(ByVal data() As Byte) As Byte()

            Try
                Dim ms As New IO.MemoryStream()   ' almacena los datos comprimidos en esta variable
                Dim zipStream As IO.Stream = Nothing

                zipStream = New IO.Compression.GZipStream(ms, IO.Compression.CompressionMode.Compress, True)

                '---compression de los datos---
                zipStream.Write(data, 0, data.Length)
                zipStream.Close()

                ms.Position = 0
                '---used to store the compressed data (byte array)---
                Dim compressed_data(ms.Length - 1) As Byte
                ' lee el contenido del stream y lo almacena en el arreglo de Bytes()
                ms.Read(compressed_data, 0, ms.Length)
                Return compressed_data

            Catch ex As Exception
                Return Nothing
            End Try

        End Function


        Public Function GeneraAleatorio() As Integer
            Dim Resultado As Integer
            Randomize()
            Resultado = CInt((2000 * Rnd()) + 1000) * -1

            Return Resultado

        End Function


    End Class
End Namespace


