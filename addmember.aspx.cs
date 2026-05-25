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
                using (SqlDataAdapter da = new SqlDataAdapter("SELECT Id, Name, Role, Department, Email, PhotoPath, Bio, LinkedInUrl FROM Members ORDER BY Name", conn))
                {
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    gvMembers.DataSource = dt;
                    gvMembers.DataBind();
                }
            }
        }

        protected void btnAddMember_Click(object sender, EventArgs e)
        {
            string name = txtMemberName.Text.Trim();
            string role = txtMemberRole.Text.Trim();
            string dept = txtMemberDept.Text.Trim();
            string email = txtMemberEmail.Text.Trim();
            string linkedIn = txtMemberLinkedIn.Text.Trim();
            string bio = txtMemberBio.Text.Trim();

            if (string.IsNullOrEmpty(name) || string.IsNullOrEmpty(email))
            {
                lblMemberMsg.Text = "Name and Email are required.";
                return;
            }

            string photoPath = "images/default-member.png"; // Default photo

            // Handle file upload
            if (fuMemberPhoto.HasFile)
            {
                try
                {
                    string fileName = System.IO.Path.GetFileName(fuMemberPhoto.FileName);
                    string fileExt = System.IO.Path.GetExtension(fileName).ToLower();

                    // Validate file extension
                    if (fileExt != ".jpg" && fileExt != ".jpeg" && fileExt != ".png" && fileExt != ".gif")
                    {
                        lblMemberMsg.Text = "Only image files (jpg, jpeg, png, gif) are allowed.";
                        return;
                    }

                    // Validate file size (max 2MB)
                    if (fuMemberPhoto.PostedFile.ContentLength > 2 * 1024 * 1024)
                    {
                        lblMemberMsg.Text = "File size must be less than 2MB.";
                        return;
                    }

                    // Create folder if not exists
                    string folderPath = Server.MapPath("~/members-photos");
                    if (!System.IO.Directory.Exists(folderPath))
                    {
                        System.IO.Directory.CreateDirectory(folderPath);
                    }

                    // Save with unique name
                    string uniqueFileName = DateTime.Now.Ticks.ToString() + fileExt;
                    string filePath = System.IO.Path.Combine(folderPath, uniqueFileName);
                    fuMemberPhoto.SaveAs(filePath);
                    photoPath = "members-photos/" + uniqueFileName;
                }
                catch (Exception ex)
                {
                    lblMemberMsg.Text = "Error uploading photo: " + ex.Message;
                    return;
                }
            }

            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    using (SqlCommand cmd = new SqlCommand("INSERT INTO Members (Name, Role, Department, Email, PhotoPath, Bio, LinkedInUrl, Category) VALUES (@n,@r,@d,@e,@p,@b,@l,@c)", conn))
                    {
                        cmd.Parameters.AddWithValue("@n", name);
                        cmd.Parameters.AddWithValue("@r", role);
                        cmd.Parameters.AddWithValue("@d", dept);
                        cmd.Parameters.AddWithValue("@e", email);
                        cmd.Parameters.AddWithValue("@p", photoPath);
                        cmd.Parameters.AddWithValue("@b", string.IsNullOrEmpty(bio) ? (object)DBNull.Value : bio);
                        cmd.Parameters.AddWithValue("@l", string.IsNullOrEmpty(linkedIn) ? (object)DBNull.Value : linkedIn);
                        cmd.Parameters.AddWithValue("@c", "Member"); // Default category
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMemberMsg.Text = "Member added successfully!";
                lblMemberMsg.ForeColor = System.Drawing.Color.Green;
                txtMemberName.Text = txtMemberRole.Text = txtMemberDept.Text = txtMemberEmail.Text = txtMemberLinkedIn.Text = txtMemberBio.Text = string.Empty;
                BindMembers();
            }
            catch (Exception ex)
            {
                lblMemberMsg.Text = "Error adding member: " + ex.Message;
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
