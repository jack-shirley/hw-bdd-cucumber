Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create(movie)
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  pagebody = page.body
  regexp = /".*#{e1}.*#{e2}"/
  expect(regexp.match(pagebody))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list = rating_list.split(',')
  for rating in rating_list
    if uncheck.nil? || uncheck.empty?
      check("ratings_#{rating}")
    else
      uncheck("ratings_#{rating}")
    end
  end
end

Then /I should see all the movies/ do
  tablesize = page.all(:css, 'table tr').size - 1
  expect(Movie.count).to eq tablesize
end

