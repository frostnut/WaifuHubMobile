// authentication state for users
// used to determine what the state of user
// auth is.
class AuthenticationState {
  final bool authenticated;

  AuthenticationState.initial({this.authenticated = false});

  AuthenticationState.authenticated({this.authenticated = true});

  AuthenticationState.failed({this.authenticated = false});

  AuthenticationState.signedOut({this.authenticated = false});
}
