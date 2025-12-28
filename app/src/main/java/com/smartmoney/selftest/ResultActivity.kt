package com.smartmoney.selftest

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.smartmoney.selftest.databinding.ActivityResultBinding

class ResultActivity : AppCompatActivity() {

    private lateinit var binding: ActivityResultBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityResultBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val total = intent.getIntExtra("score", 0)
        val count = intent.getIntExtra("questionsCount", 1)

        val average = if (count > 0) total.toDouble() / count else 0.0

        val interpretation = when {
            average <= 1.0 -> "Highly satisfactory: You show strong financial resilience — keep it up and consider sharing your strategies."
            average <= 2.0 -> "Satisfactory: You have good habits but there’s room to tighten budgeting and planning."
            average <= 3.0 -> "Unsatisfactory: Consider reviewing spending, creating a budget, and seeking ways to increase savings."
            else -> "Critical: Immediate action recommended — seek financial advice and create a plan to stabilize your situation."
        }

        binding.tvScore.text = "Total: $total — Average: ${"%.2f".format(average)}"
        binding.tvInterpretation.text = interpretation
    }
}
