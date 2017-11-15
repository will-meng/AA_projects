import StepList from './step_list'
import { connect } from 'react-redux'
import { receiveSteps , receiveStep, removeStep } from '../../actions/step_actions'
import { stepsByToDoId } from '../../reducers/selectors'

const mapStateToProps = (state) => ({
  stepsById: (stepID) => stepsByToDoId(state, stepID)
});

const mapDispatchToProps = (dispatch) => ({
  receiveStep: (step) => dispatch(receiveStep(step)),
  receiveSteps: (steps) => dispatch(receiveSteps(steps)),
  removeStep: (step) => dispatch(removeStep(step))
});

export default connect(mapStateToProps, mapDispatchToProps)(StepList);