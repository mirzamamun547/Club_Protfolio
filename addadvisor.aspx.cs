using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace KBC
{
    public partial class add_advisor : System.Web.UI.Page
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
                    gvAdvisors.DataSource = dt;
                    gvAdvisors.DataBind();
                }
            }
        }

        protected void gvAdvisors_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            int advisorId = Convert.ToInt32(gvAdvisors.DataKeys[e.NewEditIndex].Value);
            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT Id, Name, Role, Expertise, Department, Email, Bio FROM Advisors WHERE Id = @id", conn))
                {
                    cmd.Parameters.AddWithValue("@id", advisorId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        if (dt.Rows.Count > 0)
                        {
                            DataRow row = dt.Rows[0];
                            txtAdvisorName.Text = row["Name"].ToString();
                            txtAdvisorRole.Text = row["Role"].ToString();
                            txtAdvisorExpertise.Text = row["Expertise"].ToString();
                            txtAdvisorDept.Text = row["Department"].ToString();
                            txtAdvisorEmail.Text = row["Email"].ToString();
                            txtAdvisorBio.Text = row["Bio"].ToString();
                            hfEditingAdvisorId.Value = advisorId.ToString();
                            btnAddAdvisor.Text = "Update Advisor";
                            btnCancelEdit.Style["display"] = "inline-block";
                        }
                    }
                }
            }
        }

        protected void btnCancelEdit_Click(object sender, EventArgs e)
        {
            ClearForm();
        }

        private void ClearForm()
        {
            txtAdvisorName.Text = txtAdvisorRole.Text = txtAdvisorExpertise.Text = txtAdvisorDept.Text = txtAdvisorEmail.Text = txtAdvisorBio.Text = string.Empty;
            hfEditingAdvisorId.Value = "0";
            btnAddAdvisor.Text = "Add Advisor";
            btnCancelEdit.Style["display"] = "none";
            lblAdvisorMsg.Text = "";
        }

        protected void btnAddAdvisor_Click(object sender, EventArgs e)
        {
            string name = txtAdvisorName.Text.Trim();
            string role = txtAdvisorRole.Text.Trim();
            string expertise = txtAdvisorExpertise.Text.Trim();
            string dept = txtAdvisorDept.Text.Trim();
            string email = txtAdvisorEmail.Text.Trim();
            string bio = txtAdvisorBio.Text.Trim();
            int advisorId = Convert.ToInt32(hfEditingAdvisorId.Value);
            bool isEditing = advisorId > 0;

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email) || string.IsNullOrEmpty(role) || string.IsNullOrEmpty(expertise))
            {
                lblAdvisorMsg.Text = "Name, Email, Role, and Expertise are required.";
                lblAdvisorMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string photoPath = "images/default-advisor.png";

            // Handle file upload (only if a new file is uploaded)
            if (fuAdvisorPhoto.HasFile)
            {
                try
                {
                    string fileName = System.IO.Path.GetFileName(fuAdvisorPhoto.FileName);
                    string fileExt = System.IO.Path.GetExtension(fileName).ToLower();

                    if (fileExt != ".jpg" && fileExt != ".jpeg" && fileExt != ".png" && fileExt != ".gif")
                    {
                        lblAdvisorMsg.Text = "Only image files (jpg, jpeg, png, gif) are allowed.";
                        lblAdvisorMsg.ForeColor = System.Drawing.Color.Red;
                        return;
                    }

                    if (fuAdvisorPhoto.PostedFile.ContentLength > 2 * 1024 * 1024)
                    {
                        lblAdvisorMsg.Text = "File size must be less than 2MB.";
                        lblAdvisorMsg.ForeColor = System.Drawing.Color.Red;
                        return;
                    }

                    string folderPath = Server.MapPath("~/advisor-photos");
                    if (!System.IO.Directory.Exists(folderPath))
                    {
                        System.IO.Directory.CreateDirectory(folderPath);
                    }

                    string uniqueFileName = DateTime.Now.Ticks.ToString() + fileExt;
                    string filePath = System.IO.Path.Combine(folderPath, uniqueFileName);
                    fuAdvisorPhoto.SaveAs(filePath);
                    photoPath = "advisor-photos/" + uniqueFileName;
                }
                catch (Exception ex)
                {
                    lblAdvisorMsg.Text = "Error uploading photo: " + ex.Message;
                    lblAdvisorMsg.ForeColor = System.Drawing.Color.Red;
                    return;
                }
            }
            else if (isEditing)
            {
                // If editing and no new photo uploaded, keep existing photo
                string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT PhotoPath FROM Advisors WHERE Id = @id", conn))
                    {
                        cmd.Parameters.AddWithValue("@id", advisorId);
                        conn.Open();
                        object result = cmd.ExecuteScalar();
                        if (result != null)
                            photoPath = result.ToString();
                    }
                }
            }

            string connStr2 = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr2))
                {
                    conn.Open();
                    if (isEditing)
                    {
                        // Update existing advisor
                        using (SqlCommand cmd = new SqlCommand("UPDATE Advisors SET Name=@n, Role=@r, Expertise=@ex, Department=@d, Email=@e, PhotoPath=@p, Bio=@b WHERE Id=@id", conn))
                        {
                            cmd.Parameters.AddWithValue("@n", name);
                            cmd.Parameters.AddWithValue("@r", role);
                            cmd.Parameters.AddWithValue("@ex", expertise);
                            cmd.Parameters.AddWithValue("@d", dept);
                            cmd.Parameters.AddWithValue("@e", email);
                            cmd.Parameters.AddWithValue("@p", photoPath);
                            cmd.Parameters.AddWithValue("@b", string.IsNullOrEmpty(bio) ? (object)DBNull.Value : bio);
                            cmd.Parameters.AddWithValue("@id", advisorId);
                            cmd.ExecuteNonQuery();
                        }
                        lblAdvisorMsg.Text = "Advisor updated successfully!";
                    }
                    else
                    {
                        // Insert new advisor
                        using (SqlCommand cmd = new SqlCommand("INSERT INTO Advisors (Name, Role, Expertise, Department, Email, PhotoPath, Bio) VALUES (@n,@r,@ex,@d,@e,@p,@b)", conn))
                        {
                            cmd.Parameters.AddWithValue("@n", name);
                            cmd.Parameters.AddWithValue("@r", role);
                            cmd.Parameters.AddWithValue("@ex", expertise);
                            cmd.Parameters.AddWithValue("@d", dept);
                            cmd.Parameters.AddWithValue("@e", email);
                            cmd.Parameters.AddWithValue("@p", photoPath);
                            cmd.Parameters.AddWithValue("@b", string.IsNullOrEmpty(bio) ? (object)DBNull.Value : bio);
                            cmd.ExecuteNonQuery();
                        }
                        lblAdvisorMsg.Text = "Advisor added successfully!";
                    }
                }

                lblAdvisorMsg.ForeColor = System.Drawing.Color.Green;
                ClearForm();
                BindAdvisors();
            }
            catch (Exception ex)
            {
                lblAdvisorMsg.Text = "Error: " + ex.Message;
                lblAdvisorMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void gvAdvisors_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvAdvisors.DataKeys[e.RowIndex].Value);
            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("DELETE FROM Advisors WHERE Id = @id", conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.ExecuteNonQuery();
                }
            }
            BindAdvisors();
        }
    }
}
