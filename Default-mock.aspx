<%@ Page Title="" Language="VB" MasterPageFile="~/masterpages/main.master" AutoEventWireup="false" CodeFile="Default-mock.aspx.vb" Inherits="Default_mock" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="styles/home.css" rel="stylesheet" type="text/css" />
    <script src="script/newsticker.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h1><asp:Literal ID="titleLT" runat="server" /></h1>
    <asp:literal ID="contentLTL" runat="server"></asp:literal>
    <div id="embeddiv" runat="server"></div>

</asp:Content>
