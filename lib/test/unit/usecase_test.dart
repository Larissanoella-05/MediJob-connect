import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:medijob_connect/domain/usecases/sign_in_with_email.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late SignInWithEmail usecase;
  late MockAuthRepository mockRepo;

  setUp(() {
    mockRepo = MockAuthRepository();
    usecase = SignInWithEmail(mockRepo);
  });

  test('should sign in with email', () async {
    when(mockRepo.signInWithEmail('a@b.com', '123'))
        .thenAnswer((_) async => const Right(null));

    final result =
        await usecase(const Params(email: 'a@b.com', password: '123'));
    expect(result, const Right(null));
  });
}
