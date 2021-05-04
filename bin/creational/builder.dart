class Car {
  final String? model;
  final int? hp;
  final int? countSeats;
  final int? maxSpeed;
  final bool? autoTransmission;

  Car._builder(CarBuilder builder)
      : model = builder.model,
        hp = builder.hp,
        countSeats = builder.countSeats,
        maxSpeed = builder.maxSpeed,
        autoTransmission = builder.autoTransmission;

  @override
  String toString() {
    return 'Car{model: $model, hp: $hp, countSeats: $countSeats, maxSpeed: $maxSpeed, autoTransmission: $autoTransmission}';
  }
}

class CarBuilder {
  String? model;
  int? hp;
  int? countSeats;
  int? maxSpeed;
  bool? autoTransmission;

  Car build() => Car._builder(this);
}

void main() {
  final car = (CarBuilder()
        ..autoTransmission = true
        ..maxSpeed = 265
        ..countSeats = 2
        ..hp = 320
        ..model = 'Super Mega Ulra X')
      .build();

  print(car.toString());
}
