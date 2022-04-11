import 'package:flutter/material.dart';

const roundedCorner = Radius.circular(20);

class ChatText extends StatelessWidget {
  final Size size;
  final bool isMine;
  // final ChatModel chatModel;

  const ChatText(
      {Key? key,
      required this.size,
      required this.isMine,
      // required this.chatModel,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isMine ? _buildMyMsg(context) : _buildOtherMsg(context);
  }

  Row _buildOtherMsg(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.face),
        SizedBox(
          width: 6,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Text(
                '죽는 날까지 하늘을 우러러 한 점 부끄럼이 없기를 잎새에 이는 바람에도 나는 괴로워했다. 별을 노래하는 마음으로 모든 죽어가는 것을 사랑해야지 그리고 나한테 주어진 길을 걸어가야겠다.오늘 밤에도 별이 바람에 스치운다.',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: Colors.white),
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              constraints:
                  BoxConstraints(minHeight: 40, maxWidth: size.width * 0.5),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(2),
                    topRight: roundedCorner,
                    bottomRight: roundedCorner,
                    bottomLeft: roundedCorner),
              ),
            ),
            SizedBox(
              width: 6,
            ),
            Text('오전 10:25'),
          ],
        ),
      ],
    );
  }

  Row _buildMyMsg(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('오전 10:25'),
        SizedBox(
          width: 6,
        ),
        Container(
          child: Text(
            '동해물과 백두산이 마르고 닳도록 하느님이 보우하사 우리나라 만세 무궁화 삼천리',
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(color: Colors.white),
          ),
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          constraints:
              BoxConstraints(minHeight: 40, maxWidth: size.width * 0.6),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
                topLeft: roundedCorner,
                topRight: Radius.circular(2),
                bottomRight: roundedCorner,
                bottomLeft: roundedCorner),
          ),
        ),
        SizedBox(width: 5,)
      ],
    );
  }
}
