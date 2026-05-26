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

        protected void gvEventsCrud_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            int eventId = Convert.ToInt32(gvEventsCrud.DataKeys[e.NewEditIndex].Value);
            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT Id, EventName, EventDate, Location, Status FROM Events WHERE Id = @id", conn))
                {
                    cmd.Parameters.AddWithValue("@id", eventId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        if (dt.Rows.Count > 0)
                        {
                            DataRow row = dt.Rows[0];
                            txtEventName.Text = row["EventName"].ToString();
                            txtEventDate.Text = ((DateTime)row["EventDate"]).ToString("yyyy-MM-dd");
                            txtEventLocation.Text = row["Location"].ToString();
                            txtEventStatus.Text = row["Status"].ToString();
                            hfEditingEventId.Value = eventId.ToString();
                            btnAddEvent.Text = "Update Event";
                            btnCancelEdit.Style["display"] = "inline-block";
                        }
                    }
                }
            }
        }

        protected void gvEventsCrud_RowUpdating(object sender, System.Web.UI.WebControls.GridViewUpdateEventArgs e)
        {
            // Update is handled via btnAddEvent_Click using hfEditingEventId.
            // This handler is required to prevent the unhandled RowUpdating exception.
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            txtEventName.Text = txtEventDate.Text = txtEventLocation.Text = txtEventStatus.Text = string.Empty;
            hfEditingEventId.Value = "0";
            btnAddEvent.Text = "Add Event";
            btnCancelEdit.Style["display"] = "none";
            lblEventMsg.Text = "";
        }

        protected void btnAddEvent_Click(object sender, EventArgs e)
        {
            string name = txtEventName.Text.Trim();
            DateTime date = DateTime.MinValue;
            DateTime.TryParse(txtEventDate.Text.Trim(), out date);
            string location = txtEventLocation.Text.Trim();
            string status = txtEventStatus.Text.Trim();
            int eventId = Convert.ToInt32(hfEditingEventId.Value);
            bool isEditing = eventId > 0;

            if (string.IsNullOrEmpty(name)) { lblEventMsg.Text = "Event name required."; lblEventMsg.ForeColor = System.Drawing.Color.Red; return; }

            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    if (isEditing)
                    {
                        // Update existing event
                        using (SqlCommand cmd = new SqlCommand("UPDATE Events SET EventName=@n, EventDate=@d, Location=@l, Status=@s WHERE Id=@id", conn))
                        {
                            cmd.Parameters.AddWithValue("@n", name);
                            cmd.Parameters.AddWithValue("@d", date == DateTime.MinValue ? DBNull.Value : (object)date);
                            cmd.Parameters.AddWithValue("@l", location);
                            cmd.Parameters.AddWithValue("@s", status);
                            cmd.Parameters.AddWithValue("@id", eventId);
                            cmd.ExecuteNonQuery();
                        }
                        lblEventMsg.Text = "Event updated successfully!";
                    }
                    else
                    {
                        // Insert new event
                        using (SqlCommand cmd = new SqlCommand("INSERT INTO Events (EventName, EventDate, Location, Status) VALUES (@n,@d,@l,@s)", conn))
                        {
                            cmd.Parameters.AddWithValue("@n", name);
                            cmd.Parameters.AddWithValue("@d", date == DateTime.MinValue ? DBNull.Value : (object)date);
                            cmd.Parameters.AddWithValue("@l", location);
                            cmd.Parameters.AddWithValue("@s", status);
                            cmd.ExecuteNonQuery();
                        }
                        lblEventMsg.Text = "Event added successfully!";
                    }
                }

                lblEventMsg.ForeColor = System.Drawing.Color.Green;
                ClearForm();
                BindEvents();
            }
            catch (Exception ex)
            {
                lblEventMsg.Text = "Error: " + ex.Message;
                lblEventMsg.ForeColor = System.Drawing.Color.Red;
            }
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
