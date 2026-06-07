<%@ Page Language="C#" AutoEventWireup="true" CodeFile="addevents.aspx.cs" Inherits="KBC.add_events" MasterPageFile="~/Site.Master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
  Add Events - KBEC
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <style>
    .crud-section { max-width: 900px; margin: 40px auto; padding: 0 20px; }
    .crud-section h2 { color: #f8fafc; margin-bottom: 10px; }
    .crud-section h3 { color: #f8fafc; margin-top: 30px; margin-bottom: 10px; }
    .crud-form { display: flex; flex-wrap: wrap; gap: 12px; margin-bottom: 20px; align-items: flex-end; }
    .crud-form input[type="text"] {
      padding: 10px 14px;
      border: 1px solid rgba(255, 255, 255, 0.1);
      border-radius: 8px;
      background: rgba(255, 255, 255, 0.05);
      color: #f8fafc;
      font-size: 14px;
      font-family: inherit;
      min-width: 160px;
    }
    .crud-form input[type="text"]::placeholder { color: #64748b; }
    .crud-form input[type="text"]:focus {
      outline: none;
      border-color: #6366f1;
      box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.15);
    }
    .crud-form input[type="submit"] {
      padding: 10px 20px;
      background: linear-gradient(135deg, #6366f1, #4338ca);
      color: white;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      font-weight: 600;
      font-size: 14px;
      transition: transform 0.2s;
    }
    .crud-form input[type="submit"]:hover { transform: translateY(-1px); }
    .crud-table { width: 100%; border-collapse: collapse; }
    .crud-table th, .crud-table td {
      padding: 10px 14px;
      text-align: left;
      border-bottom: 1px solid rgba(255, 255, 255, 0.08);
      color: #cbd5e1;
      font-size: 14px;
    }
    .crud-table th { color: #f8fafc; font-weight: 600; }
    .crud-table a { color: #ef4444; text-decoration: none; font-weight: 600; }
    .crud-table a:hover { color: #f87171; }
    .cmd-buttons a { color: #6366f1; margin-right: 10px; }
    .cmd-buttons a:hover { color: #818cf8; }
    .crud-back { display: inline-block; margin-top: 20px; color: #6366f1; text-decoration: none; font-size: 14px; }
    .crud-back:hover { color: #818cf8; }
  </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="crud-section">
    <h2>Add Event</h2>
    <asp:Label ID="lblEventMsg" runat="server" ForeColor="Red" />
    <div class="crud-form" style="flex-direction: column; align-items: stretch;">
        <asp:TextBox ID="txtEventName" runat="server" placeholder="Event Name" />
        <asp:TextBox ID="txtEventDate" runat="server" placeholder="yyyy-MM-dd" />
        <asp:TextBox ID="txtEventLocation" runat="server" placeholder="Location" />
        <asp:TextBox ID="txtEventStatus" runat="server" placeholder="Status" />
        <asp:TextBox ID="txtEventDescription" runat="server" placeholder="Description (optional)" TextMode="MultiLine" Rows="4" />
        <asp:TextBox ID="txtMaxSeats" runat="server" placeholder="Max Seats (leave empty for unlimited)" />
        <div style="display: flex; gap: 12px; align-items: center;">
          <label style="color: #cbd5e1; font-size: 14px;">Photo:</label>
          <asp:FileUpload ID="fuEventPhoto" runat="server" accept="image/*" />
        </div>
        <asp:HiddenField ID="hfEditingEventId" runat="server" Value="0" />
        <div style="display: flex; gap: 12px;">
          <asp:Button ID="btnAddEvent" runat="server" Text="Add Event" OnClick="btnAddEvent_Click" />
          <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel" OnClick="btnCancelEdit_Click" style="background: #64748b; display: none;" />
        </div>
      </div>

    <h3>Events</h3>
    <asp:GridView ID="gvEventsCrud" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" OnRowDeleting="gvEventsCrud_RowDeleting" OnRowEditing="gvEventsCrud_RowEditing" OnRowCancelingEdit="gvEventsCrud_RowCancelingEdit" CssClass="crud-table" GridLines="None" Width="100%">
      <Columns>
        <asp:TemplateField HeaderText="Photo">
          <ItemTemplate>
            <img src='<%# ResolveUrl(string.IsNullOrEmpty(Eval("PhotoPath").ToString()) ? "~/images/default-event.png" : Eval("PhotoPath").ToString()) %>' alt="Photo" style="width: 40px; height: 40px; border-radius: 4px; object-fit: cover;" />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="EventName" HeaderText="Event" />
        <asp:BoundField DataField="EventDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
        <asp:BoundField DataField="Location" HeaderText="Location" />
        <asp:BoundField DataField="Status" HeaderText="Status" />
        <asp:BoundField DataField="Description" HeaderText="Description" />
        <asp:TemplateField HeaderText="Actions">
          <ItemTemplate>
            <asp:LinkButton ID="lbEdit" runat="server" CommandName="Edit" Text="Edit" />
            <span style="margin: 0 5px;">|</span>
            <asp:LinkButton ID="lbDelete" runat="server" CommandName="Delete" Text="Delete" />
          </ItemTemplate>
        </asp:TemplateField>
      </Columns>
    </asp:GridView>

    <a href="admin-dashboard.aspx" class="crud-back">← Back to Admin Dashboard</a>
  </div>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
