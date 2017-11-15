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

const FollowToggle = __webpack_require__(1);
const UsersSearch = __webpack_require__(3);
const AddMention = __webpack_require__(4);

$(() => {
  $('button.follow-toggle').each((idx, el) => {
    new FollowToggle(el);
  });
  
  $('nav.users-search').each((idx, el) => {
    new UsersSearch(el);
  });
  
  $('button.add-mention').each((idx, el) => {
    new AddMention(el);
  });

});

/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);

class FollowToggle {
  constructor(el, options) {
    this.$button = $(el);
    this.userId = this.$button.data('user-id') || options.userId;
    this.followState = this.$button.data('initial-follow-state') || options.followState;

    this.render();
    this.handleClick();
  }
  
  render() {
    switch (this.followState) {
      case ('unfollowed'):
        this.$button.text('Follow!');
        this.$button.prop('disabled', false);
        break;
      case ('followed'):
        this.$button.text('Unfollow!');
        this.$button.prop('disabled', false);
        break;
      case ('following'):
        this.$button.text('Following...');
        this.$button.prop('disabled', true);
        break;
      case ('unfollowing'):
        this.$button.text('Unfollowing...');
        this.$button.prop('disabled', true);      
    }
  }
  
  handleClick() {
    this.$button.on('click', event => {
      event.preventDefault();
      
      if (this.followState === 'unfollowed') {
        this.followState = 'following';
        this.render();
        
        APIUtil.followUser(this.userId).then(() => {
          this.followState = 'followed';
          this.render();
        });
      } else if (this.followState === 'followed') {
        this.followState = 'unfollowing';
        this.render();
        
        APIUtil.unfollowUser(this.userId).then(() => {
          this.followState = 'unfollowed';
          this.render();
        });
      }
    });
  }
}

module.exports = FollowToggle;

/***/ }),
/* 2 */
/***/ (function(module, exports) {

const APIUtil = {
  followUser: id => {
    return $.ajax({
      url: `/users/${id}/follow`,
      method: 'POST',
      dataType: 'json'
    });
  },

  unfollowUser: id => {
    return $.ajax({
      url: `/users/${id}/follow`,
      method: 'DELETE',
      dataType: 'json'
    });
  },
  
  searchUsers: (query) => {
    return $.ajax({
      url: `/users/search`,
      method: 'GET',
      data: { query },
      dataType: 'json'
    });
  }
};

module.exports = APIUtil;

/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);
const FollowToggle = __webpack_require__(1);

class UsersSearch {
  constructor(el) {
    this.$el = $(el);
    this.$input = this.$el.find('input.users-search-input');
    this.$ul = this.$el.find('ul.users');
    this.handleInput();
  }
  
  handleInput() {
    this.$input.on('keyup', (event) => {
      const val = this.$input.val();
      APIUtil.searchUsers(val).then((res) => this.renderResults(res));
    });
  }
  
  renderResults(res_users) {
    console.log(res_users);

    this.$ul.empty();
    
    res_users.forEach(user => {
      const $a = $('<a></a>');
      $a.attr('href',`/users/${user.id}`);
      $a.text(`${user.username}`);
      
      const $button = $('<button></button>');
      $button.addClass('follow-toggle');
      const followState = user.followed ? 'followed' : 'unfollowed';
      new FollowToggle($button, {userId: user.id, followState: followState});
      // $button.data('user-id',`${user.id}`);
      // $button.data('initial-follow-state',`${followState}`);
      
      const $li = $(`<li></li>`);
      $li.append($a);
      $li.append($button);
      
      this.$ul.append($li);
    })
  }
}

module.exports = UsersSearch;

/***/ }),
/* 4 */
/***/ (function(module, exports) {

class AddMention {
  constructor(el) {
    this.$button = $(el);

    this.handleClick();
  }
  
  handleClick() {
    this.$button.on('click', (event) => {
      event.preventDefault();
      
      this._newUserSelect().insertBefore(this.$button);
    });
  }
  
  _newUserSelect() {
    const $sel = $('<select></select>');
    $sel.attr('name',"tweet[mentioned_user_ids][]");
    
    window.users.forEach(user => {
      const $op = $('<option></option>');
      $op.val(`${user.id}`);
      $op.text(`${user.username}`);
      $sel.append($op);
    });
    
    return $sel;
  }
}

module.exports = AddMention;

/***/ })
/******/ ]);
//# sourceMappingURL=bundle.js.map