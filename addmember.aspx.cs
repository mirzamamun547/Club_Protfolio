using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace KBC
{
    public partial class add_member : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindMembers();
        }

        private void BindMembers()
        {
            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlDataAdapter da = new SqlDataAdapter("SELECT Id, Name, Role, Department, Email, PhotoPath, Bio, LinkedInUrl, Category FROM Members ORDER BY Name", conn))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvMembers.DataSource = dt;
                    gvMembers.DataBind();
                }
            }
        }

        protected void gvMembers_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            int memberId = Convert.ToInt32(gvMembers.DataKeys[e.NewEditIndex].Value);
            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT Id, Name, Role, Department, Email, LinkedInUrl, Bio, Category FROM Members WHERE Id = @id", conn))
                {
                    cmd.Parameters.AddWithValue("@id", memberId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        if (dt.Rows.Count > 0)
                        {
                            DataRow row = dt.Rows[0];
                            txtMemberName.Text = row["Name"].ToString();
                            txtMemberRole.Text = row["Role"].ToString();
                            txtMemberDept.Text = row["Department"].ToString();
                            txtMemberEmail.Text = row["Email"].ToString();
                            txtMemberLinkedIn.Text = row["LinkedInUrl"].ToString();
                            txtMemberBio.Text = row["Bio"].ToString();
                            if (ddlMemberCategory.Items.FindByValue(row["Category"].ToString()) != null)
                                ddlMemberCategory.SelectedValue = row["Category"].ToString();
                            hfEditingMemberId.Value = memberId.ToString();
                            btnAddMember.Text = "Update Member";
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
            txtMemberName.Text = txtMemberRole.Text = txtMemberDept.Text = txtMemberEmail.Text = txtMemberLinkedIn.Text = txtMemberBio.Text = string.Empty;
            ddlMemberCategory.SelectedIndex = 0;
            hfEditingMemberId.Value = "0";
            btnAddMember.Text = "Add Member";
            btnCancelEdit.Style["display"] = "none";
            lblMemberMsg.Text = "";
        }

        protected void btnAddMember_Click(object sender, EventArgs e)
        {
            string name = txtMemberName.Text.Trim();
            string role = txtMemberRole.Text.Trim();
            string dept = txtMemberDept.Text.Trim();
            string email = txtMemberEmail.Text.Trim();
            string linkedIn = txtMemberLinkedIn.Text.Trim();
            string bio = txtMemberBio.Text.Trim();
            string category = ddlMemberCategory.SelectedValue;
            int memberId = Convert.ToInt32(hfEditingMemberId.Value);
            bool isEditing = memberId > 0;

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email))
            {
                lblMemberMsg.Text = "Name and Email are required.";
                lblMemberMsg.ForeColor = System.Drawing.Color.Red;
                return;
            }

            string photoPath = "images/default-member.png";

            // Handle file upload (only if a new file is uploaded)
            if (fuMemberPhoto.HasFile)
            {
                try
                {
                    string fileName = System.IO.Path.GetFileName(fuMemberPhoto.FileName);
                    string fileExt = System.IO.Path.GetExtension(fileName).ToLower();

                    if (fileExt != ".jpg" && fileExt != ".jpeg" && fileExt != ".png" && fileExt != ".gif")
                    {
                        lblMemberMsg.Text = "Only image files (jpg, jpeg, png, gif) are allowed.";
                        lblMemberMsg.ForeColor = System.Drawing.Color.Red;
                        return;
                    }

                    if (fuMemberPhoto.PostedFile.ContentLength > 2 * 1024 * 1024)
                    {
                        lblMemberMsg.Text = "File size must be less than 2MB.";
                        lblMemberMsg.ForeColor = System.Drawing.Color.Red;
                        return;
                    }

                    string folderPath = Server.MapPath("~/members-photos");
                    if (!System.IO.Directory.Exists(folderPath))
                    {
                        System.IO.Directory.CreateDirectory(folderPath);
                    }

                    string uniqueFileName = DateTime.Now.Ticks.ToString() + fileExt;
                    string filePath = System.IO.Path.Combine(folderPath, uniqueFileName);
                    fuMemberPhoto.SaveAs(filePath);
                    photoPath = "members-photos/" + uniqueFileName;
                }
                catch (Exception ex)
                {
                    lblMemberMsg.Text = "Error uploading photo: " + ex.Message;
                    lblMemberMsg.ForeColor = System.Drawing.Color.Red;
                    return;
                }
            }
            else if (isEditing)
            {
                // If editing and no new photo uploaded, keep existing photo
                string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    using (SqlCommand cmd = new SqlCommand("SELECT PhotoPath FROM Members WHERE Id = @id", conn))
                    {
                        cmd.Parameters.AddWithValue("@id", memberId);
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
                        // Update existing member
                        using (SqlCommand cmd = new SqlCommand("UPDATE Members SET Name=@n, Role=@r, Department=@d, Email=@e, PhotoPath=@p, Bio=@b, LinkedInUrl=@l, Category=@c WHERE Id=@id", conn))
                        {
                            cmd.Parameters.AddWithValue("@n", name);
                            cmd.Parameters.AddWithValue("@r", role);
                            cmd.Parameters.AddWithValue("@d", dept);
                            cmd.Parameters.AddWithValue("@e", email);
                            cmd.Parameters.AddWithValue("@p", photoPath);
                            cmd.Parameters.AddWithValue("@b", string.IsNullOrEmpty(bio) ? (object)DBNull.Value : bio);
                            cmd.Parameters.AddWithValue("@l", string.IsNullOrEmpty(linkedIn) ? (object)DBNull.Value : linkedIn);
                            cmd.Parameters.AddWithValue("@c", category);
                            cmd.Parameters.AddWithValue("@id", memberId);
                            cmd.ExecuteNonQuery();
                        }
                        lblMemberMsg.Text = "Member updated successfully!";
                    }
                    else
                    {
                        // Insert new member
                        using (SqlCommand cmd = new SqlCommand("INSERT INTO Members (Name, Role, Department, Email, PhotoPath, Bio, LinkedInUrl, Category) VALUES (@n,@r,@d,@e,@p,@b,@l,@c)", conn))
                        {
                            cmd.Parameters.AddWithValue("@n", name);
                            cmd.Parameters.AddWithValue("@r", role);
                            cmd.Parameters.AddWithValue("@d", dept);
                            cmd.Parameters.AddWithValue("@e", email);
                            cmd.Parameters.AddWithValue("@p", photoPath);
                            cmd.Parameters.AddWithValue("@b", string.IsNullOrEmpty(bio) ? (object)DBNull.Value : bio);
                            cmd.Parameters.AddWithValue("@l", string.IsNullOrEmpty(linkedIn) ? (object)DBNull.Value : linkedIn);
                            cmd.Parameters.AddWithValue("@c", category);
                            cmd.ExecuteNonQuery();
                        }
                        lblMemberMsg.Text = "Member added successfully!";
                    }
                }

                lblMemberMsg.ForeColor = System.Drawing.Color.Green;
                ClearForm();
                BindMembers();
            }
            catch (Exception ex)
            {
                lblMemberMsg.Text = "Error: " + ex.Message;
                lblMemberMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void gvMembers_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvMembers.DataKeys[e.RowIndex].Value);
            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("DELETE FROM Members WHERE Id = @id", conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.ExecuteNonQuery();
                }
            }
            BindMembers();
        }
    }
}
