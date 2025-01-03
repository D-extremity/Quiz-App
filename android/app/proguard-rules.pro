 ## Flutter wrapper
 -keep class io.flutter.app.** { *; }
 -keep class io.flutter.plugin.** { *; }
 -keep class io.flutter.util.** { *; }
 -keep class io.flutter.view.** { *; }
 -keep class io.flutter.** { *; }
 -keep class io.flutter.plugins.** { *; }
 -keep class com.google.firebase.** { *; }
 -dontwarn io.flutter.embedding.**
 -ignorewarnings
 # Retain annotations
-keepattributes *Annotation*

# Keep all public classes, methods, and fields for libraries
-keep public class * {
    public *;
}

# Keep Firebase and analytics
-keep class com.google.firebase.** { *; }
-keep class com.google.android.gms.** { *; }

# Keep class members for serialization/deserialization
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}

# Prevent obfuscation of Retrofit and Gson models
-keep class retrofit2.** { *; }
-keep class com.google.gson.** { *; }

# Prevent obfuscation for Glide
-keep class com.bumptech.glide.** { *; }

# Keep enums
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# Optimize bytecode
-optimizations !code/simplification/arithmetic,!field/*,!class/merging/*

# General Android rules
-keep class android.** { *; }
-keep interface android.** { *; }
-keepclassmembers class android.** { *; }
