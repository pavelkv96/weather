enum Temperature {
  celsius(type: 'C'),
  fahrenheit(type: 'F');

  final String type;

  const Temperature({required this.type});
}
