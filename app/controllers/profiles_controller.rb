class ProfilesController < ApplicationController
  before_action :set_profile, only: [   :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
    @user = User.find(params[:id])
  end

  # GET /profiles/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to "profiles/<%= current_user.id%>/edit", notice: 'Profile was successfully created.' }

      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    @user = User.find(params[:id])
    params.require(:user).permit(:name, :place, :introduction, :images)
    @user.update_attributes(name: params[:user][:name], place: params[:user][:place], introduction: params[:user][:introduction], image: params[:user][:image])

    redirect_to "/profiles/#{@user.id}"
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:title, :content, :image)
    end
end
