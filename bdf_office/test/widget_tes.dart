mixin Fluttering {
  void flutter() {
    print('fluttering');
  }
}

abstract class Bird with Fluttering {
  void flap() {
    print('flap flap');
  }
}

class Owl extends Bird {
  void fly() {
    flap();
    flutter();
    print('Owl is Flying');
  }
}

main() {
  Owl owl = Owl();
  owl.fly();
}
