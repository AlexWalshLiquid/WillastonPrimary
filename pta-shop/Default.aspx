<%@ Page Title="" Language="VB" MasterPageFile="~/masterpages/main.master" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<script runat="server">
    
    Dim pageclass As New page
    Dim fileclass As New file
    Dim resourceclass As New resource
    Dim pageid As Integer
    Dim cv As New ControlValues
    Dim sitename As String = cv.ReturnSiteTitle()
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        CType(Master.FindControl("ptaHL"), HyperLink).CssClass = "ptamenu_selected" 'select menu item
        CType(Master.FindControl("galleryPNL"), Panel).Visible = False
        
        Dim pageurl As String = Request.QueryString("id")
        If [String].IsNullOrEmpty(pageurl) Then 'no ID so section homepage
            pageurl = "~/pta-shop/"
        End If
        pageurl = cv.checkInput(pageurl)
        
        If Not pageclass.CheckActivePage(pageurl) = 1 Then
            Response.Redirect("~/error/error-404.htm") 'ID but no match
        Else 'populate
            Dim ds As New DataSet
            ds = pageclass.ReturnPage_ByURL(pageurl)
            pageid = ds.Tables("page").Rows(0)("pageid")
            Dim pagetitle As String = ds.Tables("page").Rows(0)("pagetitle")
            Dim pageuid As String = ds.Tables("page").Rows(0)("pageuid")
            textdiv.InnerHtml = cv.checkUserFiles(ds.Tables("page").Rows(0)("pagetext"))
            titleLT.Text = pagetitle
            Page.Title = pagetitle & " | " & sitename
            
            MetaData(ds.Tables("page").Rows(0)("metadescription"), ds.Tables("page").Rows(0)("metakeywords"))
            
            'Set background
            DirectCast(Master.FindControl("Body"), HtmlGenericControl).Attributes.Add("class", "bg_paint")

            'Set section class
            DirectCast(Master.FindControl("contentID"), HtmlGenericControl).Attributes.Add("class", "content_wrapper pta")
            
            ''Polaroids
            'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/community_p1.png);")
            'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/community_p2.png);")
            'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/community_p3.png);")
            'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/community_p4.png);")
        
            'embed code
            If Not [String].IsNullOrEmpty(ds.Tables("page").Rows(0)("pageembed")) Then
                embeddiv.InnerHtml = "<br /><br />" & ds.Tables("page").Rows(0)("pageembed")
            End If
            
            
            'Get files
            AssociatedFiles(ds.Tables("page").Rows(0)("pageuid"))
            
            'Newsletter
            Dim newsletterHL As HyperLink = DirectCast(Master.FindControl("newsletterHL"), HyperLink)
            If Not fileclass.ReturnCountResourceFiles(pageuid, "fil") = 0 Then
                newsletterHL.Visible = True
                Dim ds2 As New DataSet
                ds2 = fileclass.ReturnResourceFiles(pageuid, "fil")
                Dim newsletterURL As String = ds2.Tables("files").Rows(0)("file_title")
                newsletterHL.NavigateUrl = "http://admin.liquidclients.co.uk/writedir/files/" & newsletterURL
            End If
                    
            newsletterHL.CssClass = "newsletter forest"
            
            'Polaroids
            ds = resourceclass.ReturnGalleryImagesForHeader_byURL("gal", "img", 574)
                
            If ds.Tables(0).Rows.Count > 0 Then
                
                'Load appropriate polaroids
                Dim photoRPT As Repeater = DirectCast(Master.FindControl("polaroidsRPT"), Repeater)
                photoRPT.DataSource = ds
                photoRPT.DataBind()
            End If
        End If

    End Sub
    
    Sub MetaData(ByVal metadesc As String, ByVal metakeywords As String)
        'bespoke meta data description
        Dim hm As New HtmlMeta()
        hm.Name = "Description"
        hm.Content = metadesc
        Master.Page.Header.Controls.Add(hm)
        'bespoke meta data keywords
        Dim hm2 As New HtmlMeta()
        hm2.Name = "Keywords"
        hm2.Content = metakeywords
        Master.Page.Header.Controls.Add(hm2)
    End Sub
    
    Sub AssociatedFiles(ByVal res_uid As String)
        fileRPT.DataSource = fileclass.ReturnResourceFiles(res_uid, "fil")
        fileRPT.DataBind()
    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="../styles/pta.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <h1><asp:Literal ID="titleLT" runat="server" /></h1>
    <div id="textdiv" runat="server" class="textdiv"></div>
    <div id="embeddiv" runat="server"></div>
    <asp:Repeater runat="server" ID="fileRPT">           
        <ItemTemplate>
                <br /><asp:HyperLink target="_blank" runat="server" ID="fileHL" navigateurl='<%# "http://admin.liquidclients.co.uk/writedir/files/" & DataBinder.Eval(Container.DataItem,"file_title")%>'><%# DataBinder.Eval(Container.DataItem, "file_displaytitle")%></asp:HyperLink>
        </ItemTemplate>           
    </asp:Repeater>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder_SubMenu" Runat="Server">
</asp:Content>

