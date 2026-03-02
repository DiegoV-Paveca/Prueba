using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace Prueba
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Si ya hay sesión, redirigir al inicio
            if (Session["UsuarioID"] != null)
            {
                Response.Redirect("Default.aspx");
            }
        }

        // ESTE ES EL MÉTODO QUE TE FALTA O TIENE EL NOMBRE INCORRECTO
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string usuario = txtUsuario.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Validaciones básicas
            if (string.IsNullOrEmpty(usuario) || string.IsNullOrEmpty(password))
            {
                lblError.Text = "Por favor ingresa usuario y contraseña.";
                lblError.Visible = true;
                return;
            }

            // Llamada a la función de validación
            if (ValidarUsuario(usuario, password))
            {
                // Login exitoso
                Response.Redirect("Default.aspx");
            }
            else
            {
                // Login fallido
                lblError.Text = "Usuario o contraseña incorrectos.";
                lblError.Visible = true;
            }
        }

        private bool ValidarUsuario(string user, string pass)
        {
            bool esValido = false;
            // Asegúrate de que "PavecaConnection" coincida con el nombre en tu Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["PavecaConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // Consulta que verifica usuario y contraseña hasheada
                string query = @"SELECT id, usuario 
                                 FROM dbo.login 
                                 WHERE (usuario = @user OR email = @user) 
                                 AND passwordHash = HASHBYTES('SHA2_256', @pass)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@user", user);
                    cmd.Parameters.AddWithValue("@pass", pass);

                    try
                    {
                        con.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                esValido = true;
                                Session["UsuarioID"] = reader["id"].ToString();
                                Session["UsuarioNombre"] = reader["usuario"].ToString();
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        lblError.Text = "Error de conexión: " + ex.Message;
                        lblError.Visible = true;
                    }
                }
            }
            return esValido;
        }
    }
}