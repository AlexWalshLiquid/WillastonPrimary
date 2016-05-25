Imports Microsoft.VisualBasic
Imports System
Imports System.Web
Imports System.IO
Imports System.Data
Imports System.Data.SqlClient
Imports System.Web.Configuration

Public Class ControlValues

    Function ReturnSiteTitle() As String
        Dim title As String = "Willaston CE Primary School, South Wirral, Cheshire"
        Return title
    End Function

    Function checkInput(ByVal chkstring As String) As String
        chkstring = Replace(chkstring, ">", "")
        chkstring = Replace(chkstring, "<", "")
        Return chkstring
    End Function

    Function checkFormInput(ByVal chkstring As String) As String
        chkstring = Replace(chkstring, ">", "")
        chkstring = Replace(chkstring, "<", "")
        chkstring = Replace(chkstring, "*", "")
        chkstring = Replace(chkstring, "'", "")
        Return chkstring
    End Function

    Function CheckLineBreaks(ByVal chkstring As String) As String
        chkstring = Replace(chkstring, Environment.NewLine, " <br />")
        Return chkstring
    End Function

    Function checkUserFiles(ByVal chkstring As String) As String
        chkstring = Replace(chkstring, "/writedir/userfiles/", "http://admin.liquidclients.co.uk/writedir/userfiles/")
        Return chkstring
    End Function

End Class
