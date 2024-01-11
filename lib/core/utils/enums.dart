enum FrequentAirtime {
  hundred(100, '100'),
  twoHundred(200, '200'),
  fiveHundred(500, '500'),
  thousand(1000, '1000'),
  twoThousand(2000, '2000'),
  threeThousand(3000, '3000');

  final int value;
  final String name;

  const FrequentAirtime(
    this.value,
    this.name,
  );
}
