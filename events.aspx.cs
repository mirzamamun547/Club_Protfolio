using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace KBC
{
    public partial class events_page : System.Web.UI.Page
    {



        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindEvents();
            }
        }

        private void BindEvents()
        {
            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string query = "SELECT EventName, EventDate, Location, Status, FacebookUrl, ImageGradient FROM Events ORDER BY EventDate DESC";

                using (SqlDataAdapter da = new SqlDataAdapter(query, conn))
                {
                    DataTable dt = new DataTable();
                    try
                    {
                        da.Fill(dt);
                        rptEvents.DataSource = dt;
                        rptEvents.DataBind();
                    }
                    catch (Exception ex)
                    {
                        Response.Write("<script>alert('Error loading events: " + ex.Message.Replace("'", "\\'") + "');</script>");
                    }
                }
            }
        }
    }
}
