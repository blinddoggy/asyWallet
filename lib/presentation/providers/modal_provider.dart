// showModalBottomSheet(
//         context: context,
//         builder: (BuildContext context) {
//           return Container(
//             // color: CustomColorspace.red,
//             decoration: const BoxDecoration(
//                 gradient: LinearGradient(colors: CustomColors.spaceGradient)),
//             child: Column(
//               children: [
//                 Row(
//                   children: [
//                     const Text("Seleccionar Red"),
//                     InkWell(
//                       child: const Icon(Icons.close),
//                       onTap: () =>
//                           {ref.read(modalProvider2.notifier).state = false},
//                     )
//                   ],
//                 )
//               ],
//             ),
//           );
//         },
//       );