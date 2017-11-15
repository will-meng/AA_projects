import StepListItem from './step_list_item'
import { connect } from 'react-redux'
import { receiveStep, removeStep } from '../../actions/step_actions'

const mapStateToProps = (state) => ({
});

const mapDispatchToProps = (dispatch) => ({
  receiveStep: (step) => dispatch(receiveStep(step)),
  removeStep: (step) => dispatch(removeStep(step))
});

export default connect(mapStateToProps, mapDispatchToProps)(StepListItem);