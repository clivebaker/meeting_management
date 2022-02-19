class MasterSlideTemplatesController < ApplicationController
  before_action :set_master_slide_template, only: %i[ show edit update destroy ]

  # GET /master_slide_templates or /master_slide_templates.json
  def index
    @master_slide_templates = MasterSlideTemplate.all
  end

  # GET /master_slide_templates/1 or /master_slide_templates/1.json
  def show

    @tags = Mustache::Template.new(@master_slide_template.content.to_s).tags
    
    #Mustache.render(@email_template.subject.to_s, @input)


  end

  # GET /master_slide_templates/new
  def new
    @master_slide_template = MasterSlideTemplate.new
  end

  # GET /master_slide_templates/1/edit
  def edit
  end

  # POST /master_slide_templates or /master_slide_templates.json
  def create
    @master_slide_template = MasterSlideTemplate.new(master_slide_template_params)

    respond_to do |format|
      if @master_slide_template.save
        format.html { redirect_to master_slide_template_url(@master_slide_template), notice: "Master slide template was successfully created." }
        format.json { render :show, status: :created, location: @master_slide_template }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @master_slide_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /master_slide_templates/1 or /master_slide_templates/1.json
  def update
    respond_to do |format|
      if @master_slide_template.update(master_slide_template_params)
        format.html { redirect_to master_slide_template_url(@master_slide_template), notice: "Master slide template was successfully updated." }
        format.json { render :show, status: :ok, location: @master_slide_template }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @master_slide_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /master_slide_templates/1 or /master_slide_templates/1.json
  def destroy
    @master_slide_template.destroy

    respond_to do |format|
      format.html { redirect_to master_slide_templates_url, notice: "Master slide template was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_master_slide_template
      @master_slide_template = MasterSlideTemplate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def master_slide_template_params
      params.require(:master_slide_template).permit(:name, :content, :enabled)
    end
end