const allTodos = (state) =>{
  const ids = Object.keys(state.todos);
  return ids.map(id => state.todos[id]);
}

const stepsByToDoId = (state, todoId) =>
{
  let keys = Object.keys(state.steps);
  let arr = [];
  keys.forEach((key) => {
    if(state.steps[key].todo_id === todoId)
    {
      arr.push(state.steps[key])
    }
  });
  return arr;
}

export { allTodos, stepsByToDoId };