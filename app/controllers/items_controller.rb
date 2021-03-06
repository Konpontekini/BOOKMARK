class ItemsController < ApplicationController
  before_action :find_item, only: %i[update edit show destroy category purchased unpurchased]
  before_action :scrape, only: [:create]

  def index
    @categories = Category::CATEGORIES
    if params[:sort].present?
      @items = Item.all.order(params[:sort])
    elsif params[:purchased].present?
      @items = Item.where(purchased: true)
    elsif params[:query].present?
      sql_query = "name ILIKE :query OR description ILIKE :query"
      @items = Item.where(sql_query, query: "%#{params[:query]}%")
    elsif params[:filter].present?
      if params[:filter] == "purchased"
        @items = Item.where(purchased: true)
      else
        category = Category.find_by(name: params[:filter])
        @items = Item.where(category: category)
      end
    else
      @items = Item.all
    end
    @items_count = Item.count
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
    if @item.save!
      @item.save!
      redirect_to items_path
    else
      render :new
    end
  end

  def edit
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

  def purchased
    @item.update(purchased: true)
    @item.save!
    redirect_to items_path
  end

  def unpurchased
    @item.update(purchased: false)
    @item.save!
    redirect_to items_path
  end


  private

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:category_id, :item_url, :sort, :name, :created_at, :price, :original_price,
                                 :purchased, :description)
  end

  def scrape
    @url = params[:item][:item_url]
    html_file = URI.open(@url, "Accept-Language" => "en-US").read
    html_doc = Nokogiri::HTML(html_file)

    if @url.include?('etsy')
      name = html_doc.search('.wt-text-body-03.wt-line-height-tight.wt-break-word').text.strip.split(/[.,\-]/).first
      description = html_doc.search("#product-details-content-toggle > div > ul").text.strip
      currency = html_doc.search('.wt-text-title-03.wt-mr-xs-2').text.strip.match(/[?????]/).to_s
      price = html_doc.search('.wt-text-title-03.wt-mr-xs-2').text.strip.match(/\d+.\d{2}/).to_s.sub(".", "").to_i
      original_price = html_doc.search('.wt-text-strikethrough.wt-text-caption.wt-text-gray.wt-mr-xs-1').text.strip.match(/\d+.\d{2}/).to_s.sub(
        ".", ""
      ).to_i
      elements = []
      html_doc.search('.wt-max-width-full.wt-horizontal-center.wt-vertical-center.carousel-image.wt-rounded').first(3).each do |element|
        image = element["data-src-zoom-image"]
        elements << image
      end
      image_url = elements
      # ignore

      @attributes = {
        name: name,
        item_url: @url,
        price: price,
        description: description,
        image_url: image_url,
        original_price: original_price,
        currency: currency
      }

    else
      # Mytheresa
      name_brand = html_doc.search('.product-designer span a').text.strip
      name_product = html_doc.search('.product-name span').text.strip
      name = "#{name_brand} | #{name_product}"
      if html_doc.search('.pa1.product-description').present?
        description = html_doc.search('.pa1.product-description').text.strip
      else
        description = html_doc.search('.pa1-rmm.product-description').text.strip
      end
      if html_doc.search('.price-box .special-price .price').present?
        currency = html_doc.search('.price-box .special-price .price').text.strip.match(/[?????]/).to_s
      else
        currency = html_doc.search('.price-box .regular-price .price').text.strip.match(/[?????]/).to_s
      end
      if html_doc.search('.price-box .special-price .price').present?
        price = html_doc.search('.price-box .special-price .price').first.text.strip.chars.select do |x|
          x.to_i.to_s == x
        end.join.to_i * 100
      else
        price = html_doc.search('.price-box .regular-price .price').first.text.strip.chars.select do |x|
          x.to_i.to_s == x
        end.join.to_i * 100
      end
      if html_doc.search('.price-box .old-price .price').present?
        original_price = html_doc.search('.price-box .old-price .price').first.text.strip.chars.select do |x|
          x.to_i.to_s == x
        end.join.to_i * 100
      end
      elements = []
      html_doc.search('.gallery-image').first(3).each do |element|
        image = "https:#{element['src']}"
        elements << image
      end
      image_url = elements

      if price.negative?
        @attributes = {
          name: name,
          item_url: @url,
          price: original_price,
          description: description,
          image_url: image_url
          # original_price: original_price
        }
      else
        @attributes = {
          name: name,
          item_url: @url,
          price: price,
          description: description,
          image_url: image_url,
          original_price: original_price,
          currency: currency
        }
      end
    end
  end
end
