import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop_init/src/const/constant.dart';

class ReviewSectionPart extends StatefulWidget {
  const ReviewSectionPart({super.key});

  @override
  State<ReviewSectionPart> createState() => _ReviewSectionPartState();
}

class _ReviewSectionPartState extends State<ReviewSectionPart> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController commentController = TextEditingController();

  List filedata = [
    {
      'name': 'Govind',
      'pic': 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTV8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D',
      'message': 'Coding sucks in a good way.',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Kan Myint Htun',
      'pic': 'https://images.unsplash.com/photo-1508184964240-ee96bb9677a7?w=900&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MjB8fHByb2ZpbGV8ZW58MHx8MHx8fDA%3D',
      'message': 'the quality is good.',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Steve',
      'pic': 'assets/img/vice/vice1.jpg',
      'message': 'Very cool',
      'date': '2021-01-01 12:00:00'
    },
    {
      'name': 'Lamsal G',
      'pic': 'assets/img/vice11.png',
      'message': 'The product is not that great.',
      'date': '2021-01-01 12:00:00'
    },
  ];

  Widget commentChild(data) {
    return Expanded(
      child: ListView(
          children: List.generate(data.length, (i) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
          child: ListTile(
            leading: GestureDetector(
              onTap: () async {
                // Display the image in large form.
                print("Comment Clicked");
              },
              child: Container(
                height: 50.0,
                width: 50.0,
                decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: CircleAvatar(
                    radius: 50,
                    backgroundImage: CommentBox.commentImageParser(
                        imageURLorPath: data[i]['pic'])),
              ),
            ),
            title: Text(
              data[i]['name'],
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(data[i]['message']),
            trailing:
                Text(data[i]['date'], style: const TextStyle(fontSize: 10)),
          ),
        );
      })),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            const Gap(20),
            Center(
              child: Container(
                width: 100,
                height: 5.0,
                color: Colors.black,
              ),
            ),
            Expanded(
              child: CommentBox(
                userImage: CommentBox.commentImageParser(
                    imageURLorPath: firebaseAuth.currentUser?.photoURL!),
                labelText: 'Write a comment...',
                errorText: 'Comment cannot be blank',
                withBorder: false,
                sendButtonMethod: () {
                  if (formKey.currentState!.validate()) {
                    print(commentController.text);
                    setState(() {
                      var value = {
                        'name': firebaseAuth.currentUser?.displayName,
                        'pic': firebaseAuth.currentUser?.photoURL!,
                        'message': commentController.text,
                        'date': '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}'
                        
                      };
                      filedata.insert(0, value);
                    });
                    commentController.clear();
                    FocusScope.of(context).unfocus();
                  } else {
                    print("Not validated");
                  }
                },
                formKey: formKey,
                commentController: commentController,
                backgroundColor: Theme.of(context).primaryColor,
                textColor: Theme.of(context).primaryColorDark,
                sendWidget:
                     Icon(Icons.send_sharp, size: 24, color: Theme.of(context).primaryColorDark),
                child: commentChild(filedata),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
