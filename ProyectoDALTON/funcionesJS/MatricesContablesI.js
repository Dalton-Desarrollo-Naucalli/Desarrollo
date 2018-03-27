//function HabilitaMatriz1() {
//    cmbConcepto.SetEnabled(true);
//}

//function MuestraMatriz1() {
//       var grid = glBusqueda.GetGridView();
//    campos = 'id_tipogasto';
//    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_Matriz1);
//}

//function ObtieneValor_Matriz1(values) {
//    cmbConcepto.SetValue(values[0]);
//}

//function DeshabilitaMatriz1() {
//    cmbConcepto.SetEnabled(false);
//  }


var isUpdated = false;
function OnEndCallback(s, e) {

    if (isUpdated) {
        alert(s.cpAccion);
        isUpdated = false;
    }
    
}
//function IdNuevo(s, e) {
//    if (cmbConcepto.GetValue() == '') {
//        cmbConcepto.SetValue(s.cpMC1);
        
//    }
//}

//function LlenaDescripcion() {

//    var Cuenta;
//    Cuenta = ColumnaCombo2.GetValue();
//    ColumnaCombo3.SetValue(Cuenta);
//}

//function LlenaCuenta() {

//    var Descripcion;
//    Descripcion = ColumnaCombo3.GetValue();
//    ColumnaCombo2.SetValue(Descripcion);
//}