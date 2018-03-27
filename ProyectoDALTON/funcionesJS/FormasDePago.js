function HabilitaFormasDePago() {
    txtFormaDePago.SetEnabled(false);
    txtSiglas.SetEnabled(true);
    txtDescripcion.SetEnabled(true);
    cmbTipoDePago.SetEnabled(true);
    rblFormaDePagoActiva.SetEnabled(true);

}
function MuestraFormasDePago() {
    //debugger;
    var grid = glBusqueda.GetGridView();
    campos = 'id_formapago;siglas;descripcion;tipo_pago;activo';
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_FormasDePago);
}
function ObtieneValor_FormasDePago(values) {

    txtFormaDePago.SetText(values[0]);
    txtSiglas.SetText(values[1]);
    txtDescripcion.SetText(values[2]);
    cmbTipoDePago.SetValue(values[3]);
    rblFormaDePagoActiva.SetValue(values[4]);

}
function DehabilitaFormasDePago() {
    txtFormaDePago.SetEnabled(false);
    txtSiglas.SetEnabled(false);
    txtDescripcion.SetEnabled(false);
    cmbTipoDePago.SetEnabled(false);
    rblFormaDePagoActiva.SetEnabled(false);

}


var isUpdated = false;
function OnEndCallback(s, e) {
    //debugger;
    if (isUpdated) {
        alert(s.cpAccion);
        isUpdated = false;
    }
    IdNuevo(s, e);
}
function IdNuevo(s, e) {
    if (txtFormaDePago.GetText() == '') {
        txtFormaDePago.SetText(s.cpIDProd);
    }
}
