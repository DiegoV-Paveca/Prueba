using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Security;
using System.Web.UI;

/* Como agregar usuario en SQL

INSERT INTO dbo.login (usuario, email, passwordHash, fechaRegistro)
VALUES (
    'nuevo_usuario_encriptado', 
    'nuevo@paveca.com.ve', 
    HASHBYTES('SHA2_256', '123456'), -- Prueba cambiando SHA2_256 por SHA1 o MD5 si no funciona
    GETDATE()
);
*/



namespace Prueba
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // =========================================================================
            // SOLUCIÓN AL BUCLE INFINITO
            // =========================================================================
            // Verificamos DOS cosas antes de redirigir:
            // 1. Session["UsuarioID"] != null  -> ¿Tenemos datos del usuario?
            // 2. Request.IsAuthenticated       -> ¿Tenemos la COOKIE de pase?

            if (Session["UsuarioID"] != null && Request.IsAuthenticated)
            {
                // Todo correcto, pase usted.
                Response.Redirect("Misterio.aspx");
            }
            else if (Session["UsuarioID"] != null && !Request.IsAuthenticated)
            {
                // CASO ZOMBIE: Tienes sesión en memoria, pero NO tienes la cookie válida.
                // El Web.config no te dejará pasar, así que borramos esa sesión corrupta
                // para que puedas loguearte de nuevo limpiamente.
                Session.Abandon();
                Session.Clear();
                System.Web.Security.FormsAuthentication.SignOut();
            }
            // Si no hay sesión, simplemente carga la página de Login normal.
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string usuario = txtUsuario.Text.Trim();
            string password = txtPassword.Text.Trim();
            string mensajeError = "";

            if (ValidarUsuarioDiagnostico(usuario, password, out mensajeError))
            {
                // 1. Crear la cookie de autenticación (CRUCIAL)
                FormsAuthentication.SetAuthCookie(usuario, false);

                // 2. Redirigir a la zona segura
                Response.Redirect("Misterio.aspx");
            }
            else
            {
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

                    // PASO 1: Verificar existencia
                    string queryUser = "SELECT COUNT(*) FROM dbo.login WHERE usuario = @user OR email = @user";
                    using (SqlCommand cmd = new SqlCommand(queryUser, con))
                    {
                        cmd.Parameters.AddWithValue("@user", user);
                        int count = (int)cmd.ExecuteScalar();

                        if (count == 0)
                        {
                            mensaje = "El usuario no existe.";
                            return false;
                        }
                    }

                    // PASO 2: Verificar contraseña
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