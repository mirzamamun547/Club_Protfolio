using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

namespace KBC
{
    public partial class admin_login : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Query string example: check if navigated here from successful signup
                if (Request.QueryString["signup"] == "success")
                {
                    lblMessage.ForeColor = System.Drawing.Color.MediumSpringGreen;
                    lblMessage.Text = "Registration successful! Please login.";
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Please enter both email and password.";
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();
                    string query = "SELECT Name FROM Admins WHERE Email = @Email AND PasswordHash = @Password";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        cmd.Parameters.AddWithValue("@Password", password); // Plain text for simplicity in lab

                        object result = cmd.ExecuteScalar();

                        if (result != null)
                        {
                            string adminName = result.ToString();

                            // 1. Session Management: Store login status
                            Session["AdminEmail"] = email;
                            Session["AdminName"] = adminName;

                            // 2. Cookie Management: Create a cookie indicating last login time
                            HttpCookie loginCookie = new HttpCookie("LastAdminLogin");
                            loginCookie.Value = DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
                            loginCookie.Expires = DateTime.Now.AddDays(7); // Persist for 7 days
                            Response.Cookies.Add(loginCookie);

                            // Redirect to dashboard
                            Response.Redirect("admin-dashboard.aspx");
                        }
                        else
                        {
                            lblMessage.ForeColor = System.Drawing.Color.Red;
                            lblMessage.Text = "Invalid email or password.";
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                    lblMessage.Text = "Database error: " + ex.Message;
                }
            }
        }
    }
}
