import React from 'react';

class Tabs extends React.Component {
  constructor(props) {
    super(props);
    this.state = { index: 0 };
    this.arr = props.arr;
  }

  changeIndex(idx, e) {
    const lis = document.querySelectorAll('.tabTitle li');
    lis.forEach(li => li.classList.remove('tab-open'));
    e.currentTarget.classList.add('tab-open');
    this.setState({ index: idx });
  }

  showArticle() {
    const idx = this.state.index;
    return this.arr[idx].content;
  }

  render() {
    return (
      <div className="tabWidget">
        <ul className ="tabTitle">
          {
            this.arr.map((tab, idx) => (
              <li key={idx} onClick={ (e) => (this.changeIndex(idx, e)) }>
                { tab.title }</li>
            ))
          }
        </ul>

        <article>{ this.showArticle() }</article>
      </div>
    );
  }
}

export default Tabs;
