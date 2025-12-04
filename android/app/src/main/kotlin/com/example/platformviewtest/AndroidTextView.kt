package com.example.platformviewtest

import android.content.Context
import android.graphics.Color
import android.view.Gravity
import android.view.View
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import io.flutter.plugin.platform.PlatformView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.engine.DiskCacheStrategy

class AndroidTextView(
    context: Context,
    creationParams: Map<String, Any>?
) : PlatformView {
    private val containerLayout: LinearLayout = LinearLayout(context)
    private val imageView: ImageView = ImageView(context)
    private val textView: TextView = TextView(context)

    init {
        val text = creationParams?.get("text") as? String ?: "Default Text"
        val imageUrl = creationParams?.get("imageUrl") as? String

        // Setup ImageView
        imageView.apply {
            scaleType = ImageView.ScaleType.CENTER_CROP
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                0,
                1f
            )

            if (imageUrl != null) {
                Glide.with(context)
                    .load(imageUrl)
                    .diskCacheStrategy(DiskCacheStrategy.NONE)
                    .skipMemoryCache(true)
                    .placeholder(android.R.color.darker_gray)
                    .error(android.R.color.holo_red_light)
                    .into(this)
            }
        }

        // Setup TextView overlay
        textView.apply {
            this.text = text
            this.gravity = Gravity.CENTER
            this.textSize = 16f
            this.setTextColor(Color.WHITE)
            this.setBackgroundColor(Color.argb(180, 0, 0, 0))
            setPadding(16, 16, 16, 16)
            layoutParams = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT
            )
        }

        // Setup container
        containerLayout.apply {
            orientation = LinearLayout.VERTICAL
            setBackgroundColor(Color.WHITE)
            addView(imageView)
            addView(textView)
        }
    }

    override fun getView(): View = containerLayout

    override fun dispose() {}
}
