import 'dart:math';

List<String> images = ['images/sdearth.png', 'images/sdruler.png', 'images/sdbiology.png', 'images/sdcomputer.png', 'images/sdmusic.png', 'images/sddance.png'];

String randomImage() {
  return images[new Random().nextInt(images.length)];
}