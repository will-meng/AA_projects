require 'active_support'
require 'active_support/inflector'
require 'active_support/core_ext'
require 'erb'
require_relative './session'
require_relative './flash'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req = req
    @res = res
    @params = req.params.merge(route_params)
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  # Set the response status code and header
  def redirect_to(url)
    raise "Content cannot be rendered more than once" if already_built_response?
    @res.redirect(url)
    session.store_session(@res)
    flash.store_flash(@res)
    @already_built_response = true
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise "Content cannot be rendered more than once" if already_built_response?
    res['Content-Type'] = content_type
    res.write(content)
    session.store_session(@res)
    flash.store_flash(@res)
    @already_built_response = true
  end

  # use ERB and binding to evaluate templates
  # pass the rendered html to render_content
  def render(template_name)
    path = "views/#{self.class.to_s.underscore}/#{template_name}.html.erb"
    raw_content = File.read(path)
    content = ERB.new(raw_content).result(binding)
    render_content(content, 'text/html')
  end

  # method exposing a `Session` object
  def session
    @session ||= Session.new(req)
  end

  def flash
    @flash ||= Flash.new(req)
  end

  # use this with the router to call action_name (:index, :show, :create...)
  def invoke_action(name)
    self.send(name)
    render(name) unless already_built_response?
  end
end
