using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;

namespace Prueba
{
    public partial class Proyect : SeguridadPaginas
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // No necesitamos lógica aquí, todo se hace vía AJAX
        }

        // Este método es el que llamará el JavaScript
        [WebMethod]
        public static List<decimal> ObtenerDatosProduccion()
        {
            List<decimal> datos = new List<decimal>();

            // 1. Leemos la conexión
            string connString = ConfigurationManager.ConnectionStrings["PavecaConnection"].ConnectionString;

            // 2. Intentamos conectar SIN "try-catch" para ver el error real si falla
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Consulta simple
                string query = "SELECT Toneladas FROM VentasMensuales WHERE Anio = 2024 ORDER BY Mes ASC";

                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open(); // <--- AQUÍ ES DONDE PROBABLEMENTE ESTÁ FALLANDO

                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    datos.Add(Convert.ToDecimal(reader["Toneladas"]));
                }
            }

            // Rellenar con ceros si faltan meses (solo visual)
            while (datos.Count < 12) datos.Add(0);

            return datos;
        }
    }
}