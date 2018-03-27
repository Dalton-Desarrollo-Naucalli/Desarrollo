function HabilitaMatriz3() {
    cmbConcepto.SetEnabled(true);
    cmbCuentaInterna.SetEnabled(true);  
    cmbCuentaInternaDes.SetEnabled(true);
    cmbCuentaExterna.SetEnabled(true);
    cmbCuentaExternaDes.SetEnabled(true);
    txtDescripcion.SetEnabled(true);
}
function MuestraMatriz3() {
     var grid = glBusqueda.GetGridView();
    campos = 'id_conceptosIngresos;cuenta_interna;cuenta_externa;descripcion';
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_Matriz3);
}
function ObtieneValor_Matriz3(values) { 

    cmbConcepto.SetValue(values[0]);   
    cmbCuentaInterna.SetValue(values[1]);
    cmbCuentaInternaDes.SetValue(values[1]);
    cmbCuentaExterna.SetValue(values[2]);
    cmbCuentaExternaDes.SetValue(values[2]);
    txtDescripcion.SetText(values[3]);

}

function DeshabilitaMatriz3() {
    cmbConcepto.SetEnabled(false);
    cmbCuentaInterna.SetEnabled(false);
    cmbCuentaInternaDes.SetEnabled(false);
    cmbCuentaExterna.SetEnabled(false);
    cmbCuentaExternaDes.SetEnabled(false);
    txtDescripcion.SetEnabled(false);
}


function LlenaDes() {
    var CuentaI;
    CuentaI = cmbCuentaInterna.GetValue();
    cmbCuentaInternaDes.SetValue(CuentaI);
} 

function LlenaCuentaI() {
    var Descripcion;
    Descripcion = cmbCuentaInternaDes.GetValue();
    cmbCuentaInterna.SetValue(Descripcion);
}

function LlenaDesc() {
    var CuentaE;
    CuentaE = cmbCuentaExterna.GetValue();
    cmbCuentaExternaDes.SetValue(CuentaE);
}

function LlenaCuentaE() {
    var Descripcion;
    Descripcion = cmbCuentaExternaDes.GetValue();
    cmbCuentaExterna.SetValue(Descripcion);
}
