import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';


const String apiKey = 'e72ca729af228beabd5d20e3b7749713';
const String openWeatherMapHost = 'api.openweathermap.org';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    
    try {
      Uri uri = Uri.https(openWeatherMapHost, '/data/2.5/weather', {
        'q': cityName,
        'appid': apiKey,
        'units': 'metric',
      });

      NetworkHelper networkHelper = NetworkHelper(uri.toString().replaceAll('%2C', ','));

      var weatherData = await networkHelper.getData();

      if (weatherData == null || weatherData['cod'] != 200) {
        throw Exception('City not found');
      }

      return weatherData;
    } catch (e) {
      print('Error fetching city weather: $e');
      return null;
    }
  }

  Future<dynamic> getLocationWeather() async {
    try {
      Location location = Location();
      await location.getCurrentLocation();
      print('Latitude: ${location.latitude}, Longitude: ${location.longitude}');

      Uri uri = Uri.https(openWeatherMapHost, '/data/2.5/weather', {
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
        'appid': apiKey,
        'units': 'metric',
      });

      NetworkHelper networkHelper = NetworkHelper(uri.toString());
      var weatherData = await networkHelper.getData();

      if (weatherData == null || weatherData['cod'] != 200) {
        throw Exception('Failed to get weather data');
      }

      return weatherData;
    } catch (e) {
      print('Error fetching location weather: $e');
      return null;
    }
  }
   String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩'; // Dông bão
    } else if (condition < 400) {
      return '🌧'; // Mưa phùn
    } else if (condition < 600) {
      return '☔️'; // Mưa
    } else if (condition < 700) {
      return '❄️'; // Tuyết
    } else if (condition < 800) {
      return '🌫'; // Sương mù
    } else if (condition == 800) {
      return '☀️'; // Trời quang
    } else if (condition <= 804) {
      return '☁️'; // Nhiều mây
    } else {
      return '❓'; // Không xác định
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
