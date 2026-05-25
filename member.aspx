<%@ Page Language='C#' AutoEventWireup='true' CodeFile='member.aspx.cs' Inherits='KBC.member' MasterPageFile='~/Site.Master' %>

<asp:Content ID='TitleContent' ContentPlaceHolderID='TitleContent' runat='server'>
  Members | KBC Official
</asp:Content>

<asp:Content ID='HeadContent' ContentPlaceHolderID='HeadContent' runat='server'>
  <link rel='stylesheet' href='member.css'>
</asp:Content>

<asp:Content ID='MainContent' ContentPlaceHolderID='MainContent' runat='server'>
  <section class='members-hero'>
    <div class='container'>
      <div class='members-hero-content reveal'>
        <p class='eyebrow'>Our Team</p>
        <h1>Meet the Team Behind KBC</h1>
        <p>Get to know the dedicated members and leaders of the KUET Business & Entrepreneurship Club who are passionate about your success.</p>
      </div>
    </div>
  </section>

  <section class='section section-members-full'>
    <div class='container'>
      <div class='members-filter reveal'>
        <button class='filter-btn active' data-filter='all'>All</button>
        <button class='filter-btn' data-filter='leadership'>Leadership</button>
        <button class='filter-btn' data-filter='coordinators'>Coordinators</button>
        <button class='filter-btn' data-filter='volunteers'>Volunteers</button>
      </div>

      <div class='members-grid-full reveal'>
        <asp:Repeater ID='rptMembers' runat='server'>
          <ItemTemplate>
            <article class='member-card-full' data-category='<%# Eval("Category") %>'>
              <div class='member-avatar-full'>
                <svg width='64' height='64' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2'></path><circle cx='12' cy='7' r='4'></circle></svg>
              </div>
              <div class='member-info'>
                <h3><%# Eval("Name") %></h3>
                <p class='member-role-full'><%# Eval("Role") %></p>
                <p class='member-department'>Department: <%# Eval("Department") %></p>
                <p class='member-bio-full'><%# Eval("Bio") %></p>
                <div class='member-contact'>
                  <a href='<%# "mailto:" + Eval("Email") %>'>Email</a>
                </div>
              </div>
            </article>
          </ItemTemplate>
        </asp:Repeater>
      </div>
    </div>
  </section>

  <section class='section section-join'>
    <div class='container join-content reveal'>
      <h2>Interested in Joining KBC?</h2>
      <p>We're always looking for passionate members who want to make a difference in the KUET community.</p>
      <a href='index.aspx#vision' class='btn-primary'>Join the Team</a>
    </div>
  </section>
</asp:Content>

<asp:Content ID='ScriptContent' ContentPlaceHolderID='ScriptContent' runat='server'>
  <script src='member.js'></script>
</asp:Content>
