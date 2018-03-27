function HabilitaAseguradoras() {
    txtNombre.SetEnabled(true);
    txtRFC.SetEnabled(true);
    txtNombre.SetEnabled(true);
    txtDireccion.SetEnabled(true);
    txtCP.SetEnabled(true);
    txtTelefono.SetEnabled(true);
    txtFax.SetEnabled(true);
    

}

function MuestraAseguradoras() {
    var grid = glBusqueda.GetGridView();
    //-----------0----------1-----------2---------3----------4----5-------6------7
    campos = 'No_aseg;nombre_aseg;direc_aseg;r_f_c_aseg;telefono;fax;cod_post;prov_id';
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_Aseguradoras);
}

function ObtieneValor_Aseguradoras(values) {
    txtIdAseguradora.SetText(values[0]);
    txtNombre.SetText(values[1]);
    txtDireccion.SetText(values[2]);
    txtRFC.SetText(values[3]);
    txtTelefono.SetText(values[4]);
    txtFax.SetText(values[5]);
    txtCP.SetText(values[6]);

}

function DeshabilitaAseguradoras() {

    txtNombre.SetEnabled(false);
    txtRFC.SetEnabled(false);
    txtNombre.SetEnabled(false);
    txtDireccion.SetEnabled(false);
    txtCP.SetEnabled(false);
    txtTelefono.SetEnabled(false);
    txtFax.SetEnabled(false);


}