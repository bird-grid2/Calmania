class GraphsController < ApplicationController
  require 'pycall'
  require 'pycall/import'
  extend PyCall::Import
  require 'matplotlib'
  require 'matplotlib/pyplot'
  require 'numpy'
  before_action :authenticate_user!
  before_action :reset_graph, only: :index
  before_action :set_graph, only: :index
  before_action :reset_cache, only: :index

  def index; end

  private

  def reset_graph
    os = PyCall.import_module('os')
    @user = User.find(current_user.id)
    
    if Rails.env.development?
      dirpath = "app/assets/images/"
    elsif Rails.env.production?
      dirpath = os.getcwd()
      dirpath += "/app/assets/images/"
    end

    return if File.exist?(os.path.join(dirpath, "test_#{@user.id}.png")) == false
    os.remove(os.path.join(dirpath, "test_#{@user.id}.png"))
    os.remove(os.path.join(dirpath, "test_#{@user.id}_1.png"))
    os.remove(os.path.join(dirpath, "test_#{@user.id}_2.png"))
    os.remove(os.path.join(dirpath, "test_#{@user.id}_3.png"))
  end

  def set_graph
    matplotlib = Matplotlib
    matplotlib.use('Agg')
    plt = matplotlib::Pyplot
    np = Numpy
    os = PyCall.import_module('os')
    @user = User.find(current_user.id)
    
    if Rails.env.development?
      dirpath = "app/assets/images/"
    elsif Rails.env.production?
      dirpath = os.getcwd()
      dirpath += "/app/assets/images/"
    end

    result = Log.where(user_id: current_user.id).includes(:user).order(date: 'ASC')
    height = User.find(current_user.id).height
    date = []
    weight = []
    total = []
    fat = []
    bmi = []

    result.each do |w|
      date << w.date.strftime("%m/%d").to_s
      weight << w.weight.to_s
      total << w.total_cal.to_s
      fat << w.bfp.to_s
      bmi << (w.weight / ((height / 100) ** 2)).to_s
    end

    x = np.array(date)
    y = np.array(weight)
    y = y.astype(np.float32)

    plt.title('Height')
    plt.xlabel('measurement date')
    plt.ylabel('weight [kg]')
    plt.plot(x,y)
    plt.savefig(os.path.join(dirpath, "test_#{@user.id}.png"))
    plt.close()

    y = np.array(total)
    y = y.astype(np.float32)

    plt.title('Total Calory')
    plt.xlabel('measurement date')
    plt.ylabel('Calory [kCal]')
    plt.plot(x, y)
    plt.savefig(os.path.join(dirpath, "test_#{@user.id}_1.png"))
    plt.close()

    y = np.array(fat)
    y = y.astype(np.float32)
    
    plt.title('Body Fat Percentage')
    plt.xlabel('measurement date')
    plt.ylabel('Body Fat [%]')
    plt.plot(x, y)
    plt.savefig(os.path.join(dirpath, "test_#{@user.id}_2.png"))
    plt.close()

    y = np.array(bmi)
    y = y.astype(np.float32)

    plt.title('Body Mass Index')
    plt.xlabel('measurement date')
    plt.ylabel('BMI [-]')
    plt.plot(x, y)
    plt.savefig(os.path.join(dirpath, "test_#{@user.id}_3.png"))
    plt.close()
  end

  def reset_cache
    os = PyCall.import_module('os')
    @user = User.find(current_user.id)

    if Rails.env.development?
      dirpath = "public/assets/"
    elsif Rails.env.production?
      dirpath = os.getcwd()
      dirpath += "/public/assets/"
    end

    return if File.exist?(os.path.join(dirpath, "test_#{@user.id}.png")) == false
    os.remove(os.path.join(dirpath, "test_#{@user.id}.png"))
    os.remove(os.path.join(dirpath, "test_#{@user.id}_1.png"))
    os.remove(os.path.join(dirpath, "test_#{@user.id}_2.png"))
    os.remove(os.path.join(dirpath, "test_#{@user.id}_3.png"))
  end
end
