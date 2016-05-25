<%@ Master Language="VB" EnableViewState="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">
    

    Protected Sub photoRPT_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim photoHL As HyperLink = DirectCast(e.Item.FindControl("photoHL"), HyperLink)
            photoHL.NavigateUrl = "http://admin.liquidclients.co.uk/writedir/images/" & e.Item.DataItem("file_title")
            photoHL.Attributes.Add("rel", "lightbox")
            photoHL.Attributes.Add("style", "background-image: url(http://admin.liquidclients.co.uk/writedir/images/thumb/" & e.Item.DataItem("file_title") & ");")
        End If
    End Sub

    Protected Sub newstickerRPT_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            DirectCast(e.Item.FindControl("newsHL"), HyperLink).NavigateUrl = "~/office/default.aspx?id=news&item=" & e.Item.DataItem("pageurl")
        End If
    End Sub

    Protected Sub fileRPT_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim str As String = e.Item.DataItem("file_displaytitle")
            str = Left(str, InStrRev(str, "(", -1, CompareMethod.Binary)-1)
            DirectCast(e.Item.FindControl("fileHL"), HyperLink).Text = str
        End If
    End Sub

    Protected Sub polaroidsRPT_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs)
        If e.Item.ItemType = ListItemType.Item Or e.Item.ItemType = ListItemType.AlternatingItem Then
            Dim i As Integer = e.Item.ItemIndex
            If i / 4 > 0 Then i = Math.Floor(i - (Math.Floor(i / 4) * 4))
            i = i + 1
            Dim polaroidLI As HtmlGenericControl = DirectCast(e.Item.FindControl("polaroidLI"), HtmlGenericControl)
            
            polaroidLI.Attributes.Add("class", "polaroid" & i)
            polaroidLI.Attributes.Add("style", "background-image:url(http://admin.liquidclients.co.uk/writedir/images/thumb/" & e.Item.DataItem("file_title") & ");")
        End If
    End Sub
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <meta name="author" content="Liquid Solution" />

    <!-- required for mobile -->
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0" /> 
    <!-- stylesheets -->
    <link type="text/css" rel="stylesheet" href="http://fast.fonts.com/cssapi/5a9a6c56-2dc2-4f74-a767-16bdc6f12f5c.css"/>
    <link href="../styles/combined.css?v=1.1" rel="stylesheet" type="text/css" />
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js" type="text/javascript"></script>
    <script src="../script/jquery.innerfade.min.js" type="text/javascript"></script>
    <link rel="apple-touch-icon" href="../images/apple-touch-icon.png" />
    <asp:ContentPlaceHolder id="head" runat="server">
    </asp:ContentPlaceHolder>
    <script type="text/javascript">
        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-34165747-1']);
        _gaq.push(['_trackPageview']);

        (function () {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();
    </script> 
    
</head>
<body id="body" runat="server">
    <form id="form1" runat="server">
        <div class="banner-top">
            <div class="outerbody">
                Have you ever thought about becoming a teacher? <asp:hyperlink runat="server" NavigateUrl="~/about-our-school/default.aspx?id=school-direct">Click here</asp:hyperlink> to learn how to take those first steps
            </div>
        </div>
        <div class="outerbody">
            <div class="contact_top">Neston Road, Willaston, <wbr>&#8203;<span class="nobr">Neston, Cheshire, CH64 2TN&nbsp;&nbsp;</span></wbr><wbr><span class="nobr">&#8203;&bull;&nbsp;&nbsp;T: 0151 338 2421&nbsp;&nbsp;</span></wbr><wbr><span class="nobr">&#8203;&bull;&nbsp;&nbsp;F: 0151 327 8244</span></ wbr></div>
            <div class="header">
                <asp:hyperlink runat="server" ID="logoHL" NavigateUrl="~/Default.aspx" CssClass="logo">Willaston Church of England Primary School</asp:hyperlink>
                <asp:Repeater runat="server" ID="polaroidsRPT" OnItemDataBound="polaroidsRPT_ItemDataBound">
                    <HeaderTemplate>
                        <ul class="polaroids">
                    </HeaderTemplate>
                    <ItemTemplate>
                        <li runat="server" id="polaroidLI"></li>
                    </ItemTemplate>
                    <FooterTemplate>
                        </ul>
                    </FooterTemplate>
                </asp:Repeater>
                <div class="frame1"></div>
                <div class="frame2"></div>
                <div class="frame3"></div>
                <div class="frame4"></div>
            </div>
            <asp:Panel runat="server" ID="tickerPNL" CssClass="ticker" Visible="false">
                <div class="t_tl"></div>
                <div class="t_t"></div>
                <div class="t_tfill"></div>
                <div class="t_tr"></div>
                <div class="t_l"></div>
                <div class="t_lfill"></div>
                <div class="t_r"></div>
                <div class="t_rfill"></div>
                <div class="t_wb">
                    <asp:repeater runat="server" ID="newstickerRPT" OnItemDataBound="newstickerRPT_ItemDataBound">
                        <HeaderTemplate>
                            <div class="ticker" id="newsticker-jcarousellite" style="top: 5px; height: 50px;">
                                <ul>
                        </HeaderTemplate>
                        <ItemTemplate>
                            <li><asp:hyperlink runat="server" ID="newsHL"><h3><%# UCase(DataBinder.Eval(Container.DataItem, "res_title"))%></h3>
                            <p><%# DataBinder.Eval(Container.DataItem,"res_summary")%></p></asp:hyperlink></li>
                        </ItemTemplate>
                        <FooterTemplate>
                            </ul></div>
                        </FooterTemplate>
                    </asp:repeater>
                </div>
                <div class="t_bl"></div>
                <div class="t_b"></div>
                <div class="t_bfill"></div>
                <div class="t_br"></div>    
            </asp:Panel>
            <div class="primarynav">
                <asp:HyperLink ID="homeHL" runat="server" CssClass="homemenu" NavigateUrl="~/" Text="Home" />
                <asp:HyperLink ID="aboutHL" runat="server" CssClass="aboutmenu" NavigateUrl="~/about-our-school/" Text="About Our School" />
                <asp:HyperLink ID="classesHL" runat="server" CssClass="classesmenu" NavigateUrl="~/our-classes/" Text="Our Classes" />
                <asp:HyperLink ID="officeHL" runat="server" CssClass="officemenu" NavigateUrl="~/office/" Text="Office" />
                <asp:HyperLink ID="communityHL" runat="server" CssClass="communitymenu" NavigateUrl="~/our-community/" Text="Our Community" />
                <asp:HyperLink ID="ptaHL" runat="server" CssClass="ptamenu" NavigateUrl="~/pta-shop/" Text="PTA Shop" />
                <br class="clear" />
            </div>
            
            <div runat="server" id="contentID">
                <div class="div_tl"></div>
                <div class="div_tb"></div>
                <div class="div_t"></div>
                <div class="div_tr"></div>
                <div class="content_outer">
                    <div class="content">
					 <h1 class="padmeH1"><asp:Literal ID="mpTitleLT" runat="server" Visible="false" /></h1>
                        <asp:Panel runat="server" ID="mapPNL" CssClass="map" Visible="false">
                            <asp:HyperLink runat="server" ID="map_forestHL" CssClass="map_forest" NavigateUrl="~/our-classes/Default.aspx?id=forest-school"></asp:HyperLink>
                            <asp:HyperLink runat="server" ID="map_officeHL" CssClass="map_office" NavigateUrl="~/office/"></asp:HyperLink>
                            <asp:HyperLink runat="server" ID="map_receptionHL" CssClass="map_reception" NavigateUrl="~/our-classes/Default.aspx?id=reception-class"></asp:HyperLink>
                            <asp:HyperLink runat="server" ID="map_tripsHL" CssClass="map_trips" NavigateUrl="~/our-classes/Default.aspx?id=school-trips"></asp:HyperLink>
                            <asp:HyperLink runat="server" ID="map_year1HL" CssClass="map_year1" NavigateUrl="~/our-classes/Default.aspx?id=year-one"></asp:HyperLink>
                            <asp:HyperLink runat="server" ID="map_year2HL" CssClass="map_year2" NavigateUrl="~/our-classes/Default.aspx?id=year-two"></asp:HyperLink>
                            <asp:HyperLink runat="server" ID="map_year3HL" CssClass="map_year3" NavigateUrl="~/our-classes/Default.aspx?id=year-three"></asp:HyperLink>
                            <asp:HyperLink runat="server" ID="map_year4HL" CssClass="map_year4" NavigateUrl="~/our-classes/Default.aspx?id=year-four"></asp:HyperLink>
                            <asp:HyperLink runat="server" ID="map_year5HL" CssClass="map_year5" NavigateUrl="~/our-classes/Default.aspx?id=year-five"></asp:HyperLink>
                            <asp:HyperLink runat="server" ID="map_year6HL" CssClass="map_year6" NavigateUrl="~/our-classes/Default.aspx?id=year-six"></asp:HyperLink>
                            <asp:HyperLink runat="server" ID="map_churchHL" CssClass="map_church" NavigateUrl="~/our-community/Default.aspx"></asp:HyperLink>
                        </asp:Panel>
                        <div class="submenu_center">
                        <asp:ContentPlaceHolder id="ContentPlaceHolder_SubMenu" runat="server">
                        </asp:ContentPlaceHolder>
                        </div>

                        <div class="content_inner curved">
                            
                            <asp:ContentPlaceHolder id="ContentPlaceHolder1" runat="server">
                            </asp:ContentPlaceHolder>

                            <asp:Repeater runat="server" ID="fileRPT" OnItemDataBound="fileRPT_ItemDataBound">
                                <HeaderTemplate>
                                    <ul class="redlist">
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <li><asp:HyperLink runat="server" ID="fileHL" navigateurl='<%# "http://admin.liquidclients.co.uk/writedir/files/" & DataBinder.Eval(Container.DataItem,"file_title")%>'></asp:HyperLink></li>
                                </ItemTemplate>
                                <FooterTemplate>
                                    </ul>
                                </FooterTemplate>
                            </asp:Repeater>
                        </div>
                        <br class="clear" />
                        <asp:Panel runat="server" ID="galleryPNL" Visible="true" CssClass="gallery curved">
                            <asp:Panel runat="server" ID="classesPNL">
                                <h2>Examples of children's work</h2>
                            </asp:Panel>
                            <asp:Panel runat="server" ID="communityPNL" Visible="false">
                                <h2>Community Gallery</h2>
                            </asp:Panel>
                            <asp:Repeater runat="server" ID="photoRPT" OnItemDataBound="photoRPT_ItemDataBound">
                                <HeaderTemplate>
                                    <div class="infiniteCarousel">
                                      <div class="wrapper">
                                        <ul>
                                </HeaderTemplate>
                                <ItemTemplate>
                                            <li><asp:hyperlink runat="server" ID="photoHL"></asp:hyperlink></li>
                                </ItemTemplate>
                                <FooterTemplate>
                                            </ul>        
                                        </div>
                                        <br class="clear" />
                                        <asp:HyperLink runat="server" ID="nextHL" CssClass="scroll forward" NavigateUrl="" Text="&gt;"></asp:HyperLink>
                                        <asp:HyperLink runat="server" ID="backHL" CssClass="scroll back" NavigateUrl="" Text="&lt;"></asp:HyperLink>
                                    </div>
                                </FooterTemplate>
                            </asp:Repeater>
                            
                            <br class="clear" />
                        </asp:Panel>
                        <br class="clear" />
                        <asp:HyperLink runat="server" ID="newsletterHL" Visible="false" CssClass="newsletter" Target="_blank"></asp:HyperLink>
                        
                        <div class="pencil" runat="server" id="pencilDIV" visible="false"></div>
                        <div class="paintbrush" runat="server" id="paintbrushDIV" visible="false"></div>
                        <div class="scissors" runat="server" id="scissorsDIV" visible="false"></div>
                        <div class="trowel" runat="server" id="trowelDIV" visible="false"></div>
                        <div class="pen" runat="server" id="penDIV" visible="false"></div>
                        <div class="ladybird" runat="server" id="ladybirdDIV" visible="false"></div>
                        <div class="butterfly_1" runat="server" id="butterfly1DIV" visible="false"></div>
                        <div class="butterfly_2" runat="server" id="butterfly2DIV" visible="false"></div>
                        <br class="clear" />
                    </div>
                    <div class="div_bl"></div>
                    <div class="div_bb"></div>
                    <div class="div_b"></div>
                    <div class="div_br"></div>
                </div>
                <br class="clear" />
                
            </div>
            <br class="clear" />
            <div class="accreditations">
                <div class="ac_tl"></div>
                <div class="ac_t"></div>
                <div class="ac_tfill"></div>
                <div class="ac_tr"></div>
                <div class="ac_l"></div>
                <div class="ac_lfill"></div>
                <div class="ac_r"></div>
                <div class="ac_rfill"></div>
                <div class="ac_wb">
                    <div class="accreditation1"></div>
                    <div class="accreditation2"></div>
                    <div class="accreditation3"></div>
                    <div class="accreditation4"></div>
                    <div class="accreditation5"></div>
                    <div class="accreditation6"></div>
                    <div class="accreditation7"></div>
                </div>
                <div class="ac_bl"></div>
                <div class="ac_b"></div>
                <div class="ac_bfill"></div>
                <div class="ac_br"></div>
                <div class="caterpillar" runat="server" id="caterpillarDIV" visible="false"></div>
            </div>
            <div class="footer">
                <ul>
                    <li class="col1">
                        <a href="../default.aspx">Home</a>
                        <ul>
                            <li><asp:hyperlink runat="server" ID="f1" NavigateUrl="~/our-community/">Our Community</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f2" NavigateUrl="~/pta-shop/">PTA</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f28" NavigateUrl="http://www.willastonpta.co.uk/">PTA Shop</asp:hyperlink></li>
                        </ul>
                    </li>
                    <li class="col2">
                        <asp:hyperlink runat="server" ID="f3" NavigateUrl="~/about-our-school/">About Our School</asp:hyperlink>
                        <ul>
                            <li><asp:hyperlink runat="server" ID="f4" NavigateUrl="~/about-our-school/default.aspx?id=what-they-say">What They Say</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f5" NavigateUrl="~/about-our-school/default.aspx?id=school-details">School Details</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f6" NavigateUrl="~/about-our-school/default.aspx?id=our-uniform">Our Uniform</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f25" NavigateUrl="~/about-our-school/default.aspx?id=admissions">Admissions</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f7" NavigateUrl="~/about-our-school/default.aspx?id=policies">Policies</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f8" NavigateUrl="~/about-our-school/default.aspx?id=clubs">Clubs</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f9" NavigateUrl="~/about-our-school/default.aspx?id=governors">Governors</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f10" NavigateUrl="~/about-our-school/default.aspx?id=s4yc">S4YC</asp:hyperlink></li>
                        </ul>
                    </li>
                    <li class="col3">
                        <asp:hyperlink runat="server" ID="f24" NavigateUrl="~/our-classes/">Our Classes</asp:hyperlink>
                        <ul>
                            <li><asp:hyperlink runat="server" ID="f11" NavigateUrl="~/our-classes/default.aspx?id=forest-school">Forest School</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f12" NavigateUrl="~/our-classes/default.aspx?id=reception-class">Reception Class</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f13" NavigateUrl="~/our-classes/default.aspx?id=year-one">Year One</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f14" NavigateUrl="~/our-classes/default.aspx?id=year-two">Year Two</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f15" NavigateUrl="~/our-classes/default.aspx?id=year-three">Year Three</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f16" NavigateUrl="~/our-classes/default.aspx?id=year-four">Year Four</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f17" NavigateUrl="~/our-classes/default.aspx?id=year-five">Year Five</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f18" NavigateUrl="~/our-classes/default.aspx?id=year-six">Year Six</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f19" NavigateUrl="~/our-classes/default.aspx?id=school-trips">School Trips</asp:hyperlink></li>
                        </ul>
                    </li>
                    <li class="col4">
                        <asp:hyperlink runat="server" ID="f20" NavigateUrl="~/office/">Office</asp:hyperlink>
                        <ul>
                        
                            <li><asp:hyperlink runat="server" ID="f27" NavigateUrl="~/office/default.aspx?id=calendar">School Holidays</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f21" NavigateUrl="~/office/default.aspx?id=willaston-school-calendar">Calendar</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f22" NavigateUrl="~/office/default.aspx?id=contact">Contact</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f23" NavigateUrl="~/office/default.aspx?id=news">News</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f26" NavigateUrl="~/office/default.aspx?id=finance">Finance</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="f29" NavigateUrl="~/office/default.aspx?id=terms-and-conditions">Terms and Conditions</asp:hyperlink></li>
                            <li><asp:hyperlink runat="server" ID="Hyperlink1" NavigateUrl="~/office/default.aspx?id=terms-and-conditions#cookie-policy">Cookie Policy</asp:hyperlink></li>
                        </ul>
                    </li>
                </ul>
                <br class="clear" />
            </div>
            <div class="tie"></div>            
        </div>
    <asp:Panel runat="server" ID="pageimagemaskPNL">
        <script>
            var imgs = $('img').not('.nowrap');
            $(imgs).wrap('<div class="contentimg">');
            $(imgs).before('<div class="frame_top"></div>')
            $(imgs).before('<div class="frame_bottom"></div>')
        </script>
    </asp:Panel>
    
    </form> 
    
   
</body>
</html>
