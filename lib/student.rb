class Student
  attr_reader :name, :grade, :id
 
  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = nil
  end

  def self.create_table
    DB[:conn].execute("CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, grade TEXT);")
  end

  def self.drop_table
    DB[:conn].execute("DROP TABLE IF EXISTS students;")
  end

  def save
    DB[:conn].execute("INSERT INTO students(name, grade) VALUES (?, ?);", self.name, self.grade)
    @id = DB[:conn].execute("SELECT id FROM STUDENTS ORDER BY id DESC LIMIT 1;")[0][0]
  end

  def self.create(hash)
    student = Student.new(hash[:name], hash[:grade])
    student.save
    return student
  end

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  
end
