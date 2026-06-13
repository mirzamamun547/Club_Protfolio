<%@ Page Language="C#" AutoEventWireup="true" CodeFile="admin-dashboard.aspx.cs" Inherits="KBC.admin_dashboard" MasterPageFile="~/Site.Master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
  Admin Dashboard | KBC Official
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <link rel="stylesheet" href="admin-dashboard.css">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="dashboard-shell">
      <aside class="dashboard-sidebar">
        <div class="sidebar-brand">
          <img src="logo.png" alt="KBC Logo" class="sidebar-logo">
          <div>
            <h1>KBC Admin</h1>
            <p>Club Management</p>
          </div>
        </div>

        <nav class="dashboard-nav">
          <a href="#overview" class="nav-link active">Overview</a>
          <a href="#events" class="nav-link">Manage Events</a>
          <a href="#members" class="nav-link">Manage Members</a>
          <a href="#advisors" class="nav-link">Manage Advisors</a>
          <a href="#sponsors" class="nav-link">Manage Sponsors</a>
          <a href="#programs" class="nav-link">Manage Programs</a>
          <asp:LinkButton ID="lnkLogout" runat="server" CssClass="nav-link logout" OnClick="lnkLogout_Click">Logout</asp:LinkButton>
        </nav>
      </aside>

      <main class="dashboard-main">
        <header class="dashboard-header">
          <div>
            <p class="eyebrow">Admin Dashboard</p>
            <h2 id="lblWelcome" runat="server">Welcome, Admin</h2>
            <p>Manage events, members, and programs for the KUET Business & Entrepreneurship Club.</p>
          </div>
          <div class="dashboard-topcard">
            <asp:Label ID="lblAdminEmail" runat="server" Text="admin@kbcofficial.com" />
          </div>
        </header>

        <section id="overview" class="dashboard-section">
          <div class="section-grid">
            <article class="metric-card">
              <h3><asp:Label ID="lblEventCount" runat="server" Text="0" /></h3>
              <p>Events</p>
            </article>
            <article class="metric-card">
              <h3><asp:Label ID="lblMemberCount" runat="server" Text="0" /></h3>
              <p>Members</p>
            </article>
            <article class="metric-card">
              <h3><asp:Label ID="lblProgramCount" runat="server" Text="0" /></h3>
              <p>Programs</p>
            </article>
            <article class="metric-card">
              <h3><asp:Label ID="lblAdvisorCount" runat="server" Text="0" /></h3>
              <p>Advisors</p>
            </article>
            <article class="metric-card">
              <h3><asp:Label ID="lblSponsorCount" runat="server" Text="0" /></h3>
              <p>Sponsors</p>
            </article>
          </div>
        </section>

        <section id="events" class="dashboard-section">
          <div class="section-heading">
            <div>
              <h3>Manage Events</h3>
              <p>View and edit upcoming club events.</p>
            </div>
            <a href="addevents.aspx" class="btn-primary">+ Add Event</a>
          </div>
          <div class="table-wrap">
            <asp:GridView ID="gvEvents" runat="server" AutoGenerateColumns="False" GridLines="None" Width="100%" CssClass="admin-grid">
              <Columns>
                <asp:BoundField DataField="EventName" HeaderText="Event Name" />
                <asp:BoundField DataField="EventDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="Location" HeaderText="Location" />
                <asp:TemplateField HeaderText="Status">
                  <ItemTemplate>
                    <span class='<%# "badge badge-" + Eval("Status").ToString().ToLower() %>'>
                      <%# Eval("Status") %>
                    </span>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action">
                  <ItemTemplate>
                    <span class="action-text" style="color:var(--muted); font-size:0.95rem;">System Locked</span>
                  </ItemTemplate>
                </asp:TemplateField>
              </Columns>
            </asp:GridView>
          </div>
        </section>

        <section id="members" class="dashboard-section">
          <div class="section-heading">
            <div>
              <h3>Manage Members</h3>
              <p>Edit member roles and contact details.</p>
            </div>
            <a href="addmember.aspx" class="btn-primary">+ Add Member (CRUD Lab)</a>
          </div>
          <div class="table-wrap">
            <asp:GridView ID="gvMembers" runat="server" AutoGenerateColumns="False" GridLines="None" Width="100%">
              <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="Role" HeaderText="Role" />
                <asp:BoundField DataField="Department" HeaderText="Department" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:TemplateField HeaderText="Action">
                  <ItemTemplate>
                    <span class="action-text" style="color:var(--muted); font-size:0.95rem;">System Locked</span>
                  </ItemTemplate>
                </asp:TemplateField>
              </Columns>
            </asp:GridView>
          </div>
        </section>

        <section id="advisors" class="dashboard-section">
          <div class="section-heading">
            <div>
              <h3>Manage Advisors</h3>
              <p>Edit advisor information and add new mentors.</p>
            </div>
            <a href="addadvisor.aspx" class="btn-primary">+ Add Advisor (CRUD Lab)</a>
          </div>
          <div class="table-wrap">
            <asp:GridView ID="gvAdvisors" runat="server" AutoGenerateColumns="False" GridLines="None" Width="100%">
              <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="Role" HeaderText="Role" />
                <asp:BoundField DataField="Expertise" HeaderText="Expertise" />
                <asp:BoundField DataField="Department" HeaderText="Department" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:TemplateField HeaderText="Action">
                  <ItemTemplate>
                    <span class="action-text" style="color:var(--muted); font-size:0.95rem;">System Locked</span>
                  </ItemTemplate>
                </asp:TemplateField>
              </Columns>
            </asp:GridView>
          </div>
        </section>

        <section id="sponsors" class="dashboard-section">
          <div class="section-heading">
            <div>
              <h3>Manage Sponsors</h3>
              <p>Edit sponsor information and add new sponsors.</p>
            </div>
            <a href="addsponsor.aspx" class="btn-primary">+ Add Sponsor</a>
          </div>
          <div class="table-wrap">
            <asp:GridView ID="gvSponsors" runat="server" AutoGenerateColumns="False" GridLines="None" Width="100%">
              <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
                <asp:TemplateField HeaderText="Action">
                  <ItemTemplate>
                    <span class="action-text" style="color:var(--muted); font-size:0.95rem;">System Locked</span>
                  </ItemTemplate>
                </asp:TemplateField>
              </Columns>
            </asp:GridView>
          </div>
        </section>

        <section id="programs" class="dashboard-section">
          <div class="section-heading">
            <div>
              <h3>Manage Programs</h3>
              <p>Track active programs and update descriptions.</p>
            </div>
            <a href="addprogram.aspx" class="btn-primary">+ Add Program (CRUD Lab)</a>
          </div>
          <div class="table-wrap">
            <asp:GridView ID="gvPrograms" runat="server" AutoGenerateColumns="False" GridLines="None" Width="100%">
              <Columns>
                <asp:BoundField DataField="ProgramName" HeaderText="Program" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
                <asp:BoundField DataField="ProgramType" HeaderText="Type" />
                <asp:TemplateField HeaderText="Status">
                  <ItemTemplate>
                    <span class='<%# "badge badge-" + Eval("Status").ToString().ToLower() %>'>
                      <%# Eval("Status") %>
                    </span>
                  </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Action">
                  <ItemTemplate>
                    <span class="action-text" style="color:var(--muted); font-size:0.95rem;">System Locked</span>
                  </ItemTemplate>
                </asp:TemplateField>
              </Columns>
            </asp:GridView>
          </div>
        </section>
      </main>
    </div>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
