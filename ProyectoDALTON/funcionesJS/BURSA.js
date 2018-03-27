/* VARIABLES */
var idSelctedValues = "";
var selectedVisibleIndex = null;

var idSelctedValuesTraspBursa = "";
var selectedVisibleIndexTraspBursa = null;

var arreGrid = [];
var arreGridTraspBursa = [];
var LlaveConsulta;
var LlaveActualiza = "";
var Buscar = 0;


/*FUNCIONES DE ARRANQUE*/

function load() {
    debugger;
    HabilitarBotonesDefault();
    //tsDispersionDetalle.SetHeight(550);
    gv_FacRtasPend.SetHeight(300);
    gv_TraspasoBursa.SetHeight(300);
   
}

function loadDatos(IDDispersionGV) {
    debugger;
    IdDispersionG = IDDispersionGV;

}

function HabilitarBotonesDefault() {
    btnAgregar.SetEnabled(false);
    btnEditar.SetEnabled(false);
    btnEliminar.SetEnabled(false);
    btnCancelar.SetEnabled(false);
    btnActualizar.SetEnabled(false);
    btnFiltrar.SetEnabled(true);
    btnBuscar.SetEnabled(false);

}

function OnSelectionChangedGvFacRtasPend(s, e)
{
    debugger;
    selectedVisibleIndex = e.visibleIndex;    
    gv_FacRtasPend.GetRowValues(selectedVisibleIndex, 'idcliente;nombreCliente;contrato;anexo;idCredito;idObligacion;factura;fechaVencimiento;importe;diasVencidos;totalCuotas', GetFieldValuesForEditGvFacRtasPendCallback2);
    
}

function GetFieldValuesForEditGvFacRtasPendCallback2(values) {
    debugger;
    arreGrid = values;    
    OnEditRowClicked();
}

function GetSelectedFieldValuesGvFacRtasPendCallback(values) {
    debugger;
    idSelctedValues = "";
    if (values.length > 0) {
        if (values.length == 1) {            
            gv_FacRtasPend.GetRowValues(selectedVisibleIndex, 'idcliente;nombreCliente;contrato;anexo;idCredito;idObligacion;factura;fechaVencimiento;importe;diasVencidos;totalCuotas', GetFieldValuesForEditGvFacRtasPendCallback2);
        } else {
            selectedVisibleIndex = null;            
            arreGrid = [];
        }        
        for (var i = 0; i < values.length; i++) {
            idSelctedValues += values[i];
            if (i < values.length - 1) {
                idSelctedValues += ",";
            }
        }
    } else {
        selectedVisibleIndex = null;        
        arreGrid = [];
    }
}

function OnEditRowClicked() {
    debugger;   
       
        GetFieldValuesForEditGvFacRtasPendCallback(arreGrid);

   
}

function GetFieldValuesForEditGvFacRtasPendCallback(values) {
    debugger;
   
    cbxCliente.SetText(values[1]);
    cmbNumeroContrato.SetText(values[2]);
    cmbAnexo.SetText(values[3]);
    //txtCliente.SetText(values[1]);
    //txtAnexo.SetText(values[3]);
    //txtContrato.SetText(values[2]);
    //txtNumeroCredito.SetText(values[4].toString() + " / " + values[5].toString());

    txtClienteTrasp.SetText(values[1]);
    txtContratoTrasp.SetText(values[2]);
    txtAnexoTrasp.SetText(values[3]);
    txtNumObligación.SetText(values[5]);
    //dteFechaVencimiento.SetText(arreGridTraspBursa[7]);
    dteFechaVencimiento.SetText(values[7].toLocaleDateString());
    txtdiasvencimiento.SetText(values[9]);
    LlaveConsulta = values[4] + ";" + values[5];

}

/*LLENA COMBOS*/

function Cargado() {
    $("body").toggleClass("wait");
}

function Cargando() {
    $("body").toggleClass("wait");
}

function ResetCombobox(combobox) {
    debugger;
    combobox.ClearItems();
    combobox.SetSelectedIndex(-1);
    combobox.SetText("");
}

function OnInitClientes()
{
    debugger;
    
    $.ajax({
        type: "POST",
        url: "WfrentpendBURSA.aspx/CargaClientes",
        data: "{}",
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        beforeSend: function () {
            Cargando();
            ResetCombobox(cbxCliente);
            ResetCombobox(cmbNumeroContrato);
            ResetCombobox(cmbAnexo);

        },

        success: function (msg) {
            debugger;
            var datos = $.parseJSON(msg.d);

            if (datos == null) {
                var title = "Error";
                var operationMessage = "Error al Cargar Combo Clientes";
                var typeOperation = "error";
                ShowMessage(typeOperation, operationMessage, title);

            }
            else {
                cbxCliente.BeginUpdate();
                $(datos).each(function () {

                    cbxCliente.AddItem(this.descripcion, this.valor);
                });
                cbxCliente.EndUpdate();
            }
        },
        error: function (msg) {
            var title = "Error";
            var operationMessage = "Error al Cargar Combo Clientes";
            var typeOperation = "error";
            ShowMessage(typeOperation, operationMessage, title);
        }
    });

}

function CargaContratos() {
    debugger;
    var idClienteV = 0;
    idClienteV = cbxCliente.GetValue();

    $.ajax({
        type: "POST",
        url: "WfrentpendBURSA.aspx/CargaContratos",
        data: '{"clienteid":"' + idClienteV + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        beforeSend: function () {
            Cargando();            
            ResetCombobox(cmbNumeroContrato);            

        },

        success: function (msg) {
            debugger;
            var datos = $.parseJSON(msg.d);

            if (datos == null) {
                var title = "Error";
                var operationMessage = "Error al Cargar Combo Contratos";
                var typeOperation = "error";
                ShowMessage(typeOperation, operationMessage, title);

            }
            else {
                cmbNumeroContrato.BeginUpdate();
                $(datos).each(function () {

                    cmbNumeroContrato.AddItem(this.descripcion, this.valor);
                });
                cmbNumeroContrato.EndUpdate();
            }
        },
        error: function (msg) {
            var title = "Error";
            var operationMessage = "Error al Cargar Combo Contratos";
            var typeOperation = "error";
            ShowMessage(typeOperation, operationMessage, title);
        }
    });
}

function OnInitContratos() {
    debugger;
}

function CargaAnexos() {
    debugger;
    var idClienteV = 0;
    idClienteV = cbxCliente.GetValue();

    $.ajax({
        type: "POST",
        url: "WfrentpendBURSA.aspx/CargaAnexos",
        data: '{"clienteid":"' + idClienteV + '"}',
        contentType: "application/json; charset=utf-8",
        dataType: "json",

        beforeSend: function () {
            Cargando();
            ResetCombobox(cmbAnexo);

        },

        success: function (msg) {
            debugger;
            var datos = $.parseJSON(msg.d);

            if (datos == null) {
                var title = "Error";
                var operationMessage = "Error al Cargar Combo Anexos";
                var typeOperation = "error";
                ShowMessage(typeOperation, operationMessage, title);

            }
            else {
                cmbAnexo.BeginUpdate();
                $(datos).each(function () {

                    cmbAnexo.AddItem(this.descripcion, this.valor);
                });
                cmbAnexo.EndUpdate();
            }
        },
        error: function (msg) {
            var title = "Error";
            var operationMessage = "Error al Cargar Combo Anexos";
            var typeOperation = "error";
            ShowMessage(typeOperation, operationMessage, title);
        }
    });
}

function OnInitAnexos() {
    debugger;
}

function CargaContratosAnex() {
    debugger;
}

/*EVENTOS BOTONES*/

function ResultadoConsulta(s, e) {
    debugger;
    MensajeResultado();

}

function MensajeResultado() {
    debugger;
    if (Buscar == 1) {
        $.ajax({
            type: "POST",
            url: "WfrentpendBURSA.aspx/MensajeConsultaSR",
            data: "{}",
            contentType: "application/json; charset=utf-8",
            dataType: "json",

            success: function (msg) {
                debugger;
                var datos = null;
                datos = $.parseJSON(msg.d);
                var buenos = 0, malos = 0;
                var sbueno, smalo;
                var tipMen;

                if (datos != null) {
                    tipMen = datos.toString().split(';');
                    for (i = 0; i <= tipMen.length - 1; i++) {
                        var mmm = tipMen[i].split('/');
                        if (mmm[1] == "info") {
                            sbueno = mmm[0];
                            buenos++;
                        }
                        else if (mmm[1] == "error") {
                            smalo = mmm[0];
                            malos++;
                        }
                    }
                    
                    if (buenos > 0) {
                        ShowMessage("info", sbueno, "Consulta");
                        

                    }
                    else if (malos > 0) {
                        ShowMessage("error", smalo, "Consulta");                        

                    }

                    buenos = 0;
                    malos = 0;
                    datos = null;

                }
                
                
            }

        });
        
    }
    Buscar = 0;
}

function OnNewRowClicked()
{
    debugger;
}



function OnConfirmDeleteRowsClicked() {
    debugger;
}

function OnDiscardChangesClicked() {
    debugger;
    Buscar = 0;
    gv_FacRtasPend.UA_ClearSearchFilter();
    cbxCliente.SetSelectedIndex(-1);
    cbxCliente.Clear();
    ResetCombobox(cmbNumeroContrato);
    ResetCombobox(cmbAnexo);
    OnInitContratos();
    OnInitAnexos();


    for (i = 0; i < document.forms[0].length; i++) {
        doc = document.forms[0].elements[i];
        switch (doc.type) {
            case "text":
                doc.value = "";
                break;
            case "checkbox":
                doc.SelectedIndex = -1;
                break;
            case "radio":
                doc.SelectedIndex = -1;
                break;
            default:
                break;
        }
    }
    cbxMuestraTodos.SetChecked(0);

    tsFacturasBURSA.SetActiveTabIndex(0);
    gv_FacRtasPend.PerformCallback('grdCancela');
    
    arreGrid = [];
    arreGridTraspBursa = [];
    HabilitarBotonesDefault();
    

    
}

function OnSaveChangesClicked() {
    debugger;
}

function OnFilterClicked() {
    debugger;
    Buscar = 0;
    btnCancelar.SetEnabled(true);
    btnBuscar.SetEnabled(true);
}

function OnBuscar() {
    debugger;
    gv_FacRtasPend.UA_ClearSearchFilter();
    Buscar = 1;
    gv_FacRtasPend.PerformCallback('Buscar');
}

function HabilitaTabTraspasos(s, e)
{
    debugger;
    //arreGridTraspBursa = [];
    //selectedVisibleIndexTraspBursa = e.visibleIndex;
    //gv_FacRtasPend.GetRowValues(selectedVisibleIndexTraspBursa, 'idcliente;nombreCliente;contrato;anexo;idCredito;idObligacion;factura;fechaVencimiento;importe;diasVencidos', GetFieldValuesForEditGvTraspasosBursaCallback);

    tsFacturasBURSA.GetTabByName("tabPendientesBursa").SetEnabled(false);
    tsFacturasBURSA.GetTabByName("tabSolTrasBURSA").SetEnabled(true);
    tsFacturasBURSA.GetTabByName("tabRentasAdic").SetEnabled(false);
    tsFacturasBURSA.SetActiveTabIndex(1);

    
    var f = new Date();
    
    dteFechaTraspaso.SetText(f.getDate() + "/" + (f.getMonth() + 1) + "/" + f.getFullYear());
    
    gv_TraspasoBursa.PerformCallback('BuscarTraspaso' + ',' + LlaveConsulta);
}



/********************************************** REGION SEGUNDO TAB*******************************************************/

function OnAutorizarClicked() {
    debugger;
}

function OnRegresar() {
    debugger;
    gv_TraspasoBursa.UA_ClearSearchFilter();    
    tsFacturasBURSA.GetTabByName("tabPendientesBursa").SetEnabled(true);
    tsFacturasBURSA.GetTabByName("tabSolTrasBURSA").SetEnabled(false);
    tsFacturasBURSA.GetTabByName("tabRentasAdic").SetEnabled(false);
    tsFacturasBURSA.SetActiveTabIndex(0);
    gv_TraspasoBursa.PerformCallback('grdCancelaTraspaso');
    
    
    
}

function OnSolicitudAltaClicked() {
    debugger;
}

function OnConfirmDeleteFondeo() {
    debugger;
    var mensaje = confirm("¿Deséa dar de Baja de Fondeo los elementos seleccionados?");
    if (mensaje) {
        OnDeleteRowsClicked();
    }

}



function OnDeleteRowsClicked() {
    debugger;
    var title = "Baja de Fondeo";
    var operationMessage = "Crédito marcado para baja de fondeo BURSA. Se generará el archivo correspondiente en el proceso semanal.";
    var typeOperation = "info";
    ShowMessage(typeOperation, operationMessage, title);

}


function OnSelectionChangedGvTraspasoBursa(s, e)
{
    debugger;
    if (e.visibleIndex > -1) {
        if (e.isSelected) {
            selectedVisibleIndexTraspBursa = e.visibleIndex;
        } else {
            selectedVisibleIndexTraspBursa = null;
        }
    }
    s.GetSelectedFieldValues("cred_id;obligacion_id", GetSelectedFieldValuesGvTraspasoBursaCallback);
}

function GetSelectedFieldValuesGvTraspasoBursaCallback(values) {
    debugger;
    idSelctedValuesTraspBursa = "";
    if (values.length > 0)
    {
        if (values.length == 1)
        {
            btnAutorizar.SetEnabled(true);
            btnBajaFondeo.SetEnabled(true);
            gv_TraspasoBursa.GetRowValues(selectedVisibleIndexTraspBursa, 'cred_id;fechaCredito;obligacion_id;fechaVencimiento;fechaSolicitudTraspaso;usuarioSolicitoTraspaso;fechaAutorizacionTraspaso;usuarioAutorizoTraspaso;fechaConfirmacionSET;numMovimientoSET', GetFieldValuesForEditGvTraspasoBursaCallback2);
        }
        else
        {
            selectedVisibleIndexTraspBursa = null;
            btnAutorizar.SetEnabled(true);
            btnBajaFondeo.SetEnabled(true);
            arreGridTraspBursa = [];
        }

        btnAutorizar.SetEnabled(true);
        btnBajaFondeo.SetEnabled(true);
        for (var i = 0; i < values.length; i++) {
            idSelctedValuesTraspBursa += values[i];
            if (i < values.length - 1) {
                idSelctedValuesTraspBursa += ",";
            }
        }
    }
    else
    {
        selectedVisibleIndexTraspBursa = null;
        btnAutorizar.SetEnabled(false);
        btnBajaFondeo.SetEnabled(false);
        arreGridTraspBursa = [];
    }
}

function GetFieldValuesForEditGvTraspasoBursaCallback2(values) {
    debugger;
    arreGridTraspBursa = values;
}

function Mensajes()
{
    debugger;
    if (tsFacturasBURSA.GetActiveTabIndex() == 1)
    {
        var iNumeroFilas = gv_TraspasoBursa.pageRowCount;
        if (iNumeroFilas == 0) {
            btnSolicitud.SetEnabled(true);            
            var title = "Traspasos BURSA";
            var operationMessage = "Esta consulta no género ningun resultado. Intente con otros críterios ó realice una nueva Solicitud";
            var typeOperation = "info";
            ShowMessage(typeOperation, operationMessage, title);
        }
        else {
            btnSolicitud.SetEnabled(false);
        }
    }
    
}

function MuestraMensajeAgregado()
{
    debugger;
    gv_TraspasoBursa.Refresh();
    var title = "Alta";
    var operationMessage = "Registro Agregado con éxito.";
    var typeOperation = "success";
    ShowMessage(typeOperation, operationMessage, title);
}

function MuestraMensajeActualizado() {
    debugger;
    gv_TraspasoBursa.Refresh();
    var title = "Actualización";
    var operationMessage = "Registro(s) Actualizados con éxito.";
    var typeOperation = "success";
    ShowMessage(typeOperation, operationMessage, title);
}

//pruebas

function dobleclick(s, e)
{
    debugger;
    selectedVisibleIndex = e.visibleIndex;
    gv_FacRtasPend.GetRowValues(selectedVisibleIndex, 'idcliente;nombreCliente;contrato;anexo;idCredito;idObligacion;factura;fechaVencimiento;importe;diasVencidos;totalCuotas', PERFOM2);

}

function PERFOM2(values) {
    debugger;
    cbxCliente.SetText(values[1]);
    cmbNumeroContrato.SetText(values[2]);
    cmbAnexo.SetText(values[3]);
    //txtCliente.SetText(values[1]);
    //txtAnexo.SetText(values[3]);
    //txtContrato.SetText(values[2]);
    //txtNumeroCredito.SetText(values[4].toString() + " / " + values[5].toString());

    txtClienteTrasp.SetText(values[1]);
    txtContratoTrasp.SetText(values[2]);
    txtAnexoTrasp.SetText(values[3]);
    txtNumObligación.SetText(values[5]);
    //dteFechaVencimiento.SetText(arreGridTraspBursa[7]);
    dteFechaVencimiento.SetText(values[7].toLocaleDateString());
    txtdiasvencimiento.SetText(values[9]);
    LlaveConsulta = values[4] + ";" + values[5];

    tsFacturasBURSA.GetTabByName("tabPendientesBursa").SetEnabled(false);
    tsFacturasBURSA.GetTabByName("tabSolTrasBURSA").SetEnabled(true);
    tsFacturasBURSA.GetTabByName("tabRentasAdic").SetEnabled(false);
    tsFacturasBURSA.SetActiveTabIndex(1);


    var f = new Date();

    dteFechaTraspaso.SetText(f.getDate() + "/" + (f.getMonth() + 1) + "/" + f.getFullYear());

    gv_TraspasoBursa.PerformCallback('BuscarTraspaso' + ',' + LlaveConsulta);
}

function ResultadoConsultaAdicionales()
{

}

//function OnEditRowClicked() {
//    debugger;

//    GetFieldValuesForEditGvFacRtasPendCallback(arreGrid);


//}

//function GetFieldValuesForEditGvFacRtasPendCallback(values) {
//    debugger;

//    cbxCliente.SetText(values[1]);
//    cmbNumeroContrato.SetText(values[2]);
//    cmbAnexo.SetText(values[3]);
//    txtCliente.SetText(values[1]);
//    txtAnexo.SetText(values[3]);
//    txtContrato.SetText(values[2]);
//    txtNumeroCredito.SetText(values[4].toString() + " / " + values[5].toString());

//    txtClienteTrasp.SetText(values[1]);
//    txtContratoTrasp.SetText(values[2]);
//    txtAnexoTrasp.SetText(values[3]);
//    txtNumObligación.SetText(values[5]);
//    //dteFechaVencimiento.SetText(arreGridTraspBursa[7]);
//    dteFechaVencimiento.SetText(values[7].toLocaleDateString());
//    txtdiasvencimiento.SetText(values[9]);
//    LlaveConsulta = values[4] + ";" + values[5];

//}
