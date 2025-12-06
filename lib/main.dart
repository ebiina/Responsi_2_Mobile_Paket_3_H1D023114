import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/login_screen.dart';
import 'screens/book_list_screen.dart';
import 'firebase_options.dart';

// ---- PALET WARNA GLOBAL ----
const Color primaryBrown = Color(0xFF4E342E);      // Brown elegant
const Color secondaryBrown = Color(0xFF8D6E63);    // Soft koko
const Color accentBrown = Color(0xFFD7CCC8);       // Light cream
const Color bgCream = Color(0xFFF3EDE7);           // Premium background

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsi 2 Mobile Paket 3 (H1D023114)',
      theme: ThemeData(
        useMaterial3: true,

        // ======= COLOR SCHEME =======
        colorScheme: ColorScheme.light(
          primary: primaryBrown,
          secondary: secondaryBrown,
          surface: bgCream,
        ),

        // ======= TEXT =======
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: primaryBrown,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),

        // ======= APP BAR MODERN =======
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryBrown,
          foregroundColor: Colors.white,
          elevation: 8,
          centerTitle: true,
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
        ),

        // ======= BUTTON MODERN =======
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBrown,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
          ),
        ),

        // ======= TEXTFIELD MODERN =======
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: accentBrown.withOpacity(0.3),
          hintStyle: const TextStyle(color: Colors.black45),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: secondaryBrown,
              width: 2,
            ),
          ),
        ),

        // ======= CARD MODERN =======
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 3,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: Colors.black12,
        ),

        scaffoldBackgroundColor: bgCream,
      ),
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(primaryBrown),
              ),
            ),
          );
        }

        if (snapshot.hasData) {
          return const BookListScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
