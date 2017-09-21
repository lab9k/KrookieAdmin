require 'net/http'
require 'json'

class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @query = 'http://zoeken.oost-vlaanderen.bibliotheek.be/api/v0/search/?q=isbn:' + params[:book][:isbn] + '&authorization=f2c359618130a698cca2e6b2736ab9fc'
    uri = URI(@query)
    req = Net::HTTP.get(uri)
    book_json = JSON.parse(Hash.from_xml(req).to_json)
    if(book_json.key?('aquabrowser'))
      args = book_json['aquabrowser']['results']['result']
    end
    test = {}
    test['isbn'] = params[:book][:isbn]
    if(args.key?('authors'))
      test['author'] = args['authors']['main_author']
    else
      test['author'] = ""
    end

    if(args.key?('titles'))
      test['title'] = args['titles']['title']
    else
      test['title'] = ""
    end

    if(args.key?('genres'))
      test['category'] = args['genres']['genre'][0]
    else
      test['category'] = ""
    end

    if(args.key?('target_audiences'))
      test['readingskill'] = args['target_audiences']['target_audience'][0].tr('age', '').gsub(/-.*/, '')
    else
      test['readingskill'] = "12"
    end

    @shelf = Shelf.find(params[:shelf_id])
    @book = @shelf.books.create(test)
    @book.save
    redirect_to shelf_path(@shelf)
  end

  def destroy
    @book = Book.find(params[:shelf_id])
    @book.destroy
  end

  private
    def book_params
      params.require(:book).permit(:isbn)
    end
end
