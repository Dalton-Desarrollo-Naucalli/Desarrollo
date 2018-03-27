var DescripcionFL = "";

function HabilitaFormasLiquidacion() {
    rbtnEsCuentaBancaria.SetEnabled(true);
    txtDescripcion.SetEnabled(true);
    txtDescripcionCorta.SetEnabled(true);
    cmbMoneda.SetEnabled(true);
    cmbCuentaInterna.SetEnabled(true);
    cmbCuentaExterna.SetEnabled(true);
    cmbTipoDeAplicacion.SetEnabled(true);
    cmbChequeCaja.SetEnabled(true);
    cmbChequeCajaTrans.SetEnabled(true);
    rbtnFormaDeLiquidacionActiva.SetEnabled(true);
}
function MuestraFormasLiquidacion() {   
    var grid = glBusqueda.GetGridView();
    campos = 'ID_formaliq;escuenta;Descripcion;des_corta;moneda_id;cuenta_interna;cuenta_externa;activo;TipoDeAplicacion;Cheque_o_Caja';
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_FormasLiquidacion);
}
function ObtieneValor_FormasLiquidacion(values) {   
    txtFormaDeLiquidacion.SetText(values[0]);
    rbtnEsCuentaBancaria.SetValue(values[1]);
    txtDescripcion.SetText(values[2]);
    DescripcionFL = values[2];
    txtDescripcionCorta.SetText(values[3]);
    cmbMoneda.SetValue(values[4]);
    cmbCuentaInterna.SetValue(values[5]);
    cmbCuentaExterna.SetValue(values[6]);
    rbtnFormaDeLiquidacionActiva.SetValue(values[7]);
    cmbTipoDeAplicacion.SetValue(values[8]);
    if (rbtnEsCuentaBancaria.GetValue() == 0)
        cmbChequeCaja.SetValue(values[9]);
    else
        cmbChequeCajaTrans.SetValue(values[9]);
  
    EsCuenta();

}
function DeshabilitaFormasLiquidacion() {
    rbtnEsCuentaBancaria.SetEnabled(false);
    txtDescripcion.SetEnabled(false);
    txtDescripcionCorta.SetEnabled(false);
    cmbMoneda.SetEnabled(false);
    cmbCuentaInterna.SetEnabled(false);
    cmbCuentaExterna.SetEnabled(false);
    cmbTipoDeAplicacion.SetEnabled(false);
    cmbChequeCaja.SetEnabled(false);
    cmbChequeCajaTrans.SetEnabled(false);
    rbtnFormaDeLiquidacionActiva.SetEnabled(false);
}
function CargaCuenta() {
    cmbNoCuenta.PerformCallback();
    if (DescripcionFL != "")       
    cmbNoCuenta.SetText(DescripcionFL);
}
function EsCuenta() {
  
    
    if (rbtnEsCuentaBancaria.GetValue() == 0) {        //No  
        cmbNoCuenta.SetSelectedIndex(-1);
        lblNoCuenta.SetVisible(false);
        cmbNoCuenta.SetVisible(false);
        cmbChequeCajaTrans.SetVisible(false);
        cmbChequeCaja.SetVisible(true);
        Visibles(true);

        

    }
    else if (rbtnEsCuentaBancaria.GetValue() == 1) {
        lblNoCuenta.SetVisible(true);
        cmbNoCuenta.SetVisible(true);
        cmbChequeCajaTrans.SetVisible(true);
        cmbChequeCaja.SetVisible(false);
        //Si
        Visibles(false);
        
        
        CargaCuenta(); 
               
    }   

 }

function Visibles(valor) {
    lblDesripcion.SetVisible(valor);
    txtDescripcion.SetVisible(valor);
    lblMoneda.SetVisible(valor);
    cmbMoneda.SetVisible(valor);
    lblCuentaInterna.SetVisible(valor);
    cmbCuentaInterna.SetVisible(valor);
    lblCuentaExterna.SetVisible(valor);
    cmbCuentaExterna.SetVisible(valor);
    

}

function recuperaValor() {
    if (DescripcionFL != "")
    cmbNoCuenta.SetText(DescripcionFL);
}



function LimpiaCampos() {

    if (rbtnEsCuentaBancaria.GetValue() == 1) {
        DescripcionFL = "";
        cmbNoCuenta.Clear();
        cmbChequeCajaTrans.Clear();
    }
    else {

        txtDescripcion.Clear();
        cmbMoneda.Clear();
        cmbCuentaExterna.Clear();
        cmbCuentaInterna.Clear();
        cmbChequeCaja.Clear();

    }

}                                        