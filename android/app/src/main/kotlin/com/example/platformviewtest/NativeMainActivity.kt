package com.example.platformviewtest

import android.content.Intent
import android.os.Bundle
import android.widget.Button
import androidx.appcompat.app.AppCompatActivity

class NativeMainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_native_main)

        findViewById<Button>(R.id.open_flutter_button).setOnClickListener {
            startActivity(Intent(this, MainActivity::class.java))
        }
    }
}
