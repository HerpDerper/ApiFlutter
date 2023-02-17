enum URL {
  user('http://localhost:8888/user'),
  token('http://localhost:8888/token'),
  note('http://localhost:8888/note');

  final String value;

  const URL(this.value);
}
