<%@ Page Language="C#" AutoEventWireup="true" CodeFile="addmember.aspx.cs" Inherits="KBC.add_member" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <title>Add Members - KBEC</title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Add Member</h2>
        <asp:Label ID="lblMemberMsg" runat="server" ForeColor="Red" />
        <div>
            <asp:TextBox ID="txtMemberName" runat="server" placeholder="Name" />
            <asp:TextBox ID="txtMemberRole" runat="server" placeholder="Role" />
            <asp:TextBox ID="txtMemberDept" runat="server" placeholder="Department" />
            <asp:TextBox ID="txtMemberEmail" runat="server" placeholder="Email" />
            <asp:Button ID="btnAddMember" runat="server" Text="Add Member" OnClick="btnAddMember_Click" />
        </div>

        <h3>Members</h3>
        <asp:GridView ID="gvMembers" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" OnRowDeleting="gvMembers_RowDeleting">
            <Columns>
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="Role" HeaderText="Role" />
                <asp:BoundField DataField="Department" HeaderText="Department" />
                <asp:BoundField DataField="Email" HeaderText="Email" />
                <asp:ButtonField CommandName="Delete" Text="Delete" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
