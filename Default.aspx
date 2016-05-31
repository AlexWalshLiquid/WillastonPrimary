<%@ Page Title="" Language="VB" MasterPageFile="~/masterpages/main.master" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>

<script runat="server">
    
    Dim cv As New ControlValues
    Dim pageclass As New page
    Dim resource As New resource
    Dim pageid As Integer = 331
    Dim sitename As String = cv.ReturnSiteTitle()
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        DirectCast(Master.FindControl("homeHL"), HyperLink).CssClass = "homemenu_selected" 'select menu item
        
        'Background
        DirectCast(Master.FindControl("Body"), HtmlGenericControl).Attributes.Add("class", "bg_paint")
        
        'Section class
        DirectCast(Master.FindControl("contentID"), HtmlGenericControl).Attributes.Add("class", "content_wrapper home")
        
        'Ticker
        DirectCast(Master.FindControl("tickerPNL"), Panel).Visible = True
        
        Dim newstickerRPT As Repeater = DirectCast(Master.FindControl("newstickerRPT"), Repeater)
        newstickerRPT.DataSource = resource.ReturnResources("new")
        newstickerRPT.DataBind()
                
        'Decorations
        DirectCast(Master.FindControl("pencilDIV"), HtmlGenericControl).Visible = True
        DirectCast(Master.FindControl("paintbrushDIV"), HtmlGenericControl).Visible = True
        DirectCast(Master.FindControl("scissorsDIV"), HtmlGenericControl).Visible = True
        
        'Polaroids
        'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(images/polaroids/home_p1.png);")
        'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(images/polaroids/home_p2.png);")
        'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(images/polaroids/home_p3.png);")
        'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(images/polaroids/home_p4.png);")
        Dim ds As DataSet
        ds = resource.ReturnGalleryImagesForHeader_byURL("gal", "img", 574)
                
        If ds.Tables(0).Rows.Count > 0 Then
                
            'Load appropriate polaroids
            Dim polaroidsRPT As Repeater = DirectCast(Master.FindControl("polaroidsRPT"), Repeater)
            polaroidsRPT.DataSource = ds
            polaroidsRPT.DataBind()
        End If
            
        'Page content
        'Dim ds As New DataSet 'page details
        ds = pageclass.ReturnPage_ByID(pageid)
        contentLTL.Text = cv.checkUserFiles(ds.Tables("page").Rows(0)("pagetext"))
        
        MetaData(ds.Tables("page").Rows(0)("metadescription"), ds.Tables("page").Rows(0)("metakeywords"))
        
        'Page title
        Dim pagetitle As String = ds.Tables("page").Rows(0)("pagetitle")
        Page.Title = pagetitle
        
        'Map
        DirectCast(Master.FindControl("mapPNL"), Panel).Visible = True
		
		'Video
		DirectCast(Master.FindControl("videoPNL"), Panel).Visible = True
        
        'Newsletter
        Dim pageuid As String = ds.Tables("page").Rows(0)("pageuid")
        Dim ds2 As New DataSet
        ds2 = pageclass.ReturnFiles(pageuid)
        Dim newsletterHL As HyperLink = DirectCast(Master.FindControl("newsletterHL"), HyperLink)
        newsletterHL.Visible = True
		newsletterHL.Enabled = True
        
        If ds2.Tables(0).Rows.Count > 0 Then
            newsletterHL.NavigateUrl = "http://admin.liquidclients.co.uk/writedir/files/" & ds2.Tables(0).Rows(0)("file_title")
        End If
        
        'Hardcoded this next line in as resources are not being called and latest newsletter record is not appearing in
        'the database - need to look into at a future date when time allows - Wayne 6/10/15
        ' newsletterHL.NavigateUrl = "http://www.willastonceprimaryschool.co.uk/pdf/may2016.pdf"
        
        titleLT.Text = "Willaston Church of England Primary School"
        
        'embed code
        If Not [String].IsNullOrEmpty(ds.Tables("page").Rows(0)("pageembed")) Then
            embeddiv.InnerHtml = "<br /><br />" & ds.Tables("page").Rows(0)("pageembed")
        End If
        
    End Sub
    
    Sub MetaData(ByVal metadesc As String, ByVal metakeywords As String)
        Dim hm As New HtmlMeta()
        Dim hm2 As New HtmlMeta()
        hm.Name = "Description"
        hm.Content = metadesc
        Master.Page.Header.Controls.Add(hm)
        hm2.Name = "Keywords"
        hm2.Content = metakeywords
        Master.Page.Header.Controls.Add(hm2)
    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="styles/home.css" rel="stylesheet" type="text/css" />
    <script src="script/newsticker.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1><asp:Literal ID="titleLT" runat="server" /></h1>
    <asp:literal ID="contentLTL" runat="server"></asp:literal>
    <div id="embeddiv" runat="server"></div>

</asp:Content>

