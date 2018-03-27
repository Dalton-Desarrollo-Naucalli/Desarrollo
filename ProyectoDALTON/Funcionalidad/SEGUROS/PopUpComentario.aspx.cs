using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Funcionalidad_PopUpComentario : System.Web.UI.Page
{
    WsFuncionalidad.Funcionalidad fnc = new WsFuncionalidad.Funcionalidad();
    string nomcon = "ConexionDBS";
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrWhiteSpace(txtComentario.Text))
        {
            var query = ObtenerQueryBitacora(Request.QueryString["id"], Request.QueryString["con"]);

            fnc.ObtenDataSet("obtenCampo", query, nomcon);
        }        
    }

    private string ObtenerQueryBitacora(string idCredito, string consecutivo)
    {
        var query = $"IF NOT EXISTS(SELECT idBitacora FROM SAC_PolizasSeguroCreditoBitacoraTbl WHERE cred_id = {idCredito} AND consecutivoPoliza = {consecutivo})" +
            $"BEGIN INSERT INTO SAC_PolizasSeguroCreditoBitacoraTbl " +
            $"VALUES({idCredito}, {consecutivo}, 1, '{txtComentario.Text}', 0, '{Session["iIdUsuario"].ToString()}', '{DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss")}', '<local machine>'); END " +
            $"ELSE BEGIN INSERT INTO SAC_PolizasSeguroCreditoBitacoraTbl VALUES({idCredito}, {consecutivo}," +
            $" (SELECT TOP 1 (idBitacora + 1) FROM SAC_PolizasSeguroCreditoBitacoraTbl WHERE cred_id = {idCredito} AND consecutivoPoliza = {consecutivo} ORDER BY idBitacora DESC)," +
            $" '{txtComentario.Text}', 0, '{Session["iIdUsuario"].ToString()}', '{DateTime.Now.ToString("yyyy-MM-dd hh:mm:ss")}', '<local machine>'); END; " +
            $" ";
        return query;
    }
}