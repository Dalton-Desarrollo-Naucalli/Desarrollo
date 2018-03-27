using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Funcionalidad_PopUpBitacora : System.Web.UI.Page
{
    WsFuncionalidad.Funcionalidad fnc = new WsFuncionalidad.Funcionalidad();
    string nomcon = "ConexionDBS";
    protected void Page_Load(object sender, EventArgs e)
    {
        LlenarDatosBitacora(Request.QueryString["id"], Request.QueryString["con"]);
    }
    
    private void LlenarDatosBitacora(string id, string consecutivo)
    {
        var query = ObtenerQueryBitacora(id, consecutivo);

        var ds = fnc.ObtenDataSet("obtenCampo", query, nomcon);

        if (ds.Tables.Count > 0)
        {
            var tabla = ds.Tables[0];
            gvBitacora.DataSource = tabla;
        }
        else
        {
            DataTable t = new DataTable();
            t.Columns.Add("Resultado");
            t.Rows.Add("No se encontraron registros en la bitácora.");
            gvBitacora.DataSource = t;
        }
        gvBitacora.DataBind();
    }

    private string ObtenerQueryBitacora(string id, string consecutivo)
    {
        var query = $"SELECT ultActual as Fecha, comentario as Comentario " +
            $"FROM SAC_PolizasSeguroCreditoBitacoraTbl " +
            $"WHERE cred_id = {id} AND consecutivoPoliza = {consecutivo}";
        return query;
    }
}