<%@ Page Language="C#" AutoEventWireup="true" CodeFile="events.aspx.cs" Inherits="KBC.events_page" MasterPageFile="~/Site.Master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
  Events | KBC Official
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
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
              <span class="event-badge"><%# Eval("Status") %></span>
              <img src='<%# ResolveUrl(string.IsNullOrEmpty(Eval("PhotoPath").ToString()) ? "~/images/default-event.png" : Eval("PhotoPath").ToString()) %>' alt="Event" style="width: 100%; height: 200px; object-fit: cover;" />
            </div>
            <div class="event-content">
              <h3 class="event-title"><%# Eval("EventName") %></h3>
              <div class="event-meta">
                <span><%# Eval("EventDate", "{0:MMM d, yyyy}") %></span>
                <span><%# Eval("Location") %></span>
              </div>
              <p class="event-desc"><%# Eval("Description") %></p>
              <div style="margin:8px 0; color:#cbd5e1; font-size:14px;">
                <strong>Registered:</strong> <%# Eval("RegisteredCount") %>
                <%# (Eval("SeatsLeft") == DBNull.Value) ? "" : " | <strong>Seats Left:</strong> " + Eval("SeatsLeft") %>
              </div>
              <a href='<%# Eval("FacebookUrl") %>' target="_blank" class="btn-secondary event-btn">View Event Details</a>
              <a href='<%# "register.aspx?eid=" + Eval("Id") %>' class='<%# GetRegisterButtonClass(Eval("EventDate"), Eval("SeatsLeft")) %>' style='<%# GetRegisterButtonStyle(Eval("EventDate"), Eval("SeatsLeft")) %>'><%# GetRegisterButtonText(Eval("EventDate"), Eval("SeatsLeft")) %></a>
            </div>
          </article>
        </ItemTemplate>
      </asp:Repeater>
    </div>
  </section>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
  <script src="script.js"></script>
</asp:Content>
