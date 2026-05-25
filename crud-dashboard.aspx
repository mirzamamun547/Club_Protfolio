<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
  CRUD Dashboard - KBEC
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <style>
    .crud-dashboard-shell { max-width: 900px; margin: 40px auto; padding: 0 20px; }
    .crud-dashboard-shell h1 { color: #f8fafc; margin-bottom: 8px; }
    .crud-dashboard-shell > p { color: #94a3b8; font-size: 15px; margin-bottom: 24px; }
    .crud-links { display: flex; gap: 16px; flex-wrap: wrap; }
    .crud-card {
      flex: 1;
      min-width: 220px;
      padding: 24px;
      background: rgba(255, 255, 255, 0.04);
      border: 1px solid rgba(255, 255, 255, 0.08);
      border-radius: 16px;
      text-align: center;
      backdrop-filter: blur(8px);
    }
    .crud-card h3 { color: #f8fafc; margin: 0 0 8px; }
    .crud-card p { color: #94a3b8; font-size: 14px; margin: 0 0 16px; }
    .crud-card a {
      display: inline-block;
      padding: 10px 20px;
      background: linear-gradient(135deg, #6366f1, #4338ca);
      color: #fff;
      text-decoration: none;
      border-radius: 8px;
      font-weight: 600;
      font-size: 14px;
      transition: transform 0.2s;
    }
    .crud-card a:hover { transform: translateY(-1px); }
    .crud-back { display: inline-block; margin-top: 24px; color: #6366f1; text-decoration: none; font-size: 14px; }
    .crud-back:hover { color: #818cf8; }
  </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="crud-dashboard-shell">
    <h1>CRUD Dashboard</h1>
    <p>Quick links to manage the KBEC site data. Use these pages to add or remove records for members, events, and programs.</p>

    <div class="crud-links">
      <div class="crud-card">
        <h3>Members</h3>
        <p>Add or remove club members.</p>
        <a href="addmember.aspx">Open Members</a>
      </div>
      <div class="crud-card">
        <h3>Events</h3>
        <p>Add or remove events.</p>
        <a href="addevents.aspx">Open Events</a>
      </div>
      <div class="crud-card">
        <h3>Programs</h3>
        <p>Add or remove programs.</p>
        <a href="addprogram.aspx">Open Programs</a>
      </div>
    </div>

    <a href="admin-dashboard.aspx" class="crud-back">← Back to Admin Dashboard</a>
  </div>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
