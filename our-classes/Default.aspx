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
        CType(Master.FindControl("classesHL"), HyperLink).CssClass = "classesmenu_selected" 'select menu item
        
        Dim pageurl As String = Request.QueryString("id")
        If [String].IsNullOrEmpty(pageurl) Then 'no ID so section homepage
            pageurl = "forest-school"
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
            Dim headertext As String = ds.Tables("page").Rows(0)("menutitle")
            textdiv.InnerHtml = cv.checkUserFiles(ds.Tables("page").Rows(0)("pagetext"))
            titleLT.Text = headertext
            Page.Title = pagetitle & " | " & sitename
            
            'Load file repeater
            fileRPT.DataSource = fileclass.ReturnResourceFiles(pageuid, "fil")
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
            Dim body As HtmlGenericControl = DirectCast(Master.FindControl("Body"), HtmlGenericControl)
            If pageid = 344 Then 'Check if Forect School page as has different background
                body.Attributes.Add("class", "bg_grass")
            Else
                body.Attributes.Add("class", "bg_paint")
            End If
            
            'Set section class
            DirectCast(Master.FindControl("contentID"), HtmlGenericControl).Attributes.Add("class", "content_wrapper classes")
            
            'Display decorations
            If pageid = 344 Then 'Check if Forect School page as has different decorations
                DirectCast(Master.FindControl("butterfly1DIV"), HtmlGenericControl).Visible = True
                DirectCast(Master.FindControl("butterfly2DIV"), HtmlGenericControl).Visible = True
                DirectCast(Master.FindControl("ladybirdDIV"), HtmlGenericControl).Visible = True
                DirectCast(Master.FindControl("trowelDIV"), HtmlGenericControl).Visible = True
                DirectCast(Master.FindControl("caterpillarDIV"), HtmlGenericControl).Visible = True
            Else
                DirectCast(Master.FindControl("paintbrushDIV"), HtmlGenericControl).Visible = True
            End If
            
            'Polaroids & Newletters
            
            Dim newsletterHL As HyperLink = DirectCast(Master.FindControl("newsletterHL"), HyperLink)
            If Not fileclass.ReturnCountResourceFiles(pageuid, "fil") = 0 Then
                newsletterHL.Visible = True
                Dim ds2 As New DataSet
                ds2 = fileclass.ReturnResourceFiles(pageuid, "fil")
                Dim newsletterURL As String = ds2.Tables("files").Rows(0)("file_title")
                newsletterHL.NavigateUrl = "http://admin.liquidclients.co.uk/writedir/files/" & newsletterURL
            End If
            
            
            Dim galleryid As Integer = 0
            Dim headergalleryid As Integer = 574
            Select Case pageid
                Case 344 'Forest school
                    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/forestschool_p1.png);")
                    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/forestschool_p2.png);")
                    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/forestschool_p3.png);")
                    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/forestschool_p4.png);")
                  
                    newsletterHL.CssClass = "newsletter forest"
                    
                    galleryid = 202
                    headergalleryid = 566
                Case 345 'Reception class
                    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/reception_p1.png);")
                    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/reception_p2.png);")
                    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/reception_p3.png);")
                    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/reception_p4.png);")
                    
                    newsletterHL.CssClass = "newsletter reception"
                    
                    galleryid = 203
                    headergalleryid = 567
                Case 346 'Year 1
                    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year1_p1.png);")
                    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year1_p2.png);")
                    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year1_p3.png);")
                    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year1_p4.png);")
                    
                    newsletterHL.CssClass = "newsletter year1"
                    
                    galleryid = 204
                    headergalleryid = 568
                Case 347 'Year 2
                    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year2_p1.png);")
                    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year2_p2.png);")
                    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year2_p3.png);")
                    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year2_p4.png);")
                    
                    newsletterHL.CssClass = "newsletter year2"
                    
                    galleryid = 205
                    headergalleryid = 569
                Case 348 'Year 3
                    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year3_p1.png);")
                    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year3_p2.png);")
                    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year3_p3.png);")
                    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year3_p4.png);")
                    
                    newsletterHL.CssClass = "newsletter year3"
                    
                    galleryid = 206
                    headergalleryid = 570
                Case 349 'Year 4
                    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year4_p1.png);")
                    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year4_p2.png);")
                    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year4_p3.png);")
                    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year4_p4.png);")
                    
                    newsletterHL.CssClass = "newsletter year4"
                    
                    galleryid = 207
                    headergalleryid = 571
                Case 350 'Year 5
                    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year5_p1.png);")
                    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year5_p2.png);")
                    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year5_p3.png);")
                    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year5_p4.png);")
                    
                    newsletterHL.CssClass = "newsletter year5"
                    
                    galleryid = 208
                    headergalleryid = 572
                Case 351 'Year 6
                    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year6_p1.png);")
                    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year6_p2.png);")
                    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year6_p3.png);")
                    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year6_p4.png);")
                    
                    newsletterHL.CssClass = "newsletter year6"
                    
                    galleryid = 209
                    headergalleryid = 573
                Case 352 'School Trips
                    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/schooltrips_p1.png);")
                    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/schooltrips_p2.png);")
                    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/schooltrips_p3.png);")
                    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/schooltrips_p4.png);")
                    
                    newsletterHL.Visible = False
                Case Else
                    'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year6_p1.png);")
                    'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year6_p2.png);")
                    'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year6_p3.png);")
                    'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/year6_p4.png);")
                    
                    newsletterHL.Visible = False
            End Select
            
            'embed code
            If Not [String].IsNullOrEmpty(ds.Tables("page").Rows(0)("pageembed")) Then
                embeddiv.InnerHtml = "<br /><br />" & ds.Tables("page").Rows(0)("pageembed")
            End If
            
            'Gallery
            
            If Not pageid = 352 Then 'Don't display gallery for school trip page
                
                ds = resourceclass.ReturnGalleryImages_byURL("gal", "img", galleryid)
                
                If ds.Tables(0).Rows.Count > 0 Then
                    'Display the gallery panel
                    DirectCast(Master.FindControl("galleryPNL"), Panel).Visible = True
                
                    'Load appropriate gallery
                    Dim photoRPT As Repeater = DirectCast(Master.FindControl("photoRPT"), Repeater)
                    photoRPT.DataSource = ds
                    photoRPT.DataBind()
                End If

            End If
            
            'Polaroids
            ds = resourceclass.ReturnGalleryImagesForHeader_byURL("gal", "img", headergalleryid)
                
            If Not ds.Tables(0).Rows.Count > 3 Then
                'Load general header images if insufficient
                ds = resourceclass.ReturnGalleryImagesForHeader_byURL("gal", "img", 574)
                'Load appropriate polaroids
                
            End If
            
            Dim polaroidsRPT As Repeater = DirectCast(Master.FindControl("polaroidsRPT"), Repeater)
            polaroidsRPT.DataSource = ds
            polaroidsRPT.DataBind()
            
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
    <link href="../styles/classes.css" rel="stylesheet" type="text/css" />
    <script src="../script/gallery.min.js" type="text/javascript"></script>
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

    <asp:Panel runat="server" ID="submenuPnl" CssClass="submenu">
        <asp:HyperLink ID="submenu344HL" runat="server" CssClass="classessubmenu forestschool_submenu" NavigateUrl="default.aspx?id=forest-school" Text="Forest School" />
        <asp:HyperLink ID="submenu345HL" runat="server" CssClass="classessubmenu reception_submenu" NavigateUrl="default.aspx?id=reception-class" Text="Reception Class" />
        <asp:HyperLink ID="submenu346HL" runat="server" CssClass="classessubmenu year1_submenu" NavigateUrl="default.aspx?id=year-one" Text="Year 1" />
        <asp:HyperLink ID="submenu347HL" runat="server" CssClass="classessubmenu year2_submenu" NavigateUrl="default.aspx?id=year-two" Text="Year 2" />
        <asp:HyperLink ID="submenu348HL" runat="server" CssClass="classessubmenu year3_submenu" NavigateUrl="default.aspx?id=year-three" Text="Year 3" />
        <asp:HyperLink ID="submenu349HL" runat="server" CssClass="classessubmenu year4_submenu" NavigateUrl="default.aspx?id=year-four" Text="Year 4" />
        <asp:HyperLink ID="submenu350HL" runat="server" CssClass="classessubmenu year5_submenu" NavigateUrl="default.aspx?id=year-five" Text="Year 5" />
        <asp:HyperLink ID="submenu351HL" runat="server" CssClass="classessubmenu year6_submenu" NavigateUrl="default.aspx?id=year-six" Text="Year 6" />
        <asp:HyperLink ID="submenu352HL" runat="server" CssClass="classessubmenu schooltrips_submenu" NavigateUrl="default.aspx?id=school-trips" Text="School Trips" />
    </asp:Panel>
</asp:Content>

