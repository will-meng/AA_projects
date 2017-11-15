import React from 'react'
import uniqueId from '../../util/util'

class StepForm extends React.Component {
  constructor(props)
  {
    super(props);
    this.receiveStep = props.receiveStep;
    this.receiveSteps = props.receiveSteps;
    this.todo_id = props.todo.id
    this.state = {title: "", body: ""};
    this.handleInput = this.handleInput.bind(this);
  }
  handleInput(evt)
  {
    this.setState({[evt.target.name]: evt.target.value})
  }
  handleSubmit()
  {
    return (evt) => {
      evt.preventDefault();
      this.receiveStep({id: uniqueId(), title: this.state.title, body: this.state.body, done: false, todo_id: this.todo_id});
      this.setState({body: "", title: ""});
    }
  }
  render()
  {
    return (
      <form action="" onSubmit = {this.handleSubmit()}>
        <label>
          Title
          <input 
            name = "title" type="text"
            value = {this.state.title}
            onChange = {this.handleInput}/>
        </label>
        <label>
          Body
          <input 
            name = "body" type="text" 
            value = {this.state.body}
            onChange = {this.handleInput}/>
        </label>

        <input type="submit"/>
      </form>
    )
  }
}

export default StepForm;
{/* <button onClick = {
  (evt) => {
    evt.preventDefault();
    this.receiveStep({id: uniqueId(), title: this.state.title, body: this.state.body});
    this.setState({body: "", title: ""});
  }
}> 
  Submit 
</button> */}