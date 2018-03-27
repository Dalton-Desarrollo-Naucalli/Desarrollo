function HabilitaMoneda() {
    txtNoMoneda.SetEnabled(false);
    txtIdContabilidad.SetEnabled(true);
    txtNombre.SetEnabled(true);
    txtNomCorto.SetEnabled(true);
    txtLeyenda1.SetEnabled(true);
    txtLeyenda2.SetEnabled(true);
}
function MuestraMoneda() {
    var grid = glBusqueda.GetGridView();
    campos = 'moneda_id;moneda_conta;nombre;nombre_corto;leyenda_1;leyenda_2';
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_Moneda);
}
function ObtieneValor_Moneda(values) {
    txtNoMoneda.SetText(values[0]);
    txtIdContabilidad.SetText(values[1]);
    txtNombre.SetText(values[2]);
    txtNomCorto.SetText(values[3]);
    txtLeyenda1.SetText(values[4]);
    txtLeyenda2.SetText(values[5]);
}

function DeshabilitaMoneda() {
    txtNoMoneda.SetEnabled(false);
    txtIdContabilidad.SetEnabled(false);
    txtNombre.SetEnabled(false);
    txtNomCorto.SetEnabled(false);
    txtLeyenda1.SetEnabled(false);
    txtLeyenda2.SetEnabled(false);
}