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
        
        Dim pageurl As String = Request.QueryString("id")
        If [String].IsNullOrEmpty(pageurl) Then 'no ID so section homepage
            pageurl = "calendar"
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
            textdiv.InnerHtml = ds.Tables("page").Rows(0)("pagetext")
            Page.Title = pagetitle & " | " & sitename
            
            'sub menu
            Dim level As Integer = ds.Tables("page").Rows(0)("level")
            If level = 2 Then
                Dim submenu As HyperLink = CType(submenuPnl.FindControl("submenu" & pageid & "HL"), HyperLink) 'select sub menu for page from pageid
                Dim submenuCssClass As String = submenu.CssClass
                submenu.CssClass = submenu.CssClass & " selected" 'add "_selected" to the end of the cssclass
            End If
            '/sub menu
            
            'Set background
            DirectCast(Master.FindControl("Body"), HtmlGenericControl).Attributes.Add("class", "bg_office")

            'Set section class
            DirectCast(Master.FindControl("contentID"), HtmlGenericControl).Attributes.Add("class", "content_wrapper office")
            
            'Display decorations
            DirectCast(Master.FindControl("penDIV"), HtmlGenericControl).Visible = True
            
            'Polaroids
            DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/news_p1.png);")
            DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/news_p2.png);")
            DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/news_p3.png);")
            DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/news_p4.png);")

        End If
        
    End Sub

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="eventbackground">

        <div class="eventtext">

            <h2><asp:Literal ID="titleLT" runat="server"></asp:Literal></h2>
            <br />
            <a href="default.aspx"><img src="images/events/back_btn.png" alt="Back" /></a>
            <br /><br />

            <div id="textdiv" runat="server"></div>

            <br /><br />
            <a href="default.aspx"><img src="images/events/back_btn.png" alt="Back" /></a>

            
        </div>
    </div>
    <div class="eventbackgroundbottom"></div>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder_SubMenu" Runat="Server">

    <asp:Panel runat="server" ID="submenuPnl" CssClass="submenu">
        <asp:HyperLink ID="submenu353HL" runat="server" CssClass="officesubmenu calendar_submenu" NavigateUrl="?id=calendar" Text="Calendar" />
        <asp:HyperLink ID="submenu354HL" runat="server" CssClass="officesubmenu contact_submenu" NavigateUrl="?id=contact" Text="Contact" />
        <asp:HyperLink ID="submenu355HL" runat="server" CssClass="officesubmenu news_submenu" NavigateUrl="?id=news" Text="News" />
    </asp:Panel>
</asp:Content>
