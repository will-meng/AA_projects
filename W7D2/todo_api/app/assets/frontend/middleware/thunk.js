const thunkMiddleware = ({ dispatch }) => (next) => (action) => {
  if (typeof action === 'function')
  { 
    return action(dispatch);
  }
  return next(action);
};

export default thunkMiddleware;