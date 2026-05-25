using System;
using System.Configuration;
using System.Data.SqlClient;

namespace KBC
{
    public partial class register_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                int eid;
                if (int.TryParse(Request.QueryString["eid"], out eid))
                {
                    LoadEvent(eid);
                }
                else
                {
                    lblMsg.Text = "Invalid event selected.";
                }
            }
        }

        private void LoadEvent(int id)
        {
            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand("SELECT EventName, EventDate, Location FROM Events WHERE Id = @id", conn))
            {
                cmd.Parameters.AddWithValue("@id", id);
                conn.Open();
                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        pnlEvent.Visible = true;
                        lblEventName.Text = rdr["EventName"].ToString();
                        // store event id in hidden field for postback
                        hfEventId.Value = id.ToString();
                        DateTime d;
                        if (DateTime.TryParse(rdr["EventDate"].ToString(), out d))
                            lblEventDate.Text = d.ToString("MMM d, yyyy");
                        lblLocation.Text = rdr["Location"].ToString();
                    }
                    else
                    {
                        lblMsg.Text = "Event not found.";
                    }
                }
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            try
            {
                // Validation
                string validationError = ValidateForm();
                if (!string.IsNullOrEmpty(validationError))
                {
                    DisplayMessage(validationError, "error");
                    return;
                }

                string fullName = txtFullName.Text.Trim();
                string studentId = txtStudentId.Text.Trim();
                string dept = txtDepartment.Text.Trim();
                string email = txtEmail.Text.Trim();
                string phone = txtPhone.Text.Trim();
                string why = txtWhyAttend.Text.Trim();
                string expect = txtExpectations.Text.Trim();
                string eventName = lblEventName.Text.Trim();

                string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand(@"INSERT INTO EventRegistrations
                    (FullName, StudentId, Department, Email, Phone, EventName, WhyAttend, Expectations)
                    VALUES (@FullName, @StudentId, @Department, @Email, @Phone, @EventName, @WhyAttend, @Expectations)", conn))
                {
                    cmd.Parameters.AddWithValue("@FullName", (object)fullName ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@StudentId", (object)studentId ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Department", (object)dept ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Email", (object)email ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Phone", (object)phone ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@EventName", (object)eventName ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@WhyAttend", (object)why ?? DBNull.Value);
                    cmd.Parameters.AddWithValue("@Expectations", (object)expect ?? DBNull.Value);

                    conn.Open();
                    int rows = cmd.ExecuteNonQuery();
                    if (rows > 0)
                    {
                        DisplayMessage("Registration submitted successfully. Thank you!", "success");
                        // clear fields
                        txtFullName.Text = txtStudentId.Text = txtDepartment.Text = txtEmail.Text = txtPhone.Text = txtWhyAttend.Text = txtExpectations.Text = string.Empty;
                    }
                    else
                    {
                        DisplayMessage("Unable to save registration. Please try again.", "error");
                    }
                }
            }
            catch (Exception ex)
            {
                DisplayMessage("Error: " + ex.Message, "error");
            }
        }

        private string ValidateForm()
        {
            if (string.IsNullOrWhiteSpace(txtFullName.Text))
                return "Please enter your full name.";
            if (string.IsNullOrWhiteSpace(txtStudentId.Text))
                return "Please enter your student ID.";
            if (string.IsNullOrWhiteSpace(txtDepartment.Text))
                return "Please enter your department.";
            if (string.IsNullOrWhiteSpace(txtEmail.Text))
                return "Please enter your email address.";
            if (!IsValidEmail(txtEmail.Text.Trim()))
                return "Please enter a valid email address.";
            if (string.IsNullOrWhiteSpace(txtPhone.Text))
                return "Please enter your phone number.";
            if (string.IsNullOrWhiteSpace(txtWhyAttend.Text))
                return "Please tell us why you want to attend.";
            if (string.IsNullOrWhiteSpace(txtExpectations.Text))
                return "Please share your expectations from the event.";
            return null;
        }

        private bool IsValidEmail(string email)
        {
            try
            {
                var addr = new System.Net.Mail.MailAddress(email);
                return addr.Address == email;
            }
            catch
            {
                return false;
            }
        }

        private void DisplayMessage(string message, string type)
        {
            lblMsg.Text = "<div class='message-box " + type + "'>" + System.Web.HttpUtility.HtmlEncode(message) + "</div>";
        }
    }
}
