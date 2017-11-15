class DOMNodeCollection {
  constructor(HTMLElements) {
    this.HTMLElements = HTMLElements;
  }

  html (string) {
    if (typeof string === 'undefined') {
      return this.HTMLElements[0].innerHTML;
    }
    else {
      this.HTMLElements.forEach((e) => {
        e.innerHTML = string;
      });
      return this;
    }
  }

  empty() {
    return this.html('');
  }

  append(arg)  {
    let arr;
    if (arg instanceof DOMNodeCollection) {
      arr = arg.HTMLElements;
    } else if (arg instanceof HTMLElement) {
      arr = [HTMLElement];
    } else if (typeof arg === 'string') {
      arr = [arg];
    }

    this.HTMLElements.forEach((parent) => {//lol
      arr.forEach((child) => {
        if (child instanceof HTMLElement) {
          parent.innerHTML += child.outerHTML;
        } else {
          parent.innerHTML += child;
        }
      });
    });
    return this;
  }

  attr(attr, value) {
    if (typeof value === 'undefined') {
      return this.HTMLElements[0].getAttribute(attr);
    } else {
      this.HTMLElements[0].setAttribute(attr, value);
      return this;
    }
  }

  addClass(className) {
    this.HTMLElements.forEach((e)=> {
      e.className += className;
    });
    return this;
  }

  removeClass(className)  {
    this.HTMLElements.forEach((e)=> {
      e.classList.remove(className);
    });
    return this;
  }

  children() {
    let arr = [];
    this.HTMLElements.forEach((e)=> {
      arr = arr.concat(e.children);
    });
    console.log(arr);
    return new DOMNodeCollection(arr);
  }

  parent()  {
    let parentList = [];
    this.HTMLElements.forEach((e) => {
      parentList.push(e.parentNode);
    });
    return new DOMNodeCollection(parentList);
  }

  find(string)  {
    let results = [];
    this.HTMLElements.forEach((e) => {
      results = results.concat(e.querySelectorAll(string));
    });
    return new DOMNodeCollection(results);
  }

  remove() {
    let that = this.HTMLElements.slice();
    this.HTMLElements.forEach((e) => {
      e.innerHTML = '';
      e.remove();
    });
    this.HTMLElements = [];
    return new DOMNodeCollection(that);
  }

  on(action, callback)  {
    this.HTMLElements.forEach((e)=> {
      if (e.eventListenerCallback)  {
        e.eventListenerCallback[action] = callback;
      }

      e.addEventListener(action, callback);
    });
  }
}

module.exports = DOMNodeCollection;
