<%@ Page Language="C#" AutoEventWireup="true" CodeFile="events.aspx.cs" Inherits="KBC.events_page" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Events | KBC Official</title>
  
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Outfit:wght@400;500;700;800;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="index.css">
</head>
<body>
  <form id="form1" runat="server">
    <div class="bg-shapes">
      <div class="shape shape-1"></div>
      <div class="shape shape-2"></div>
      <div class="shape shape-3"></div>
    </div>
    
    <header class="site-header">
      <div class="container header-inner">
        <a href="index.aspx" class="brand">
          <img src="logo.png" alt="KBC Logo">
          <div class="brand-text">
            <span>KBC</span>
            <p>KUET Business & Entrepreneurship Club</p>
          </div>
        </a>
        <nav class="nav-links">
          <a href="index.aspx#home">Home</a>
          <a href="index.aspx#about">About</a>
          <a href="events.aspx" class="active-link" style="color: var(--text); border-bottom: 2px solid var(--primary);">Events</a>
          <a href="index.aspx#vision">Vision</a>
          <a href="admin-login.aspx" class="nav-cta">Admin</a>
        </nav>
      </div>
    </header>

    <main>
      <section class="section">
        <div class="container section-heading reveal">
          <p class="eyebrow">Discover What's Next</p>
          <h2>Workshops & Events</h2>
          <p>Join our upcoming events to learn, network, and grow with industry leaders.</p>
        </div>

        <div class="container events-grid reveal">
          <asp:Repeater ID="rptEvents" runat="server">
            <ItemTemplate>
              <article class="event-card">
                <div class="event-image">
                  <span class='<%# "event-badge badge-" + Eval("Status").ToString().ToLower() %>'><%# Eval("Status") %></span>
                  <div style='<%# "width: 100%; height: 200px; background: " + Eval("ImageGradient") + ";" %>'></div>
                </div>
                <div class="event-content">
                  <h3 class="event-title"><%# Eval("EventName") %></h3>
                  <div class="event-meta">
                    <span>📅 <%# Eval("EventDate", "{0:MMM d, yyyy}") %></span>
                    <span>📍 <%# Eval("Location") %></span>
                  </div>
                  <p class="event-desc">Join KUET Business and Entrepreneurship Club at <%# Eval("EventName") %> for an inspiring and educational session.</p>
                  <a href='<%# Eval("FacebookUrl") %>' target="_blank" class="btn-secondary event-btn">View Event Details</a>
                </div>
              </article>
            </ItemTemplate>
          </asp:Repeater>
        </div>
      </section>
    </main>

    <footer class="site-footer">
      <div class="container footer-inner">
        <p>© 2026 KUET Business & Entrepreneurship Club. All rights reserved.</p>
      </div>
    </footer>

    <script src="script.js"></script>
  </form>
</body>
</html>
