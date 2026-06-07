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
            using (SqlDataAdapter da = new SqlDataAdapter("SELECT Id, EventName, EventDate, Location, Status, Description, PhotoPath, MaxSeats FROM Events ORDER BY EventDate DESC", conn))
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
                using (SqlCommand cmd = new SqlCommand("SELECT Id, EventName, EventDate, Location, Status, Description, PhotoPath, MaxSeats FROM Events WHERE Id = @id", conn))
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
                            txtEventDescription.Text = row["Description"] != DBNull.Value ? row["Description"].ToString() : "";
                            txtMaxSeats.Text = row["MaxSeats"] != DBNull.Value ? row["MaxSeats"].ToString() : string.Empty;
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
            e.Cancel = true;
        }

        protected void gvEventsCrud_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            // Cancel edit mode and refresh the grid
            ClearForm();
            BindEvents();
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            txtEventName.Text = txtEventDate.Text = txtEventLocation.Text = txtEventStatus.Text = txtEventDescription.Text = string.Empty;
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
            string description = txtEventDescription.Text.Trim();
            int eventId = Convert.ToInt32(hfEditingEventId.Value);
            bool isEditing = eventId > 0;

            if (string.IsNullOrEmpty(name)) { lblEventMsg.Text = "Event name required."; lblEventMsg.ForeColor = System.Drawing.Color.Red; return; }

            string photoPath = null;
            if (fuEventPhoto.HasFile)
            {
                try
                {
                    string uploadsFolder = System.IO.Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "uploads", "events");
                    if (!System.IO.Directory.Exists(uploadsFolder))
                        System.IO.Directory.CreateDirectory(uploadsFolder);

                    string fileName = System.IO.Path.GetFileNameWithoutExtension(fuEventPhoto.FileName);
                    string fileExtension = System.IO.Path.GetExtension(fuEventPhoto.FileName);
                    string uniqueFileName = fileName + "_" + DateTime.Now.Ticks + fileExtension;
                    string filePath = System.IO.Path.Combine(uploadsFolder, uniqueFileName);

                    fuEventPhoto.SaveAs(filePath);
                    photoPath = "~/uploads/events/" + uniqueFileName;
                }
                catch (Exception ex)
                {
                    lblEventMsg.Text = "Error uploading photo: " + ex.Message;
                    lblEventMsg.ForeColor = System.Drawing.Color.Red;
                    return;
                }
            }

            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    if (isEditing)
                    {
                        // Update existing event
                        string query = "UPDATE Events SET EventName=@n, EventDate=@d, Location=@l, Status=@s, Description=@desc";
                        if (photoPath != null)
                            query += ", PhotoPath=@p";
                        query += ", MaxSeats=@max";
                        query += " WHERE Id=@id";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@n", name);
                            cmd.Parameters.AddWithValue("@d", date == DateTime.MinValue ? DBNull.Value : (object)date);
                            cmd.Parameters.AddWithValue("@l", location);
                            cmd.Parameters.AddWithValue("@s", status);
                            cmd.Parameters.AddWithValue("@desc", string.IsNullOrEmpty(description) ? DBNull.Value : (object)description);
                            if (photoPath != null)
                                cmd.Parameters.AddWithValue("@p", photoPath);
                            int maxSeatsVal;
                            if (int.TryParse(txtMaxSeats.Text.Trim(), out maxSeatsVal))
                                cmd.Parameters.AddWithValue("@max", (object)maxSeatsVal);
                            else
                                cmd.Parameters.AddWithValue("@max", DBNull.Value);
                            cmd.Parameters.AddWithValue("@id", eventId);
                            cmd.ExecuteNonQuery();
                        }
                        lblEventMsg.Text = "Event updated successfully!";
                    }
                    else
                    {
                        // Insert new event
                        string query = "INSERT INTO Events (EventName, EventDate, Location, Status, Description, MaxSeats";
                        if (photoPath != null)
                            query += ", PhotoPath";
                        query += ") VALUES (@n,@d,@l,@s,@desc,@max";
                        if (photoPath != null)
                            query += ",@p";
                        query += ")";

                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@n", name);
                            cmd.Parameters.AddWithValue("@d", date == DateTime.MinValue ? DBNull.Value : (object)date);
                            cmd.Parameters.AddWithValue("@l", location);
                            cmd.Parameters.AddWithValue("@s", status);
                            cmd.Parameters.AddWithValue("@desc", string.IsNullOrEmpty(description) ? DBNull.Value : (object)description);
                            int maxSeatsVal;
                            if (int.TryParse(txtMaxSeats.Text.Trim(), out maxSeatsVal))
                                cmd.Parameters.AddWithValue("@max", (object)maxSeatsVal);
                            else
                                cmd.Parameters.AddWithValue("@max", DBNull.Value);
                            if (photoPath != null)
                                cmd.Parameters.AddWithValue("@p", photoPath);
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
