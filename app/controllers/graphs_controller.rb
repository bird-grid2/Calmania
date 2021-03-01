class GraphsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    require 'pycall'
    require 'numpy'
    require 'matplotlib'

    matplotlib = Matplotlib
    matplotlib.use('Agg')
    plt = Matplotlib.pyplot
    np = Numpy
    os = PyCall.import_module('os')

    if Rails.env.development?
      dirpath = 'app/assets/images/'
    elsif Rails.env.production?
      dirpath = '/var/www/Calmania/current/app/assets/images/'
    end
    
    result = Log.where(user_id: current_user.id).includes(:user).order(date: 'ASC')
    height = User.find(current_user.id).height

    date = []
    weight = []
    total = []
    fat = []
    bmi = []

    result.each do |w|
      date << w.date.to_s
      weight << w.weight.to_f
      total << w.total_cal.to_i
      fat << w.bfp.to_f
      bmi << (w.weight / ((height / 100) ** 2)).to_f
    end

    x = np.array(date)
    y = np.array(weight)

    plt.title('Height')
    plt.xlabel('measurement date')
    plt.ylabel('weight [kg]')
    plt.plot(x,y)
    plt.savefig(os.path.join(dirpath, "test.png"))
    plt.close()

    y = np.array(total)

    plt.title('Total Calory')
    plt.xlabel('measurement date')
    plt.ylabel('Calory [kCal]')
    plt.plot(x, y)
    plt.savefig(os.path.join(dirpath, "test_1.png"))
    plt.close()

    y = np.array(fat)
    
    plt.title('Body Fat Percentage')
    plt.xlabel('measurement date')
    plt.ylabel('Body Fat [%]')
    plt.plot(x, y)
    plt.savefig(os.path.join(dirpath, "test_2.png"))
    plt.close()

    y = np.array(bmi)

    plt.title('Body Mass Index')
    plt.xlabel('measurement date')
    plt.ylabel('BMI [-]')
    plt.plot(x, y)
    plt.savefig(os.path.join(dirpath, "test_3.png"))
    plt.close()
  end

end
