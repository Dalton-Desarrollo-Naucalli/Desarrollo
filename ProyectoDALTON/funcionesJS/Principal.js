//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
//      FUNCIONES GLOBALES APLICAN PARA TODOS LOS FORMULARIOS
//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 
 
 
 
 // Removes leading whitespaces

    function validaCorreoElectronico(eMail)
      {
       var filter=/^[A-Za-z][A-Za-z0-9_]*@[A-Za-z0-9_]+\.[A-Za-z0-9_.]+[A-za-z]$/;
       
       if(eMail.length == 0 )
         {
          return true;
         }
        
       if(filter.test(eMail))
         {
          return true;
         }
       else
         {
          return false;         
         }  
      }         




 

function validaCampo (valor,min,max,bint,nombre){
var tamValor = valor.length;

if ( bint == true ) 
{
 if ( tamValor >= min)
  {
   if (tamValor <= max)
    {
     for ( i = 0; i < valor.length; i++ ) {
            x = parseInt(valor.charAt(i));
            if (isNaN(x)) {
               var msg = encodeURI("El campo " + nombre + " debe de ser un número entero");
                if(VersionNavegador() != -1)
                 {
                window.showModalDialog("../Framework/Alerta.aspx?tipo_mensaje=2&mensaje=" + msg, null, 'dialogWidth:455px;dialogHeight:226px;dialogTop=250px; dialogLeft=250px;center=yes;toolbar=no;menubar=no');
                 }
                else
                {
                window.open("../Framework/Alerta.aspx?tipo_mensaje=2&mensaje=" + msg, '_blank', 'width=454px,height=223px,left=250,top=250');
                }
            
                return false;
            }
          }
          return true;
      }
       
    else {
    var msg = encodeURI("El campo " + nombre + " debe de ser menor o igual a " + max + " caracter(es)");
     if(VersionNavegador() != -1)
                 {
                window.showModalDialog("../Framework/Alerta.aspx?tipo_mensaje=2&mensaje=" + msg, null, 'dialogWidth:455px;dialogHeight:226px;dialogTop=250px; dialogLeft=250px;center=yes;toolbar=no;menubar=no');
                 }
                else
                {
                window.open("../Framework/Alerta.aspx?tipo_mensaje=2&mensaje=" + msg, '_blank', 'width=454px,height=223px,left=250,top=250');
                }
    return false; 
    }
   }
   else {
     var msg = encodeURI("El campo " + nombre + " debe de ser mayor a " + min + " caracter(es)");
     if(VersionNavegador() != -1)
                 {
                window.showModalDialog("../Framework/Alerta.aspx?tipo_mensaje=2&mensaje=" + msg, null, 'dialogWidth:455px;dialogHeight:226px;dialogTop=250px; dialogLeft=250px;center=yes;toolbar=no;menubar=no');
                 }
                else
                {
                window.open("../Framework/Alerta.aspx?tipo_mensaje=2&mensaje=" + msg, '_blank', 'width=454px,height=223px,left=250,top=250');
                }
   return false; 
   }
  }
  else 
   if (tamValor >= min)
   {
    if(tamValor <= max)
     return true;
    else  {
      var msg= encodeURI("El campo " + nombre + " debe de ser menor o igual a " + max + " caracter(es)");
            if(VersionNavegador() != -1)
                 {
                window.showModalDialog("../Framework/Alerta.aspx?tipo_mensaje=2&mensaje=" + msg, null, 'dialogWidth:455px;dialogHeight:226px;dialogTop=250px; dialogLeft=250px;center=yes;toolbar=no;menubar=no');
                 }
                else
                {
                window.open("../Framework/Alerta.aspx?tipo_mensaje=2&mensaje=" + msg, '_blank', 'width=454px,height=223px,left=250,top=250');
                }
     return false;
     }
   }
   else 
   {
        var msg = encodeURI("El campo " + nombre + " debe de ser mayor a  " + min + " caracter(es)");
                if(VersionNavegador() != -1)
                 {
                window.showModalDialog("../Framework/Alerta.aspx?tipo_mensaje=2&mensaje=" + msg, null, 'dialogWidth:455px;dialogHeight:226px;dialogTop=250px; dialogLeft=250px;center=yes;toolbar=no;menubar=no');
                 }
                else
                {
                window.open("../Framework/Alerta.aspx?tipo_mensaje=2&mensaje=" + msg, '_blank', 'width=454px,height=223px,left=250,top=250');
                }
   return false; 
   }
}    





   





        
        
//+++++++++++++++++++++++++++++++++++
//           FUNCION QUE SOLO ACEPTA NUMEROS
var nav4 = window.Event ? true : false;
function acceptNum(evt)
{ 
    // NOTE: Backspace = 8, Enter = 13, '0' = 48, '9' = 57 
    var key = nav4 ? evt.which : evt.keyCode; 
    return (key <= 13 || (key >= 48 && key <= 57));
}

//+++++++++++++++++++++++++++++++++++++++++++++++

var nav4 = window.Event ? true : false;
function acceptNot(evt)
{ 
    // NOTE: Backspace = 8, Enter = 13, '0' = 48, '9' = 57 
    var key = nav4 ? evt.which : evt.keyCode; 
    return (key <= 13 || (key >= 48 && key <= 57));
}



//Esta funcion formatea las cantidades con comas en los miles y dos decimales (TOP)
        function oNumero(numero)
          {
           this.valor = numero || 0
           this.dec = -1;
           this.formato = numFormat;
           this.ponValor = ponValor;
           
           
           function ponValor(cad)
             {
              if (cad =='-' || cad=='+') return
              if (cad.length ==0) return
              if (cad.indexOf('.') >=0)
                  this.valor = parseFloat(cad);
              else
                  this.valor = parseInt(cad);
             }
             
           function numFormat(dec, miles)
             {
              var num = this.valor, signo=3, expr;
              var cad = ""+this.valor;
              var ceros = "", pos, pdec, i;
                  for (i=0; i < dec; i++)
                       ceros += '0';
                       pos = cad.indexOf('.')
                if (pos < 0)
                    cad = cad+"."+ceros;
                else
                    {
                    pdec = cad.length - pos -1;
                    if (pdec <= dec)
                        {
                        for (i=0; i< (dec-pdec); i++)
                            cad += '0';
                        }
                    else
                        {
                        num = num*Math.pow(10, dec);
                        num = Math.round(num);
                        num = num/Math.pow(10, dec);
                        cad = new String(num);
                        }
                    }
                pos = cad.indexOf('.')
                if (pos < 0) pos = cad.lentgh
                if (cad.substr(0,1)=='-' || cad.substr(0,1) == '+')
                       signo = 4;
                if (miles && pos > signo)
                    do{
                        expr = /([+-]?\d)(\d{3}[\.\,]\d*)/
                        cad.match(expr)
                        cad=cad.replace(expr, RegExp.$1+','+RegExp.$2)
                        }
                while (cad.indexOf(',') > signo)
                    if (dec<0) cad = cad.replace(/\./,'')
                        return cad;
             }
        }//Fin del objeto oNumero:     
  

function formatCurrency(num,decimales) 
{
    num = num.toString().replace(/\$|\,/g,'');
    if(isNaN(num))
    {
        num = "0";
    }
    sign = (num == (num = Math.abs(num)));
    num = Math.floor(num*100+0.50000000001);
    cents = num%100;
    num = Math.floor(num/100).toString();
    if(cents < 10)
    {
        cents = "0" + cents;
    }
    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
    {
        num = num.substring(0,num.length-(4*i+3))+'.'+
        num.substring(num.length-(4*i+3));
    }
    if(decimales != 0)
    {
        return (((sign)?'':'-') + '' + num + ',' + cents);
    }
    else
    {
        return (((sign)?'':'-') + '' + num);
    }  
}


        function UnformatCurrency(cadena) //Este recibe una cadena '999.999.999.999,99'
        {
           var NuevaCad = cadena.replace(/\./g, ""); 
           NuevaCad = NuevaCad.replace(/,/g,".");
           return NuevaCad
        }
        
        
        function unformatNumber(cadena) //Este recibe una cadena '999.999.999.999,99'
        {
           var NuevaCad = cadena.replace(/\./g, ""); 
           NuevaCad = NuevaCad.replace(/,/g,".");
           return NuevaCad
        }        
 

//Esta funcion checa si el campo es numerico, y tiene un parametro que permite validar la coma para españa
      
     function FechaActual()
       {
        var mydate = new Date();
        var year = mydate.getYear();
        var day = mydate.getDay(); 
        var month = mydate.getMonth() + 1;        
        var daym = mydate.getDate();
        var FechaCompleta;
        
            if(year < 1000)
              {
               year+=1900;
              }
            
            if(month<10)
              {
               month = "0" + month;              
              }

            if(daym<10)
              {
               daym = "0" + daym;              
              }

        FechaCompleta = daym + "/" + month + "/" + year;
      
        return FechaCompleta;
       }          
       
        
function ValidaNumerosMX(valor,punto)
{
     var log=valor.length;
     var solounpunto = false;
     var sw="S";
     for(x=0; x<log; x++)
     {
        v1 = valor.substr(x,1);
        if(punto == 1)
        {
            if(v1 == "." && solounpunto == false)
            {
                v1 = 0;
                solounpunto = true;
            }
        }
        v2 = parseInt(v1);
        if(isNaN(v2))
        {
            sw= "N";
        }
     }
    if(sw == "S")
    {
        return true;
    }
    else
    {
        return false;
    }
}   
        
 
//***********FUNCION DE DIFERENCIA DE HORARIO***********
function DifHorario(Anio,Mes,Dia)
{
  var date1 = new Date(Anio, Mes-1, Dia, 0, 0, 0, 0);
  var date1UTC = date1.toGMTString();
  //alert(date1UTC.substring(0, date1UTC.lastIndexOf(" ")-1));
  var date2 = new Date(date1UTC.substring(0, date1UTC.lastIndexOf(" ")-1));
  //alert(date2);
  var hoursDiffStdTime = (date1 - date2) / (1000 * 60 * 60);
  //alert(hoursDiffStdTime);
  return hoursDiffStdTime;
      
}


function calcular_edad(fecha){ 

    //calculo la fecha de hoy 
    hoy=new Date() 
    //alert(hoy) 

    //calculo la fecha que recibo 
    //La descompongo en un array 
    var array_fecha = fecha.split("/") 
    //si el array no tiene tres partes, la fecha es incorrecta 
    if (array_fecha.length!=3) 
       return false 

    //compruebo que los ano, mes, dia son correctos 
    var ano 
    ano = parseInt(array_fecha[2]); 
    if (isNaN(ano)) 
       return false 

    var mes 
    mes = parseInt(array_fecha[1]); 
    if (isNaN(mes)) 
       return false 

    var dia 
    dia = parseInt(array_fecha[0]); 
    if (isNaN(dia)) 
       return false 


    //si el año de la fecha que recibo solo tiene 2 cifras hay que cambiarlo a 4 
    if (ano<=99) 
       ano +=1900 

    //resto los años de las dos fechas 
    edad=hoy.getYear()- ano - 1; //-1 porque no se si ha cumplido años ya este año 

    //si resto los meses y me da menor que 0 entonces no ha cumplido años. Si da mayor si ha cumplido 
    if (hoy.getMonth() + 1 - mes < 0) //+ 1 porque los meses empiezan en 0 
       return edad 
    if (hoy.getMonth() + 1 - mes > 0) 
       return edad+1 

    //entonces es que eran iguales. miro los dias 
    //si resto los dias y me da menor que 0 entonces no ha cumplido años. Si da mayor o igual si ha cumplido 
    if (hoy.getUTCDate() - dia >= 0) 
       return edad + 1 

        return edad 
} 

 