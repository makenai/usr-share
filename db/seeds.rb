# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

User.destroy_all
User.create!(
  :name     => "Pawel",
  :email    => "pawel@zappos.com",
  :password => 'changeme',
  :admin    => true
)

Location.destroy_all
usrlib = Location.create!(
  :name      => '/usr/lib',
  :address_1 => '520 E. Fremont St. #200',
  :city      => 'Las Vegas',
  :state     => 'NV',
  :postal    => '89144',
  :country   => 'USA',
  :phone     => '(702) 518-0098',
  :hours     => "Mon-Fri 7 am - 12 am\nSat 9 am - 12 am\nSun 9 am - 5 pm"
)

Room.destroy_all
Room.create(
  :name        => 'Meeting Room',
  :location_id => usrlib.id,
  :capacity    => 30
)

MediaType.destroy_all
MediaType.create( :name => 'Book' )

Media.destroy_all
Media.create(
  :title => 'Agile Web Development with Rails',
  :description => "Rails has evolved over the years, and this book has evolved
  along with it. We still start with a step-by-step walkthrough of building a
  real application, and in-depth chapters look at the built-in Rails features.
  This edition now gives new Ruby and Rails users more information on the Ruby
  language and takes more time to explain key concepts throughout. Best
  practices on how to apply Rails continue to change, and this edition keeps
  up. Examples use cookie backed sessions, HTTP authentication, and Active
  Record-based forms, and the book focuses throughout on the right way to use
  Rails. Additionally, this edition now reflects Ruby 1.9, a new release of
  Ruby with substantial functional and performance improvements."
  )

Media.create(
  :title => 'How To Win Friends and Influence People',
  :description => "One of the best known motivational books in history: Since
  it was released in 1936, How to Win Friends and Influence People has sold
  more than 15 million copies. Carnegies first book is timeless and appeals
  equally to business audiences, self-help audiences, and general readers
  alike. Proven advice for success in life: Carnegie believed that most
  successes come from an ability to communicate effectively rather than from
  brilliant insights. His book teaches these skills by showing readers how to
  value others and make them feel appreciated rather than manipulated. As
  relevant as ever before: In the age of Steven Covey and Tony Robbins, Dale
  Carnegies principles endure. The original edition was published in response
  to the Great Depression, and this fresh hardcover edition will appeal now
  more than ever to readers wanting tried and true advice on how to deal with
  a depressed economy. Readers can learn how to get the job they want, improve
  the job they have, and make the best of any situation."
  )
  
Media.create(
  :title => 'Crafting Rails Applications: Expert Practices for Everyday Rails Development',
  :description => "Rails Core developer Jose Valim guides you through seven
  different tutorials, each of them using test-driven development to build a
  new Rails extension or application that solves common problems with these
  new APIs. You will understand how the Rails rendering stack works and
  customize it to read templates from the database while you learn how to
  mimic Active Record behavior, like validations, in any other object. You
  will find out how to write faster, leaner controllers, and you'll learn how
  to mix Sinatra applications into your Rails apps, so you can choose the most
  appropriate tool for the job. In addition, you will improve your
  productivity by customizing generators and responders. This book will help
  you understand Rails 3's inner workings, including generators, template
  handlers, internationalization, routing, and responders. With the knowledge
  you'll gain, you'll be ready to tackle complicated projects more easily than
  ever before, creating solutions that are well-tested, modular, and easy to
  maintain." )



MediaLocation.destroy_all
MediaLocation.create( :name => 'On Order',   :available => false )
MediaLocation.create( :name => 'Processing', :available => false )
MediaLocation.create( :name => 'Shelved',    :available => true )

