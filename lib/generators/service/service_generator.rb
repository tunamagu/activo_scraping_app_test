class ServiceGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  # パラメータを定義
  argument :name

  # サービスクラスを作成する
  def create_service_file
    destination = Rails.root.join("app/services/#{name.underscore}_service.rb")
    template('service.rb.erb', destination)
  end

  # サービスクラスのテストクラスを作成する
  def create_test_file
    destination = Rails.root.join("test/services/#{name.underscore}_service_test.rb")
    template('test.rb.erb', destination)
  end
end
