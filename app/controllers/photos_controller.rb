class PhotosController < ApplicationController
  def index
    matching_photos = Photo.all

    @list_of_photos = matching_photos.order({ :created_at => :desc })

    render({ :template => "photo_templates/index.html.erb" })
  end

  def show
    url_id = params.fetch("path_id")

    matching_photos = Photo.where({ :id => url_id })

    @the_photo = matching_photos.first

    if @the_photo == nil
      redirect_to("/404")
    else
      render({ :template => "photo_templates/show.html.erb" })
    end
  end

  def create
    input_image = params.fetch("query_image")

    input_caption = params.fetch("query_caption")

    input_owner_id = params.fetch("query_owner_id")

    a_new_photo = Photo.new

    a_new_photo.image = input_image

    a_new_photo.caption = input_caption

    a_new_photo.owner_id = input_owner_id

    a_new_photo.save

    # render({ :template => "photo_templates/create.html.erb" })

    redirect_to("/photos/" + a_new_photo.id.to_s)
  end

  def update
    url_id = params.fetch("path_id")

    input_image = params.fetch("query_image")

    input_caption = params.fetch("query_caption")

    matching_photos = Photo.where({ :id => url_id })

    the_photo = matching_photos.first

    the_photo.image = input_image

    the_photo.caption = input_caption

    the_photo.save

    # render({ :template => "photo_templates/update.html.erb" })

    redirect_to("/photos/" + the_photo.id.to_s)
  end

  def destroy
    url_id = params.fetch("path_id")

    matching_photos = Photo.where({ :id => url_id })

    the_photo = matching_photos.first

    the_photo.destroy

    # render({ :template => "photo_templates/destroy.html.erb" })

    redirect_to("/photos")
  end

  def comment
    photo_id = params.fetch("query_photo_id")

    comment_author_id = params.fetch("query_author_id")

    comment_body = params.fetch("query_body")

    a_new_comment = Comment.new

    a_new_comment.author_id = comment_author_id

    a_new_comment.body = comment_body

    a_new_comment.photo_id = photo_id

    a_new_comment.save

    redirect_to("/photos/" + a_new_comment.photo_id.to_s)
  end
end
