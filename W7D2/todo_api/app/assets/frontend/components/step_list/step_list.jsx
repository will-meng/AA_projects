import React from 'react';
import StepListItemContainer from './step_list_item_container';
import StepListForm from './step_form';


export default ({ stepsById, todo, removeStep, receiveStep }) => (
  <div>
    <ul>
      {stepsById(todo.id).map(step => 
        <StepListItemContainer step = {step} key = {step.id}/>)}
    </ul>
    <StepListForm todo = {todo} receiveStep = {receiveStep} />
  </div>
);