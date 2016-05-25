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
        DirectCast(Master.FindControl("officeHL"), HyperLink).CssClass = "officemenu_selected" 'select menu item
        
        Dim pageurl As String = cv.checkInput(Request.QueryString("id"))
        Dim noURLInt As Integer
        If [String].IsNullOrEmpty(pageurl) Then 'no ID so section homepage
            pageurl = "calendar"
            noURLInt = 1
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
            Page.Title = pagetitle & " | " & sitename
                        
            'sub menu
            Dim level As Integer = ds.Tables("page").Rows(0)("level")
            If level = 2 Then
                Dim submenu As HyperLink = CType(submenuPnl.FindControl("submenu" & pageid & "HL"), HyperLink) 'select sub menu for page from pageid
                If Not pageid = 538 Then
                    Dim submenuCssClass As String = submenu.CssClass
                    submenu.CssClass = submenu.CssClass & " selected" 'add "_selected" to the end of the cssclass
                End If
                
            End If
            '/sub menu
            
            'office work around
            If noURLInt = 1 Then
                pageuid = "b29f8884-7f7e-488e-9618-6ccb701286a8"
            End If
            
            AssociatedFiles(pageuid)
            
            MetaData(ds.Tables("page").Rows(0)("metadescription"), ds.Tables("page").Rows(0)("metakeywords"))
            
            'Set background
            DirectCast(Master.FindControl("Body"), HtmlGenericControl).Attributes.Add("class", "bg_office")

            'Set section class
            DirectCast(Master.FindControl("contentID"), HtmlGenericControl).Attributes.Add("class", "content_wrapper office")
            
            'Display decorations
            DirectCast(Master.FindControl("penDIV"), HtmlGenericControl).Visible = True
            
            ''Polaroids
            Select Case pageid
                Case 353 'School holidays
                    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/calendar_p1.png);")
                    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/calendar_p2.png);")
                    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/calendar_p3.png);")
                    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/calendar_p4.png);")
                Case 354 'Contact
                    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/contact_p1.png);")
                    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/contact_p2.png);")
                    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/contact_p3.png);")
                    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/contact_p4.png);")
                    DirectCast(Master.FindControl("pageimagemaskPNL"), Panel).Visible = False
                Case 355 'News
                    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/news_p1.png);")
                    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/news_p2.png);")
                    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/news_p3.png);")
                    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/news_p4.png);")
                Case 364 'School calendar
                Case Else
                    DirectCast(Master.FindControl("pageimagemaskPNL"), Panel).Visible = False
                    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/calendar_p1.png);")
                    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/calendar_p2.png);")
                    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/calendar_p3.png);")
                    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/calendar_p4.png);")
            End Select
            
            'embed code
            If Not [String].IsNullOrEmpty(ds.Tables("page").Rows(0)("pageembed")) Then
                embeddiv.InnerHtml = "<br /><br />" & ds.Tables("page").Rows(0)("pageembed")
            End If
            
            'Polaroids
            ds = resourceclass.ReturnGalleryImagesForHeader_byURL("gal", "img", 574)
                
            If ds.Tables(0).Rows.Count > 0 Then
                
                'Load appropriate polaroids
                Dim photoRPT As Repeater = DirectCast(Master.FindControl("polaroidsRPT"), Repeater)
                photoRPT.DataSource = ds
                photoRPT.DataBind()
            End If
        End If
        
        'News page
        If pageid = 355 Then
            Dim newsitem As String = Request.QueryString("item")
            If Not [String].IsNullOrEmpty(newsitem) Then
                If Not resourceclass.CheckActiveResource(newsitem) = 1 Then 'id but no match
                    Response.Redirect("~/error/error-404.htm")
                Else
                    loadArticle(newsitem)
                End If
            Else 'Load news list
                loadNews()
            End If
        End If
    End Sub
    
    Sub loadNews()
        newsRPT.DataSource = resourceclass.ReturnActiveResources("new")
        newsRPT.DataBind()
    End Sub
    
    Sub loadArticle(ByVal pageurl As String)
        Dim dsRes As New DataSet
        dsRes = resourceclass.ReturnActiveResource_ByURL(pageurl)
        
        titleLTL.Text = dsRes.Tables("res").Rows(0)("res_title")
        textLTL.Text = cv.checkUserFiles(dsRes.Tables("res").Rows(0)("res_description"))
        Dim dateadded As Date = dsRes.Tables("res").Rows(0)("res_date")
        dateLTL.Text = dateadded.ToString("dd MMMMMMMM yyyy")
        
        Dim pagetitle As String = Page.Title.ToString
        
        pagetitle = dsRes.Tables("res").Rows(0)("res_title") & " | " & "News | " & sitename
        
        Page.Title = pagetitle
        
        PageImages(dsRes.Tables("res").Rows(0)("res_uid"))
        AssociatedFiles(dsRes.Tables("res").Rows(0)("res_uid"))
        
        newsarticlePNL.Visible = True
        textdiv.Visible = False
        embeddiv.Visible = False
        
        'embed code
        If Not [String].IsNullOrEmpty(dsRes.Tables("res").Rows(0)("resembed")) Then
            resembeddiv.InnerHtml = "<br />" & dsRes.Tables("res").Rows(0)("resembed")
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
        'CType(Master.FindControl("FilesRepeater"), Repeater).DataSource = fileclass.ReturnResourceFiles(res_uid, "fil")
        'CType(Master.FindControl("FilesRepeater"), Repeater).DataBind()
        
        fileRPT.DataSource = fileclass.ReturnResourceFiles(res_uid, "fil")
        fileRPT.DataBind()
    End Sub
    
    Sub PageImages(ByVal res_uid As String)
        'CType(Master.FindControl("pageIMGRepeater"), Repeater).DataSource = file.ReturnFiles_ByType(res_uid, "img") 'update uploaded images
        'CType(Master.FindControl("pageIMGRepeater"), Repeater).DataBind()
        PageIMGRepeater.DataSource = fileclass.ReturnResourceFiles(res_uid, "img") 'update uploaded images
        pageIMGRepeater.DataBind()
    End Sub

    Protected Sub newsRPT_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item or e.Item.ItemType = ListItemType.AlternatingItem Then
            DirectCast(e.Item.FindControl("newsHL"), HyperLink).NavigateUrl = "~/office/default.aspx?id=news&item=" & e.Item.DataItem("pageurl")
        End If
    End Sub
</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="../styles/office.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="textdiv" runat="server" class="textdiv"></div>
    <div id="embeddiv" runat="server"></div>

    <asp:Panel runat="server" ID="newsarticlePNL" Visible="false"> 
        <h1>
            <asp:Literal ID="titleLTL" runat="server"></asp:Literal>
        </h1>

        <asp:Repeater ID="PageIMGRepeater" runat="server">
            <ItemTemplate>
                <asp:Image ID="Image1" runat="server" ImageUrl='<%# "http://admin.liquidclients.co.uk/writedir/images/thumb/" & DataBinder.Eval(Container.DataItem,"file_title")%>' AlternateText="Uploaded Images" style="max-width:90%" />
                <br /><br />
            </ItemTemplate>
        </asp:Repeater>
        
        <asp:Literal ID="textLTL" runat="server"></asp:Literal>

        
        
        <div id="resembeddiv" runat="server"></div>
        <br /><br />
        
        <b>Date: </b><asp:Literal ID="dateLTL" runat="server"></asp:Literal>
    </asp:Panel>
    <asp:Repeater ID="newsRPT" runat="server" OnItemDataBound="newsRPT_ItemDataBound">
        <HeaderTemplate>
            <div class="newslist">
        </HeaderTemplate>
        <ItemTemplate>
            <div class="date"><%# Eval("res_date", "{0: dd MMMMMMMMM yyyy}")%></div>
            <asp:HyperLink runat="server" ID="newsHL"><h2><%# DataBinder.Eval(Container.DataItem,"res_title")%></h2></asp:HyperLink>
            <div class="summary"><%# DataBinder.Eval(Container.DataItem,"res_summary")%></div>
        </ItemTemplate>
        <SeparatorTemplate>
            <hr />
        </SeparatorTemplate>
        <FooterTemplate>
            </div>
        </FooterTemplate>
    </asp:Repeater>

    <asp:Repeater runat="server" ID="fileRPT">           
        <ItemTemplate>
                <br /><asp:HyperLink target="_blank" runat="server" ID="fileHL" navigateurl='<%# "http://admin.liquidclients.co.uk/writedir/files/" & DataBinder.Eval(Container.DataItem,"file_title")%>'><%# DataBinder.Eval(Container.DataItem, "file_displaytitle")%></asp:HyperLink>
        </ItemTemplate>           
    </asp:Repeater>
    
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder_SubMenu" Runat="Server">

    <asp:Panel runat="server" ID="submenuPnl" CssClass="submenu">
        <asp:HyperLink ID="submenu353HL" runat="server" CssClass="officesubmenu holidays_submenu" NavigateUrl="default.aspx?id=calendar" Text="School Holidays" />
        <asp:HyperLink ID="submenu364HL" runat="server" CssClass="officesubmenu calendar_submenu" NavigateUrl="default.aspx?id=willaston-school-calendar" Text="Calendar Dates" />
        <asp:HyperLink ID="submenu354HL" runat="server" CssClass="officesubmenu contact_submenu" NavigateUrl="default.aspx?id=contact" Text="Contact" />
        <asp:HyperLink ID="submenu355HL" runat="server" CssClass="officesubmenu news_submenu" NavigateUrl="default.aspx?id=news" Text="News" />
        <asp:HyperLink ID="submenu439HL" runat="server" CssClass="officesubmenu finance_submenu" NavigateUrl="default.aspx?id=finance" Text="Pupil premium" />
        <asp:HyperLink ID="submenu1753HL" runat="server" CssClass="officesubmenu sportsfunding_submenu" NavigateUrl="default.aspx?id=sports-premium" Text="Sports Funding" />
        <asp:HyperLink ID="submenu442HL" runat="server" CssClass="officesubmenu prospectus_submenu" NavigateUrl="~/pdf/Willaston_Prospectus_WEB.pdf" Text="Prospectus" target="_new"/>

    </asp:Panel>
</asp:Content>

