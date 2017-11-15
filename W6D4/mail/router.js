class Router {
  constructor(node, routes) {
    this.node = node;
    this.routes = routes;
  }

  start() {
    this.render();
    window.addEventListener('hashchange', (e) => {
      this.render();
    });
  }

  render()  {
    this.node.innerHTML = '';

    let component = this.activeRoute();
    if (typeof component !== 'undefined') {
      this.node.appendChild(component.render());
    }
  }

  activeRoute ()  {
    return this.routes[window.location.hash.slice(1)];
  }
}

module.exports = Router;
