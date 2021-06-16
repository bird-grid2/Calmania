class Api::V1::GraphsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: :index
  before_action :reset_cache, only: :index
  before_action :set_graph, only: :index

  def index
    render json: { status: 'SUCCESS', data: @user }
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

    result = Log.where(user_id: current_user.id).includes(:user).order(date: 'ASC')
    height = User.find(current_user.id).height
    date = []
    weight = []
    total = []
    fat = []
    bmi = []
    dirpath = "#{os.getcwd()}/public/assets"

    result.each do |w|
      w.weight.nil? || w.total_cal.nil? || w.bfp.nil? and next
      date << w.date.strftime("%m/%d").to_s
      weight << w.weight.to_s
      total << w.total_cal.to_s
      fat << w.bfp.to_s
      bmi << (w.weight / ((height / 100)**2)).to_s
    end

    x = np.array(date)
    y = np.array(weight)
    y = y.astype(np.float32)

    plt.title('Height')
    plt.xlabel('measurement date')
    plt.ylabel('weight [kg]')
    plt.plot(x, y)
    plt.savefig(os.path.join(dirpath, "test_#{@user.id}_1.png"))
    plt.close()

    y = np.array(total)
    y = y.astype(np.float32)

    plt.title('Total Calory')
    plt.xlabel('measurement date')
    plt.ylabel('Calory [kCal]')
    plt.plot(x, y)
    plt.savefig(os.path.join(dirpath, "test_#{@user.id}_2.png"))
    plt.close(_)

    y = np.array(fat)
    y = y.astype(np.float32)

    plt.title('Body Fat Percentage')
    plt.xlabel('measurement date')
    plt.ylabel('Body Fat [%]')
    plt.plot(x, y)
    plt.savefig(os.path.join(dirpath, "test_#{@user.id}_3.png"))
    plt.close()

    y = np.array(bmi)
    y = y.astype(np.float32)

    plt.title('Body Mass Index')
    plt.xlabel('measurement date')
    plt.ylabel('BMI [-]')
    plt.plot(x, y)
    plt.savefig(os.path.join(dirpath, "test_#{@user.id}_4.png"))
    plt.close()
  end

  def reset_cache
    os = PyCall.import_module('os')
    dirpath = "#{os.getcwd()}/public/assets"

    return unless File.exist?(os.path.join(dirpath, "test_#{@user.id}_1.png"))

    os.remove(os.path.join(dirpath, "test_#{@user.id}_1.png"))
    os.remove(os.path.join(dirpath, "test_#{@user.id}_2.png"))
    os.remove(os.path.join(dirpath, "test_#{@user.id}_3.png"))
    os.remove(os.path.join(dirpath, "test_#{@user.id}_4.png"))
  end
end
