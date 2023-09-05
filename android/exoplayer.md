---
layout: default
title: ExoPlayer
parent: Android
---

# ExoPlayer

首先我们先来看看官方的例子：
<https://developer.android.com/codelabs/exoplayer-intro>

根据官方的例子，我们可以看到，ExoPlayer的使用非常简单，只需要几行代码就可以实现视频的播放。

同时我们也了解到 ExoPlayer 在 Media3 中
<https://developer.android.com/jetpack/androidx/releases/media3>

我们需要在项目中添加相关的依赖
```patch
dependencies {

    implementation 'androidx.core:core-ktx:1.12.0'
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'androidx.lifecycle:lifecycle-runtime-ktx:2.7.0'
    implementation 'androidx.activity:activity-compose:1.7.0'

+   def media3_version = "1.2.1"
+   // For building media playback UIs
+   implementation "androidx.media3:media3-ui:$media3_version"
+   // Common functionality used across multiple media libraries
+   implementation "androidx.media3:media3-common:$media3_version"
+   // For media playback using ExoPlayer
+   implementation "androidx.media3:media3-exoplayer:$media3_version"
+   // For HLS playback support with ExoPlayer
+   implementation "androidx.media3:media3-exoplayer-hls:$media3_version"
}
```

现在我们在 Layout 中添加一个 `PlayerView` 用于显示视频

```xml
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent">

    <androidx.media3.ui.PlayerView
        android:id="@+id/player_view"
        android:layout_width="match_parent"
        android:layout_height="match_parent"
        android:layout_gravity="center"
        />

</RelativeLayout>
```

然后在 Activity 中添加相关的代码

```kotlin
package org.lsong.mytv

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.media3.common.MediaItem
import androidx.media3.exoplayer.ExoPlayer
import androidx.media3.ui.PlayerView

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val playerView = findViewById<PlayerView>(R.id.player_view)
        playerView.player = ExoPlayer.Builder(this).build()
        playerView.player!!.playWhenReady = true

        val mediaItem = MediaItem.fromUri("http://live.cgtn.com/1000/prog_index.m3u8")
        playerView.player!!.setMediaItem(mediaItem)
        playerView.player!!.prepare()
    }
}
```

由于我们播放网络视频，所以我们需要在 `AndroidManifest.xml` 中添加网络权限

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.INTERNET" />
</manifest>
```

现在我们就可以运行程序了，但是我们会发现程序运行后，视频并没有播放

```
Caused by: androidx.media3.datasource.HttpDataSource$CleartextNotPermittedException: Cleartext HTTP traffic not permitted. See https://developer.android.com/guide/topics/media/issues/cleartext-not-permitted
    at androidx.media3.datasource.DefaultHttpDataSource.open(DefaultHttpDataSource.java:405)
    at androidx.media3.datasource.DefaultDataSource.open(DefaultDataSource.java:272)
    at androidx.media3.datasource.StatsDataSource.open(StatsDataSource.java:86)
    ...
```

这是因为我们的视频是通过 `http` 协议加载的，而 Android 9 之后默认不允许加载 `http` 协议的资源，所以我们需要在 `AndroidManifest.xml` 中添加相关的配置

```patch
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:tools="http://schemas.android.com/tools">

    <uses-feature
        android:name="android.hardware.touchscreen"
        android:required="false" />
    <uses-feature
        android:name="android.software.leanback"
        android:required="true" />
    <uses-permission android:name="android.permission.INTERNET" />
    <application
+       android:usesCleartextTraffic="true"
        android:allowBackup="true"
        android:banner="@mipmap/ic_launcher"
        android:icon="@mipmap/ic_launcher"
        android:label="@string/app_name"
        android:supportsRtl="true"
        android:theme="@style/Theme.Mytv">
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />

                <category android:name="android.intent.category.LAUNCHER" />
                <category android:name="android.intent.category.LEANBACK_LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>
```