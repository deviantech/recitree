class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]

  # GET /recipes
  # GET /recipes.json
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to [:edit, @recipe], success: 'Recipe was successfully created - now add steps' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to params[:commit].to_s =~ /Continue/ ? [:edit, @recipe] : @recipe, success: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, success: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    PERMITTED = [:name, steps_attributes: [:position, :action, :notes, :duration, :duration_unit, :id, :_destroy, components_attributes: [:position, :item_type, :item_id, :quantity, :unit, :id, :_destroy]]]

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      @recipe_params ||= begin
        cleaned_params = convert_attribute_params_to_array params.require(:recipe)
        cleaned_params = clean_step_attributes(
          normalize_position_params(:steps_attributes, cleaned_params)
        )

        cleaned_params.permit(PERMITTED)
      end
    end

    def convert_attribute_params_to_array(raw)
      return raw unless raw[:steps_attributes]

      raw[:steps_attributes] = raw[:steps_attributes].values
      raw[:steps_attributes].each do |step|
        next unless step[:components_attributes]
        step[:components_attributes] = step[:components_attributes].values
      end

      raw
    end

    def clean_step_attributes(raw)
      raw[:steps_attributes] = (raw[:steps_attributes] || []).map do |step|
        (step[:components_attributes] || []).each do |component|
          if item = component.delete(:item)
            item_type, item_id = item.split('__')

            if item_id && Component::VALID_TYPES.include?(item_type)
              component[:item_type] = item_type
              component[:item_id] = item_id
            elsif item_id.nil?
              ingredient = Ingredient.create(name: item_type)
              component[:item_type] = ingredient.class.name
              component[:item_id] = ingredient.id
            end
          end
        end

        normalize_position_params :components_attributes, step
      end

      raw
    end

    def normalize_position_params(replace_key, raw)
      steps = (raw[replace_key] || [])
      with_position, without_position = steps.sort_by {|s| s[:position].to_i }.partition {|s| s[:position].to_i > 0 }

      min_position = 0
      with_position.each do |s|
        s[:position] = min_position += 1
      end

      max_position = with_position.any? ? with_position.last[:position] : 0

      without_position.each_with_index do |s, idx|
        s[:position] = max_position + idx + 1
      end

      raw[replace_key] = (with_position + without_position)

      raw
    end
end
