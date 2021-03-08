
class Configs {

  num priceHour;
  num margin;

  Map<String, dynamic> toMap() {
    return {
      "pricehour": priceHour,
      "margin": margin,
    };
  }

}