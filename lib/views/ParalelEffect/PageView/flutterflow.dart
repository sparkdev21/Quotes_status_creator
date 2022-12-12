// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../QuotesUI/UserQuotesPage.dart';


// class FlowBack extends ConsumerWidget {
//   const FlowBack({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Scaffold(
//       body: ref.watch(firebaseIdeaProvider).when(
//             loading: () => const Center(child: CircularProgressIndicator()),
//             error: (err, stack) => Center(child: Text(err.toString())),
//             data: (ideas) {
//               return ListView.builder(
//                 itemCount: ideas.length,
//                 itemBuilder: (_, index) {
//                   return ListTile(
//                     title: Text(ideas[index].quote),
//                     subtitle: Text(ideas[index].status == 0
//                         ? "pending"
//                         : "published".toString()),
//                   );
//                 },
//               );
//             },
//           ),
//     );
//   }
// }
