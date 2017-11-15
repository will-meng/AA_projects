import React from 'react';
import TodoListItem from './todo_list_item';
import TodoListForm from './todo_form';

export default ({ todos, receiveTodo, receiveTodos, removeTodo }) => (
  <div>
    <ul>
      {todos.map((todo) => (
        <TodoListItem todo = {todo} key = {todo.id} removeTodo = {removeTodo} receiveTodo = {receiveTodo} />
      ))}
    </ul>
    <TodoListForm receiveTodo = {receiveTodo} receiveTodos = {receiveTodos} />
  </div>
);