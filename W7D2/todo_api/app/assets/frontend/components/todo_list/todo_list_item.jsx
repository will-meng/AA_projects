import React from 'react';
import TodoDetailViewContainer from './todo_detail_container';


class TodoListItem extends React.Component
{
  constructor(props)
  {
    super(props);
    this.state = {details: false};
    this.removeTodo = props.removeTodo;
    this.receiveTodo = props.receiveTodo;
    this.todo = props.todo;
    this.updateTodo = this.updateTodo.bind(this);
  }

  updateTodo(todo) {
    todo.done = !todo.done;
    this.props.updateTodo({id: todo.id, todo});
  }
  
  toggleDetails() {
    this.setState({ details: !this.state.details });
  }

  render()
  {
    return (
      <li>
        <span onClick = {() => this.toggleDetails()}>{this.todo.title}</span>
        <button onClick={() => this.updateTodo(this.todo)}>
        {this.todo.done ? 'Undo' : 'Done'}
        </button>
        <TodoDetailViewContainer todo = {this.todo} details = {this.state.details}/>
        <hr/>
      </li>
    );
  }
}

export default TodoListItem;