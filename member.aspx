<%@ Page Language="C#" AutoEventWireup="true" CodeFile="member.aspx.cs" Inherits="KBC.member" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Members | KBC Official</title>

  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&family=Outfit:wght@400;500;700;800;900&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="index.css">
  <link rel="stylesheet" href="member.css">
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
        <div class="brand">
          <img src="logo.png" alt="KBC Logo">
          <div class="brand-text">
            <span>KBC</span>
            <p>KUET Business & Entrepreneurship Club</p>
          </div>
        </div>
        <nav class="nav-links">
          <a href="index.aspx#home">Home</a>
          <a href="index.aspx#about">About</a>
          <a href="events.aspx">Events</a>
          <a href="index.aspx#vision">Vision</a>
          <a href="admin-login.aspx" class="nav-cta">Admin</a>
        </nav>
      </div>
    </header>

    <main>
      <section class="members-hero">
        <div class="container">
          <div class="members-hero-content reveal">
            <p class="eyebrow">Our Team</p>
            <h1>Meet the Team Behind KBC</h1>
            <p>Get to know the dedicated members and leaders of the KUET Business & Entrepreneurship Club who are passionate about your success.</p>
          </div>
        </div>
      </section>

      <section class="section section-members-full">
        <div class="container">
          <div class="members-filter reveal">
            <button class="filter-btn active" data-filter="all">All</button>
            <button class="filter-btn" data-filter="leadership">Leadership</button>
            <button class="filter-btn" data-filter="coordinators">Coordinators</button>
            <button class="filter-btn" data-filter="volunteers">Volunteers</button>
          </div>

          <div class="members-grid-full reveal">
            <asp:Repeater ID="rptMembers" runat="server">
              <ItemTemplate>
                <article class="member-card-full" data-category='<%# Eval("Category") %>'>
                  <div class="member-avatar-full">
                    <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
                  </div>
                  <div class="member-info">
                    <h3><%# Eval("Name") %></h3>
                    <p class="member-role-full"><%# Eval("Role") %></p>
                    <p class="member-department">Department: <%# Eval("Department") %></p>
                    <p class="member-bio-full"><%# Eval("Bio") %></p>
                    <div class="member-contact">
                      <a href='<%# "mailto:" + Eval("Email") %>'>Email</a>
                      <a href='<%# Eval("LinkedInUrl") %>'>LinkedIn</a>
                    </div>
                  </div>
                </article>
              </ItemTemplate>
            </asp:Repeater>
          </div>
        </div>
      </section>

      <section class="section section-join">
        <div class="container join-content reveal">
          <h2>Interested in Joining KBC?</h2>
          <p>We're always looking for passionate members who want to make a difference in the KUET community.</p>
          <a href="index.aspx#vision" class="btn-primary">Join the Team</a>
        </div>
      </section>
    </main>

    <footer class="site-footer">
      <div class="container footer-inner">
        <p>&copy; 2024 KBC Official. All rights reserved.</p>
        <a href="#">Privacy Policy</a>
        <a href="#">Contact Us</a>
      </div>
    </footer>

    <script src="member.js"></script>
  </form>
</body>
</html>
