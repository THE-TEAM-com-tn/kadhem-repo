@startuml

hide circle
class Training {
    id: string
    name: string
    description: string
    duration: Duration
    categories: ArrayList<Category>
    tags: ArrayList<Tag>
    price: double
    author: Admin
    courses: ArrayList<Course>
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
   training: ArrayList<Training>
   totalPrice: Double
}

class Course {
   id: string
   lessons: ArrayList<Lesson>
   quizzes: ArrayList<Quiz>
}

class Lesson {
   id: string
   content: string
}

class Quiz {
   id: string
   questions: ArrayList<Question>
}

class Question {
   question: string
   answer: string
}

Basket "0..1" --* "1" User
Training "0..*" *-- "0..*" Basket
User <|-- Admin
Training "1" o-- "0..*" Admin
Duration "1" --* "1" Training
Training "0..*" o-- "0..*" Category
Training "0..*" o-- "0..*" Tag
Training "0..*" o-- "0..*" Course
Course "1" o-- "0..*" Lesson
Course "1" o-- "0..*" Quiz
Quiz "1" *-- "0..*" Question

@enduml
