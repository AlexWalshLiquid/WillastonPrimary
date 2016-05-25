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
    Dim galleryid As Integer = 838
    
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs)
        CType(Master.FindControl("communityHL"), HyperLink).CssClass = "communitymenu_selected" 'select menu item
        
        Dim pageurl As String = Request.QueryString("id")
        If [String].IsNullOrEmpty(pageurl) Then 'no ID so section homepage
            pageurl = "~/our-community/"
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
            titleLT.Text = ds.Tables("page").Rows(0)("menutitle")
            Page.Title = pagetitle & " | " & sitename
            
            MetaData(ds.Tables("page").Rows(0)("metadescription"), ds.Tables("page").Rows(0)("metakeywords"))
            
            'Get files
            AssociatedFiles(ds.Tables("page").Rows(0)("pageuid"))
            
            'Set background
            DirectCast(Master.FindControl("Body"), HtmlGenericControl).Attributes.Add("class", "bg_paint")

            'Set section class
            DirectCast(Master.FindControl("contentID"), HtmlGenericControl).Attributes.Add("class", "content_wrapper community")
            
            'Display decorations
            DirectCast(Master.FindControl("paintbrushDIV"), HtmlGenericControl).Visible = True
            
            ''Polaroids
            'DirectCast(Master.FindControl("polaroid1"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/community_p1.png);")
            'DirectCast(Master.FindControl("polaroid2"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/community_p2.png);")
            'DirectCast(Master.FindControl("polaroid3"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/community_p3.png);")
            'DirectCast(Master.FindControl("polaroid4"), HtmlGenericControl).Attributes.Add("style", "background-image: url(../images/polaroids/community_p4.png);")
        
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

            'Gallery
            ds = resourceclass.ReturnGalleryImages_byURL("gal", "img", galleryid)
                
            If ds.Tables(0).Rows.Count > 0 Then
                'Display the gallery panel
                DirectCast(Master.FindControl("galleryPNL"), Panel).Visible = True
                
                'Load appropriate gallery
                Dim photoRPT As Repeater = DirectCast(Master.FindControl("photoRPT"), Repeater)
                photoRPT.DataSource = ds
                photoRPT.DataBind()
                
                DirectCast(Master.FindControl("classesPNL"), Panel).Visible = False
                DirectCast(Master.FindControl("communityPNL"), Panel).Visible = True
                
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
    <link href="../styles/community.css" rel="stylesheet" type="text/css" />
    <script src="../script/gallery.js" type="text/javascript"></script>
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
    <script type="text/javascript">
        /*
        Slimbox v2.04 - The ultimate lightweight Lightbox clone for jQuery
        (c) 2007-2010 Christophe Beyls <http://www.digitalia.be>
        MIT-style license.
        */
        (function (w) { var E = w(window), u, f, F = -1, n, x, D, v, y, L, r, m = !window.XMLHttpRequest, s = [], l = document.documentElement, k = {}, t = new Image(), J = new Image(), H, a, g, p, I, d, G, c, A, K; w(function () { w("body").append(w([H = w('<div id="lbOverlay" />')[0], a = w('<div id="lbCenter" />')[0], G = w('<div id="lbBottomContainer" />')[0]]).css("display", "none")); g = w('<div id="lbImage" />').appendTo(a).append(p = w('<div style="position: relative;" />').append([I = w('<a id="lbPrevLink" href="#" />').click(B)[0], d = w('<a id="lbNextLink" href="#" />').click(e)[0]])[0])[0]; c = w('<div id="lbBottom" />').appendTo(G).append([w('<a id="lbCloseLink" href="#" />').add(H).click(C)[0], A = w('<div id="lbCaption" />')[0], K = w('<div id="lbNumber" />')[0], w('<div style="clear: both;" />')[0]])[0] }); w.slimbox = function (O, N, M) { u = w.extend({ loop: false, overlayOpacity: 0.8, overlayFadeDuration: 400, resizeDuration: 400, resizeEasing: "swing", initialWidth: 250, initialHeight: 250, imageFadeDuration: 400, captionAnimationDuration: 400, counterText: "Image {x} of {y}", closeKeys: [27, 88, 67], previousKeys: [37, 80], nextKeys: [39, 78] }, M); if (typeof O == "string") { O = [[O, N]]; N = 0 } y = E.scrollTop() + (E.height() / 2); L = u.initialWidth; r = u.initialHeight; w(a).css({ top: Math.max(0, y - (r / 2)), width: L, height: r, marginLeft: -L / 2 }).show(); v = m || (H.currentStyle && (H.currentStyle.position != "fixed")); if (v) { H.style.position = "absolute" } w(H).css("opacity", u.overlayOpacity).fadeIn(u.overlayFadeDuration); z(); j(1); f = O; u.loop = u.loop && (f.length > 1); return b(N) }; w.fn.slimbox = function (M, P, O) { P = P || function (Q) { return [Q.href, Q.title] }; O = O || function () { return true }; var N = this; return N.unbind("click").click(function () { var S = this, U = 0, T, Q = 0, R; T = w.grep(N, function (W, V) { return O.call(S, W, V) }); for (R = T.length; Q < R; ++Q) { if (T[Q] == S) { U = Q } T[Q] = P(T[Q], Q) } return w.slimbox(T, U, M) }) }; function z() { var N = E.scrollLeft(), M = E.width(); w([a, G]).css("left", N + (M / 2)); if (v) { w(H).css({ left: N, top: E.scrollTop(), width: M, height: E.height() }) } } function j(M) { if (M) { w("object").add(m ? "select" : "embed").each(function (O, P) { s[O] = [P, P.style.visibility]; P.style.visibility = "hidden" }) } else { w.each(s, function (O, P) { P[0].style.visibility = P[1] }); s = [] } var N = M ? "bind" : "unbind"; E[N]("scroll resize", z); w(document)[N]("keydown", o) } function o(O) { var N = O.keyCode, M = w.inArray; return (M(N, u.closeKeys) >= 0) ? C() : (M(N, u.nextKeys) >= 0) ? e() : (M(N, u.previousKeys) >= 0) ? B() : false } function B() { return b(x) } function e() { return b(D) } function b(M) { if (M >= 0) { F = M; n = f[F][0]; x = (F || (u.loop ? f.length : 0)) - 1; D = ((F + 1) % f.length) || (u.loop ? 0 : -1); q(); a.className = "lbLoading"; k = new Image(); k.onload = i; k.src = n } return false } function i() { a.className = ""; w(g).css({ backgroundImage: "url(" + n + ")", visibility: "hidden", display: "" }); w(p).width(k.width); w([p, I, d]).height(k.height); w(A).html(f[F][1] || ""); w(K).html((((f.length > 1) && u.counterText) || "").replace(/{x}/, F + 1).replace(/{y}/, f.length)); if (x >= 0) { t.src = f[x][0] } if (D >= 0) { J.src = f[D][0] } L = g.offsetWidth; r = g.offsetHeight; var M = Math.max(0, y - (r / 2)); if (a.offsetHeight != r) { w(a).animate({ height: r, top: M }, u.resizeDuration, u.resizeEasing) } if (a.offsetWidth != L) { w(a).animate({ width: L, marginLeft: -L / 2 }, u.resizeDuration, u.resizeEasing) } w(a).queue(function () { w(G).css({ width: L, top: M + r, marginLeft: -L / 2, visibility: "hidden", display: "" }); w(g).css({ display: "none", visibility: "", opacity: "" }).fadeIn(u.imageFadeDuration, h) }) } function h() { if (x >= 0) { w(I).show() } if (D >= 0) { w(d).show() } w(c).css("marginTop", -c.offsetHeight).animate({ marginTop: 0 }, u.captionAnimationDuration); G.style.visibility = "" } function q() { k.onload = null; k.src = t.src = J.src = n; w([a, g, c]).stop(true); w([I, d, g, G]).hide() } function C() { if (F >= 0) { q(); F = x = D = -1; w(a).hide(); w(H).stop().fadeOut(u.overlayFadeDuration, j) } return false } })(jQuery);

        // AUTOLOAD CODE BLOCK (MAY BE CHANGED OR REMOVED)
        if (!/android|iphone|ipod|series60|symbian|windows ce|blackberry/i.test(navigator.userAgent)) {
            jQuery(function ($) {
                $("a[rel^='lightbox']").slimbox({/* Put custom options here */
            }, null, function (el) {
                return (this == el) || ((this.rel.length > 8) && (this.rel == el.rel));
            });
        });
    }
    </script>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder_SubMenu" Runat="Server">
</asp:Content>

