<%@ Page Language="C#" AutoEventWireup="true" CodeFile="admin-login.aspx.cs" Inherits="KBC.admin_login" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Login | KBC Official</title>
  <link rel="stylesheet" href="admin-login.css">
</head>
<body class="login-page">
  <form id="form1" runat="server">
    <header class="site-header login-header">
      <div class="container header-inner">
        <div class="brand">
          <img src="logo.png" alt="KBC Logo">
          <div class="brand-text">
            <span>KBC</span>
            <p>KUET Business & Entrepreneurship Club</p>
          </div>
        </div>
        <div class="header-actions">
          <a href="index.aspx" class="btn-secondary">Home</a>
          <a href="admin-signup.aspx" class="btn-secondary">Signup</a>
        </div>
        <div class="header-note">
          <p>Admin Login</p>
        </div>
      </div>
    </header>

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
  </form>
</body>
</html>
