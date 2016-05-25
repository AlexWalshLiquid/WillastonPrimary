Imports Microsoft.VisualBasic
Imports System
Imports System.Web
Imports System.IO
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class page
    Private ReadOnly _conString As String
    Private ReadOnly siteid As Integer = 16

    Public Function CheckActivePage(ByVal pageurl As String) As Integer
        Dim con As New SqlConnection(_conString)
        Dim value As Integer

        Dim cmd As New System.Data.SqlClient.SqlCommand
        cmd.Connection = con
        cmd.CommandType = Data.CommandType.StoredProcedure
        cmd.CommandText = "dbo.SelectCheckActivePage"
        cmd.Parameters.AddWithValue("@pageurl", pageurl)
        cmd.Parameters.AddWithValue("@siteid", siteid)
        con.Open()
        value = cmd.ExecuteScalar
        con.Close()

        Return value
    End Function

    Public Function ReturnPage_ByID(ByVal pageid As Integer) As DataSet
        Dim con As New SqlConnection(_conString)
        Dim sqlD As New SqlDataAdapter("dbo.SelectPage", _conString)
        sqlD.SelectCommand.CommandType = CommandType.StoredProcedure
        sqlD.SelectCommand.Parameters.Add(New SqlParameter("@pageid", SqlDbType.Int, 4)).Value = pageid
        sqlD.SelectCommand.Parameters.Add(New SqlParameter("@siteid", SqlDbType.Int, 3)).Value = siteid
        Dim datasetD As New DataSet
        con.Open()
        sqlD.Fill(datasetD, "page")
        con.Close()
        Return datasetD
    End Function

    Public Function ReturnPage_ByURL(ByVal pageurl As String) As DataSet
        Dim con As New SqlConnection(_conString)
        Dim sqlD As New SqlDataAdapter("dbo.SelectPage_ByURL", _conString)
        sqlD.SelectCommand.CommandType = CommandType.StoredProcedure
        sqlD.SelectCommand.Parameters.Add(New SqlParameter("@pageurl", SqlDbType.VarChar, 100)).Value = pageurl
        sqlD.SelectCommand.Parameters.Add(New SqlParameter("@siteid", SqlDbType.Int, 3)).Value = siteid
        Dim datasetD As New DataSet
        con.Open()
        sqlD.Fill(datasetD, "page")
        con.Close()
        Return datasetD
    End Function

    Public Function ReturnActivePages_ByParentID(ByVal parentid As Integer) As DataSet
        Dim con As New SqlConnection(_conString)
        Dim sqlD As New SqlDataAdapter("dbo.ReturnActivePages_ByParentID", _conString)
        sqlD.SelectCommand.Parameters.Add(New SqlParameter("@parentid", SqlDbType.Int, 4)).Value = parentid
        sqlD.SelectCommand.Parameters.Add(New SqlParameter("@siteid", SqlDbType.Int, 3)).Value = siteid
        Dim datasetD As New DataSet
        con.Open()
        sqlD.Fill(datasetD, "page")
        con.Close()
        Return datasetD
    End Function

    Public Function ReturnPageURL(ByVal pageid As String) As String
        Dim con As New SqlConnection(_conString)
        Dim value As String

        Dim cmd As New System.Data.SqlClient.SqlCommand
        cmd.Connection = con
        cmd.CommandType = Data.CommandType.StoredProcedure
        cmd.CommandText = "dbo.SelectPageURL"
        cmd.Parameters.AddWithValue("@pageid", pageid)
        con.Open()
        value = cmd.ExecuteScalar
        con.Close()

        Return value
    End Function

    Public Function ReturnFiles(ByVal res_uid As String) As DataSet
        Dim con As New SqlConnection(_conString)
        Dim files As New DataSet
        con.Open()

        Dim sqlD As New SqlDataAdapter("SELECT * FROM tbl_resourcefiles where res_uid=@res_uid and active=1 order by file_id", _conString)
        sqlD.SelectCommand.Parameters.AddWithValue("@res_uid", res_uid)

        sqlD.Fill(files)
        con.Close()
        Return files
    End Function

    Public Sub New()
        _conString = WebConfigurationManager.ConnectionStrings("LIQUIDConnectionString").ConnectionString
    End Sub

End Class
