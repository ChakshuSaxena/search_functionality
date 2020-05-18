class TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :edit, :update, :destroy]

  # GET /templates
  # GET /templates.json
  def index
    @templates = Template.all
    @users = User.where(nil)
    @users = @users.filter_by_provider(params[:provider]) if params[:provider].present?
    # @users= User.filter(params.slice(:provider))
    @user = User.all
    @provider = User.all.pluck(:provider).uniq
  end

  # GET /templates/1
  # GET /templates/1.json
  def show
  end

  # GET /templates/new
  def new
    @template = Template.new
  end

  # GET /templates/1/edit
  def edit
  end

  # POST /templates
  # POST /templates.json
  def create
    @template = Template.new(template_params)
    @user = User.new()
    respond_to do |format|       params.require(:user).permit(:name, :email, :provider)
     params.require(:user).permit(:name, :email, :provider)

      if @template.save
        format.html { redirect_to @template, notice: 'Template was successfully created.' }
        format.json { render :show, status: :created, location: @template }
      else
        format.html { render :new }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /templates/1
  # PATCH/PUT /templates/1.json
  def update
    respond_to do |format|
      if @template.update(template_params)
        format.html { redirect_to @template, notice: 'Template was successfully updated.' }
        format.json { render :show, status: :ok, location: @template }
      else
        format.html { render :edit }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.json
  def destroy
    @template.destroy
    respond_to do |format|
      format.html { redirect_to templates_url, notice: 'Template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def search
    @parameter = params[:search]
    if @parameter.blank? && !params[:provider1].present? && !params[:provider2].present? && !params[:provider3].present?
      redirect_to(root_path, alert: "Empty field!") and return
    elsif @parameter.blank? && params[:provider1].present? && params[:provider2].present?
      @provider = [params[:provider1],params[:provider2]].map(&:downcase)
      @e = User.where(provider: @provider)
    elsif @parameter.blank? && params[:provider1].present? && params[:provider3].present?
        @provider = [params[:provider1],params[:provider3]].map(&:downcase)
        @f = User.where(provider: @provider)
    elsif @parameter.blank? && params[:provider2].present? && params[:provider3].present?
        @provider = [params[:provider2],params[:provider3]].map(&:downcase)
        @g = User.where(provider: @provider)

    elsif @parameter.blank? && params[:provider1].present?
      @a = User.where(provider: params[:provider1].downcase)

    elsif @parameter.blank?  && params[:provider2].present?
      @b = User.where(provider: params[:provider2].downcase)

    elsif  @parameter.blank?  && params[:provider3].present?
      @c = User.where(provider: params[:provider3].downcase)

    elsif params[:provider1].present? && params[:provider2].present?
      @provider = [params[:provider1],params[:provider2]].map(&:downcase)

    elsif params[:provider1].present? && params[:provider3].present?
      @provider = [params[:provider1],params[:provider3]].map(&:downcase)

    elsif params[:provider2].present? && params[:provider3].present?
      @provider = [params[:provider2],params[:provider3]].map(&:downcase)

    elsif params[:provider2].present?
      @provider = (params[:provider2]).downcase

    elsif params[:provider3].present?
      @provider = (params[:provider3]).downcase

    elsif  params[:provider1].present?
      @provider = (params[:provider1]).downcase          
    else
      @provider = nil
    end

    if @parameter.blank? && params[:provider1].present? && params[:provider2].present? && params[:provider3].present?
      @results = User.all
    elsif @parameter.blank? && params[:provider1].present? && params[:provider2].present?
        @results = @e
    elsif  @parameter.blank? && params[:provider1].present? && params[:provider3].present?
          @results = @f
    elsif @parameter.blank? && params[:provider2].present? && params[:provider3].present?
          @results = @g
            
    elsif @provider.present? && @parameter.present?
      debugger
      @results = User.where(name: @parameter.downcase, provider: @provider)
    elsif @parameter.present? && !@provider.present? 
      debugger
      # @results = User.where(name: @parameter)  
      @results = User.where('lower(name) = ?', params[:search].downcase) if params[:search].present?      
    elsif params[:provider1].present? || params[:provider2].present? || params[:provider3].present?
      @results = @a if  params[:provider1].present?
      @results = @b if  params[:provider2].present?
      @results = @c if  params[:provider3].present?
    else
      @results = User.all
    end
      # a = User.where(name: @parameter, provider: ["spotify","linkedin"])

      # debugger
      # @a = User.all.where(provider: params[:provider].downcase)

      # @filter = User.all.where('lower(provider) LIKE :search', search: @filter_params)
      # @results = @a.where('lower(name) LIKE :search', search: @parameter)
      # @results = User.where('lower(name) LIKE :search', search: @parameter)
      # @results = User.all.where('lower(name) LIKE :search' or 'lower(provider) LIKE :search' or 'lower(email) LIKE :search', search: @parameter)
      # @results = User.all.where("lower(provider) LIKE :search", search: @parameter)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = Template.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def template_params
      params.require(:template).permit(:title, :desc)
    end

    def user_params
      params.require(:user).permit(:name, :email, :provider)
    end

    def filtering_params(params)
      params.slice(:provider)
    end
end
