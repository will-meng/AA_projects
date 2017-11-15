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