import TodoDetailView from './todo_detail_view';
import { connect } from 'react-redux';
import { deleteTodo } from '../../actions/todo_action';


const mapStateToProps = (state) => ({

});
const mapDispatchToProps = (dispatch) => ({
  deleteTodo: (todo) => dispatch(deleteTodo(todo))
});

export default connect(mapStateToProps, mapDispatchToProps)(TodoDetailView);