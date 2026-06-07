using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace KBC
{
    public partial class events_page : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindEvents();
        }

        private void BindEvents()
        {
            try
            {
                string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                using (SqlDataAdapter da = new SqlDataAdapter(@"SELECT e.Id, e.EventName, e.EventDate, e.Location, e.Status, e.FacebookUrl, e.ImageGradient, e.PhotoPath, e.Description, e.MaxSeats,
ISNULL(r.RegisteredCount,0) AS RegisteredCount,
CASE WHEN e.MaxSeats IS NULL THEN NULL ELSE (e.MaxSeats - ISNULL(r.RegisteredCount,0)) END AS SeatsLeft
FROM Events e
LEFT JOIN (SELECT EventId, COUNT(*) AS RegisteredCount FROM EventRegistrations GROUP BY EventId) r ON e.Id = r.EventId
ORDER BY e.EventDate DESC", conn))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    rptEvents.DataSource = dt;
                    rptEvents.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Handle exception
            }
        }
    }
}
