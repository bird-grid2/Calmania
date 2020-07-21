class GraphsController < ApplicationController

  def index
    @user = User.find(params[:id])
    require 'pycall/import'
    include PyCall::Import
    pyimport 'matplotlib.pyplot', as: 'plt'
    plt.title('height graph')
    plt.xlabel('measurement date')
    plt.ylabel('height')
    plt.plot([70,60,50,90])
    @graph = plt.show()

  end

end
