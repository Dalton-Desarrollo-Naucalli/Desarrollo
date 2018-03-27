function load() {
    debugger;
    //HabilitarBotonesDefault();
    //tsDispersionDetalle.SetHeight(550);
    
    gv_DevolucionesBursa.SetHeight(300);
}

function OnBuscar()
{
    debugger;
    gv_DevolucionesBursa.UA_ClearSearchFilter();
    //Buscar = 1;
    gv_DevolucionesBursa.PerformCallback('Buscar');
}