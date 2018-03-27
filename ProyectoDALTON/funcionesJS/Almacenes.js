function HabilitaAlmacenes() {

    cmbEncargado.SetEnabled(true);
    txtDescripcion.SetEnabled(true);
    txtDireccion.SetEnabled(true);
    txtTelefono.SetEnabled(true);
    txtColonia.SetEnabled(true);
    txtCP.SetEnabled(true);
    cmbMunicipio.SetEnabled(true);
    cmbEstado.SetEnabled(true);
    cmbCentroCostos.SetEnabled(true);
    rblHabilitado.SetEnabled(true);
    cmbSucursal.SetEnabled(true);

}

function MuestraAlmacenes() {
    var grid = glBusqueda.GetGridView();
    //-----------0----------1-------2----------------3--------------4-------------5--------6------------7-----------8----------9--------------10---------11------
    campos = 'ID_almacen;person_id;descripcion;direccion_alma;telefono_alma;colonia_alma;cp_alma;municipio_alma;estado_alma;ID_centro_costo;habilitado;modulo_id';
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_Almacenes);
}

function ObtieneValor_Almacenes(values) {
    txtNoAlmacen.SetText(values[0]);
    cmbEncargado.SetValue(values[1]);
    txtDescripcion.SetText(values[2]);
    txtDireccion.SetText(values[3]);
    txtTelefono.SetText(values[4]);
    txtColonia.SetText(values[5]);
    txtCP.SetText(values[6]);
    cmbMunicipio.SetValue(values[7]);
    cmbEstado.SetValue(values[8]);
    cmbCentroCostos.SetValue(values[9]);
    rblHabilitado.SetValue(values[10]);
    cmbSucursal.SetValue(values[11]);
}

function DeshabilitaAlmacenes() {

    txtNoAlmacen.SetEnabled(false);
    cmbEncargado.SetEnabled(false);
    txtDescripcion.SetEnabled(false);   
    txtDireccion.SetEnabled(false);
    txtTelefono.SetEnabled(false);
    txtColonia.SetEnabled(false);
    txtCP.SetEnabled(false);
    cmbMunicipio.SetEnabled(false);  
    cmbEstado.SetEnabled(false);
    cmbCentroCostos.SetEnabled(false);
    rblHabilitado.SetEnabled(false);
    cmbSucursal.SetEnabled(false);   

}


function LlenaMunicipio() {
    var IdEstado;
    IdEstado = cmbEstado.GetValue();
    cmbMunicipio.PerformCallback(IdEstado);

}

