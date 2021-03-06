import 'dart:convert';
import 'package:http/http.dart' as http;

// Future sendnotification(String channelname, String fcm_token, String screenId,
//     String caller_id, String user_id, String user_Image) async {
//   var Response =
//       await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
//           body: jsonEncode({
//             "registration_ids": [
//               fcm_token,
//             ], //token
//             "collapse_key": "type_a",
//             "notification": {
//               "body": channelname,
//               "title": "Title of Your Notification"
//             },
//             "data": {
//               "body": "Body of Your Notification in Data",
//               "title": "Title of Your Notification in Title",
//               "channel_name": channelname,
//               "screenId": screenId
//             }
//           }),
//           encoding: Encoding.getByName("utf-8"),
//           headers: {
//         'Content-Type': 'application/json',
//         'Authorization':
//             'key=AAAAWVHnPRM:APA91bGKz6q_JLW0--EVLtHe9tOrZ_mb4DucyQjLWeU691dQyP3FCzCxtjh3Sd_Qlfbj0ojM2tx62evClUyNsWzhDBHeQhIZfu7pubZJpeuFUsMDJwi0mwuA5A_FaNcnFMjdg2XH7FDq'
//       });
//   var response = jsonDecode(Response.body.toString());
// }
Future sendnotification(String channelname, String fcm_token, String screenId,
    String caller_id, String user_id, String user_Image) async {
  print(
      user_id.toString() + caller_id.toString() + 'ssssssssssssssssssssssssss');
  var Response =
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: jsonEncode({
            "registration_ids": [
              fcm_token,
            ], //token
            "collapse_key": "type_a",
            "notification": {
              "body": "",
              "title": (screenId == '0')
                  ? "Incoming Video Call "
                  : "Incoming Voice Call "
            },
            "data": {
              "title": " ",
              "channel_name": channelname,
              "screenId": screenId,
              "caller_id": caller_id,
              "user_id": user_id,
              "user_Image": user_Image,
            }
          }),
          encoding: Encoding.getByName("utf-8"),
          headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAWVHnPRM:APA91bGKz6q_JLW0--EVLtHe9tOrZ_mb4DucyQjLWeU691dQyP3FCzCxtjh3Sd_Qlfbj0ojM2tx62evClUyNsWzhDBHeQhIZfu7pubZJpeuFUsMDJwi0mwuA5A_FaNcnFMjdg2XH7FDq'
      });
  var response = jsonDecode(Response.body.toString());
}

Future rejectCall(String fcm_token) async {
  var Response =
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: jsonEncode({
            "registration_ids": [
              fcm_token,
            ], //token
            "collapse_key": "type_a",
            "notification": {"body": "", "title": "Rejected Call"},
            "data": {"title": "Rejected  Call"}
          }),
          encoding: Encoding.getByName("utf-8"),
          headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAWVHnPRM:APA91bGKz6q_JLW0--EVLtHe9tOrZ_mb4DucyQjLWeU691dQyP3FCzCxtjh3Sd_Qlfbj0ojM2tx62evClUyNsWzhDBHeQhIZfu7pubZJpeuFUsMDJwi0mwuA5A_FaNcnFMjdg2XH7FDq'
      });
  var response = jsonDecode(Response.body.toString());
}
