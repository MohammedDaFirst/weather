import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();
  int temp;
  int condition;
  String zone;
  String name;

  String weatherIcon;
  String tempMessage;
  @override
  void initState() {
    super.initState();

    updateUI(widget.locationWeather);
  }

  void updateUI(dynamic weahterData) {
    setState(() {
      if (weahterData == null) {
        zone = ' the sky';
        temp = 0;
        tempMessage = 'Unable to find any data clouds';
        weatherIcon = '🌦️';
        return;
      }

      String city = weahterData['timezone'].replaceAll(RegExp('_'), ' ');
      zone = city.substring(city.indexOf('/') + 1, city.length);
      // weahterData[0]['name']
      print(zone);
      double temperature = weahterData['current']['temp'];
      temp = temperature.toInt();
      condition = weahterData['current']['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      tempMessage = weather.getMessage(temp);
    });
  }

  // void updateUISearch(dynamic weahterData) {
  //   setState(() {
  //     if (weahterData == null) {
  //       zone = ' the sky';
  //       temp = 0;
  //       tempMessage = 'Unable to find any data clouds';
  //       weatherIcon = '🌦️';
  //       return;
  //     }
  //     zone = weahterData[0]['name'];
  //     // weahterData[0]['name']
  //     print(zone);
  //     double temperature = 20;
  //     temp = temperature.toInt();
  //     condition = 400;
  //     weatherIcon = weather.getWeatherIcon(condition);
  //     tempMessage = weather.getMessage(temp);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeahter();
                      updateUI(weatherData);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CityScreen()));
                      if (typedName != null) {
                        var weatherData =
                            await weather.getCityWeather(typedName);
                        updateUI(weatherData);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  '$tempMessage in ${zone} ',
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
