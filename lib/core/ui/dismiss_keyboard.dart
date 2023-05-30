import 'package:flutter/cupertino.dart';

class DismissKeyboard extends StatelessWidget {
  final Widget child;

  const DismissKeyboard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        unfocusCurrWidget(context);
      },
      child: child,
    );
  }
}

void unfocusCurrWidget(BuildContext context) {
  final FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    currentFocus.requestFocus(FocusNode());
  }
}
