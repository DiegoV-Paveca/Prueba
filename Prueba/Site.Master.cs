using System;
using System.Globalization;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace Prueba
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Evitamos ejecutar lógica pesada en cada postback (clics de botones, etc.)
            if (IsPostBack) return;
            else
            {
                if (phNavbar != null) phNavbar.Visible = true;
            }

            // =========================================================================
            // 1. LÓGICA DEL MENÚ (Marcar opción activa)
            // =========================================================================
            var current = (Request.AppRelativeCurrentExecutionFilePath ?? "").ToLowerInvariant();

            MarkActive("navHome", current == "~/" || current.EndsWith("/default.aspx"));
            MarkActive("navProyect", current.Contains("/proyect"));
            MarkActive("navAbout", current.Contains("/about"));
            MarkActive("navContact", current.Contains("/contact"));
            MarkActive("A2", current.Contains("/login"));
            MarkActive("A1", current.Contains("/future"));

            // =========================================================================
            // 2. LÓGICA DE USUARIO (SEGURA)
            // =========================================================================
            // Verificamos si realmente hay una sesión válida y el usuario está autenticado.
            // Esto evita que el código intente mostrar datos cuando estás en el Login.
            bool usuarioAutenticado = Request.IsAuthenticated && Session["UsuarioID"] != null;

            if (usuarioAutenticado)
            {
                // ¡HAY USUARIO! -> Mostramos el panel (botón salir + nombre)
                if (phUsuarioInfo != null)
                {
                    phUsuarioInfo.Visible = true;
                }

                // Obtenemos el nombre (prioridad: Cookie -> Sesión)
                string rawName = Context.User.Identity.Name;
                if (string.IsNullOrEmpty(rawName) && Session["UsuarioNombre"] != null)
                {
                    rawName = Session["UsuarioNombre"].ToString();
                }

                // Limpiamos y mostramos el nombre
                if (!string.IsNullOrEmpty(rawName))
                {
                    string cleanName = rawName;

                    // Si viene con dominio (DOMINIO\Usuario), nos quedamos solo con el usuario
                    if (cleanName.Contains("\\"))
                    {
                        cleanName = cleanName.Split('\\')[1];
                    }

                    // Formato bonito (Título)
                    cleanName = cleanName.Replace(".", " ");
                    cleanName = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(cleanName);

                    if (litUserName != null)
                    {
                        litUserName.Text = cleanName;
                    }
                }
            }
            else
            {
                // NO HAY USUARIO (Login o Anónimo) -> Ocultamos todo el panel
                // Esto es vital para evitar errores o bucles en la página de Login.
                if (phUsuarioInfo != null)
                {
                    phUsuarioInfo.Visible = false;
                }
            }
        }

        private void MarkActive(string anchorId, bool active)
        {
            if (!active) return;
            var ctl = FindControlRecursive(this, anchorId) as HtmlAnchor;
            if (ctl == null) return;

            var cls = ctl.Attributes["class"] ?? "nav-link";
            if (!cls.Contains("active")) ctl.Attributes["class"] = cls + " active";
            ctl.Attributes["aria-current"] = "page";
        }

        private Control FindControlRecursive(Control root, string id)
        {
            if (root.ID == id) return root;
            foreach (Control c in root.Controls)
            {
                var r = FindControlRecursive(c, id);
                if (r != null) return r;
            }
            return null;
        }

        protected void btnLogout_Click(object sender, EventArgs e)
        {
            // Cerrar sesión completamente
            Session.Abandon();
            Session.Clear();
            System.Web.Security.FormsAuthentication.SignOut();

            // Redirigir al Login
            Response.Redirect("~/Login.aspx");
        }
    }
}