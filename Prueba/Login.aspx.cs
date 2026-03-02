using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Security; // NECESARIO para la cookie de seguridad
using System.Web.UI;

namespace Prueba
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Si el usuario ya tiene sesión, lo mandamos directo a la zona secreta
            if (Session["UsuarioID"] != null)
            {
                Response.Redirect("Misterio.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string usuario = txtUsuario.Text.Trim();
            string password = txtPassword.Text.Trim();
            string mensajeError = "";

            if (ValidarUsuarioDiagnostico(usuario, password, out mensajeError))
            {
                // --- PASO CRÍTICO QUE FALTABA ---
                // Creamos la "Cookie de Autorización". 
                // Esto le dice al Web.config: "Este usuario ya pasó el control, déjalo entrar".
                FormsAuthentication.SetAuthCookie(usuario, false);

                // Ahora sí, redirigimos a la página protegida
                Response.Redirect("Misterio.aspx");
            }
            else
            {
                // Mostramos el error en pantalla
                lblError.Text = mensajeError;
                lblError.Visible = true;
            }
        }

        private bool ValidarUsuarioDiagnostico(string user, string pass, out string mensaje)
        {
            mensaje = "Error desconocido";
            string connectionString = ConfigurationManager.ConnectionStrings["PavecaConnection"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                try
                {
                    con.Open();

                    // PASO 1: Verificar si el usuario existe (sin importar la contraseña)
                    string queryUser = "SELECT COUNT(*) FROM dbo.login WHERE usuario = @user OR email = @user";
                    using (SqlCommand cmd = new SqlCommand(queryUser, con))
                    {
                        cmd.Parameters.AddWithValue("@user", user);
                        int count = (int)cmd.ExecuteScalar();

                        if (count == 0)
                        {
                            mensaje = "El usuario NO existe en la base de datos.";
                            return false;
                        }
                    }

                    // PASO 2: Verificar la contraseña
                    // Usamos CAST(@pass AS VARCHAR(50)) para que coincida con el formato de SQL
                    string queryPass = @"SELECT id, usuario 
                                         FROM dbo.login 
                                         WHERE (usuario = @user OR email = @user) 
                                         AND passwordHash = HASHBYTES('SHA2_256', CAST(@pass AS VARCHAR(50)))";

                    using (SqlCommand cmd = new SqlCommand(queryPass, con))
                    {
                        cmd.Parameters.AddWithValue("@user", user);
                        cmd.Parameters.AddWithValue("@pass", pass);

                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                // Login Exitoso: Guardamos datos en sesión
                                Session["UsuarioID"] = reader["id"].ToString();
                                Session["UsuarioNombre"] = reader["usuario"].ToString();
                                return true;
                            }
                            else
                            {
                                mensaje = "El usuario existe, pero la contraseña es INCORRECTA.";
                                return false;
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    mensaje = "Error de conexión a BD: " + ex.Message;
                    return false;
                }
            }
        }
    }
}