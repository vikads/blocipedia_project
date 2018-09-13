class CollaboratorsController < ApplicationController

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find_by_email(params[:collaborator])

    if User.exists?(@user)
      @collaborator = @wiki.collaborators.new(wiki_id: @wiki.id, user_id: @user.id)

      if @collaborator.save
        flash[:notice] = "Collaborator added."
      else
        flash.now[:alert] = "Error occured. Please try again."
      end
      redirect_to @wiki

    else
      flash.now[:alert] = "User does not exist"
      redirect_to @wiki
    end
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator deleted"
      redirect_to @wiki
    else
      flash.now[:alert] = "Error occured"
      redirect_to @wiki
    end
  end

end
