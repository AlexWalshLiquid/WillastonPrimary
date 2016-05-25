Imports Microsoft.VisualBasic
Imports System
Imports System.Web
Imports System.IO
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class resource
    Private ReadOnly _conString As String
    Private ReadOnly siteid As Integer = 16

    Public Function ReturnActiveResources(ByVal res_type As String) As DataSet

        Dim con As New SqlConnection(_conString)
        Dim sqlD As New SqlDataAdapter("SELECT * FROM dbo.tbl_resource WHERE res_type=@res_type and siteid=@siteid and active=1 and deleted=0 and ((not sdate >=getdate()) and expirydate >=getdate()) order by res_id desc", _conString)
        sqlD.SelectCommand.Parameters.AddWithValue("@res_type", res_type)
        sqlD.SelectCommand.Parameters.AddWithValue("@siteid", siteid)
        Dim datasetD As New DataSet
        con.Open()
        sqlD.Fill(datasetD, "res")
        con.Close()
        Return datasetD

    End Function

    Public Function CheckActiveResource(ByVal pageurl As String) As Integer
        Dim con As New SqlConnection(_conString)
        Dim value As Integer

        Dim cmd As New System.Data.SqlClient.SqlCommand
        cmd.Connection = con
        cmd.CommandType = Data.CommandType.StoredProcedure
        cmd.CommandText = "dbo.SelectCheckActiveResource"
        cmd.Parameters.AddWithValue("@pageurl", pageurl)
        cmd.Parameters.AddWithValue("@siteid", siteid)
        con.Open()
        value = cmd.ExecuteScalar
        con.Close()

        Return value
    End Function

    Public Function ReturnActiveResource_ByURL(ByVal pageurl As String) As DataSet
        Dim con As New SqlConnection(_conString)
        Dim sqlD As New SqlDataAdapter("dbo.SelectActiveResource_ByURL", _conString)
        sqlD.SelectCommand.CommandType = CommandType.StoredProcedure
        sqlD.SelectCommand.Parameters.Add(New SqlParameter("@pageurl", SqlDbType.VarChar, 1000)).Value = pageurl
        sqlD.SelectCommand.Parameters.Add(New SqlParameter("@siteid", SqlDbType.Int, 3)).Value = siteid
        Dim datasetD As New DataSet
        con.Open()
        sqlD.Fill(datasetD, "res")
        con.Close()
        Return datasetD
    End Function

    Public Function ReturnResources_Top4_WithFile(ByVal res_type As String, ByVal file_type As String) As DataSet

        Dim con As New SqlConnection(_conString)
        Dim sqlD As New SqlDataAdapter("SELECT top 4 t1.res_uid, t1.pageurl, t1.res_title, t1.res_date, t1.res_summary, t2.file_title FROM dbo.tbl_resource as t1, tbl_resourcefiles as t2 WHERE t1.res_uid=t2.res_uid and t1.res_type=@res_type and t1.siteid=@siteid and t1.deleted=0 and t1.active=1 and t2.active=1 and t2.file_type=@file_type and t2.mainimg=1 order by t1.res_id desc", _conString)
        sqlD.SelectCommand.Parameters.AddWithValue("@res_type", res_type)
        sqlD.SelectCommand.Parameters.AddWithValue("@siteid", siteid)
        sqlD.SelectCommand.Parameters.AddWithValue("@file_type", file_type)
        Dim datasetD As New DataSet
        con.Open()
        sqlD.Fill(datasetD, "res")
        con.Close()
        Return datasetD

    End Function

    Public Function ReturnResources_Top4(ByVal res_type As String) As DataSet

        Dim con As New SqlConnection(_conString)
        Dim sqlD As New SqlDataAdapter("SELECT TOP 4 res_uid, pageurl, res_title, res_date, res_summary FROM tbl_resource WHERE (res_type = @res_type) AND (siteid = @siteid) AND active = 1 and deleted = 0 ORDER BY res_id DESC", _conString)
        sqlD.SelectCommand.Parameters.AddWithValue("@res_type", res_type)
        sqlD.SelectCommand.Parameters.AddWithValue("@siteid", siteid)
        Dim datasetD As New DataSet
        con.Open()
        sqlD.Fill(datasetD, "res")
        con.Close()
        Return datasetD

    End Function

    Public Function ReturnResources(ByVal res_type As String) As DataSet

        Dim con As New SqlConnection(_conString)
        Dim sqlD As New SqlDataAdapter("SELECT res_uid, pageurl, res_title, res_date, res_summary FROM tbl_resource WHERE (res_type = @res_type) AND (siteid = @siteid) AND active = 1 and deleted = 0 ORDER BY res_id DESC", _conString)
        sqlD.SelectCommand.Parameters.AddWithValue("@res_type", res_type)
        sqlD.SelectCommand.Parameters.AddWithValue("@siteid", siteid)
        Dim datasetD As New DataSet
        con.Open()
        sqlD.Fill(datasetD, "res")
        con.Close()
        Return datasetD

    End Function

    Public Function ReturnResources_All_WithFile(ByVal res_type As String, ByVal file_type As String) As DataSet

        Dim con As New SqlConnection(_conString)
        Dim sqlD As New SqlDataAdapter("SELECT t1.res_uid, t1.pageurl, t1.res_title, t1.res_date, t1.res_summary, t2.file_title FROM dbo.tbl_resource as t1, tbl_resourcefiles as t2 WHERE t1.res_uid=t2.res_uid and t1.res_type=@res_type and t1.siteid=@siteid and t1.deleted=0 and t1.active=1 and t2.active=1 and t2.file_type=@file_type order by t1.res_id desc", _conString)
        sqlD.SelectCommand.Parameters.AddWithValue("@res_type", res_type)
        sqlD.SelectCommand.Parameters.AddWithValue("@siteid", siteid)
        sqlD.SelectCommand.Parameters.AddWithValue("@file_type", file_type)
        Dim datasetD As New DataSet
        con.Open()
        sqlD.Fill(datasetD, "res")
        con.Close()
        Return datasetD

    End Function

    Public Function ReturnGalleryImages_byURL(ByVal res_type As String, ByVal file_type As String, ByVal galleryid As String) As DataSet

        Dim con As New SqlConnection(_conString)
        Dim sqlD As New SqlDataAdapter("SELECT t1.res_uid, t1.pageurl, t1.res_title, t1.res_date, t1.res_summary, t2.file_title FROM dbo.tbl_resource as t1, tbl_resourcefiles as t2 WHERE t1.res_uid=t2.res_uid and t1.res_type=@res_type and t1.siteid=@siteid and t1.deleted=0 and t1.active=1 and t2.active=1 and t2.file_type=@file_type AND t1.res_id = @galleryid order by NEWID()", _conString)
        sqlD.SelectCommand.Parameters.AddWithValue("@res_type", res_type)
        sqlD.SelectCommand.Parameters.AddWithValue("@siteid", siteid)
        sqlD.SelectCommand.Parameters.AddWithValue("@galleryid", galleryid)
        sqlD.SelectCommand.Parameters.AddWithValue("@file_type", file_type)
        Dim datasetD As New DataSet
        con.Open()
        sqlD.Fill(datasetD, "res")
        con.Close()
        Return datasetD

    End Function

    Public Function ReturnGalleryImagesForHeader_byURL(ByVal res_type As String, ByVal file_type As String, ByVal galleryid As String) As DataSet

        Dim con As New SqlConnection(_conString)
        Dim sqlD As New SqlDataAdapter("SELECT TOP 20 t1.res_uid, t1.pageurl, t1.res_title, t1.res_date, t1.res_summary, t2.file_title FROM dbo.tbl_resource as t1, tbl_resourcefiles as t2 WHERE t1.res_uid=t2.res_uid and t1.res_type=@res_type and t1.siteid=@siteid and t1.deleted=0 and t1.active=1 and t2.active=1 and t2.file_type=@file_type AND t1.res_id = @galleryid order by NEWID()", _conString)
        sqlD.SelectCommand.Parameters.AddWithValue("@res_type", res_type)
        sqlD.SelectCommand.Parameters.AddWithValue("@siteid", siteid)
        sqlD.SelectCommand.Parameters.AddWithValue("@galleryid", galleryid)
        sqlD.SelectCommand.Parameters.AddWithValue("@file_type", file_type)
        Dim datasetD As New DataSet
        con.Open()
        sqlD.Fill(datasetD, "res")
        con.Close()
        Return datasetD

    End Function

    Public Sub New()
        _conString = WebConfigurationManager.ConnectionStrings("LIQUIDConnectionString").ConnectionString
    End Sub

End Class
