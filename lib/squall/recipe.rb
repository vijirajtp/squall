module Squall
  # OnApp Recipes
  class Recipe < Base

  	# Returns a list of all Recipes in a Cloud
    #
    # Returns an array
    #
    def list
      req = request(:get, "/recipes.json")
      req.collect { |r| r['recipe'] }
    end

    # Returns a Hash for the given Recipe
    #
    # id - ID of the recipe
    #
    # Returns a Hash
    def show(id)      
      response = request(:get, "/recipes/#{id}.json")
      response.first[1]
    end

    # Add a new Recipe
    #
    # options - Params for creating the recipe
    #           label               - label for the recipe
    #           description         - description for the recipe
    #           compatible_with     - recipe compatiblity (windows or unix)
    #           script_type         - specify script type for windows compatible (bat, vps, powershell)
    #
    # Returns a hash
    def create(options = {})
      optional = [:description,
      			  :compatible_with,
      			  :script_type
      ]
      params.required(:label).accepts(optional).validate!(options)
      response = request(:post, "/recipes.json", default_params(options))
      response['recipe']
    end

    # Edit a Recipe
    #
    # id      - ID of the recipe
    # options - Params for creating recipe, see 'create' method
    #
    # Returns a Hash.
    def edit(id, options = {})
      optional = [:label,
                  :description,
                  :compatible_with,
                  :script_type
      ]
      params.accepts(optional).validate! options
      request(:put, "/recipes/#{id}.json", default_params(options))
    end

    # Delete a Recipe
    #
    # id - ID of the recipe
    #
    # Returns a Hash.
    def delete(id)
      request(:delete, "/recipes/#{id}.json")
    end

  end
end