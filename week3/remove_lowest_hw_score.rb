require 'pry'
gem 'bson'
require 'bson'
require 'mongoid'
require 'moped'

# db = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'school')

Mongoid::Config.connect_to("school") 
# Mongoid.database = Mongo::Client.new('127.0.0.1:27017').db('school') 


class Student
	include Mongoid::Document
	field :id
	field :name
	embeds_many :scores
end

class Score
	include Mongoid::Document
	field :type
	field :score
end

student_homework_score = {}
students = Student.all.each do |student|
	puts "before - #{student.scores.count}"
	hw_scores = (student.scores.where(:type => "homework")).to_a
	hw_to_delete = hw_scores.min
	student.scores.find(hw_to_delete._id).score = nil
	student.save
	puts "after - #{student.scores.count}"
end
