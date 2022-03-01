require 'open-uri'
require 'nokogiri'

class ItemsController < ApplicationController
  before_action :find_item, only: [:update, :edit, :show, :destroy, :category]
  before_action :scrape, only: [:create]

  def index
    @items = Item.all
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
    params.require(:item).permit(:category_id, :item_url, :name, :price, :description, :purchased)
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


# Farfetch
# name = html_doc.search('#bannerComponents-Container > h1 > span._b4693b._2ef212._b4693b').text.strip
# description = html_doc.search('#panelInner-0 > div > div:nth-child(1) > div._1b910b._ab46e0 > ul')
# price = html_doc.search('#content > div.noTouch > div._89a1a1 > div._b350ae > div._071112 > div._f08199 > div > div > span').text.strip
# elements = []
# html_doc.search('#content > div.noTouch > div._89a1a1 > div._b350ae > div._3bc5b1 > div > div._8a37de._b6b6d1 > div:nth-child(1) > div > div > img').each do |element|
# html_doc.search('.css-u2g8cx-BaseImg e2u0eu40').each do |element|
# image = element["src"]
# elements << image
# end
# image_url = elements[0]

#newchic
# name = html_doc.search('.d-inline.product-info-product-name-js.product-info__product-name').text.strip
# price = html_doc.search(".Product-detail__price").text.strip.t_f

# Etsy - img
# html_doc.search('.wt-list-unstyled.wt-overflow-hidden.wt-position-relative.carousel-pane-list li img').each do |element|
