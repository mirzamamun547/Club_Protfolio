<%@ Page Language="C#" AutoEventWireup="true" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>CRUD Dashboard - KBEC</title>
  <style>
    body { font-family: Arial, sans-serif; padding: 24px; background:#f7f7f7 }
    .shell { max-width:900px; margin:0 auto; background:#fff; padding:20px; border-radius:6px; box-shadow:0 2px 6px rgba(0,0,0,.05) }
    .links { display:flex; gap:12px; margin-top:16px }
    .card { flex:1; padding:16px; border:1px solid #e6e6e6; border-radius:6px; text-align:center }
    .card a { display:inline-block; margin-top:8px; padding:8px 12px; background:#0078d4; color:#fff; text-decoration:none; border-radius:4px }
    .back { margin-top:18px }
  </style>
</head>
<body>
  <div class="shell">
    <h1>CRUD Dashboard</h1>
    <p>Quick links to manage the KBEC site data. Use these pages to add or remove records for members, events, and programs.</p>

    <div class="links">
      <div class="card">
        <h3>Members</h3>
        <p>Add or remove club members.</p>
        <a href="addmember.aspx">Open Members</a>
      </div>
      <div class="card">
        <h3>Events</h3>
        <p>Add or remove events.</p>
        <a href="addevents.aspx">Open Events</a>
      </div>
      <div class="card">
        <h3>Programs</h3>
        <p>Add or remove programs.</p>
        <a href="addprogram.aspx">Open Programs</a>
      </div>
    </div>

    <div class="back">
      <a href="admin-dashboard.aspx">← Back to Admin Dashboard</a>
    </div>
  </div>
</body>
</html>
