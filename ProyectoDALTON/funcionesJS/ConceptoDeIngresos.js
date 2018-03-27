function HabilitaConceptoIngresos() {
    txtNoConcepto.SetEnabled(false);
    txtDescripcion.SetEnabled(true);
    cmbContexto.SetEnabled(true);
}
function MuestraConceptoIngresos() {
    //debugger;
    var grid = glBusqueda.GetGridView();
    campos = 'id_conceptosIngresos;descripcion;Form_reclasifica';
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_ConceptoIngresos);
}
function ObtieneValor_ConceptoIngresos(values) {

    txtNoConcepto.SetText(values[0]);
    txtDescripcion.SetText(values[1]);
    cmbContexto.SetText(values[2]);
}
function DeshabilitaConceptoIngresos() {
    txtNoConcepto.SetEnabled(false);
    txtDescripcion.SetEnabled(false);
    cmbContexto.SetEnabled(false);
}
