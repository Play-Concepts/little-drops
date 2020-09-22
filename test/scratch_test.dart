const apiVersion = 'v2.6';
const namespace = 'drops';
const storiesEndpoint = '/api/$apiVersion/data/$namespace/stories';
const profileEndpoint = '/api/$apiVersion/data/$namespace/profile';

void main() {
  print(profileEndpoint);
  print(storiesEndpoint);
  print(DateTime.now().millisecondsSinceEpoch);
}