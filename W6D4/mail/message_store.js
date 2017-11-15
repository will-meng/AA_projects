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
