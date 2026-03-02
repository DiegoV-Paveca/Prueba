using System;
using System.Web.Security;
using System.Web.UI;

namespace Prueba
{
    public partial class Misterio : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. SEGURIDAD: Si no hay sesión, ¡fuera!
            if (Session["UsuarioID"] == null)
            {
                FormsAuthentication.SignOut();
                Response.Redirect("Login.aspx");
            }

            // 2. Cargar datos del usuario
            if (!IsPostBack)
            {
                if (Session["UsuarioNombre"] != null)
                {
                    // IMPORTANTE: Esto requiere que exista un <asp:Label ID="lblUsuario"> en el .aspx
                    lblUsuario.Text = Session["UsuarioNombre"].ToString();

                }
            }
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // 3. CERRAR SESIÓN
            FormsAuthentication.SignOut();
            Session.Abandon();

            Response.Redirect("Login.aspx");
        }
    }
}