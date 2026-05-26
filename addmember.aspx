<%@ Page Language="C#" AutoEventWireup="true" CodeFile="addmember.aspx.cs" Inherits="KBC.add_member" MasterPageFile="~/Site.Master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
  Add Members - KBEC
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <style>
    .crud-section { max-width: 900px; margin: 40px auto; padding: 0 20px; }
    .crud-section h2 { color: #f8fafc; margin-bottom: 10px; }
    .crud-section h3 { color: #f8fafc; margin-top: 30px; margin-bottom: 10px; }
    .crud-form { display: flex; flex-wrap: wrap; gap: 12px; margin-bottom: 20px; align-items: flex-end; }
    .crud-form input[type="text"],
    .crud-form input[type="email"] {
      padding: 10px 14px;
      border: 1px solid rgba(255, 255, 255, 0.1);
      border-radius: 8px;
      background: rgba(255, 255, 255, 0.05);
      color: #f8fafc;
      font-size: 14px;
      font-family: inherit;
      min-width: 160px;
    }
    .crud-form input::placeholder { color: #64748b; }
    .crud-form input:focus {
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
    <h2>Add Member</h2>
    <asp:Label ID="lblMemberMsg" runat="server" ForeColor="Red" />
    <div class="crud-form" style="flex-direction: column; align-items: stretch;">
      <asp:TextBox ID="txtMemberName" runat="server" placeholder="Name" />
      <asp:TextBox ID="txtMemberRole" runat="server" placeholder="Role" />
      <asp:TextBox ID="txtMemberDept" runat="server" placeholder="Department" />
      <asp:TextBox ID="txtMemberEmail" runat="server" placeholder="Email" />
      <asp:TextBox ID="txtMemberLinkedIn" runat="server" placeholder="LinkedIn URL (optional)" />
      <asp:TextBox ID="txtMemberBio" runat="server" placeholder="Short bio (optional)" TextMode="MultiLine" Rows="3" />
      <div style="display: flex; gap: 12px; align-items: center;">
        <label style="color: #cbd5e1; font-size: 14px;">Photo:</label>
        <asp:FileUpload ID="fuMemberPhoto" runat="server" accept="image/*" />
      </div>
      <asp:DropDownList ID="ddlMemberCategory" runat="server" CssClass="crud-form-dropdown" style="padding: 10px 14px; border: 1px solid rgba(255, 255, 255, 0.1); border-radius: 8px; background: rgba(255, 255, 255, 0.05); color: #f8fafc; font-size: 14px; min-width: 160px;">
        <asp:ListItem Text="Leadership" Value="leadership" />
        <asp:ListItem Text="Coordinators" Value="coordinators" />
        <asp:ListItem Text="Volunteers" Value="volunteers" />
      </asp:DropDownList>
      <asp:HiddenField ID="hfEditingMemberId" runat="server" Value="0" />
      <div style="display: flex; gap: 12px;">
        <asp:Button ID="btnAddMember" runat="server" Text="Add Member" OnClick="btnAddMember_Click" />
        <asp:Button ID="btnCancelEdit" runat="server" Text="Cancel" OnClick="btnCancelEdit_Click" style="background: #64748b; display: none;" />
      </div>
    </div>

    <h3>Members</h3>
    <asp:GridView ID="gvMembers" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" OnRowDeleting="gvMembers_RowDeleting" OnRowEditing="gvMembers_RowEditing" CssClass="crud-table" GridLines="None" Width="100%">
      <Columns>
        <asp:TemplateField HeaderText="Photo">
          <ItemTemplate>
            <img src='<%# Eval("PhotoPath") %>' alt="Photo" style="width: 40px; height: 40px; border-radius: 4px; object-fit: cover;" />
          </ItemTemplate>
        </asp:TemplateField>
        <asp:BoundField DataField="Name" HeaderText="Name" />
        <asp:BoundField DataField="Role" HeaderText="Role" />
        <asp:BoundField DataField="Department" HeaderText="Department" />
        <asp:BoundField DataField="Email" HeaderText="Email" />
        <asp:BoundField DataField="LinkedInUrl" HeaderText="LinkedIn" />
        <asp:BoundField DataField="Bio" HeaderText="Bio" />
        <asp:CommandField ShowEditButton="True" EditText="Edit" CancelText="Cancel" UpdateText="Update" ItemStyle-CssClass="cmd-buttons" />
        <asp:ButtonField CommandName="Delete" Text="Delete" />
      </Columns>
    </asp:GridView>

    <a href="admin-dashboard.aspx" class="crud-back">← Back to Admin Dashboard</a>
  </div>
</asp:Content>

<asp:Content ID="ScriptContent" ContentPlaceHolderID="ScriptContent" runat="server">
</asp:Content>
