abstract class Failure {
  final String message;

  Failure({required this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class AuthFailure extends Failure {
  AuthFailure(String message) : super(message: message);
}

// class BookFailure extends Failure {
//   BookFailure([String message = 'Un-known error occured please try again'])
//       : super(message: message);
//   factory BookFailure.fromCode(String code) {
//     if (code == 'permission_denied') {
//       return BookFailure(
//         "Seems like you don't have to correct permissions. Permission Denied",
//       );
//     }
//     return BookFailure();
//   }
// }
