const DOMNodeCollection = require('./dom_node_collection');

window.$l = function(selector) {
  if (selector instanceof HTMLElement)  {
     return new DOMNodeCollection(Array.from((selector)));
  }
  else if (typeof selector === 'string'){
    return new DOMNodeCollection(Array.from(document.querySelectorAll(selector)));
  }
  // return Array.prototype.slice.call(document.querySelectorAll(selector));
};
