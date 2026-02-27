using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace Prueba
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack) return;

            var current = (Request.AppRelativeCurrentExecutionFilePath ?? "").ToLowerInvariant();

            MarkActive("navHome", current == "~/" || current.EndsWith("/default.aspx"));
            MarkActive("navProyect", current.Contains("/proyect"));
            MarkActive("navAbout", current.Contains("/about"));
            MarkActive("navContact", current.Contains("/contact"));
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
    }
}