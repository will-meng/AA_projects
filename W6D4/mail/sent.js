const MessageStore = require('./message_store');

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
