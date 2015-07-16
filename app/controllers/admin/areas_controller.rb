class Admin::AreasController < Admin::BaseController
  before_action :set_area, only: [:show, :edit, :update, :destroy, :asignar_user]

  # GET /areas
  # GET /areas.json
  def index
    @areas = Area.all
    respond_to do |format|
      format.html

      format.json{ render json: @areas }
    end
  end

  # GET /areas/1
  # GET /areas/1.json
  def show    
    respond_to do |format|
      format.html
      format.json{ render json: @area.to_json(:include => [:userasignaciones => {:include => [:user] } ] ) }
    end
  end

  # GET /areas/new
  def new
    @area = Area.new
  end

  # GET /areas/1/edit
  def edit
  end

  # POST /areas
  # POST /areas.json
  def create
    @area = Area.new(area_params)

    respond_to do |format|
      if @area.save
        format.html { redirect_to(:controller=>:areas, notice: 'Area was successfully created.') }
        format.json { render :show, status: :created, location: @area }
      else
        format.html { render :new }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areas/1
  # PATCH/PUT /areas/1.json
  def update
    respond_to do |format|
      if @area.update(area_params)
        format.html { redirect_to controller: :areas, action: :asignacion, notice: 'Area ha sido actualizada exitosamente.' }
        format.json { render :show, status: :ok, location: @area }
      else
        format.html { render :edit }
        format.json { render json: @area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areas/1
  # DELETE /areas/1.json
  def destroy
    @area.destroy
    respond_to do |format|
      format.html { redirect_to(:controller=>:areas, notice: 'Area was successfully destroyed.') }
      format.json { head :no_content }
    end
  end

  def asignacion
  	 
  end

  def destroy_asignacion
    u = Userasignacion.find(params[:asignacion_id])
    u.destroy

    respond_to do |format|
      format.json { head :no_content }
    end
  end

  def asignar_user
    @user = User.find(asignar_user_params[:id])
    @asignacion = @area.userasignaciones.create(user: @user)
    respond_to do |format|
      format.json{ render json: @asignacion}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_area
      @area = Area.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def area_params
      params.require(:area).permit(:nombre)
    end

    def asignar_user_params
      params.require(:user).permit(:id)
    end

end