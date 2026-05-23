<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="member.aspx.cs" Inherits="KBC.member" %>
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
            <!-- Leadership Team -->
            <article class="member-card-full" data-category="leadership">
              <div class="member-avatar-full">
                <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
              </div>
              <div class="member-info">
                <h3>Ahmed Hassan</h3>
                <p class="member-role-full">President</p>
                <p class="member-department">Department: CSE</p>
                <p class="member-bio-full">Visionary leader with a passion for entrepreneurship and student development. Ahmed has successfully organized 20+ seminars and mentored 100+ students in career planning.</p>
                <div class="member-contact">
                  <a href="mailto:ahmed@kbc.com">Email</a>
                  <a href="#">LinkedIn</a>
                </div>
              </div>
            </article>

            <article class="member-card-full" data-category="leadership">
              <div class="member-avatar-full">
                <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
              </div>
              <div class="member-info">
                <h3>Fatima Rahman</h3>
                <p class="member-role-full">Vice President</p>
                <p class="member-department">Department: EEE</p>
                <p class="member-bio-full">Strategic thinker dedicated to organizing impactful career seminars and workshops. Fatima brings excellent organizational skills and industry connections.</p>
                <div class="member-contact">
                  <a href="mailto:fatima@kbc.com">Email</a>
                  <a href="#">LinkedIn</a>
                </div>
              </div>
            </article>

            <!-- Coordinators -->
            <article class="member-card-full" data-category="coordinators">
              <div class="member-avatar-full">
                <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
              </div>
              <div class="member-info">
                <h3>Karim Khan</h3>
                <p class="member-role-full">Events Manager</p>
                <p class="member-department">Department: ME</p>
                <p class="member-bio-full">Creative organizer bringing professional speakers and mentors to our community. Karim has coordinated partnerships with 30+ industry experts.</p>
                <div class="member-contact">
                  <a href="mailto:karim@kbc.com">Email</a>
                  <a href="#">LinkedIn</a>
                </div>
              </div>
            </article>

            <article class="member-card-full" data-category="coordinators">
              <div class="member-avatar-full">
                <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
              </div>
              <div class="member-info">
                <h3>Nusrat Jahan</h3>
                <p class="member-role-full">Workshop Coordinator</p>
                <p class="member-department">Department: Civil</p>
                <p class="member-bio-full">Passionate educator focused on skill development and student empowerment. Nusrat designs and delivers engaging workshops on communication and leadership.</p>
                <div class="member-contact">
                  <a href="mailto:nusrat@kbc.com">Email</a>
                  <a href="#">LinkedIn</a>
                </div>
              </div>
            </article>

            <article class="member-card-full" data-category="coordinators">
              <div class="member-avatar-full">
                <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
              </div>
              <div class="member-info">
                <h3>Rashid Ahmed</h3>
                <p class="member-role-full">Treasurer</p>
                <p class="member-department">Department: IPE</p>
                <p class="member-bio-full">Financial steward ensuring resources support our mission and growth. Rashid manages budgets and sponsorships for all KBC activities.</p>
                <div class="member-contact">
                  <a href="mailto:rashid@kbc.com">Email</a>
                  <a href="#">LinkedIn</a>
                </div>
              </div>
            </article>

            <!-- Volunteers -->
            <article class="member-card-full" data-category="volunteers">
              <div class="member-avatar-full">
                <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
              </div>
              <div class="member-info">
                <h3>Zara Malik</h3>
                <p class="member-role-full">Social Media Lead</p>
                <p class="member-department">Department: CSE</p>
                <p class="member-bio-full">Digital communicator connecting KBC with the broader student community. Zara manages all social media channels with engaging content.</p>
                <div class="member-contact">
                  <a href="mailto:zara@kbc.com">Email</a>
                  <a href="#">LinkedIn</a>
                </div>
              </div>
            </article>

            <article class="member-card-full" data-category="volunteers">
              <div class="member-avatar-full">
                <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
              </div>
              <div class="member-info">
                <h3>Imran Hossain</h3>
                <p class="member-role-full">Content Coordinator</p>
                <p class="member-department">Department: EEE</p>
                <p class="member-bio-full">Creative storyteller documenting KBC's journey. Imran produces videos, blogs, and promotional materials for our events and programs.</p>
                <div class="member-contact">
                  <a href="mailto:imran@kbc.com">Email</a>
                  <a href="#">LinkedIn</a>
                </div>
              </div>
            </article>

            <article class="member-card-full" data-category="volunteers">
              <div class="member-avatar-full">
                <svg width="64" height="64" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg>
              </div>
              <div class="member-info">
                <h3>Sabrina Begum</h3>
                <p class="member-role-full">Volunteer Lead</p>
                <p class="member-department">Department: Architecture</p>
                <p class="member-bio-full">Energetic team builder coordinating volunteer activities and team initiatives. Sabrina ensures smooth execution of all KBC events and activities.</p>
                <div class="member-contact">
                  <a href="mailto:sabrina@kbc.com">Email</a>
                  <a href="#">LinkedIn</a>
                </div>
              </div>
            </article>
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
