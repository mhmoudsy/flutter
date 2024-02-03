import 'package:flutter/material.dart';

class Messengerscreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
 return Scaffold(
   appBar: AppBar(
     titleSpacing: 20.0,
     backgroundColor: Colors.white,
     elevation: 0.0,
     title:Row(
       children: [
         CircleAvatar(
           radius: 20.0,
           backgroundImage: NetworkImage('https://scontent.fcai20-3.fna.fbcdn.net/v/t39.30808-6/277577629_1133774327415624_1252120501314814624_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeF0a4NoVLeHUQu5BKa3inNDFXRyPtsLCtAVdHI-2wsK0JX0GRFV8lW1v8no_S0nyhs3mXjZXkaqym8u0UQJBPjb&_nc_ohc=zpsNvtEjRUYAX8b8IZj&tn=s0u1Ji3dwP4A7vV7&_nc_ht=scontent.fcai20-3.fna&oh=00_AT9lUNGQmBAVuHuyfkJW2KS4SaFN6k8RGZ7R0d1LyQmSwA&oe=632D117F'),
         ),
         SizedBox(
           width: 15.0,
         ),
         Text(
           'Chats',
           style: TextStyle(
             color: Colors.black
           ),
         ),
       ],
     ),
     actions: [
       IconButton(
             onPressed: (){},
             icon: CircleAvatar(
               radius: 15.0,
               backgroundColor: Colors.blue,
               child: Icon(
                   Icons.camera_alt,
                 size: 17.0,
                 color: Colors.white,
               ),
             )
         ),
       IconButton(
           onPressed: (){},
           icon: CircleAvatar(
             radius: 15.0,
             backgroundColor: Colors.blue,
             child: Icon(
               Icons.edit,
               size: 17.0,
               color: Colors.white,
             ),
           )
       ),
       
     ],
   ),
   body:Padding(
     padding: const EdgeInsets.all(20.0),
     child: SingleChildScrollView(
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Container(
             padding: EdgeInsets.all(7.0),
             decoration: BoxDecoration(
               borderRadius: BorderRadius.circular(10.0),
               color: Colors.grey,
             ),
             child: Row(
               children: [
                 Icon(
                   Icons.search,
                 ),
                 SizedBox(
                   width: 10.0,
                 ),
                 Text(
                   'Search',
                 ),
               ],
             ),
           ),
           SizedBox(
             height: 10.0,
           ),
          Container(
            height: 100.0,
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context,index)=>SizedBox(
                width: 10.0,
              ),
              scrollDirection: Axis.horizontal,
                itemBuilder: (context,index){
              return BuildStoryItem();
                },

              itemCount:10 ,
            ),
          ),
           ListView.separated(
             shrinkWrap: true,
             physics: NeverScrollableScrollPhysics(),
               itemBuilder: (context,int)=>BuildChatiItem(),
             separatorBuilder: (context,int)=>SizedBox(
               height: 20.0,
             ),
             itemCount: 15,
           ),
         ],
       ),
     ),
   ) ,
 );
  }
 Widget BuildChatiItem()=>Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage('https://scontent.fcai20-3.fna.fbcdn.net/v/t39.30808-6/277577629_1133774327415624_1252120501314814624_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeF0a4NoVLeHUQu5BKa3inNDFXRyPtsLCtAVdHI-2wsK0JX0GRFV8lW1v8no_S0nyhs3mXjZXkaqym8u0UQJBPjb&_nc_ohc=zpsNvtEjRUYAX8b8IZj&tn=s0u1Ji3dwP4A7vV7&_nc_ht=scontent.fcai20-3.fna&oh=00_AT9lUNGQmBAVuHuyfkJW2KS4SaFN6k8RGZ7R0d1LyQmSwA&oe=632D117F'),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(
              bottom: 4.0,
              end: 3.0,
            ),
            child: CircleAvatar(
              radius: 5.0,
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
      SizedBox(
        width: 20.0,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mhmoud Ahmed",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 7.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Hello My Friend How are You Hello My Friend How are You Hello My Friend How are You  ',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal:5.0,
                  ),
                  child: Container(
                    width: 5.0,
                    height: 5.0,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle
                    ),
                  ),
                ),
                Text(
                  '11:48 am',
                  style: TextStyle(
                      fontWeight: FontWeight.bold
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    ],
  );
 Widget BuildStoryItem()=>Container(
    width: 60.0,
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage('https://scontent.fcai20-3.fna.fbcdn.net/v/t39.30808-6/277577629_1133774327415624_1252120501314814624_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeF0a4NoVLeHUQu5BKa3inNDFXRyPtsLCtAVdHI-2wsK0JX0GRFV8lW1v8no_S0nyhs3mXjZXkaqym8u0UQJBPjb&_nc_ohc=zpsNvtEjRUYAX8b8IZj&tn=s0u1Ji3dwP4A7vV7&_nc_ht=scontent.fcai20-3.fna&oh=00_AT9lUNGQmBAVuHuyfkJW2KS4SaFN6k8RGZ7R0d1LyQmSwA&oe=632D117F'),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: 4.0,
                end: 3.0,
              ),
              child: CircleAvatar(
                radius: 5.0,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
        Text(
          'Mhmoud Ahmed Syd Mustafa El Barghot',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );

}
