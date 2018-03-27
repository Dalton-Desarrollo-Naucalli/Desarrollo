function HabilitaTiposCambio() {
    cmbNoMoneda.SetEnabled(true);
    dateFechaMovimiento.SetEnabled(true);
    txtTipoCambioOficial.SetEnabled(true);
    txtTipoCambioComercial.SetEnabled(true);
    btnCatMonedas.SetEnabled(true);

}
function MuestraTiposCambio() {

    var grid = glBusqueda.GetGridView();
    campos = 'tc_id;moneda_id;fechamov;tipodecambio;tipodecambio_comercial';
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_TiposCambio);
}
function ObtieneValor_TiposCambio(values) {

    txtNoMovimiento.SetText(values[0]);
    cmbNoMoneda.SetValue(values[1]);
    dateFechaMovimiento.SetValue(values[2]);
    txtTipoCambioOficial.SetText(values[3]);
    txtTipoCambioComercial.SetText(values[4]);
}
function DehabilitaTiposCambio() {
    cmbNoMoneda.SetEnabled(false);
    dateFechaMovimiento.SetEnabled(false);
    txtTipoCambioOficial.SetEnabled(false);
    txtTipoCambioComercial.SetEnabled(false);
    btnCatMonedas.SetEnabled(false);
}

