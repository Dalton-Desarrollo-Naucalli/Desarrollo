var arreglo = null;

function OnBuscar() {
    GridFinammico.PerformCallback('Buscar');
}
function OnActualizaZonaFiscal() {
    gvImpuestosZonaFiscal.PerformCallback('Actualizar');
}
//Abre un nuevo formulario dentro de un popup
function AbreForm() {
    debugger;   

        var NomFrm = txtForm.GetText();
        window.open(NomFrm, '_parent', 'channelmode = no,directories = no,fullscreen = yes,height=665,width=1230,left = 80,location = no,menubar = no,resizable = yes,scrollbars = yes,status = no,titlebar = ' + NomFrm + ',toolbar = no,top = 0')
    
}
//**************************Pasar el nombre del formulario a una caja de texto desde un GridLookup Catalogo_Maestro***************
function OnGridFocusedRowChanged() {
    //debugger;
    var grid = glCatalogos.GetGridView();
    grid.GetRowValues(grid.GetFocusedRowIndex(), 'FormularioInd', OnGetRowValues);
}
function OnGetRowValues(values) {
    //debugger;
    txtForm.SetText(values);
}
//*****************************************Abrir una nueva ventana con un parametro desde CatalogoMaestro*********************
function OnGridFocusedRowChangedIdPar() {
    //debugger;
    GridFinammico.GetRowValues(GridFinammico.GetFocusedRowIndex(), 'ID', OnGetRowValuesIdPar);
}
function OnGetRowValuesIdPar(values) {
    //debugger;
    txtIdPar.SetText(values);
    var NomFrm = txtForm.GetText();
    window.open(NomFrm + '?IdTab=' + values, '_parent', 'channelmode = no,directories = no,fullscreen = yes,height=665,width=1230,left = 80,location = no,menubar = no,resizable = yes,scrollbars = yes,status = no,titlebar = ' + NomFrm + ',toolbar = no,top = 0')
}
//************************************Pasar los campos a las cajas de texto Frm_ConceptoDeEgresosPar******************************
function OnGridFocusedRowChangedConceptoDeEgresosPar() {
    //debugger;
    var grid = glBusquedaPar.GetGridView();
    //------------------------------------------------0-------;-----1-----;----2----------;------3------;-------4------;---5----;-----6---;---7--;--------8---------;----9----;-----------10---------;-------11------;--------12--------;------13---;-----14---;-----------15---------;--------16------------;------17-------;--------18---------------;--------19--------------;--------20-----;------------21----------;------------22------------;----------23------------;-----------24----------;----------25--------;--------26-------;---------27------;------------28-------;--------------29--------;-----30----;--31---;----32--;---33--
    grid.GetRowValues(grid.GetFocusedRowIndex(), 'id_tipogasto;descripcion;Tipo_prorrateo;porcentaje_iva;porcentaje_isr;usuario;ultactual;activo;forma_amortizacion;retencion;id_tipogasto_provision;id_tipoconcepto;AfectaPresupuestos;cuenta_iva;cuenta_isr;cuenta_cargo_retencion;cuenta_abono_retencion;cuenta_ingresos;prorrateo_por_facturacion;tipogasto_prorrateo_fac;ID_centro_costo;cuenta_contable_concepto;cuenta_cargo_transferencia;cuenta_iva_transferencia;porcentaje_imp_especial;cuenta_imp_especial;cuenta_devolucion;porcentaje_retiva;TipoAplicacion_retiva;Apl_Contabilidad_alConcepto;borradoLogico;ipAct', OnGetRowValuesConceptoDeEgresosPar);
}
function OnGetRowValuesConceptoDeEgresosPar(values) {
    debugger;
    txtTipoGasto.SetText(values[0]);
    txtDescripcion.SetText(values[1]);
    cmbTipoConcepto.SetValue(values[11]);

    cmbTipoProrrateo.SetValue(values[2]);
    cmbCentroCostos.SetValue(values[20]);

    rblSujetoRetencionIVA.SetValue(values[9]);
    rblSujetoRetencionISR.SetValue(values[4]);
    txtRetencionIVA.SetText(values[27]);
    txtIVA.SetText(values[3]);

    txtImpEsp.SetText(values[24]);
    rblAplicaPersonas.SetValue(values[28]);
    rblPresupuestoBaseFacturado.SetValue(values[12]);
    cmbTipoGastoProvision.SetValue(values[10]);
    rblProrrateoFacturacion.SetValue(values[18]);
    cmbTipoGastoProrrateo.SetValue(values[19]);
    cmbEgresos.SetValue(values[21]);
    cmbIngresos.SetValue(values[17]);
    cmbIvaPend.SetValue(values[13]);
    cmbDevoluciones.SetValue(values[26]);
    cmbImpEspecial.SetValue(values[25]);
    cmbIvaPagado.SetValue(values[23]);

    txtRetISR.SetText(values[14]);
    txtRetIva.SetText(values[16]);
    txtRetIvaCCH.SetText(values[15]);
    txtRetIvaCTR.SetText(values[22]);
    rblAplRegContableConcepto.SetValue(values[29]);
    gvImpuestosZonaFiscal.Refresh();

}
//FIN DE Frm_ConceptoDeEgresosPar
//************************************Pasar los campos a las cajas de texto Frm_ConceptoDeEgresos********************************
function OnGridFocusedRowChangedConceptoDeEgresos() {
    //debugger;
    var grid = glBusqueda.GetGridView();
    //------------------------------------------------0-------;-----1-----;----2----------;------3------;-------4------;---5----;-----6---;---7--;--------8---------;----9----;-----------10---------;-------11------;--------12--------;------13---;-----14---;-----------15---------;--------16------------;------17-------;--------18---------------;--------19--------------;--------20-----;------------21----------;------------22------------;----------23------------;-----------24----------;----------25--------;--------26-------;---------27------;------------28-------;--------------29-------;--------30---;--31---;----32--;---33--
    grid.GetRowValues(grid.GetFocusedRowIndex(), 'id_tipogasto;descripcion;Tipo_prorrateo;porcentaje_iva;porcentaje_isr;usuario;ultactual;activo;forma_amortizacion;retencion;id_tipogasto_provision;id_tipoconcepto;AfectaPresupuestos;cuenta_iva;cuenta_isr;cuenta_cargo_retencion;cuenta_abono_retencion;cuenta_ingresos;prorrateo_por_facturacion;tipogasto_prorrateo_fac;ID_centro_costo;cuenta_contable_concepto;cuenta_cargo_transferencia;cuenta_iva_transferencia;porcentaje_imp_especial;cuenta_imp_especial;cuenta_devolucion;porcentaje_retiva;TipoAplicacion_retiva;Apl_Contabilidad_alConcepto;borradoLogico;ipAct', OnGetRowValuesConceptoDeEgresos);
}
function OnGetRowValuesConceptoDeEgresos(values) {
    debugger
    if (txtBandera.GetText() == "") {
        txtTipoGasto.SetText(values[0]);
        txtDescripcion.SetText(values[1]);
        cmbTipoConcepto.SetValue(values[11]);
        cmbTipoProrrateo.SetValue(values[2]);
        cmbCentroCostos.SetValue(values[20]);
        rblSujetoRetencionIVA.SetValue(values[9]);
        rblSujetoRetencionISR.SetValue(values[4]);
        txtRetencionIVA.SetText(values[27]);
        txtIVA.SetText(values[3]);
        txtImpEsp.SetText(values[24]);
        rblAplicaPersonas.SetValue(values[28]);
        rblPresupuestoBaseFacturado.SetValue(values[12]);
        cmbTipoGastoProvision.SetValue(values[10]);
        rblProrrateoFacturacion.SetValue(values[18]);
        cmbTipoGastoProrrateo.SetValue(values[19]);
        cmbEgresos.SetValue(values[21]);
        cmbIngresos.SetValue(values[17]);
        cmbIvaPend.SetValue(values[13]);
        cmbDevoluciones.SetValue(values[26]);
        cmbImpEspecial.SetValue(values[25]);
        cmbIvaPagado.SetValue(values[23]);
        txtRetISR.SetText(values[14]);
        txtRetIva.SetText(values[16]);
        txtRetIvaCCH.SetText(values[15]);
        txtRetIvaCTR.SetText(values[22]);
        rblAplRegContableConcepto.SetValue(values[29]);
        gvImpuestosZonaFiscal.Refresh();

        arreglo = {
            TipoGasto: values[0],
            Descripcion: values[1],
            TipoConcepto: values[11],
            TipoProrrateo: values[2],
            CentroCostos: values[20],
            SujetoRetencionIVA: values[9],
            SujetoRetencionISR: values[4],
            RetencionIVA: values[27],
            IVA: values[3],
            ImpEsp: values[24],
            AplicaPersonas: values[28],
            PresupuestoBaseFacturado:values[12],
            TipoGastoProvision: values[10],
            ProrrateoFacturacion: values[18],
            TipoGastoProrrateo: values[19],
            Egresos: values[21],
            Ingresos: values[17],
            IvaPend: values[13],
            Devoluciones: values[26],
            ImpEspecial: values[25],
            IvaPagado: values[23],
            RetISR: values[14],
            RetIva: values[16],
            RetIvaCCH: values[15],
            RetIvaCTR: values[22],
            AplRegContableConcepto: values[29]
        }
    }
    else if (txtBandera.GetText() == "Cancelar")
    {             

        txtTipoGasto.SetText(arreglo.TipoGasto);
        txtDescripcion.SetText(arreglo.Descripcion);
        cmbTipoConcepto.SetValue(arreglo.TipoConcepto);
        cmbTipoProrrateo.SetValue(arreglo.TipoProrrateo);
        cmbCentroCostos.SetValue(arreglo.CentroCostos);
        rblSujetoRetencionIVA.SetValue(arreglo.SujetoRetencionIVA);
        rblSujetoRetencionISR.SetValue(arreglo.SujetoRetencionISR);
        txtRetencionIVA.SetText(arreglo.RetencionIVA);
        txtIVA.SetText(arreglo.IVA);
        txtImpEsp.SetText(arreglo.ImpEsp);
        rblAplicaPersonas.SetValue(arreglo.AplicaPersonas);
        rblPresupuestoBaseFacturado.SetValue(arreglo.PresupuestoBaseFacturado);
        cmbTipoGastoProvision.SetValue(arreglo.TipoGastoProvision);
        rblProrrateoFacturacion.SetValue(arreglo.ProrrateoFacturacion);
        cmbTipoGastoProrrateo.SetValue(arreglo.TipoGastoProrrateo);
        cmbEgresos.SetValue(arreglo.Egresos);
        cmbIngresos.SetValue(arreglo.Ingresos);
        cmbIvaPend.SetValue(arreglo.IvaPend);
        cmbDevoluciones.SetValue(arreglo.Devoluciones);
        cmbImpEspecial.SetValue(arreglo.ImpEspecial);
        cmbIvaPagado.SetValue(arreglo.IvaPagado);
        txtRetISR.SetText(arreglo.RetISR);
        txtRetIva.SetText(arreglo.RetIva);
        txtRetIvaCCH.SetText(arreglo.RetIvaCCH);
        txtRetIvaCTR.SetText(arreglo.RetIvaCTR);
        rblAplRegContableConcepto.SetValue(arreglo.AplRegContableConcepto);
    }
}
//********************************** FUNCIONES PARA LA ACCIÓN DE LOS BOTONES ConceptDeEgresos ************************************
function DeshabilitaConceptoDeEgresos() {
    // txtTipoGasto.SetEnabled(false);
    txtDescripcion.GetInputElement().readOnly = true;
    cmbTipoConcepto.SetEnabled(false);
    cmbTipoProrrateo.SetEnabled(false);
    cmbCentroCostos.SetEnabled(false);

    rblSujetoRetencionIVA.SetEnabled(false);
    rblSujetoRetencionISR.SetEnabled(false);
    txtRetencionIVA.GetInputElement().readOnly = true;
    txtIVA.GetInputElement().readOnly = true;

    txtImpEsp.GetInputElement().readOnly = true;
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

    txtRetISR.GetInputElement().readOnly = true;
    txtRetIva.GetInputElement().readOnly = true;
    txtRetIvaCCH.GetInputElement().readOnly = true;
    txtRetIvaCTR.GetInputElement().readOnly = true;
    rblAplRegContableConcepto.SetEnabled(false);
}
function HabilitaConceptoDeEgresos() {
    //debugger;
    //txtTipoGasto.SetEnabled(true);
    txtDescripcion.GetInputElement().readOnly = false;
    cmbTipoConcepto.SetEnabled(true);
    cmbTipoProrrateo.SetEnabled(true);
    cmbCentroCostos.SetEnabled(true);

    rblSujetoRetencionIVA.SetEnabled(true);
    rblSujetoRetencionISR.SetEnabled(true);
    txtRetencionIVA.GetInputElement().readOnly = false;
    txtIVA.GetInputElement().readOnly = false;

    txtImpEsp.GetInputElement().readOnly = false;
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

    txtRetISR.GetInputElement().readOnly = false;
    txtRetIva.GetInputElement().readOnly = false;
    txtRetIvaCCH.GetInputElement().readOnly = false;
    txtRetIvaCTR.GetInputElement().readOnly = false;
    rblAplRegContableConcepto.SetEnabled(true);
}
function LimpiaConceptoDeEgresos() {
   // debugger;
    //glBusqueda.SetValue(-1);
    for (i = 0; i < document.forms[0].length; i++) {
        doc = document.forms[0].elements[i];
        switch (doc.type) {
            case "text":
                doc.value = "";
                break;
            default:
                break;
        }
    }
    
    rblSujetoRetencionIVA.SetValue(-1);
    rblSujetoRetencionISR.SetValue(-1);
    rblAplicaPersonas.SetValue(-1);
    rblPresupuestoBaseFacturado.SetValue(-1);
    rblProrrateoFacturacion.SetValue(-1);
    rblAplRegContableConcepto.SetValue(-1);
    cmbEgresos.SetValue('111111');
    cmbIngresos.SetValue('111111');
    cmbIvaPend.SetValue('111111');
    cmbDevoluciones.SetValue('111111');
    cmbImpEspecial.SetValue('111111');
    cmbIvaPagado.SetValue('111111');

    txtRetISR.SetText('16');
    txtRetIvaCCH.SetText('16');
    txtRetIva.SetText('16');
    txtRetIvaCTR.SetText('16');
    rblAplRegContableConcepto.SetValue('0');
    


}


