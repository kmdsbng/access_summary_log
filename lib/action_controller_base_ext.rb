# -*- encoding: utf-8 -*-
require 'set'

class ActionController::Base
  around_filter :output_access_summary_log

  private

  def prepare_access_summary_logger
    log_path = Rails.root + 'log/access_summary.log'
    @__access_summary_logger ||= Logger.new(log_path)
  end

  def access_summary_log_ignore_paths
    Set[]
  end

  def output_access_summary_log
    prepare_access_summary_logger
    output_access_summary_log_before

    yield

    output_access_summary_log_complete
  rescue Exception => x
    output_access_summary_log_exception
    raise x
  end

  def output_access_summary_log_before
    return unless @__access_summary_logger
    if access_summary_log_ignore_paths.include? request.path
      @__access_summary_logger.info "... (#{request.method} \"#{request.path}\" #{Time.now.strftime('%H:%S:%S')})"
    else
      @__access_summary_logger.info ">>> Started #{request.method} \"#{request.path}\" #{Time.now}".green
      @__access_summary_logger.info params.pretty_inspect
      @__access_summary_logger_start_time = Time.now
    end
  end

  def output_access_summary_log_complete
    return if !@__access_summary_logger || access_summary_log_ignore_paths.include?(request.path)
    status_str = "#{response.status} #{response.status_message}"
    if 200 <= response.status && response.status < 400
      status_str = status_str.green
    else
      status_str = status_str.red
    end
    @__access_summary_logger.info "Complete: " + status_str + " (#{((Time.now - @__access_summary_logger_start_time) * 1000).to_i}msec)\n"
  end

  def output_access_summary_log_exception
    return unless @__access_summary_logger
    rails_root_path_regex = /^#{Rails.root}(\/)?/
    @__access_summary_logger.error "Exception raised: " + x.message.red + " (#{((Time.now - @__access_summary_logger_start_time) * 1000).to_i}msec)"
    backtrace_ary = x.backtrace.first(20).map {|l|
      case l
      when rails_root_path_regex; l.gsub(rails_root_path_regex, '').cyan
      else                        l
      end
    }
    @__access_summary_logger.error "  " + backtrace_ary.join("\n  ") + "\n"
  end

end


