import { RECEIVE_TODOS, RECEIVE_TODO, REMOVE_TODO } from '../actions/todo_action';

const todosReducer = (state = {}, action) => {
  Object.freeze(state);
  // console.log(action);
  let newState = {};
  switch(action.type) {
    case RECEIVE_TODOS:
      action.todos.forEach((todo) => {
        newState[todo.id] = todo;
      });
      // return Object.assign({}, state, newState);
      return Object.assign({}, state, newState);
    // case RECEIVE_TODO:
    case RECEIVE_TODO:
      // newState[action.todo.id] = action.todo;
      return Object.assign({}, state, { [action.todo.id]: action.todo });
    case REMOVE_TODO:
      newState = Object.assign({}, state);
      delete newState[action.todo.id];
      return newState;
    default:
      return state;
  }
};
  
export default todosReducer;