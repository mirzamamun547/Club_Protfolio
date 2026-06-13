using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace KBC
{
    public partial class sponsors : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindSponsors();
            }
        }

        private void BindSponsors()
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlCommand cmd = new SqlCommand("SELECT Id, Name, Description, PhotoPath FROM Sponsors ORDER BY CreatedAt DESC", conn))
                using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptSponsors.DataSource = dt;
                    rptSponsors.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Optionally handle exception
            }
        }
    }
}
