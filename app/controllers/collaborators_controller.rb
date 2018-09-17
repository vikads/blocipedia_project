class CollaboratorsController < ApplicationController

  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.find_by_email(params[:collaborator][:user])

    if User.exists?(@user)
      if @user == current_user
        flash[:alert] = "You can not be the collaborator, you are the wiki owner."
        redirect_to @wiki
      elsif @wiki.users.include?(@user)
        flash[:alert] =  "User is alredy a collaborator"
        redirect_to @wiki
      else
        @collaborator = @wiki.collaborators.new(wiki_id: @wiki.id, user_id: @user.id)

        if @collaborator.save
          flash[:notice] = "Collaborator \"#{@collaborator.user.email}\ added to the list of collaborators."
        else
          flash[:alert] = "Error occured. Please try again."
        end
        redirect_to @wiki
      end

    else
      flash[:alert] = "User does not exist"
      redirect_to @wiki
    end
  end


  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = Collaborator.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator \"#{@collaborator.user.email}\ deleted from the list of collaborators."
      redirect_to @wiki
    else
      flash[:alert] = "Error occured"
      redirect_to @wiki
    end
  end

end
