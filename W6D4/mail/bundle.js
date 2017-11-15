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
/******/ 	return __webpack_require__(__webpack_require__.s = 1);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports) {

let messages = {
  sent: [
    {to: "friend@mail.com", subject: "Check this out", body: "It's so cool"},
    {to: "person@mail.com", subject: "zzz", body: "so booring"}
  ],
  inbox: [
    {from: "grandma@mail.com", subject: "Fwd: Fwd: Fwd: Check this out", body: "Stay at home mom discovers cure for leg cramps. Doctors hate her"},
    {from: "person@mail.com", subject: "Questionnaire", body: "Take this free quiz win $1000 dollars"} ] };

class Message {
  constructor(from, to, subject, body) {
    this.from = from;
    this.to = to;
    this.subject = subject;
    this.body = body;
  }
}

let messageDraft = new Message();

let MessageStore =  {
  getInboxMessages: () => messages.inbox,
  getSentMessages: () => messages.sent,
  getMessageDraft: () => messageDraft,
  updateDraftField: function(field, value) { messageDraft[field] = value; },
  sendDraft: function() {
    messages.sent.push(messageDraft);
    messageDraft = new Message();
  }
};

module.exports = MessageStore;


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const Router = __webpack_require__(2);
const Inbox = __webpack_require__(3);
const Sent = __webpack_require__(4);
const Compose = __webpack_require__(5);

const routes = {
  inbox: Inbox,
  sent: Sent,
  compose: Compose
};

document.addEventListener("DOMContentLoaded", function(event) {

  document.querySelectorAll('.sidebar-nav li').forEach((li)=>  {
    li.addEventListener('click', function(e)  {
      e.preventDefault();
      window.location.hash = `${li.innerText.toLowerCase()}`;
    });
  });

  const activeRouter = new Router(document.querySelector('.content'), routes);
  activeRouter.start();
});


/***/ }),
/* 2 */
/***/ (function(module, exports) {

class Router {
  constructor(node, routes) {
    this.node = node;
    this.routes = routes;
  }

  start() {
    this.render();
    window.addEventListener('hashchange', (e) => {
      this.render();
    });
  }

  render()  {
    this.node.innerHTML = '';

    let component = this.activeRoute();
    if (typeof component !== 'undefined') {
      this.node.appendChild(component.render());
    }
  }

  activeRoute ()  {
    return this.routes[window.location.hash.slice(1)];
  }
}

module.exports = Router;


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const MessageStore = __webpack_require__(0);

const Inbox = {
  render: () => {
    const ul = document.createElement('ul');
    const messages = MessageStore.getInboxMessages();
    messages.forEach((message) => {
      ul.appendChild(Inbox.renderMessage(message));
    });
    ul.className = 'messages';
    return ul;
  },

  renderMessage: (message) =>  {
    const li = document.createElement('li');
    li.className = 'message';
    li.innerHTML = `
      <span class='from'>${message.from}</span>
      <span class='subject'>${message.subject}</span>
      <span class='body'>${message.body}</span>
      `;
    return li;
  }
};

module.exports = Inbox;


/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

const MessageStore = __webpack_require__(0);

const Sent = {
  render: () => {
    const ul = document.createElement('ul');
    const messages = MessageStore.getSentMessages();
    messages.forEach((message)=>  {
      ul.appendChild(Sent.renderMessage(message));
    });
    ul.className = 'messages';
    return ul;
  },
  renderMessage: (message) =>  {
    const li = document.createElement('li');
    li.className = 'message';
    li.innerHTML = `
      <span class='to'>${message.to}</span>
      <span class='subject'>${message.subject}</span>
      <span class='body'>${message.body}</span>
      `;
    return li;
  }
};

module.exports = Sent;


/***/ }),
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

const MessageStore = __webpack_require__(0);

const Compose = {
  render() {
    const div = document.createElement('div');
    div.className = 'new-message';
    div.innerHTML = this.renderForm();
    div.addEventListener('change', e => {
      const name = e.target.name;
      const value = e.target.value;
      MessageStore.updateDraftField(name, value);
    });
    div.addEventListener('submit', e => {
      e.preventDefault();
      MessageStore.sendDraft();
      window.location.hash = 'inbox';
    });
    return div;
  },

  renderForm() {
    const draft = MessageStore.getMessageDraft();
    const formString = `
     <p class='new-message-header'>New Message</p>
     <form class='compose-form'>
      <input placeholder='Recipient' name='to' type='text'
        value=${draft.to || ''}>
      <input placeholder='Subject' name='subject' type='text'
        value=${draft.subject || ''}>
      <textarea name="body" rows="20" >${draft.body || ''}</textarea>
      <button type="submit" class='btn btn-primary submit-message'>Send</button>
     </form>
     `;
    return formString;
  }
};

module.exports = Compose;


/***/ })
/******/ ]);