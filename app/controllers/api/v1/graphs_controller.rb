class Api::V1::GraphsController < ApplicationController
  before_action :authenticate_request!

  # HACK: pycallがメインスレッドのみ対応しているため、open3を使用してサブプロセスで実行
  require 'open3'
  # python コマンドを実行
  require 'pycall/import'
  include PyCall::Import
  # require 'numpy'

  def index
    # Matplotlib.use('Agg')
    # plt = Matplotlib::Pyplot
    # @npy = Numpy
    # set_cache_buster
    calculate_parameter
    # reset_cache(load_os)
    # set_graph
    render json: { status: 'SUCCESS', message: 'Loaded Path', data: { imagePath: check_image_path(load_os("cwd")) } }
  end

  private

  def calculate_parameter
    @user = User.find(current_user.id)
    @result = Log.where(user_id: current_user.id).includes(:user).order(date: 'ASC')
    @height = User.find(current_user.id).height
    @date = []
    @weight = []
    @total = []
    @fat = []
    @bmi = []
    binding.pry
    @result.each do |w|
      w.weight.nil? || w.total_cal.nil? || w.bfp.nil? and next
      @date << w.date.strftime("%m/%d").to_s
      @weight << w.weight.to_s
      @total << w.total_cal.to_s
      @fat << w.bfp.to_s
      @bmi << (w.weight / ((@height / 100)**2)).to_s
    end
  end

  def set_graph(npy, plt, os)
    x = npy.array(@date)
    y = npy.array(@weight)
    y = y.astype(npy.float32)

    plt.title('Height')
    plt.xlabel('measurement date')
    plt.ylabel('weight [kg]')
    plt.plot(x, y)
    plt.savefig(os.path.join(@dirpath, "test_#{@user.id}_1.png"))
    plt.close

    y = npy.array(@total)
    y = y.astype(npy.float32)

    plt.title('Total Calory')
    plt.xlabel('measurement date')
    plt.ylabel('Calory [kCal]')
    plt.plot(x, y)
    plt.savefig(os.path.join(@dirpath, "test_#{@user.id}_2.png"))
    plt.close

    y = npy.array(@fat)
    y = y.astype(npy.float32)

    plt.title('Body Fat Percentage')
    plt.xlabel('measurement date')
    plt.ylabel('Body Fat [%]')
    plt.plot(x, y)
    plt.savefig(os.path.join(@dirpath, "test_#{@user.id}_3.png"))
    plt.close

    y = npy.array(@bmi)
    y = y.astype(npy.float32)

    plt.title('Body Mass Index')
    plt.xlabel('measurement date')
    plt.ylabel('BMI [-]')
    plt.plot(x, y)
    plt.savefig(os.path.join(@dirpath, "test_#{@user.id}_4.png"))
    plt.close
  end

  def reset_cache(os)
    return unless File.exist?(os.path.join(@dirpath, "test_#{@user.id}_1.png"))

    os.remove(os.path.join(dirpath, "test_#{@user.id}_1.png"))
    os.remove(os.path.join(dirpath, "test_#{@user.id}_2.png"))
    os.remove(os.path.join(dirpath, "test_#{@user.id}_3.png"))
    os.remove(os.path.join(dirpath, "test_#{@user.id}_4.png"))
  end

  def set_cache_buster
    response.set_header("Cache-Control", "no-store, max-age=0")
    response.set_header("Pragma", "no-store, max-age=0")
  end

  def check_image_path(path)
    file1 = File.exist?(path + "test_#{@user.id}_1.png")
    file2 = File.exist?(path + "test_#{@user.id}_2.png")
    file3 = File.exist?(path + "test_#{@user.id}_3.png")
    file4 = File.exist?(path + "test_#{@user.id}_4.png")

    if file1 && file2 && file3 && file4
      true
    else
      false
    end
  end

  def load_os(arg)
    command = 'python3 ./lib/assets/python/loadOs.py '
    command += arg
    stdout, stderr, status = Open3.capture3(command)
    if status.success?
      stdout
    else
      puts "Error: #{stderr}"
    end
  end
end
