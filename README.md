```@mermaid

classDiagram
    hide circle

    class Training {
        id: string
        name: string
        description: string
        duration: Duration
        categories: ArrayList&lt;Category&gt;
        tags: ArrayList&lt;Tag&gt;
        price: double
        author: Admin
        courses: ArrayList&lt;Course&gt;
        creation_date: date
    }

    class Duration {
        days: int
        hours: int
    }

    class Category {
        id: string
        name: string
        description: string
    }

    class Tag {
        id: string
        label: string
        description: string
    }

    class User {
        id: string
        firstname: string
        lastname: string
        email: string
        hashed_password: string
        basket: Basket
    }

    class Admin {}

    class Basket {
        training: ArrayList&lt;Training&gt;
        totalPrice: Double
    }

    class Course {
        id: string
        lessons: ArrayList&lt;Lesson&gt;
        quizzes: ArrayList&lt;Quiz&gt;
    }

    class Lesson {
        id: string
        content: string
    }

    class Quiz {
        id: string
        questions: ArrayList&lt;Question&gt;
    }

    class Question {
        question: string
        answer: string
    }

    User "0..1" --* "1" Basket
    Training "0..*" --* "0..*" Basket
    User <|-- Admin
    Training "1" o-- "0..*" Admin
    Duration "1" --* "1" Training
    Training "0..*" o-- "0..*" Category
    Training "0..*" o-- "0..*" Tag
    Training "0..*" o-- "0..*" Course
    Course "1" o-- "0..*" Lesson
    Course "1" o-- "0..*" Quiz
    Quiz "1" --* "0..*" Question
