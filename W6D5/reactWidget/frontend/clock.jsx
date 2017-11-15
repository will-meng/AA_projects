import React from 'react';

class Clock extends React.Component {
  constructor() {
    super();
    this.state = { datetime: new Date };

    this.tick = this.tick.bind(this);
  }

  tick() {
    this.setState({ datetime: new Date });
  }

  renderTime() {
    const date = this.state.datetime;
    return `${date.getHours()}:${date.getMinutes()}:${date.getSeconds()}`;
  }

  renderDate(){
    const date = this.state.datetime;
    return `${this.translateDay(date.getDay())}
      ${this.translateMonth(date.getMonth())}
      ${date.getDate()}
      ${date.getFullYear()}`;
  }

  translateDay(dayNum) {
    const dayWords = {0: "Sun",
      1: "Mon",
      2: "Tues",
      3: "Wed",
      4: "Thur",
      5: "Fri",
      6: "Sat"};

    return dayWords[dayNum];
  }

  translateMonth(monNum){
    const monthWords = {0: "Jan",
      1: "Feb",
      2: "Mar",
      3: "Apr",
      4: "May",
      5: "Jun",
      6: "Jul",
      7: "Aug",
      8: "Sep",
      9: "Oct",
      10: "Nov",
      11: "Dec"};

    return monthWords[monNum];

  }

  componentDidMount() {
    const timer = setInterval(this.tick, 1000);
  }

  render() {
    return (
      <div className="clock">
        <h1>Clock</h1>
        <div className="clock-react">

          <div className="time">
            <h2>Time:</h2>
            <h2>{this.renderTime()}</h2>
          </div>

          <div className="time">
            <h2>Date:</h2>
            <h2>{this.renderDate()}</h2>
          </div>

        </div>
      </div>
    );
  }
}

export default Clock;
