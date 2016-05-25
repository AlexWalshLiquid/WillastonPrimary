Imports Microsoft.VisualBasic
Imports System
Imports System.Web
Imports System.IO
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class file
    Private ReadOnly _conString As String

    Public Function ReturnCountResourceFiles(ByVal res_uid As String, ByVal file_type As String) As Integer
        Dim con As New SqlConnection(_conString)
        Dim value As Integer

        Dim cmd As New System.Data.SqlClient.SqlCommand
        cmd.Connection = con
        cmd.CommandType = Data.CommandType.StoredProcedure
        cmd.CommandText = "dbo.SelectCountResourceFiles"
        cmd.Parameters.AddWithValue("@res_uid", res_uid)
        cmd.Parameters.AddWithValue("@file_type", file_type)
        con.Open()
        value = cmd.ExecuteScalar
        con.Close()

        Return value
    End Function

    Public Function ReturnResourceFiles(ByVal res_uid As String, ByVal file_type As String) As DataSet
        Dim con As New SqlConnection(_conString)
        Dim sqlD As New SqlDataAdapter("dbo.SelectResourceFiles", _conString)
        sqlD.SelectCommand.CommandType = CommandType.StoredProcedure
        sqlD.SelectCommand.Parameters.Add(New SqlParameter("@res_uid", SqlDbType.VarChar, 50)).Value = res_uid
        sqlD.SelectCommand.Parameters.Add(New SqlParameter("@file_type", SqlDbType.VarChar, 5)).Value = file_type
        Dim datasetD As New DataSet
        con.Open()
        sqlD.Fill(datasetD, "files")
        con.Close()
        Return datasetD
    End Function

    Public Sub New()
        _conString = WebConfigurationManager.ConnectionStrings("LIQUIDConnectionString").ConnectionString
    End Sub

End Class
