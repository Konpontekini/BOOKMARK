require 'pry'
class ItemsController < ApplicationController
  before_action :find_item, only: [:update, :edit, :show, :destroy, :category]
  before_action :scrape, only: [:create]

  def index
    if params[:sort].present?
      @items = Item.all.order(params[:sort])
    if params[:query].present?
      sql_query = "name ILIKE :query OR description ILIKE :query"
      @items = Item.where(sql_query, query: "%#{params[:query]}%")
    else
      @items = Item.all
    end
  end

  def new
    @item = Item.new
  end

  def show
  end

  def create
    @item = Item.new(@attributes)
    @item.user = current_user
    @category = Category.find(params[:item][:category_id])
    @item.category = @category
    @item.save!
    redirect_to items_path
  end

  def edit
  end

  def purchased
    @item.purchased? == true
  end

  def update
    if @item.update(item_params)
      # redirect_to item_path(@item)
      redirect_to items_path
    else
      render :index
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path
  end

  private

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:category_id, :item_url, :sort, :name, :created_at, :price, :purchased, :description)
  end
end


  def scrape
    @url = params[:item][:item_url]
    html_file = URI.open(@url).read
    html_doc = Nokogiri::HTML(html_file)

    if @url.include?('etsy')
      name = html_doc.search('.wt-text-body-03.wt-line-height-tight.wt-break-word').text.strip
      description = html_doc.search("#product-details-content-toggle > div > ul").text.strip
      price = html_doc.search('.wt-text-title-03.wt-mr-xs-2').text.strip
      elements = []
      html_doc.search('.wt-position-absolute.wt-width-full.wt-height-full.wt-position-top.wt-position-left.carousel-pane img').each do |element|
        image = element["src"]
        elements << image
      end
      image_url = elements[0]
    else
      # Mytheresa
      name_brand = html_doc.search('.product-designer span a').text.strip
      name_product = html_doc.search('.product-name span').text.strip
      name = "#{name_brand} - #{name_product}"
      description = html_doc.search('.pa1.product-description').text.strip
      price = html_doc.search('.price-box span span').first.text.strip
      elements = []
      html_doc.search('.gallery-image').each do |element|
        image = "https:#{element["src"]}"
        elements << image
      end
      image_url = elements[0]
    end

    @attributes = {
      name: name,
      item_url: @url,
      price: price,
      description: description,
      image_url: image_url
    }
  end
end
