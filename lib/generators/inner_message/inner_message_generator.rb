class InnerMessageGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  def copy_initializer_file
    copy_file "inner_message.rb", "config/initializers/inner_message.rb"
  end
end
