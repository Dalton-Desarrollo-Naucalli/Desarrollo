using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
//--------------------------------
//using DevExpress.Web.ASPxUploadControl;
using System.IO;
using System.Xml;
using System.Data;
//---------------------------------------
using System.Configuration;
using System.Data.Sql;
using System.Data.SqlClient;

using System.Drawing;
using System.Text;
//using Ionic.Zip;
using DevExpress.Web;
using DevExpress.Utils;
using System.Collections.Specialized;
using System.Globalization;

public partial class Funcionalidad_BURSA_WfdevolucionesBURSA : System.Web.UI.Page
{

    static int IdUsuario;
    private WsSeguridad.Seguridad Servicio = new WsSeguridad.Seguridad();
    WsFuncionalidad.Funcionalidad fnc = new WsFuncionalidad.Funcionalidad();
    
    public string vsistema = System.Configuration.ConfigurationManager.AppSettings["sistema"];
    public string vempresa = System.Configuration.ConfigurationManager.AppSettings["empresa"];
    static int credV = 0;
    static int obligV = 0;

    #region VARIABLES

    String nomcon = "ConexionDBS";
    DataSet tabla = new DataSet();
    DataTable dtTipoDato = new DataTable();
    DataSet tablaDatVehiculo = new DataSet();
    DataTable dtDatVehiculo = new DataTable();

    GridViewCommandColumn ColumnaBtns = new GridViewCommandColumn();
    GridViewDataTextColumn ColumnaGrid = new GridViewDataTextColumn();
    GridViewDataCheckColumn chbox = new GridViewDataCheckColumn();

    #endregion

    #region PAGELOAD
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["iIdUsuario"] == null)
            {
                IdUsuario = 0;
            }
            else
            {
                IdUsuario = int.Parse(Session["iIdUsuario"].ToString());
            }

            if (Session["sCliente"] == null)
            {
                Response.Buffer = true;
                Response.Clear();
                Response.Redirect("../Framework/Acceso.aspx");
            }
            VerificaAccesos("WfdevolucionesBURSA");
            //this.ConstruyeGridDevolucion();
            this.gv_DevolucionesBursa.DataBind();
            //this.Consultar();
            
        }
        else
        {
            this.Consultar();            

        }
    }

    #endregion

    #region FUNCIONES

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

                        if (ColumnaGrid.Caption == "ConfirmarPago")
                        {
                            ColumnaGrid.Visible = false;
                            chbox.FieldName = "ConfirmarPago";
                            chbox.PropertiesEdit.ClientInstanceName = "chbConfirmarPago";

                            chbox.ReadOnly = false;
                            // gvFacSeg.Columns.Add(chbox);
                        }
                    }

                    if (txtAcceso == "ELIMINAR")
                    {
                        // ColumnaGrid.ShowDeleteButton = true;
                    }

                    vRenglon = vRenglon + 1;
                    txtAccesosUsuario = txtAccesosUsuario + txtAcceso + "-";

                    this.lblAccesos.Text = txtAccesosUsuario;
                }
            }
            else
            {
                this.lblAccesos.Text = "Su usuario no tiene acceso a este formaulario...";
                Response.Buffer = true;
                Response.Clear();
                Response.Redirect("../Framework/Acceso.aspx");
                Response.Redirect("../Framework/Acceso.aspx");
            }
        }
    }

    private void ConstruyeGridDevolucion()
    {

    }

    private void Consultar()
    {
        try
        {
            //DataSet DS;
            //DS = fnc.TraeDatosConsulta("Select 0 as ID, ' SELECCIONAR...' as NombreF union all Select idbanco as ID, ID_formaliq_TR as NombreF from bancos order by NombreF", "ConexionDBS");
            int IdUsuario = 0;
            if (Session["iIdUsuario"] == null)
            {
                IdUsuario = 0;
            }
            else
            {
                IdUsuario = int.Parse(Session["iIdUsuario"].ToString());
            }
            DataTable model = MostrarDevolucionesBursa(IdUsuario: IdUsuario, FechaCorte: FechaCorteP).Tables[0];
            gv_DevolucionesBursa.DataSource = model;
            gv_DevolucionesBursa.DataBind();
            if (model.Rows.Count == 0)
                messages(1);





        }
        catch (Exception ex)
        {

            throw (ex);
        }
    }

    

    private DataSet MostrarDevolucionesBursa(int IdUsuario, DateTime? FechaCorte = null)
    {
        DataSet ds = new DataSet();

        using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString))
        {
            try
            {
                con.Open();
                SqlCommand command = new SqlCommand("Spc_SAC_DevolucionesBursa", con);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@PnIdUsuarioAct", IdUsuario));
                if (FechaCorte != null)
                {
                    command.Parameters.Add(new SqlParameter("@PdFechaCorte", FechaCorte));
                }
                else
                    command.Parameters.Add(new SqlParameter("@PdFechaCorte", Convert.ToDateTime("01/11/2017")));

                

                SqlDataAdapter sda = new SqlDataAdapter();
                sda.SelectCommand = command;
                sda.Fill(ds);
                con.Close();
                con.Dispose();
            }
            catch (Exception ex)
            {
                con.Close();
                con.Dispose();
            }
        }//using
        return ds;
    }   

    protected void messages(short TipoMensaje, string MensajeError = "")
    {
        string titulo = "Devoluciones BURSA";
        string mensaje = String.Empty;
        string tipoMen = String.Empty;

        switch (TipoMensaje)
        {
            case 1:
                mensaje = "No se encontraron registros";
                tipoMen = "info";
                break;
            case 2:
                mensaje = "Se ha agregado el registro";
                tipoMen = "success";
                break;
            case 3:
                mensaje = "Se ha actualizado el registro";
                tipoMen = "success";
                break;
            case 4:
                mensaje = "Se ha eliminado el registro";
                tipoMen = "success";
                break;
            case 5:
                mensaje = "Se han eliminado los registros";
                tipoMen = "success";
                break;
            case 6:
                mensaje = "Se ha producido un error al intentar eliminar el registro";
                tipoMen = "error";
                break;
            case 7:
                mensaje = MensajeError;
                tipoMen = "error";
                break;

        }

        ClientScript.RegisterStartupScript(this.GetType(), "Devoluciones", "<script>javascript:ShowMessage('" + tipoMen + "','" + mensaje.Replace("'", "") + "','" + titulo + "');</script>");
    }

    #endregion

    #region EVENTOS    

    protected void gv_DevolucionesBursa_CustomCallback(object sender, DevExpress.Web.ASPxGridViewCustomCallbackEventArgs e)
    {
        string[] Parametros = e.Parameters.Split(';');

        if (e.Parameters.Equals("Buscar"))
        {

            gv_DevolucionesBursa.DataSource = null;
            gv_DevolucionesBursa.DataBind();
            //gv_DevolucionesBursa.Selection.UnselectAll();
            this.Consultar();
        }

        if (e.Parameters.Equals("grdCancela"))
        {

            gv_DevolucionesBursa.DataSource = null;
            gv_DevolucionesBursa.DataBind();
            //gv_DevolucionesBursa.Selection.UnselectAll();

        }

        gv_DevolucionesBursa.SearchPanelFilter = String.Empty;
        Parametros = null;
    }  

    #endregion

    #region JSON

    [System.Web.Services.WebMethod]
    public static object CargaClientes()
    {

        try
        {
            object query = new object();
            DataSet DS;
            DS = new DataSet();
            DataTable dtCliente = new DataTable();

            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString))
            {
                try
                {
                    con.Open();
                    SqlCommand command = new SqlCommand("spc_consultacombosgenerales", con);
                    command.CommandType = System.Data.CommandType.StoredProcedure;
                    command.Parameters.Add(new SqlParameter("@PnIdUsuario", IdUsuario));
                    command.Parameters.Add(new SqlParameter("@PnIdOpcion", 3));
                    SqlDataAdapter sda = new SqlDataAdapter();
                    sda.SelectCommand = command;
                    sda.Fill(DS);
                    con.Close();
                    con.Dispose();
                }
                catch (Exception ex)
                {
                    con.Close();
                    con.Dispose();
                }
            }//using




            dtCliente = DS.Tables[0];
            List<DataRow> list = dtCliente.AsEnumerable().ToList();


            query = from c in list
                    select new
                    {
                        //valor = c.Table.Rows[0],
                        //descripcion = c.Table.Rows[1]
                        valor = c.ItemArray[0].ToString(),
                        descripcion = c.ItemArray[1].ToString()

                    };

            //    cbxCliente.DataSource = paConCombosGenerales(IdUsuario, 1);
            //    cbxCliente.DataTextField = "Nombre";
            //    cbxCliente.DataValueField = "EntidadFed_ID";
            //    cbxCliente.DataBind();
            //    cbxCliente.Items.Insert(0, new ListItem("", "0"));

            //    //object fncion = new object();
                //fncion = new WsFuncionalidad.Funcionalidad();





            //    'Se llena el combo Moneda
            //DS = fncion.("Select 0 as ID, ' SELECCIONAR...' as NombreF union all Select idbanco as ID, ID_formaliq_TR as NombreF from bancos order by NombreF", "ConexionDBS")
            //'Combo 

            //Me.cmbLiquidDefaultTR.DataSource = DS
            //Me.cmbLiquidDefaultTR.ValueField = "ID"
            //Me.cmbLiquidDefaultTR.TextField = "Nombref"
            //Me.cmbLiquidDefaultTR.DataBind()
            //Me.cmbLiquidDefaultTR.SelectedIndex = 0


            //    SqlResult error = new SqlResult();
            //    Nomina.Rhin.Entities.Common.FiltroConsultanomGruposPago filtro = new Nomina.Rhin.Entities.Common.FiltroConsultanomGruposPago();
            //    filtro.IdUsuarioAct = usuario;
            //    filtro.IdEstatus = 1;

            //    List<Nomina.Rhin.Entities.Catalogo.nomGruposPago> grupopago = Nomina.Rhin.Business.Catalogo.nomGruposPago.ObtenerGruposRelLaboral("rhin", filtro, ref error);

            //    if (error.Estatus > 0)
            //    {
            //        return null;


            //    }


            //    query = from c in grupopago
            //            select new
            //            {
            //                valor = c.idGrupoPago,
            //                descripcion = c.grupoPago
            //            };


            return Newtonsoft.Json.JsonConvert.SerializeObject(query);
        }
        catch (Exception ex)
        {

            throw (ex);
        }

    }

    #endregion

    #region PROPIEDADES

    private DateTime? FechaCorteP
    {
        get
        {
            if (this.dteFechaCorte.Text != String.Empty)
                return Convert.ToDateTime(this.dteFechaCorte.Text.Trim());
            else
                return null;
        }

    }

    #endregion


}