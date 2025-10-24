import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseDatabase.instance.databaseURL = "https://kisaa-65c7a-default-rtdb.firebaseio.com/";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OtherCarrierOnboarding2(),
    );
  }
}

class OtherCarrierOnboarding2 extends StatefulWidget {
  const OtherCarrierOnboarding2({super.key});

  @override
  State<OtherCarrierOnboarding2> createState() => _OtherCarrierOnboarding2State();
}

class _OtherCarrierOnboarding2State extends State<OtherCarrierOnboarding2> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    FirebaseDatabase.instance
        .ref("employees/emp001/age")
        .onValue
        .listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      setState(() {
        _controller.text = data != null ? data.toString() : "No Data";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    const double designW = 430.0;
    const double designH = 932.0;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double scale = (screenWidth / designW < screenHeight / designH)
        ? screenWidth / designW
        : screenHeight / designH;

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: SafeArea(
          top: false,
          bottom: false,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/other_screen_background.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 50 * scale,
                left: 10 * scale,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.black,
                    size: 40 * scale,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Positioned(
                top: 297 * scale,
                left: (designW - 307) / 2 * scale,
                child: Container(
                  width: 307 * scale,
                  height: 213 * scale,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20 * scale),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 16 * scale, vertical: 12 * scale),
                    child: TextField(
                      controller: _controller,
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        fontSize: 20 * scale,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
