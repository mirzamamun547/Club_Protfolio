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

        protected void btnAddProgram_Click(object sender, EventArgs e)
        {
            string name = txtProgramName.Text.Trim();
            string desc = txtProgramDesc.Text.Trim();
            string type = txtProgramType.Text.Trim();
            string status = txtProgramStatus.Text.Trim();

            if (string.IsNullOrEmpty(name)) { lblProgramMsg.Text = "Program name required."; return; }

            string connStr = ConfigurationManager.ConnectionStrings["KBEC_Connection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand("INSERT INTO Programs (ProgramName, Description, ProgramType, Status) VALUES (@n,@d,@t,@s)", conn))
                {
                    cmd.Parameters.AddWithValue("@n", name);
                    cmd.Parameters.AddWithValue("@d", desc);
                    cmd.Parameters.AddWithValue("@t", type);
                    cmd.Parameters.AddWithValue("@s", status);
                    cmd.ExecuteNonQuery();
                }
            }

            txtProgramName.Text = txtProgramDesc.Text = txtProgramType.Text = txtProgramStatus.Text = string.Empty;
            BindPrograms();
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
