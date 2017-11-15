import React from 'react';
import Clock from './clock';
import Tabs from './tabs';
import Weather from './weather';

const tabInfo = [{title: 'one', content: 'I am the one'},
                 {title: 'two', content: 'I am the 2nd'},
                 {title: 'three', content: 'I am the 3rd'}];

const App = () => (
    <div className="app">
      <Clock />
      <Tabs arr={tabInfo} />
      <Weather />
    </div>
  );

export default App;
