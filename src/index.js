'use strict';

require('./index.html');
require("./styles.scss");

var Elm = require('./Main');

// var elm = Elm.Main.fullscreen({ swap: false });
var app = Elm.Main.fullscreen();

//interop
// elm.ports.logs.subscribe(function(log) {
//   var node = document.createElement('div');
//   node.style.color = 'red';
//   node.innerHTML = 'JS log: ' + log + ', time = ' + Date.now();
//   document.body.appendChild(node);
// });