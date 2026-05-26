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
        <button type='button' class='filter-btn active' data-filter='all'>All</button>
        <button type='button' class='filter-btn' data-filter='leadership'>Leadership</button>
        <button type='button' class='filter-btn' data-filter='coordinators'>Coordinators</button>
        <button type='button' class='filter-btn' data-filter='volunteers'>Volunteers</button>
      </div>

      <div class='members-grid-full reveal'>
        <asp:Repeater ID='rptMembers' runat='server'>
          <ItemTemplate>
            <article class='member-card-full' data-category='<%# Eval("Category") %>'>
              <div class='member-avatar-full'>
                <asp:Image ID="imgMember" runat="server"
                    ImageUrl='<%# string.IsNullOrEmpty(Eval("PhotoPath").ToString()) 
                        ? "~/images/default-member.png" 
                        : ResolveUrl(Eval("PhotoPath").ToString()) %>' Style="width:100%; height:100%; border-radius:50%; object-fit:cover;" />
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
  <script src='member.js?v=2'></script>
</asp:Content>
