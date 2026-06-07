<%@ Page Language="C#" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="KBC.register_page" MasterPageFile="~/Site.Master" %>

<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="server">
  Event Registration - KBEC
</asp:Content>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <style>
    .registration-form {
      max-width: 700px;
      margin: 40px auto;
      background-color: rgba(255, 255, 255, 0.03);
      padding: 30px;
      border-radius: 8px;
      border: 1px solid rgba(255, 255, 255, 0.08);
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    .event-details {
      background: linear-gradient(135deg, rgba(99, 102, 241, 0.1) 0%, rgba(245, 158, 11, 0.1) 100%);
      padding: 20px;
      border-left: 4px solid #6366f1;
      margin-bottom: 30px;
      border-radius: 4px;
      border: 1px solid rgba(99, 102, 241, 0.2);
    }
    .event-details h3 {
      margin-top: 0;
      color: #f8fafc;
      font-size: 24px;
      margin-bottom: 15px;
    }
    .event-details p {
      margin: 8px 0;
      color: #cbd5e1;
      font-size: 15px;
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
      color: #f8fafc;
      font-size: 14px;
    }
    .form-group label .required {
      color: #ef4444;
      margin-left: 2px;
    }
    .form-group input[type="text"],
    .form-group input[type="email"],
    .form-group input[type="tel"],
    .form-group textarea {
      width: 100%;
      padding: 10px 12px;
      border: 1px solid rgba(255, 255, 255, 0.1);
      border-radius: 4px;
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
      font-size: 14px;
      box-sizing: border-box;
      background: rgba(255, 255, 255, 0.05);
      color: #f8fafc;
      transition: all 0.3s;
    }
    .form-group input[type="text"]::placeholder,
    .form-group input[type="email"]::placeholder,
    .form-group input[type="tel"]::placeholder,
    .form-group textarea::placeholder {
      color: #64748b;
    }
    .form-group input[type="text"]:focus,
    .form-group input[type="email"]:focus,
    .form-group input[type="tel"]:focus,
    .form-group textarea:focus {
      outline: none;
      border-color: #6366f1;
      background: rgba(99, 102, 241, 0.1);
      box-shadow: 0 0 0 3px rgba(99, 102, 241, 0.1);
    }
    .form-group textarea {
      resize: vertical;
      min-height: 100px;
      font-family: inherit;
    }
    .form-actions {
      margin-top: 30px;
      display: flex;
      gap: 12px;
    }
    .btn-submit {
      flex: 1;
      padding: 12px 24px;
      background: linear-gradient(135deg, #6366f1 0%, #4338ca 100%);
      color: white;
      border: none;
      border-radius: 4px;
      font-size: 16px;
      font-weight: 600;
      cursor: pointer;
      transition: all 0.3s;
    }
    .btn-submit:hover {
      transform: translateY(-2px);
      box-shadow: 0 10px 20px rgba(99, 102, 241, 0.3);
    }
    .message-box {
      padding: 15px;
      margin-bottom: 20px;
      border-radius: 4px;
      border-left: 4px solid;
      border: 1px solid;
    }
    .message-box.success {
      background-color: rgba(34, 197, 94, 0.1);
      color: #86efac;
      border-color: #22c55e;
    }
    .message-box.error {
      background-color: rgba(239, 68, 68, 0.1);
      color: #fca5a5;
      border-color: #ef4444;
    }
    .back-link {
      display: inline-block;
      margin-top: 20px;
      color: #6366f1;
      text-decoration: none;
      font-size: 14px;
      transition: color 0.3s;
    }
    .back-link:hover {
      color: #818cf8;
    }
    .form-section-title {
      font-size: 16px;
      font-weight: 600;
      color: #f8fafc;
      margin-top: 25px;
      margin-bottom: 15px;
      padding-bottom: 10px;
      border-bottom: 2px solid rgba(255, 255, 255, 0.1);
    }
    @media (max-width: 600px) {
      .form-row {
        grid-template-columns: 1fr;
      }
      .registration-form {
        padding: 20px;
        margin: 20px auto;
      }
      .form-actions {
        flex-direction: column;
      }
    }
  </style>
</asp:Content>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">
  <div class="container" style="padding:24px">
    <div class="registration-form">
      <h2 style="text-align: center; color: #f8fafc; margin-top: 0;">Event Registration</h2>

      <asp:Panel ID="pnlEvent" runat="server" Visible="false">
        <!-- Event Details Section -->
        <div class="event-details">
          <h3><asp:Label ID="lblEventName" runat="server" /></h3>
          <p><strong> Date:</strong> <asp:Label ID="lblEventDate" runat="server" /></p>
          <p><strong> Location:</strong> <asp:Label ID="lblLocation" runat="server" /></p>
          <p><asp:Label ID="lblSeatsInfo" runat="server" CssClass="seats-info" /></p>
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
</asp:Content>

