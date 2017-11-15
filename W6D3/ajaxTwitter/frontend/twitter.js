const FollowToggle = require('./follow_toggle');
const UsersSearch = require('./users_search');
const AddMention = require('./add_mention');

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