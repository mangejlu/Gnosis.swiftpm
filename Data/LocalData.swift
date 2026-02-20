//
//  LocalData.swift
//  Gnosis
//
//  Created by Mariangel J. Loaiza Urbina on 2/13/26.
//

import Foundation

struct LocalData {

    static let books: [Book] = [

        Book(
            id: "pinocchio",
            title: "Pinocchio",
            subtitle: "8 chapters",
            islandName: "Isle of Honesty",
            isLocked: false,
            progress: 7,

            chapters: [

                Chapter(
                    id: "ch1",
                    title: "Geppetto’s Wish",
                    content:
                    "In a quiet Italian village lived a gentle woodcarver named Geppetto. Though he was poor, he was rich in kindness and imagination. One day, he carved a puppet from a curious piece of wood that seemed almost alive. He shaped the puppet carefully and named him Pinocchio. That night, a magical Blue Fairy appeared in a soft blue glow and brought the puppet to life. She told Pinocchio that he could become a real boy if he proved himself brave, honest, and unselfish. Geppetto was overjoyed and promised to teach him right from wrong. Pinocchio felt excited, but he did not yet understand how difficult being good could be.",

                    highlightedWords: [
                        "imagination": "What you need to form ideas or pictures in your mind.",
                        "curious": "Weird in a way that makes you want to know more.",
                        "unselfish": "Caring more about others than yourself."
                    ],

                    quiz: Quiz(
                        questions: [
                            QuizQuestion(
                                id: "q1a",
                                question: "Who made Pinocchio?",
                                options: ["Geppetto", "The Fox", "Stromboli"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q1b",
                                question: "Who brought Pinocchio to life?",
                                options: ["Blue Fairy", "Geppetto", "A whale"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q1c",
                                question: "What must Pinocchio prove to become real?",
                                options: ["Brave, honest, unselfish", "Fast and strong", "Rich and famous"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q1d",
                                question: "What does imagination mean?",
                                options: ["Using your mind to create ideas", "Running fast", "Sleeping deeply"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q1e",
                                question: "How did Geppetto feel when Pinocchio came alive?",
                                options: ["Very happy", "Angry", "Bored"],
                                correctIndex: 0
                            )
                        ]
                    )
                ),

                Chapter(
                    id: "ch2",
                    title: "The First Mistakes",
                    content:
                    "Geppetto sold his warm winter coat to buy Pinocchio a schoolbook. It was a great sacrifice because he believed education would give his son a better future. Pinocchio promised to go straight to school, but on the way he heard music and laughter. His curiosity pulled him toward excitement instead of responsibility. Soon he met a sly Fox and Cat who persuaded him that school was boring and easy money was better. Pinocchio followed them, forgetting his promise and not thinking about the consequences of his choice.",

                    highlightedWords: [
                        "sacrifice": "Giving up something important to help someone else.",
                        "responsibility": "Something you are supposed to do or take care of.",
                        "consequences": "Results of an action or decision."
                    ],

                    quiz: Quiz(
                        questions: [
                            QuizQuestion(
                                id: "q2a",
                                question: "What did Geppetto sell?",
                                options: ["His coat", "His tools", "His house"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q2b",
                                question: "Why did he sell it?",
                                options: ["To buy a schoolbook", "To buy candy", "To travel"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q2c",
                                question: "Who tricked Pinocchio?",
                                options: ["Fox and Cat", "Blue Fairy", "Geppetto"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q2d",
                                question: "What does responsibility mean?",
                                options: ["A duty you must take care of", "A game", "A prize"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q2e",
                                question: "What are consequences?",
                                options: ["Results of choices", "New shoes", "Songs"],
                                correctIndex: 0
                            )
                        ]
                    )
                ),

                Chapter(
                    id: "ch3",
                    title: "The Puppet Master",
                    content:
                    "Pinocchio wandered into a lively puppet theater owned by Stromboli. The puppets were amazed that he could move without strings, and the audience cheered loudly. For a moment, Pinocchio felt proud. But Stromboli was greedy and cared only about money. He locked Pinocchio in a cage and planned to force him to perform every night. Frightened and regretful, Pinocchio wished he had listened to Geppetto. When the Blue Fairy appeared and asked what happened, Pinocchio lied. Instantly, his nose grew longer. Ashamed, he finally told the truth and was forgiven.",

                    highlightedWords: [
                        "greedy": "Wanting more than you need.",
                        "regretful": "Feeling sorry about something you did.",
                        "instantly": "Happening right away."
                    ],

                    quiz: Quiz(
                        questions: [
                            QuizQuestion(
                                id: "q3a",
                                question: "Who owned the puppet theater?",
                                options: ["Stromboli", "Geppetto", "Fox"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q3b",
                                question: "Why did Stromboli lock Pinocchio up?",
                                options: ["To make money", "To protect him", "To teach him"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q3c",
                                question: "What happened when he lied?",
                                options: ["His nose grew", "He disappeared", "He slept"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q3d",
                                question: "What does greedy mean?",
                                options: ["Wanting too much", "Sharing", "Sleeping"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q3e",
                                question: "How did Pinocchio feel in the cage?",
                                options: ["Frightened", "Excited", "Hungry"],
                                correctIndex: 0
                            )
                        ]
                    )
                ),

                Chapter(
                    id: "ch4",
                    title: "Lessons About Lies",
                    content:
                    "Even after being rescued, Pinocchio still struggled to make wise choices. Sometimes he thought small lies would protect him from trouble. Yet each lie made his nose grow, making his dishonesty visible to everyone. Pinocchio began to understand that lying damages trust. Without trust, friendships and families grow weak. He slowly learned that telling the truth requires courage, even when it feels difficult.",

                    highlightedWords: [
                        "visible": "Something that can be seen.",
                        "damages": "Causes harm.",
                        "courage": "Bravery when doing something hard."
                    ],

                    quiz: Quiz(
                        questions: [
                            QuizQuestion(
                                id: "q4a",
                                question: "What happened each time he lied?",
                                options: ["His nose grew", "He flew", "He shrank"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q4b",
                                question: "What does lying damage?",
                                options: ["Trust", "Shoes", "Trees"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q4c",
                                question: "What does visible mean?",
                                options: ["Able to be seen", "Hidden", "Broken"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q4d",
                                question: "Why is courage needed?",
                                options: ["To tell the truth", "To sleep", "To whisper"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q4e",
                                question: "What lesson was he learning?",
                                options: ["Honesty matters", "Candy is best", "Run away"],
                                correctIndex: 0
                            )
                        ]
                    )
                ),

                Chapter(
                    id: "ch5",
                    title: "Pleasure Island",
                    content:
                    "Pinocchio met a carefree boy who invited him to Pleasure Island, a place without rules or homework. At first it seemed wonderful. The boys played all day and ignored discipline. But the island held a terrible secret. Boys who refused to learn slowly transformed into donkeys. Pinocchio felt his ears stretching and his voice changing. Horrified, he realized that laziness and disobedience had consequences. He escaped just in time.",

                    highlightedWords: [
                        "discipline": "Self-control and obeying rules.",
                        "transformed": "Changed completely.",
                        "horrified": "Filled with fear or shock."
                    ],

                    quiz: Quiz(
                        questions: [
                            QuizQuestion(
                                id: "q5a",
                                question: "What made the island seem fun?",
                                options: ["No rules", "Lots of school", "Hard work"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q5b",
                                question: "What did the boys turn into?",
                                options: ["Donkeys", "Birds", "Fish"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q5c",
                                question: "What does transformed mean?",
                                options: ["Changed completely", "Stayed same", "Fell asleep"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q5d",
                                question: "How did Pinocchio feel?",
                                options: ["Horrified", "Happy", "Bored"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q5e",
                                question: "What lesson did he learn?",
                                options: ["Actions have consequences", "Skip school", "Ignore rules"],
                                correctIndex: 0
                            )
                        ]
                    )
                ),

                Chapter(
                    id: "ch6",
                    title: "Lost at Sea",
                    content:
                    "While Pinocchio was gone, Geppetto searched everywhere for him. His love was unwavering. He sailed across the sea but was swallowed by a giant whale named Monstro. When Pinocchio learned this, he felt deep guilt. Without hesitation, he dove into the ocean to rescue his father. Inside the enormous whale, he found Geppetto alive, and their reunion was full of relief and love.",

                    highlightedWords: [
                        "unwavering": "Steady and not changing.",
                        "hesitation": "Pausing because you are unsure.",
                        "enormous": "Very, very large."
                    ],

                    quiz: Quiz(
                        questions: [
                            QuizQuestion(
                                id: "q6a",
                                question: "Why did Geppetto sail away?",
                                options: ["To find Pinocchio", "To fish", "To rest"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q6b",
                                question: "Who swallowed Geppetto?",
                                options: ["Monstro", "Fox", "Fairy"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q6c",
                                question: "What does enormous mean?",
                                options: ["Very large", "Very small", "Very loud"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q6d",
                                question: "Did Pinocchio hesitate?",
                                options: ["No", "Yes"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q6e",
                                question: "How did they feel when reunited?",
                                options: ["Relieved", "Angry", "Sleepy"],
                                correctIndex: 0
                            )
                        ]
                    )
                ),

                Chapter(
                    id: "ch7",
                    title: "The Brave Escape",
                    content:
                    "Pinocchio knew they could not stay inside the whale. He devised a clever plan to build a small fire, causing the whale to sneeze. The powerful sneeze shot them out into the sea. Pinocchio carried his tired father through the waves with determination. Though exhausted, he refused to give up and thought only about his father’s safety.",

                    highlightedWords: [
                        "devised": "Carefully planned.",
                        "determination": "Refusing to give up.",
                        "exhausted": "Extremely tired."
                    ],

                    quiz: Quiz(
                        questions: [
                            QuizQuestion(
                                id: "q7a",
                                question: "What did Pinocchio build?",
                                options: ["A small fire", "A boat", "A cage"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q7b",
                                question: "Why did the whale sneeze?",
                                options: ["Because of smoke", "Because of rain", "Because of wind"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q7c",
                                question: "What does determination mean?",
                                options: ["Not giving up", "Sleeping", "Laughing"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q7d",
                                question: "How did Pinocchio feel?",
                                options: ["Exhausted", "Excited", "Hungry"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q7e",
                                question: "Who did he protect?",
                                options: ["Geppetto", "Fox", "Fairy"],
                                correctIndex: 0
                            )
                        ]
                    )
                ),

                Chapter(
                    id: "ch8",
                    title: "A Real Boy at Last",
                    content:
                    "Back home, Pinocchio worked diligently to care for Geppetto. He studied hard and showed maturity in his actions. He no longer chased foolish adventures. Seeing his selflessness and bravery, the Blue Fairy returned and turned him into a real boy. Geppetto awoke to find his son warm and alive. Tears of joy filled his eyes. Pinocchio had truly grown in heart.",

                    highlightedWords: [
                        "diligently": "Working carefully and with effort.",
                        "maturity": "Acting in a responsible, grown-up way.",
                        "selflessness": "Caring about others more than yourself."
                    ],

                    quiz: Quiz(
                        questions: [
                            QuizQuestion(
                                id: "q8a",
                                question: "How did Pinocchio work?",
                                options: ["Diligently", "Lazily", "Quickly"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q8b",
                                question: "What does maturity mean?",
                                options: ["Acting grown-up", "Being silly", "Sleeping late"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q8c",
                                question: "Why did the Fairy reward him?",
                                options: ["He was brave and honest", "He ran away", "He lied"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q8d",
                                question: "What does selflessness mean?",
                                options: ["Caring for others first", "Only caring for yourself", "Playing games"],
                                correctIndex: 0
                            ),
                            QuizQuestion(
                                id: "q8e",
                                question: "What did Pinocchio finally become?",
                                options: ["A real boy", "A whale", "A fox"],
                                correctIndex: 0
                            )
                        ]
                    )
                )

            ]
        ),

        Book(
            id: "alice",
            title: "Alice",
            subtitle: "Coming Soon",
            islandName: "Island of Curiosity",
            isLocked: true,
            progress: 0,
            chapters: []
        ),

        Book(
            id: "jungle",
            title: "Jungle Tales",
            subtitle: "Coming Soon",
            islandName: "Wild Wisdom Island",
            isLocked: true,
            progress: 0,
            chapters: []
        )
    ]
}

