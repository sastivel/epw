# Flutter-specific rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.embedding.** { *; }

# Firebase
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Retrofit or Gson (if used)
-keepattributes Signature
-keepattributes *Annotation*
-keep class com.google.gson.** { *; }
-keep class retrofit2.** { *; }
-dontwarn retrofit2.**

# Prevent obfuscation of app entry point
-keep class com.example.epw.MainActivity { *; }
