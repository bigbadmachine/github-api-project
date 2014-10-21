github-api-project
=================
by: Scott Shervington


Assignment: Using the GitHub Search API, implement a basic web app that queries repositories based on user input and displays the following data / options:

Business Requirements:
- A list of the results along with the programming language for that repo
- A filtering of the results based on the languages returned (can use AJAX or make separate requests)
- Sort by stars in either asc or desc order
- Pagination, if available
- Persist the user's information upon logging in to the app in a DB

Technical Requirements:
- Use Ruby on Rails or similar framework (Django, NodeJS, etc). No oddball languages.
- Push code to GitHub public repo
- While the GitHub search API is public and can be used without authentication, you must authenticate your user and make authenticated requests. Tools like Omniauth / Devise might be useful.
- It must be deployed to either a micro EC2 instance or Heroku Instance
- While we won't be too picky on the front end, ideally the app should be presentable. A basic Bootstrap or Foundation theme is perfect
