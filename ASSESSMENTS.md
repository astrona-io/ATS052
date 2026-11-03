# Question Banks

Each section has a `quiz.yaml` and the course has `sections/final-domain-quiz.yaml`. They follow the question bank schema version 1, as in the other courses. Each question is single choice with four options, per-option feedback, a learning objective and source reading paths.

| Bank | File | Questions |
| --- | --- | --- |
| Section 010 | sections/section-010/quiz.yaml | 10 |
| Section 020 | sections/section-020/quiz.yaml | 11 |
| Section 030 | sections/section-030/quiz.yaml | 11 |
| Section 040 | sections/section-040/quiz.yaml | 12 |
| Section 050 | sections/section-050/quiz.yaml | 12 |
| Final domain quiz | sections/final-domain-quiz.yaml | 15 |

The manifest lists the banks as `type: quiz` entries with `pass_score: 70`, each after the capstone lab of its section, and the final bank at the end of the course.

The banks contain answer keys and are public learning material. They are practice material and not official CCA exam questions. The file `assessments/domain-review.yaml` is the older bank for the previous one-module layout. It is no longer listed.
