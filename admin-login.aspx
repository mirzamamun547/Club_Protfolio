<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="admin-login.aspx.cs" Inherits="KBC.admin_login" %>
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
            <label>
              <span>Email address</span>
              <input type="email" name="email" id="txtEmail" placeholder="admin@kbcofficial.com" required>
            </label>
            <label>
              <span>Password</span>
              <input type="password" name="password" id="txtPassword" placeholder="••••••••" required>
            </label>
            <button type="submit" class="btn-primary" id="btnLogin">Login</button>
            <p class="auth-note">Need support? <a href="mailto:info@kbcofficial.com">info@kbcofficial.com</a></p>
          </div>
        </section>
      </div>
    </main>

    <script>
      document.querySelector('.auth-form').addEventListener('submit', function(e) {
        e.preventDefault();
        
        const email = document.getElementById('txtEmail').value;
        const password = document.getElementById('txtPassword').value;
        
        // Basic validation
        if (!email || !password) {
          alert('Please fill in all fields');
          return;
        }
        
        // Simple demo credentials
        const adminEmail = 'admin@kbcofficial.com';
        const adminPassword = 'KBC@2024';
        
        if (email === adminEmail && password === adminPassword) {
          alert('Login successful!');
          // Redirect to admin dashboard
          window.location.href = 'admin-dashboard.aspx';
        } else {
          alert('Invalid email or password');
        }
      });
    </script>
  </form>
</body>
</html>
