
//FUNCIONES MUESTRA PRODUCTOS EN FORMULARIO
function MuestraProductos() {
    //debugger;
    var grid = glBusqueda.GetGridView();
    campos = 'prod_id;cat_id;marca_id;mod_id;unidades_cons;Tipo_Manejo_Inventario;Existencia_minima;individualizable;desc_corta;desc_completa;tipo_comision;Numero_Parte;codigodebarras;moneda_id;PrecioVenta;Inventariable;ID_capas;ID_clase;id_tipogasto;valuacion_del_inventario;Origen;Existencia_maxima;Cve_arancel;desc_sintetica;valor_comision;precio_lista;max_precio_compra;max_costo_compra;VigenciaPrecio';
    grid.GetRowValues(grid.GetFocusedRowIndex(), campos, ObtieneValor_Productos);
}
function ObtieneValor_Productos(values) {
    //debugger;
    txtNoProducto.SetText(values[0]);
    cmbCategoria.SetValue(values[1]);      
    cmbMarca.SetValue(values[2]);  
    cmbModelo.SetValue(values[3]);   
    cmbUnidadDeMedida.SetValue(values[4]);    
    cmbTipoManejoInventario.SetValue(values[5]);
    txtExistenciaMin.SetText(values[6]);
    rbtnIndividualizable.SetValue(values[7]);
    txtDescripcionCorta.SetText(values[8]);
    txtDescripcionCompleta.SetText(values[9]);
    cmbTipoDeComision.SetValue(values[10]);
    txtNumeroDeParte.SetText(values[11]);
    txtCodigoFabricante.SetText(values[12]);
    cmbMonedaPrecioVenta.SetValue(values[13]);
    txtPrecioMinVenta.SetText(values[14]);    
    cmbTipoDeProducto.SetValue(values[15]);
    cmbCapaDepreciacion.SetValue(values[16]);
    cmbClase.SetValue(values[17]);
    cmbConcepto.SetValue(values[18]);
    cmbValuacionInventario.SetValue(values[19]);
    rbtnOrigen.SetValue(values[20]);
    txtExistenciaMax.SetText(values[21]);
    cmbClasificacionArancelaria.SetValue(values[22]);
    txtDescripcionsintetica.SetText(values[23]);
    txtValor.SetText(values[24]);
    txtPrecioPubico.SetText(values[25]);
    txtMaxPrecioCompra.SetText(values[26]);
    txtMaxCostoIndirecto.SetText(values[27]);
    txtVigenciaPrecio.SetValue(values[28]);
    GVProdProv.Refresh();
}

//FUNCION QUE HABILITA LOS CONTROLES DEL FORMULARIO PRODUCTOS
function HabilitaProductos() {
    //debugger;
    cmbCategoria.SetEnabled(true);
    cmbMarca.SetEnabled(true);
    cmbModelo.SetEnabled(true);
    cmbUnidadDeMedida.SetEnabled(true);
    cmbTipoManejoInventario.SetEnabled(true);
    rbtnOrigen.SetEnabled(true);
    cmbTipoDeProducto.SetEnabled(true);
    cmbCapaDepreciacion.SetEnabled(true);
    cmbClase.SetEnabled(true);
    cmbConcepto.SetEnabled(true);
    cmbValuacionInventario.SetEnabled(true);
    txtExistenciaMin.SetEnabled(true);
    txtExistenciaMax.SetEnabled(true);
    rbtnIndividualizable.SetEnabled(true);
    txtDescripcionCorta.SetEnabled(true);
    txtDescripcionsintetica.SetEnabled(true);
    txtDescripcionCompleta.SetEnabled(true);
    cmbClasificacionArancelaria.SetEnabled(true);
    cmbTipoDeComision.SetEnabled(true);
    txtValor.SetEnabled(true);
    txtNumeroDeParte.SetEnabled(true);
    txtCodigoFabricante.SetEnabled(true);
    cmbMonedaPrecioVenta.SetEnabled(true);
    txtPrecioMinVenta.SetEnabled(true);
    txtPrecioPubico.SetEnabled(true);
    txtMaxPrecioCompra.SetEnabled(true);
    txtMaxCostoIndirecto.SetEnabled(true);
    txtVigenciaPrecio.SetEnabled(true);
}
function DeshabilitaProductos() {
    cmbCategoria.SetEnabled(false);
    cmbMarca.SetEnabled(false);
    cmbModelo.SetEnabled(false);
    cmbUnidadDeMedida.SetEnabled(false);
    cmbTipoManejoInventario.SetEnabled(false);
    rbtnOrigen.SetEnabled(false);
    cmbTipoDeProducto.SetEnabled(false);
    cmbCapaDepreciacion.SetEnabled(false);
    cmbClase.SetEnabled(false);
    cmbConcepto.SetEnabled(false);
    cmbValuacionInventario.SetEnabled(false);
    txtExistenciaMin.SetEnabled(false);
    txtExistenciaMax.SetEnabled(false);
    rbtnIndividualizable.SetEnabled(false);
    txtDescripcionCorta.SetEnabled(false);
    txtDescripcionsintetica.SetEnabled(false);
    txtDescripcionCompleta.SetEnabled(false);
    cmbClasificacionArancelaria.SetEnabled(false);
    cmbTipoDeComision.SetEnabled(false);
    txtValor.SetEnabled(false);
    txtNumeroDeParte.SetEnabled(false);
    txtCodigoFabricante.SetEnabled(false);
    cmbMonedaPrecioVenta.SetEnabled(false);
    txtPrecioMinVenta.SetEnabled(false);
    txtPrecioPubico.SetEnabled(false);
    txtMaxPrecioCompra.SetEnabled(false);
    txtMaxCostoIndirecto.SetEnabled(false);
    txtVigenciaPrecio.SetEnabled(false);
}
//FUNCIONES VALIDA COMBOS INDEPENDIENTES.
function CargaMarca() {
    cmbMarca.PerformCallback();
}
function CargaModelo() {
    cmbModelo.PerformCallback();
}
function CargaUnidad() {
    cmbUnidadDeMedida.PerformCallback();
}
function CargaTipoManejo() {
    cmbTipoManejoInventario.PerformCallback();
}
function CargaTipoProducto() {
    cmbTipoDeProducto.PerformCallback();
}

//FUNCION VALIDA TIPO DE PRODUCTO.
function TipoProducto() {
    //debugger;
    var MercSobreven;
    MercSobreven == 'NO';
    //Validación Tipo de Producto = ACTIVO.
    cmbTipoManejoInventario.SetEnabled(false);
    cmbTipoManejoInventario.SetValue() == null;
    if ((cmbTipoDeProducto.GetText() != "") && (cmbTipoDeProducto.GetValue() != null)) {
        if ((cmbTipoDeProducto.GetValue() == 3) && (MercSobreven == "NO")) {
            cmbTipoManejoInventario.Value == 0;
            cmbTipoManejoInventario.SetEnabled(false);
            cmbTipoManejoInventario.SetValue() == null;
        }

        if (cmbTipoDeProducto.GetValue() == 1) {
            cmbClase.SetVisible(true);
            lblClase.SetVisible(true);
            cmbCapaDepreciacion.SetVisible(true);
            lblCapaDepreciacion.SetVisible(true);
            cmbValuacionInventario.SetVisible(false);
            cmbValuacionInventario.SetValue() == null;
            lblValuacionInventario.SetVisible(false);
            txtExistenciaMin.SetVisible(false);
            txtExistenciaMin.SetText() == null;
            lblExistenciasMinimas.SetVisible(false);
            txtExistenciaMax.SetVisible(false);
            txtExistenciaMax.SetText() == null;
            lblExistenciaMaxima.SetVisible(false);
            cmbTipoManejoInventario.SetEnabled(false);
            cmbTipoManejoInventario.SetValue() == null;
        }
        else {
            if (cmbTipoDeProducto == 4) {
                //Si es un servicio el tipo de manejo de inventario de inventario debe ser siempre sobrevendible
                cmbTipoManejoInventario == 1;
                cmbTipoManejoInventario.SetEnabled(true);
            }
            else {
                cmbTipoManejoInventario.SetEnabled(false);
                cmbTipoManejoInventario.SetValue() == null;
            }
            //Si es Mercancía o Consumible deben visualizarse los controles Valuación del inventario y Punto de Reorden.
            if ((cmbTipoDeProducto.GetValue() == 2) || (cmbTipoDeProducto.GetValue() == 3)) {
                if (cmbTipoDeProducto.Value = 3) {
                    cmbValuacionInventario.SetVisible(true);
                    lblValuacionInventario.SetVisible(true);
                }
                else {
                    cmbValuacionInventario.SetVisible(false);
                    cmbValuacionInventario.SetValue() == null;
                    lblValuacionInventario.SetVisible(false);
                }
                txtExistenciaMin.SetVisible(true);
                lblExistenciasMinimas.SetVisible(true);
                txtExistenciaMax.SetVisible(true);
                lblExistenciaMaxima.SetVisible(true);
            }
            else {
                cmbValuacionInventario.SetVisible(false);
                cmbValuacionInventario.SetValue() == null;
                lblValuacionInventario.SetVisible(false);
                txtExistenciaMin.SetVisible(false);
                txtExistenciaMin.SetText() == null;
                lblExistenciasMinimas.SetVisible(false);
                txtExistenciaMax.SetVisible(false);
                txtExistenciaMax.SetText() == null;
                lblExistenciaMaxima.SetVisible(false);
            }
            cmbClase.SetVisible(false);
            cmbClase.SetValue() == null;
            lblClase.SetVisible(false);
            cmbCapaDepreciacion.SetVisible(false);
            cmbCapaDepreciacion.SetValue() == null;
            lblCapaDepreciacion.SetVisible(false);
        }
    }
}

function DatosVacios() {
     debugger;
        for (i = 0; i < document.forms[0].length; i++) {
            doc = document.forms[0].elements[i];
            switch (doc.type) {
                case "text":
                    if (doc.value = ""){
                    //if ((doc.value = "")|(txtVigenciaPrecio.GetText() == "")){
                        doc.value == null;
                        
                    }

                    break;
                case "checkbox":
                    doc.SelectedIndex = -1;
                    break;
                case "radio":
                    doc.SelectedIndex = -1;
                    break;
                default:
                    break;
        }
    }
}
var isUpdated = false;

//FUNCION ALERTAS DEL GRID RELACION PRODUCTO-PROVEEDOR
function OnEndCallback(s, e) {
    //debugger;
    if (isUpdated) {
        alert(s.cpAccion);
        isUpdated = false;           
    }
    IdNuevo(s, e);
}
//FUNCION NUEVO ID DESPUES DE UN REGISTRO COMPLETO DE FORMULARIO CON GRID
function IdNuevo(s, e) {
    if (txtNoProducto.GetText() == '') {
        txtNoProducto.SetText(s.cpIDProd);
    }
}

