<%@ Page Language="C#" AutoEventWireup="true" CodeFile="event-registrations.aspx.cs" Inherits="KBC.event_registrations" MasterPageFile="~/Site.Master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
  Event Registrations - KBEC
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <style>
    .registrations-section { max-width: 1100px; margin: 40px auto; padding: 0 20px; }
    .registrations-section h2 { color: #f8fafc; margin-bottom: 5px; }
    .registrations-section p.subtitle { color: #94a3b8; margin-bottom: 30px; font-size: 15px; }
    .data-table { width: 100%; border-collapse: collapse; margin-top: 20px; }
    .data-table th, .data-table td {
      padding: 12px 16px;
      text-align: left;
      border-bottom: 1px solid rgba(255, 255, 255, 0.08);
      color: #cbd5e1;
      font-size: 14px;
    }
    .data-table th { color: #f8fafc; font-weight: 600; background: rgba(255, 255, 255, 0.03); }
    .data-table tr:hover { background: rgba(255, 255, 255, 0.02); }
    .crud-back { display: inline-block; margin-top: 30px; color: #6366f1; text-decoration: none; font-size: 14px; font-weight: 500; }
    .crud-back:hover { color: #818cf8; text-decoration: underline; }
    .empty-state { text-align: center; padding: 40px; color: #94a3b8; font-style: italic; }
  </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="registrations-section">
    <h2 id="lblEventName" runat="server">Event Registrations</h2>
    <p class="subtitle">Total Registered: <asp:Label ID="lblTotalCount" runat="server" Text="0" style="font-weight: bold; color: #f8fafc;"></asp:Label></p>

    <div style="overflow-x: auto; background: rgba(255,255,255,0.02); border-radius: 12px; border: 1px solid rgba(255,255,255,0.08);">
        <asp:GridView ID="gvRegistrations" runat="server" AutoGenerateColumns="False" CssClass="data-table" GridLines="None">
          <Columns>
            <asp:BoundField DataField="FullName" HeaderText="Name" />
            <asp:BoundField DataField="StudentId" HeaderText="Student ID" />
            <asp:BoundField DataField="Department" HeaderText="Department" />
            <asp:BoundField DataField="Email" HeaderText="Email" />
            <asp:BoundField DataField="Phone" HeaderText="Phone" />
            <asp:BoundField DataField="RegistrationDate" HeaderText="Reg. Date" DataFormatString="{0:dd MMM yyyy, hh:mm tt}" />
          </Columns>
          <EmptyDataTemplate>
              <div class="empty-state">No registrations found for this event yet.</div>
          </EmptyDataTemplate>
        </asp:GridView>
    </div>

    <a href="admin-dashboard.aspx" class="crud-back">← Back to Dashboard</a>
  </div>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
