# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should (not )?see the movie: "(.*)"/ do |inv, m1|
  if inv then
    page.body.include?(m1).should be_false
  else 
    page.body.include?(m1).should be_true
  end
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see all the movies/ do 
  exp_lines = Movie.all.count + 1
  page.all('table#movies tr').count.should == exp_lines
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  if page.body.include?(e1) && page.body.include?(e2) && page.body.index(e1) < page.body.index(e2)
  then
    1.should == 1
  else
    1.should == 2 
  end
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |unch, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(', ').each do |rating|
    if unch
      uncheck('ratings_'+rating)
    else
      check('ratings_'+rating)
    end 
  end
end

When /I press Refresh/ do
  click_button('ratings_submit')
end
