
var isUpdated = false;
function OnEndCallback(s, e) {
  
    if (isUpdated) {
        alert(s.cpAccion);
        isUpdated = false;
    } 

}
