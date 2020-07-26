class GraphsController < ApplicationController
  
  
  def index
    require 'pg'
    require 'pycall'

    matplotlib = PyCall.import_module('matplotlib')
    matplotlib.use('Agg')
    plt = matplotlib.pyplot

    os = PyCall.import_module('os')

    dirpath = 'app/assets/images/'
    
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
    plt.plot([70,60,50,110])
    
    plt.savefig(os.path.join(dirpath, "test.png"))
    plt.close()
  end

end
