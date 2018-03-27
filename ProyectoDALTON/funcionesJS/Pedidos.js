
//FUNCIONES MUESTRA PEDIDOS EN FORMULARIO
function MuestraPedidos() {
    //debugger;
    var grid = glBusqueda.GetGridView();
    campos = 'ped_id;Cve_pedido;fecha;moneda_id;modulo_id;cliente_id;Contacto_id;id_sucursal;forma_pago;Comentario_plazo;person_id;ID_TipoServicio;observaciones;captura_dir_entrego;observ_automaticas;'
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_Pedidos);
}
function ObtieneValor_Pedidos(values) {
    //debugger;
    txtNoPedido.SetText(values[0]);
    txtCvePedidoCte.SetText(values[1]);     
    dtFecha.SetValue(values[2]);
    cmbMoneda.SetValue(values[3]);
    cmbSucursal.SetValue(values[4]);
    cmbCliente.SetValue(values[5]);
    cmbAtencion.SetValue(values[6]);
    cmbSucursalCte.SetValue(values[7]);
    txtFormaPago.SetText(values[8]);
    txtComentarioPlazo.SetText(values[9]);
    cmbPersona.SetValue(values[10]);
    cmbTipoServicio.SetValue(values[11]);
    txtObserv.SetText(values[12]);
    cmbCapDirec.SetValue(values[13]);
    txtNotas.SetText(values[14]);
}

//FUNCION QUE HABILITA LOS CONTROLES DEL FORMULARIO PEDIDOS
function HabilitaPedidos() {
    //debugger;
    txtCvePedidoCte.SetEnabled(true);
    dtFecha.SetEnabled(true);
    cmbMoneda.SetEnabled(true);
    cmbSucursal.SetEnabled(true);
    cmbCliente.SetEnabled(true);
    cmbAtencion.SetEnabled(true);
    cmbSucursalCte.SetEnabled(true);
    txtFormaPago.SetEnabled(true);
    txtComentarioPlazo.SetEnabled(true);
    cmbPersona.SetEnabled(true);
    cmbTipoServicio.SetEnabled(true);
}
function DeshabilitaPedidos() {
    txtCvePedidoCte.SetEnabled(false);
    dtFecha.SetEnabled(false);
    cmbMoneda.SetEnabled(false);
    cmbSucursal.SetEnabled(false);
    cmbCliente.SetEnabled(false);
    cmbAtencion.SetEnabled(false);
    cmbSucursalCte.SetEnabled(false);
    txtFormaPago.SetEnabled(false);
    txtComentarioPlazo.SetEnabled(false);
    cmbPersona.SetEnabled(false);
    cmbTipoServicio.SetEnabled(false);
}

//FUNCION LLENA COMBO ATENCION VALIDACION DE CLIENTE
function LlenaAtn() {
var IdCliente;
IdCliente = cmbCliente.GetValue();
cmbAtencion.PerformCallback(IdCliente);
}
//FUNCION LLENA COMBO SUCURSAL CLIENTE DE CLIENTE
function LlenaSucCte() {
    var SucCte;
    SucCte = cmbCliente.GetValue();
    cmbSucursalCte.PerformCallback(SucCte);
}
//FUNCION ALERTAS DEL GRID PEDIDOS
function OnEndCallback(s, e) {
    //debugger;
    if (isUpdated) {
        alert(s.cpAccion);
        isUpdated = false;           
    }
    IdNuevo(s, e);
}
//FUNCION NUEVO ID DESPUES DE UN REGISTRO COMPLETO DE FORMULARIO CON GRID
function IdNuevo(s, e) {
    if (txtNoPedido.GetText() == '') {
        txtNoPedido.SetText(s.cpIDProd);
    }
}

