
class ApiUrls {
  //static String get baseUrl => 'http://backend.fm/';
  static String get baseUrl => 'https://st-api.copax-fms.com/';
  // static String get baseUrl => 'https://itl-api.copax-fms.com/';
  static String get registerFCMToken => 'https://st-fgm.copax-fms.com/subscriber/register';
  static String get registerFCMToken1 => '/fgm/subscriber/register';
  //  static String get registerFCMToken => 'https://itl-fgm.copax-fms.com/subscriber/register';

  //static String get baseUrl => 'https://st-api.copax-fms.com/';
  static String get _auth => 'auth/';
  static String get _user => 'user/';
  static String get _v1 => 'v1/';
  static String get _notification => 'notification-center/${_v1}notifications';
  static String get _controls => 'controls';
  static String get _dashboard => 'dashboard/';
  static String get _alertManager => 'alert-manager/';
  static String get lockDoors => '$_controls/lock-doors';
  static String get unlockDoors => '$_controls/unlock-doors';
  static String get blockEngine => '$_controls/block-engine';
  static String get unblockEngine => '$_controls/unblock-engine';

  static String get login => '/$_auth${_v1}login';
  static String get dynamicLogin => '/$_auth${_v1}qr-token-exchange';
  static String get me => '/$_v1${_user}me';
  static String get updateNotificationSettings => '/$_v1${_user}subscribed-events';
  static String get forgetPassword => '/$_auth${_v1}forgot-password';
  static String get resetPassword => '/$_auth${_v1}set-password';
  static String get verifyCode => '/$_auth${_v1}verify-code';
  static String get vehicle => '/${_v1}vehicle';
  static String get customer => '/${_v1}customer';
  static String get notificationCount => '/$_notification/non-received-count';
  static String get markNotificationSeen => '/$_notification/mark-all-as-seen';
  static String get notifications => '/$_notification';
  static String get trip => '/${_v1}trip';
  static String get records => '/${_v1}records';
  static String get driver => '/${_v1}driver';
  static String get customers => '/${_v1}customer';
  static String get notificationsSettings => '/${_v1}notifications-settings';
  static String get refreshToken  => '/$_auth${_v1}refresh';
  static String get vehicleState => '/vehicle-stats';
  static String get branches => '/${_v1}branch';
  static String get mySessions => '/$_auth${_v1}my-sessions';
  static String get customerWithAlerts => '/$_alertManager${_v1}customers';
  static String get vehicleWithAlerts => '/$_alertManager${_v1}vehicles';
  static String get alerts => '/$_alertManager${_v1}alerts';
  static String get alertByPriorities => '/$_alertManager${_v1}alerts-by-priority';
  static String get resolveAlert => '/$_alertManager${_v1}resolve-alert';
  static String get alertStats => '/$_alertManager${_v1}customers-by-priority';
  static String get terminateSession => '/terminate-session';


}