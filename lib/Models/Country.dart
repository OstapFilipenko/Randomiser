class Country {
  final String name;
  final String abbreviation;
  final String capital;
  final String region;
  final String subregion;
  final int population;
  final double area;
  final String pathFlag;

  Country(this.name, this.abbreviation, this.capital, this.region,
      this.subregion, this.population, this.area, this.pathFlag);

  Country.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        abbreviation = json['alpha2Code'],
        capital = json['capital'],
        region = json['region'],
        subregion = json['subregion'],
        population = json['population'],
        area = json['area'],
        pathFlag = json['flag'];
}
