import React from 'react';

class Weather extends React.Component {
  constructor(){
    super();
    this.state = {city: "", temperature: ""};
  }

  getWeather (lat, long) {
    const req = $.ajax({
      type: 'GET',
      url: `http://api.openweathermap.org/data/2.5/weather?lat=${lat}&lon=${long}&appid=a08cce255a31815e971b86da767ca06d`
    });

    return req.then( (res) => {
      this.setState({
        city: res.name,
        temperature: this.convertKtoF(res.main.temp)
      });
    });
  }

  convertKtoF(tempK) {
    const rawTemp = tempK * (9/5) - 459.67;
    return `${Math.round(rawTemp * 10)/ 10} degrees`;
  }

  componentDidMount() {
    navigator.geolocation.getCurrentPosition((pos) => {
      let [lat, long] = [pos.coords.latitude, pos.coords.longitude];
      const data = this.getWeather(lat, long);
    });
  }


  render() {
    if (this.state.city === "" ) {
      return (
        <div>
          <p>loading weather ... </p>
        </div>
      );
    } else {
      return (
        <div>
          <h1>{this.state.city}</h1>
          <h1>{this.state.temperature}</h1>
        </div>
      );
    }
  }
}

export default Weather;
