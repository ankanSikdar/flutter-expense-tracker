part of 'theme_cubit.dart';

enum ThemeColor {
  red,
  purple,
  blue,
  green,
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

final greenTheme = ThemeData(
  primarySwatch: Colors.green,
  accentColor: Colors.amber,
  fontFamily: 'Poppins',
  appBarTheme: appBarTheme,
);

final redTheme = ThemeData(
  primarySwatch: Colors.red,
  accentColor: Colors.grey[350],
  fontFamily: 'Poppins',
  appBarTheme: appBarTheme,
);

final blueTheme = ThemeData(
  primarySwatch: Colors.blue,
  accentColor: Colors.blueGrey.shade200,
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
    return ThemeState(color: ThemeColor.green, theme: greenTheme);
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
