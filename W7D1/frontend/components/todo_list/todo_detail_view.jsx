import React from 'react'
import StepListContainer from '../step_list/step_list_container'

export default ({ removeTodo, todo, details, stepsById }) => (
  <div style = {{"display":(details ? "none" : "block")}} >
    {todo.body}
    <StepListContainer todo = {todo}/>
    <button onClick={() => removeTodo(todo)}>Remove</button>  
  </div>
);