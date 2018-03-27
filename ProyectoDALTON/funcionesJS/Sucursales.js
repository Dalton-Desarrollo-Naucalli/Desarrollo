
function HabilitaSucursales() {   
    txtNumSucursal.SetEnabled(false);
    txtNombre.SetEnabled(true);
    txtDireccion.SetEnabled(true);
    txtColonia.SetEnabled(true);
    txtCP.SetEnabled(true);
    cmbMunicipio.SetEnabled(true);
    cmbEstado.SetEnabled(true);
    txtTelefono.SetEnabled(true);
    txtTelefono2.SetEnabled(true);
    txtFax.SetEnabled(true);
    txtCostoAdmvo.SetEnabled(true);
    txtNumVendedores.SetEnabled(true);
    txtCostoMinVendedor.SetEnabled(true);
    cmbAreaRegion.SetEnabled(true);
    cmbAuxiliarVentas.SetEnabled(true);
    cmbDescAuxiliarVentas.SetEnabled(true);
    txtContadorFiscal.SetEnabled(true);
    txtContadorRemisiones.SetEnabled(true);
    cmbNoCuenta.SetEnabled(true);
    txtSerieFacturas.SetEnabled(true);
    txtSerieRemisiones.SetEnabled(true);
    txtContadorRecibosPagos.SetEnabled(true);
    txtSerieRecibosPagos.SetEnabled(true);
    cmbAuxiliarDevoluciones.SetEnabled(true);
    cmbDescAuxiliarDevolucione.SetEnabled(true);
    txtContadorReciboFiscal.SetEnabled(true);
    txtSerieReciboFiscal.SetEnabled(true);
    cmbAuxiliarDescuentos.SetEnabled(true);
    cmbDescAuxiliarDescuentos.SetEnabled(true);
    txtContadorContratos.SetEnabled(true);
    cmbZonaFiscal.SetEnabled(true);
    txtSerieNotaCredito.SetEnabled(true);
    txtContadorNotaCredito.SetEnabled(true);
    txtContadorCompra.SetEnabled(true);
    cmbSucursalFacturadora.SetEnabled(true);
    cmbAlmacenPredeterminado.SetEnabled(true);
    cmbAuxIvaPendiente.SetEnabled(true);
    cmbDescAuxIvaPendiente.SetEnabled(true);
    txtNombreFormatoFactura.SetEnabled(true);
    txtNombreFormatoNC.SetEnabled(true);
    rbSucursalActiva.SetEnabled(true);
    cmbEmpresa.SetEnabled(true);

}

function MuestraSucursales() {
    //debugger;
    var grid = glBusqueda.GetGridView();
    //************1*******2********3*******4********5**********6********7*******8*********9******10******11**********12**************13***************14*********15**********16******************17***********18******19******20*******21*********22*************23****************24*********25***********26*******************27*************28***********29********30*********31************32**********************33****************34**********************35************36************37******38
    campos = 'modulo_id;nombre;direccion;colonia;cod_postal;municipio;estado;telefono1;telefono2;fax;costo_admvo;num_vendedores;costo_min_vendedor;id_proyecto;auxiliar;ContadorFacturas;ContadorRemisiones;idcuenta;SerieF;SerieR;ContadorPagos;SerieP;auxiliar_devoluciones;ContadorRecibo;SerieRB;auxiliar_descuentos;ContadorContratos;zona_fiscal_id;SerieNC;ContadorNC;ContadorOC;SucursalFacturadora_id;Id_almacen_default;auxiliar_IVAPendiente;nom_formato_factura;nom_formato_nc;activo;ID_empresa';
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_Sucursales);
}

function ObtieneValor_Sucursales(values) {
   //debugger;
    txtNumSucursal.SetText(values[0]);
    txtNombre.SetText(values[1]);
    txtDireccion.SetText(values[2]);
    txtColonia.SetText(values[3]);
    txtCP.SetText(values[4]);
    cmbMunicipio.SetValue(values[5]);
    cmbEstado.SetValue(values[6]);
    txtTelefono.SetText(values[7]);
    txtTelefono2.SetText(values[8]);
    txtFax.SetText(values[9]);
    txtCostoAdmvo.SetText(values[10]);
    txtNumVendedores.SetText(values[11]);
    txtCostoMinVendedor.SetText(values[12]);
    cmbAreaRegion.SetValue(values[13]);
    cmbAuxiliarVentas.SetValue(values[14]);
    cmbDescAuxiliarVentas.SetValue(values[14]);
    txtContadorFiscal.SetText(values[15]);
    txtContadorRemisiones.SetValue(values[16]);
    cmbNoCuenta.SetValue(values[17]);
    txtSerieFacturas.SetText(values[18]);
    txtSerieRemisiones.SetText(values[19]);
    txtContadorRecibosPagos.SetText(values[20]);
    txtSerieRecibosPagos.SetText(values[21]);
    cmbAuxiliarDevoluciones.SetValue(values[22]);
    cmbDescAuxiliarDevolucione.SetValue(values[22]);
    txtContadorReciboFiscal.SetText(values[23]);
    txtSerieReciboFiscal.SetText(values[24]);
    cmbAuxiliarDescuentos.SetValue(values[25]);
    cmbDescAuxiliarDescuentos.SetValue(values[25]);
    txtContadorContratos.SetText(values[26]);
    cmbZonaFiscal.SetValue(values[27])
    txtSerieNotaCredito.SetText(values[28]);
    txtContadorNotaCredito.SetText(values[29]);
    txtContadorCompra.SetText(values[30]);
    cmbSucursalFacturadora.SetValue(values[31]);
    cmbAlmacenPredeterminado.SetValue(values[32]);
    cmbAuxIvaPendiente.SetValue(values[33]);
    cmbDescAuxIvaPendiente.SetValue(values[33]);
    txtNombreFormatoFactura.SetText(values[34]);
    txtNombreFormatoNC.SetText(values[35]);
    rbSucursalActiva.SetValue(values[36]);
    cmbEmpresa.SetValue(values[37]);   
    GVCentroCostosProceso.Refresh();

}

function DeshabilitaSucursales() {
    txtNumSucursal.SetEnabled(false);
    txtNombre.SetEnabled(false);
    txtDireccion.SetEnabled(false);
    txtColonia.SetEnabled(false);
    txtCP.SetEnabled(false);
    cmbMunicipio.SetEnabled(false);
    cmbEstado.SetEnabled(false);
    txtTelefono.SetEnabled(false);
    txtTelefono2.SetEnabled(false);
    txtFax.SetEnabled(false);
    txtCostoAdmvo.SetEnabled(false);
    txtNumVendedores.SetEnabled(false);
    txtCostoMinVendedor.SetEnabled(false);
    cmbAreaRegion.SetEnabled(false);
    cmbAuxiliarVentas.SetEnabled(false);
    cmbDescAuxiliarVentas.SetEnabled(false);
    txtContadorFiscal.SetEnabled(false);
    txtContadorRemisiones.SetEnabled(false);
    cmbNoCuenta.SetEnabled(false);
    txtSerieFacturas.SetEnabled(false);
    txtSerieRemisiones.SetEnabled(false);
    txtContadorRecibosPagos.SetEnabled(false);
    txtSerieRecibosPagos.SetEnabled(false);
    cmbAuxiliarDevoluciones.SetEnabled(false);
    cmbDescAuxiliarDevolucione.SetEnabled(false);
    txtContadorReciboFiscal.SetEnabled(false);
    txtSerieReciboFiscal.SetEnabled(false);
    cmbAuxiliarDescuentos.SetEnabled(false);
    cmbDescAuxiliarDescuentos.SetEnabled(false);
    txtContadorContratos.SetEnabled(false);
    cmbZonaFiscal.SetEnabled(false);
    txtSerieNotaCredito.SetEnabled(false);
    txtContadorNotaCredito.SetEnabled(false);
    txtContadorCompra.SetEnabled(false);
    cmbSucursalFacturadora.SetEnabled(false);
    cmbAlmacenPredeterminado.SetEnabled(false);
    cmbAuxIvaPendiente.SetEnabled(false);
    cmbDescAuxIvaPendiente.SetEnabled(false);
    txtNombreFormatoFactura.SetEnabled(false);
    txtNombreFormatoNC.SetEnabled(false);
    rbSucursalActiva.SetEnabled(false);
    cmbEmpresa.SetEnabled(false);

}

//**************************** Municipio*************************************
function LlenaMunicipio() {
    var IdEstado;
    IdEstado = cmbEstado.GetValue();
    cmbMunicipio.PerformCallback(IdEstado);
}
//**********************************Auxiliar ventas*****************************
function LlenaDescAuxVentas() {
    var AuxiliarV;
    AuxiliarV = cmbAuxiliarVentas.GetValue();
    cmbDescAuxiliarVentas.SetValue(AuxiliarV);
}

function LlenaAuxiliarVentas() {
    var DescAuxiliarV;
    DescAuxiliarV = cmbDescAuxiliarVentas.GetValue();
    cmbAuxiliarVentas.SetValue(DescAuxiliarV);
}

//**********************************Auxiliar devoluciones*****************************
function LlenaDescAuxiliarDevoluciones() {
    var AuxiliarD;
    AuxiliarD = cmbAuxiliarDevoluciones.GetValue();
    cmbDescAuxiliarDevolucione.SetValue(AuxiliarD);
}

function LlenaAuxiliarDevoluciones() {
    var DescAuxiliarD;
    DescAuxiliarD = cmbDescAuxiliarDevolucione.GetValue();
    cmbAuxiliarDevoluciones.SetValue(DescAuxiliarD);
}

//**********************************Auxiliar Descuentos*****************************
function LlenaDescAuxDescuentos() {
    var AuxiliarDes;
    AuxiliarDes = cmbAuxiliarDescuentos.GetValue();
    cmbDescAuxiliarDescuentos.SetValue(AuxiliarDes);
}

function LlenaAuxiliarDescuentos() {
    var DescAuxiliarDes;
    DescAuxiliarDes = cmbDescAuxiliarDescuentos.GetValue();
    cmbAuxiliarDescuentos.SetValue(DescAuxiliarDes);
}


//**********************************Auxiliar Iva pendiente*****************************
function LlenaDescAuxIvaPend () {
    var AuxiliarIVA;
    AuxiliarIVA = cmbAuxIvaPendiente.GetValue();
    cmbDescAuxIvaPendiente.SetValue(AuxiliarIVA);
}

function LlenaAuxIvaPendiente() {
    var DescAuxiliarIVA;
    DescAuxiliarIVA = cmbDescAuxIvaPendiente.GetValue();
    cmbAuxIvaPendientev.SetValue(DescAuxiliarIVA);
}
  
function OnEndCallback(s, e) {
  
    if (isUpdated) {
        alert(s.cpAccion);
        isUpdated = false;
    }
    IdNuevo(s, e);
}
//FUNCION NUEVO ID DESPUES DE UN REGISTRO COMPLETO DE FORMULARIO CON GRID
function IdNuevo(s, e) {
    if (txtNumSucursal.GetText() == '') {
        txtNumSucursal.SetText(s.cpNumSuc);
    }
}
