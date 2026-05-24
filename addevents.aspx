<%@ Page Language="C#" AutoEventWireup="true" CodeFile="addevents.aspx.cs" Inherits="KBC.add_events" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <title>Add Events - KBEC</title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Add Event</h2>
        <asp:Label ID="lblEventMsg" runat="server" ForeColor="Red" />
        <div>
            <asp:TextBox ID="txtEventName" runat="server" placeholder="Event Name" />
            <asp:TextBox ID="txtEventDate" runat="server" placeholder="yyyy-MM-dd" />
            <asp:TextBox ID="txtEventLocation" runat="server" placeholder="Location" />
            <asp:TextBox ID="txtEventStatus" runat="server" placeholder="Status" />
            <asp:Button ID="btnAddEvent" runat="server" Text="Add Event" OnClick="btnAddEvent_Click" />
        </div>

        <h3>Events</h3>
        <asp:GridView ID="gvEventsCrud" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" OnRowDeleting="gvEventsCrud_RowDeleting">
            <Columns>
                <asp:BoundField DataField="EventName" HeaderText="Event" />
                <asp:BoundField DataField="EventDate" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                <asp:BoundField DataField="Location" HeaderText="Location" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
                <asp:ButtonField CommandName="Delete" Text="Delete" />
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>
