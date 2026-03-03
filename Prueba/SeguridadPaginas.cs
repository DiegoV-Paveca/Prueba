using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace Prueba
{
    // Esta clase hereda de "Page" (la página normal de ASP.NET)
    // Pero le agregamos nuestra regla de seguridad.
    public class SeguridadPaginas : Page
    {
        protected override void OnLoad(EventArgs e)
        {
            // 1. SEGURIDAD CENTRALIZADA
            // Si no hay sesión, lo mandamos al Login inmediatamente.
            if (Session["UsuarioID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            // 2. Continuar con la carga normal de la página
            base.OnLoad(e);
        }
    }
}