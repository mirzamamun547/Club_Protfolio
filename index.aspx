<%@ Page Language="C#" AutoEventWireup="true" CodeFile="index.aspx.cs" Inherits="KBC.index" MasterPageFile="~/Site.Master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
  KUET Business and Entrepreneurship Club (KBEC) | Innovation & Entrepreneurship
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
      <section id="home" class="hero section-hero">
        <div class="container hero-grid">
          <div class="hero-copy-block reveal">
            <p class="eyebrow">KBEC</p>
            <h1>KUET Business & Entrepreneurship Club</h1>
            <p class="hero-copy">The Premier Business and Entrepreneurship Club at KUET.Igniting enthusiasm, expertise, and excellence at KUET. Empowering students to master skills, innovate, and shine globally with KBC.</p>
            <div class="hero-actions reveal">
              <a class="btn-secondary" href="#about" aria-label="Discover more about KBEC">Discover More</a>
              <a class="btn-primary" href="events.aspx" aria-label="View upcoming events">View Events</a>
            </div>
          </div>
         
        </div>
      </section>

      <section class="section section-offer">
        <div class="container">
          <div class="offer-panel reveal">
            <h2>What we offer</h2>
            <ul class="offer-list">
              <li>Career seminars with national speakers</li>
              <li>Skill development workshops</li>
              <li>Idea sharing & leadership sessions</li>
              <li>Higher study guidance and alumni mentorship</li>
            </ul>
          </div>
        </div>
      </section>

      <section id="about" class="section section-about">
        <svg class="about-curve-bg" viewBox="0 0 1440 300" preserveAspectRatio="none">
          <defs>
            <linearGradient id="curveBgGradient" x1="0%" y1="0%" x2="0%" y2="100%">
              <stop offset="0%" style="stop-color:#FFC85B;stop-opacity:0.35" />
              <stop offset="50%" style="stop-color:#F7D07A;stop-opacity:0.18" />
              <stop offset="100%" style="stop-color:#FFDFA7;stop-opacity:0.06" />
            </linearGradient>
          </defs>
          <path d="M0,80 Q360,20 720,80 T1440,80 L1440,0 L0,0 Z" fill="url(#curveBgGradient)"></path>
          <path d="M0,120 Q360,60 720,120 T1440,120 L1440,80 Q720,20 0,80 Z" fill="rgba(255, 200, 91, 0.12)"></path>
        </svg>

        <div class="container section-heading reveal">
          <p class="eyebrow">About KBEC</p>
          <h2>Helping KUETians choose the right career path</h2>
          <p>KBEC, the premier business and entrepreneurship club of Khulna University of Engineering & Technology, bridges engineering excellence with entrepreneurial vision. Through KBEC Nexus, Entrepreneurial Voice, Case Crack, workshops, seminars, startup programs, and TEDxKUET, it empowers students from idea to launch, fostering leadership, innovation, and real-world impact.</p>
        </div>
        <div class="container about-grid reveal">
          <article class="feature-card">
            <h3>Career Awareness</h3>
            <p>Guiding students through industry trends, job opportunities, entrepreneurship, and higher education choices.</p>
          </article>
          <article class="feature-card">
            <h3>Practical Skills</h3>
            <p>Developing communication, teamwork, problem solving, and leadership skills through focused workshops.</p>
          </article>
          <article class="feature-card">
            <h3>Alumni & Expert Support</h3>
            <p>Connecting students with successful alumni, trainers, and faculty for mentorship and real-world guidance.</p>
          </article>
        </div>
      </section>

      <section id="programs" class="section section-programs">
        <div class="container section-heading reveal">
          <p class="eyebrow">Our Events</p>
          <h2>Events designed to inspire and prepare</h2>
        </div>
        <div class="container programs-grid reveal">
          <article class="program-card">
            <h3>Career Seminars</h3>
            <p>Expert-led sessions on career planning, interview preparation, and competitive industries.</p>
          </article>
          <article class="program-card">
            <h3>Skill Workshops</h3>
            <p>Interactive trainings for communication, leadership, design thinking, and personal development.</p>
          </article>
          <article class="program-card">
            <h3>Idea Labs</h3>
            <p>Collaborative sessions for sharing business ideas, innovation, and entrepreneurial mindset development.</p>
          </article>
        </div>
      </section>

      <section id="vision" class="section section-vision">
        <div class="container vision-inner reveal">
          <div>
            <p class="eyebrow">Our Vision</p>
            <h2>Confident KUETians thriving across every sector</h2>
            <p>We aim to make every student career-conscious and prepared to compete for top jobs, higher study programs, and entrepreneurial success.</p>
            <a class="btn-primary" href="admin-login.aspx">Join the Team    </a>
          </div>
          <div class="vision-stats">
            <div class="stat-card">
              <strong>100+</strong>
              <span>Events hosted</span>
            </div>
            <div class="stat-card">
              <strong>50+</strong>
              <span>Speakers & mentors</span>
            </div>
            <div class="stat-card">
              <strong>2000+</strong>
              <span>Students reached</span>
            </div>
          </div>
        </div>
      </section>

      <section id="contact" class="section section-contact">
        <div class="container section-heading reveal">
          <p class="eyebrow">Stay Connected</p>
          <h2>Follow KBC for updates</h2>
          <p>Keep in touch with our events, workshops, and program announcements on social media.</p>
        </div>
        <div class="container contact-grid reveal">
          <div class="contact-card">
            <h3>Email</h3>
            <p>info@kbcofficial.com</p>
          </div>
          <div class="contact-card">
            <h3>Location</h3>
            <p>KUET Campus, Khulna</p>
          </div>
          <div class="contact-card">
            <h3>Social</h3>
            <p>Facebook / Instagram / LinkedIn</p>
          </div>
        </div>
      </section>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>