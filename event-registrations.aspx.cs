using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace KBC
{
    public partial class event_registrations : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminEmail"] == null)
            {
                Response.Redirect("admin-login.aspx");
            }

            if (!IsPostBack)
            {
                LoadRegistrations();
            }
        }

        private void LoadRegistrations()
        {
            if (Request.QueryString["eid"] != null)
            {
                int eventId;
                if (int.TryParse(Request.QueryString["eid"], out eventId))
                {
                    string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
                    using (SqlConnection conn = new SqlConnection(connStr))
                    {
                        // Get Event Name
                        using (SqlCommand cmd = new SqlCommand("SELECT EventName FROM Events WHERE Id = @Id", conn))
                        {
                            cmd.Parameters.AddWithValue("@Id", eventId);
                            conn.Open();
                            object result = cmd.ExecuteScalar();
                            if (result != null)
                            {
                                lblEventName.InnerText = "Registrations for: " + result.ToString();
                            }
                            else
                            {
                                lblEventName.InnerText = "Event Not Found";
                                return; // Event doesn't exist
                            }
                        }

                        // Get Registrations
                        using (SqlCommand cmd = new SqlCommand(@"SELECT FullName, StudentId, Department, Email, Phone, RegistrationDate 
                                                                 FROM EventRegistrations 
                                                                 WHERE EventId = @EventId 
                                                                 ORDER BY RegistrationDate DESC", conn))
                        {
                            cmd.Parameters.AddWithValue("@EventId", eventId);
                            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                            {
                                DataTable dt = new DataTable();
                                da.Fill(dt);
                                lblTotalCount.Text = dt.Rows.Count.ToString();
                                gvRegistrations.DataSource = dt;
                                gvRegistrations.DataBind();
                                
                                if (gvRegistrations.HeaderRow != null)
                                    gvRegistrations.HeaderRow.TableSection = System.Web.UI.WebControls.TableRowSection.TableHeader;
                            }
                        }
                    }
                }
            }
            else
            {
                lblEventName.InnerText = "No event selected";
            }
        }
    }
}
