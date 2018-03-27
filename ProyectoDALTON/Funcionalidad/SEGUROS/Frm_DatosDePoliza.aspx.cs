using System;
using System.Data;
using DevExpress.Web;
using System.Text.RegularExpressions;

public partial class Funcionalidad_Frm_DatosDePoliza : System.Web.UI.Page
{
    private WsSeguridad.Seguridad Servicio = new WsSeguridad.Seguridad();
    WsFuncionalidad.Funcionalidad fnc = new WsFuncionalidad.Funcionalidad();
    public string vsistema = System.Configuration.ConfigurationManager.AppSettings["sistema"];
    public string vempresa = System.Configuration.ConfigurationManager.AppSettings["empresa"];

    #region "Variables"
    String nomcon = "ConexionDBS";
    string resultado = string.Empty;
    DataSet tabla = new DataSet();
    DataTable dtTipoDato = new DataTable();
    DataSet tablaDatVehiculo = new DataSet();
    DataTable dtDatVehiculo = new DataTable();
    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["sCliente"] == null)
            {
                Response.Buffer = true;
                Response.Clear();
                Response.Redirect("../Framework/Acceso.aspx");
            }
            VerificaAccesos("Frm_MonitorGeneralSeguros");

            param.Value = Request.QueryString["IdTab"];

            consecutivo.Value = Request.QueryString["secuencia"];

            if (Request.QueryString["Endoso"].ToString() != "NO")
            {
                btnAgregarEndoso.Visible = false;
            }

            if (DateTime.Now.AddDays(30) <= Convert.ToDateTime(Request.QueryString["Vence"]))
            {
                btnNuevaPoliza.Visible = false;
            }

            if (Request.QueryString["Cancela"].ToString() != "SI")
            {
                txtCancelar.Visible = false;
            }

            ConsultaGral(Convert.ToInt32(param.Value), consecutivo.Value);

            DeshabilitarControles();
        }
    }
    
    /// <summary>
    /// Método utilizado para Seguridad
    /// </summary>
    public void VerificaAccesos(object txtFormulario)
    {
        DataSet DsAccesos = new DataSet();
        DataTable dtAccesos = default(DataTable);
        Int32 vRenglon = 0;
        DsAccesos = Servicio.OpVerificaAccesosFormulario(Session["sUsuario"], Session["iIdUsuario"], txtFormulario, System.Configuration.ConfigurationManager.AppSettings["ConexionSeguridad"]);
        dtAccesos = DsAccesos.Tables["Accesos"];

        String txtAcceso = "";
        string txtAccesosUsuario = "";

        //VerificaAccesos("Frm_FacturasSeguros");
        if (DsAccesos.Tables.Count > 0)
        {
            if (DsAccesos.Tables[0].Rows.Count > 0)
            {
                //foreach (DataRow drAccesos in dtAccesos.Rows )
                foreach (DataRow drAccesos in dtAccesos.Rows)
                {
                    txtAcceso = DsAccesos.Tables["Accesos"].Rows[vRenglon]["nombre"].ToString().Trim();

                    if (txtAcceso == "AGREGAR")
                    {
                        // ColumnaGrid.ShowNewButtonInHeader = true;
                    }

                    if (txtAcceso == "EDITAR")
                    {
                        //ColumnaGrid.ShowEditButton = true;


                    }
                    if (txtAcceso == "ELIMINAR")
                    {
                        // ColumnaGrid.ShowDeleteButton = true;
                    }
                    vRenglon = vRenglon + 1;
                    txtAccesosUsuario = txtAccesosUsuario + txtAcceso + "-";
                    //this.lblAccesos.Text = txtAccesosUsuario;
                }
            }
            else
            {
                //this.lblAccesos.Text = "Su usuario no tiene acceso a este formaulario...";
                Response.Buffer = true;
                Response.Clear();
                Response.Redirect("../Framework/Acceso.aspx");
            }
        }
    }
    
    /// <summary>
    /// Método utilizado para Consultar 
    /// </summary>
    public void ConsultaGral(int id_cred, string consecutivo)
    {
        var consulta = $"SELECT cre.cred_id, dac.contrato, dac.anexo, " +
            $"dac.vin, ase.nombre_aseg, cre.intfondeado, psc.numeroEndoso, " +
            $"CASE WHEN psc.idQuienCompra = 1 THEN 'DES' ELSE 'CTE' END as QuienCompra, " +
            $"psc.fechaSolicitud, psc.poliza, psc.fechaEmision, " +
            $"psc.fechaVencimiento, (psc.importeTotal - psc.importeIva) as importePrima, psc.importeIva, " +
            $"psc.importeTotal,	dac.caracteristicas, psc.idEstatus, ssp.idSiniestro, age.nombre as agencia, " +
            $"pro.nombre as promotor, cli.nombre as cliente, sfb.nombre as fondeadora, psc.porcentajeUDI, " +
            $"(select marca from dbo.Fn_Busca_Caracteristicas(dac.caracteristicas)) as marca, " +
            $"(select modeloSubtipo from dbo.Fn_Busca_Caracteristicas(dac.caracteristicas)) as subtipo, " +
            $"(select anio from dbo.Fn_Busca_Caracteristicas(dac.caracteristicas)) as modelo, " +
            $"cgt.descripcion as estatus, dac.referencia, psc.agenteSeguro " +
            $"FROM SIIFI_credito cre " +
            $"JOIN cliente cli ON cre.Socio_ID = cli.cliente_id " +
            $"JOIN SAC_PolizasSeguroCreditoTbl psc ON psc.cred_id = cre.cred_id " +
            $"LEFT JOIN SAC_DatosAdicionalesCreditoTbl dac ON cre.cred_id = dac.cred_id " +
            $"LEFT JOIN SIIFI_aseguradora ase ON psc.idAseguradora = ase.No_Aseg " +
            $"LEFT JOIN SAC_agenciasTbl age ON dac.idAgencia = age.idAgencia " +
            $"LEFT JOIN SAC_promotoresTbl pro ON dac.idPromotor = pro.idPromotor " +
            $"LEFT JOIN SIIFI_fondos_y_bancos sfb ON cre.cvefonbco = sfb.cvefonbco " +
            $"LEFT JOIN catGeneralesTbl cgt ON psc.idEstatus = cgt.valor " +
            $"LEFT JOIN SAC_SiniestrosPolizasTbl ssp ON cre.cred_id = ssp.cred_id " +
            $"WHERE cre.cred_id = {id_cred} And cgt.tabla = 'SAC_PolizasSeguroCreditoTbl' And " +
            $"cgt.columna = 'idEstatus' AND psc.consecutivoPoliza = {consecutivo}";

        tabla = fnc.ObtenDataSet("obtenCampo", consulta, nomcon);

        if (tabla.Tables.Count > 0)
        {
            dtTipoDato = tabla.Tables[0];

            if (dtTipoDato.Rows.Count > 0)
            {
                foreach (DataRow row in dtTipoDato.Rows)
                {
                    txtCliente.Text = row["cliente"].ToString().Trim();
                    txtNoContrato.Text = row["contrato"].ToString().Trim();
                    txtAnexo.Text = row["anexo"].ToString().Trim();
                    txtVIN.Text = row["vin"].ToString().Trim();
                    txtAgencia.Text = row["agencia"].ToString().Trim();
                    txtPromotor.Text = row["promotor"].ToString().Trim();
                    txtEstatus.Text = row["estatus"].ToString().Trim();
                    txtFondeadora.Text = row["fondeadora"].ToString().Trim();

                    var idSiniestro = row["idSiniestro"]?.ToString().Trim();

                    if (string.IsNullOrWhiteSpace(idSiniestro))
                    {
                        rblSiniestro.Items.FindByValue("0").Selected = true;
                    }
                    else
                    {
                        rblSiniestro.Items.FindByValue("1").Selected = true;
                    }
                    
                    txtNoPoliza.Text = row["poliza"].ToString().Trim();

                    txtFechaEmision.Text = Convert.ToDateTime(row["fechaEmision"]).ToString("yyyy/MM/dd");
                    txtFechaVencimiento.Text = Convert.ToDateTime(row["fechaVencimiento"]).ToString("yyyy/MM/dd");
                    
                    txtCostoPolizaSinIVA.Text = row["importePrima"].ToString().Trim();
                    txtCostoPolizaSinIVA.DisplayFormatString = "c";

                    txtCostoTotal.Text = row["importeTotal"].ToString().Trim();
                    txtCostoTotal.DisplayFormatString = "c";

                    txtAseguradora.Text = row["nombre_aseg"].ToString().Trim();

                    txtUDI.Text = row["porcentajeUDI"].ToString().Trim();
                    txtUDI.DisplayFormatString = "p";

                    txtNoEndoso.Text = row["numeroEndoso"].ToString().Trim();
                    if (string.IsNullOrWhiteSpace(row["numeroEndoso"]?.ToString()))
                    {
                        txtEndoso.Text = "Pendiente";
                    }
                    else
                    {
                        txtEndoso.Text = "Realizado";
                    }
                    
                    txtComprara.Text = row["QuienCompra"].ToString().Trim();
                    txtAgente.Text = row["agenteSeguro"]?.ToString().Trim();

                    var referencia = row["referencia"].ToString();

                    if (!string.IsNullOrWhiteSpace(referencia))
                    {
                        txtCuentaContable.Text = referencia;
                    }

                    if (Regex.IsMatch(referencia, @"^\d{18}$"))
                    {
                        txtCuenta.Text = referencia.Substring(6, 11);
                    }
                    else
                    {
                        txtCuenta.Text = "No hay ninguna cuenta asociada.";
                    }

                    txtMarca.Text = row["marca"].ToString().Trim();
                    txtSubMarca.Text = row["subtipo"].ToString().Trim();
                    txtModelo.Text = row["modelo"].ToString().Trim();
                }
            }
            else
            {
                resultado = "No se encontró información para esa póliza.";
            }
        }
        else
        {
            resultado = "No se encontró información para esa póliza.";
        }
    }

    private void DeshabilitarControles()
    {
        this.txtAgencia.Enabled = false;
        this.txtAgente.Enabled = false;
        this.txtAnexo.Enabled = false;
        this.txtAseguradora.Enabled = false;
        this.txtCliente.Enabled = false;
        this.txtComprara.Enabled = false;
        this.txtCostoPolizaSinIVA.Enabled = false;
        this.txtCostoTotal.Enabled = false;
        this.txtCuenta.Enabled = false;
        this.txtCuentaContable.Enabled = false;
        this.txtEndoso.Enabled = false;
        this.txtEstatus.Enabled = false;
        this.txtFechaEmision.Enabled = false;
        this.txtFechaVencimiento.Enabled = false;
        this.txtFondeadora.Enabled = false;
        this.txtMarca.Enabled = false;
        this.txtModelo.Enabled = false;
        this.txtNoContrato.Enabled = false;
        this.txtNoEndoso.Enabled = false;
        this.txtNoPoliza.Enabled = false;
        this.txtPromotor.Enabled = false;
        this.txtSubMarca.Enabled = false;
        this.txtUDI.Enabled = false;
        this.txtVIN.Enabled = false;
    }

    private void HabilitarControles()
    {
        this.txtAgencia.Enabled = true;
        this.txtAgente.Enabled = true;
        this.txtAnexo.Enabled = true;
        this.txtAseguradora.Enabled = true;
        this.txtCliente.Enabled = true;
        this.txtComprara.Enabled = true;
        this.txtCostoPolizaSinIVA.Enabled = true;
        this.txtCostoTotal.Enabled = true;
        this.txtCuenta.Enabled = true;
        this.txtCuentaContable.Enabled = true;
        this.txtEndoso.Enabled = true;
        this.txtEstatus.Enabled = true;
        this.txtFechaEmision.Enabled = true;
        this.txtFechaVencimiento.Enabled = true;
        this.txtFondeadora.Enabled = true;
        this.txtMarca.Enabled = true;
        this.txtModelo.Enabled = true;
        this.txtNoContrato.Enabled = true;
        this.txtNoEndoso.Enabled = true;
        this.txtNoPoliza.Enabled = true;
        this.txtPromotor.Enabled = true;
        this.txtSubMarca.Enabled = true;
        this.txtUDI.Enabled = true;
        this.txtVIN.Enabled = true;
    }

}
