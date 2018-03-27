function HabilitaCveInventario() {
    txtClave.SetEnabled(true);
    txtConsecutivo.SetEnabled(true);
    txtDescripcion.SetEnabled(true);   
}

function MuestraCveInventario() {
    var grid = glBusqueda.GetGridView();
    campos = 'ID_inventario;consecutivo;descripcion';
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_CveInventario);
}

function ObtieneValor_CveInventario(values) {
    txtClave.SetText(values[0]);
    txtConsecutivo.SetText(values[1]);
    txtDescripcion.SetText(values[2]);  

}

function DeshabilitaCveInventario() {
    txtClave.SetEnabled(false);
    txtConsecutivo.SetEnabled(false);
    txtDescripcion.SetEnabled(false);


}