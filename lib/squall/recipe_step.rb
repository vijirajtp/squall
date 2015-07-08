module Squall
  # OnApp Recipe steps
  class RecipeStep < Base

  	# Get the List of Recipe Steps
    #
    # Returns an Array.
    def recipe_steps(id)
    	req = request(:get, "/recipes/#{id}/recipe_steps.json")
      req.collect { |r| r['recipe_step'] }
    end

    # Create Recipe Step
    #
    # options - Params for creating the recipe steps
    #           script              - recipe step code
    #           result_source       - specify the step result source (exit_code, std_out, std_err, std_out_and_std_err)
    #           pass_anything_else  - set true, if you have specified the recipe fail value, otherwise set false
    #           pass_values         - step pass value
    #           on_success          - specify the step behavior in case of success: (proceed, fail, stop, go_to_step)
    #           success_goto_step   - if the on_success parameter = go to step, specify the step to proceed to. If you specify the nonexistent step, the recipe will be stopped.
    #           fail_anything_else  - set true, if you have specified the recipe pass value, otherwise set false
    #           fail_values         - specify step fail value
    #           on_failure          - step behavior in case of failure: (proceed, fail, stop, go_to_step)
    #           failure_goto_step   - if the on_failure parameter = go to step, specify the step to proceed to. If you specify the nonexistent step, the recipe will be stopped.
    #
    # Returns a hash
    def create(id, options = {})
      optional = [:result_source,
                  :pass_anything_else,
                  :pass_values,
                  :on_success,
                  :success_goto_step,
                  :fail_anything_else,
                  :fail_values,
                  :on_failure,
                  :failure_goto_step
      ]
      params.required(:script).accepts(optional).validate!(options)
      response = request(:post, "/recipes/#{id}/recipe_steps.json", default_params(options))
      response['recipe_step']
    end

    # Edit Recipe Step
    #
    # id               - ID of the recipe
    # receipe_step_id  - ID of the recipe step
    #
    # options - Params for creating recipe step, see 'create' method
    #
    # Returns a Hash.
    def edit(id, recipe_step_id, options = {})
    	optional = [:script,
    							:result_source,
                  :pass_anything_else,
                  :pass_values,
                  :on_success,
                  :success_goto_step,
                  :fail_anything_else,
                  :fail_values,
                  :on_failure,
                  :failure_goto_step
      ]
    	params.accepts(optional).validate! options
    	response = request(:put, "/recipes/#{id}/recipe_steps/#{recipe_step_id}.json", default_params(options))
    	response['status']
    end

    # Remove Recipe Step
    #
    # id               - ID of a recipe the step belongs to
    # recipe_step_id   - ID of a step to remove
    #
    # Returns a Hash.
    def delete(id, recipe_step_id)
    	request(:delete, "/recipes/#{id}/recipe_steps/#{recipe_step_id}.json")
    end

    # Interchange recipe steps locations
    #
    # id               - ID of the recipe
    # receipe_step_id  - ID of the recipe step
    # step_num         - specify recipe step number to which you want to move
    #
    def swap_recipe_step(id, recipe_step_id, step_num)
      request(:put, "/recipes/#{id}/recipe_steps/#{recipe_step_id}/move_to/#{step_num}.json")
    end

  end
end