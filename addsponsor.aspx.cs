using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI.WebControls;

namespace KBC
{
    public partial class add_sponsor : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminEmail"] == null)
            {
                Response.Redirect("admin-login.aspx");
            }

            if (!IsPostBack)
            {
                BindSponsors();
            }
        }

        private void BindSponsors()
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand("SELECT Id, Name, Description, PhotoPath FROM Sponsors ORDER BY CreatedAt DESC", conn))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvSponsors.DataSource = dt;
                gvSponsors.DataBind();
            }
        }

        protected void btnAddSponsor_Click(object sender, EventArgs e)
        {
            string name = txtSponsorName.Text.Trim();
            string desc = txtSponsorDescription.Text.Trim();
            string photoPath = "images/default-sponsor.png"; // Fallback

            if (string.IsNullOrEmpty(name))
            {
                lblSponsorMsg.Text = "Name is required.";
                return;
            }

            // Handle file upload
            if (fuSponsorPhoto.HasFile)
            {
                try
                {
                    string ext = Path.GetExtension(fuSponsorPhoto.FileName).ToLower();
                    if (ext == ".jpg" || ext == ".jpeg" || ext == ".png" || ext == ".gif")
                    {
                        string fileName = Guid.NewGuid().ToString() + ext;
                        string uploadDir = Server.MapPath("~/sponsors-photos/");
                        if (!Directory.Exists(uploadDir)) Directory.CreateDirectory(uploadDir);

                        string savePath = Path.Combine(uploadDir, fileName);
                        fuSponsorPhoto.SaveAs(savePath);
                        photoPath = "sponsors-photos/" + fileName;
                    }
                    else
                    {
                        lblSponsorMsg.Text = "Only image files (.jpg, .png, .gif) are allowed.";
                        return;
                    }
                }
                catch (Exception ex)
                {
                    lblSponsorMsg.Text = "Upload failed: " + ex.Message;
                    return;
                }
            }

            int editingId = 0;
            int.TryParse(hfEditingSponsorId.Value, out editingId);

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql;
                if (editingId > 0)
                {
                    // Update
                    if (fuSponsorPhoto.HasFile)
                    {
                        sql = "UPDATE Sponsors SET Name=@Name, Description=@Description, PhotoPath=@PhotoPath WHERE Id=@Id";
                    }
                    else
                    {
                        sql = "UPDATE Sponsors SET Name=@Name, Description=@Description WHERE Id=@Id";
                    }
                }
                else
                {
                    // Insert
                    sql = "INSERT INTO Sponsors (Name, Description, PhotoPath) VALUES (@Name, @Description, @PhotoPath)";
                }

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Description", desc);
                    if (fuSponsorPhoto.HasFile || editingId == 0)
                    {
                        cmd.Parameters.AddWithValue("@PhotoPath", photoPath);
                    }
                    if (editingId > 0)
                    {
                        cmd.Parameters.AddWithValue("@Id", editingId);
                    }

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            lblSponsorMsg.Text = editingId > 0 ? "Sponsor updated successfully!" : "Sponsor added successfully!";
            lblSponsorMsg.ForeColor = System.Drawing.Color.LightGreen;
            ResetForm();
            BindSponsors();
        }

        protected void gvSponsors_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvSponsors.DataKeys[e.RowIndex].Value);
            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand("DELETE FROM Sponsors WHERE Id=@Id", conn))
            {
                cmd.Parameters.AddWithValue("@Id", id);
                conn.Open();
                cmd.ExecuteNonQuery();
            }
            lblSponsorMsg.Text = "Sponsor deleted.";
            lblSponsorMsg.ForeColor = System.Drawing.Color.LightGreen;
            BindSponsors();
        }

        protected void gvSponsors_RowEditing(object sender, GridViewEditEventArgs e)
        {
            e.Cancel = true; // Handle manually
            int id = Convert.ToInt32(gvSponsors.DataKeys[e.NewEditIndex].Value);

            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlCommand cmd = new SqlCommand("SELECT Name, Description FROM Sponsors WHERE Id=@Id", conn))
            {
                cmd.Parameters.AddWithValue("@Id", id);
                conn.Open();
                using (SqlDataReader rdr = cmd.ExecuteReader())
                {
                    if (rdr.Read())
                    {
                        txtSponsorName.Text = rdr["Name"].ToString();
                        txtSponsorDescription.Text = rdr["Description"].ToString();
                        
                        hfEditingSponsorId.Value = id.ToString();
                        btnAddSponsor.Text = "Update Sponsor";
                        btnCancelEdit.Style["display"] = "inline-block";
                        lblSponsorMsg.Text = "Editing sponsor. (Leave photo empty to keep current)";
                        lblSponsorMsg.ForeColor = System.Drawing.Color.LightBlue;
                    }
                }
            }
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
        {
            ResetForm();
            lblSponsorMsg.Text = "Edit cancelled.";
            lblSponsorMsg.ForeColor = System.Drawing.Color.LightBlue;
        }

        private void ResetForm()
        {
            txtSponsorName.Text = "";
            txtSponsorDescription.Text = "";
            hfEditingSponsorId.Value = "0";
            btnAddSponsor.Text = "Add Sponsor";
            btnCancelEdit.Style["display"] = "none";
        }
    }
}
