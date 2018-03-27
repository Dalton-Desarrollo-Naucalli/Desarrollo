Public Class ServicioDatosFactory
    Public Shared Function GetServicioDatos() As IClienteServicioDatos
        '

        Dim conexionActual As ConexionBackend
        conexionActual = ConexionBackend.ConexionDefault


        If conexionActual Is Nothing Then
        End If




        Return conexionActual.CrearClienteAccesoDatos

    End Function

    Public Shared Function getSeguridadCompania() As String
        '

        ' ejemplo de uso
        ' en cualquier parte de la solucion general
        ' ServicioDatosFactory.getSeguridadCompania
        Dim Datos As IClienteServicioDatos
        Dim usuario As String = ConexionBackend.ConexionDefault.Usuario
        Dim query As String
        Dim dsCompanias As New DataSet
        'Dim numeroRegistros As Int32
        Dim pivote As Int32
        Dim companias As String = ""
        Dim variableAuxiliar As String
        '
        Datos = ServicioDatosFactory.GetServicioDatos
        '
        Try
            Datos = ServicioDatosFactory.GetServicioDatos
            '
            query = "select compania from aut_companias where usuario= " & Funciones.ValorReal(usuario, 2)
            '
            Datos.LlenarDataSet(query, dsCompanias)
            '
            If dsCompanias.Tables(0).Rows.Count() > 0 Then
                For pivote = 0 To dsCompanias.Tables(0).Rows.Count() - 1
                    variableAuxiliar = dsCompanias.Tables(0).Rows(pivote).Item(0)
                    If companias.Trim.Length > 0 Then
                        companias = companias & "," & Funciones.ValorReal(variableAuxiliar, 2)
                    Else
                        companias = Funciones.ValorReal(variableAuxiliar, 2)

                    End If
                Next
            Else
                Return ""
            End If
            Return companias
        Catch ex As Exception
            Return ""
        End Try
    End Function



End Class
