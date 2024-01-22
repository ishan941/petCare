// import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:project_petcare/helper/constant.dart';
// import 'package:project_petcare/view/customs/consttextform.dart';

// class ForgetPassword extends StatefulWidget {
//   const ForgetPassword({super.key});

//   @override
//   State<ForgetPassword> createState() => _ForgetPasswordState();
// }

// class _ForgetPasswordState extends State<ForgetPassword> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: ColorUtil.primaryColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: 20,),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Row(
//                   children: [
//                     Icon(Icons.arrow_back_ios),
//                     Text("Forget Password?"),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 200,),
//               // Container(
//               //   height: 5000,
//               //   decoration: BoxDecoration(
//               //     borderRadius: BorderRadius.circular(20),
//               //       color: ColorUtil.BackGroundColorColor,
                    
//               //   ),
//               //   child: Column(
//               //     children: [
//               //       ConstTextForm(),
//               //       Container(height: 200,
//               //       color: Colors.red,)
//               //     ],
//               //   ),
                
                
                
              
//               // ),
//               Container(
//                 height: 500,
//                 color: Colors.green,
//                 child: Expanded(
//                   child: GridView.builder(
//                   //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   //   crossAxisCount: 2),
//                   // itemCount: 10,
//                   //  itemBuilder: (context, index)
//                   //  {
//                   //   return  Container(
//                   //   height: 20,
//                   //   // color: Colors.red,
//                   //  );
                  
//                   //  }
//                   gridDelegate: SliverWovenGridDelegate.count(
//                     pattern: [

//                   ], crossAxisCount: 2),
//                   ),
//                 ),
//             //     Container(
//             //   height: 500,
//             //   child: Container(
//             //     height: MediaQuery.of(context).size.height*0.15,

               
                  
//             //      child: GridView.custom(
                    
//             //         gridDelegate: SliverWovenGridDelegate.count(
                      
//             //           crossAxisCount: 2,
//             //           mainAxisSpacing: 0,
//             //           crossAxisSpacing: 0,
//             //           pattern: [
//             //             WovenGridTile(1),
//             //             WovenGridTile(
//             //               5 / 7,
//             //               crossAxisRatio: 0.9,
//             //               alignment: AlignmentDirectional.centerEnd,
//             //             ),
//             //           ],
//             //         ),
            
//             //         childrenDelegate: SliverChildBuilderDelegate(
//             //           (context, index) => Container(
//             //             decoration: BoxDecoration(
//             //                 boxShadow: [
//             //                   BoxShadow(
//             //                     spreadRadius: 0,
//             //                     blurRadius: 3,
//             //                     color: Colors.grey.withOpacity(0.5),
//             //                     offset: Offset(2, 4),
//             //                   ),
//             //                 ],
//             //                 borderRadius: BorderRadius.circular(10),
//             //                 color: Colors.white),
//             //                 child: Column(
//             //                   children: [
//             //                     Image.network(donateProvider.donatePetList[index].imageUrl!,
//             //                     fit: BoxFit.cover,
//             //                     )
//             //                   ],
//             //                 ),
//             //           ),
//             //         ),
//             //       ),
                
//             //   ),
//             // )
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }