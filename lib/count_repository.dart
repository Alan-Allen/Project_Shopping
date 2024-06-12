abstract class CountRepositoryImp {
  Future<int> add(int count);
  Future<int> dec(int count);
}

class CountRepository implements CountRepositoryImp {
  @override
  Future<int> add(int count) async {
    return ++count;
  }

  @override
  Future<int> dec(int count) async {
    return --count;
  }
}