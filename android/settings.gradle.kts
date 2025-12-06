// android/settings.gradle.kts

pluginManagement {
    repositories {
        google()
        mavenCentral()
        gradlePluginPortal()
    }
}

// Baca file local.properties untuk mendapatkan path Flutter SDK
val properties = java.util.Properties()
file("local.properties").inputStream().use { properties.load(it) }
val flutterSdkPath = properties.getProperty("flutter.sdk")

if (flutterSdkPath == null) {
    throw GradleException("Flutter SDK not found. Define flutter.sdk in local.properties")
}

// Sertakan build Gradle dari Flutter SDK
includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

// Sertakan modul 'app' ke dalam proyek
include(":app")