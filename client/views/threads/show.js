function scrollFix() {   
  var objDiv = document.getElementById("messages");
  objDiv.scrollTop = objDiv.scrollHeight;
  setTimeout("scrollFix();", 500);
}
window.onload = function() { scrollFix(); }


Template.showThread.helpers({
  show: scrollFix
});