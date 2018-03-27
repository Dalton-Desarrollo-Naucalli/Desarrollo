    using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using Newtonsoft.Json;
using System.Web.Services;
using System.Text.RegularExpressions;
using System.ComponentModel;

public class CanastaAgregaZonasViewModel
{
    public List<ItemZonasaViewModel> ZonasFiscales { get; set; }
    public int Items { get; set; }
}

public class ItemZonasaViewModel
{

    public ItemZonasaViewModel()
    {
        this.IdSucursal = 0;
    }

    public int IdSucursal { get; set; }
    public string Descripcion { get; set; }
    public int IdZonaFiscal { get; set; }
    public string ZonaFiscal { get; set; }

}





public partial class Framework_GestionProveedores : System.Web.UI.Page
{
    int IdUsuario;
    private WsSeguridad.Seguridad Servicio = new WsSeguridad.Seguridad();
    public string vSistema = System.Configuration.ConfigurationManager.AppSettings["sistema"];
    public string vEmpresa = System.Configuration.ConfigurationManager.AppSettings["empresa"];


    /* Seccion de Metodos de Base de Datos */

    /// <summary>
    /// paConBancos
    /// </summary>
    /// <param name="IdBanco"></param>
    /// <returns></returns>



    private static DataSet paConCombosGenerales(int IdUsuario, int IdOpcion)
    {
        DataSet ds = new DataSet();

        using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString))
        {
            try
            {
                con.Open();
                SqlCommand command = new SqlCommand("spc_consultacombosgenerales", con);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@PnIdUsuario", IdUsuario));
                command.Parameters.Add(new SqlParameter("@PnIdOpcion", IdOpcion));
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

    private DataSet MostrarProveedores(int IdUsuario, int IdProveedor = 0, string Descripcion = "")
    {
        DataSet ds = new DataSet();

        using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString))
        {
            try
            {
                con.Open();
                SqlCommand command = new SqlCommand("spc_proveedor", con);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@PnIdUsuario", IdUsuario));
                if (IdProveedor > 0)
                {
                    command.Parameters.Add(new SqlParameter("@PnIdProveedor", IdProveedor));
                }
                if (Descripcion != "")
                {
                    command.Parameters.Add(new SqlParameter("@PsNombre", Descripcion));
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

    private static DataSet paConComboCuentasVirtuales(int IdUsuario, int IdOpcion)
    {
        DataSet ds = new DataSet();

        using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString))
        {
            try
            {
                con.Open();
                SqlCommand command = new SqlCommand("spc_consultacomboscuentasvirtuales", con);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@PnIdUsuario", IdUsuario));
                command.Parameters.Add(new SqlParameter("@PnIdOpcion", IdOpcion));
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

    private static DataSet paConZonasFiscales(int IdUsuario, int IdProveedor)
    {
        DataSet ds = new DataSet();

        using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString))
        {
            try
            {
                con.Open();
                SqlCommand command = new SqlCommand("spc_proveedor_zonafiscal", con);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@PnIdProveedor", IdProveedor));
                command.Parameters.Add(new SqlParameter("@PnIdUsuario", IdUsuario));
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

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["sUsuario"] == null)
            {
                Response.Buffer = true;
                Response.Clear();
                Response.Redirect("Acceso.aspx");
            }
            LlenaListas();
            llenargv();
            VerificaAccesos("GestionProveedores");
        }

    }

    /* Métodos Privados */
    /// <summary>
    /// Metodo para Llenar Lista de Bancos
    /// </summary>
    private void LlenaListas()
    {
        if (Session["iIdUsuario"] == null)
        {
            IdUsuario = 0;
        }
        else
        {
            IdUsuario = int.Parse(Session["iIdUsuario"].ToString());
        }

        Estado.DataSource = paConCombosGenerales(IdUsuario, 1);
        Estado.DataTextField = "Nombre";
        Estado.DataValueField = "EntidadFed_ID";
        Estado.DataBind();
        Estado.Items.Insert(0, new ListItem("", "0"));


        Banco.DataSource = paConCombosGenerales(IdUsuario, 2);
        Banco.DataTextField = "nombre_corto";
        Banco.DataValueField = "idBanco";
        Banco.DataBind();
        Banco.Items.Insert(0, new ListItem("", "0"));

        TipoProveedor.DataSource = paConCombosGenerales(IdUsuario, 3);
        TipoProveedor.DataTextField = "descripcion";
        TipoProveedor.DataValueField = "cve_tipo";
        TipoProveedor.DataBind();
        TipoProveedor.Items.Insert(0, new ListItem("", "0"));

        SujetoImpExp.DataSource = paConCombosGenerales(IdUsuario, 4);
        SujetoImpExp.DataTextField = "descripcion";
        SujetoImpExp.DataValueField = "clave";
        SujetoImpExp.DataBind();

        Nacionalidad.DataSource = paConCombosGenerales(IdUsuario, 11);
        Nacionalidad.DataTextField = "descripcion";
        Nacionalidad.DataValueField = "clave";
        Nacionalidad.DataBind();


        AuxiliarContable.DataSource = paConComboCuentasVirtuales(IdUsuario, 3);
        AuxiliarContable.DataTextField = "cuenta";
        AuxiliarContable.DataValueField = "numerodecuenta";
        AuxiliarContable.DataBind();
        AuxiliarContable.Items.Insert(0, new ListItem("", "0"));

        AuxiliarContableCC.DataSource = paConComboCuentasVirtuales(IdUsuario, 3);
        AuxiliarContableCC.DataTextField = "cuenta";
        AuxiliarContableCC.DataValueField = "numerodecuenta";
        AuxiliarContableCC.DataBind();
        AuxiliarContableCC.Items.Insert(0, new ListItem("", "0"));


        txtZonaFiscal.DataSource = paConCombosGenerales(IdUsuario, 9);
        txtZonaFiscal.DataTextField = "Descripcion";
        txtZonaFiscal.DataValueField = "zona_fiscal_id";
        txtZonaFiscal.DataBind();
        txtZonaFiscal.Items.Insert(0, new ListItem("", "0"));

    }

    private void llenargv()
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
        DataTable model = MostrarProveedores(IdUsuario).Tables[0];
        gv.DataSource = model;
        gv.DataBind();
    }

    public DataTable ConvertToDataTable<T>(IList<T> data)
    {
        PropertyDescriptorCollection properties =
           TypeDescriptor.GetProperties(typeof(T));
        DataTable table = new DataTable();
        foreach (PropertyDescriptor prop in properties)
            table.Columns.Add(prop.Name, Nullable.GetUnderlyingType(prop.PropertyType) ?? prop.PropertyType);
        foreach (T item in data)
        {
            DataRow row = table.NewRow();
            foreach (PropertyDescriptor prop in properties)
                row[prop.Name] = prop.GetValue(item) ?? DBNull.Value;
            table.Rows.Add(row);
        }
        return table;

    }

    public void VerificaAccesos(object txtFormulario)
    {
        DataSet DsAccesos = new DataSet();
        DataTable dtAccesos = new DataTable();
        int vRenglon = 0;
        DsAccesos = Servicio.OpVerificaAccesosFormulario(Session["sUsuario"], Session["iIdUsuario"], txtFormulario, System.Configuration.ConfigurationManager.AppSettings["ConexionSeguridad"]);
        dtAccesos = DsAccesos.Tables[0];
        object txtAcceso;
        string txtAccesosUsuario = "";

        if (DsAccesos.Tables.Count > 0)
        {
            if (DsAccesos.Tables[0].Rows.Count > 0)
            {
                foreach (DataRow drAccesos in dtAccesos.Rows)
                {
                    txtAcceso = DsAccesos.Tables[0].Rows[vRenglon]["nombre"].ToString().Trim();

                    vRenglon = vRenglon + 1;
                    txtAccesosUsuario = txtAccesosUsuario + txtAcceso + "-";
                    //this.lblAccesos.Text = txtAccesosUsuario;
                }
            }
            else
            {
                this.lblAccesos.Text = "Su usuario no tiene acceso a este formulario...";
                Response.Buffer = true;
                Response.Clear();
                Response.Redirect("../Framework/Acceso.aspx");
                Response.Redirect("../Framework/Acceso.aspx");
            }
        }
    }

    /* Eventos  */

    protected void btnGuardarProv_Click(object sender, EventArgs e)
    {
        int returnValue = 0;

        decimal saldocuenta = 0;


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
                if (Session["prov_id"] != null)
                {
                    con.Open();
                    int IdProveedor = int.Parse(Session["prov_id"].ToString());
                    #region Update Proveedor
                    using (SqlCommand cmd = new SqlCommand("spu_proveedor", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@PnIdProveedor", SqlDbType.Int).Value = IdProveedor;
                        cmd.Parameters.Add("@PsNombre", SqlDbType.VarChar).Value = Nombre.Text;
                        cmd.Parameters.Add("@PsDireccion", SqlDbType.VarChar).Value = Calle.Text;
                        cmd.Parameters.Add("@PsColonia", SqlDbType.VarChar).Value = Colonia.Text;
                        cmd.Parameters.Add("@PsCP", SqlDbType.VarChar).Value = CP.Text;
                        cmd.Parameters.Add("@PsMunicipio", SqlDbType.VarChar).Value = Municipio.Text;
                        cmd.Parameters.Add("@PsEstado", SqlDbType.VarChar).Value = Estado.SelectedItem.Text;
                        cmd.Parameters.Add("@PsTelefono1", SqlDbType.VarChar).Value = Telefono.Text;
                        cmd.Parameters.Add("@PsTelefono2", SqlDbType.VarChar).Value = Telefono2.Text;
                        cmd.Parameters.Add("@PsFax", SqlDbType.VarChar).Value = Fax.Text;
                        cmd.Parameters.Add("@PsRfc", SqlDbType.VarChar).Value = RFC.Text;
                        cmd.Parameters.Add("@PnNum_distribuidor", SqlDbType.Int).Value = string.IsNullOrEmpty(NumDistribuidor.Text) ? 0 : int.Parse(NumDistribuidor.Text); ;
                        cmd.Parameters.Add("@Psclave_proveedor", SqlDbType.VarChar).Value = "0";
                        cmd.Parameters.Add("@PsNota", SqlDbType.Text).Value = Nota.Text;
                        cmd.Parameters.Add("@PnPorcentaje_isr", SqlDbType.Real).Value = RetIsr.Text;
                        cmd.Parameters.Add("@PsHorariopago", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsCalidad_fiscal", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PnCve_tipo", SqlDbType.VarChar).Value = TipoProveedor.SelectedItem.Value;
                        cmd.Parameters.Add("@PsAuxiliar", SqlDbType.VarChar).Value = AuxiliarContable.SelectedItem.Value;
                        cmd.Parameters.Add("@PnBanco", SqlDbType.Int).Value = Banco.SelectedItem.Value;
                        cmd.Parameters.Add("@PsNum_cheque", SqlDbType.VarChar).Value = CtaCheques.Text;
                        cmd.Parameters.Add("@PnNacional", SqlDbType.TinyInt).Value = Nacionalidad.SelectedItem.Value;
                        cmd.Parameters.Add("@PnProceso_importa", SqlDbType.TinyInt).Value = SujetoImpExp.SelectedItem.Value;
                        cmd.Parameters.Add("@PnConsec_mov", SqlDbType.Int).Value = 0;
                        cmd.Parameters.Add("@PnSaldo_CC", SqlDbType.Money).Value = SaldoCuenta.Text;
                        cmd.Parameters.Add("@PsE_mail", SqlDbType.VarChar).Value = Correo.Text;
                        cmd.Parameters.Add("@PnDias_credito", SqlDbType.Int).Value = DiasCredito.Text;
                        cmd.Parameters.Add("@PsAuxiliar_cc", SqlDbType.VarChar).Value = AuxiliarContableCC.SelectedItem.Value;
                        cmd.Parameters.Add("@PsNombre_corto", SqlDbType.VarChar).Value = NombreCorto.Text;
                        cmd.Parameters.Add("@PnIdOpcion", SqlDbType.Int).Value = 0;
                        cmd.Parameters.Add("@PnIdUsuario", SqlDbType.SmallInt).Value = IdUsuario;
                        cmd.Parameters.Add("@PsIpAct", SqlDbType.VarChar).Value = Request.ServerVariables["REMOTE_ADDR"].ToString();
                        cmd.Parameters.Add("@PnEstatus", SqlDbType.Int).Value = 0;
                        cmd.Parameters.Add("@PsMensaje", SqlDbType.VarChar).Value = "";
                        cmd.Parameters["@PnEstatus"].Direction = ParameterDirection.Output;
                        cmd.Parameters["@PsMensaje"].Direction = ParameterDirection.Output;
                        cmd.ExecuteNonQuery();
                        cmd.Dispose();
                    }
                    #endregion
                    #region agrega Zonas Fiscales 
                    if (IdProveedor > 0)
                    {
                        CanastaAgregaZonasViewModel canasta = new CanastaAgregaZonasViewModel();
                        if (Session["CanastaZonasFiscales"] != null)
                        {
                            canasta = (Session["CanastaZonasFiscales"] as CanastaAgregaZonasViewModel);
                        }
                        foreach (var item in canasta.ZonasFiscales)
                        {
                            if (item.IdSucursal == 0)
                            {
                                using (SqlCommand cmd = new SqlCommand("spa_proveedor_zonafiscal", con))
                                {
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    cmd.Parameters.Add("@PnId_Proveedor", SqlDbType.Int).Value = IdProveedor;
                                    cmd.Parameters.Add("@PnId_ZonaFiscal", SqlDbType.Int).Value = item.IdZonaFiscal;
                                    cmd.Parameters.Add("@PsNombre", SqlDbType.VarChar).Value = item.Descripcion;
                                    cmd.Parameters.Add("@PnIdUsuario", SqlDbType.SmallInt).Value = IdUsuario;
                                    cmd.Parameters.Add("@PnIdOpcion", SqlDbType.Int).Value = 0;
                                    cmd.Parameters.Add("@PnEstatus", SqlDbType.Int).Value = 0;
                                    cmd.Parameters.Add("@PsMensaje", SqlDbType.VarChar).Value = "";
                                    cmd.Parameters["@PnEstatus"].Direction = ParameterDirection.Output;
                                    cmd.Parameters["@PsMensaje"].Direction = ParameterDirection.Output;
                                    cmd.ExecuteNonQuery();
                                    cmd.Dispose();
                                }
                            }

                        }
                    }
                    #endregion
                    Session.Remove("prov_id");
                }
                else
                {
                    con.Open();
                    #region Inserta Proveedor 
                    using (SqlCommand cmd = new SqlCommand("spa_proveedor", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@PsNombre", SqlDbType.VarChar).Value = Nombre.Text;
                        cmd.Parameters.Add("@PsDireccion", SqlDbType.VarChar).Value = Calle.Text;
                        cmd.Parameters.Add("@PsColonia", SqlDbType.VarChar).Value = Colonia.Text;
                        cmd.Parameters.Add("@PsCP", SqlDbType.VarChar).Value = CP.Text;
                        cmd.Parameters.Add("@PsMunicipio", SqlDbType.VarChar).Value = Municipio.Text;
                        cmd.Parameters.Add("@PsEstado", SqlDbType.VarChar).Value = Estado.SelectedItem.Text;
                        cmd.Parameters.Add("@PsTelefono1", SqlDbType.VarChar).Value = Telefono.Text;
                        cmd.Parameters.Add("@PsTelefono2", SqlDbType.VarChar).Value = Telefono2.Text;
                        cmd.Parameters.Add("@PsFax", SqlDbType.VarChar).Value = Fax.Text;
                        cmd.Parameters.Add("@PsRfc", SqlDbType.VarChar).Value = RFC.Text;
                        cmd.Parameters.Add("@PnNum_distribuidor", SqlDbType.Int).Value = string.IsNullOrEmpty(NumDistribuidor.Text) ? 0 : int.Parse(NumDistribuidor.Text); ;
                        cmd.Parameters.Add("@Psclave_proveedor", SqlDbType.VarChar).Value = "0";
                        cmd.Parameters.Add("@PsNota", SqlDbType.Text).Value = Nota.Text;
                        cmd.Parameters.Add("@PnPorcentaje_isr", SqlDbType.Real).Value = RetIsr.Text;
                        cmd.Parameters.Add("@PsHorariopago", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsCalidad_fiscal", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PnCve_tipo", SqlDbType.Int).Value = TipoProveedor.SelectedItem.Value;
                        cmd.Parameters.Add("@PsAuxiliar", SqlDbType.VarChar).Value = AuxiliarContable.SelectedItem.Value;
                        cmd.Parameters.Add("@PnBanco", SqlDbType.Int).Value = Banco.SelectedItem.Value;
                        cmd.Parameters.Add("@PsNum_cheque", SqlDbType.VarChar).Value = CtaCheques.Text;
                        cmd.Parameters.Add("@PnNacional", SqlDbType.TinyInt).Value = Nacionalidad.SelectedItem.Value;
                        cmd.Parameters.Add("@PnProceso_importa", SqlDbType.TinyInt).Value = SujetoImpExp.SelectedItem.Value;
                        cmd.Parameters.Add("@PnConsec_mov", SqlDbType.Int).Value = 0;
                        cmd.Parameters.Add("@PnSaldo_CC", SqlDbType.Money).Value = 0;
                        cmd.Parameters.Add("@PsE_mail", SqlDbType.VarChar).Value = Correo.Text;
                        cmd.Parameters.Add("@PnDias_credito", SqlDbType.Int).Value = DiasCredito.Text;
                        cmd.Parameters.Add("@PsAuxiliar_cc", SqlDbType.VarChar).Value = AuxiliarContableCC.SelectedItem.Value;
                        cmd.Parameters.Add("@PsNombre_corto", SqlDbType.VarChar).Value = NombreCorto.Text;
                        cmd.Parameters.Add("@PnIdOpcion", SqlDbType.Int).Value = 0;
                        cmd.Parameters.Add("@PnIdUsuario", SqlDbType.SmallInt).Value = IdUsuario;
                        cmd.Parameters.Add("@PsIpAct", SqlDbType.VarChar).Value = Request.ServerVariables["REMOTE_ADDR"].ToString();
                        cmd.Parameters.Add("@PnEstatus", SqlDbType.Int).Value = 0;
                        cmd.Parameters.Add("@PsMensaje", SqlDbType.VarChar).Value = "";
                        cmd.Parameters["@PnEstatus"].Direction = ParameterDirection.Output;
                        cmd.Parameters["@PsMensaje"].Direction = ParameterDirection.Output;
                        returnValue = (int)cmd.ExecuteScalar();
                        cmd.Dispose();
                    }
                    #endregion
                    #region agrega Zonas Fiscales 
                    if (returnValue > 0)
                    {
                        CanastaAgregaZonasViewModel canasta = new CanastaAgregaZonasViewModel();
                        if (Session["CanastaZonasFiscales"] != null)
                        {
                            canasta = (Session["CanastaZonasFiscales"] as CanastaAgregaZonasViewModel);
                        }
                        foreach (var item in canasta.ZonasFiscales)
                        {
                            using (SqlCommand cmd = new SqlCommand("spa_proveedor_zonafiscal", con))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.Add("@PnId_Proveedor", SqlDbType.Int).Value = returnValue;
                                cmd.Parameters.Add("@PnId_ZonaFiscal", SqlDbType.Int).Value = item.IdZonaFiscal;
                                cmd.Parameters.Add("@PsNombre", SqlDbType.VarChar).Value = item.Descripcion;
                                cmd.Parameters.Add("@PnIdUsuario", SqlDbType.SmallInt).Value = IdUsuario;
                                cmd.Parameters.Add("@PnIdOpcion", SqlDbType.Int).Value = 0;
                                cmd.Parameters.Add("@PnEstatus", SqlDbType.Int).Value = 0;
                                cmd.Parameters.Add("@PsMensaje", SqlDbType.VarChar).Value = "";
                                cmd.Parameters["@PnEstatus"].Direction = ParameterDirection.Output;
                                cmd.Parameters["@PsMensaje"].Direction = ParameterDirection.Output;
                                cmd.ExecuteNonQuery();
                                cmd.Dispose();
                            }
                        }
                    }
                    #endregion
                }
                Session.Remove("CanastaZonasFiscales");
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
        }//using
        NumProveedor.Text = "";
        Nombre.Text = "";
        Calle.Text = "";
        Colonia.Text = "";
        CP.Text = "";
        Municipio.Text = "";
        Estado.Text = "0";
        Telefono.Text = "";
        Telefono2.Text = "";
        Fax.Text = "";
        RFC.Text = "";
        NumDistribuidor.Text = "";
        Nota.Text = "";
        RetIva.Text = "";
        RetIsr.Text = "";
        TipoProveedor.Text = "0";
        Auxiliar.Text = "";
        AuxiliarCC.Text = "";
        Banco.Text = "0";
        CtaCheques.Text = "";
        Nacionalidad.Text = "0";
        SujetoImpExp.Text = "0";
        SaldoCuenta.Text = "";
        Correo.Text = "";
        DiasCredito.Text = "";
        AuxiliarContable.Text = "0";
        AuxiliarContableCC.Text = "0";
        NombreCorto.Text = "";
        Nota.Text = "";
        divCatalogo.Visible = true;
        Editar.Visible = false; llenargv();
        gvZonas.DataSource = null;
        gvZonas.DataBind();
        btnAgregar.Visible = true;
    }

    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index = Convert.ToInt32(e.CommandArgument);
        int IdUsuario = 0;
        if (Session["iIdUsuario"] == null)
        {
            IdUsuario = 0;
        }
        else
        {
            IdUsuario = int.Parse(Session["iIdUsuario"].ToString());
        }

        if (e.CommandName == "Editar")
        {
            #region Editar
            Editar.Visible = true; divCatalogo.Visible = false; btnAgregar.Visible = false;
            DataTable dt = MostrarProveedores(IdUsuario, index).Tables[0];
            NumProveedor.Text = index.ToString();
            Nombre.Text = dt.Rows[0]["Nombre"].ToString();
            Calle.Text = dt.Rows[0]["direccion"].ToString();
            Colonia.Text = dt.Rows[0]["colonia"].ToString();
            CP.Text = dt.Rows[0]["cp"].ToString();
            Municipio.Text = dt.Rows[0]["municipio"].ToString();
            Estado.SelectedValue = dt.Rows[0]["estado_id"].ToString();
            Telefono.Text = dt.Rows[0]["telefono1"].ToString();
            Telefono2.Text = dt.Rows[0]["telefono2"].ToString();
            Fax.Text = dt.Rows[0]["fax"].ToString();
            RFC.Text = dt.Rows[0]["rfc"].ToString();
            NumDistribuidor.Text = dt.Rows[0]["num_distribuidor"].ToString();
            Nota.Text = dt.Rows[0]["nota"].ToString();
            RetIva.Text = dt.Rows[0]["retencion"].ToString();
            RetIsr.Text = dt.Rows[0]["porcentaje_isr"].ToString();
            TipoProveedor.SelectedValue = dt.Rows[0]["cve_tipo"].ToString();
            try
            {
                Banco.SelectedValue = dt.Rows[0]["banco"].ToString();
            }
            catch
            {
                Banco.SelectedValue = "0";
            }
            CtaCheques.Text = dt.Rows[0]["num_cheque"].ToString();
            Nacionalidad.SelectedValue = dt.Rows[0]["nacional"].ToString();
            SujetoImpExp.SelectedValue = dt.Rows[0]["Proceso_importa"].ToString();
            SaldoCuenta.Text = dt.Rows[0]["Saldo_CC"].ToString();
            Correo.Text = dt.Rows[0]["e_mail"].ToString();
            DiasCredito.Text = dt.Rows[0]["dias_credito"].ToString();
            try
            {
                Auxiliar.Text = dt.Rows[0]["auxconta"].ToString();
                AuxiliarCC.Text = dt.Rows[0]["auxcontacc"].ToString();
                AuxiliarContableCC.SelectedValue = dt.Rows[0]["auxiliar_cc"].ToString();
                AuxiliarContable.SelectedValue = dt.Rows[0]["auxiliar"].ToString();
            }
            catch
            {
                Auxiliar.Text = "";
                AuxiliarCC.Text = "";
                AuxiliarContable.SelectedValue = "0";
                AuxiliarContableCC.SelectedValue = "0";
            }
            NombreCorto.Text = dt.Rows[0]["nombre_corto"].ToString();
            DataTable dtZonas = paConZonasFiscales(IdUsuario, index).Tables[0];
            foreach (DataRow dr in dtZonas.Rows)
            {
                int IdZonaFiscal = string.IsNullOrEmpty(dr["IdZonaFiscal"].ToString()) ? 0 : int.Parse(dr["IdZonaFiscal"].ToString());
                string ZonaFiscal = string.IsNullOrEmpty(dr["zona_fiscal_id"].ToString()) ? "" : dr["zona_fiscal_id"].ToString();
                string Descripcion = string.IsNullOrEmpty(dr["Nombre"].ToString()) ? "" : dr["Nombre"].ToString();
                int IdSucursal = string.IsNullOrEmpty(dr["Sucursal_prov"].ToString()) ? 0 : int.Parse(dr["Sucursal_prov"].ToString());

                CanastaAgregaZonasViewModel canasta = new CanastaAgregaZonasViewModel();
                if (Session["CanastaZonasFiscales"] == null)
                {
                    canasta.ZonasFiscales = new List<ItemZonasaViewModel>();
                    ItemZonasaViewModel zonafiscal = new ItemZonasaViewModel();
                    zonafiscal.IdSucursal = IdSucursal;
                    zonafiscal.IdZonaFiscal = IdZonaFiscal;
                    zonafiscal.ZonaFiscal = ZonaFiscal;
                    zonafiscal.Descripcion = Descripcion;
                    canasta.ZonasFiscales.Add(zonafiscal);
                }
                else
                {
                    canasta = (Session["CanastaZonasFiscales"] as CanastaAgregaZonasViewModel);
                    var existe = canasta.ZonasFiscales.Where(x => x.Descripcion == txtDescripcion.Text && x.IdZonaFiscal == IdZonaFiscal).FirstOrDefault();
                    if (existe != null)
                    {
                        existe.IdSucursal = IdSucursal;
                        existe.Descripcion = Descripcion;
                        existe.IdZonaFiscal = IdZonaFiscal;
                        existe.ZonaFiscal = ZonaFiscal;
                    }
                    else
                    {
                        ItemZonasaViewModel zonafiscal = new ItemZonasaViewModel();
                        zonafiscal.Descripcion = Descripcion;
                        zonafiscal.IdZonaFiscal = IdZonaFiscal;
                        zonafiscal.ZonaFiscal = ZonaFiscal;
                        zonafiscal.IdSucursal = IdSucursal;
                        canasta.ZonasFiscales.Add(zonafiscal);
                    }
                }
                canasta.Items = canasta.ZonasFiscales.Count();
                Session["CanastaZonasFiscales"] = canasta;
                gvZonas.DataSource = ConvertToDataTable(canasta.ZonasFiscales);
                gvZonas.DataBind();
            }
            Session.Add("prov_id", index);
            #endregion
        }
        else if (e.CommandName == "Borrar")
        {
            #region Borrar 
            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString))
            {
                try
                {
                    if (index > 0)
                    {
                        #region Borrado Lógico Proveedor
                        using (SqlCommand cmd = new SqlCommand("Spd_Proveedor", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.Add("@PnIdProveedor", SqlDbType.Int).Value = index;
                            cmd.Parameters.Add("@PbBorradoLogico", SqlDbType.Bit).Value = true;
                            cmd.Parameters.Add("@PnIdUsuario", SqlDbType.SmallInt).Value = IdUsuario;
                            cmd.Parameters.Add("@PnIdOpcion", SqlDbType.Int).Value = 0;
                            cmd.Parameters.Add("@PsIpAct", SqlDbType.VarChar).Value = Request.ServerVariables["REMOTE_ADDR"].ToString();
                            cmd.Parameters.Add("@PnEstatus", SqlDbType.Int).Value = 0;
                            cmd.Parameters.Add("@PsMensaje", SqlDbType.VarChar).Value = "";
                            cmd.Parameters["@PnEstatus"].Direction = ParameterDirection.Output;
                            cmd.Parameters["@PsMensaje"].Direction = ParameterDirection.Output;
                            con.Open();
                            cmd.ExecuteNonQuery();
                            cmd.Dispose();
                        }
                        llenargv();
                        #endregion
                    }
                }
                catch (Exception ex)
                {
                }
                finally
                {
                    con.Close();
                    con.Dispose();

                }
            }//using
            #endregion
        }

    }


    protected void btnAgregar_Click(object sender, EventArgs e)
    {
        btnAgregar.Visible = false;
        NumProveedor.Text = "";
        Nombre.Text = "";
        Calle.Text = "";
        Colonia.Text = "";
        CP.Text = "";
        Municipio.Text = "";
        Estado.Text = "0";
        Telefono.Text = "";
        Telefono2.Text = "";
        Fax.Text = "";
        RFC.Text = "";
        NumDistribuidor.Text = "";
        Nota.Text = "";
        RetIva.Text = "";
        RetIsr.Text = "";
        TipoProveedor.Text = "0";
        Auxiliar.Text = "";
        AuxiliarCC.Text = "";
        Banco.Text = "0";
        CtaCheques.Text = "";
        Nacionalidad.Text = "0";
        SujetoImpExp.Text = "0";
        SaldoCuenta.Text = "";
        Correo.Text = "";
        DiasCredito.Text = "";
        AuxiliarContable.Text = "0";
        AuxiliarContableCC.Text = "0";
        NombreCorto.Text = "";
        divCatalogo.Visible = false;
        Editar.Visible = true;
        Session.Remove("prov_id");
        llenargv();
    }

    protected void cancelar_Click(object sender, EventArgs e)
    {
        divCatalogo.Visible = true;
        Editar.Visible = false;
        btnAgregar.Visible = true;
        Session.Remove("prov_id");
        Session.Remove("CanastaZonasFiscales");
        gvZonas.DataSource = null;
        gvZonas.DataBind();

    }

    protected void btnBuscar_Click(object sender, EventArgs e)
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
        DataTable model = MostrarProveedores(IdUsuario: IdUsuario, Descripcion: txtBuscar.Text).Tables[0];
        gv.DataSource = model;
        gv.DataBind();

    }

    protected void TipoProveedor_SelectedIndexChanged(object sender, EventArgs e)
    {
        int id = string.IsNullOrEmpty(TipoProveedor.SelectedValue) ? 0 : int.Parse(TipoProveedor.SelectedValue);
        if (Session["iIdUsuario"] == null)
        {
            IdUsuario = 0;
        }
        else
        {
            IdUsuario = int.Parse(Session["iIdUsuario"].ToString());
        }
        DataTable dt = new DataTable();

        dt = paConCombosGenerales(IdUsuario, 3).Tables[0];

        if (id > 0)
        {
            var modeldr = (from s in dt.AsEnumerable()
                           where s.Field<Int32>("cve_tipo") == id
                           select s);
            RetIva.Text = modeldr.FirstOrDefault()["retencion"].ToString();
        }
    }

    protected void AuxiliarContable_SelectedIndexChanged(object sender, EventArgs e)
    {
        string id = AuxiliarContable.SelectedValue;
        if (Session["iIdUsuario"] == null)
        {
            IdUsuario = 0;
        }
        else
        {
            IdUsuario = int.Parse(Session["iIdUsuario"].ToString());
        }

        DataTable dt = new DataTable();

        dt = paConComboCuentasVirtuales(IdUsuario, 3).Tables[0];
        if (id != "")
        {
            var modeldr = (from s in dt.AsEnumerable()
                           where s.Field<string>("numerodecuenta") == id
                           select s);
            Auxiliar.Text = modeldr.FirstOrDefault()["numerodecuenta"].ToString();
        }
        else
        {
            Auxiliar.Text = "";
        }
    }

    protected void AuxiliarContableCC_SelectedIndexChanged(object sender, EventArgs e)
    {
        string id = AuxiliarContableCC.SelectedValue;
        if (Session["iIdUsuario"] == null)
        {
            IdUsuario = 0;
        }
        else
        {
            IdUsuario = int.Parse(Session["iIdUsuario"].ToString());
        }

        DataTable dt = new DataTable();

        dt = paConComboCuentasVirtuales(IdUsuario, 3).Tables[0];
        if (id != "")
        {

            var modeldr = (from s in dt.AsEnumerable()
                           where s.Field<string>("numerodecuenta") == id
                           select s);
            AuxiliarCC.Text = modeldr.FirstOrDefault()["numerodecuenta"].ToString();
        }
        else
        {
            AuxiliarCC.Text = "";
        }

    }

    protected void btnZona_Click(object sender, EventArgs e)
    {
        int IdZonaFiscal = int.Parse(txtZonaFiscal.SelectedItem.Value);
        string ZonaFiscal = txtZonaFiscal.SelectedItem.Text;
        CanastaAgregaZonasViewModel canasta = new CanastaAgregaZonasViewModel();
        if (Session["CanastaZonasFiscales"] == null)
        {
            canasta.ZonasFiscales = new List<ItemZonasaViewModel>();
            ItemZonasaViewModel zonafiscal = new ItemZonasaViewModel();
            zonafiscal.IdZonaFiscal = IdZonaFiscal;
            zonafiscal.ZonaFiscal = ZonaFiscal;
            zonafiscal.Descripcion = txtDescripcion.Text;
            canasta.ZonasFiscales.Add(zonafiscal);
        }
        else
        {
            canasta = (Session["CanastaZonasFiscales"] as CanastaAgregaZonasViewModel);
            var existe = canasta.ZonasFiscales.Where(x => x.Descripcion == txtDescripcion.Text && x.IdZonaFiscal == IdZonaFiscal).FirstOrDefault();
            if (existe != null)
            {
                existe.Descripcion = txtDescripcion.Text;
                existe.IdZonaFiscal = IdZonaFiscal;
                existe.ZonaFiscal = ZonaFiscal;
            }
            else
            {
                ItemZonasaViewModel zonafiscal = new ItemZonasaViewModel();
                zonafiscal.Descripcion = txtDescripcion.Text;
                zonafiscal.IdZonaFiscal = IdZonaFiscal;
                zonafiscal.ZonaFiscal = ZonaFiscal;
                canasta.ZonasFiscales.Add(zonafiscal);
            }
        }
        canasta.Items = canasta.ZonasFiscales.Count();
        Session["CanastaZonasFiscales"] = canasta;
        gvZonas.DataSource = ConvertToDataTable(canasta.ZonasFiscales);
        gvZonas.DataBind();
        txtDescripcion.Text = "";
        txtZonaFiscal.SelectedIndex = 0;

    }


    ///Emular Servicio WEB
    ///
    [WebMethod]
    public static string TipoProveedorSeleccionado(int id, int IdUsuario)
    {
        string returnValue = "";
        DataTable dt = new DataTable();

        dt = paConCombosGenerales(IdUsuario, 3).Tables[0];

        if (id > 0)
        {
            var modeldr = (from s in dt.AsEnumerable()
                           where s.Field<Int32>("cve_tipo") == id
                           select s);
            returnValue = modeldr.FirstOrDefault()["retencion"].ToString();
        }
        return returnValue;
    }

    public static string AuxiliarContableSeleccionado(string id, int IdUsuario)
    {
        string returnValue = "";
        DataTable dt = new DataTable();

        dt = paConComboCuentasVirtuales(IdUsuario, 3).Tables[0];
        if (id != "")
        {
            var modeldr = (from s in dt.AsEnumerable()
                           where s.Field<string>("numerodecuenta") == id
                           select s);
            returnValue = modeldr.FirstOrDefault()["descripcion"].ToString();
        }
        return returnValue;
    }

    protected void gvZonas_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index = Convert.ToInt32(e.CommandArgument);


        int IdProveedor = 0;
        if (Session["prov_id"] == null)
        {
            IdProveedor = 0;
        }
        else
        {
            IdProveedor = int.Parse(Session["prov_id"].ToString());
        }

        int IdUsuario = 0;
        if (Session["iIdUsuario"] == null)
        {
            IdUsuario = 0;
        }
        else
        {
            IdUsuario = int.Parse(Session["iIdUsuario"].ToString());
        }

        if (e.CommandName == "Borrar")
        {
            #region Borrar 
            using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString))
            {
                try
                {
                    if (index > 0)
                    {
                        #region Borrado Lógico Proveedor
                        using (SqlCommand cmd = new SqlCommand("Spd_proveedor_zonafiscal", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.Add("@PnSucursal_prov", SqlDbType.Int).Value = index;
                            cmd.Parameters.Add("@PnIdProveedor", SqlDbType.Int).Value = IdProveedor;
                            cmd.Parameters.Add("@PbBorradoLogico", SqlDbType.Bit).Value = false;
                            cmd.Parameters.Add("@PnIdUsuario", SqlDbType.SmallInt).Value = IdUsuario;
                            cmd.Parameters.Add("@PnIdOpcion", SqlDbType.Int).Value = 0;
                            cmd.Parameters.Add("@PsIpAct", SqlDbType.VarChar).Value = Request.ServerVariables["REMOTE_ADDR"].ToString();
                            cmd.Parameters.Add("@PnEstatus", SqlDbType.Int).Value = 0;
                            cmd.Parameters.Add("@PsMensaje", SqlDbType.VarChar).Value = "";
                            cmd.Parameters["@PnEstatus"].Direction = ParameterDirection.Output;
                            cmd.Parameters["@PsMensaje"].Direction = ParameterDirection.Output;
                            con.Open();
                            cmd.ExecuteNonQuery();
                            cmd.Dispose();

                            CanastaAgregaZonasViewModel canasta = new CanastaAgregaZonasViewModel();
                            if (Session["CanastaZonasFiscales"] != null)
                            {
                                canasta = (Session["CanastaZonasFiscales"] as CanastaAgregaZonasViewModel);
                                if (canasta != null)
                                {
                                    canasta.ZonasFiscales.Remove(canasta.ZonasFiscales.Where(x => x.IdSucursal == index).FirstOrDefault());
                                }
                                canasta.Items = canasta.ZonasFiscales.Count();
                                Session["CanastaContactos"] = canasta;
                                gvZonas.DataSource = ConvertToDataTable(canasta.ZonasFiscales);
                                gvZonas.DataBind();
                            }


                        }
                        #endregion
                    }
                }
                catch (Exception ex)
                {
                }
                finally
                {
                    con.Close();
                    con.Dispose();

                }
            }//using
            #endregion
        }

    }
}