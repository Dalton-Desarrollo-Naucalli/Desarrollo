using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Funcionalidad_CalculoSeguros :  System.Web.UI.Page
{
    WsFuncionalidad.Funcionalidad fnc = new WsFuncionalidad.Funcionalidad();
    string nomcon = "ConexionDBS";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            LlenarComboCliente();
        }
    }
    
    private void LlenarComboCliente()
    {
        var query = "SELECT No_aseg as ID, nombre_aseg as nombre FROM SIIFI_aseguradora WHERE activo = 1 AND borradoLogico = 0";
        cmbCliente.DataSource = fnc.ObtenDataSet("obtenCampo", query, nomcon);
        cmbCliente.ValueField = "ID";
        cmbCliente.TextField = "nombre";
        cmbCliente.DataBind();
    }

    private void LlenarComboContrato(string aseguradora)
    {
        var query = $"SELECT dac.contrato as ID, dac.contrato as nombre " +
            $"FROM SAC_PolizasSeguroCreditoTbl psc INNER JOIN SAC_DatosAdicionalesCreditoTbl dac " +
            $"ON psc.cred_id = dac.cred_id and psc.idAseguradora = {aseguradora} " +
            $"GROUP BY dac.contrato";
        cmbContrato.DataSource = fnc.ObtenDataSet("obtenCampo", query, nomcon);
        cmbContrato.ValueField = "ID";
        cmbContrato.TextField = "nombre";
        cmbContrato.DataBind();
    }

    private void LlenarComboAnexo(string contrato)
    {
        var query = $"SELECT dac.anexo as ID, dac.anexo as nombre " +
            $"FROM SAC_PolizasSeguroCreditoTbl psc " +
            $"INNER JOIN SAC_DatosAdicionalesCreditoTbl dac ON psc.cred_id = dac.cred_id " +
            $"WHERE psc.idAseguradora = {cmbCliente.SelectedItem.Value} AND dac.contrato = '{contrato}'";
        cmbAnexo.DataSource = fnc.ObtenDataSet("obtenCampo", query, nomcon);
        cmbAnexo.ValueField = "ID";
        cmbAnexo.TextField = "nombre";
        cmbAnexo.DataBind();
    }

    protected void cmbContrato_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
    {
        LlenarComboContrato(e.Parameter);
    }

    protected void cmbAnexo_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
    {
        LlenarComboAnexo(e.Parameter);
    }

    protected void callbackPanel_Callback(object sender, DevExpress.Web.CallbackEventArgsBase e)
    {
        //Funcionalidad para llenar los campos de los cálculos
        var query = $"SELECT dac.contrato, psc.fechaEmision, psc.fechaVencimiento, dac.VIN,  " +
            $"dac.anexo, psc.poliza, psc.importePrima, psc.porcentajeUDI, c.nombre " +
            $"FROM SAC_PolizasSeguroCreditoTbl psc " +
            $"INNER JOIN SAC_DatosAdicionalesCreditoTbl dac ON psc.cred_id = dac.cred_id " +
            $"INNER JOIN SIIFI_credito sc on psc.cred_id = sc.cred_id " +
            $"INNER JOIN cliente c on sc.SOCIO_ID = c.cliente_id " +
            $"WHERE dac.contrato = '{e.Parameter.Split('|')[1]}' " +
            $"AND dac.anexo = '{e.Parameter.Split('|')[2]}' " +
            $"AND psc.idEstatus <> 4 AND psc.idEstatus <> 1";

        var resultados = fnc.ObtenDataSet("obtenCampo", query, nomcon);

        if (resultados.Tables.Count > 0)
        {
            var t = resultados.Tables[0];

            if (t.Rows.Count > 0)
            {
                foreach (System.Data.DataRow row in t.Rows)
                {
                    txtContrato.Text = row["contrato"].ToString();

                    txtAnexo.Text = row["anexo"].ToString();

                    txtVIN.Text = row["VIN"].ToString();

                    txtEmpresa.Text = row["nombre"].ToString();

                    txtCompañía.Text = cmbCliente.SelectedItem.Text;

                    ASPxDateEdit1.Text = Convert.ToDateTime(row["fechaEmision"]).ToString("dd/MM/yyyy");

                    ASPxDateEdit2.Text = Convert.ToDateTime(row["fechaVencimiento"]).ToString("dd/MM/yyyy");

                    txtPoliza.Text = row["poliza"].ToString();

                    txtUDI.Text = row["porcentajeUDI"].ToString();
                    txtUDI.DisplayFormatString = "p";

                    txtPrima.Text = row["importePrima"].ToString();
                    txtPrima.DisplayFormatString = "c";
                }
            }
        }

    }
}