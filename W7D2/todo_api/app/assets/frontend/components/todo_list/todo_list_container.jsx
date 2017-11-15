import TodoList from './todo_list';
import { connect } from 'react-redux';
import { createTodo , receiveTodo, removeTodo, fetchTodos, updateTodo } from '../../actions/todo_action';
import { allTodos } from '../../reducers/selectors';

const mapStateToProps = (state) => ({
  todos: allTodos(state),
  errors: state.errors
});

const mapDispatchToProps = (dispatch) => ({
  createTodo: (todo) => dispatch(createTodo(todo)),
  receiveTodo: (todo) => dispatch(receiveTodo(todo)),
  removeTodo: (todo) => dispatch(removeTodo(todo)),
  fetchTodos: () => dispatch(fetchTodos()),
  updateTodo: (todo) => dispatch(updateTodo(todo))
});

export default connect(mapStateToProps, mapDispatchToProps)(TodoList);