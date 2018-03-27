
function HabilitaConceptoEgresos() {
    txtDescripcion.SetEnabled(true);
    cmbTipoConcepto.SetEnabled(true);
    cmbTipoProrrateo.SetEnabled(true);
    cmbCentroCostos.SetEnabled(true);

    rblSujetoRetencionIVA.SetEnabled(true);
    rblSujetoRetencionISR.SetEnabled(true);
    txtRetencionIVA.SetEnabled(true);
    txtIVA.SetEnabled(true);

    txtImpEsp.SetEnabled(true);
    rblAplicaPersonas.SetEnabled(true);
    rblPresupuestoBaseFacturado.SetEnabled(true);
    cmbTipoGastoProvision.SetEnabled(true);
    rblProrrateoFacturacion.SetEnabled(true);
    cmbTipoGastoProrrateo.SetEnabled(true);
    cmbEgresos.SetEnabled(true);
    cmbIngresos.SetEnabled(true);
    cmbIvaPend.SetEnabled(true);
    cmbDevoluciones.SetEnabled(true);
    cmbImpEspecial.SetEnabled(true);
    cmbIvaPagado.SetEnabled(true);

    txtRetISR.SetEnabled(true);
    txtRetIva.SetEnabled(true);
    txtRetIvaCCH.SetEnabled(true);
    txtRetIvaCTR.SetEnabled(true);
    rblAplRegContableConcepto.SetEnabled(true);
   
}

function MuestraConceptoEgresos() {
    var grid = glBusqueda.GetGridView();
    //-------------0------------1-----------2------------3--------------------4------------5----------------6------------------7----------    -----8---------       --9---------10------------11---------------------12-----------------13---------------------14----------------------15-----------------------16-----------------------17--------------------
    campos = 'id_tipogasto;descripcion;Tipo_prorrateo;porcentaje_iva;porcentaje_isr;retencion;id_tipogasto_provision;id_tipoconcepto;AfectaPresupuestos;cuenta_iva;cuenta_isr;cuenta_cargo_retencion;cuenta_abono_retencion;cuenta_ingresos;prorrateo_por_facturacion;tipogasto_prorrateo_fac;ID_centro_costo;cuenta_contable_concepto;cuenta_cargo_transferencia;cuenta_iva_transferencia;porcentaje_imp_especial;cuenta_imp_especial;cuenta_devolucion;TipoAplicacion_retiva;Apl_Contabilidad_alConcepto';
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_ConceptoEgresos);
}


function ObtieneValor_ConceptoEgresos(values) {

    txtTipoGasto.SetText(values[0]);
    txtDescripcion.SetText(values[1]);
    cmbTipoProrrateo.SetValue(values[2]);
    txtIVA.SetText(values[3]);
    rblSujetoRetencionISR.SetValue(values[4]);
    rblSujetoRetencionIVA.SetValue(values[5]);
    cmbTipoGastoProvision.SetValue(values[6]);
    cmbTipoConcepto.SetValue(values[7]);
    rblPresupuestoBaseFacturado.SetValue(values[8]);
    cmbIvaPend.SetValue(values[9]);
    txtRetISR.SetText(values[10]);
    txtRetIvaCCH.SetText(values[11]);
    txtRetIva.SetText(values[12]);
    cmbIngresos.SetValue(values[13]);
    rblProrrateoFacturacion.SetValue(values[14]);
    cmbTipoGastoProrrateo.SetValue(values[15]); 
    cmbCentroCostos.SetValue(values[16]);
    cmbEgresos.SetValue(values[17]);
    txtRetIvaCTR.SetText(values[18]);
    cmbIvaPagado.SetValue(values[19]);
    txtImpEsp.SetText(values[20]);
    cmbImpEspecial.SetValue(values[21]);
    cmbDevoluciones.SetValue(values[22]);   
    txtRetencionIVA.SetText(values[23]);     
    rblAplicaPersonas.SetValue(values[24]);  
    rblAplRegContableConcepto.SetValue(values[25]);
    ProrrateoFactuaracionN();
    SujetoRetencionISR();
    SujetoRetencionIVA();
   
}

function DeshabilitaConceptoEgresos() {
    txtTipoGasto.SetEnabled(false);
    txtDescripcion.SetEnabled(false);
    cmbTipoConcepto.SetEnabled(false);
    cmbTipoProrrateo.SetEnabled(false);
    cmbCentroCostos.SetEnabled(false);
    rblSujetoRetencionIVA.SetEnabled(false);
    rblSujetoRetencionISR.SetEnabled(false);
    txtRetencionIVA.SetEnabled(false);
    txtIVA.SetEnabled(false);
    txtImpEsp.SetEnabled(false);
    rblAplicaPersonas.SetEnabled(false);
    rblPresupuestoBaseFacturado.SetEnabled(false);
    cmbTipoGastoProvision.SetEnabled(false);
    rblProrrateoFacturacion.SetEnabled(false);
    cmbTipoGastoProrrateo.SetEnabled(false);
    cmbEgresos.SetEnabled(false);
    cmbIngresos.SetEnabled(false);
    cmbIvaPend.SetEnabled(false);
    cmbDevoluciones.SetEnabled(false);
    cmbImpEspecial.SetEnabled(false);
    cmbIvaPagado.SetEnabled(false);
    txtRetISR.SetEnabled(false);
    txtRetIva.SetEnabled(false);
    txtRetIvaCCH.SetEnabled(false);
    txtRetIvaCTR.SetEnabled(false);
    rblAplRegContableConcepto.SetEnabled(false);
}


//***************************************************************Oculta tipo de gasto prorrateo**********************************************************************
function ProrrateoFactuaracionN() {
    if (rblProrrateoFacturacion.GetValue() == 1) {
        lblTipoGastoProrrateo.SetVisible(true);
        cmbTipoGastoProrrateo.SetVisible(true);
    }
    else if (rblProrrateoFacturacion.GetValue() == 0) {
        lblTipoGastoProrrateo.SetVisible(false);
        cmbTipoGastoProrrateo.SetVisible(false);
    }

}
//********************************************************************Oculta Ret ISR**********************************************************************

function SujetoRetencionISR() {
    if (rblSujetoRetencionISR.GetValue() == 1) {
        lblRetISR.SetVisible(true);
        txtRetISR.SetVisible(true);
    }
    else if (rblSujetoRetencionISR.GetValue() == 0) {
        lblRetISR.SetVisible(false);
        txtRetISR.SetVisible(false);
    }

}

//***************************************************************Oculta aplica personas, retIva, RetIvaCCH, RetIvaCtr**********************************************************************

function SujetoRetencionIVA(){
    if (rblSujetoRetencionIVA.GetValue() == 1) {
        lblAplicaPersonas.SetVisible(true);
        rblAplicaPersonas.SetVisible(true);
        lblRetIva.SetVisible(true);
        txtRetIva.SetVisible(true);
        lblRetIvaCCH.SetVisible(true);
        txtRetIvaCCH.SetVisible(true);
        lblRetIvaCTR.SetVisible(true);
        txtRetIvaCTR.SetVisible(true);
    }
    else if (rblSujetoRetencionIVA.GetValue() == 0) {     
        lblAplicaPersonas.SetVisible(false);
        rblAplicaPersonas.SetVisible(false);
        lblRetIva.SetVisible(false);
        txtRetIva.SetVisible(false);
        lblRetIvaCCH.SetVisible(false);
        txtRetIvaCCH.SetVisible(false);
        lblRetIvaCTR.SetVisible(false);
        txtRetIvaCTR.SetVisible(false);
    }
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
    if (txtTipoGasto.GetText() == '') {
        txtTipoGasto.SetText(s.cpConceptoE);
    }
}