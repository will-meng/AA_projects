const APIUtil = require('./api_util.js');

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