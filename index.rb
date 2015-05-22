require 'sinatra'
require 'json'
# Assets
questionString = '{"question":"Favourite programming language?", "published_at":"2014-11-11T08:40:51.620Z", "url":"/questions/1", "choices":[{"choice":"Swift", "url":"/questions/1/choices/1", "votes":2048}, {"choice":"Python", "url":"/questions/1/choices/2", "votes":1024}, {"choice":"Objective-C", "url":"/questions/1/choices/3", "votes":512}, {"choice":"Ruby", "url":"/questions/1/choices/4", "votes":256}]}'
questionsString = '[{"question":"Favourite programming language?", "published_at":"2014-11-11T08:40:51.620Z", "url":"/questions/1", "choices":[{"choice":"Swift", "url":"/questions/1/choices/1", "votes":2048}, {"choice":"Python", "url":"/questions/1/choices/2", "votes":1024}, {"choice":"Objective-C", "url":"/questions/1/choices/3", "votes":512}, {"choice":"Ruby", "url":"/questions/1/choices/4", "votes":256}]}]'
question = JSON.parse(questionString)
questions = JSON.parse(questionsString)
# Polls API Root
# Retrieve the Entry Point
get '/' do
  content_type :json
  { :questions_url => '/questions' }.to_json
end
# Group Question
# Question
# View a Questions Detail
get '/questions/:question_id' do
  content_type :json
  question.to_json
end
# Choice
# Vote on a Choice
post '/questions/:question_id/choices/:choice_id' do
  status 201
  response.headers['Location'] = "/questions/#{params['question_id']}"
  ""
end
# Questions Collection
# List All Questions
get '/questions' do
  pageId = Integer(params['page']) + 1
  response.headers['Link'] = "</questions?page=#{pageId}>; rel=\"next\""
  content_type :json
  questions.to_json
end
# Create a New Question
post '/questions' do
  content_type :json
  status 201
  response.headers['Location'] = '/questions/2'
  question.to_json
end
