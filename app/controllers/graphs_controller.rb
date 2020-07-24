class GraphsController < ApplicationController
  
  require 'pycall/import'
  include PyCall::Import
  require 'numpy'
  np = Numpy
  
  def index
    require 'pg'
    
    # データベース接続する
    connection = PG::connect(host: "localhost", user: "yondo", dbname: "Calmania_development", port: "5432")
    begin
      result = connection.exec("SELECT * FROM User")
    ensure
      # データベースへのコネクションを切断する
      connection.finish
    end
    @user = result.find(params[:id])
    
    

    plt.title('height graph')
    plt.xlabel('measurement date')
    plt.ylabel('height')
    plt.plot([70,60,50,90])
    @graph = plt.show()

  end

end
