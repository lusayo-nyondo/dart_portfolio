import '../../containers/box_model/size.dart';

/// Abstract class for defining custom clip regions.
abstract class CustomClipper<T> {
  /// Returns the clip shape for the given size.
  T getClip(Size size);

  /// Called when the old clipper might need to be rebuilt.
  bool shouldReclip(covariant CustomClipper<T> oldClipper);
}
