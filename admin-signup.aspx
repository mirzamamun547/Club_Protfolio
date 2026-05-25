<%@ Page Language="C#" AutoEventWireup="true" CodeFile="admin-signup.aspx.cs" Inherits="KBC.admin_signup" MasterPageFile="~/Site.Master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
  Admin Signup | KBC Official
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <link rel="stylesheet" href="admin-signup.css">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <main class="login-section">
      <div class="container login-shell">
        <section class="login-panel">
          <div class="login-copy">
            <p class="eyebrow">Admin Signup</p>
            <h1>Create your KBC admin access</h1>
            <p>Register securely to manage club events, announcements, and member updates for KUET Business and Entrepreneurship Club.</p>
          </div>

          <div class="auth-form">
            <asp:Label ID="lblMessage" runat="server" CssClass="message-label" ForeColor="#FF6B6B" Font-Bold="true" Style="display:block; margin-bottom:10px;" />
            <label>
              <span>Full name</span>
              <asp:TextBox ID="txtName" runat="server" placeholder="Your full name" required="required" />
            </label>
            <label>
              <span>Email address</span>
              <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="admin@kbcofficial.com" required="required" />
            </label>
            <label>
              <span>Password</span>
              <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Choose a strong password" required="required" />
            </label>
            <label>
              <span>Confirm password</span>
              <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="Repeat your password" required="required" />
            </label>
            <asp:Button ID="btnSignup" runat="server" Text="Signup" CssClass="btn-primary" OnClick="btnSignup_Click" />
            <p class="auth-note">Already have an account? <a href="admin-login.aspx">Login here</a></p>
          </div>
        </section>
      </div>
    </main>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
