import '../../views.dart';

class LogoutDialog extends AlertDialogModel<bool> {
  const LogoutDialog()
      : super(
          title: ComponentStrings.logout,
          message: ComponentStrings.areYouSureThatYouWantToLogOutOfTheApp,
          actions: const {
            ComponentStrings.cancel: false,
            ComponentStrings.logout: true,
          },
        );
}
