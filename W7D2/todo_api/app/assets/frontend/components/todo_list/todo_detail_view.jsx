import React from 'react';
import StepListContainer from '../step_list/step_list_container';

export default ({ deleteTodo, todo, details, stepsById }) => (
  <div style = {{"display":(details ? "block" : "none")}} >
    {todo.body}
    <StepListContainer todo = {todo}/>
    <button onClick={() => deleteTodo(todo)}>Remove</button>  
  </div>
);