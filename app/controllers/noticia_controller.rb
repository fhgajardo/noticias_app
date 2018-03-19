class NoticiaController < ApplicationController
  before_action :set_noticium, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only:[:create, :edit, :update, :destroy, :new]


  # GET /noticia
  # GET /noticia.json
  def index
    @noticia = Noticium.limit(10).order(:fecha).reverse_order
  end

  def comentar
    comentario = params[:comentario]
    n = Noticium.find(comentario[:noticium_id])
    h = {
      fecha: comentario[:fecha],
      contenido: comentario[:contenido],
      noticium: n,
      nombre: comentario[:nombre]
    }
    @comentario = Comentario.create(h)


    respond_to do |format|
      if @comentario.save
        format.html { redirect_to n, notice: 'Comentario was successfully created.' }
      else
        format.html { redirect_to n, notice: 'Imposible comentar, faltan parametros'}
        format.json { render json: @comentario.errors, status: :unprocessable_entity }
      end
    end
  end

  def admin
    @noticia = Noticium.all.order(:fecha).reverse_order
  end


  # GET /noticia/1
  # GET /noticia/1.json
  def show
    #@comentario = Comentario.new
    @comentario = @noticium.comentarios.build
  end

  # GET /noticia/new
  def new
    @noticium = Noticium.new
  end

  # GET /noticia/1/edit
  def edit
  end

  # POST /noticia
  # POST /noticia.json
  def create
    @noticium = Noticium.new(noticium_params)

    respond_to do |format|
      if @noticium.save
        format.html { redirect_to @noticium, notice: 'Noticium was successfully created.' }
        format.json { render :show, status: :created, location: @noticium }
      else
        format.html { render :new }
        format.json { render json: @noticium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /noticia/1
  # PATCH/PUT /noticia/1.json
  def update
    respond_to do |format|
      h = {
        cuerpo: noticium_params[:cuerpo],
        bajada: noticium_params[:bajada],
        titular: noticium_params[:titular]
      }
      if @noticium.update(h)
        format.html { redirect_to @noticium, notice: 'Noticium was successfully updated.' }
        format.json { render :show, status: :ok, location: @noticium }
      else
        format.html { render :edit }
        format.json { render json: @noticium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /noticia/1
  # DELETE /noticia/1.json
  def destroy
    @noticium.destroy
    respond_to do |format|
      format.html { redirect_to noticia_url, notice: 'Noticium was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_noticium
      @noticium = Noticium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def noticium_params
      params.require(:noticium).permit(:fecha, :cuerpo, :bajada, :titular)
    end
end
