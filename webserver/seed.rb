#connect to db
require './config/environments' #database configuration

#load models
Dir["./models/*.rb"].each { |file| require file }

User.create( email: "test1@test.com", name: "Joe Doe", password: "test", password_confirmation: "test",
location: "New York", dev_type: "Web", blurb: "I am a test account", skill1: "Java", employer: true)

User.create( email: "test2@test.com", name: "Stevey", password: "test", password_confirmation: "test",
location: "New York", dev_type: "Mobile", blurb: "I am a test account", skill1: "Java", skill2: "XML", employer: false)

User.create( email: "test3@test.com", name: "Stevey", password: "test", password_confirmation: "test",
location: "New York", dev_type: "Data Science", blurb: "I am a test account", skill1: "Java", skill2: "R", skill3: "Scala", employer: false)
