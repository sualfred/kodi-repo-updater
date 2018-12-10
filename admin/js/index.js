function _(el) {
  return document.getElementById(el);
}

function uploadFile() {
  _("loaded_n_total").innerHTML = "";
  _("progressStatus").innerHTML = "";
  var select = _("repodir").value;
  var file = _("file1").files[0];
  _("filename").innerHTML = file.name;
  if (file.type.match('application/x-zip-compresse')) {    
    var formdata = new FormData();
    formdata.append("file1", file);
    formdata.append("repodir", select);
    var ajax = new XMLHttpRequest();
    ajax.upload.addEventListener("progress", progressHandler, false);
    ajax.addEventListener("load", completeHandler, false);
    ajax.addEventListener("error", errorHandler, false);
    ajax.addEventListener("abort", abortHandler, false);
    ajax.open("POST", "upload.php");
    ajax.send(formdata);
  } else {
    errorHandler();
  }
}

function progressHandler(event) {
  var percent = (event.loaded / event.total) * 100;
  _("loaded_n_total").innerHTML = "Uploaded " + event.loaded + " bytes of " + event.total + "  (" + Math.round(percent) + "%)";
}

function completeHandler(event) {
  _("file-dummy").style.backgroundColor = "green";
  _("update-repo").style.display = "block";
  _("progressStatus").innerHTML = event.target.responseText;  
}

function errorHandler(event) {
  _("file-dummy").style.backgroundColor = "red";
  _("loaded_n_total").innerHTML = "Upload Failed";
}

function abortHandler(event) {
  _("file-dummy").style.backgroundColor = "red";
  _("loaded_n_total").innerHTML = "Upload Aborted";
}

function resetHandler() {
}

function generate() {  
  var inputArray = document.querySelectorAll('input');
  inputArray.forEach(function (input){
    input.value = "";
  });
  _("update-repo").style.display = "none";
  document.location.href = 'update.php';
}

