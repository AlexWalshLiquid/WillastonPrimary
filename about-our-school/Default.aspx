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
        CType(Master.FindControl("aboutHL"), HyperLink).CssClass = "aboutmenu_selected" 'select menu item
        CType(Master.FindControl("galleryPNL"), Panel).Visible = False
        
        Dim pageurl As String = Request.QueryString("id")
        If [String].IsNullOrEmpty(pageurl) Then 'no ID so section homepage
            pageurl = "what-they-say"
        End If
        pageurl = cv.checkInput(pageurl)
        
        If Not pageclass.CheckActivePage(pageurl) = 1 Then
            Response.Redirect("~/error/error-404.htm") 'ID but no match
        Else 'populate
            Dim ds As New DataSet
            ds = pageclass.ReturnPage_ByURL(pageurl)
            pageid = ds.Tables("page").Rows(0)("pageid")
            Dim pagetitle As String = ds.Tables("page").Rows(0)("pagetitle")
            Dim headertext As String = ds.Tables("page").Rows(0)("menutitle")
            Dim pageuid As String = ds.Tables("page").Rows(0)("pageuid")
            contentLTL.Text = cv.checkUserFiles(ds.Tables("page").Rows(0)("pagetext"))
            titleLT.Text = headertext
            Page.Title = pagetitle & " | " & sitename
            
            'File Repeater 
            Dim dt As DataTable = fileclass.ReturnResourceFiles(pageuid, "fil").Tables(0)
            
            If pageid = 340 Then
                dt.DefaultView.Sort = "file_displaytitle asc"
            Else
                dt.DefaultView.Sort = "file_id asc"
            End If
            
            'dt = dt.DefaultView.ToTable
            
            
            'dt.AcceptChanges()
            
            Dim fileRPT As Repeater = DirectCast(Master.FindControl("fileRPT"), Repeater)
            
            
            fileRPT.DataSource = dt
            fileRPT.DataBind()
            
            MetaData(ds.Tables("page").Rows(0)("metadescription"), ds.Tables("page").Rows(0)("metakeywords"))
            
            'sub menu
            Dim level As Integer = ds.Tables("page").Rows(0)("level")
            If level = 2 Then
                Dim submenu As HyperLink = CType(submenuPnl.FindControl("submenu" & pageid & "HL"), HyperLink) 'select sub menu for page from pageid
                Dim submenuCssClass As String = submenu.CssClass
                submenu.CssClass = submenu.CssClass & " selected" 'add "_selected" to the end of the cssclass
            End If
            '/sub menu
            
            'Set background
            DirectCast(Master.FindControl("Body"), HtmlGenericControl).Attributes.Add("class", "bg_paint")
            
            'Set section class
            DirectCast(Master.FindControl("contentID"), HtmlGenericControl).Attributes.Add("class", "content_wrapper about")
            
            'Display decorations
            DirectCast(Master.FindControl("paintbrushDIV"), HtmlGenericControl).Visible = True
            
            'Polaroids
            Select Case pageid
                'Case 337 'What they say
                '    DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/whattheysay_p1.png);")
                '    DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/whattheysay_p2.png);")
                '    DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/whattheysay_p3.png);")
                '    DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/whattheysay_p4.png);")
                'Case 338 'School details
                '    DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/schooldetails_p1.png);")
                '    DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/schooldetails_p2.png);")
                '    DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/schooldetails_p3.png);")
                '    DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/schooldetails_p4.png);")
                'Case 357 'Our uniform
                '    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/ouruniform_p1.png);")
                '    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/ouruniform_p2.png);")
                '    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/ouruniform_p3.png);")
                '    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/ouruniform_p4.png);")
                'Case 339 'Admissions
                '    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/admission_p1.png);")
                '    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/admission_p2.png);")
                '    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/admission_p3.png);")
                '    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/admission_p4.png);")
                'Case 340 'Policies
                '    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/policies_p1.png);")
                '    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/policies_p2.png);")
                '    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/policies_p3.png);")
                '    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/policies_p4.png);")
                'Case 341 'Clubs
                '    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/clubs_p1.png);")
                '    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/clubs_p2.png);")
                '    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/clubs_p3.png);")
                '    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/clubs_p4.png);")
                Case 342 'Governors
                    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/governors_p1.png);")
                    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/governors_p2.png);")
                    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/governors_p3.png);")
                    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/governors_p4.png);")
                    
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
                    fileRPT.Visible = False
                    
                    DirectCast(Master.FindControl("pageimagemaskPNL"),Panel).Visible= False
                    'Case 343 'S4YC
                    '    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/s4yc_p1.png);")
                    '    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/s4yc_p2.png);")
                    '    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/s4yc_p3.png);")
                    '    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/s4yc_p4.png);")
                    'Case Else
                    '    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/whattheysay_p1.png);")
                    '    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/whattheysay_p2.png);")
                    '    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/whattheysay_p3.png);")
                    '    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/whattheysay_p4.png);")
            End Select
            
            'embed code
            If Not [String].IsNullOrEmpty(ds.Tables("page").Rows(0)("pageembed")) Then
                embeddiv.InnerHtml = "<br /><br />" & ds.Tables("page").Rows(0)("pageembed")
            End If
            
            'Polaroids
            ds = resourceclass.ReturnGalleryImagesForHeader_byURL("gal", "img", 574)
                
            If ds.Tables(0).Rows.Count > 0 Then
                
                'Load appropriate polaroids
                Dim polaroidsRPT As Repeater = DirectCast(Master.FindControl("polaroidsRPT"), Repeater)
                polaroidsRPT.DataSource = ds
                polaroidsRPT.DataBind()
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
        CType(Master.FindControl("FilesRepeater"), Repeater).DataSource = fileclass.ReturnResourceFiles(res_uid, "fil")
        CType(Master.FindControl("FilesRepeater"), Repeater).DataBind()
    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="../styles/about.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="about-spacer">
        <h1><asp:Literal ID="titleLT" runat="server" /></h1>
        <asp:Literal ID="contentLTL" runat="server"></asp:Literal>
        <div id="embeddiv" runat="server"></div>
    </div>
    
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder_SubMenu" Runat="Server">

    <asp:Panel runat="server" ID="submenuPnl" CssClass="submenu">
        <asp:HyperLink ID="submenu337HL" runat="server" CssClass="aboutsubmenu whattheysay_submenu" NavigateUrl="default.aspx?id=what-they-say" Text="What They Say" />
        <asp:HyperLink ID="submenu338HL" runat="server" CssClass="aboutsubmenu schooldetails_submenu" NavigateUrl="default.aspx?id=school-details" Text="School Details" />
        <asp:HyperLink ID="submenu357HL" runat="server" CssClass="aboutsubmenu uniform_submenu" NavigateUrl="default.aspx?id=our-uniform" Text="Our Uniform" />
        <asp:HyperLink ID="submenu339HL" runat="server" CssClass="aboutsubmenu admissions_submenu" NavigateUrl="default.aspx?id=admissions" Text="Admissions" />
        <asp:HyperLink ID="submenu340HL" runat="server" CssClass="aboutsubmenu policies_submenu" NavigateUrl="default.aspx?id=policies" Text="Policies" />
        <asp:HyperLink ID="submenu341HL" runat="server" CssClass="aboutsubmenu clubs_submenu" NavigateUrl="default.aspx?id=clubs" Text="Clubs" />
        <asp:HyperLink ID="submenu342HL" runat="server" CssClass="aboutsubmenu governors_submenu" NavigateUrl="default.aspx?id=governors" Text="Governors" />
        <asp:HyperLink ID="submenu343HL" runat="server" CssClass="aboutsubmenu s4yc_submenu" NavigateUrl="default.aspx?id=s4yc" Text="S4YC" />
        <asp:HyperLink ID="submenu533HL" runat="server" CssClass="aboutsubmenu schooldirect_submenu" NavigateUrl="default.aspx?id=school-direct" Text="School Direct" />
        <asp:HyperLink ID="submenu506HL" runat="server" CssClass="aboutsubmenu results_submenu" NavigateUrl="default.aspx?id=results" Text="Results" />
    </asp:Panel>
</asp:Content>

