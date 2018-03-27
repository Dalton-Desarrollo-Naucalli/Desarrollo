function HabilitaTiposMovsBancarios() {
    txtDescrpcion.SetEnabled(true);
    cmbAuxiliar.SetEnabled(true);
    cmbDescAuxiliar.SetEnabled(true);
    cmbTipoDeMovimiento.SetEnabled(true);
    txtMovtoBanco.SetEnabled(true);
    cmbOrigen.SetEnabled(true);
}

function MuestraTiposMovsBancarios() {
    var grid = glBusqueda.GetGridView();
    campos = 'cve_movimiento;descripcion;auxiliar;tipomovimiento;Cve_banco;Cve_Origen';
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_TiposDeMovsBancarios);
}

function ObtieneValor_TiposDeMovsBancarios(values) {
    txtMovimiento.SetText(values[0]);
    txtDescrpcion.SetText(values[1]);
    cmbAuxiliar.SetValue(values[2]);
    cmbDescAuxiliar.SetValue(values[2]);
    cmbTipoDeMovimiento.SetValue(values[3]);
    txtMovtoBanco.SetText(values[4]);
    cmbOrigen.SetValue(values[5]);
}

function DeshabilitaTiposMovsBancarios() {
    txtDescrpcion.SetEnabled(false);
    cmbAuxiliar.SetEnabled(false);
    cmbDescAuxiliar.SetEnabled(false);
    cmbTipoDeMovimiento.SetEnabled(false);
    txtMovtoBanco.SetEnabled(false);
    cmbOrigen.SetEnabled(false);
}

function LlenaDescAux() {   
    var IdAuxiliarV;
    IdAuxiliarV = cmbAuxiliar.GetValue();
    cmbDescAuxiliar.SetValue(IdAuxiliarV);
}

function LlenaAuxiliar() {
    var IdDescAuxiliarV;
    IdDescAuxiliarV = cmbDescAuxiliar.GetValue();
    cmbAuxiliar.SetValue(IdDescAuxiliarV);
}
