
import 'package:auto_point_mobile/data/entities/comment.dart';
import 'package:auto_point_mobile/data/repository/comment_repo.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:get/get.dart';

class CommentController extends GetxController implements GetxService{
  final CommentRepo commentRepo;
  late final Response? response;

  CommentController({required this.commentRepo});

  List<dynamic> _commentList = [];
  List<dynamic> get commentList => _commentList;

  @override
  void onInit() async{
    super.onInit();
    await getCommentsFromAPI();
    update();
  }


  Future<void> getCommentsFromAPI() async{
    response = await commentRepo.getCommentList();

    if(response?.statusCode == 200){
      _commentList = [];

      for (var item in response?.body ) {
        _commentList.add(Comment.fromJson(item));
      }

      update();
    }
  }
}