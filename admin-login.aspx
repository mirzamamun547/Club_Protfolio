<%@ Page Language="C#" AutoEventWireup="true" CodeFile="admin-login.aspx.cs" Inherits="KBC.admin_login" MasterPageFile="~/Site.Master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
  Admin Login | KBC Official
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <link rel="stylesheet" href="admin-login.css">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <main class="login-section">
      <div class="container login-shell">
        <section class="login-panel">
          <div class="login-copy">
            <p class="eyebrow">Admin Login</p>
            <h1>Access the KBC Portal</h1>
            <p>Enter your admin credentials to manage programs, events, and member updates for the KUET Business and Entrepreneurship Club.</p>
          </div>

          <div class="auth-form">
            <asp:Label ID="lblMessage" runat="server" CssClass="message-label" ForeColor="#5CE1E6" Font-Bold="true" Style="display:block; margin-bottom:10px;" />
            <label>
              <span>Email address</span>
              <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="admin@kbcofficial.com" required="required" />
            </label>
            <label>
              <span>Password</span>
              <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="••••••••" required="required" />
            </label>
            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-primary" OnClick="btnLogin_Click" />
            <p class="auth-note">Need support? <a href="mailto:info@kbcofficial.com">info@kbcofficial.com</a></p>
          </div>
        </section>
      </div>
    </main>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
