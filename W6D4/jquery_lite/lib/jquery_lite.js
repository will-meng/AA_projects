/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const DOMNodeCollection = __webpack_require__(1);

window.$l = function(selector) {
  if (selector instanceof HTMLElement)  {
     return new DOMNodeCollection(Array.from((selector)));
  }
  else if (typeof selector === 'string'){
    return new DOMNodeCollection(Array.from(document.querySelectorAll(selector)));
  }
  // return Array.prototype.slice.call(document.querySelectorAll(selector));
};


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class DOMNodeCollection {
  constructor(HTMLElements) {
    this.HTMLElements = HTMLElements;
  }

  html (string) {
    if (typeof string === 'undefined') {
      return this.HTMLElements[0].innerHTML;
    }
    else {
      this.HTMLElements.forEach((e) => {
        e.innerHTML = string;
      });
      return this;
    }
  }

  empty() {
    return this.html('');
  }

  append(arg)  {
    let arr;
    if (arg instanceof DOMNodeCollection) {
      arr = arg.HTMLElements;
    } else if (arg instanceof HTMLElement) {
      arr = [HTMLElement];
    } else if (typeof arg === 'string') {
      arr = [arg];
    }

    this.HTMLElements.forEach((parent) => {//lol
      arr.forEach((child) => {
        if (child instanceof HTMLElement) {
          parent.innerHTML += child.outerHTML;
        } else {
          parent.innerHTML += child;
        }
      });
    });
    return this;
  }

  attr(attr, value) {
    if (typeof value === 'undefined') {
      return this.HTMLElements[0].getAttribute(attr);
    } else {
      this.HTMLElements[0].setAttribute(attr, value);
      return this;
    }
  }

  addClass(className) {
    this.HTMLElements.forEach((e)=> {
      e.className += className;
    });
    return this;
  }

  removeClass(className)  {
    this.HTMLElements.forEach((e)=> {
      e.classList.remove(className);
    });
    return this;
  }

  children() {
    let arr = [];
    this.HTMLElements.forEach((e)=> {
      arr = arr.concat(e.children);
    });
    console.log(arr);
    return new DOMNodeCollection(arr);
  }

  parent()  {
    let parentList = [];
    this.HTMLElements.forEach((e) => {
      parentList.push(e.parentNode);
    });
    return new DOMNodeCollection(parentList);
  }

  find(string)  {
    let results = [];
    this.HTMLElements.forEach((e) => {
      results = results.concat(e.querySelectorAll(string));
    });
    return new DOMNodeCollection(results);
  }

  remove() {
    let that = this.HTMLElements.slice();
    this.HTMLElements.forEach((e) => {
      e.innerHTML = '';
      e.remove();
    });
    this.HTMLElements = [];
    return new DOMNodeCollection(that);
  }

  on(action, callback)  {
    this.HTMLElements.forEach((e)=> {
      if (e.eventListenerCallback)  {
        e.eventListenerCallback[action] = callback;
      }

      e.addEventListener(action, callback);
    });
  }
}

module.exports = DOMNodeCollection;


/***/ })
/******/ ]);