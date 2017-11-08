const Util = {
  inherits: function(child, parent) {
    let Surrogate = function(){};
    Surrogate.prototype = parent.prototype;
    child.prototype = new Surrogate();
    child.prototype.constructor = child;

  },
  randomVec: function(length) {
    const deg = 2 * Math.PI * Math.random();
    return Util.scale([Math.sin(deg), Math.cos(deg)], length);
  },
  // Scale the length of a vector by the given amount.
  scale: function(vec, m) {
    return [vec[0] * m, vec[1] * m];
  }

};


module.exports = Util;
