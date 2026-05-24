using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace KBC
{
    public partial class add_events : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindEvents();
        }

        private void BindEvents()
        {
            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlDataAdapter da = new SqlDataAdapter("SELECT Id, EventName, EventDate, Location, Status FROM Events ORDER BY EventDate DESC", conn))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvEventsCrud.DataSource = dt;
                gvEventsCrud.DataBind();
            }
        }

        protected void btnAddEvent_Click(object sender, EventArgs e)
        {
            string name = txtEventName.Text.Trim();
            DateTime date;
            DateTime.TryParse(txtEventDate.Text.Trim(), out date);
            string location = txtEventLocation.Text.Trim();
            string status = txtEventStatus.Text.Trim();

            if (string.IsNullOrEmpty(name)) { lblEventMsg.Text = "Event name required."; return; }

            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("INSERT INTO Events (EventName, EventDate, Location, Status) VALUES (@n,@d,@l,@s)", conn))
                {
                    cmd.Parameters.AddWithValue("@n", name);
                    cmd.Parameters.AddWithValue("@d", (object)date == null ? DBNull.Value : (object)date);
                    cmd.Parameters.AddWithValue("@l", location);
                    cmd.Parameters.AddWithValue("@s", status);
                    cmd.ExecuteNonQuery();
                }
            }

            txtEventName.Text = txtEventDate.Text = txtEventLocation.Text = txtEventStatus.Text = string.Empty;
            BindEvents();
        }

        protected void gvEventsCrud_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvEventsCrud.DataKeys[e.RowIndex].Value);
            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("DELETE FROM Events WHERE Id = @id", conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.ExecuteNonQuery();
                }
            }
            BindEvents();
        }
    }
}
