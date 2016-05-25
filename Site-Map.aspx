<%@ Page Title="" Language="VB" MasterPageFile="~/masterpages/main.master" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Configuration" %>
<%@ Import Namespace="System.Drawing" %>

<script runat="server">
    Dim siteid As Integer = 16
    Dim pageclass As New page
    Dim cv As New ControlValues
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        
        Dim sitename As String = cv.ReturnSiteTitle()
        Page.Title = sitename & " | Site Map"
        
        Repeater1.DataSource = pageclass.ReturnActivePages_ByParentID(0, siteid)
        Repeater1.DataBind()
        
        For Each row1 As RepeaterItem In Repeater1.Items 'TOP LEVEL
            Dim pageid1 As Integer = DirectCast(row1.FindControl("pageidHF"), HiddenField).Value
            Dim parentid1 As Integer = DirectCast(row1.FindControl("parentidHF"), HiddenField).Value
            Dim pagetype1 As String = DirectCast(row1.FindControl("pagetypeHF"), HiddenField).Value
            Dim pageurl1 As String = DirectCast(row1.FindControl("pageurlHF"), HiddenField).Value
            Dim viewHL1 As HyperLink = DirectCast(row1.FindControl("viewHL"), HyperLink)
            Dim repeater2 As Repeater = DirectCast(row1.FindControl("repeater2"), Repeater)
            
            If pagetype1.ToLower = "default" Then 'default
                viewHL1.NavigateUrl = pageurl1
            ElseIf pagetype1.ToLower = "custom" Then 'specific urls
                viewHL1.NavigateUrl = pageurl1
            ElseIf pagetype1.ToLower = "standard" Then 'standard
                viewHL1.NavigateUrl = "~/page.aspx?id=" & pageurl1
            End If
            
            repeater2.DataSource = pageclass.ReturnActivePages_ByParentID(pageid1, siteid)
            repeater2.DataBind()
            For Each row2 As RepeaterItem In repeater2.Items 'SUB LEVEL
                Dim pageid2 As Integer = DirectCast(row2.FindControl("pageidHF"), HiddenField).Value
                Dim parentid2 As Integer = DirectCast(row2.FindControl("parentidHF"), HiddenField).Value
                Dim pagetype2 As String = DirectCast(row2.FindControl("pagetypeHF"), HiddenField).Value
                Dim pageurl2 As String = DirectCast(row2.FindControl("pageurlHF"), HiddenField).Value
                Dim viewHL2 As HyperLink = DirectCast(row2.FindControl("viewHL"), HyperLink)
                Dim repeater3 As Repeater = DirectCast(row2.FindControl("repeater3"), Repeater)
                
                If pagetype2.ToLower = "custom" Then 'specific urls
                    viewHL2.NavigateUrl = pageurl2
                Else 'standard 
                    If pagetype1.ToLower = "standard" Then
                        viewHL2.NavigateUrl = "~/page.aspx?id=" & pageurl2
                    Else
                        viewHL2.NavigateUrl = pageclass.returnPageURL(parentid2) & "?id=" & pageurl2
                    End If
                End If
                
                repeater3.DataSource = pageclass.ReturnActivePages_ByParentID(pageid2, siteid)
                repeater3.DataBind()
                For Each row3 As RepeaterItem In repeater3.Items 'THIRD LEVEL
                    Dim pageid3 As Integer = DirectCast(row3.FindControl("pageidHF"), HiddenField).Value
                    Dim parentid3 As Integer = DirectCast(row3.FindControl("parentidHF"), HiddenField).Value
                    Dim pagetype3 As String = DirectCast(row3.FindControl("pagetypeHF"), HiddenField).Value
                    Dim pageurl3 As String = DirectCast(row3.FindControl("pageurlHF"), HiddenField).Value
                    Dim viewHL3 As HyperLink = DirectCast(row3.FindControl("viewHL"), HyperLink)
                    
                    If pagetype3.ToLower = "custom" Then 'specific urls
                        viewHL3.NavigateUrl = pageurl3
                    Else 'standard 
                        If pagetype1.ToLower = "standard" Then
                            viewHL3.NavigateUrl = "~/page.aspx?id=" & pageurl3
                        Else
                            viewHL3.NavigateUrl = pageclass.returnPageURL(parentid2) & "?id=" & pageurl3
                        End If
                    End If
                Next

            Next
        Next
        
    End Sub
    

</script>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    
            

            <asp:Repeater ID="Repeater1" runat="server">
                <ItemTemplate>
                    <asp:HiddenField ID="pageidHF" runat="server" value='<%#DataBinder.Eval(Container.DataItem, "pageid")%>' />      
                    <asp:HiddenField ID="parentidHF" runat="server" value='<%#DataBinder.Eval(Container.DataItem, "parentid")%>' /> 
                    <asp:HiddenField ID="pagetypeHF" runat="server" value='<%#DataBinder.Eval(Container.DataItem, "pagetype")%>' />      
                    <asp:HiddenField ID="pageurlHF" runat="server" value='<%#DataBinder.Eval(Container.DataItem, "pageurl")%>' />  
                    <asp:HyperLink ID="viewHL" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "menutitle")%>' /><br />        
        
                    <div class="sitemap">
                        <asp:Repeater ID="Repeater2" runat="server" >
                            <ItemTemplate>
                                <asp:HiddenField ID="pageidHF" runat="server" value='<%#DataBinder.Eval(Container.DataItem, "pageid")%>' />   
                                <asp:HiddenField ID="parentidHF" runat="server" value='<%#DataBinder.Eval(Container.DataItem, "parentid")%>' /> 
                                <asp:HiddenField ID="pagetypeHF" runat="server" value='<%#DataBinder.Eval(Container.DataItem, "pagetype")%>' />      
                                <asp:HiddenField ID="pageurlHF" runat="server" value='<%#DataBinder.Eval(Container.DataItem, "pageurl")%>' />  
                                <asp:HyperLink ID="viewHL" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "menutitle")%>' /><br />        
                    
                                <div class="sitemap">
                                    <asp:Repeater ID="Repeater3" runat="server" >
                                        <ItemTemplate>
                                            <asp:HiddenField ID="pageidHF" runat="server" value='<%#DataBinder.Eval(Container.DataItem, "pageid")%>' />    
                                            <asp:HiddenField ID="parentidHF" runat="server" value='<%#DataBinder.Eval(Container.DataItem, "parentid")%>' /> 
                                            <asp:HiddenField ID="pagetypeHF" runat="server" value='<%#DataBinder.Eval(Container.DataItem, "pagetype")%>' />      
                                            <asp:HiddenField ID="pageurlHF" runat="server" value='<%#DataBinder.Eval(Container.DataItem, "pageurl")%>' />  
                                            <asp:HyperLink ID="viewHL" runat="server" Text='<%#DataBinder.Eval(Container.DataItem, "menutitle")%>' />   <br />     
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                    
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

        
                </ItemTemplate>
            </asp:Repeater>
        
</asp:Content>


