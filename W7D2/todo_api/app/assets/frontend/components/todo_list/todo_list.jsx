import React from 'react';
import TodoListItem from './todo_list_item';
import TodoListForm from './todo_form';

export default class TodoList extends React.Component 
{
  constructor(props)
  {
    super(props);
  }

  componentDidMount()
  {
    this.props.fetchTodos();
  }

  render()
  {
    const {todos, removeTodo, receiveTodo,
          createTodo, receiveTodos, updateTodo, errors} = this.props;
    return (
      <div>
        <ul>
          {todos.map((todo) => (
            <TodoListItem 
              todo = {todo} 
              key = {todo.id} 
              removeTodo = {removeTodo} 
              receiveTodo = {receiveTodo} 
              updateTodo = {updateTodo}/>
          ))}
        </ul>
        <TodoListForm createTodo = {createTodo} errors = {errors} />
      </div>
    );
  }
}