using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace KBC
{
    public partial class advisor : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindAdvisors();
        }

        private void BindAdvisors()
        {
            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlDataAdapter da = new SqlDataAdapter("SELECT Id, Name, Role, Expertise, Department, Email, PhotoPath, Bio FROM Advisors ORDER BY Name", conn))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    rptAdvisors.DataSource = dt;
                    rptAdvisors.DataBind();
                }
            }
        }

        public string GetAdvisorCategory(string role)
        {
            if (string.IsNullOrEmpty(role))
                return "faculty";

            string roleLower = role.ToLower();

            // Check for Industry/Mentor first
            if (roleLower.Contains("industry") || roleLower.Contains("mentor"))
                return "industry";

            // Check for Faculty/Professor/Dr
            if (roleLower.Contains("faculty") || roleLower.Contains("professor") || roleLower.Contains("dr"))
                return "faculty";

            // Default to faculty
            return "faculty";
        }
    }
}
