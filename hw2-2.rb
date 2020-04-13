client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'm101')
grades = client[:grades].find("type" => "homework").sort({student_id:1, score:1})

student_id = nil
grades.each do |grade|
  if student_id != grade["student_id"]
    student_id = grade["student_id"]
    client[:grades].find(_id: grade[:_id]).delete_one
  end
end