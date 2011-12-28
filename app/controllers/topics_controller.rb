class TopicsController < ApplicationController
  before_filter :login_from_cookie
  before_filter :login_required, :except => [:login],:only=>[:new,:index,:create,:update,:edit,:show,:destroy]
  # GET /topics
  # GET /topics.json
  def index
    @topics = Topic.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @record = Topic.find(params[:id])
    @comment = Comment.new
    @comment.resource = @record
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @record }
    end
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(params[:topic])

    respond_to do |format|
      if @topic.save
        format.html { redirect_to @topic, notice: t("helpers.create_info",:model=>t('activerecord.models.topic')) }
        format.json { render json: @topic, status: :created, location: @topic }
      else
        format.html { render action: "new" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to @topic, notice: t("helpers.update_info",:model=>t('activerecord.models.topic')) }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to topics_url }
      format.json { head :ok }
    end
  end
  
  #获取最新记录
  def get_new_topic
    if params[:topic_id] && params[:topic_id] != "0"
      @topics = Topic.select("topics.id,title,price,place,latlng,photo_id,comments_count,flags_count,cheers_count,cached_tag_list,user_id,topics.created_at,users.name").joins("left join users on (topics.user_id = users.id)").where(["topics.id > ? ",params[:topic_id]]).order("topics.id asc")
    else
      @topics = Topic.select("topics.id,title,price,place,latlng,photo_id,comments_count,flags_count,cheers_count,cached_tag_list,user_id,topics.created_at,users.name").joins("left join users on (topics.user_id = users.id)").order("topics.idid desc").limit(10)
      @topics.reverse!
    end
    render :json=>@topics.to_json
  end
  
  #获取后10条
  def get_last_topic
    if params[:topic_id] && params[:topic_id] != "0"
      @topics = Topic.select("topics.id,title,price,place,latlng,photo_id,comments_count,flags_count,cheers_count,cached_tag_list,user_id,topics.created_at,users.name").joins("left join users on (topics.user_id = users.id)").where(["topics.id < ? ",params[:topic_id]]).order("topics.id desc").limit(10)
    else
      @topics = []
    end
    render :json=>@topics.to_json
  end
end
