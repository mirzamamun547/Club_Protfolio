using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;

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
            using (SqlCommand cmd = new SqlCommand(@"SELECT e.EventName, e.EventDate, e.Location, e.MaxSeats,
ISNULL(r.RegisteredCount,0) AS RegisteredCount
FROM Events e
LEFT JOIN (SELECT EventId, COUNT(*) AS RegisteredCount FROM EventRegistrations GROUP BY EventId) r ON e.Id = r.EventId
WHERE e.Id = @id", conn))
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
                            bool eventEnded = false;
                            if (DateTime.TryParse(rdr["EventDate"].ToString(), out d))
                            {
                                lblEventDate.Text = d.ToString("MMM d, yyyy");
                                if (d.Date < DateTime.Today)
                                {
                                    eventEnded = true;
                                }
                            }
                            lblLocation.Text = rdr["Location"].ToString();
                            object maxObj = rdr["MaxSeats"];
                            object regCountObj = rdr["RegisteredCount"];
                            int? maxSeats = maxObj == DBNull.Value ? (int?)null : Convert.ToInt32(maxObj);
                            int regCount = regCountObj == DBNull.Value ? 0 : Convert.ToInt32(regCountObj);
                            if (maxSeats.HasValue)
                            {
                                int seatsLeft = Math.Max(0, maxSeats.Value - regCount);
                                lblSeatsInfo.Text = string.Format("Registered: {0} | Seats left: {1}", regCount, seatsLeft);
                                if (seatsLeft <= 0 || eventEnded)
                                {
                                    btnRegister.Enabled = false;
                                    if (eventEnded) btnRegister.Text = "Event Ended";
                                }
                            }
                            else
                            {
                                lblSeatsInfo.Text = string.Format("Registered: {0} | Seats left: Unlimited", regCount);
                                if (eventEnded)
                                {
                                    btnRegister.Enabled = false;
                                    btnRegister.Text = "Event Ended";
                                }
                            }
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
                {
                    conn.Open();
                    using (SqlTransaction tran = conn.BeginTransaction())
                    {
                        try
                        {
                            int eventId = 0;
                            if (!int.TryParse(hfEventId.Value, out eventId))
                            {
                                DisplayMessage("Invalid event selected.", "error");
                                return;
                            }

                            // Check current registrations count and MaxSeats with locking to avoid race conditions
                            int regCount = 0;
                            int? maxSeats = null;
                            DateTime? eventDate = null;
                            using (SqlCommand chkCmd = new SqlCommand(@"SELECT @regCount = COUNT(*) FROM EventRegistrations WITH (UPDLOCK, HOLDLOCK) WHERE EventId = @EventId;
                                SELECT @maxSeats = MaxSeats, @eventDate = EventDate FROM Events WHERE Id = @EventId;", conn, tran))
                            {
                                chkCmd.Parameters.AddWithValue("@EventId", eventId);
                                var pReg = new SqlParameter("@regCount", System.Data.SqlDbType.Int) { Direction = System.Data.ParameterDirection.Output };
                                var pMax = new SqlParameter("@maxSeats", System.Data.SqlDbType.Int) { Direction = System.Data.ParameterDirection.Output, IsNullable = true };
                                var pDate = new SqlParameter("@eventDate", System.Data.SqlDbType.DateTime) { Direction = System.Data.ParameterDirection.Output, IsNullable = true };
                                chkCmd.Parameters.Add(pReg);
                                chkCmd.Parameters.Add(pMax);
                                chkCmd.Parameters.Add(pDate);
                                chkCmd.ExecuteNonQuery();
                                regCount = (int)(chkCmd.Parameters["@regCount"].Value ?? 0);
                                object maxObj = chkCmd.Parameters["@maxSeats"].Value;
                                if (maxObj != DBNull.Value) maxSeats = Convert.ToInt32(maxObj);
                                object dateObj = chkCmd.Parameters["@eventDate"].Value;
                                if (dateObj != DBNull.Value) eventDate = Convert.ToDateTime(dateObj);
                            }

                            if (eventDate.HasValue && eventDate.Value.Date < DateTime.Today)
                            {
                                tran.Rollback();
                                DisplayMessage("Registration closed: event has already ended.", "error");
                                return;
                            }

                            if (maxSeats.HasValue && regCount >= maxSeats.Value)
                            {
                                tran.Rollback();
                                DisplayMessage("Registration closed: event is full.", "error");
                                return;
                            }

                            using (SqlCommand cmd = new SqlCommand(@"INSERT INTO EventRegistrations
                                (EventId, FullName, StudentId, Department, Email, Phone, WhyAttend, Expectations)
                                VALUES (@EventId, @FullName, @StudentId, @Department, @Email, @Phone, @WhyAttend, @Expectations);", conn, tran))
                            {
                                cmd.Parameters.AddWithValue("@EventId", eventId);
                                cmd.Parameters.AddWithValue("@FullName", (object)fullName ?? DBNull.Value);
                                cmd.Parameters.AddWithValue("@StudentId", (object)studentId ?? DBNull.Value);
                                cmd.Parameters.AddWithValue("@Department", (object)dept ?? DBNull.Value);
                                cmd.Parameters.AddWithValue("@Email", (object)email ?? DBNull.Value);
                                cmd.Parameters.AddWithValue("@Phone", (object)phone ?? DBNull.Value);
                                cmd.Parameters.AddWithValue("@WhyAttend", (object)why ?? DBNull.Value);
                                cmd.Parameters.AddWithValue("@Expectations", (object)expect ?? DBNull.Value);

                                cmd.ExecuteNonQuery();
                            }

                            tran.Commit();

                            // Send notification emails (admin + attendee)
                            try
                            {
                                SendRegistrationEmails(fullName, email, lblEventName.Text, hfEventId.Value);
                            }
                            catch (Exception exEmail)
                            {
                                // Log or ignore email errors; do not fail registration
                            }

                            DisplayMessage("Registration submitted successfully. Thank you!", "success");
                            // clear fields
                            txtFullName.Text = txtStudentId.Text = txtDepartment.Text = txtEmail.Text = txtPhone.Text = txtWhyAttend.Text = txtExpectations.Text = string.Empty;
                        }
                        catch (SqlException ex)
                        {
                            tran.Rollback();
                            // 2627 and 2601 are unique constraint violation numbers in SQL Server
                            if (ex.Number == 2627 || ex.Number == 2601)
                            {
                                DisplayMessage("You have already registered for this event.", "error");
                            }
                            else
                            {
                                DisplayMessage("Error: " + ex.Message, "error");
                            }
                        }
                        catch (Exception ex)
                        {
                            tran.Rollback();
                            DisplayMessage("Error: " + ex.Message, "error");
                        }
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

        private void SendRegistrationEmails(string fullName, string attendeeEmail, string eventName, string eventId)
        {
            string adminEmail = ConfigurationManager.AppSettings["AdminEmail"] ?? "admin@kbcofficial.com";

            // Email to attendee
            var attendeeMsg = new MailMessage();
            attendeeMsg.To.Add(attendeeEmail);
            attendeeMsg.Subject = "Registration Confirmation - " + eventName;
            attendeeMsg.Body = string.Format("Dear {0},\n\nThank you for registering for {1}. We have received your registration.\n\nBest regards,\nKBEC Team", fullName, eventName);
            attendeeMsg.IsBodyHtml = false;

            // Email to admin
            var adminMsg = new MailMessage();
            adminMsg.To.Add(adminEmail);
            adminMsg.Subject = "New Registration for " + eventName;
            adminMsg.Body = string.Format("A new registration was submitted:\n\nName: {0}\nEmail: {1}\nEvent: {2}\nEventId: {3}\n\nVisit admin dashboard to view details.", fullName, attendeeEmail, eventName, eventId);
            adminMsg.IsBodyHtml = false;

            using (var smtp = new SmtpClient())
            {
                smtp.Send(attendeeMsg);
                smtp.Send(adminMsg);
            }
        }
    }
}
