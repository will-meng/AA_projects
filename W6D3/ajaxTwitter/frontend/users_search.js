const APIUtil = require('./api_util');
const FollowToggle = require('./follow_toggle');

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