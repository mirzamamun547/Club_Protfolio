<%@ Page Language="C#" AutoEventWireup="true" CodeFile="advisor.aspx.cs" Inherits="KBC.advisor" MasterPageFile="~/Site.Master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
  Advisors | KBC Official
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <link rel="stylesheet" href="advisor.css">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <section class="advisors-hero">
    <div class="container">
      <div class="advisors-hero-content reveal">
        <p class="eyebrow">Our Guidance</p>
        <h1>Meet Our Advisors</h1>
        <p>Learn from experienced industry leaders and faculty members who are committed to mentoring the next generation of entrepreneurs and business professionals.</p>
      </div>
    </div>
  </section>

  <section class="section section-advisors-full">
    <div class="container">
      <div class="advisors-filter reveal">
        <button type="button" class="filter-btn active" data-filter="all">All</button>
        <button type="button" class="filter-btn" data-filter="faculty">Faculty</button>
        <button type="button" class="filter-btn" data-filter="industry">Industry</button>
      </div>

      <div class="advisors-grid-full reveal">
        <asp:Repeater ID="rptAdvisors" runat="server">
          <ItemTemplate>
            <article class="advisor-card-full" data-category='<%# GetAdvisorCategory(Eval("Role").ToString()) %>'
              style='background-image: linear-gradient(135deg, rgba(15, 23, 42, 0.7) 0%, rgba(15, 23, 42, 0.5) 100%), url(<%# ResolveUrl(string.IsNullOrEmpty(Eval("PhotoPath").ToString()) ? "~/images/default-advisor.png" : Eval("PhotoPath").ToString()) %>); background-size: cover; background-position: center;'>
              <div class="advisor-info">
                <div class="advisor-label">ADVISOR</div>
                <h3><%# Eval("Name") %></h3>
                <p class="advisor-role-full"><%# Eval("Role") %></p>
                <p class="advisor-expertise"><%# Eval("Expertise") %></p>
                <div class="advisor-contact">
                  <a href='<%# "mailto:" + Eval("Email") %>'>Contact</a>
                </div>
              </div>
            </article>
          </ItemTemplate>
        </asp:Repeater>
      </div>
    </div>
  </section>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
  <script>
    // Initialize filter functionality
    document.querySelectorAll('.filter-btn').forEach(btn => {
      btn.addEventListener('click', function() {
        // Update active button
        document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
        this.classList.add('active');

        // Get selected filter
        const filter = this.getAttribute('data-filter');
        const cards = document.querySelectorAll('.advisor-card-full');

        // Filter and show/hide cards with animation
        cards.forEach(card => {
          const category = card.getAttribute('data-category');

          if (filter === 'all' || category === filter) {
            card.style.display = 'block';
            card.style.animation = 'revealFadeIn 0.6s ease-out forwards';
          } else {
            card.style.display = 'none';
            card.style.animation = 'none';
          }
        });
      });
    });

    // Log categories for debugging
    console.log('Advisor categories loaded:');
    document.querySelectorAll('.advisor-card-full').forEach((card, index) => {
      console.log(`Card ${index + 1}: ${card.getAttribute('data-category')}`);
    });
  </script>
</asp:Content>
