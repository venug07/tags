class TagsController < ApplicationController
  skip_before_action :verify_authenticity_token


  def create
  	@entity_tag = Tag.where("name = ? and entity_id = ? and entity_type = ?",tag_params[:name],tag_params[:entity_id],tag_params[:entity_type]).first
	if @entity_tag.present?
       render json: @entity_tag
    else   
    @tag = Tag.new(tag_params)
    if @tag.save
      render json: @tag
    else
      render json: "Not able to create Tag", status: 403
    end
   end
  end

  def get_entity_tags
    @tags = Tag.where("entity_id = ? and entity_type = ?",params[:entity_id],params[:entity_type])
    render json: @tags
  end

  def delete_entity_tag
    @tags = Tag.where("entity_id = ? and entity_type = ?",params[:entity_id],params[:entity_type])
    if @tags.destroy_all
      render json: "Succesfully deleted entity and tags"
    end
  end

  def tag_statistics
    @statistics = Tag.all.group("name").select("name","count(name) as count")
    render json: @statistics.as_json(:except => [:id])
  end

  def entity_wise_statistics
    @statistics = Tag.where("entity_type = ? and entity_id = ?",params[:entity_type],params[:entity_id]).group("name").select("name","count(name) as count")
    render json: @statistics.as_json(:except => [:id])
  end	

  private

  def tag_params
    params.require(:tag).permit(:name,:entity_id,:entity_type)
  end
end
