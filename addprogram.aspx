<%@ Page Language="C#" AutoEventWireup="true" CodeFile="addprogram.aspx.cs" Inherits="KBC.add_program" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <title>Add Program - KBEC</title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Add Program</h2>
        <asp:Label ID="lblProgramMsg" runat="server" ForeColor="Red" />
        <div>
            <asp:TextBox ID="txtProgramName" runat="server" placeholder="Program Name" />
            <asp:TextBox ID="txtProgramDesc" runat="server" placeholder="Description" />
            <asp:TextBox ID="txtProgramType" runat="server" placeholder="Type" />
            <asp:TextBox ID="txtProgramStatus" runat="server" placeholder="Status" />
            <asp:Button ID="btnAddProgram" runat="server" Text="Add Program" OnClick="btnAddProgram_Click" />
        </div>

        <h3>Programs</h3>
        <asp:GridView ID="gvProgramsCrud" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" OnRowDeleting="gvProgramsCrud_RowDeleting">
            <Columns>
                <asp:BoundField DataField="ProgramName" HeaderText="Program" />
                <asp:BoundField DataField="Description" HeaderText="Description" />
                <asp:BoundField DataField="ProgramType" HeaderText="Type" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
                <asp:ButtonField CommandName="Delete" Text="Delete" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
