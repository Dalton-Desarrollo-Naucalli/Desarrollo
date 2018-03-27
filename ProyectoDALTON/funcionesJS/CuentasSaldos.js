function HabilitaCuentasSaldos() {
   
    txtNumeroDeCuenta.SetEnabled(true);
    cmbBanco.SetEnabled(true);
    txtSucursal.SetEnabled(true);
    txtNoSucursal.SetEnabled(true);
    dateInicioOperacion.SetEnabled(true);
    txtSaldo.SetEnabled(true);
    cmbAuxiliar.SetEnabled(true);
    cmbDescAuxiliar.SetEnabled(true);
    cmbFormatoCheques.SetEnabled(true);
    cmbMoneda.SetEnabled(true);
    txtSaldoEnBanco.SetEnabled(true);
    cmbCuentaTransferencia.SetEnabled(true);
    cmbTipoPol.SetEnabled(true);
    cmbModuloid.SetEnabled(true);
    btnSucursales.SetEnabled(true);
    txtConsecutivoDeChequera.SetEnabled(true);
    rbtnCuentaActiva.SetEnabled(true);
    txtNumeroCuentaClave.SetEnabled(true);
    txtNumeroCteBanco.SetEnabled(true);
    txtCveFondoRelacionado.SetEnabled(true);
    
}

function MuestraCuentasSaldos() {
   
    var grid = glBusqueda.GetGridView();
    campos = 'idcuenta;numerodecuenta;idbanco;sucursal;numsucursal;fecha_iniciooperacion;saldo;auxiliar;formato_id;moneda_id;saldo_banco;cueta_transferencia;TipoPoliza;modulo_id;Cons_Num_CH;activo;numerodecuentaclave;numClienteBanco;cvefonbco';
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_CuentasSaldos);
}

function ObtieneValor_CuentasSaldos(values) {
   
    txtIdCuenta.SetText(values[0]);
    txtNumeroDeCuenta.SetText(values[1]);
    cmbBanco.SetValue(values[2]);
    txtSucursal.SetText(values[3]);
    txtNoSucursal.SetText(values[4]);
    dateInicioOperacion.SetText(values[5]);
    txtSaldo.SetText(values[6]);
    cmbAuxiliar.SetValue(values[7]);
    cmbDescAuxiliar.SetValue(values[7]);
    cmbFormatoCheques.SetValue(values[8]);
    cmbMoneda.SetValue(values[9]);
    txtSaldoEnBanco.SetText(values[10]);
    cmbCuentaTransferencia.SetValue(values[11]);
    cmbTipoPol.SetValue(values[12]);
    cmbModuloid.SetValue(values[13]);
    txtConsecutivoDeChequera.SetText(values[14]);
    rbtnCuentaActiva.SetValue(values[15]);
    txtNumeroCuentaClave.SetText(values[16]);
    txtNumeroCteBanco.SetText(values[17]);
    txtCveFondoRelacionado.SetText(values[18]);
    
}


function DehabilitaCuentasSaldos() {
 
    txtNumeroDeCuenta.SetEnabled(false);
    cmbBanco.SetEnabled(false);
    txtSucursal.SetEnabled(false);
    txtNoSucursal.SetEnabled(false);
    dateInicioOperacion.SetEnabled(false);
    txtSaldo.SetEnabled(false);
    cmbAuxiliar.SetEnabled(false);
    cmbDescAuxiliar.SetEnabled(false);
    cmbFormatoCheques.SetEnabled(false);
    cmbMoneda.SetEnabled(false);
    txtSaldoEnBanco.SetEnabled(false);
    cmbCuentaTransferencia.SetEnabled(false);
    cmbTipoPol.SetEnabled(false);
    cmbModuloid.SetEnabled(false);
    btnSucursales.SetEnabled(false);
    txtConsecutivoDeChequera.SetEnabled(false);
    rbtnCuentaActiva.SetEnabled(false);
    txtNumeroCuentaClave.SetEnabled(false);
    txtNumeroCteBanco.SetEnabled(false);
    txtCveFondoRelacionado.SetEnabled(false);

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
