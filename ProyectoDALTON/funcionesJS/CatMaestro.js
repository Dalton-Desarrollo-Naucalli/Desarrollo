var arreglo = null;
var s;

function OnBuscar() {
    GridFinammico.PerformCallback('Buscar');
}

function Colapse(s, e) {
    //debugger;
    if (s = 1){ 
    ASPxRoundPanel1.SetCollapsed(false);
    }
}

function OnActualizaZonaFiscal() {
    gvImpuestosZonaFiscal.PerformCallback('Actualizar');
}
//Abre un nuevo formulario dentro de un popup
function AbreForm() {
    debugger;   

    var NomFrm = txtForm.GetText();
    window.open(NomFrm, '_parent', 'channelmode = no,directories = no,fullscreen = yes,height=800,width=1400,left = 80,location = no,menubar = yes,resizable = yes,scrollbars = yes,status = no,titlebar = ' + NomFrm + ',toolbar = yes,top = 0')

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
    debugger;
    txtIdPar.SetText(values);
    var NomFrm = txtForm.GetText();
    window.open(NomFrm + '?IdTab=' + values, '_parent', 'channelmode = no,directories = no,fullscreen = yes,height=800,width=1400,left = 80,location = no,menubar = yes,resizable = yes,scrollbars = yes,status = no,titlebar = ' + NomFrm + ',toolbar = yes,top = 0')
}