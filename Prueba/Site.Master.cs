using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Globalization; // Necesario para ToTitleCase

namespace Prueba
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // =========================================================================
            // 1. CANDADO DE SEGURIDAD GLOBAL
            // =========================================================================
            // Verificamos si el usuario NO está autenticado.
            if (!Context.User.Identity.IsAuthenticated)
            {
                // Obtenemos la URL actual en minúsculas
                string path = Request.Url.AbsolutePath.ToLower();

                // Si NO estamos en la página de Login, expulsamos al usuario.
                // Esto protege Default, About, Contact y cualquier otra página.
                if (!path.Contains("login.aspx"))
                {
                    Response.Redirect("~/Login.aspx");
                    return; // Detenemos la ejecución para que no cargue nada más
                }
            }

            if (IsPostBack) return;

            // =========================================================================
            // 2. LÓGICA DEL MENÚ (MarkActive)
            // =========================================================================
            var current = (Request.AppRelativeCurrentExecutionFilePath ?? "").ToLowerInvariant();

            MarkActive("navHome", current == "~/" || current.EndsWith("/default.aspx"));
            MarkActive("navProyect", current.Contains("/proyect"));
            MarkActive("navAbout", current.Contains("/about"));
            MarkActive("navContact", current.Contains("/contact"));

            // =========================================================================
            // 3. MOSTRAR NOMBRE DE USUARIO
            // =========================================================================
            string rawName = Context.User.Identity.Name;

            if (!string.IsNullOrEmpty(rawName))
            {
                string cleanName = rawName;

                // Si el nombre viene con dominio (ej: DOMINIO\Usuario), lo limpiamos
                if (cleanName.Contains("\\"))
                {
                    cleanName = cleanName.Split('\\')[1];
                }

                // Reemplazamos puntos por espacios (ej: diego.valencic -> diego valencic)
                cleanName = cleanName.Replace(".", " ");

                // Convertimos a Título (ej: Diego Valencic)
                cleanName = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(cleanName);

                // Asignamos el nombre al control en la Master Page
                if (litUserName != null)
                {
                    litUserName.Text = cleanName;
                }
            }
        }

        private void MarkActive(string anchorId, bool active)
        {
            if (!active) return;
            // Buscamos el control recursivamente por si está dentro de otros contenedores
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
    }
}