using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
//---------------------------------------
using System.Configuration;
using System.Data.Sql;
using System.Data.SqlClient;

using System.Drawing;
using System.Text;
using DevExpress.Web;
using DevExpress.Utils;
public partial class Funcionalidad_Frm_MonitorGeneralSeguros : System.Web.UI.Page
{
    private WsSeguridad.Seguridad Servicio = new WsSeguridad.Seguridad();
    WsFuncionalidad.Funcionalidad fnc = new WsFuncionalidad.Funcionalidad();
    public string vsistema = System.Configuration.ConfigurationManager.AppSettings["sistema"];
    public string vempresa = System.Configuration.ConfigurationManager.AppSettings["empresa"];

    String nomcon = "ConexionDBS";
    GridViewDataTextColumn ColumnaGrid = new GridViewDataTextColumn();
    GridViewCommandColumn ColumnaBtns = new GridViewCommandColumn();
    DataSet tabla = null;
    
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
        }
        LlenaGridMonitorSeguros();
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

                        if (ColumnaGrid.Caption == "Poliza")
                        {
                            //ColumnaGrid.CellStyle.ForeColor = Color.Green;
                            //ColumnaGrid.EditFormSettings.Visible = DefaultBoolean.False;
                            ColumnaGrid.ReadOnly = false;
                        }
                        if (ColumnaGrid.Caption == "importeTotal")
                        {
                            ColumnaGrid.CellStyle.ForeColor = Color.Red;
                            ColumnaGrid.PropertiesTextEdit.DisplayFormatString = "c";
                            ColumnaGrid.ReadOnly = false;
                        }
                    }
                    if (txtAcceso == "ELIMINAR")
                    {
                        // ColumnaGrid.ShowDeleteButton = true;
                    }
                    vRenglon = vRenglon + 1;
                    txtAccesosUsuario = txtAccesosUsuario + txtAcceso + "-";
                }
            }
            else
            {
                Response.Buffer = true;
                Response.Clear();
                Response.Redirect("../Framework/Acceso.aspx");
            }
        }
    }
    /// <summary>
    /// Configurar Grid View No Match
    /// </summary>
    public void LlenaGridMonitorSeguros()
    {
        DataSet tabla = new DataSet();
        DataTable dtOpciones = new DataTable();
        String vNombreColumna = "";
        String vfieldName = "";
        int NumeroColunas = 0;
        int NumeroRenglones = 0;
        ASPxSummaryItem footerCountf = new ASPxSummaryItem();
        ASPxSummaryItem footerTot = new ASPxSummaryItem();
        ASPxSummaryItem footerTot1 = new ASPxSummaryItem();
        GridViewDataTextColumn ColumnaGrid = new GridViewDataTextColumn();
        DataSet tablaDatVehiculo = new DataSet();
        DataTable dtDatVehiculo = new DataTable();

        var query = "SELECT psc.cred_id, max(psc.consecutivoPoliza) as consecutivoPoliza, cli.nombre as Cliente, dac.contrato, " +
            "dac.anexo, dac.VIN, age.nombre as Agencia, pro.nombre as Promotor, " +
            "sfb.nombre as Fondeadora, psc.numeroEndoso as Endoso, " +
            "CASE WHEN psc.idQuienCompra = 1 THEN 'DES' ELSE 'CTE' END as CompraA, " +
            "psc.fechaSolicitud, psc.poliza, psc.fechaEmision, psc.fechaVencimiento, " +
            "(psc.importeTotal - psc.importeIva) as importeSinIva, psc.importeIva, psc.importeTotal, " +
            "(select marca from dbo.Fn_Busca_Caracteristicas(dac.caracteristicas)) as marca, " +
            "(select modeloSubtipo from dbo.Fn_Busca_Caracteristicas(dac.caracteristicas)) as modelo, " +
            "cgt.descripcion as Estatus " +
            "FROM SAC_PolizasSeguroCreditoTbl psc " +
            "JOIN catGeneralesTbl cgt ON psc.idEstatus = cgt.valor " +
            "LEFT JOIN SAC_DatosAdicionalesCreditoTbl dac ON psc.cred_id = dac.cred_id " +
            "LEFT JOIN SAC_agenciasTbl age ON dac.idAgencia = age.idAgencia " +
            "LEFT JOIN SAC_promotoresTbl pro ON dac.idPromotor = pro.idPromotor " +
            "LEFT JOIN SIIFI_aseguradora ase ON psc.idAseguradora = ase.No_aseg " +
            "LEFT JOIN SIIFI_credito cred ON dac.cred_id = cred.cred_id " +
            "LEFT JOIN cliente cli ON cred.SOCIO_ID = cli.cliente_id " +
            "LEFT JOIN SIIFI_fondos_y_bancos sfb ON sfb.cvefonbco = cred.cvefonbco " +
            "WHERE cgt.tabla = 'SAC_PolizasSeguroCreditoTbl' And cgt.columna = 'idEstatus' " +
            "AND (psc.idEstatus <> 3 AND psc.idEstatus <> 4) " +
            "GROUP BY psc.cred_id, cli.nombre, dac.contrato, dac.anexo, dac.VIN, age.nombre, " +
            "pro.nombre, sfb.nombre, psc.numeroEndoso, psc.idQuienCompra, psc.fechaSolicitud, " +
            "psc.poliza, psc.fechaEmision, psc.fechaVencimiento, psc.importeIva, psc.importeTotal, " +
            "dac.caracteristicas, cgt.descripcion";

        tabla = fnc.ObtenDataSet("obtenCampo", query, nomcon);

        dtOpciones = tabla.Tables["Table"];
        
        //Columna de botones
        GridViewCommandColumn cmdCol1 = new GridViewCommandColumn();
        cmdCol1.ButtonRenderMode = GridCommandButtonRenderMode.Image;        
        cmdCol1.Caption = "Acción";
        
        //Boton Renovar
        GridViewCommandColumnCustomButton cmbtnRenovar = new GridViewCommandColumnCustomButton();
        cmbtnRenovar.ID = "BTNRenovar";
        cmbtnRenovar.Text = "Ver detalles";
        cmbtnRenovar.Visibility = GridViewCustomButtonVisibility.AllDataRows;
        cmbtnRenovar.Image.Url = "../Imagenes/editar.png";
        cmbtnRenovar.Image.Width = Unit.Pixel(16);

        ////Boton Cancelar
        //GridViewCommandColumnCustomButton cmbtnCancelar = new GridViewCommandColumnCustomButton();
        //cmbtnCancelar.ID = "BTNCancelar";
        //cmbtnCancelar.Text = "Cancelar";
        //cmbtnCancelar.Visibility = GridViewCustomButtonVisibility.AllDataRows;
        //cmbtnCancelar.Image.Url = "../Imagenes/editar.png";
        //cmbtnCancelar.Image.Width = Unit.Pixel(16);

        ////Boton Agregar Endoso
        //GridViewCommandColumnCustomButton cmbtnAgregarEndoso = new GridViewCommandColumnCustomButton();
        //cmbtnAgregarEndoso.ID = "BTNAgregarEndoso";
        //cmbtnAgregarEndoso.Text = "AgregarEndoso";
        //cmbtnAgregarEndoso.Visibility = GridViewCustomButtonVisibility.AllDataRows;
        //cmbtnAgregarEndoso.Image.Url = "../Imagenes/editar.png";
        //cmbtnAgregarEndoso.Image.Width = Unit.Pixel(16);

        //Boton no utilizado
        //GridViewCommandColumnCustomButton cDetailBtn1 = new GridViewCommandColumnCustomButton();
        //cDetailBtn1.ID = "BTNNuevo";
        //cDetailBtn1.Text = "Nuevo Registro";
        //cDetailBtn1.Visibility = GridViewCustomButtonVisibility.FilterRow;
        //cDetailBtn1.Image.Url = "../Imagenes/New_.png";
        //cDetailBtn1.Image.Width = Unit.Pixel(23);

        cmdCol1.CustomButtons.Add(cmbtnRenovar);//, cmbtnCancelar, cmbtnAgregarEndoso);//, cDetailBtn1);

        gvMonitorSeg.Columns.Clear();

        if (tabla.Tables.Count > 0)
        {
            if (tabla.Tables[0].Rows.Count > 0)
            {
                NumeroColunas = tabla.Tables[0].Columns.Count - 1;
                NumeroRenglones = tabla.Tables[0].Rows.Count - 1;

                for (int j = 0; j <= tabla.Tables[0].Columns.Count - 1; j++)
                {
                    vNombreColumna = tabla.Tables[0].Columns[j].ColumnName;
                    vfieldName = tabla.Tables[0].Columns[j].ColumnName;
                    ColumnaGrid = new GridViewDataTextColumn();
                    ColumnaGrid.Caption = vNombreColumna;
                    
                    if (ColumnaGrid.Caption == "cred_id" || ColumnaGrid.Caption == "consecutivoPoliza")
                    {
                        ColumnaGrid.ReadOnly = true;                       
                        ColumnaGrid.Visible = false;
                    }
                    if (ColumnaGrid.Caption == "importeSinIva" || ColumnaGrid.Caption == "importeTotal" || ColumnaGrid.Caption== "importeIva")
                    {
                        ColumnaGrid.PropertiesTextEdit.DisplayFormatString = "c";
                    }

                    ColumnaGrid.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                    ColumnaGrid.FieldName = vfieldName;
                    gvMonitorSeg.Columns.Add(ColumnaGrid);
                }
            }
        }
        if (tabla.Tables.Count > 0)
        {
            if (tabla.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow row in tabla.Tables[0].Rows)
                {
                    if((DateTime.Now.AddDays(30) <= Convert.ToDateTime(row["fechaVencimiento"].ToString())) &&
                        row["Estatus"].ToString() == "Vigente")
                    {
                        row["Estatus"] = "En proceso de renovación";
                    }
                }
                

                gvMonitorSeg.DataSource = tabla;
                gvMonitorSeg.DataBind();
                gvMonitorSeg.KeyFieldName = "cred_id";
                
                gvMonitorSeg.Caption = "- Monitor General de Seguros -";
                cmdCol1.FixedStyle = GridViewColumnFixedStyle.Left;
                gvMonitorSeg.Columns.Add(cmdCol1);                
            }
        }
    }
}