import 'flexible.dart';

class Expanded extends Flexible {
  const Expanded({
    super.key,
    required super.child,
  }) : super(
          flex: 1,
          fit: FlexFit.tight,
        );
}
