const MessageStore = require('./message_store');

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
