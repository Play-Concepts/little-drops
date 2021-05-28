const apiVersion = 'v2.6';
const namespace = 'drops';
const storiesEndpoint = '/api/$apiVersion/data/$namespace/stories';
const profileEndpoint = '/api/$apiVersion/data/$namespace/profile';

void _test({String a: 'hello', String b: 'saturn'}) => print('$a, $b');
void test({String? a, String? b}) => _test(a: a!, b: b!);

void main() {
  print(profileEndpoint);
  print(storiesEndpoint);
  print(DateTime.now().millisecondsSinceEpoch);

  int count = 0;
  count++;
  print(count);
  count++;
  print(count);
}