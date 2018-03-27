function HabilitaCuentasP() {
    txtId.SetEnabled(false);
    txtDescripcion.SetEnabled(true);
    cmbCuentaInterna.SetEnabled(true);
    cmbCuentaExterna.SetEnabled(true);
    cmbNoMoneda.SetEnabled(true);

}
function MuestraCuentasP() {
    //debugger;
    var grid = glBusqueda.GetGridView();
    campos = 'ID;Descripcion;CuentaInterna;CuentaExterna;moneda_id';
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_CuentasP);
}
function ObtieneValor_CuentasP(values) {
    txtId.SetText(values[0]);
    txtDescripcion.SetText(values[1]);
    cmbCuentaInterna.SetValue(values[2]);
    cmbCuentaExterna.SetValue(values[3]);
    cmbNoMoneda.SetValue(values[4]);
}
function DehabilitaCuentasP() {
    txtId.SetEnabled(false);
    txtDescripcion.SetEnabled(false);
    cmbCuentaInterna.SetEnabled(false);
    cmbCuentaExterna.SetEnabled(false);
    cmbNoMoneda.SetEnabled(false);
}