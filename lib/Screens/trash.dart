//class trash {
//  relatedList.length > 0 ?
//  Container(
//  height: 300,
//  width: width,
//  child: ListView.builder(
//  shrinkWrap: true,
//  scrollDirection: Axis.horizontal,
//  itemCount: relatedList.length,
//  itemBuilder: (context, index){
//  bool isFree = relatedList[index]['isFree'];
//
//  return InkWell(
//  child: Card(
//  elevation: 0,
//  child: Container(
//  width: width * 0.5,
//  child: Column(
//  mainAxisAlignment: MainAxisAlignment.start,
//  crossAxisAlignment: CrossAxisAlignment.start,
//  children: [
//  Padding(
//  padding: const EdgeInsets.all(8.0),
//  child: Center(child: SvgPicture.asset('svg/meditation.svg', height: width * 0.25, fit: BoxFit.fitHeight,)),
//  ),
//  Padding(
//  padding: const EdgeInsets.all(8.0),
//  child: Row(
//  mainAxisAlignment: MainAxisAlignment.start,
//  children: [
//  !isFree ? Container() : Icon(Icons.lock, color: Colors.black, size: 20,),
//  SizedBox(width: 5,),
//  Container(
//  width: width * 0.37,
//  child: Text(relatedList[index]['title'], style: kSubTitleTextStyle.copyWith(fontSize: 17),)),
//  ],
//  ),
//  ),
//  Padding(
//  padding: const EdgeInsets.only(left:8.0),
//  child: Row(
//  children: [
//  Icon(Icons.volume_up, color: Colors.black, size: 20,),
//  SizedBox(width: 5,),
//
//  Text('${relatedList[index]['duration']} min', style: kDescTextStyle,)
//  ],
//  ),
//  ),
//  Padding(
//  padding: const EdgeInsets.only(left:8.0, top: 4.0),
//  child: Text(relatedList[index]['desc'], style: kDescTextStyle,),
//  ),
//  ],
//  )
//  )
//  ),
//  onTap: (){
//  HapticFeedback.lightImpact();
//  pushNewScreen(context, screen: PlayMeditationScreen(data: relatedList[index]), withNavBar: false);
//  },
//  );
//  },
//  ),
//  ): CircularProgressIndicator()
//}


