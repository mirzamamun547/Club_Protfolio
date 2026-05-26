using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace KBC
{
    public partial class add_program : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                BindPrograms();
        }

        private void BindPrograms()
        {
            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            using (SqlDataAdapter da = new SqlDataAdapter("SELECT Id, ProgramName, Description, ProgramType, Status FROM Programs ORDER BY ProgramName", conn))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvProgramsCrud.DataSource = dt;
                gvProgramsCrud.DataBind();
            }
        }

        protected void gvProgramsCrud_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            int programId = Convert.ToInt32(gvProgramsCrud.DataKeys[e.NewEditIndex].Value);
            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                using (SqlCommand cmd = new SqlCommand("SELECT Id, ProgramName, Description, ProgramType, Status FROM Programs WHERE Id = @id", conn))
                {
                    cmd.Parameters.AddWithValue("@id", programId);
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        if (dt.Rows.Count > 0)
                        {
                            DataRow row = dt.Rows[0];
                            txtProgramName.Text = row["ProgramName"].ToString();
                            txtProgramDesc.Text = row["Description"].ToString();
                            txtProgramType.Text = row["ProgramType"].ToString();
                            txtProgramStatus.Text = row["Status"].ToString();
                            hfEditingProgramId.Value = programId.ToString();
                            btnAddProgram.Text = "Update Program";
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
            txtProgramName.Text = txtProgramDesc.Text = txtProgramType.Text = txtProgramStatus.Text = string.Empty;
            hfEditingProgramId.Value = "0";
            btnAddProgram.Text = "Add Program";
            btnCancelEdit.Style["display"] = "none";
            lblProgramMsg.Text = "";
        }

        protected void btnAddProgram_Click(object sender, EventArgs e)
        {
            string name = txtProgramName.Text.Trim();
            string desc = txtProgramDesc.Text.Trim();
            string type = txtProgramType.Text.Trim();
            string status = txtProgramStatus.Text.Trim();
            int programId = Convert.ToInt32(hfEditingProgramId.Value);
            bool isEditing = programId > 0;

            if (string.IsNullOrEmpty(name)) { lblProgramMsg.Text = "Program name required."; lblProgramMsg.ForeColor = System.Drawing.Color.Red; return; }

            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            try
            {
                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    conn.Open();
                    if (isEditing)
                    {
                        // Update existing program
                        using (SqlCommand cmd = new SqlCommand("UPDATE Programs SET ProgramName=@n, Description=@d, ProgramType=@t, Status=@s WHERE Id=@id", conn))
                        {
                            cmd.Parameters.AddWithValue("@n", name);
                            cmd.Parameters.AddWithValue("@d", desc);
                            cmd.Parameters.AddWithValue("@t", type);
                            cmd.Parameters.AddWithValue("@s", status);
                            cmd.Parameters.AddWithValue("@id", programId);
                            cmd.ExecuteNonQuery();
                        }
                        lblProgramMsg.Text = "Program updated successfully!";
                    }
                    else
                    {
                        // Insert new program
                        using (SqlCommand cmd = new SqlCommand("INSERT INTO Programs (ProgramName, Description, ProgramType, Status) VALUES (@n,@d,@t,@s)", conn))
                        {
                            cmd.Parameters.AddWithValue("@n", name);
                            cmd.Parameters.AddWithValue("@d", desc);
                            cmd.Parameters.AddWithValue("@t", type);
                            cmd.Parameters.AddWithValue("@s", status);
                            cmd.ExecuteNonQuery();
                        }
                        lblProgramMsg.Text = "Program added successfully!";
                    }
                }

                lblProgramMsg.ForeColor = System.Drawing.Color.Green;
                ClearForm();
                BindPrograms();
            }
            catch (Exception ex)
            {
                lblProgramMsg.Text = "Error: " + ex.Message;
                lblProgramMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void gvProgramsCrud_RowDeleting(object sender, System.Web.UI.WebControls.GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvProgramsCrud.DataKeys[e.RowIndex].Value);
            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("DELETE FROM Programs WHERE Id = @id", conn))
                {
                    cmd.Parameters.AddWithValue("@id", id);
                    cmd.ExecuteNonQuery();
                }
            }
            BindPrograms();
        }
    }
}
