// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../info/user.dart';
import '../../themepage/theme.dart';
import '../room.dart';
import '../create/room_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();

    if (UserProvider.userName != null) {
      NAME = UserProvider.userName;
    }
  }

  String? NAME;
  List<String> roomCode = [];
  // ignore: unused_field, prefer_final_fields
  TextEditingController _roomNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 25, top: 66),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '나의 습관',
                      style: blackw500.copyWith(fontSize: 16),
                    ),
                    SizedBox(height: 19),
                    Text(
                      '조이',
                      style: pinkw700.copyWith(fontSize: 20),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '소다',
                      style: blackw700.copyWith(fontSize: 20),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                    width: 108,
                    height: 114,
                    margin: EdgeInsets.only(right: 31),
                    child: Image.asset('assets/images/home_icon.png'))
              ],
            ),
          ),
          SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: TabBar(
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2, // Bottom line width
                    ), // Bottom line padding
                    borderRadius:
                        BorderRadius.circular(2), // Adjust the radius as needed
                  ),
                  indicatorWeight: 3,
                  indicatorColor: Color.fromRGBO(36, 38, 37, 1),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorPadding:
                      EdgeInsets.only(bottom: 1), // Adjust horizontal padding
                  controller: _tabController,
                  // label color
                  labelColor: Color.fromRGBO(36, 38, 37, 1),
                  // unselected label color
                  unselectedLabelColor: Color.fromARGB(255, 151, 151, 151),
                  tabs: [
                    Tab(
                      child: Text(
                        '진행중인 방',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 18, // Font size
                          fontWeight: FontWeight.w700, // Font weight 700
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        ' 완료된 방 ',
                        style: TextStyle(
                          fontFamily: 'Pretendard',
                          fontSize: 18, // Font size
                          fontWeight: FontWeight.w700, // Font weight 700
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(width: 100),
              IconButton(
                  onPressed: () {
                    _showBottomSheet(context, '1');
                  },
                  icon: Icon(Icons.add))
            ],
          ),
          Divider(
            height: 0,
            color: Color.fromRGBO(170, 170, 170, 1),
          ),
          Container(
            margin: EdgeInsets.only(top: 23, left: 25),
            height: 448,
            width: 393,
            child: TabBarView(
              controller: _tabController,
              children: [
                Tabbarviewinmoa(),
                Container(
                    margin: EdgeInsets.only(right: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 131,
                            height: 116,
                            child: Image.asset(
                                'assets/images/home_completed.png')),
                        SizedBox(height: 19),
                        Text(
                          '완료된 방은',
                          style: blackw500.copyWith(fontSize: 17),
                        ),
                        SizedBox(height: 5),
                        Text(
                          '업데이트 예정이에요',
                          style: blackw500.copyWith(fontSize: 17),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context, String text) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(23.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Container(
            margin: EdgeInsets.only(top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 25),
                  child: Text(
                    '함께 시작하기',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SetRoomTitle()),
                      );
                    },
                    icon: ImageIcon(
                      size: 18,
                      color: Colors.black,
                      AssetImage('assets/images/plus.png'),
                    ),
                    label: Text('방 생성하기',
                        style: blackw500.copyWith(
                            fontSize: 16, letterSpacing: -1)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showEnterRoomBottomSheet(context);
                    },
                    icon: ImageIcon(
                      size: 18,
                      color: Colors.black,
                      AssetImage('assets/images/key.png'),
                    ),
                    label: Text('참여코드로 방 입장하기',
                        style: blackw500.copyWith(
                            fontSize: 16, letterSpacing: -1)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEnterRoomBottomSheet(BuildContext context) {
    bool isConfirmButtonEnabled = false;
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateInside) {
            return Container(
              height: 327,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23), color: Colors.white),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 16),
                        width: 48,
                        height: 3.346,
                        decoration: BoxDecoration(
                          color: Color(0xFFAAAAAA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, top: 14),
                      child: Text('방 입장하기',
                          style: blackw700.copyWith(
                              fontSize: 18, letterSpacing: -1)),
                    ),
                    SizedBox(height: 42),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                '참여코드',
                                style: greyw500.copyWith(
                                  fontSize: 14,
                                  letterSpacing: -1,
                                ),
                              ),
                            ],
                          ),
                          TextField(
                            controller: _roomNameController,
                            style: blackw500.copyWith(
                                fontSize: 24, letterSpacing: -1.5),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFEFEFEF)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFEFEFEF)), // 원하는 색상으로 변경
                              ),
                              hintText: '입력해주세요',
                              hintStyle: greyw500.copyWith(
                                  fontSize: 24, letterSpacing: -1.5),
                              contentPadding:
                                  EdgeInsets.fromLTRB(0, 20, 0, 10), // 상하 여백 조정
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              setState(() {
                                isConfirmButtonEnabled = value.length == 4;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 67.0),
                    Container(
                      width: 343,
                      height: 45,
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: ElevatedButton(
                        onPressed: isConfirmButtonEnabled
                            ? () async {
                                final roomCodeText = _roomNameController.text;
                                _roomNameController.clear();

                                final querySnapshot = await firestore
                                    .collection('Biginfo')
                                    .where('code', isEqualTo: roomCodeText)
                                    .get();

                                if (querySnapshot.docs.isNotEmpty) {
                                  final roomId = querySnapshot.docs[0].id;
                                  final roomDoc = firestore
                                      .collection('Biginfo')
                                      .doc(roomId);
                                  await roomDoc.update({
                                    "users_id": FieldValue.arrayUnion(
                                        [UserProvider.userId]),
                                    "users_name": FieldValue.arrayUnion(
                                        [UserProvider.userName]),
                                  });
                                  setState(() {
                                    roomCode.add(roomCodeText);
                                  });
                                  roomDoc.get().then((docSnapshot) {
                                    final roomData = docSnapshot.data();
                                    final Title = roomData?['title'] as String;
                                    print(Title);
                                    final Mission =
                                        roomData?['mission'] as String;
                                    print(Mission);
                                    final Image =
                                        roomData?['roomImage'] as String;
                                    print(Image);

                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Room(
                                          id: roomId,
                                          roomimage: Image,
                                          roommission: Mission,
                                          roomtitle: Title,
                                        ),
                                      ),
                                    );
                                    // 이제 roomTitle을 사용하여 원하는 곳에 표시할 수 있습니다.
                                  }).catchError((error) {
                                    print('Error getting document: $error');
                                  });
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // 버튼 모서리 둥글기 설정
                            ),
                            backgroundColor: Color(0xFFEF597D)),
                        child: Text(
                          '입장하기',
                          style: whitew700.copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class Tabbarviewinmoa extends StatefulWidget {
  const Tabbarviewinmoa({super.key});
  @override
  State<Tabbarviewinmoa> createState() => TabbarviewinmoaState();
}

final firestore = FirebaseFirestore.instance;

class TabbarviewinmoaState extends State<Tabbarviewinmoa>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();

    if (UserProvider.userName != null) {
      NAME = UserProvider.userName;
    }
  }

  String? NAME;
  List<String> roomCode = [];
  // ignore: unused_field, prefer_final_fields
  TextEditingController _roomNameController = TextEditingController();
  var scroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: firestore.collection('Biginfo').snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final docs = snapshot.data!.docs;
        final filteredDocs = docs
            .where((doc) =>
                (doc['users_id'] as List?)?.contains(UserProvider.userId) ??
                false)
            .toList();
        if (filteredDocs.length > 0) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true, // Prevents the ListView from scrolling
            itemCount: filteredDocs.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Room(
                        id: filteredDocs[index]['id'] as String,
                        roomimage: filteredDocs[index]['roomImage'] as String,
                        roommission: filteredDocs[index]['mission'] as String,
                        roomtitle: filteredDocs[index]['title'] as String,
                      ),
                    ),
                  );
                },
                child: Card(
                  shadowColor: Colors.transparent,
                  child: Container(
                    width: 299,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        fit: BoxFit
                            .cover, // Make the image cover the entire container
                        image: NetworkImage(
                          filteredDocs[index]['roomImage'] as String,
                        ),
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.4), // 여기서 색상과 투명도 조절 가능
                          BlendMode.darken, // 원하는 블렌드 모드 선택
                        ),
                      ),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: 20), // Adding some padding at the top
                            child: Text(
                              filteredDocs[index]['title'] as String,
                              style: whitew700.copyWith(fontSize: 24),
                            ),
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () async {
                              try {
                                // Replace "Biginfo" with the actual collection name
                                await FirebaseFirestore.instance
                                    .collection("Biginfo")
                                    .doc(filteredDocs[index]['id'])
                                    .delete();
                              } catch (e) {
                                print("Error deleting document: $e");
                              }
                            },
                            child: Container(
                              width: 30,
                              height: 18,
                              child: Image.asset('assets/images/kebap.png'),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        children: [
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width: 132,
                                height: 30,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(3), // 반지름 값을 설정합니다.
                                  color: Color.fromRGBO(255, 239, 244, 1),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 12, bottom: 3),
                                      child: Text(
                                        filteredDocs[index]['mission']
                                            as String,
                                        style: pinkw700.copyWith(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return Padding(
            padding: const EdgeInsets.only(right: 47, left: 22),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                    width: 299,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                        child: Column(
                      children: [
                        SizedBox(height: 34),
                        Container(
                            width: 292,
                            height: 188,
                            child: Image.asset('assets/images/login.png')),
                        SizedBox(height: 9),
                        Text(
                          '친구들과 함께',
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.48),
                        ),
                        Text(
                          '습관을 만들어보세요',
                          style: TextStyle(
                              fontFamily: 'Pretendard',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.48),
                        ),
                        SizedBox(height: 40),
                        ElevatedButton(
                          onPressed: () {
                            _showBottomSheet(context, '1');
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            foregroundColor: Color(0xFFFFFFFF),
                            backgroundColor:
                                Color(0xFFEF597D), // 버튼 내의 아이콘과 텍스트 색상
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // 모서리 보더 반경
                            ),
                            minimumSize: Size(267, 45), // 버튼 크기 설정
                          ),
                          child: Text(
                            '함께 하기',
                            style: TextStyle(
                                fontFamily: 'Pretendard',
                                fontSize: 18, // 폰트 크기
                                fontWeight: FontWeight.w700, // 폰트 무게
                                color: Color(0xFFFFFFFF),
                                letterSpacing: -0.36 // 글씨 색
                                ),
                          ),
                        ),
                        SizedBox(height: 18)
                      ],
                    ))),
              ],
            ),
          );
        }
      },
    );
  }

  void _showBottomSheet(BuildContext context, String text) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(23.0)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 200,
          child: Container(
            margin: EdgeInsets.only(top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 25),
                  child: Text(
                    '함께 시작하기',
                    style: TextStyle(
                        fontFamily: 'Pretendard',
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -1),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SetRoomTitle()),
                      );
                    },
                    icon: ImageIcon(
                      size: 18,
                      color: Colors.black,
                      AssetImage('assets/images/plus.png'),
                    ),
                    label: Text('방 생성하기',
                        style: blackw500.copyWith(
                            fontSize: 16, letterSpacing: -1)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _showEnterRoomBottomSheet(context);
                    },
                    icon: ImageIcon(
                      size: 18,
                      color: Colors.black,
                      AssetImage('assets/images/key.png'),
                    ),
                    label: Text('참여코드로 방 입장하기',
                        style: blackw500.copyWith(
                            fontSize: 16, letterSpacing: -1)),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEnterRoomBottomSheet(BuildContext context) {
    bool isConfirmButtonEnabled = false;
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateInside) {
            return Container(
              height: 327,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23), color: Colors.white),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 16),
                        width: 48,
                        height: 3.346,
                        decoration: BoxDecoration(
                          color: Color(0xFFAAAAAA),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, top: 14),
                      child: Text('방 입장하기',
                          style: blackw700.copyWith(
                              fontSize: 18, letterSpacing: -1)),
                    ),
                    SizedBox(height: 42),
                    Container(
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                '참여코드',
                                style: greyw500.copyWith(
                                  fontSize: 14,
                                  letterSpacing: -1,
                                ),
                              ),
                            ],
                          ),
                          TextField(
                            controller: _roomNameController,
                            style: blackw500.copyWith(
                                fontSize: 24, letterSpacing: -1.5),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFFEFEFEF)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFEFEFEF)), // 원하는 색상으로 변경
                              ),
                              hintText: '입력해주세요',
                              hintStyle: greyw500.copyWith(
                                  fontSize: 24, letterSpacing: -1.5),
                              contentPadding:
                                  EdgeInsets.fromLTRB(0, 20, 0, 10), // 상하 여백 조정
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            onChanged: (value) {
                              setState(() {
                                isConfirmButtonEnabled = value.length == 4;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 67.0),
                    Container(
                      width: 343,
                      height: 45,
                      margin: EdgeInsets.only(left: 25, right: 25),
                      child: ElevatedButton(
                        onPressed: isConfirmButtonEnabled
                            ? () async {
                                final roomCodeText = _roomNameController.text;
                                _roomNameController.clear();

                                final querySnapshot = await firestore
                                    .collection('Biginfo')
                                    .where('code', isEqualTo: roomCodeText)
                                    .get();

                                if (querySnapshot.docs.isNotEmpty) {
                                  final roomId = querySnapshot.docs[0].id;
                                  final roomDoc = firestore
                                      .collection('Biginfo')
                                      .doc(roomId);
                                  await roomDoc.update({
                                    "users_id": FieldValue.arrayUnion(
                                        [UserProvider.userId]),
                                    "users_name": FieldValue.arrayUnion(
                                        [UserProvider.userName]),
                                  });
                                  setState(() {
                                    roomCode.add(roomCodeText);
                                  });
                                  roomDoc.get().then((docSnapshot) {
                                    final roomData = docSnapshot.data();
                                    final Title = roomData?['title'] as String;
                                    print(Title);
                                    final Mission =
                                        roomData?['mission'] as String;
                                    print(Mission);
                                    final Image =
                                        roomData?['roomImage'] as String;
                                    print(Image);

                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Room(
                                          id: roomId,
                                          roomimage: Image,
                                          roommission: Mission,
                                          roomtitle: Title,
                                        ),
                                      ),
                                    );
                                    // 이제 roomTitle을 사용하여 원하는 곳에 표시할 수 있습니다.
                                  }).catchError((error) {
                                    print('Error getting document: $error');
                                  });
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // 버튼 모서리 둥글기 설정
                            ),
                            backgroundColor: Color(0xFFEF597D)),
                        child: Text(
                          '입장하기',
                          style: whitew700.copyWith(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
