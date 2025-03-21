import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final dynamic locationWeather;

  LocationScreen({this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temperature = 0;
  String weatherIcon = '❌';
  String cityName = 'Unknown';
  String weatherMessage = 'No data available';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      isLoading = true;
    });

    if (weatherData == null || weatherData['main'] == null || weatherData['weather'] == null) {
      print('Error: Invalid weather data received');
      setState(() {
        temperature = 0;
        weatherIcon = '❌';
        weatherMessage = 'Unable to get weather data. Check your internet connection.';
        cityName = 'Unknown';
        isLoading = false;
      });
      return;
    }

    double temp = weatherData['main']['temp'] ?? 0.0;
    int condition = weatherData['weather'][0]['id'] ?? 800;

    setState(() {
      temperature = temp.toInt();
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'] ?? 'Unknown';
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.8), 
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: isLoading
              ? Center(child: CircularProgressIndicator())  // Hiển thị loading khi đang tải dữ liệu
              : Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          onPressed: () async {
                            var weatherData = await weather.getLocationWeather();
                            updateUI(weatherData);
                          },
                          icon: Icon(Icons.near_me, size: 50.0),
                        ),
                        IconButton(
                          onPressed: () async {
                            var typedName = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CityScreen(),
                              ),
                            );
                            if (typedName != null) {
                              var weatherData = await weather.getCityWeather(typedName);
                              updateUI(weatherData);
                            }
                          },
                          icon: Icon(Icons.location_city, size: 50.0),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '$temperature°',
                            style: kTempTextStyle,
                          ),
                          Text(
                            weatherIcon,
                            style: kConditionTextStyle,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        '$weatherMessage in $cityName',
                        textAlign: TextAlign.right,
                        style: kMessageTextStyle,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
