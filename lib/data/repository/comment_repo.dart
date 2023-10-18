import 'package:get/get.dart';

import '../../utils/constants.dart';
import '../api/api_client.dart';

class CommentRepo extends GetxService{
  final ApiClient apiClient;
  CommentRepo({required this.apiClient});

  Future<Response> getCommentList() async{
    return await apiClient.getData(AppConstants.GET_COMMENT_ALL);
  }
}