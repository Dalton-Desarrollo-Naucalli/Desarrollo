function HabilitaAgencias() {    
    txtNombre.SetEnabled(true);
    txtRFC.SetEnabled(true);
    cmbIdProveedor.SetEnabled(true);
    cmbIdStatus.SetEnabled(true);
   
}

function MuestraAgencias() {
    var grid = glBusqueda.GetGridView();
    //-----------0----------1-----------2---------3----------4----------
    campos = 'idAgencia;nombre;RFC;proveedor_id;idEstatus';
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_Agencias);
}

function ObtieneValor_Agencias(values) {
    txtIdAgencia.SetText(values[0]);
    txtNombre.SetText(values[1]);
    txtRFC.SetText(values[2]);
    cmbIdProveedor.SetValue(values[3]);
    cmbIdStatus.SetValue(values[4]);
     
}

function DeshabilitaAgencias() {

    txtIdAgencia.SetEnabled(false);   
    txtNombre.SetEnabled(false);
    txtRFC.SetEnabled(true);
    cmbIdProveedor.SetEnabled(false);
    cmbIdStatus.SetEnabled(false);

}

