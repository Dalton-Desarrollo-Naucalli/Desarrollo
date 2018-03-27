using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
//--------------------------------
//using DevExpress.Web.ASPxUploadControl;
using System.Data;
//---------------------------------------
using System.Data.SqlClient;
using System.Drawing;
//using Ionic.Zip;
using DevExpress.Web;
using System.Data.Linq;
using System.Linq;



public partial class Funcionalidad_BURSA_WfrentpendBURSA : System.Web.UI.Page
{
    static int IdUsuario;
    private WsSeguridad.Seguridad Servicio = new WsSeguridad.Seguridad();
    WsFuncionalidad.Funcionalidad fnc = new WsFuncionalidad.Funcionalidad();
    public string vsistema = System.Configuration.ConfigurationManager.AppSettings["sistema"];
    public string vempresa = System.Configuration.ConfigurationManager.AppSettings["empresa"];
    static int credV = 0;
    static int obligV = 0;
    static List<string> lmsg = new List<string>();

    #region VARIABLES


    GridViewCommandColumn ColumnaBtns = new GridViewCommandColumn();
    GridViewDataTextColumn ColumnaGrid = new GridViewDataTextColumn();
    GridViewDataCheckColumn chbox = new GridViewDataCheckColumn();
    GridViewDataComboBoxColumn ColumnaCombo = new GridViewDataComboBoxColumn();
    GridViewDataComboBoxColumn ColumnaCombo2 = new GridViewDataComboBoxColumn();
    ListBoxColumn l_ValueField = new ListBoxColumn();
    GridViewColumn ValueFieldC;
    GridViewColumn TextFieldC;


    string cadena = "";
    string consulta = "";
    string Resultado = "";
    string cat = "";
    string pseudo;
    string Errpseudo = "";
    string colum = "";
    int NumeroColumnas = 0;
    int NumeroRenglones = 0;
    object vNombreColumna;
    object vfieldName;
    DataSet DSTipoDato = new DataSet();
    DataTable dtTipoDato = new DataTable();
    DataTable dtOpciones;
    DataRow drOpciones;
    GridViewDataTextColumn ColumnaGridt = new GridViewDataTextColumn();
    //  PARA EL TEXTO (ENCABEZADO) EN EL GRID
    object fncion = new WsFuncionalidad.Funcionalidad();
    DataSet tabla = new DataSet();
    bool campo;


    String nomcon = "ConexionDBS";   
    DataSet tablaDatVehiculo = new DataSet();
    DataTable dtDatVehiculo = new DataTable();

    

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
            VerificaAccesos("WfrentpendBURSA");
            this.Consultar();
            this.gv_TraspasoBursa.DataBind();
            //this.gv_FacRtasPend.DataBind();
        }
        else
        {
            this.Consultar();
            if (tsFacturasBURSA.ActiveTabIndex == 1)
                this.ConsultaTraspaso(credV + ";" + obligV);

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
        //l_ValueField.FieldName = "algofield";
        //ColumnaCombo.Columns.Add(l_ValueField)
        //ValueFieldC.Caption = "ALGO";
        //ValueFieldC.Name = "ALGO2";

        //ColumnaCombo.Columns.Add(ValueFieldC);
    }

    private void Consultar()
    {
        try
        {
            int IdUsuario = 0;
            if (Session["iIdUsuario"] == null)
            {
                IdUsuario = 0;
            }
            else
            {
                IdUsuario = int.Parse(Session["iIdUsuario"].ToString());
            }
            DataTable model = MostrarClientesBursaContratoVencido(IdUsuario: IdUsuario, IdCliente: IDClienteP, Contrato: ContratoP, Anexo: AnexoP, Vencidas: FacturaVencidaP).Tables[0];
            gv_FacRtasPend.DataSource = model;
            gv_FacRtasPend.DataBind();
            if (model.Rows.Count == 0)
                //messages(1);
                MensajeConsulta(1);





        }
        catch (Exception ex)
        {

            throw (ex);
        }
    }

    private void ConsultarAdicionales()
    {
        try
        {
            int IdUsuario = 0;
            if (Session["iIdUsuario"] == null)
            {
                IdUsuario = 0;
            }
            else
            {
                IdUsuario = int.Parse(Session["iIdUsuario"].ToString());
            }
            DataTable model = MostrarClientesBursaContratoVencido(IdUsuario: IdUsuario, IdCliente: IDClienteP, Contrato: ContratoP, Anexo: AnexoP, Vencidas: FacturaVencidaP).Tables[0];

        
            //gv_FacRtasPend.DataSource = model;
            //gv_FacRtasPend.DataBind();
            if (model.Rows.Count == 0)
                //messages(1);
                MensajeConsulta(1);
            else
            {
                var queryLinq = from facturas in model.AsEnumerable()
                                 //where facturas.Field<byte>("adicional") == 1
                                 select new
                                 {
                                     idcliente = facturas.Field<int>("idcliente"),
                                     nombreCliente = facturas.Field<string>("nombreCliente"),
                                     contrato = facturas.Field<string>("contrato"),
                                     anexo = facturas.Field<string>("anexo"),
                                     idCredito = facturas.Field<int>("idCredito"),
                                     idObligacion = facturas.Field<int>("idObligacion"),
                                     factura = facturas.Field<int>("factura"),
                                     fechaVencimiento = facturas.Field<DateTime>("fechaVencimiento"),
                                     importe = facturas.Field<decimal>("importe"),
                                     diasVencidos = facturas.Field<int>("diasVencidos"),
                                     totalCuotas = facturas.Field<int>("totalCuotas"),
                                     cuota = facturas.Field<string>("cuota"),
                                     adicional = facturas.Field<byte>("adicional")
                                 };
                //DataTable queryLinq = from facturas in model.AsEnumerable()
                //                where facturas.Field<byte>("adicional") == 1
                //                select facturas;

                gv_FacAdicionales.DataSource = queryLinq;
                gv_FacAdicionales.DataBind();
            }





        }
        catch (Exception ex)
        {

            throw (ex);
        }
    }

    private void ConsultaTraspaso(string parametros = "")
    {
        try
        {
            string[] Parametros = parametros.Split(';');
            int IdUsuario = 0;
            if (Session["iIdUsuario"] == null)
            {
                IdUsuario = 0;
            }
            else
            {
                IdUsuario = int.Parse(Session["iIdUsuario"].ToString());
            }
            DataTable modelT = MostrarTraspasosBURSA(IdUsuario: IdUsuario, Cred_id: Convert.ToInt32(Parametros[0].ToString()), Obligacion_id: Convert.ToInt32(Parametros[1].ToString()), FechaSolicitudTraspaso: null, UsuarioSolicitoTraspaso: "", FechaAutorizacionTraspaso: null, UsuarioAutorizoTraspaso: "", FechaConfirmacionSET: null, NumMovimientoSET: 0, IdOpcion: 3, UltActual: null, IpAct: "").Tables[0];
            gv_TraspasoBursa.DataSource = modelT;
            gv_TraspasoBursa.DataBind();
            if (modelT.Rows.Count == 0)
                messages(1);



        }
        catch (Exception ex)
        {

            throw (ex);
        }
    }

    private DataSet MostrarClientesBursaContratoVencido(int IdUsuario, int IdCliente = 0, string Contrato = "", string Anexo = "", byte Vencidas = 0)
    {
        DataSet ds = new DataSet();

        using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString))
        {
            try
            {
                con.Open();
                SqlCommand command = new SqlCommand("Spc_clienteBursaContratoVencido", con);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@PnIdUsuarioAct", IdUsuario));
                if (IdCliente > 0)
                {
                    command.Parameters.Add(new SqlParameter("@PnIdCliente", IdCliente));
                }
                else
                    command.Parameters.Add(new SqlParameter("@PnIdCliente", DBNull.Value));

                if (Contrato != "")
                {
                    command.Parameters.Add(new SqlParameter("@PsContrato", Contrato));
                }
                else
                    command.Parameters.Add(new SqlParameter("@PsContrato", DBNull.Value));

                if (Anexo != "")
                {
                    command.Parameters.Add(new SqlParameter("@PsAnexo", Anexo));
                }
                else
                    command.Parameters.Add(new SqlParameter("@PsAnexo", DBNull.Value));

                command.Parameters.Add(new SqlParameter("@PbTipoConsulta", Vencidas));

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

    private DataSet MostrarTraspasosBURSA(int IdUsuario, int Cred_id = 0, int Obligacion_id = 0, DateTime? FechaSolicitudTraspaso = null, string UsuarioSolicitoTraspaso = "", DateTime? FechaAutorizacionTraspaso = null, string UsuarioAutorizoTraspaso = "", DateTime? FechaConfirmacionSET = null, int NumMovimientoSET = 0, int IdOpcion = 0, DateTime? UltActual = null, string IpAct = "")
    {
        DataSet ds = new DataSet();

        using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString))
        {
            try
            {
                con.Open();
                SqlCommand command = new SqlCommand("Spc_SAC_ControlTraspasosBursaTbl", con);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@PnIdUsuarioAct", IdUsuario));
                if (Cred_id > 0)
                {
                    command.Parameters.Add(new SqlParameter("@PnCred_id", Cred_id));
                }
                else
                    command.Parameters.Add(new SqlParameter("@PnCred_id", DBNull.Value));

                if (Obligacion_id > 0)
                {
                    command.Parameters.Add(new SqlParameter("@PnObligacion_id", Obligacion_id));
                }
                else
                    command.Parameters.Add(new SqlParameter("@PnObligacion_id", DBNull.Value));

                if (FechaSolicitudTraspaso != null)
                {
                    command.Parameters.Add(new SqlParameter("@PdFechaSolicitudTraspaso", FechaSolicitudTraspaso));
                }
                else
                    command.Parameters.Add(new SqlParameter("@PdFechaSolicitudTraspaso", DBNull.Value));

                if (UsuarioSolicitoTraspaso != "")
                {
                    command.Parameters.Add(new SqlParameter("@PsUsuarioSolicitoTraspaso", UsuarioSolicitoTraspaso));
                }
                else
                {
                    command.Parameters.Add(new SqlParameter("@PsUsuarioSolicitoTraspaso", DBNull.Value));
                }

                if (FechaAutorizacionTraspaso != null)
                {
                    command.Parameters.Add(new SqlParameter("@PdFechaAutorizacionTraspaso", FechaAutorizacionTraspaso));
                }
                else
                    command.Parameters.Add(new SqlParameter("@PdFechaAutorizacionTraspaso", DBNull.Value));

                if (UsuarioAutorizoTraspaso != "")
                {
                    command.Parameters.Add(new SqlParameter("@PsUsuarioAutorizoTraspaso", UsuarioAutorizoTraspaso));
                }
                else
                {
                    command.Parameters.Add(new SqlParameter("@PsUsuarioAutorizoTraspaso", DBNull.Value));
                }

                if (FechaConfirmacionSET != null)
                {
                    command.Parameters.Add(new SqlParameter("@PdFechaConfirmacionSET", FechaConfirmacionSET));
                }
                else
                    command.Parameters.Add(new SqlParameter("@PdFechaConfirmacionSET", DBNull.Value));

                if (NumMovimientoSET > 0)
                {
                    command.Parameters.Add(new SqlParameter("@PnNumMovimientoSET", NumMovimientoSET));
                }
                else
                    command.Parameters.Add(new SqlParameter("@PnNumMovimientoSET", DBNull.Value));

                if (IdOpcion > 0)
                {
                    command.Parameters.Add(new SqlParameter("@PnIdOpcion", IdOpcion));
                }
                else
                    command.Parameters.Add(new SqlParameter("@PnIdOpcion", DBNull.Value));

                if (UltActual != null)
                {
                    command.Parameters.Add(new SqlParameter("@PdUltActual", UltActual));
                }
                else
                    command.Parameters.Add(new SqlParameter("@PdUltActual", DBNull.Value));

                if (IpAct != "")
                {
                    command.Parameters.Add(new SqlParameter("@PsIpAct", IpAct));
                }
                else
                {
                    command.Parameters.Add(new SqlParameter("@PsIpAct", DBNull.Value));
                }

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
        string titulo = "BURSA";
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

        ClientScript.RegisterStartupScript(this.GetType(), "BURSA", "<script>javascript:ShowMessage('" + tipoMen + "','" + mensaje.Replace("'", "") + "','" + titulo + "');</script>");
    }

    protected void MensajeConsulta(int TipoMensajeC, string MensajeErrorC = "")
    {

        string mensajeC = String.Empty;
        string tipoMenC = String.Empty;
        switch (TipoMensajeC)
        {
            case 1:
                mensajeC = "No se encontraron registros";
                tipoMenC = "info";
                break;
            case 7:
                mensajeC = MensajeErrorC;
                tipoMenC = "error";
                break;

        }
        lmsg.Add(mensajeC.Replace("'", "") + "/" + tipoMenC);
    }

    #endregion

    #region EVENTOS

    protected void gv_FacRtasPend_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
    {
        string[] Parametros = e.Parameters.Split(';');

        if (e.Parameters.Equals("Buscar"))
        {

            gv_FacRtasPend.DataSource = null;
            gv_FacRtasPend.DataBind();
            //gv_FacRtasPend.Selection.UnselectAll();
            this.Consultar();
            //this.ConsultarAdicionales();
        }

        if (e.Parameters.Equals("grdCancela"))
        {

            gv_FacRtasPend.DataSource = null;
            gv_FacRtasPend.DataBind();
            //gv_FacRtasPend.Selection.UnselectAll();

        }

        gv_FacRtasPend.SearchPanelFilter = String.Empty;
        Parametros = null;
    }

    protected void gv_TraspasoBursa_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
    {
        string[] Parametros = e.Parameters.Split(',');

        if (e.Parameters.Contains("BuscarTraspaso"))
        {
            if (Parametros[1] == "undefined")
            {
                credV = 0;
                obligV = 0;
            }
            else
            {
                string[] Param = Parametros[1].Split(';');
                credV = Convert.ToInt32(Param[0].ToString());
                obligV = Convert.ToInt32(Param[1].ToString());
            }
            gv_TraspasoBursa.DataSource = null;
            gv_TraspasoBursa.DataBind();
            gv_TraspasoBursa.Selection.UnselectAll();
            if (Parametros[1] == "undefined")
                this.ConsultaTraspaso("0;0");
            else
                this.ConsultaTraspaso(Parametros[1]);
        }

        if (e.Parameters.Equals("grdCancelaTraspaso"))
        {

            gv_TraspasoBursa.DataSource = null;
            gv_TraspasoBursa.DataBind();
            gv_TraspasoBursa.Selection.UnselectAll();

        }

        gv_TraspasoBursa.SearchPanelFilter = String.Empty;
        Parametros = null;
    }

    protected void cbAutorizar_Callback(object source, CallbackEventArgs e)
    {
        string[] Parametros = e.Parameter.Split(',');
        int cred_idV = Convert.ToInt32(Parametros[0]);
        int obligacion_idV = Convert.ToInt32(Parametros[2]);
        string FechaCompuesta = String.Empty;
        DateTime FechaSolTrasV;
        FechaCompuesta = Parametros[4].Substring(0, 24);
        FechaSolTrasV = DateTime.Parse(FechaCompuesta);
        FechaCompuesta = String.Empty;
        short userSolV = 40;



        int IdUsuario = 0;
        if (Session["iIdUsuario"] == null)
        {
            IdUsuario = 0;
        }
        else
        {
            IdUsuario = int.Parse(Session["iIdUsuario"].ToString());
        }
        using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString))
        {
            try
            {
                con.Open();
                #region Inserta 
                using (SqlCommand cmd = new SqlCommand("Spu_SAC_ControlTraspasosBursaTbl", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@PnCred_id", SqlDbType.Int).Value = cred_idV;
                    cmd.Parameters.Add("@PnObligacion_id", SqlDbType.Int).Value = txtNumObligación.Text;
                    cmd.Parameters.Add("@PdFechaSolicitudTraspaso", SqlDbType.DateTime).Value = dteFechaTraspaso.Text;
                    cmd.Parameters.Add("@PnIdUsuarioSolicitoTraspaso", SqlDbType.SmallInt).Value = userSolV;
                    cmd.Parameters.Add("@PdFechaAutorizacionTraspaso", SqlDbType.DateTime).Value = dteFechaTraspaso.Text;
                    cmd.Parameters.Add("@PnIdUsuarioAutorizoTraspaso", SqlDbType.SmallInt).Value = IdUsuario;
                    cmd.Parameters.Add("@PdFechaConfirmacionSET", SqlDbType.DateTime).Value = DBNull.Value;
                    cmd.Parameters.Add("@PnNumMovimientoSET", SqlDbType.Int).Value = DBNull.Value;
                    cmd.Parameters.Add("@PnIdOpcion", SqlDbType.Int).Value = 3;
                    cmd.Parameters.Add("@PnIdUsuarioAct", SqlDbType.SmallInt).Value = IdUsuario;
                    cmd.Parameters.Add("@PsIpAct", SqlDbType.VarChar).Value = Request.ServerVariables["REMOTE_ADDR"].ToString();

                    cmd.Parameters.Add("@PnEstatus", SqlDbType.Int).Value = 0;
                    cmd.Parameters.Add("@PsMensaje", SqlDbType.VarChar).Value = "";
                    cmd.Parameters["@PnEstatus"].Direction = ParameterDirection.Output;
                    cmd.Parameters["@PsMensaje"].Direction = ParameterDirection.Output;
                    cmd.ExecuteScalar();
                    cmd.Dispose();
                }
                #endregion


            }
            catch (Exception ex)
            {
                con.Close();
                con.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
    }

    protected void cbSolicitar_Callback(object source, CallbackEventArgs e)
    {
        int IdUsuario = 0;
        if (Session["iIdUsuario"] == null)
        {
            IdUsuario = 0;
        }
        else
        {
            IdUsuario = int.Parse(Session["iIdUsuario"].ToString());
        }
        using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString))
        {
            try
            {
                con.Open();
                #region Inserta 
                using (SqlCommand cmd = new SqlCommand("Spa_SAC_ControlTraspasosBursaTbl", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@PnCred_id", SqlDbType.Int).Value = credV;
                    cmd.Parameters.Add("@PnObligacion_id", SqlDbType.Int).Value = txtNumObligación.Text;
                    cmd.Parameters.Add("@PdFechaSolicitudTraspaso", SqlDbType.DateTime).Value = dteFechaTraspaso.Text;
                    cmd.Parameters.Add("@PnIdUsuarioSolicitoTraspaso", SqlDbType.SmallInt).Value = IdUsuario;
                    cmd.Parameters.Add("@PdFechaAutorizacionTraspaso", SqlDbType.DateTime).Value = DBNull.Value;
                    cmd.Parameters.Add("@PnIdUsuarioAutorizoTraspaso", SqlDbType.SmallInt).Value = DBNull.Value;
                    cmd.Parameters.Add("@PdFechaConfirmacionSET", SqlDbType.DateTime).Value = DBNull.Value;
                    cmd.Parameters.Add("@PnNumMovimientoSET", SqlDbType.Int).Value = DBNull.Value;
                    cmd.Parameters.Add("@PnIdOpcion", SqlDbType.Int).Value = 3;
                    cmd.Parameters.Add("@PnIdUsuarioAct", SqlDbType.SmallInt).Value = IdUsuario;
                    cmd.Parameters.Add("@PsIpAct", SqlDbType.VarChar).Value = Request.ServerVariables["REMOTE_ADDR"].ToString();

                    cmd.Parameters.Add("@PnEstatus", SqlDbType.Int).Value = 0;
                    cmd.Parameters.Add("@PsMensaje", SqlDbType.VarChar).Value = "";
                    cmd.Parameters["@PnEstatus"].Direction = ParameterDirection.Output;
                    cmd.Parameters["@PsMensaje"].Direction = ParameterDirection.Output;
                    cmd.ExecuteScalar();
                    cmd.Dispose();
                }
                #endregion


            }
            catch (Exception ex)
            {
                con.Close();
                con.Dispose();
            }
            finally
            {
                con.Close();
                con.Dispose();
            }
        }
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
                    string queryc = "select cliente_id, nombre from cliente";

                    SqlCommand cmd = new SqlCommand(queryc, con);

                    SqlDataAdapter sda = new SqlDataAdapter();
                    sda.SelectCommand = cmd;
                    sda.Fill(DS);
                    con.Close();
                    con.Dispose();

                    //con.Open();
                    //SqlCommand command = new SqlCommand("spc_consultacombosgenerales", con);
                    //command.CommandType = System.Data.CommandType.StoredProcedure;
                    //command.Parameters.Add(new SqlParameter("@PnIdUsuario", IdUsuario));
                    //command.Parameters.Add(new SqlParameter("@PnIdOpcion", 3));
                    //SqlDataAdapter sda = new SqlDataAdapter();
                    //sda.SelectCommand = command;
                    //sda.Fill(DS);
                    //con.Close();
                    //con.Dispose();
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

                        valor = c.ItemArray[0].ToString(),
                        descripcion = c.ItemArray[1].ToString()

                    };


            //DataSet DSc;
            //using (SqlConnection conn = new SqlConnection("ConexionDBS"))
            //{
            //    string queryc = "select id, desc from <tabla>";

            //    SqlCommand cmd = new SqlCommand(queryc, conn);

            //    SqlDataAdapter da = new SqlDataAdapter(cmd);
            //    da.Fill(dt);
            //}

            //combobox1.DisplayMember = "desc";
            //combobox1.ValueMember = "id";
            //combobox1.Datasource = dt;

            //DSc = fncion.("Select 0 as ID, ' SELECCIONAR...' as NombreF union all Select idbanco as ID, ID_formaliq_TR as NombreF from bancos order by NombreF", "ConexionDBS")

            //    cbxCliente.DataSource = paConCombosGenerales(IdUsuario, 1);
            //    cbxCliente.DataTextField = "Nombre";
            //    cbxCliente.DataValueField = "EntidadFed_ID";
            //    cbxCliente.DataBind();
            //    cbxCliente.Items.Insert(0, new ListItem("", "0"));

            //    //object fncion = new object();
            //    //fncion = new WsFuncionalidad.Funcionalidad();





            //    'Se llena el combo Moneda
            //DS = fncion.("Select 0 as ID, ' SELECCIONAR...' as NombreF union all Select idbanco as ID, ID_formaliq_TR as NombreF from bancos order by NombreF", "ConexionDBS")
            //'Combo 

            //Me.cmbLiquidDefaultTR.DataSource = DS
            //Me.cmbLiquidDefaultTR.ValueField = "ID"
            //Me.cmbLiquidDefaultTR.TextField = "Nombref"
            //Me.cmbLiquidDefaultTR.DataBind()
            //Me.cmbLiquidDefaultTR.SelectedIndex = 0





            return Newtonsoft.Json.JsonConvert.SerializeObject(query);
        }
        catch (Exception ex)
        {

            throw (ex);
        }

    }

    [System.Web.Services.WebMethod]
    public static object CargaContratos(int clienteid = 0)
    {

        try
        {
            object query = new object();
            DataSet DS;
            DS = new DataSet();
            DataTable dtContratos = new DataTable();

            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string queryc = "SELECT  SIIFI_credito.cred_id as cred_id , SIIFI_credito.Socio_ID as Socio_ID, SAC_DatosAdicionalesCreditoTbl.anexo as anexo, SAC_DatosAdicionalesCreditoTbl.contrato as contrato FROM SIIFI_credito INNER JOIN SAC_DatosAdicionalesCreditoTbl ON SIIFI_credito.cred_id = SAC_DatosAdicionalesCreditoTbl.cred_id where Socio_ID = " + clienteid;

                    SqlCommand cmd = new SqlCommand(queryc, con);

                    SqlDataAdapter sda = new SqlDataAdapter();
                    sda.SelectCommand = cmd;
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

            dtContratos = DS.Tables[0];
            List<DataRow> list = dtContratos.AsEnumerable().ToList();


            query = from c in list
                    select new
                    {

                        valor = c.ItemArray[3].ToString(),
                        descripcion = c.ItemArray[3].ToString()

                    };





            return Newtonsoft.Json.JsonConvert.SerializeObject(query);
        }
        catch (Exception ex)
        {

            throw (ex);
        }

    }

    [System.Web.Services.WebMethod]
    public static object CargaAnexos(int clienteid = 0)
    {

        try
        {
            object query = new object();
            DataSet DS;
            DS = new DataSet();
            DataTable dtAnexos = new DataTable();

            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString))
            {
                try
                {
                    con.Open();
                    string queryc = "SELECT  SIIFI_credito.cred_id as cred_id , SIIFI_credito.Socio_ID as Socio_ID, SAC_DatosAdicionalesCreditoTbl.anexo as anexo, SAC_DatosAdicionalesCreditoTbl.contrato as contrato FROM SIIFI_credito INNER JOIN SAC_DatosAdicionalesCreditoTbl ON SIIFI_credito.cred_id = SAC_DatosAdicionalesCreditoTbl.cred_id where Socio_ID = " + clienteid;

                    SqlCommand cmd = new SqlCommand(queryc, con);

                    SqlDataAdapter sda = new SqlDataAdapter();
                    sda.SelectCommand = cmd;
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

            dtAnexos = DS.Tables[0];
            List<DataRow> list = dtAnexos.AsEnumerable().ToList();


            query = from c in list
                    select new
                    {

                        valor = c.ItemArray[2].ToString(),
                        descripcion = c.ItemArray[2].ToString()

                    };





            return Newtonsoft.Json.JsonConvert.SerializeObject(query);
        }
        catch (Exception ex)
        {

            throw (ex);
        }

    }

    [System.Web.Services.WebMethod]
    public static object MensajeConsultaSR()
    {

        try
        {
            object query;

            if (lmsg.Count > 0)
            {
                string slist = String.Empty;
                slist = string.Join(";", lmsg.ToArray());
                query = slist;
            }
            else
                query = null;


            lmsg.Clear();

            return Newtonsoft.Json.JsonConvert.SerializeObject(query);

        }
        catch (Exception ex)
        {

            throw (ex);
        }

    }

    #endregion

    #region PROPIEDADES

    private int IDClienteP
    {
        get
        {
            if (this.cbxCliente.SelectedIndex != -1)
                return Convert.ToInt32(this.cbxCliente.SelectedItem.Value.ToString());
            else
                return 0;
        }
    }

    private byte FacturaVencidaP
    {
        get
        {
            if (this.cbxMuestraTodos.Checked)
                return 0;
            else
                return 1;
        }
    }

    private string ContratoP
    {
        get
        {
            if (this.cmbNumeroContrato.Text != String.Empty)
                return this.cmbNumeroContrato.Text.Trim();
            else
                return String.Empty;
        }

    }

    private string AnexoP
    {
        get
        {
            if (this.cmbAnexo.Text != String.Empty)
                return this.cmbAnexo.Text.Trim();
            else
                return String.Empty;
        }

    }

    #endregion


    protected void btnBuscar_Click(object sender, EventArgs e)
    {
        gv_FacRtasPend.DataSource = null;
        gv_FacRtasPend.DataBind();
        this.Consultar();
        gv_FacRtasPend.SearchPanelFilter = String.Empty;
    }

    protected void gv_FacAdicionales_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
    {
        string[] Parametros = e.Parameters.Split(';');

        if (e.Parameters.Equals("BuscarAdicionales"))
        {

            gv_FacAdicionales.DataSource = null;
            gv_FacAdicionales.DataBind();            
            this.ConsultarAdicionales();
        }

        if (e.Parameters.Equals("grdCancelaAdicionales"))
        {

            gv_FacAdicionales.DataSource = null;
            gv_FacAdicionales.DataBind();
            

        }

        gv_FacAdicionales.SearchPanelFilter = String.Empty;
        Parametros = null;
    }



    protected void gv_FacAdicionales_CustomColumnSort(object sender, CustomColumnSortEventArgs e)
    {
        //CompareColumnValues(e);
    }

    protected void gv_FacAdicionales_CustomColumnGroup(object sender, CustomColumnSortEventArgs e)
    {
        //CompareColumnValues(e);
    }

    protected void gv_FacAdicionales_CustomGroupDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
    {
        if (e.Column.FieldName == "adicional")
        {
            //double d = Math.Floor(Convert.ToDouble(e.Value) / 10);
            byte adic = Convert.ToByte(e.Value);
            string displayText = "Rentas";
            if (adic == 1) displayText = "Rentas Adicionales";
            e.DisplayText = displayText;
        }
    }

    //private void CompareColumnValues(DevExpress.Web.ASPxGridView.CustomColumnSortEventArgs e)
    //{
    //    if (e.Column.FieldName == "UnitPrice")
    //    {
    //        int res = 0;

    //        double x = Math.Floor(Convert.ToDouble(e.Value1) / 10);
    //        double y = Math.Floor(Convert.ToDouble(e.Value2) / 10);
    //        res = Comparer.Default.Compare(x, y);
    //        if (res < 0) res = -1;
    //        else if (res > 0) res = 1;
    //        if (res == 0 || (x > 9 && y > 9)) res = 0;

    //        e.Result = res;
    //        e.Handled = true;
    //    }
    //}


    protected void gv_FacRtasPend_CustomGroupDisplayText(object sender, ASPxGridViewColumnDisplayTextEventArgs e)
    {
        if (e.Column.FieldName == "adicional")
        {
            //double d = Math.Floor(Convert.ToDouble(e.Value) / 10);
            byte adic = Convert.ToByte(e.Value);
            string displayText = "Rentas";
            if (adic == 1) displayText = "Rentas Adicionales";
            e.DisplayText = displayText;
            
        }
    }
}