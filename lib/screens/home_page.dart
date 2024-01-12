import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/controller/homeprovider.dart';
import 'package:weather/controller/location_provider.dart';
import 'package:weather/controller/weatherprovide.dart';

TextEditingController cityController = TextEditingController();

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    checkInternetAndFetchData(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(20),
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/bg.jpg'))),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.green),
                      const SizedBox(
                        width: 10,
                      ),
                      Consumer<LocatorProvider>(
                        builder: (context, value, child) => Column(
                          children: [
                            Text(
                              value.currentLocationName?.locality ??
                                  "unknown location",
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              value.currentLocationName?.subLocality ?? " ",
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        labelText: "Search ...",
                        labelStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        searchCity(context);
                      },
                      icon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ))
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Consumer2<WeatherProvider, LocatorProvider>(
                builder: (context, weathervalue, locatorvalue, child) {
                  if (locatorvalue.currentLocationName == null ||
                      weathervalue.weather == null) {
                    // Placeholder widget or empty container
                    return Container();
                  }
                  return Column(
                    children: [
                      Text(
                        "${weathervalue.weather!.temp!.round().toString()}\u00b0c",
                        style: const TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.w200,
                            color: Colors.white),
                      ),
                      Text(
                        weathervalue.weather!.clouds?.toString() ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        weathervalue.weather!.name?.toString().toUpperCase() ??
                            'N/A',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 150,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 330,
                height: 150,
                child: Consumer2<WeatherProvider, LocatorProvider>(
                  builder: (context, weathervalue, locatorvalue, child) {
                    if (locatorvalue.currentLocationName == null) {
                      // Display a message to select a location
                      return const Center(
                        child: Text(
                          "Select a location...",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.red,
                          ),
                        ),
                      );
                    } else {
                      final weather = weathervalue.weather;

                      if (weather == null) {
                        return Container();
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/temp_1.png',
                                width: 60,
                              ),
                              Column(
                                children: [
                                  const Text(
                                    "Temp Max",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                  Text(
                                    "${weather.temp_max?.round().toString() ?? "N/A"}\u00b0c",
                                    style: const TextStyle(
                                        fontSize: 25, color: Colors.red),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Image.asset(
                                'assets/images/temp 2.png',
                                width: 40,
                              ),
                              Column(
                                children: [
                                  const Text(
                                    "Temp Min",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                  Text(
                                    "${weather.temp_min?.round().toString() ?? 'N/A'}\u00b0c",
                                    style: const TextStyle(
                                        fontSize: 25, color: Colors.blue),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.white,
                            height: 10,
                            thickness: 1.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/sun.png',
                                width: 40,
                              ),
                              Column(
                                children: [
                                  const Text(
                                    "Sunrise",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    DateFormat("hh:mm a").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                        weather.sunrise! * 1000,
                                      ),
                                    ),
                                    style:
                                        const TextStyle(color: Colors.white54),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Image.asset(
                                'assets/images/half moon.png',
                                width: 40,
                                color: Colors.white54,
                              ),
                              Column(
                                children: [
                                  const Text("Sunset",
                                      style: TextStyle(color: Colors.white)),
                                  Text(
                                    DateFormat("hh:mm a").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                        weather.sunset! * 1000,
                                      ),
                                    ),
                                    style:
                                        const TextStyle(color: Colors.white54),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> checkInternetAndFetchData(context) async {
    final hasInternet =
        await Provider.of<Homeprovider>(context).checkInternet();
    if (!hasInternet) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('No Internet Connection'),
            content: const Text(
                'Please check your internet connection.  restart the app after the network is stabled'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      final locationProvider =
          Provider.of<LocatorProvider>(context, listen: false);

      locationProvider.determinePosition().then((_) {
        if (locationProvider.currentLocationName != null) {
          var city = locationProvider.currentLocationName?.locality;
          if (city != null) {
            Provider.of<WeatherProvider>(context, listen: false)
                .fetchWeatherDataByCity(city, context);
          }
        }
      });
    }
  }

  searchCity(context) async {
    final prov = Provider.of<WeatherProvider>(context, listen: false);
    await prov.fetchWeatherDataByCity(cityController.text.trim(), context);
    cityController.clear();

    if (prov.weather == null) {
      final snackBar = SnackBar(
          backgroundColor: Colors.red, content: Text("City not found"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
