<%@ Page Language="C#" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="KBC.register_page" %>
<!DOCTYPE html>
<html lang="en">
<head runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Register for Event - KBC</title>
  <link rel="stylesheet" href="index.css">
  <style>
    .registration-form {
      max-width: 700px;
      margin: 0 auto;
      background-color: #f9f9f9;
      padding: 30px;
      border-radius: 8px;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    .event-details {
      background-color: #e8f4f8;
      padding: 20px;
      border-left: 4px solid #0073b1;
      margin-bottom: 30px;
      border-radius: 4px;
    }
    .event-details h3 {
      margin-top: 0;
      color: #333;
    }
    .event-details p {
      margin: 8px 0;
      color: #555;
    }
    .form-group {
      margin-bottom: 20px;
    }
    .form-row {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 20px;
    }
    .form-row.full {
      grid-template-columns: 1fr;
    }
    .form-group label {
      display: block;
      font-weight: 600;
      margin-bottom: 6px;
      color: #333;
      font-size: 14px;
    }
    .form-group label .required {
      color: #e74c3c;
      margin-left: 2px;
    }
    .form-group input[type="text"],
    .form-group input[type="email"],
    .form-group input[type="tel"],
    .form-group textarea {
      width: 100%;
      padding: 10px 12px;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
      font-size: 14px;
      box-sizing: border-box;
      transition: border-color 0.3s;
    }
    .form-group input[type="text"]:focus,
    .form-group input[type="email"]:focus,
    .form-group input[type="tel"]:focus,
    .form-group textarea:focus {
      outline: none;
      border-color: #0073b1;
      box-shadow: 0 0 0 3px rgba(0, 115, 177, 0.1);
    }
    .form-group textarea {
      resize: vertical;
      min-height: 100px;
    }
    .form-actions {
      margin-top: 30px;
      display: flex;
      gap: 12px;
    }
    .btn-submit {
      flex: 1;
      padding: 12px 24px;
      background-color: #0073b1;
      color: white;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    .btn-submit:hover {
      background-color: #005a8a;
    }
    .btn-secondary {
      flex: 1;
      padding: 12px 24px;
      background-color: #f0f0f0;
      color: #333;
      border: 1px solid #ddd;
      border-radius: 4px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      text-decoration: none;
      text-align: center;
      transition: background-color 0.3s;
    }
    .btn-secondary:hover {
      background-color: #e0e0e0;
    }
    .message-box {
      padding: 15px;
      margin-bottom: 20px;
      border-radius: 4px;
      border-left: 4px solid;
    }
    .message-box.success {
      background-color: #d4edda;
      color: #155724;
      border-color: #28a745;
    }
    .message-box.error {
      background-color: #f8d7da;
      color: #721c24;
      border-color: #f5c6cb;
    }
    .back-link {
      display: inline-block;
      margin-top: 20px;
      color: #0073b1;
      text-decoration: none;
      font-size: 14px;
    }
    .back-link:hover {
      text-decoration: underline;
    }
    .form-section-title {
      font-size: 16px;
      font-weight: 600;
      color: #333;
      margin-top: 25px;
      margin-bottom: 15px;
      padding-bottom: 10px;
      border-bottom: 2px solid #f0f0f0;
    }
    @media (max-width: 600px) {
      .form-row {
        grid-template-columns: 1fr;
      }
      .registration-form {
        padding: 20px;
      }
      .form-actions {
        flex-direction: column;
      }
    }
  </style>
</head>
<body>
  <form id="form1" runat="server">
    <div class="container" style="padding:24px">
      <div class="registration-form">
        <h2 style="text-align: center; color: #333; margin-top: 0;">Event Registration</h2>

        <asp:Panel ID="pnlEvent" runat="server" Visible="false">
          <!-- Event Details Section -->
          <div class="event-details">
            <h3><asp:Label ID="lblEventName" runat="server" /></h3>
            <p><strong>📅 Date:</strong> <asp:Label ID="lblEventDate" runat="server" /></p>
            <p><strong>📍 Location:</strong> <asp:Label ID="lblLocation" runat="server" /></p>
          </div>

          <asp:HiddenField ID="hfEventId" runat="server" />

          <!-- Personal Information Section -->
          <div class="form-section-title">Personal Information</div>

          <div class="form-row">
            <div class="form-group">
              <label>Full Name <span class="required">*</span></label>
              <asp:TextBox ID="txtFullName" runat="server" placeholder="Enter your full name" />
            </div>
            <div class="form-group">
              <label>Student ID <span class="required">*</span></label>
              <asp:TextBox ID="txtStudentId" runat="server" placeholder="e.g., STU001" />
            </div>
          </div>

          <div class="form-row">
            <div class="form-group">
              <label>Department <span class="required">*</span></label>
              <asp:TextBox ID="txtDepartment" runat="server" placeholder="Your department" />
            </div>
            <div class="form-group">
              <label>Email <span class="required">*</span></label>
              <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" placeholder="your.email@example.com" />
            </div>
          </div>

          <div class="form-row">
            <div class="form-group">
              <label>Phone Number <span class="required">*</span></label>
              <asp:TextBox ID="txtPhone" runat="server" TextMode="Phone" placeholder="+1 (555) 000-0000" />
            </div>
          </div>

          <!-- Event Feedback Section -->
          <div class="form-section-title">Event Interest</div>

          <div class="form-group form-row full">
            <label>Why do you want to attend this event? <span class="required">*</span></label>
            <asp:TextBox ID="txtWhyAttend" runat="server" TextMode="MultiLine" Rows="4" placeholder="Share your motivation for attending..." />
          </div>

          <div class="form-group form-row full">
            <label>What are your expectations from this event? <span class="required">*</span></label>
            <asp:TextBox ID="txtExpectations" runat="server" TextMode="MultiLine" Rows="4" placeholder="Tell us what you hope to learn or gain..." />
          </div>

          <!-- Message Display -->
          <asp:Label ID="lblMsg" runat="server" />

          <!-- Action Buttons -->
          <div class="form-actions">
            <asp:Button ID="btnRegister" runat="server" Text="Submit Registration" OnClick="btnRegister_Click" CssClass="btn-submit" />
          </div>
        </asp:Panel>
      </div>

      <a href="events.aspx" class="back-link">← Back to Events</a>
    </div>
  </form>
</body>
</html>
