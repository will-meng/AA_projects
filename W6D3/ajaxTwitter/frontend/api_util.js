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