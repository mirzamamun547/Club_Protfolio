<%@ Page Language="C#" AutoEventWireup="true" CodeFile="admin-signup.aspx.cs" Inherits="KBC.admin_signup" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Signup | KBC Official</title>
  <link rel="stylesheet" href="admin-signup.css">
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
          <a href="admin-login.aspx" class="btn-secondary">Admin Login</a>
        </div>
        <div class="header-note">
          <p>Admin Signup</p>
        </div>
      </div>
    </header>

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
  </form>
</body>
</html>
