# deviseのログインメソッド定義
module ControllerMacros
  def login(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end
end

# rails_helper.rb(RSpec.configure do |config|から下)に、以下記述をコピペ
# すると、このファイルと合わせて、deviseをrspecで使用する準備完了
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
# config.include Devise::Test::ControllerHelpers, type: :controller
# config.include ControllerMacros, type: :controller