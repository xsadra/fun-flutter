import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() => runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}

enum City {
  tokyo,
  osaka,
  kyoto,
  nagoya,
  fukuoka,
  sapporo,
  sendai,
  yokohama,
  kobe,
  nagasaki,
  none,
}

typedef WeatherEmoji = String;

Future<WeatherEmoji> fetchWeather(City city) async {
  await Future.delayed(const Duration(seconds: 1));
  return '${{
    City.fukuoka: '🌞',
    City.kobe: '☀',
    City.kyoto: '🌩',
    City.nagasaki: '⛈',
    City.nagoya: '🌤',
    City.osaka: '🌪',
    City.sapporo: '🌧',
    City.sendai: '🌡',
    City.tokyo: '⚠️️🌀',
    City.yokohama: '🌄☁️️🌞',
  }[city]!} in ${city.toString().split('.').last}';
}

final currentCityProvider = StateProvider<City?>((ref) => null);

const unknownWeatherEmoji = '🤷‍♂️';

final weatherEmojiProvider = FutureProvider.autoDispose<WeatherEmoji>(
  (ref) {
    final city = ref.watch(currentCityProvider);
    if (city == null) {
      return unknownWeatherEmoji;
    }
    return fetchWeather(city);
  },
);

class HomePage extends ConsumerWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCity = ref.watch(currentCityProvider);
    final currentWeather = ref.watch(weatherEmojiProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
      ),
      body: Column(
        children: [
          currentWeather.when(
            data: (weather) => Text(
              weather,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            loading: () => const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
            error: (error, stack) => const Text('Error: no data available!'),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: City.values.length,
              itemBuilder: (context, index) {
                final city = City.values[index];
                final isSelected = currentCity == city;
                return ListTile(
                  title: Text(city.toString().split('.').last),
                  trailing: isSelected ? const Icon(Icons.check) : null,
                  onTap: () {
                    ref.read(currentCityProvider.notifier).state = city;
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
