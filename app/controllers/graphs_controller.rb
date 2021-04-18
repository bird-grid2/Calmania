class GraphsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: :index
  before_action :reset_cache, only: :index
  before_action :set_graph, only: :index

  def index
    expires_now
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def set_graph
    matplotlib = Matplotlib
    matplotlib.use('Agg')
    plt = matplotlib::Pyplot
    np = Numpy
    os = PyCall.import_module('os')
    
    if Rails.env.development?
      dirpath = "app/assets/images/" 
    elsif Rails.env.production?
      dirpath = os.getcwd()
      dirpath += "/public/assets"
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

    2.times do 
      x = np.array(date)
      y = np.array(weight)
      y = y.astype(np.float32)

      plt.title('Height')
      plt.xlabel('measurement date')
      plt.ylabel('weight [kg]')
      plt.plot(x,y)
      plt.savefig(os.path.join(dirpath, "test_#{@user.id}_2.png"))
      plt.close()

      y = np.array(total)
      y = y.astype(np.float32)

      plt.title('Total Calory')
      plt.xlabel('measurement date')
      plt.ylabel('Calory [kCal]')
      plt.plot(x, y)
      plt.savefig(os.path.join(dirpath, "test_#{@user.id}_4.png"))
      plt.close()

      y = np.array(fat)
      y = y.astype(np.float32)
      
      plt.title('Body Fat Percentage')
      plt.xlabel('measurement date')
      plt.ylabel('Body Fat [%]')
      plt.plot(x, y)
      plt.savefig(os.path.join(dirpath, "test_#{@user.id}_6.png"))
      plt.close()

      y = np.array(bmi)
      y = y.astype(np.float32)

      plt.title('Body Mass Index')
      plt.xlabel('measurement date')
      plt.ylabel('BMI [-]')
      plt.plot(x, y)
      plt.savefig(os.path.join(dirpath, "test_#{@user.id}_8.png"))
      plt.close()
    end
  end

  def reset_cache
    os = PyCall.import_module('os')

    return unless File.exist?(helpers.asset_url("/assets/test_#{@user.id}_2.png"))

    os.remove(helpers.asset_url("/assets/test_#{@user.id}_2.png"))
    os.remove(helpers.asset_url("/assets/test_#{@user.id}_4.png"))
    os.remove(helpers.asset_url("/assets/test_#{@user.id}_6.png"))
    os.remove(helpers.asset_url("/assets/test_#{@user.id}_8.png"))
  end
end
