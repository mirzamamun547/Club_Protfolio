using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace KBC
{
    public partial class admin_dashboard : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Browser Cache Security: Prevent browser caching back-button access
            Response.Cache.SetCacheability(HttpCacheability.NoCache);
            Response.Cache.SetNoStore();
            Response.Cache.SetExpires(DateTime.UtcNow.AddHours(-1));
            Response.Cache.SetNoServerCaching();

            // 2. Authentication & Session Check: Protect unauthorized dashboard access
            if (Session["AdminEmail"] == null)
            {
                Response.Redirect("admin-login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                // Load details
                lblWelcome.InnerText = "Welcome, " + Session["AdminName"].ToString();
                lblAdminEmail.Text = Session["AdminEmail"].ToString();

                // Bind Data & Metrics
                LoadDashboardData();
            }
        }

        private void LoadDashboardData()
        {
            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                try
                {
                    conn.Open();

                    // Load counts
                    SqlCommand cmdCount = new SqlCommand("SELECT COUNT(*) FROM Events", conn);
                    lblEventCount.Text = cmdCount.ExecuteScalar().ToString();

                    cmdCount.CommandText = "SELECT COUNT(*) FROM Members";
                    lblMemberCount.Text = cmdCount.ExecuteScalar().ToString();

                    cmdCount.CommandText = "SELECT COUNT(*) FROM Programs";
                    lblProgramCount.Text = cmdCount.ExecuteScalar().ToString();

                    cmdCount.CommandText = "SELECT COUNT(*) FROM Advisors";
                    lblAdvisorCount.Text = cmdCount.ExecuteScalar().ToString();

                    cmdCount.CommandText = "SELECT COUNT(*) FROM Sponsors";
                    lblSponsorCount.Text = cmdCount.ExecuteScalar().ToString();

                    // Load events grid
                    using (SqlDataAdapter da = new SqlDataAdapter("SELECT EventName, EventDate, Location, Status FROM Events ORDER BY EventDate DESC", conn))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvEvents.DataSource = dt;
                        gvEvents.DataBind();
                        if (gvEvents.HeaderRow != null)
                            gvEvents.HeaderRow.TableSection = TableRowSection.TableHeader;
                    }

                    // Load members grid
                    using (SqlDataAdapter da = new SqlDataAdapter("SELECT Name, Role, Department, Email FROM Members ORDER BY Name ASC", conn))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvMembers.DataSource = dt;
                        gvMembers.DataBind();
                        if (gvMembers.HeaderRow != null)
                            gvMembers.HeaderRow.TableSection = TableRowSection.TableHeader;
                    }

                    // Load programs grid
                    using (SqlDataAdapter da = new SqlDataAdapter("SELECT ProgramName, Description, ProgramType, Status FROM Programs ORDER BY ProgramName ASC", conn))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvPrograms.DataSource = dt;
                        gvPrograms.DataBind();
                        if (gvPrograms.HeaderRow != null)
                            gvPrograms.HeaderRow.TableSection = TableRowSection.TableHeader;
                    }

                    // Load advisors grid
                    using (SqlDataAdapter da = new SqlDataAdapter("SELECT Name, Role, Expertise, Department, Email FROM Advisors ORDER BY Name ASC", conn))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvAdvisors.DataSource = dt;
                        gvAdvisors.DataBind();
                        if (gvAdvisors.HeaderRow != null)
                            gvAdvisors.HeaderRow.TableSection = TableRowSection.TableHeader;
                    }

                    // Load sponsors grid
                    using (SqlDataAdapter da = new SqlDataAdapter("SELECT Name, Description FROM Sponsors ORDER BY Name ASC", conn))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        gvSponsors.DataSource = dt;
                        gvSponsors.DataBind();
                        if (gvSponsors.HeaderRow != null)
                            gvSponsors.HeaderRow.TableSection = TableRowSection.TableHeader;
                    }
                }
                catch (Exception ex)
                {
                    // Show error in welcome text or handle gracefully in logs
                    lblWelcome.InnerText = "Error loading data: " + ex.Message;
                }
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            // 1. Session destroy
            Session.Clear();
            Session.RemoveAll();
            Session.Abandon();

            // 2. Cookie removal: Expire ASP.NET session cookie
            if (Request.Cookies["ASP.NET_SessionId"] != null)
            {
                Response.Cookies["ASP.NET_SessionId"].Value = string.Empty;
                Response.Cookies["ASP.NET_SessionId"].Expires = DateTime.Now.AddMonths(-20);
            }

            // Expire our tracking login cookie
            if (Request.Cookies["LastAdminLogin"] != null)
            {
                Response.Cookies["LastAdminLogin"].Value = string.Empty;
                Response.Cookies["LastAdminLogin"].Expires = DateTime.Now.AddMonths(-20);
            }

            // Redirect back to login
            Response.Redirect("admin-login.aspx");
        }
    }
}
