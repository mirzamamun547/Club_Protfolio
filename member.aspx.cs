using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace KBC
{
    public partial class member : System.Web.UI.Page
    {


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindMembers();
            }
        }

        private void BindMembers()
        {
            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT Name, Role, Department, Email, Bio, LinkedInUrl, Category FROM Members ORDER BY Category, Name ASC";

                using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    try
                    {
                        da.Fill(dt);
                        rptMembers.DataSource = dt;
                        rptMembers.DataBind();
                    }
                    catch (Exception ex)
                    {
                        // Log or handle error
                        Response.Write("<script>alert('Error loading members: " + ex.Message.Replace("'", "\\'") + "');</script>");
                    }
                }
            }
        }
    }
}
