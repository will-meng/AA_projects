import { RECEIVE_STEPS, RECEIVE_STEP, REMOVE_STEP } from '../actions/step_actions';


const stepsReducer = (state = {1: {id: 1, title: 'step!', todo_id: 2}}, action) => {
  Object.freeze(state);
  let newState = {};
  switch(action.type) {
    case RECEIVE_STEPS:
      action.steps.forEach((step) => {
        newState[step.id] = step;
      });
      return Object.assign({}, state, newState);
    case RECEIVE_STEP:
      // newState[action.step.id] = action.step;
      return Object.assign({}, state, { [action.step.id]: action.step });
    case REMOVE_STEP:
      newState = Object.assign({}, state);
      delete newState[action.step.id];
      return newState;
    default:
      return state;
  }
}

export default stepsReducer;