Rails Engine Lite
Mod 3


## Table of Contents
  - [Abstract](#abstract)
  - [Technologies](#technologies)
  - [Schema](#schema)
  - [Install + Setup](#set-up)
  - [Contributors](#contributors)
  - [Wins](#wins)
  - [Improvements](#Improvements)
  - [Project Completion](#project-completion)

## Abstract
- The goals of Rails Engine Lite were to gain a functional understanding of the concept of exposing API endpoints 
- Using serializers to format JSON responses
- Test API exposure in Postman 
- Use SQL and ActiveRecord to gather data.

## Technologies
- Ruby on Rails
- RSPEC
- Postman 
- Factory_bot_rails Gem
- Faker Gem 
- jsonapi-serializer Gem

## Schema

![Schema](https://user-images.githubusercontent.com/44381885/187950272-e4efad4f-9964-4c11-a066-d46da2591846.png)


## Install + Setup
- To run Rails Engine Lite:
  - $rails s in terminal to set up server
  - Use Postman to expose API endpoints:
    - http://localhost:3000/api/v1/merchants
    - http://localhost:3000/api/v1/merchants/{{merchant_id}}
    - http://localhost:3000/api/v1/merchants/{{merchant_id}}/items
    - http://localhost:3000/api/v1/items
    - http://localhost:3000/api/v1/items/{{item_id}}
    - http://localhost:3000/api/v1/items/{{item_id}}/merchant
    - http://localhost:3000/api/v1/merchants/find?name=iLl
    - http://localhost:3000/api/v1/items/find_all?name=hArU

## Contributors
- [Michael Koulouvaris](https://github.com/mikekoul)

## Wins
- Successfully built and tested an API from scratch 
- Gain confidence in testing happy and sad paths 
- Splitting responsiblities in RESTful convention
- Properly using namespacing and resouces when building routes
- Successfully using serializers for the first time

## Improvements
- Currently no known bugs
- Continue to build out the remaining endpoints

## Project Completion 
  - Part 1
    - 1a. Merchants - Completed. All happy and sad paths tested
    - 1b. Items - Completed. All happy and sad paths tested
    - Extensions - Get one Merchant Edge Case   
  - Part 2
    - Set One
      - Happy Path, Sad Path - Completed. All happy and sad paths tested
      - Extenstions - Completed. All edge cases tested  
 



