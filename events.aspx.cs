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

        protected string GetRegisterButtonClass(object eventDateObj, object seatsLeftObj)
        {
            DateTime eventDate;
            string dateStr = eventDateObj != null ? eventDateObj.ToString() : null;
            if (DateTime.TryParse(dateStr, out eventDate) && eventDate.Date < DateTime.Today)
            {
                return "btn-secondary event-btn disabled";
            }
            if (seatsLeftObj != DBNull.Value && seatsLeftObj != null && Convert.ToInt32(seatsLeftObj) <= 0)
            {
                return "btn-secondary event-btn disabled";
            }
            return "btn-primary event-btn";
        }

        protected string GetRegisterButtonStyle(object eventDateObj, object seatsLeftObj)
        {
            DateTime eventDate;
            string dateStr = eventDateObj != null ? eventDateObj.ToString() : null;
            if (DateTime.TryParse(dateStr, out eventDate) && eventDate.Date < DateTime.Today)
            {
                return "pointer-events: none; opacity: 0.6;";
            }
            if (seatsLeftObj != DBNull.Value && seatsLeftObj != null && Convert.ToInt32(seatsLeftObj) <= 0)
            {
                return "pointer-events: none; opacity: 0.6;";
            }
            return "";
        }

        protected string GetRegisterButtonText(object eventDateObj, object seatsLeftObj)
        {
            DateTime eventDate;
            string dateStr = eventDateObj != null ? eventDateObj.ToString() : null;
            if (DateTime.TryParse(dateStr, out eventDate) && eventDate.Date < DateTime.Today)
            {
                return "Registration Closed";
            }
            if (seatsLeftObj != DBNull.Value && seatsLeftObj != null && Convert.ToInt32(seatsLeftObj) <= 0)
            {
                return "Event Full";
            }
            return "Register";
        }
    }
}
