<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin-signup.aspx.cs" Inherits="KBC.admin_signup" %>
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
            <label>
              <span>Full name</span>
              <input type="text" name="name" placeholder="Your full name" required>
            </label>
            <label>
              <span>Email address</span>
              <input type="email" name="email" placeholder="admin@kbcofficial.com" required>
            </label>
            <label>
              <span>Password</span>
              <input type="password" name="password" placeholder="Choose a strong password" required>
            </label>
            <label>
              <span>Confirm password</span>
              <input type="password" name="confirm_password" placeholder="Repeat your password" required>
            </label>
            <button type="submit" class="btn-primary">Signup</button>
            <p class="auth-note">Already have an account? <a href="admin-login.aspx">Login here</a></p>
          </div>
        </section>
      </div>
    </main>
  </form>
</body>
</html>
