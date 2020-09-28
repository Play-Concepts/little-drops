import 'dart:math';

List<String> images = ['images/sdearth.png', 'images/sdruler.png', 'images/sdbiology.png', 'images/sdcomputer.png', 'images/sdmusic.png', 'images/sddance.png'];

List<String> randomChildImages = ['https://cdn.fastly.picmonkey.com/contentful/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24E953B920A9CD0FF2E1D587742A2472/1-intro-photo-final.jpg?w=800&q=70', 'https://i.insider.com/5de6dd81fd9db241b00c04d3?width=1100&format=jpeg&auto=webp'];

List<String> messages = ['Excellent work!', 'Good Work!'];

String randomImage() => images[new Random().nextInt(images.length)];

String randomChildImage() => randomChildImages[new Random().nextInt(randomChildImages.length)];

String randomMessage() => messages[new Random().nextInt(messages.length)];

int randomScore() => new Random().nextInt(100);

