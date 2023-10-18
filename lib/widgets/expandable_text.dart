import 'package:auto_point_mobile/utils/colors.dart';
import 'package:auto_point_mobile/utils/dimensions.dart';
import 'package:auto_point_mobile/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  late String firstHalf;
  late String secondHalf;

  bool hiddenText = true;

  double textHeight = Dimensions.screenHeight/5.63;

  @override
  void initState(){
    super.initState();
    if(widget.text.length > textHeight) {
      firstHalf = widget.text.substring(0, textHeight.toInt());
      secondHalf = widget.text.substring(textHeight.toInt() + 1);
    }else{
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty?SmallText(text: firstHalf,size: Dimensions.font16,color: Colors.black87,):Column(
        children: [
          SmallText(height: 1.4,text: hiddenText?(firstHalf+"..."):(firstHalf+secondHalf), size: Dimensions.font16, color: Colors.black87,),
          InkWell(
            onTap: (){
              setState(() {
                hiddenText = !hiddenText;
              });
            },
            child: Row(
              children: [
                SmallText(text: hiddenText?"Show more":"Show less", color: AppColors.mainColor,),
                Icon(hiddenText?Icons.arrow_drop_down:Icons.arrow_drop_up, color: AppColors.mainColor,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
