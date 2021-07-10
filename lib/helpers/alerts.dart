part of 'helpers.dart';

showLoading(BuildContext context) {
  showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CupertinoAlertDialog(
            title: Text("Espere"),
            content: LinearProgressIndicator(),
          ));
}

showAlert(BuildContext context, String title, String content) {
  showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              MaterialButton(
                child: Text("OK"),
                onPressed: () {
                Navigator.pop(context);
              })
            ],
          ));
}
