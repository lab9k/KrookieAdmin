require 'net/http'
require 'json'

class BooksController < ApplicationController
  def index
    @books = Book.all

    jsonlist = Array.new
    @books.each do |book|
      jsonlist.push( {
                         "title" => book.title,
                         "isbn" => book.isbn,
                         "url" => book_url(book)
                     })
    end

    respond_to do |format|
      format.html
      format.json { render :json => jsonlist}
    end
  end

  def show
    @book = Book.find(params[:id])

    jsonlist = Array.new
    jsonlist.push( {
                       "title" => @book.title,
                       "isbn" => @book.isbn,
                       "author" => @book.author,
                       "category" => @book.category,
                       "readingskill" => @book.readingskill,
                       "fact" => @book.fact,
                       "mainbeacon" => @book.shelf.mainbeacon,
                       "beacon1" => @book.shelf.beacon1,
                       "beacon2" => @book.shelf.beacon2,
                       "beacon3" => @book.shelf.beacon3
                   })

    respond_to do |format|
      format.html
      format.json { render :json => jsonlist}
    end
  end

  def new
    @shelves = Shelf.all
    @book = Book.new
  end

  def create
    @query = 'http://zoeken.oost-vlaanderen.bibliotheek.be/api/v0/search/?q=isbn:' + params[:ISBN] + '&authorization=f2c359618130a698cca2e6b2736ab9fc'
    uri = URI(@query)
    req = Net::HTTP.get(uri)
    book_json = JSON.parse(Hash.from_xml(req).to_json)
    if(book_json.key?('aquabrowser'))
      args = book_json['aquabrowser']['results']['result']
    end
    test = {}
    test['isbn'] = params[:ISBN]
    if(args.key?('authors'))
      test['author'] = args['authors']['main_author']
    else
      test['author'] = ""
    end

    if(args.key?('awards'))
      test['fact'] = args['awards']['award']
    else
      test['title'] = ""
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

    @shelf = Shelf.find(params[:shelf])
    @book = @shelf.books.create(test)
    @book.save
    redirect_to book_path(params[:ISBN])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
  end

  private
    def book_params
      params.require(:book).permit(:isbn)
    end
end
