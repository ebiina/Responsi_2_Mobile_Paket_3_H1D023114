// android/build.gradle.kts (ini file di FOLDER android, bukan di folder app)

plugins {
    // Definisikan SEMUA plugin yang diperlukan beserta versinya di sini
    id("com.android.application") version "8.1.2" apply false
    id("org.jetbrains.kotlin.android") version "1.9.10" apply false // Ganti 'kotlin-android' dengan ini
    id("com.google.gms.google-services") version "4.4.1" apply false
}