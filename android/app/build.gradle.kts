// android/app/build.gradle.kts (ini file di FOLDER app)

plugins {
    // Terapkan plugin yang sudah didefinisikan di file build.gradle.kts induk
    id("com.android.application")
    id("org.jetbrains.kotlin.android") // Terapkan plugin Kotlin yang sudah didefinisikan
    // Plugin Flutter didapat dari includeBuild di settings.gradle.kts
    id("dev.flutter.flutter-gradle-plugin")
    // Terapkan plugin Google Services
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.responsi2_mobile_paket3_h1d023114"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.responsi2_mobile_paket3_h1d023114"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}