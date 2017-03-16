def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.

  Actor.joins(:movies)
    .where("actors.name IN (?)", those_actors)
    .select("movies.id, movies.title")
    .group("movies.id")
    .having("COUNT(actors.id) = ?", those_actors.length)

end

def golden_age
  # Find the decade with the highest average movie score.
  Movie.select("(movies.yr / 10) * 10 as decade, AVG(movies.score)")
  .group("decade")
  .order("AVG(movies.score) DESC")
  .limit(1)
  .first
  .decade
end

def costars(name)
  # List the names of the actors that the named actor has ever appeared with.
  # Hint: use a subquery

  subquery = Movie.joins(:actors)
    .where("actors.name = ?", name)
    .select("movies.id")

  Actor.joins(:movies)
    .where("actors.name <> ? AND movies.id IN (#{subquery.to_sql})", name)
    .order("actors.name")
    .uniq
    .pluck("actors.name")
end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor.joins("LEFT OUTER JOIN castings ON castings.actor_id = actors.id")
    .where("castings.actor_id IS NULL")
    .pluck("COUNT(*)").first
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the letters in whazzername,
  # ignoring case, in order.
  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but not like "stallone sylvester" or "zylvester ztallone"
  regex_whazzername = '%' + whazzername.chars.map { |c| "#{c}%" }.join
  Movie.joins(:actors).where("actors.name ILIKE ?", regex_whazzername).order("movies.title").select("movies.*")

end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of their career.
  Actor.joins(:movies)
    .group("actors.id")
    .select("actors.id, actors.name, (MAX(movies.yr) - MIN(movies.yr)) AS career")
    .order("career DESC, actors.name")
    .limit(3)
end
