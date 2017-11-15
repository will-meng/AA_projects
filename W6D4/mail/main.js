const Router = require('./router');
const Inbox = require('./Inbox');
const Sent = require('./sent');
const Compose = require('./compose');

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
