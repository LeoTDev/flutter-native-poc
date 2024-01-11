package com.example.native_poc

import android.content.Context
import android.graphics.Color
import android.graphics.ColorSpace
import android.view.View
import android.widget.TextView
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class NativeView(context: Context, private var id: Int, creationParams: Map<String?, Any?>?)
    : PlatformView {
    private val textView: TextView

    override fun getView(): View {
        textView.text = "Rendered on a native Android view (id: $id)"
        return textView
    }

    override fun dispose() {}

    init {
        val backgroundColor = (creationParams?.get("backgroundColor") as? Long)?.toInt()
                ?: Color.WHITE
        val textColor = (creationParams?.get("textColor") as? Long)?.toInt() ?: Color.BLACK
        textView = TextView(context)
        textView.textSize = 20f
        textView.setTextColor(textColor)
        textView.setBackgroundColor(backgroundColor)
        textView.text = "Rendered on a native Android view (id: $id)"
    }
}

class NativeViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        return NativeView(context, viewId, creationParams)
    }
}