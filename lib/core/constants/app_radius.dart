/// Centralized corner-radius scale. Pair with named roles
/// (`button`, `card`, ...) rather than the raw scale where possible, so
/// changing a component's roundness later is a one-line edit.
class AppRadius {
  const AppRadius._();

  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 999;

  static const double input = md;
  static const double button = md;
  static const double card = lg;
  static const double chip = full;
  static const double dialog = lg;
  static const double sheet = xl;
}
