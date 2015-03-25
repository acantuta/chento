class Admin::MovaccionesController < ApplicationController
  before_action :set_admin_movaccion, only: [:show, :edit, :update, :destroy]

  # GET /admin/movacciones
  # GET /admin/movacciones.json
  def index
    @admin_movacciones = Movaccion.all
  end

  # GET /admin/movacciones/1
  # GET /admin/movacciones/1.json
  def show
  end

  # GET /admin/movacciones/new
  def new
    @admin_movaccion = Movaccion.new
  end

  # GET /admin/movacciones/1/edit
  def edit
  end

  # POST /admin/movacciones
  # POST /admin/movacciones.json
  def create
    @admin_movaccion = Movaccion.new(admin_movaccion_params)

    respond_to do |format|
      if @admin_movaccion.save
        format.html { redirect_to [:admin,@admin_movaccion], notice: 'Movaccion was successfully created.' }
        format.json { render :show, status: :created, location: @admin_movaccion }
      else
        format.html { render :new }
        format.json { render json: @admin_movaccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/movacciones/1
  # PATCH/PUT /admin/movacciones/1.json
  def update
    respond_to do |format|
      if @admin_movaccion.update(admin_movaccion_params)
        format.html { redirect_to @admin_movaccion, notice: 'Movaccion was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_movaccion }
      else
        format.html { render :edit }
        format.json { render json: @admin_movaccion.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/movacciones/1
  # DELETE /admin/movacciones/1.json
  def destroy
    @admin_movaccion.destroy
    respond_to do |format|
      format.html { redirect_to admin_movacciones_url, notice: 'Movaccion was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_movaccion
      @admin_movaccion = Movaccion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_movaccion_params
      params.require(:movaccion).permit(:nombre)
    end
end
