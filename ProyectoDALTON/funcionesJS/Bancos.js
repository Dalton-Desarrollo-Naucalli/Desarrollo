function HabilitaBancos() {
    txtIdBanco.SetEnabled(false);
    txtNombreCorto.SetEnabled(true);
    txtNombre.SetEnabled(true);
    cmbLiquidDefaultTR.SetEnabled(true);
    txtNoDigCtas.SetEnabled(true);
}
function MuestraBancos() {
    var grid = glBusqueda.GetGridView();
    campos = 'idbanco;nombre_corto;nombre;ID_formaliq_TR;no_digitos';
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_Bancos);
}

function ObtieneValor_Bancos(values) {
    txtIdBanco.SetText(values[0]);
    txtNombreCorto.SetText(values[1]);
    txtNombre.SetValue(values[2]);
    cmbLiquidDefaultTR.SetValue(values[3]);
    txtNoDigCtas.SetText(values[4]);

}
function DeshabilitaBancos() {
    txtIdBanco.SetEnabled(false);
    txtNombreCorto.SetEnabled(false);
    txtNombre.SetEnabled(false);
    cmbLiquidDefaultTR.SetEnabled(false);
    txtNoDigCtas.SetEnabled(false);

}