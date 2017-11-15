import ReactDOM from 'react-dom';
import React from 'react';
import configureStore from './store/store';
import Root from'./components/root';
import { updateTodo } from './util/todo_api_util';

document.addEventListener("DOMContentLoaded", () => {
    const root = document.getElementById("root");
    let store = configureStore();
    window.store = store;
    window.updateTodo = updateTodo;
    ReactDOM.render(<Root store = {store}/>, root);
});
