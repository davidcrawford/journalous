class PromptsController < ApplicationController
  before_filter :authenticate
  
  # GET /prompts
  # GET /prompts.xml
  def index
    get_prompt_lists

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @prompts }
    end
  end
  
  def list
    get_prompt_lists
    
    render :partial => 'prompt_list'
  end

  # GET /prompts/1
  # GET /prompts/1.xml
  def show
    @prompt = Prompt.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @prompt }
    end
  end
  
  def answer
    prompt = Prompt.find_by_id(params[:id])
    if prompt.nil?
      render  :json => { :error => "You must include a prompt id" }.to_json,
              :status => 400
      return
    end

    if !params[:answer] || params[:answer][:content].blank?
      render  :json => { :error => "You must include a non-empty 'content' field" }.to_json,
              :status => 400
      return
    end
    
    answer = current_user.answer prompt, params[:answer][:content]
    render :json => answer.to_json
  end

  # GET /prompts/new
  # GET /prompts/new.xml
  def new
    @prompt = Prompt.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @prompt }
    end
  end

  # GET /prompts/1/edit
  def edit
    @prompt = Prompt.find(params[:id])
  end

  # POST /prompts
  # POST /prompts.xml
  def create
    @prompt = Prompt.new(params[:prompt])

    respond_to do |format|
      if @prompt.save
        format.html { redirect_to(@prompt, :notice => 'Prompt was successfully created.') }
        format.xml  { render :xml => @prompt, :status => :created, :location => @prompt }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @prompt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /prompts/1
  # PUT /prompts/1.xml
  def update
    @prompt = Prompt.find(params[:id])

    respond_to do |format|
      if @prompt.update_attributes(params[:prompt])
        format.html { redirect_to(@prompt, :notice => 'Prompt was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prompt.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /prompts/1
  # DELETE /prompts/1.xml
  def destroy
    @prompt = Prompt.find(params[:id])
    @prompt.destroy

    respond_to do |format|
      format.html { redirect_to(prompts_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def get_prompt_lists
    @prompts = Prompt.all
    
    @answered = {}
    @prompts.each do |prompt|
      answer = current_user.answer_for prompt
      if !answer.nil?
        @answered[prompt] = answer
      end
    end
    
    @answered.each do |prompt, answer|
      @prompts.delete prompt
    end
  end

end
