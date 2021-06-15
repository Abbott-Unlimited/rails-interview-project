# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'ffaker'

# Random number generator
rand_num = Random.new

Tenant.create(name: FFaker::Company.name, calls_today: 95, calls_lifetime: 1000, last_call: Time.new)

10.times do
  Tenant.create(
    name: FFaker::Company.name,
    calls_today: rand_num.rand(10..150),
    calls_lifetime: rand_num.rand(1200..5000),
    last_call: Time.new - rand_num.rand(0..60).seconds
  )
end

# Users
users = []
20.times do
  users << User.create(name: FFaker::Name.name)
end

# Questions and Answers
20.times do
  question = Question.create(title: FFaker::HipsterIpsum.sentence.gsub(/\.$/, '?'),
                             private: FFaker::Boolean.random, user: users.sample)
  rand(1..3).times do
    question.answers.create(body: FFaker::HipsterIpsum.sentence, user: users.sample)
  end
end
