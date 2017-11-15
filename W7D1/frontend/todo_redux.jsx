import ReactDOM from 'react-dom';
import React from 'react';
import configureStore from './store/store';
import Root from'./components/root';

document.addEventListener("DOMContentLoaded", () => {
    const root = document.getElementById("root");
    let store = configureStore();
    window.store = store;
    ReactDOM.render(<Root store = {store}/>, root);
});
