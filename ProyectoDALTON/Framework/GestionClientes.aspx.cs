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

public class CanastaAgregaContactosViewModel
{
    public List<ItemContactoViewModel> Contactos { get; set; }
    public int Items { get; set; }
}

public class ItemContactoViewModel
{

    public ItemContactoViewModel()
    {
        this.IdContacto = 0;
    }

    public int IdContacto { get; set; }
    public string NombreContacto { get; set; }
    public int IdPuesto { get; set; }
    public string Puesto { get; set; }
    public int IdRelacion { get; set; }
    public string Relacion { get; set; }

}



public partial class Framework_GestionClientes : System.Web.UI.Page
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



    private static DataSet paConCatContacto(int IdUsuario, int IdOpcion)
    {
        DataSet ds = new DataSet();

        using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString))
        {
            try
            {
                con.Open();
                SqlCommand command = new SqlCommand("spc_contacto", con);
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

    private DataSet MostrarClientes(int IdUsuario, int IdCliente = 0, string Descripcion = "")
    {
        DataSet ds = new DataSet();

        using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString))
        {
            try
            {
                con.Open();
                SqlCommand command = new SqlCommand("spc_cliente", con);
                command.CommandType = System.Data.CommandType.StoredProcedure;
                command.Parameters.Add(new SqlParameter("@PnIdUsuario", IdUsuario));
                command.Parameters.Add(new SqlParameter("@PnIdOpcion", IdUsuario));
                if (IdCliente > 0)
                {
                    command.Parameters.Add(new SqlParameter("@PnIdCliente", IdCliente));
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

    private static DataSet paConContactosCliente(int IdUsuario, int IdCliente, int IdContacto = 0)
    {
        DataSet ds = new DataSet();

        using (SqlConnection con = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["ConexionDB"].ConnectionString))
        {
            try
            {
                con.Open();
                SqlCommand command = new SqlCommand("spc_contactocliente", con);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                command.Parameters.Add(new SqlParameter("@PnId_Cliente", IdCliente));
                if (IdContacto > 0)
                {
                    command.Parameters.Add(new SqlParameter("@PnId_Contacto", IdContacto));
                }
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
            VerificaAccesos("GestionClientes");
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



        TipoCliente.DataSource = paConCombosGenerales(IdUsuario, 5);
        TipoCliente.DataTextField = "Descripcion";
        TipoCliente.DataValueField = "id_TipoCliente";
        TipoCliente.DataBind();
        TipoCliente.Items.Insert(0, new ListItem("", "0"));


        TipoPersona.DataSource = paConCombosGenerales(IdUsuario, 6);
        TipoPersona.DataTextField = "descripcion";
        TipoPersona.DataValueField = "clave";
        TipoPersona.DataBind();

        DesgloseIva.DataSource = paConCombosGenerales(IdUsuario, 4);
        DesgloseIva.DataTextField = "descripcion";
        DesgloseIva.DataValueField = "clave";
        DesgloseIva.DataBind();

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

        GrupoEmpresarial.DataSource = paConCombosGenerales(IdUsuario, 7);
        GrupoEmpresarial.DataTextField = "Nombre";
        GrupoEmpresarial.DataValueField = "id_Grupo";
        GrupoEmpresarial.DataBind();
        GrupoEmpresarial.Items.Insert(0, new ListItem("", "0"));


        ddlRelacion.DataSource = paConCombosGenerales(IdUsuario, 8);
        ddlRelacion.DataTextField = "Descripcion";
        ddlRelacion.DataValueField = "relcon_id";
        ddlRelacion.DataBind();
        ddlRelacion.Items.Insert(0, new ListItem("", "0"));


        NombreContacto.DataSource = paConCatContacto(IdUsuario, 0);
        NombreContacto.DataTextField = "Nombre";
        NombreContacto.DataValueField = "Contacto_id";
        NombreContacto.DataBind();
        NombreContacto.Items.Insert(0, new ListItem("", "0"));


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
        DataTable model = MostrarClientes(IdUsuario).Tables[0];
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
                if (Session["cliente_id"] != null)
                {
                    con.Open();
                    int IdCliente = int.Parse(Session["cliente_id"].ToString());
                    #region Update Proveedor
                    using (SqlCommand cmd = new SqlCommand("spu_cliente", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@PnIdCliente", SqlDbType.Int).Value = IdCliente;
                        cmd.Parameters.Add("@PnIdUsuario", SqlDbType.SmallInt).Value = IdUsuario;
                        cmd.Parameters.Add("@PsNombre", SqlDbType.VarChar).Value = Nombre.Text;
                        cmd.Parameters.Add("@PsDomicilio", SqlDbType.VarChar).Value = Calle.Text;
                        cmd.Parameters.Add("@PsColonia", SqlDbType.VarChar).Value = Colonia.Text;
                        cmd.Parameters.Add("@PsCP", SqlDbType.VarChar).Value = CP.Text;
                        cmd.Parameters.Add("@PsMunicipio", SqlDbType.VarChar).Value = Municipio.Text;
                        cmd.Parameters.Add("@PsEstado", SqlDbType.VarChar).Value = Estado.SelectedItem.Text;
                        cmd.Parameters.Add("@PsTelefono1", SqlDbType.VarChar).Value = Telefono.Text;
                        cmd.Parameters.Add("@PsTelefono2", SqlDbType.VarChar).Value = Telefono2.Text;
                        cmd.Parameters.Add("@PsFax", SqlDbType.VarChar).Value = Fax.Text;
                        cmd.Parameters.Add("@PsRfc", SqlDbType.VarChar).Value = RFC.Text;
                        cmd.Parameters.Add("@PnTipopersona", SqlDbType.TinyInt).Value = TipoPersona.SelectedItem.Value;
                        cmd.Parameters.Add("@PsDiasrevision", SqlDbType.VarChar).Value = DiasRevision.Text;
                        cmd.Parameters.Add("@PsHorariorevision", SqlDbType.VarChar).Value = HorarioRevision.Text;
                        cmd.Parameters.Add("@PsDiaspago", SqlDbType.VarChar).Value = DiasPago.Text;
                        cmd.Parameters.Add("@PsHorariopago", SqlDbType.VarChar).Value = HorarioPago.Text;
                        cmd.Parameters.Add("@PsAuxiliar", SqlDbType.VarChar).Value = AuxiliarContable.SelectedItem.Value;
                        cmd.Parameters.Add("@PnLim_credito", SqlDbType.Money).Value = 0;
                        cmd.Parameters.Add("@PnSaldo_cc", SqlDbType.Money).Value = 0;
                        cmd.Parameters.Add("@PnConsec_mov", SqlDbType.Int).Value = 0;
                        cmd.Parameters.Add("@PdFecha_Alta", SqlDbType.DateTime).Value = DateTime.Now;
                        cmd.Parameters.Add("@PnPlazo", SqlDbType.Int).Value = 0;
                        cmd.Parameters.Add("@PsCorreo_electronico", SqlDbType.VarChar).Value = Correo.Text;
                        cmd.Parameters.Add("@PnNacional", SqlDbType.TinyInt).Value = Nacionalidad.Text;
                        cmd.Parameters.Add("@PnSaldoCondicionado", SqlDbType.Money).Value = 0;
                        cmd.Parameters.Add("@PnTipoCliente", SqlDbType.Int).Value = TipoCliente.SelectedItem.Value;
                        cmd.Parameters.Add("@PnIdbanco", SqlDbType.Int).Value = DBNull.Value;
                        cmd.Parameters.Add("@PsNum_cheque", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PnIdUsuario_cap_limite", SqlDbType.SmallInt).Value = IdUsuario;
                        cmd.Parameters.Add("@PnTipoFacturacion", SqlDbType.TinyInt).Value = DesgloseIva.SelectedItem.Value;
                        cmd.Parameters.Add("@PnIdUsuario_aut_limite", SqlDbType.SmallInt).Value = IdUsuario;
                        cmd.Parameters.Add("@PdFecha_aut_limite", SqlDbType.DateTime).Value = new DateTime(1900, 01, 01);
                        cmd.Parameters.Add("@PnTipo_bloqueo", SqlDbType.TinyInt).Value = 0;
                        cmd.Parameters.Add("@PsPrimer_nombre", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsSegundo_nombre", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsPrimer_apellido", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsSegundo_apellido", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsApellido_casada", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsNombre_comercial", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsNo_cedula", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsMunicipio_cedula", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsZona", SqlDbType.VarBinary).Value = DBNull.Value;
                        cmd.Parameters.Add("@Pspag_web", SqlDbType.VarChar).Value = DireccionWeb.Text;
                        cmd.Parameters.Add("@PnFE_ncliente", SqlDbType.Int).Value = 0;
                        if (GrupoEmpresarial.SelectedItem.Value == "0")
                        {
                            cmd.Parameters.Add("@PnIdGrupo", SqlDbType.Int).Value = DBNull.Value;
                        }
                        else
                        {
                            cmd.Parameters.Add("@PnIdGrupo", SqlDbType.Int).Value = GrupoEmpresarial.SelectedItem.Value;
                        }
                        cmd.Parameters.Add("@PsComplemento_fe", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsAuxiliar_cc", SqlDbType.VarChar).Value = AuxiliarContableCC.SelectedItem.Value;
                        cmd.Parameters.Add("@PnActivo", SqlDbType.Int).Value = 1;
                        cmd.Parameters.Add("@PsPais", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PnIdOpcion", SqlDbType.Int).Value = 0;
                        cmd.Parameters.Add("@PsIpAct", SqlDbType.VarChar).Value = Request.ServerVariables["REMOTE_ADDR"].ToString();
                        cmd.Parameters.Add("@PnEstatus", SqlDbType.Int).Value = 0;
                        cmd.Parameters.Add("@PsMensaje", SqlDbType.VarChar).Value = "";
                        cmd.Parameters["@PnEstatus"].Direction = ParameterDirection.Output;
                        cmd.Parameters["@PsMensaje"].Direction = ParameterDirection.Output;
                        cmd.ExecuteNonQuery();
                        cmd.Dispose();
                    }
                    #endregion
                    #region agrega Zonas Contactos
                    if (IdCliente > 0)
                    {
                        CanastaAgregaContactosViewModel canasta = new CanastaAgregaContactosViewModel();
                        if (Session["CanastaContactos"] != null)
                        {
                            canasta = (Session["CanastaContactos"] as CanastaAgregaContactosViewModel);
                        }
                        foreach (var item in canasta.Contactos)
                        {

                            var existe = (from d in paConContactosCliente(IdUsuario, IdCliente, item.IdContacto).Tables[0].AsEnumerable()
                                          select d).FirstOrDefault();
                            if (existe == null)
                            {
                                using (SqlCommand cmd = new SqlCommand("spa_contactocliente", con))
                                {
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    cmd.Parameters.Add("@Pncliente_id", SqlDbType.Int).Value = IdCliente;
                                    cmd.Parameters.Add("@Pncontacto_id", SqlDbType.Int).Value = item.IdContacto;
                                    cmd.Parameters.Add("@Pspuesto", SqlDbType.VarChar).Value = item.Puesto;
                                    cmd.Parameters.Add("@Pnrelcon_id", SqlDbType.Int).Value = item.IdRelacion;
                                    cmd.Parameters.Add("@PsIpAct", SqlDbType.VarChar).Value = Request.ServerVariables["REMOTE_ADDR"].ToString();
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
                    Session.Remove("cliente_id");
                }
                else
                {
                    con.Open();
                    #region Inserta Proveedor 
                    using (SqlCommand cmd = new SqlCommand("spa_cliente", con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.Add("@PnIdUsuario", SqlDbType.SmallInt).Value = IdUsuario;
                        cmd.Parameters.Add("@PsNombre", SqlDbType.VarChar).Value = Nombre.Text;
                        cmd.Parameters.Add("@PsDomicilio", SqlDbType.VarChar).Value = Calle.Text;
                        cmd.Parameters.Add("@PsColonia", SqlDbType.VarChar).Value = Colonia.Text;
                        cmd.Parameters.Add("@PsCP", SqlDbType.VarChar).Value = CP.Text;
                        cmd.Parameters.Add("@PsMunicipio", SqlDbType.VarChar).Value = Municipio.Text;
                        cmd.Parameters.Add("@PsEstado", SqlDbType.VarChar).Value = Estado.SelectedItem.Text;
                        cmd.Parameters.Add("@PsTelefono1", SqlDbType.VarChar).Value = Telefono.Text;
                        cmd.Parameters.Add("@PsTelefono2", SqlDbType.VarChar).Value = Telefono2.Text;
                        cmd.Parameters.Add("@PsFax", SqlDbType.VarChar).Value = Fax.Text;
                        cmd.Parameters.Add("@PsRfc", SqlDbType.VarChar).Value = RFC.Text;
                        cmd.Parameters.Add("@PnTipopersona", SqlDbType.TinyInt).Value = TipoPersona.SelectedItem.Value;
                        cmd.Parameters.Add("@PsDiasrevision", SqlDbType.VarChar).Value = DiasRevision.Text;
                        cmd.Parameters.Add("@PsHorariorevision", SqlDbType.VarChar).Value = HorarioRevision.Text;
                        cmd.Parameters.Add("@PsDiaspago", SqlDbType.VarChar).Value = DiasPago.Text;
                        cmd.Parameters.Add("@PsHorariopago", SqlDbType.VarChar).Value = HorarioPago.Text;
                        cmd.Parameters.Add("@PsAuxiliar", SqlDbType.VarChar).Value = AuxiliarContable.SelectedItem.Value;
                        cmd.Parameters.Add("@PnLim_credito", SqlDbType.Money).Value = 0;
                        cmd.Parameters.Add("@PnSaldo_cc", SqlDbType.Money).Value = 0;
                        cmd.Parameters.Add("@PnConsec_mov", SqlDbType.Int).Value = 0;
                        cmd.Parameters.Add("@PnPlazo", SqlDbType.Int).Value = 0;
                        cmd.Parameters.Add("@PsCorreo_electronico", SqlDbType.VarChar).Value = Correo.Text;
                        cmd.Parameters.Add("@PnNacional", SqlDbType.TinyInt).Value = Nacionalidad.Text;
                        cmd.Parameters.Add("@PnSaldoCondicionado", SqlDbType.Money).Value = 0;
                        cmd.Parameters.Add("@PnTipoCliente", SqlDbType.Int).Value = TipoCliente.SelectedItem.Value;
                        cmd.Parameters.Add("@PnIdbanco", SqlDbType.Int).Value = DBNull.Value;
                        cmd.Parameters.Add("@PsNum_cheque", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PnIdUsuario_cap_limite", SqlDbType.SmallInt).Value = IdUsuario;
                        cmd.Parameters.Add("@PnTipoFacturacion", SqlDbType.TinyInt).Value = DesgloseIva.SelectedItem.Value;
                        cmd.Parameters.Add("@PnIdUsuario_aut_limite", SqlDbType.SmallInt).Value = IdUsuario;
                        cmd.Parameters.Add("@PdFecha_aut_limite", SqlDbType.DateTime).Value = new DateTime(1900, 01, 01);
                        cmd.Parameters.Add("@PnTipo_bloqueo", SqlDbType.TinyInt).Value = 0;
                        cmd.Parameters.Add("@PsPrimer_nombre", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsSegundo_nombre", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsPrimer_apellido", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsSegundo_apellido", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsApellido_casada", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsNombre_comercial", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsNo_cedula", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsMunicipio_cedula", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsZona", SqlDbType.VarBinary).Value = DBNull.Value;
                        cmd.Parameters.Add("@Pspag_web", SqlDbType.VarChar).Value = DireccionWeb.Text;
                        cmd.Parameters.Add("@PnFE_ncliente", SqlDbType.Int).Value = 0;
                        if (GrupoEmpresarial.SelectedItem.Value == "0")
                        {
                            cmd.Parameters.Add("@PnIdGrupo", SqlDbType.Int).Value = DBNull.Value;
                        }
                        else
                        {
                            cmd.Parameters.Add("@PnIdGrupo", SqlDbType.Int).Value = GrupoEmpresarial.SelectedItem.Value;
                        }
                        cmd.Parameters.Add("@PsComplemento_fe", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PsAuxiliar_cc", SqlDbType.VarChar).Value = AuxiliarContableCC.SelectedItem.Value;
                        cmd.Parameters.Add("@PsPais", SqlDbType.VarChar).Value = "";
                        cmd.Parameters.Add("@PnIdOpcion", SqlDbType.Int).Value = 0;
                        cmd.Parameters.Add("@PsIpAct", SqlDbType.VarChar).Value = Request.ServerVariables["REMOTE_ADDR"].ToString();
                        cmd.Parameters.Add("@PnEstatus", SqlDbType.Int).Value = 0;
                        cmd.Parameters.Add("@PsMensaje", SqlDbType.VarChar).Value = "";
                        cmd.Parameters["@PnEstatus"].Direction = ParameterDirection.Output;
                        cmd.Parameters["@PsMensaje"].Direction = ParameterDirection.Output;
                        returnValue = (int)cmd.ExecuteScalar();
                        cmd.Dispose();
                    }
                    #endregion
                    #region agrega Contactos
                    if (returnValue > 0)
                    {
                        CanastaAgregaContactosViewModel canasta = new CanastaAgregaContactosViewModel();
                        if (Session["CanastaContactos"] != null)
                        {
                            canasta = (Session["CanastaContactos"] as CanastaAgregaContactosViewModel);
                        }
                        foreach (var item in canasta.Contactos)
                        {
                            using (SqlCommand cmd = new SqlCommand("spa_contactocliente", con))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.Add("@Pncliente_id", SqlDbType.Int).Value = returnValue;
                                cmd.Parameters.Add("@Pncontacto_id", SqlDbType.Int).Value = item.IdContacto;
                                cmd.Parameters.Add("@Pspuesto", SqlDbType.VarChar).Value = item.Puesto;
                                cmd.Parameters.Add("@Pnrelcon_id", SqlDbType.Int).Value = item.IdRelacion;
                                cmd.Parameters.Add("@PsIpAct", SqlDbType.VarChar).Value = Request.ServerVariables["REMOTE_ADDR"].ToString();
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
                Session.Remove("CanastaContactos");
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

        NumCliente.Text = "";
        DireccionWeb.Text = "";
        Nombre.Text = "";
        Calle.Text = "";
        Colonia.Text = "";
        CP.Text = "";
        Municipio.Text = "";
        Estado.SelectedValue = "0";
        Telefono.Text = "";
        Telefono2.Text = "";
        Fax.Text = "";
        RFC.Text = "";
        Auxiliar.Text = "";
        AuxiliarCC.Text = "";
        Nacionalidad.Text = "0";
        Correo.Text = "";
        AuxiliarContable.Text = "0";
        AuxiliarContableCC.Text = "0";
        TipoCliente.Text = "0";
        TipoPersona.Text = "0";
        DesgloseIva.Text = "0";
        GrupoEmpresarial.Text = "0";
        DiasRevision.Text = "";
        HorarioRevision.Text = "";
        DiasPago.Text = "";
        HorarioPago.Text = "";
        divCatalogo.Visible = true;
        Editar.Visible = false;
        llenargv();
        gvContactos.DataSource = null;
        gvContactos.DataBind();
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
            DataTable dt = MostrarClientes(IdUsuario, index).Tables[0];
            NumCliente.Text = index.ToString();
            Nombre.Text = dt.Rows[0]["Nombre"].ToString();
            Calle.Text = dt.Rows[0]["domicilio"].ToString();
            Colonia.Text = dt.Rows[0]["colonia"].ToString();
            CP.Text = dt.Rows[0]["cp"].ToString();
            Municipio.Text = dt.Rows[0]["municipio"].ToString();
            Estado.SelectedValue = dt.Rows[0]["estado_id"].ToString();
            Telefono.Text = dt.Rows[0]["telefono1"].ToString();
            Telefono2.Text = dt.Rows[0]["telefono2"].ToString();
            Fax.Text = dt.Rows[0]["fax"].ToString();
            RFC.Text = dt.Rows[0]["rfc"].ToString();
            TipoPersona.SelectedValue = dt.Rows[0]["tipopersona"].ToString();
            DiasRevision.Text = dt.Rows[0]["diasrevision"].ToString();
            HorarioRevision.Text = dt.Rows[0]["horariorevision"].ToString();
            DiasPago.Text = dt.Rows[0]["diaspago"].ToString();
            HorarioPago.Text = dt.Rows[0]["horariopago"].ToString();
            Nacionalidad.SelectedValue = dt.Rows[0]["nacional"].ToString();
            Correo.Text = dt.Rows[0]["correo_electronico"].ToString();
            TipoCliente.SelectedValue = dt.Rows[0]["tipocliente"].ToString();
            DesgloseIva.SelectedValue = dt.Rows[0]["TipoFacturacion"].ToString();
            DireccionWeb.Text = dt.Rows[0]["pag_web"].ToString();
            if (dt.Rows[0]["id_grupo"] == DBNull.Value)
            {
                GrupoEmpresarial.SelectedValue = "0";
            }
            else
            {
                GrupoEmpresarial.SelectedValue = dt.Rows[0]["id_grupo"].ToString();
            }
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
            DataTable dtContactos = paConContactosCliente(IdUsuario, index).Tables[0];
            foreach (DataRow dr in dtContactos.Rows)
            {
                int IdRelacion = string.IsNullOrEmpty(dr["relcon_id"].ToString()) ? 0 : int.Parse(dr["relcon_id"].ToString());
                string Relacion = string.IsNullOrEmpty(dr["relcon_id"].ToString()) ? "" : dr["Relacion"].ToString();
                string NombreContacto = string.IsNullOrEmpty(dr["Contacto"].ToString()) ? "" : dr["Contacto"].ToString();
                string Puesto = string.IsNullOrEmpty(dr["Puesto"].ToString()) ? "" : dr["Puesto"].ToString();
                int IdContacto = string.IsNullOrEmpty(dr["contacto_id"].ToString()) ? 0 : int.Parse(dr["contacto_id"].ToString());

                CanastaAgregaContactosViewModel canasta = new CanastaAgregaContactosViewModel();
                if (Session["CanastaContactos"] == null)
                {
                    canasta.Contactos = new List<ItemContactoViewModel>();
                    ItemContactoViewModel contacto = new ItemContactoViewModel();
                    contacto.IdContacto = IdContacto;
                    contacto.Puesto = Puesto;
                    contacto.NombreContacto = NombreContacto;
                    contacto.IdContacto = IdContacto;
                    canasta.Contactos.Add(contacto);
                }
                else
                {
                    canasta = (Session["CanastaContactos"] as CanastaAgregaContactosViewModel);
                    var existe = canasta.Contactos.Where(x => x.NombreContacto == NombreContacto).FirstOrDefault();
                    if (existe != null)
                    {
                        existe.IdRelacion = IdRelacion;
                        existe.NombreContacto = NombreContacto;
                        existe.IdContacto = IdContacto;
                        existe.NombreContacto = NombreContacto;
                    }
                    else
                    {
                        ItemContactoViewModel contacto = new ItemContactoViewModel();
                        contacto.NombreContacto = NombreContacto;
                        contacto.Puesto = Puesto;
                        contacto.IdContacto = IdContacto;
                        canasta.Contactos.Add(contacto);
                    }
                }
                canasta.Items = canasta.Contactos.Count();
                Session["CanastaContactos"] = canasta;
                gvContactos.DataSource = ConvertToDataTable(canasta.Contactos);
                gvContactos.DataBind();
            }
            Session.Add("cliente_id", index);
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
                        using (SqlCommand cmd = new SqlCommand("Spd_cliente", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;
                            cmd.Parameters.Add("@PnIdCliente", SqlDbType.Int).Value = index;
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
        NumCliente.Text = "";
        DireccionWeb.Text = "";
        Nombre.Text = "";
        Calle.Text = "";
        Colonia.Text = "";
        CP.Text = "";
        Municipio.Text = "";
        Estado.SelectedValue = "0";
        Telefono.Text = "";
        Telefono2.Text = "";
        Fax.Text = "";
        RFC.Text = "";
        Auxiliar.Text = "";
        AuxiliarCC.Text = "";
        Nacionalidad.Text = "0";
        Correo.Text = "";
        AuxiliarContable.Text = "0";
        AuxiliarContableCC.Text = "0";
        TipoCliente.Text = "0";
        TipoPersona.Text = "0";
        DesgloseIva.Text = "0";
        GrupoEmpresarial.Text = "0";
        DiasRevision.Text = "";
        HorarioRevision.Text = "";
        DiasPago.Text = "";
        HorarioPago.Text = "";
        divCatalogo.Visible = false; Editar.Visible = true; Session.Remove("cliente_id");
        gvContactos.DataSource = null;
        gvContactos.DataBind();
    }

    protected void cancelar_Click(object sender, EventArgs e)
    {
        divCatalogo.Visible = true;
        Editar.Visible = false;
        btnAgregar.Visible = true;

        Session.Remove("CanastaContactos");
        Session.Remove("cliente_id");
        gvContactos.DataSource = null;
        gvContactos.DataBind();
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
        DataTable model = MostrarClientes(IdUsuario: IdUsuario, Descripcion: txtBuscar.Text).Tables[0];
        gv.DataSource = model;
        gv.DataBind();

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

    protected void btnContacto_Click(object sender, EventArgs e)
    {
        int IdContacto = int.Parse(NombreContacto.SelectedItem.Value);
        string nombreContacto = NombreContacto.SelectedItem.Text;
        CanastaAgregaContactosViewModel canasta = new CanastaAgregaContactosViewModel();
        if (Session["CanastaContactos"] == null)
        {
            canasta.Contactos = new List<ItemContactoViewModel>();
            ItemContactoViewModel contacto = new ItemContactoViewModel();
            contacto.IdContacto = IdContacto;
            contacto.NombreContacto = NombreContacto.SelectedItem.Text;
            contacto.Puesto = txtPuesto.Text;
            contacto.IdRelacion = int.Parse(ddlRelacion.SelectedItem.Value);
            contacto.Relacion = ddlRelacion.SelectedItem.Text;
            canasta.Contactos.Add(contacto);
        }
        else
        {
            canasta = (Session["CanastaContactos"] as CanastaAgregaContactosViewModel);
            var existe = canasta.Contactos.Where(x => x.NombreContacto == NombreContacto.SelectedItem.Text && x.IdContacto == IdContacto).FirstOrDefault();
            if (existe != null)
            {
                existe.IdContacto = IdContacto;
                existe.NombreContacto = NombreContacto.SelectedItem.Text;
                existe.Puesto = txtPuesto.Text;
                existe.IdRelacion = int.Parse(ddlRelacion.SelectedItem.Value);
                existe.Relacion = ddlRelacion.SelectedItem.Text;
            }
            else
            {
                ItemContactoViewModel contacto = new ItemContactoViewModel();
                contacto.IdContacto = IdContacto;
                contacto.NombreContacto = NombreContacto.SelectedItem.Text;
                contacto.Puesto = txtPuesto.Text;
                contacto.IdRelacion = int.Parse(ddlRelacion.SelectedItem.Value);
                contacto.Relacion = ddlRelacion.SelectedItem.Text;
                canasta.Contactos.Add(contacto);
            }
        }
        canasta.Items = canasta.Contactos.Count();
        Session["CanastaContactos"] = canasta;

        gvContactos.DataSource = ConvertToDataTable(canasta.Contactos);
        gvContactos.DataBind();
        txtPuesto.Text = "";
        ddlRelacion.SelectedValue = "0";

    }


    ///Emular Servicio WEB
    ///
    [WebMethod]
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

    protected void gvContactos_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        int index = Convert.ToInt32(e.CommandArgument);

        //       GridViewRow row = gvContactos.Rows[index];

        int IdCliente = 0;
        if (Session["cliente_id"] == null)
        {
            IdCliente = 0;
        }
        else
        {
            IdCliente = int.Parse(Session["cliente_id"].ToString());
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
                        using (SqlCommand cmd = new SqlCommand("Spd_contactocliente", con))
                        {
                            cmd.CommandType = CommandType.StoredProcedure;

                            cmd.Parameters.Add("@PnId_Contacto", SqlDbType.Int).Value = index;
                            cmd.Parameters.Add("@PnId_Cliente", SqlDbType.Int).Value = IdCliente;
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

                            CanastaAgregaContactosViewModel canasta = new CanastaAgregaContactosViewModel();
                            if (Session["CanastaContactos"] != null)
                            {
                                canasta = (Session["CanastaContactos"] as CanastaAgregaContactosViewModel);
                                if (canasta != null)
                                {
                                    canasta.Contactos.Remove(canasta.Contactos.Where(x => x.IdContacto == index).FirstOrDefault());
                                }
                                canasta.Items = canasta.Contactos.Count();
                                Session["CanastaContactos"] = canasta;
                                gvContactos.DataSource = ConvertToDataTable(canasta.Contactos);
                                gvContactos.DataBind();
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