(function(){
  if (!('serviceWorker' in navigator)) return;
  var url = new URL('sw.js', document.currentScript && document.currentScript.src
    ? new URL('.', document.currentScript.src)
    : new URL('.', location.href));
  // app-pwa.js lives at the app root, so sw.js is beside it
  var sw = new URL('sw.js', new URL('.', (document.currentScript && document.currentScript.src) || location.href));
  window.addEventListener('load', function(){
    navigator.serviceWorker.register(sw.href).catch(function(){});
  });
})();
