//function HabilitaMatriz2() {
//    cmbTipoDeGasto.SetEnabled(true);
  
//}

//function MuestraMatriz2() { 
   
//        var grid = glBusqueda.GetGridView();
//        campos = 'id_tipogasto';
//        grid.GetRowValues(grid.GetFocusedRowIndex(), campos, cmbTipoDeGasto.SetValue(values[0]));
//}

//    function ObtieneValor_Matriz2(values) {
//        cmbTipoDeGasto.SetValue(values[0]);
//    }

//        function DeshabilitaMatriz2() {
//            cmbTipoDeGasto.SetEnabled(false);
//    }


var isUpdated = false;
function OnEndCallback(s, e) {

    if (isUpdated) {
        alert(s.cpAccion);
        isUpdated = false;
    }

}

        