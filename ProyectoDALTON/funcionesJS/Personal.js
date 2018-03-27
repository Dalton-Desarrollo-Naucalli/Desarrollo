function HabilitaPersonal() {
    txtNombre.SetEnabled(true);
    txtDireccion.SetEnabled(true);
    txtColonia.SetEnabled(true);
    txtCodigoPostal.SetEnabled(true);
    cmbMunicipio.SetEnabled(true);
    cmbEstado.SetEnabled(true);
    txtTelParticular.SetEnabled(true);
    txtTelTrabajo.SetEnabled(true);
    txtFax.SetEnabled(true);
    txtRFC.SetEnabled(true);
    txtPuesto.SetEnabled(true);
    txtNumeroSeguridadSocial.SetEnabled(true);
    txtNalDeIdentificacion.SetEnabled(true);
    txtCorreoElectronico.SetEnabled(true);
    txtDepto.SetEnabled(true);
    dteFNacimiento.SetEnabled(true);
    datedFechaContratacion.SetEnabled(true);
    txtNomEsposa.SetEnabled(true);
    txtPersonaEmergencia.SetEnabled(true);
    txtTelEmergencia.SetEnabled(true);
    mmoNotas.SetEnabled(true);
    txtClaveEmpleado.SetEnabled(true);
    txtFComision.SetEnabled(true);
    cmbCentroCostos.SetEnabled(true);
    txtNombreCorto.SetEnabled(true);
    cmbSucursal.SetEnabled(true);
    rbtnnBaja.SetEnabled(true);
    datedFechaBaja.SetEnabled(true);
    //CMBS
    cmbNumCuentaCargo.SetEnabled(true);
    cmbBancoCtaCargo.SetEnabled(true);
    cmbNumCuentaAbono.SetEnabled(true);
    cmbBancoCtaAbono.SetEnabled(true);
    cmbAuxiliar.SetEnabled(true);
    cmbDescAuxiliar.SetEnabled(true);
    cmbFormularioInicial.SetEnabled(true);
}
function MuestraPersonal() {
    
    var grid = glBusqueda.GetGridView();
    campos = 'person_id;nombre;domicilio;colonia;cp;municipio;estado;telefono1;telefono2;fax;rfc;puesto;numseguridadsocial;numnacionalempleado;nombrecorreoelectronico;nombredepartamento;fechanacimiento;fechacontratacion;nombredelconyuge;nombrecontactoemerg;telefcontactoemerg;nota;cve_emp;FactorComisionVentas;ID_centro_costo;nombre_corto;modulo_id;baja;fechabaja;num_cuenta_cargo;banco_cuenta_cargo;num_cuenta_abono;banco_cuenta_abono;auxiliar;formulario_inicial';
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_Personal);
}
function ObtieneValor_Personal(values) {
    
    txtIdEmpleado.SetText(values[0]);
    txtNombre.SetText(values[1]);
    txtDireccion.SetText(values[2]);
    txtColonia.SetText(values[3]);
    txtCodigoPostal.SetText(values[4]);
    cmbMunicipio.SetValue(values[5]);
    cmbEstado.SetValue(values[6]);
    txtTelParticular.SetText(values[7]);
    txtTelTrabajo.SetText(values[8]);
    txtFax.SetText(values[9]);
    txtRFC.SetText(values[10]);
    txtPuesto.SetText(values[11]);
    txtNumeroSeguridadSocial.SetText(values[12]);
    txtNalDeIdentificacion.SetText(values[13]);
    txtCorreoElectronico.SetText(values[14]);
    txtDepto.SetText(values[15]);
    dteFNacimiento.SetValue(values[16]);
    datedFechaContratacion.SetValue(values[17]);
    txtNomEsposa.SetText(values[18]);
    txtPersonaEmergencia.SetText(values[19]);
    txtTelEmergencia.SetText(values[20]);
    mmoNotas.SetText(values[21]);
    txtClaveEmpleado.SetText(values[22]);
    txtFComision.SetText(values[23]);
    cmbCentroCostos.SetValue(values[24]);
    txtNombreCorto.SetText(values[25]);
    cmbSucursal.SetValue(values[26]);
    rbtnnBaja.SetValue(values[27]);
    datedFechaBaja.SetValue(values[28]);
    //CMBS
    cmbNumCuentaCargo.SetValue(values[29]);
    cmbBancoCtaCargo.SetValue(values[30]);
    cmbNumCuentaAbono.SetValue(values[31]);
    cmbBancoCtaAbono.SetValue(values[32]);
    cmbAuxiliar.SetValue(values[33]);
    cmbDescAuxiliar.SetValue(values[33]);
    cmbFormularioInicial.SetValue(values[34]);
    EsBaja();
    


}
function DeshabilitaPersonal() {
    txtNombre.SetEnabled(false);
    txtDireccion.SetEnabled(false);
    txtColonia.SetEnabled(false);
    txtCodigoPostal.SetEnabled(false);
    cmbMunicipio.SetEnabled(false);
    cmbEstado.SetEnabled(false);
    txtTelParticular.SetEnabled(false);
    txtTelTrabajo.SetEnabled(false);
    txtFax.SetEnabled(false);
    txtRFC.SetEnabled(false);
    txtPuesto.SetEnabled(false);
    txtNumeroSeguridadSocial.SetEnabled(false);
    txtNalDeIdentificacion.SetEnabled(false);
    txtCorreoElectronico.SetEnabled(false);
    txtDepto.SetEnabled(false);
    dteFNacimiento.SetEnabled(false);
    datedFechaContratacion.SetEnabled(false);
    txtNomEsposa.SetEnabled(false);
    txtPersonaEmergencia.SetEnabled(false);
    txtTelEmergencia.SetEnabled(false);
    mmoNotas.SetEnabled(false);
    txtClaveEmpleado.SetEnabled(false);
    txtFComision.SetEnabled(false);
    cmbCentroCostos.SetEnabled(false);
    txtNombreCorto.SetEnabled(false);
    cmbSucursal.SetEnabled(false);
    rbtnnBaja.SetEnabled(false);
    datedFechaBaja.SetEnabled(false);
    cmbNumCuentaCargo.SetEnabled(false);
    cmbBancoCtaCargo.SetEnabled(false);
    cmbNumCuentaAbono.SetEnabled(false);
    cmbBancoCtaAbono.SetEnabled(false);    
    cmbAuxiliar.SetEnabled(false);
    cmbDescAuxiliar.SetEnabled(false);
    cmbFormularioInicial.SetEnabled(false);
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


function LlenaMunicipio() {
    var IdEstado;
    IdEstado = cmbEstado.GetValue();
    cmbMunicipio.PerformCallback(IdEstado);

}

var isUpdated = false;
function OnEndCallback(s, e) {
    //debugger;
    if (isUpdated) {
        alert(s.cpAccion);
        isUpdated = false;
    }
    IdNuevo(s, e);
}
function IdNuevo(s, e) {
    if (txtIdEmpleado.GetText() == '') {
        txtIdEmpleado.SetText(s.cpIDProd);
    }
}

function EsBaja() {
    if (rbtnnBaja.GetValue() == 1) {
        lblFechaBaja.SetVisible(true);
        datedFechaBaja.SetVisible(true);
    }
    else if (rbtnnBaja.GetValue() == 2) {
        lblFechaBaja.SetVisible(false);
        datedFechaBaja.SetVisible(false);
    }

  }
