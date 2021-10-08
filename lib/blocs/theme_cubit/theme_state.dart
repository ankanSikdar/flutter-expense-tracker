part of 'theme_cubit.dart';

enum ThemeColor {
  red,
  purple,
  blue,
}

final appBarTheme = AppBarTheme(
  textTheme: ThemeData.light().textTheme.copyWith(
        headline6: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
);

final purpleTheme = ThemeData(
  primarySwatch: Colors.purple,
  accentColor: Colors.amber,
  fontFamily: 'Poppins',
  appBarTheme: appBarTheme,
);

final redTheme = ThemeData(
  primarySwatch: Colors.red,
  accentColor: Colors.amber,
  fontFamily: 'Poppins',
  appBarTheme: appBarTheme,
);

final blueTheme = ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.amber,
  fontFamily: 'Poppins',
  appBarTheme: appBarTheme,
);

class ThemeState extends Equatable {
  final ThemeColor color;
  final ThemeData theme;

  ThemeState({
    @required this.color,
    @required this.theme,
  });

  factory ThemeState.initial() {
    return ThemeState(color: ThemeColor.purple, theme: purpleTheme);
  }

  @override
  List<Object> get props => [color, theme];

  ThemeState copyWith({
    ThemeColor color,
    ThemeData theme,
  }) {
    return ThemeState(
      color: color ?? this.color,
      theme: theme ?? this.theme,
    );
  }
}
