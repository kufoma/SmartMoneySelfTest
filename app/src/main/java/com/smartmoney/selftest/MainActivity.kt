package com.smartmoney.selftest

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import com.smartmoney.selftest.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private val questions = mutableListOf<Question>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        setupQuestions()

        val adapter = QuestionAdapter(questions)
        binding.rvQuestions.layoutManager = LinearLayoutManager(this)
        binding.rvQuestions.adapter = adapter

        binding.btnSubmit.setOnClickListener {
            val total = questions.sumOf { it.score }
            val intent = Intent(this, ResultActivity::class.java).apply {
                putExtra("score", total)
                putExtra("questionsCount", questions.size)
            }
            startActivity(intent)
        }
    }

    private fun setupQuestions() {
        val list = listOf(
            "I DON’T have a written personal or family budget",
            "I DON’T pay all the bills on time all the time",
            "I RARELY record all my expenses",
            "I FORGET to balance my budget every at the end of each month",
            "I RARELY plan for my bills. I just pay as and when they fall due",
            "I withdraw and spend my ENTIRE salary within 7 days of payday",
            "I have NO cash or any other forms of savings",
            "I have received more than one WARNING from those I owe money",
            "I have ONLY ONE source of regular, reliable, verifiable income",
            "I STILL OWING my friends; workmates money and I have not paid anything in the said period",
            "I BELONG to more than 3 village banking and Chilimba Groups",
            "For my debts, I only pay the MONTHLY MINIMUM that is expected",
            "I STILL OWE for food, utility, clothes and transport in the last 6 months",
            "My rentals, school fees are paid from a SALARY ADVANCE not my savings",
            "I HAVE LOANS from at least three lending institutions",
            "I DON’T KNOW how much money I need to retire from daily work",
            "If NO to 16 above, I don’t know the time when I will have this money"
        )

        questions.clear()
        list.forEachIndexed { i, s -> questions.add(Question(i, s)) }
    }
}
