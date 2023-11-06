class DirectorsController < ApplicationController
  
  def update
    # Get the ID out of params
    m_id = params.fetch("the_id")

    # Look up the existing record
    matching_records = Director.where({ :id => m_id })
    the_actor = matching_records.at(0)

    # Overwrite each column with the values from user inputs
    the_actor.name= params.fetch("the_name")
    the_actor.dob = params.fetch("the_dob")
    the_actor.bio = params.fetch("the_bio")
    the_actor.image = params.fetch("the_image")

    # Save

    the_actor.save

    # Redirect to the movie details page
    redirect_to("/directors/#{the_actor.id}")
  end


  def create

    the_actor = Director.new
    the_actor.name= params.fetch("the_name")
    the_actor.dob = params.fetch("the_dob")
    the_actor.bio = params.fetch("the_bio")
    the_actor.image = params.fetch("the_image")


    the_actor.save

    redirect_to("/directors")
  end

  def destroy
    the_id = params.fetch("an_id")

    matching_records = Director.where({ :id => the_id })

    the_actor = matching_records.at(0)

    the_actor.destroy

    redirect_to("/directors")
  end
  
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
end
