import React from 'react';

export default ({ step, removeStep }) => (
  <li>{step.title} 
    {step.body}
    <button onClick={() => removeStep(step)}>Remove Step</button>  
    
  </li>
);