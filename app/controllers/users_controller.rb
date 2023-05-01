class UsersController < ApplicationController
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :username => :asc })

    render({ :template => "user_templates/index.html.erb" })
  end

  def show
    url_username = params.fetch("path_username")

    matching_usernames = User.where({ :username => url_username })

    @the_user = matching_usernames.first

    if @the_user == nil
      redirect_to("/404")
    else
      render({ :template => "user_templates/show.html.erb"})
    end
  end

  def new_user
    new_username = params.fetch("query_username")

    the_user = User.new

    the_user.username = new_username

    the_user.save

    redirect_to("/users/" + the_user.username.to_s)
  end

  def update_user
    url_username = params.fetch("path_username")

    new_username = params.fetch("query_username")

    matching_users = User.where({ :username => url_username })

    the_user = matching_users.first

    the_user.username = new_username

    the_user.save

    redirect_to("/users/" + new_username.to_s)
  end
end
