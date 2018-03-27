//-------------------------------------------------FUNCIONES PARA FACTUAS SEGUROS-----------------------------------------------------------
function OnActualizaNoMatch() {
    //debugger;
    gvNoMatch.PerformCallback('Actualizar');
    }
function OnActualizaNoAutorizadas() {
    //debugger;
    gvNoAuto.PerformCallback('Actualizar');
}
function onRowClick(s, e) {
    //debugger;
    selectedVisibleIndexFacturasSeguros = e.visibleIndex; //para ver en donde el usuario dio clic
   // if (bandera == 0) { // aquí puedes preguntar tu si es un registro nuevo o viene de un update, si no, pues quitas ese if

    gvFacSeg.GetRowValues(selectedVisibleIndexFacturasSeguros, 'Poliza1;ConfirmarPago;ID', GetFieldValuesForEditGvFacturasSeguros); //aqui recuperarias el valor de la columna nde la cual haras la validación

    //}
    //else { // de igual forma si no te sirvio el if o no lo requieres este if no va
    //    mesContableGrid.SetEnabled(true);
    //    anioContableGrid.SetEnabled(true);
    }
function GetFieldValuesForEditGvFacturasSeguros(values) {
        //debugger;

        var EstatusV = "";
        var GrupoPagoV = "";

        EstatusV = values[0];
        GrupoPagoV = values[1];

        if (EstatusV == null) {
            chbConfirmarPago.SetEnabled(false);
            chbConfirmarPago.SetChecked(false);
            //mesContableGrid.SetEnabled(true);
            //anioContableGrid.SetEnabled(true);
        }
        else {
            chbConfirmarPago.SetEnabled(true);
            //mesContableGrid.SetEnabled(false);
            //anioContableGrid.SetEnabled(false);
        }



    }
//-------------------------------------------------------------------------------------------------------------------------------------------

//-------------------------------------------------FUNCIONES PARA MONITOR GENERAL DE SEGUROS-------------------------------------------------
//DEBUGGER
//function OnGridFocusedRowChangedIdParMonitorSeguros() {
//    gvMonitorSeg.GetRowValues(gvMonitorSeg.GetFocusedRowIndex(), 'cred_id;Endoso;fechaVencimiento;consecutivoPoliza;Estatus', OnGetRowValuesIdParMonitorSeguros);
//}
//function OnGetRowValuesIdParMonitorSeguros(values) {
//    var NomFrm = "Frm_DatosDePoliza.aspx";
//    window.open(NomFrm + '?IdTab=' + values, '_self', 'channelmode = no,directories = no,fullscreen = yes,height=665,width=1230,left = 80,location = no,menubar = no,resizable = yes,scrollbars = yes,status = no,titlebar = ' + NomFrm + ',toolbar = no,top = 0')
//    //window.open(NomFrm, '_blank', 'channelmode = no,directories = no,fullscreen = yes,height=665,width=1230,left = 80,location = no,menubar = no,resizable = yes,scrollbars = yes,status = no,titlebar = ' + NomFrm + ',toolbar = no,top = 0')
//}

function OnGridFocusedRowChangedMonitor() {
    gvMonitorSeg.GetRowValues(gvMonitorSeg.GetFocusedRowIndex(), 'cred_id;Endoso;fechaVencimiento;consecutivoPoliza;Estatus', OnGetRowValuesIdParMonitor);
}
function OnGetRowValuesIdParMonitor(values) {
    var flag = txtBan.GetText();
    var NomFrm = "Frm_DatosDePoliza.aspx";
    var endoso = '';
    var vence = '';
    var cancela = 'NO';

    if (values[1] === '' || values[1] === ' ') { endoso = 'NO' } else { endoso = values[1] }
    vence = new Date(values[2]).toISOString().slice(0, 10);

    if (values[4] === 'Solicitud de Cancelación') {
        cancela = 'SI';
    }

    window.open(NomFrm + '?IdTab=' + values[0] + '&Endoso=' + endoso + "&Vence=" + vence + "&secuencia=" + values[3] + "&cancela=" + cancela, '_self', 'channelmode = no,directories = no,fullscreen = yes,height=665,width=1230,left = 80,location = no,menubar = no,resizable = yes,scrollbars = yes,status = no,titlebar = ' + NomFrm + ',toolbar = no,top = 0')
}

//-------------------------------------------------------------------------------------------------------------------------------------------