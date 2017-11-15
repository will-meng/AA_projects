import TodoDetailView from './todo_detail_view'
import { connect } from 'react-redux'
import { removeTodo } from '../../actions/todo_action'


const mapStateToProps = (state) => ({

});
const mapDispatchToProps = (dispatch) => ({
  removeTodo: (todo) => dispatch(removeTodo(todo))
});

export default connect(mapStateToProps, mapDispatchToProps)(TodoDetailView);