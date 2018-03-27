//Habilita todos Botones**********************
function HabilitaBotones() {
    btnAgregar.SetEnabled(true);
    btnEditar.SetEnabled(true);
    btnEliminar.SetEnabled(true);
    btnCancelar.SetEnabled(true);
    btnActualizar.SetEnabled(true);
}
//Función que limpia Controles****************
function LimpiaControles() {
    for (i = 0; i < document.forms[0].length; i++) {
        doc = document.forms[0].elements[i];
        switch (doc.type) {
            case "text":
                doc.value = "";
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
//Función Botón Agregar***********************
function Enc_BotonAgregar() {
    if (btnAgregar.GetChecked()) {
        btnEditar.SetEnabled(false);
        btnEliminar.SetEnabled(false);
        btnCancelar.SetEnabled(true);
        btnActualizar.SetEnabled(true);
    } else {
        btnEditar.SetEnabled(false);
        btnEliminar.SetEnabled(false);
        btnCancelar.SetEnabled(false);
        btnActualizar.SetEnabled(false);
    }
}
 //Función Botón Editar***********************
function Enc_BotonEditar() {
    if (btnEditar.GetChecked()) {
        btnAgregar.SetEnabled(false);
        btnEliminar.SetEnabled(false);
    } else {
        btnAgregar.SetEnabled(true);
        btnEliminar.SetEnabled(true);
    }
}    
//Confirma eliminación************************
function ConfirmarEliminar() {

        var Busqueda = glBusqueda.GetValue();
        if (Busqueda == null) {
            alert('Selecciona un registro.');
        }
        else {
            var mensaje = confirm("¿Desea eliminar el registro seleccionado?");
            if (mensaje) {
                cbEliminar.PerformCallback();
            }
        }
    }
 //Limpia formulario después de eliminar******
function limpia(tipo) {

        var ti = tipo;
        if (ti == "0")
            LimpiaControles();

    }
 //Función pulsar(Enter en combo)*************
function pulsar(e) {
        tecla = (document.all) ? e.keyCode : e.which;
        if (tecla == 13) return false;
}
 //Función Bloquea Agrega (Devuelve ID nuevo)*
function BloqueaAgrega() {
    //debugger;
    btnAgregar.SetChecked(false);
    btnEditar.SetEnabled(true);
    btnEditar.SetChecked(true);
    btnAgregar.SetEnabled(false);
    btnEliminar.SetEnabled(false);

} 
 // Función Solo números *********************
function ValidaSoloNumeros() {
    //debugger;
if ((event.keyCode < 48) || (event.keyCode > 57))
        event.returnValue = false;
}
//Función Mensajes Grids En Forms. Independientes
var isUpdated = false;
function OnBeginCallback(s, e) {
    //debugger;
        if (e.command == "UPDATEEDIT")
        isUpdated = true;       
    }
//Función ValidaDecimales.
	function ValidaDecimales(field) {
    if (event.keyCode > 47 && event.keyCode < 58) {
        if (field.value == "") return true
        regexp = /.[0-9]{2}$/
        return !(regexp.test(field.value))
    }
    if (event.keyCode == 46) {
        if (field.value == "") return false
        regexp = /^[0-9]+$/
        return regexp.test(field.value)
    }

    event.returnValue = false;
}

//************************************************************************Mensajes personalizados*******************************************************************
function ShowMessage(messageObject, mensaje, titulo) {
    debugger;
    if (messageObject != null) {

        $.toast({
            heading: titulo,
            text: mensaje,
            icon: messageObject,
            loader: false,
            showHideTransition: 'slide',
            hideAfter: false,
            allowToastClose: true,
            position: 'top-center',
            stack: 4
        });
        
    }
}

 