package com.example.native_poc

import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Path
import android.util.AttributeSet
import android.view.MotionEvent
import android.view.View
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class CanvasPlatformView(context: Context, id: Int, creationParams: Map<String?, Any?>?) : PlatformView {
private val canvasView: CanvasView

    override fun getView(): View {
        return canvasView
    }

    override fun dispose() {}

    init {
        canvasView = CanvasView(context)
    }
}

class CanvasPlatformViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, viewId: Int, args: Any?): PlatformView {
        val creationParams = args as Map<String?, Any?>?
        return CanvasPlatformView(context, viewId, creationParams)
    }
}

class CanvasView(context: Context, attributes: AttributeSet? = null): View(context, attributes) {
    private val path = Path()
    private val paint by lazy {
        val paint = Paint()
        paint.style = Paint.Style.STROKE
        paint.color= Color.RED
        paint.strokeWidth = 10f
        paint
    }

    override fun onTouchEvent(event: MotionEvent?): Boolean {
        if(event == null) return false
        when(event.action) {
            MotionEvent.ACTION_DOWN -> path.moveTo(event.x, event.y)
            MotionEvent.ACTION_MOVE -> path.lineTo(event.x, event.y)
            else -> return false
        }
        invalidate()
        return true
    }

    override fun onDraw(canvas: Canvas?) {
        super.onDraw(canvas)
        canvas?.drawPath(path, paint)
    }
}