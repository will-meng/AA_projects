import React from 'react';
import uniqueId from '../../util/util';

class TodoForm extends React.Component {
  constructor(props)
  {
    super(props);
    this.createTodo = props.createTodo;
    this.state = {title: "", body: ""};
    this.handleInput = this.handleInput.bind(this);
  }
  handleInput(evt)
  {
    this.setState({[evt.target.name]: evt.target.value});
  }
  handleSubmit()
  {
    return (evt) => {
      evt.preventDefault();
      this.createTodo({todo: {id: uniqueId(), title: this.state.title, body: this.state.body, done: false}});
      console.log(this.props);
      if(!this.props.errors.length === 0)
      {
        this.setState({body: "", title: ""});
      }
    };
  }
  render()
  {
    return (
      <form action="" onSubmit = {this.handleSubmit()}>
        <ul> {this.props.errors.map((err) => <li key={err}>{err}</li>)} </ul>
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
    );
  }
}

export default TodoForm;
{/* <button onClick = {
  (evt) => {
    evt.preventDefault();
    this.receiveTodo({id: uniqueId(), title: this.state.title, body: this.state.body});
    this.setState({body: "", title: ""});
  }
}> 
  Submit 
</button> */}