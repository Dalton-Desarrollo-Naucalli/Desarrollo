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
public partial class Frm_FacturasSeguros : System.Web.UI.Page
{
    private WsSeguridad.Seguridad Servicio = new WsSeguridad.Seguridad();
    WsFuncionalidad.Funcionalidad fnc = new WsFuncionalidad.Funcionalidad();
    public string vsistema = System.Configuration.ConfigurationManager.AppSettings["sistema"];
    public string vempresa = System.Configuration.ConfigurationManager.AppSettings["empresa"];

    #region VARIABLES
    string Error = "", nombreXml = "", nomrepUUID = "", nomcon = "ConexionDBS", resFileName = "", destFileuuid = "";
    Decimal costoPoliza = 0.0M, total = 0.0M, iva = 0.0M;
    String aseguradora = "", f_Emision = "", f_Vencimiento = "", no_Poliza = "", factura = "", rfcemisor = "", rfcreceptor = "", uuid = "";
    DateTime f_vencimiento, f_emision;
    String conpagos = "";
    int endoso = 0, id = 0, repite = 0, band = 0;
    const string Paso = "~/Archivos/";
    int sumaFacturas = 0, sf = 0, sf1 = 0;
    bool bandera=false;
    ASPxSummaryItem facturasSum = new ASPxSummaryItem();
    GridViewCommandColumn ColumnaBtns = new GridViewCommandColumn();
    GridViewDataTextColumn ColumnaGrid = new GridViewDataTextColumn();
    GridViewDataCheckColumn chbox = new GridViewDataCheckColumn();
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
            VerificaAccesos("Frm_FacturasSeguros");
        }
        else
        {
            LlenaGridPrincipal();
            LlenaGridNoMatch();
            LlenaGridFacturasNoAutorizadas();
            SumTotFacturas();
        }
    }
    protected void calRenombrar_Callback(object source, DevExpress.Web.CallbackEventArgs e)
    {
        #region Old Code
        //string RUTA = "";
        //string nombre = "";
        //string RUTABUSQUEDA = "";

        //RUTABUSQUEDA = @"http://sianvt03.cloudapp.net:88/ProyectoDalton/XMLS/Contenedor/";
        //int existe = 0, existen = 0, exi = 0;

        ////string files = Server.MapPath("~/Archivos/");
        ////string files = Server.MapPath(RUTABUSQUEDA + "*.xml");
        ////Path.GetFileName("http://sianvt03.cloudapp.net:88/ProyectoDalton/XMLS/Contenedor");
        //string[] files = System.IO.Directory.GetFiles(RUTABUSQUEDA + "/", "*.xml");
        //fnc.FacturasSeg_EliminaTmp(wsConexion: nomcon);
        //foreach (string s in files)
        //{
        //    RUTA = s;
        //    nombre = Path.GetFileName(s);
        //    if (leexml(RUTA) == "")
        //    {
        //        //calRenombrar.JSProperties["cpError"] = " el archivo " + nombre + " no contiene la estructura de un xml";
        //        string xxx = @"http://sianvt03.cloudapp.net:88/ProyectoDalton/XMLS/EnRevision";
        //        string sourceFile1 = RUTA;
        //        string destFile1 = System.IO.Path.Combine(xxx, nombre);
        //        if (!System.IO.Directory.Exists(xxx))
        //        {
        //            System.IO.Directory.CreateDirectory(xxx);
        //        }
        //        System.IO.File.Copy(sourceFile1, destFile1, true);
        //        System.IO.File.Delete(sourceFile1);
        //    }
        //    else
        //    {
        //        //CONSULTA A LA TABLA PARA VISUALIZAR SI NO ESTA REPETIDO EL UUID
        //        if (ConsultaFactura(uuid) != "")
        //        {
        //            // calRenombrar.JSProperties["cpError"] = "Error al procesar el archivo " + nombre;
        //            string xxx = @"http://sianvt03.cloudapp.net:88/ProyectoDalton/XMLS/UUIDREPETIDO";
        //            string sourceFile1 = RUTA;
        //            destFileuuid = System.IO.Path.Combine(xxx, nombre);
        //            if (!System.IO.Directory.Exists(xxx))
        //            {
        //                System.IO.Directory.CreateDirectory(xxx);
        //            }
        //            System.IO.File.Copy(sourceFile1, destFileuuid, true);
        //            if (nomrepUUID != "")
        //            {
        //                System.IO.File.Delete(sourceFile1);
        //                existen = 1;
        //                band = 0;
        //                repite = 1;
        //            }
        //            else
        //            {
        //                repite = 1;
        //                band = 1;
        //            }
        //            nomrepUUID = nomrepUUID + "\n - " + nombre;
        //            //return;
        //        }
        //        else
        //        {
        //            //INSERCION A LA TABLA CON LOS DATOS TOMADOS DEL XML

        //            string grabaxmlx = "http://sianvt03.cloudapp.net:88/ProyectoDalton/XMLS/RGUARDADO" + rfcemisor;
        //            string valx = grabaxmlx + "/" + nombre;
        //            if (!File.Exists(valx))
        //            {
        //                bool conpago = true;
        //                fnc.FacturasSeg_Alta(ID: id, Factura: factura, NoPoliza: no_Poliza, Aseguradora: aseguradora, F_vencimiento: f_Vencimiento, F_emision: f_Emision, NoEndoso: endoso, CostoDePoliza: costoPoliza, iva: iva, CostoTotal: total, UUID: uuid, CONFIRMARPAGO: conpago, wsConexion: nomcon);
        //                if (nomrepUUID == "")
        //                {
        //                    repite = 0;
        //                }
        //                else
        //                {
        //                    repite = 1;
        //                    band = 0;
        //                    existen = 1;
        //                    exi = 1;
        //                }
        //            }
        //        }
        //        //copia de archivos
        //        string grabaxml = "http://sianvt03.cloudapp.net:88/ProyectoDalton/XMLS/RGUARDADO" + rfcemisor;
        //        string val = grabaxml + "/" + nombre;

        //        if (File.Exists(val))
        //        {
        //            existe = 1;
        //            //calRenombrar.JSProperties["cpError"] = "Ya existe un archivo con nombre " + nombre + " favor de verificar ";                    
        //            //string xxx = @"C:\XMLS\Contenedor\EnRevision";
        //            string xxx = @"http://sianvt03.cloudapp.net:88/ProyectoDalton/XMLS/RGUARDADO";
        //            string sourceFile1 = RUTA;
        //            string destFile1 = System.IO.Path.Combine(xxx, nombre);
        //            if (!System.IO.Directory.Exists(xxx))
        //            {
        //                System.IO.Directory.CreateDirectory(xxx);
        //            }
        //            if (band == 1 && repite == 1)
        //            {
        //                System.IO.File.Copy(sourceFile1, destFile1, true);
        //                System.IO.File.Delete(sourceFile1);
        //            }
        //            if (repite == 0)
        //            {
        //                System.IO.File.Delete(sourceFile1);
        //            }
        //            //return;
        //            nombreXml = nombreXml + "\n - " + nombre;
        //        }
        //        else
        //        {
        //            string sourceFile = RUTA;
        //            string destFile = System.IO.Path.Combine(grabaxml, nombre);
        //            if (!System.IO.Directory.Exists(grabaxml))
        //            {
        //                System.IO.Directory.CreateDirectory(grabaxml);
        //            }
        //            if (nomrepUUID == "")
        //            {
        //                System.IO.File.Copy(sourceFile, destFile, true);
        //                System.IO.File.Delete(sourceFile);
        //            }
        //            if (band == 1 && repite == 1)
        //            {
        //                System.IO.File.Copy(sourceFile, destFile, true);
        //                System.IO.File.Delete(sourceFile);
        //                if (!System.IO.Directory.Exists(destFile))
        //                {
        //                    System.IO.File.Delete(val);
        //                }
        //            }
        //            if (band == 0 && repite == 1 && existen != 1)
        //            {
        //                System.IO.File.Copy(sourceFile, destFile, true);
        //                System.IO.File.Delete(sourceFile);
        //            }
        //            if (exi == 1)
        //            {
        //                System.IO.File.Copy(sourceFile, destFile, true);
        //                System.IO.File.Delete(sourceFile);
        //            }
        //        }
        //    }
        //}
        //if (existe == 1)
        //{
        //    if (repite == 1)
        //    { calRenombrar.JSProperties["cpError"] = "Ya existe un archivo con nombre: " + nombreXml + " \n Y los siguientes archivos esta repetido el UUID " + nomrepUUID + "\nFavor de verificar \n \n                            ...Proceso terminado"; }
        //    else
        //    { calRenombrar.JSProperties["cpError"] = "Ya existe un archivo con nombre: " + nombreXml + " \n No se almacenara(n) en el sistema. \n \n                            ...Proceso terminado"; }
        //}
        //else
        //{
        //    if (files.Count() == 0)
        //    { calRenombrar.JSProperties["cpError"] = "No ha cargado ningun archivo XML en la carpeta Contendor. \n Favor de verificar"; }
        //    else
        //    {
        //        if (repite == 1)
        //        { calRenombrar.JSProperties["cpError"] = "los siguientes archivos esta repetido el UUID " + nomrepUUID + "\n Favor de verificar \n \n                            ...Proceso terminado"; }
        //        else
        //        { calRenombrar.JSProperties["cpError"] = "OK"; }
        //    }
        //} 
        #endregion
    }
    protected void gvFacSeg_BatchUpdate(object sender, DevExpress.Web.Data.ASPxDataBatchUpdateEventArgs e)
    {
        foreach (var args in e.UpdateValues)
        {
            UpdateItem(args.Keys, args.NewValues);
        }

        e.Handled = true;
        this.gvFacSeg.DataSource = null;
        this.gvFacSeg.DataBind();
        this.gvFacSeg.Selection.UnselectAll();
        this.gvFacSeg.CancelEdit();
        this.gvFacSeg.FocusedRowIndex = -1;

        LlenaGridPrincipal();

        this.gvNoMatch.DataSource = null;
        this.gvNoMatch.DataBind();
        this.gvNoMatch.Selection.UnselectAll();
        this.gvNoMatch.CancelEdit();
        this.gvNoMatch.FocusedRowIndex = -1;
        LlenaGridNoMatch();

        this.gvNoAuto.DataSource = null;
        this.gvNoAuto.DataBind();
        this.gvNoAuto.Selection.UnselectAll();
        this.gvNoAuto.CancelEdit();
        this.gvNoAuto.FocusedRowIndex = -1;
        LlenaGridFacturasNoAutorizadas();
        
        SumTotFacturas();
    }
    protected void gvNoMatch_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
    {
        if (e.Parameters.Equals("Actualizar"))
        {
            LlenaGridNoMatch();
        }
                
    }
    protected void gvNoAuto_CustomCallback(object sender, ASPxGridViewCustomCallbackEventArgs e)
    {
        if (e.Parameters.Equals("Actualizar"))
        {
            LlenaGridFacturasNoAutorizadas();
        }              
    }

    #region METODOS

    /// <summary>
    /// Método utilizado para verificar si el UUID existe en la tabla de tbl_FacturasSeguros
    /// </summary>
    public string ConsultaFactura(string uuID)
    {
        string cat = "", consulta;
        DataSet DSTipoDato;
        DataTable dtTipoDato;
        consulta = "SELECT UUID, ConfirmarPago FROM tbl_FacturasSeguros where UUID='" + uuID + "'";
        DSTipoDato = fnc.ObtenDataSet("obtenCampo", consulta, "ConexionDBS");
        dtTipoDato = DSTipoDato.Tables[0];
        foreach (DataRow row in dtTipoDato.Rows)
        {
            cat = row["UUID"].ToString();
        }
        return cat;
    }

    /// <summary>
    /// Configurar Grid View Principal
    /// </summary>
    public void LlenaGridPrincipal()
    {
        DataSet tabla = new DataSet();
        DataTable dtOpciones = new DataTable();
        String vNombreColumna = "";
        String vfieldName = "";
        int NumeroColunas = 0;
        int NumeroRenglones = 0;

        ASPxSummaryItem footerCount = new ASPxSummaryItem();
        ASPxSummaryItem footerTot = new ASPxSummaryItem();
        ASPxSummaryItem footerTot1 = new ASPxSummaryItem();
                
        GridViewBandColumn bandColumn = new GridViewBandColumn();
        GridViewBandColumn bandColumn1 = new GridViewBandColumn();
        GridViewCommandColumn colcheck = new GridViewCommandColumn();
        DataSet DS = new DataSet();
        DataTable dt = new DataTable();

        tabla = fnc.FacturasSeg_SelectG(wsConexion: nomcon);
        dtOpciones = tabla.Tables["Table"];

        //'GRID PRINCIPAL "BOTONES"
        ColumnaBtns.ShowNewButtonInHeader = true;
        ColumnaBtns.ShowDeleteButton = true;
        ColumnaBtns.ShowEditButton = true;
        ColumnaBtns.FixedStyle = GridViewColumnFixedStyle.Left;
        gvFacSeg.Columns.Clear();

        if (tabla.Tables.Count > 0)
        {
            if (tabla.Tables[0].Rows.Count > 0)
            {
                #region Generador de columnas
                NumeroColunas = tabla.Tables[0].Columns.Count - 1;
                NumeroRenglones = tabla.Tables[0].Rows.Count - 1;

                for (int j = 0; j <= tabla.Tables[0].Columns.Count - 1; j++)
                {
                    vNombreColumna = tabla.Tables[0].Columns[j].ColumnName;
                    vfieldName = tabla.Tables[0].Columns[j].ColumnName;
                    ColumnaGrid = new GridViewDataTextColumn();
                    ColumnaGrid.Caption = vNombreColumna;
                    if (ColumnaGrid.Caption == "ID")
                    {
                        ColumnaGrid.Visible = false;
                        //ColumnaGrid.EditFormSettings.Visible = DefaultBoolean.False;
                    }
                    if (ColumnaGrid.Caption == "Poliza")
                    {

                        //ColumnaGrid.CellStyle.ForeColor = Color.Green;
                        //ColumnaGrid.EditFormSettings.Visible = DefaultBoolean.False;
                        ColumnaGrid.ReadOnly = true;
                    }
                    if (ColumnaGrid.Caption == "importeTotal")
                    {
                        ColumnaGrid.CellStyle.ForeColor = Color.Red;
                        ColumnaGrid.PropertiesTextEdit.DisplayFormatString = "c";
                        ColumnaGrid.ReadOnly = true;
                    }
                    if (ColumnaGrid.Caption == "-----")
                    {
                        ColumnaGrid.CellStyle.BackColor = Color.YellowGreen;
                        ColumnaGrid.Settings.AllowAutoFilter = DefaultBoolean.False;
                        ColumnaGrid.Settings.ShowFilterRowMenu = DefaultBoolean.False;
                        ColumnaGrid.Settings.ShowInFilterControl = DefaultBoolean.False;
                        ColumnaGrid.Width = 50;
                        ColumnaGrid.ReadOnly = true;
                        ColumnaGrid.EditFormSettings.Visible = DefaultBoolean.False;
                    }
                    if (ColumnaGrid.Caption == "Factura")
                    {
                        //ColumnaGrid.ReadOnly = true;    
                        //ColumnaGrid.CellStyle.ForeColor = Color.Green;
                        //ColumnaGrid.EditFormSettings.Visible = DefaultBoolean.False;
                        ColumnaGrid.ReadOnly = true;
                    }
                    if (ColumnaGrid.Caption == "Poliza1")
                    {

                        //ColumnaGrid.CellStyle.ForeColor = Color.Green;
                        //ColumnaGrid.EditFormSettings.Visible = DefaultBoolean.False;
                        ColumnaGrid.ReadOnly = true;
                    }

                    if (ColumnaGrid.Caption == "importeTotal1")
                    {
                        ColumnaGrid.CellStyle.ForeColor = Color.Red;
                        ColumnaGrid.PropertiesTextEdit.DisplayFormatString = "c";
                        //ColumnaGrid.EditFormSettings.Visible = DefaultBoolean.False;
                        ColumnaGrid.ReadOnly = true;
                    }
                    if (ColumnaGrid.Caption == "ConfirmarPago")
                    {
                        ColumnaGrid.Visible = false;

                        chbox.FieldName = "ConfirmarPago";
                        chbox.PropertiesEdit.ClientInstanceName = "chbConfirmarPago";
                        //chbox.PropertiesCheckEdit.ClientInstanceName = "chbConfirmarPago1";
                        //chbox.Name = "chbConfirmarPago";
                        chbox.ReadOnly = true;
                        gvFacSeg.Columns.Add(chbox);


                        //colcheck.ShowSelectCheckbox = true;
                        //colcheck.Caption = "ConfirmarPago";
                        //colcheck.ShowInCustomizationForm = true;

                        //colcheck.SelectAllCheckboxMode = GridViewSelectAllCheckBoxMode.AllPages;

                        //gvFacSeg.SettingsPager.EnableAdaptivity = true;
                        //gvFacSeg.Styles.Header.Wrap = DefaultBoolean.True;

                    }

                    ColumnaGrid.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                    ColumnaGrid.FieldName = vfieldName;
                    //ColumnaGridGL.Width = 70

                    gvFacSeg.Columns.Add(ColumnaGrid);
                    VerificaAccesos("Frm_FacturasSeguros");
                }

                //bandColumn.Caption = "Poliza";
                //bandColumn.ShowInCustomizationForm = true;
                //bandColumn.Name = "Poliza";
                //bandColumn.VisibleIndex = 1;
                //bandColumn1.Columns.Add(ColumnaGrid);

                //gvFacSeg.Columns.Add(bandColumn1); 
                #endregion
                #region Datos
                sf = Convert.ToInt32(tabla.Tables[0].Rows.Count);
                gvFacSeg.DataSource = tabla;
                gvFacSeg.DataBind();

                //gvFacSeg.Selection.SelectAll();
                //gvFacSeg.Columns.Add(colcheck);                

                footerCount.FieldName = "Poliza";
                footerCount.ShowInColumn = "Poliza";
                footerCount.SummaryType = DevExpress.Data.SummaryItemType.Count;
                footerCount.DisplayFormat = "Factura(s): {0}";

                footerTot.FieldName = "importeTotal";
                footerTot.ShowInColumn = "importeTotal";
                footerTot.SummaryType = DevExpress.Data.SummaryItemType.Sum;
                footerTot.DisplayFormat = "Total: {0:c}";

                footerTot1.FieldName = "importeTotal1";
                footerTot1.ShowInColumn = "importeTotal1";
                footerTot1.SummaryType = DevExpress.Data.SummaryItemType.Sum;
                footerTot1.DisplayFormat = "Total: {0:c}";

                gvFacSeg.TotalSummary.Clear();
                gvFacSeg.TotalSummary.Add(footerCount, footerTot, footerTot1);

                //gvFacSeg.SettingsText.CommandBatchEditUpdate = "Validar";
                //gvFacSeg.SettingsText.CommandBatchEditCancel = "Cancelar cambios";
                gvFacSeg.SettingsEditing.Mode = GridViewEditingMode.Batch;
                #endregion
            }
        }
    }

    /// <summary>
    /// Configurar Grid View No Match
    /// </summary>
    public void LlenaGridNoMatch()
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

        tabla = fnc.FacturasSeg_SelectGNoM(wsConexion: nomcon);
        dtOpciones = tabla.Tables["Table"];

        gvNoMatch.Columns.Clear();
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

                    if (ColumnaGrid.Caption == "importeTotal")
                    {
                        ColumnaGrid.PropertiesTextEdit.DisplayFormatString = "c";
                    }

                    ColumnaGrid.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                    ColumnaGrid.FieldName = vfieldName;
                    //ColumnaGridGL.Width = 70
                    gvNoMatch.Columns.Add(ColumnaGrid);
                }
            }
        }

        if (tabla.Tables.Count > 0)
        {
            if (tabla.Tables[0].Rows.Count > 0)
            {
                sf1 = Convert.ToInt32(tabla.Tables[0].Rows.Count);
                gvNoMatch.DataSource = tabla;
                gvNoMatch.DataBind();
                
                gvNoMatch.SettingsPager.EnableAdaptivity = true;
                gvNoMatch.Settings.ShowFooter = true;

                footerCountf.FieldName = "Factura";
                footerCountf.ShowInColumn = "Factura";
                footerCountf.SummaryType = DevExpress.Data.SummaryItemType.Count;
                footerCountf.DisplayFormat = "Factura(s): {0}";

                // sf1 = Convert.ToInt32(footerCountf.DisplayFormat = "Factura(s): {0}");
                footerTot.FieldName = "importeTotal";
                footerTot.ShowInColumn = "importeTotal";
                footerTot.SummaryType = DevExpress.Data.SummaryItemType.Sum;
                footerTot.DisplayFormat = "Total: {0:c}";

                gvNoMatch.TotalSummary.Clear();
                gvNoMatch.TotalSummary.Add(footerCountf, footerTot);

                gvNoMatch.Caption = "FACTURAS NO CONCILIADAS";
            }
        }
    }

    /// <summary>
    /// Configurar Grid View No Match
    /// </summary>
    public void LlenaGridFacturasNoAutorizadas()
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

        tabla = fnc.FacturasSeg_SelectFacNoAuto(wsConexion: nomcon);
        dtOpciones = tabla.Tables["Table"];
        
        gvNoAuto.Columns.Clear();
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

                    if (ColumnaGrid.Caption == "importeTotal")
                    {
                        ColumnaGrid.PropertiesTextEdit.DisplayFormatString = "c";
                    }

                    ColumnaGrid.HeaderStyle.HorizontalAlign = HorizontalAlign.Center;
                    ColumnaGrid.FieldName = vfieldName;
                    //ColumnaGridGL.Width = 70
                    gvNoAuto.Columns.Add(ColumnaGrid);
                }
            }
        }
        if (tabla.Tables.Count > 0)
        {
            if (tabla.Tables[0].Rows.Count > 0)
            {
                //sf1 = Convert.ToInt32(tabla.Tables[0].Rows.Count);
                gvNoAuto.DataSource = tabla;
                gvNoAuto.DataBind();
                //gvNoAuto.Columns.Add(ColumnaBtns);

                gvNoAuto.SettingsPager.EnableAdaptivity = true;
                gvNoAuto.Settings.ShowFooter = true;

                footerCountf.FieldName = "Factura";
                footerCountf.ShowInColumn = "Factura";
                footerCountf.SummaryType = DevExpress.Data.SummaryItemType.Count;
                footerCountf.DisplayFormat = "Factura(s): {0}";

                // sf1 = Convert.ToInt32(footerCountf.DisplayFormat = "Factura(s): {0}");
                footerTot.FieldName = "importeTotal";
                footerTot.ShowInColumn = "importeTotal";
                footerTot.SummaryType = DevExpress.Data.SummaryItemType.Sum;
                footerTot.DisplayFormat = "Total: {0:c}";

                gvNoAuto.TotalSummary.Clear();
                gvNoAuto.TotalSummary.Add(footerCountf, footerTot);

                gvNoAuto.Caption = "FACTURAS NO AUTORIZADAS";
            }
        }
    }
   
    /// <summary>
    /// Método utilizado para la suma total de las facturas que se presentan en pantalla
    /// </summary>
    public void SumTotFacturas()
    {
        sumaFacturas = sf + sf1;
        //calRenombrar.JSProperties["cpArchivos"] = sumaFacturas;
        gvFacSeg.JSProperties["cpArchivos"] = sumaFacturas;
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
                        //ColumnaGrid.ShowNewButtonInHeader = true;
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

    #region BATCH
    protected GridDataItem UpdateItem(OrderedDictionary keys, OrderedDictionary newValues)
    {
        var credID = Convert.ToInt32(keys["ID"]);
        //var idF = Convert.ToDateTime(keys["fechaVigencia"]);
        //var idM = Convert.ToInt32(keys["idModelo"]);
        var item = GridData.First(i => i.id == credID);
        //var item = new GridDataItem();
        //BanderaInsUpd = 2;
        //LoadNewValues(item, newValues, BanderaInsUpd);
        LoadNewValues(item, newValues);
        return item;
    }
    protected List<GridDataItem> GridData
    {
        get
        {
            var key = "34FAA454-CF92-4882-9401-93F6AAE81277";
            if (!IsPostBack || Session[key] == null)
                Session[key] = Enumerable.Range(0, 3000).Select(i => new GridDataItem
                {
                    id = Convert.ToInt32(i),
                    Poliza = null,
                    CostoTotal = 0,
                    PolizaTemp = null,
                    ConfirmarPago = false
                    //fechaVigencia = new DateTime(2013 + i, 12, 16),
                    //idModelo = 0

                }).ToList();
            return (List<GridDataItem>)Session[key];
        }
    }
    public class GridDataItem
    {
        public int id { get; set; }
        public string Poliza { get; set; }
        public decimal CostoTotal { get; set; }
        public string PolizaTemp { get; set; }
        public Boolean ConfirmarPago { get; set; }

    }
    protected void LoadNewValues(GridDataItem item, OrderedDictionary values)
    {
        //int BanderaIdConcepto = 0;
        //int BanderaIdProcedimiento = 0;
        //try
        //{
        //    item.idConcepto = Int32.Parse(values["concepto"].ToString());

        //}
        //catch (FormatException e)
        //{
        //    BanderaIdConcepto = 1;
        //}
        //try
        //{
        //    item.idProcedimiento = Convert.ToInt16(values["procedimiento"]);


        //}
        //catch (FormatException e)
        //{
        //    BanderaIdProcedimiento = 1;
        //}


        // item.id = Convert.ToInt32(values["ID"]);
        item.id = item.id;
        //if (BanderaIdConcepto == 1)
        //    item.idConcepto = Int32.Parse(values["idConcepto"].ToString());
        item.Poliza = Convert.ToString(values["Poliza"]);
        //if (BanderaIdProcedimiento == 1)
        //    item.idProcedimiento = Convert.ToInt16(values["idProcedimiento"]);
        //item.esConsolidado = Convert.ToByte(values["esConsolidado"]);
        //item.fechaVigencia = Convert.ToDateTime(values["fechaVigencia"]);
        item.CostoTotal = Convert.ToDecimal(values["importeTotal"]);

        item.PolizaTemp = Convert.ToString(values["Poliza1"]);
        item.ConfirmarPago = Convert.ToBoolean(values["ConfirmarPago"]);


        //Nomina.Rhin.Entities.Catalogo.nomModelosSecuencia ModeloSecuencia = new Nomina.Rhin.Entities.Catalogo.nomModelosSecuencia();

        Int32 idcred = 0;
        String poliza = "";
        decimal importeTotal = 0.0M;
        String polizaTemp = "";
        Boolean confirmarpago;

        idcred = item.id;
        poliza = item.Poliza;
        importeTotal = item.CostoTotal;
        polizaTemp = item.PolizaTemp;
        confirmarpago = item.ConfirmarPago;

        fnc.FacturasSeg_Editar(ID: idcred, Poliza: poliza, CostoTotal: importeTotal, PolizaTemp: polizaTemp,confirmarPago: confirmarpago, wsConexion: nomcon);

        gvFacSeg.JSProperties["cpCambio"] = "ok";

        //if (bandera == 1)
        //{
        //    object InsertRecGpoPagoConceptos = Nomina.Rhin.Business.Catalogo.nomModelosSecuencia.Insertar("rhin", ModeloSecuencia, ref error);
        //    if (error.Estatus > 0)
        //    {
        //        messageModelosSecuencia(7, error.Mensaje);

        //    }

        //    else
        //    {

        //        messageModelosSecuencia(2);

        //    }
        //}

        //else if (bandera == 2)
        //{

        //    object UpdateRecGpoPagoConceptos = Nomina.Rhin.Business.Catalogo.nomModelosSecuencia.Actualizar("rhin", ModeloSecuencia, ref error);
        //    if (error.Estatus > 0)
        //    {
        //        messageModelosSecuencia(7, error.Mensaje);

        //    }

        //    else
        //    {

        //        messageModelosSecuencia(3);

        //    }
        //}


    }
    #endregion

    protected void UploadControl_FileUploadComplete(object sender, FileUploadCompleteEventArgs e)
    {
        try
        {
            //Reemplazar el siguiente codigo por
            //la informacion de la base de datos (Tabla: SAC_Cat_NodoSeguros)
            using (var reader = XmlReader.Create(e.UploadedFile.FileContent))
            {
                while (reader.Read())
                {
                    if (reader.IsStartElement())
                    {
                        switch (reader.Name.ToLower())
                        {
                            case "cfdi:comprobante":
                                costoPoliza = Convert.ToDecimal(reader["subTotal"]);
                                total = Convert.ToDecimal(reader["total"]);
                                factura = reader["serie"]?.ToString() + reader["folio"]?.ToString();
                                break;
                            case "cfdi:traslado":
                                iva = Convert.ToDecimal(reader["importe"]);
                                break;
                            case "aba:encabezado":
                                aseguradora = reader["RazonSocialABA"].ToString();
                                f_emision = Convert.ToDateTime(reader["FechaEmision"].ToString());
                                f_Emision = f_emision.ToString("yyyy-MM-dd");
                                endoso = Convert.ToInt32(reader["Endoso"].ToString());
                                break;
                            case "if:encabezado":
                                f_vencimiento = Convert.ToDateTime(reader["PeriodoHasta"].ToString());
                                f_Vencimiento = f_vencimiento.ToString("yyyy-MM-dd");
                                no_Poliza = reader["NumeroPoliza"].ToString();
                                factura = reader["SerieFolio"].ToString();
                                break;
                            case "cfdi:emisor":
                                rfcemisor = reader["rfc"].ToString();
                                break;
                            case "cfdi:receptor":
                                rfcreceptor = reader["rfc"].ToString();
                                break;
                            case "tfd:timbrefiscaldigital":
                                uuid = reader["UUID"].ToString().Trim();
                                break;
                            case "referencias":
                                no_Poliza = reader["NumPoliza"].ToString();
                                f_Vencimiento = reader["FechaVencimiento"].ToString();
                                aseguradora = reader["Aseguradora"].ToString();
                                break;
                        }
                    }
                }

                if (!string.IsNullOrWhiteSpace(uuid) && !string.IsNullOrWhiteSpace(rfcemisor)
                    && !string.IsNullOrWhiteSpace(rfcreceptor) && !string.IsNullOrWhiteSpace(factura)
                    && !string.IsNullOrWhiteSpace(f_Vencimiento) && !string.IsNullOrWhiteSpace(aseguradora))
                {
                    var resultado = ConsultaFactura(uuid);

                    if (string.IsNullOrWhiteSpace(resultado))
                    {
                        var responseInsert = fnc.FacturasSeg_Alta(
                            id,
                            factura,
                            no_Poliza,
                            aseguradora,
                            f_Vencimiento,
                            f_Emision,
                            endoso,
                            costoPoliza,
                            iva,
                            total,
                            uuid,
                            false,
                            nomcon);

                        if (responseInsert > 0)
                        {
                            e.ErrorText = $"Archivo registrado: {e.UploadedFile.FileName}. UUID: {uuid}";
                        }
                    }
                }

            }
        }
        catch (Exception ex)
        {
            e.ErrorText = $"Archivo: {e.UploadedFile.FileName} - {ex.ToString()}";
        }
        
        //Revisar el modelo de base de datos...
        //fnc.FacturasSeg_EliminaTmp(wsConexion: nomcon);
    }

    #endregion
}