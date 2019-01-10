This is Ruby on Rails project.
1) Test App
  This app contains following feature as follow :
    Articles
    1) Create New Articles
    2) Update Articles
    3) Destroy Articles
    4) Show Articles

2) Blog App

Model name: Article, class: Article -> Capitalized A and singular

File name: article.rb -> singular and all lowercase

Controller file name: articles_controller.rb, class: ArticlesController -> camel case class name, snake case file name both plural

Views folder: articles

Table name: articles -> plural of model

Model name: User, class: User -> Capitalized U and singular

File name: user.rb -> singular and all lowercase

Controller file name: users_controller.rb, class: UsersController -> camel case class name, snake case file name both plural

Views folder: users

Table name: users -> plural of model

To generate a migration to create a table (in this example articles):

rails generate migration create_articles

To add attributes for the table in the migration file, add the following inside create_table block:

t.string :title

t.text :description

t.timestamps

To run the migration file and create the articles table:

rake db:migrate

OR

bundle exec rake db:migrate

If using Rails 5 -> rails db:migrate

To rollback a migration (undo the last migration):

rake db:rollback

If using Rails 5 -> rails db:rollback

To add a column (example: created_at column) to the articles table:

rails generate migration add_created_at_to_articles

Then within the def change method in the migration file:

add_column :articles, :created_at, :datetime

To add a different column (example: name) to a users table:

rails generate migration add_name_to_users

Then within the def change method in the migration file:

add_column :users, :name, :string

In the above two adding column methods, the first argument is the name of the table, second is the attribute name and third is the type

To create a model file for Article:

- In the app/models folder create a file called article.rb

- Fill it in with the following ->

class Article < ActiveRecord::Base

end

If using Rails 5 ->

class Article < ApplicationRecord

end

To start the rails console:

rails console

To test connection to the articles table:

Article.all # classname.all will list all the articles in the articles table

Then simply type in Article (classname) to view the attributes

To create a new article with attributes title and description:

article = Article.new(title: "This is a test title", description: "This is a test description")

article.save

OR

article = Article.new

article.title = "This is a test title"

article.description = "This is a test description"

article.save

Another method to do the same:

article = Article.create(title: "This is a test title", description: "This is a test description") # This will hit the table right away without needing the article.save line

Edit, Delete and Validations - Text directions and code

To find an article with id 2 and edit it's title:

article = Article.find(2) # Here assumption is article with id of 2 was being looked for

article.title = "This is an edited title"

article.save

To delete an article, example with id 5:

article = Article.find(5)

article.destroy

To add validations presence and length validations to article model for title and description:

class Article < ActiveRecord::Base

validates :title, presence: true, length: {minimum: 3, maximum: 50}

validates :description, presence: true, length: {minimum: 10, maximum: 300}

end

If using Rails 5, the first line above would be -> class Article < ApplicationRecord

To find errors in article object while saving (if it's rolled back):

article.errors.any?

article.errors.full_messages

****************************************************************************************************************
Create New Articles from UI - Text directions and code

In the config/routes.rb file add the following line to add all the routes for articles:

resources :articles

This will add the following routes:

routes path HTTP verb link controller#action

articles index articles GET /articles articles#index

new article new_article GET /articles/new articles#new

create article POST /articles articles#create

edit article edit_article GET /articles/:id articles#edit

update article PATCH /articles/:id articles#update

show article article GET /articles/:id articles#show

delete article DELETE /articles/:id articles#destroy

To create articles controller with a new action, under app/controllers create a file named articles_controller.rb (snake case):

class ArticlesController < ApplicationController

def new

@article = Article.new

end

end

To create a view, under app/views create a folder named articles and within it create a file named new.html.erb then fill in the following:

<h1>Create an article</h1>

<%= form_for @article do |f| %>

<p>

<%= f.label :title %><br/>

<%= f.text_field :title %>

</p>

<p>

<%= f.label :description %><br/>

<%= f.text_area :description %>

</p>

<p>

<%= f.submit %>

</p>

<% end %>

Create action and private article_params method for string parameters in the articles controller (Note: This is not complete):

def create

@article = Article.new(article_params)

@article.save

redirect_to article_path(@article)

end

private

def article_params

params.require(:article).permit(:title, :description)

end
